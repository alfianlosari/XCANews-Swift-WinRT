import Foundation
import UWP
import WinAppSDK
import WindowsFoundation
import WinUI
@_spi(WinRTImplements) import WindowsFoundation

class MainWindow: Window {

    let categories = Category.allCases
    let api = NewsAPI.shared
    var fetchPhase = DataFetchPhase<[Article]>.fetching {
        didSet { fetchPhaseDidChange(fetchPhase) }
    }

    lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.paneTitle = "XCA News - Swift WinRT"
        navigationView.paneDisplayMode = .left
        navigationView.isSettingsVisible = false
        navigationView.openPaneLength = 220
        navigationView.isBackButtonVisible = .collapsed

        self.categories.forEach { c in
            let navigationViewItem = NavigationViewItem()
            navigationViewItem.tag = Uri("xca://\(c.rawValue)")
            let icon = FontIcon()
            icon.glyph = c.glyph
            navigationViewItem.content = c.text
            navigationViewItem.icon = icon
            navigationView.menuItems.append(navigationViewItem)
        }
        navigationView.header = self.categories[0].text
        navigationView.selectedItem = navigationView.menuItems[0]
        navigationView.selectionChanged.addHandler { [weak self] (_, _) in
            self?.handleRefresh()
        }  
        navigationView.content = self.rootCanvas
        return navigationView
    }()

    lazy var rootCanvas: Canvas = {
        let canvas = Canvas()
        canvas.horizontalAlignment = .stretch
        canvas.verticalAlignment = .stretch
        canvas.margin = Thickness(left: 0, top: 0, right: 0, bottom: 0)
        canvas.children.append(self.refreshContainer)
        canvas.children.append(self.overlayStackPanel)
        canvas.sizeChanged.addHandler { [weak self] (_, args) in
            guard let self, let args else { return }
            let newWidth = Double(args.newSize.width)
            let newHeight = Double(args.newSize.height)
            self.refreshContainer.width = newWidth
            self.refreshContainer.height = newHeight
            self.setOverlayStackPanelPosition(width: newWidth, height: newHeight)
        }
        return canvas
    }()

    lazy var refreshContainer: RefreshContainer = {
        let refreshContainer = RefreshContainer()
        refreshContainer.content = gridView
        refreshContainer.refreshRequested.addHandler { [weak self] _, _ in
            self?.handleRefresh()
        }
        return refreshContainer
    }()

    lazy var refreshButton: Button = {
        let button = Button()
        button.horizontalAlignment = .center
        button.style = Application.current.resources["AccentButtonStyle"] as! Style
        button.content = "Refresh"
        button.click.addHandler { [weak self] _, _ in
            self?.handleRefresh()
        }
        return button
    }()
   
    lazy var overlayStackPanel: StackPanel = {
        let stackPanel = StackPanel()
        stackPanel.horizontalAlignment = .stretch
        stackPanel.verticalAlignment = .stretch
        stackPanel.width = 280
        stackPanel.spacing = 16
        stackPanel.children.append(self.overlayTextBlock)
        stackPanel.children.append(self.overlayProgressRing)
        stackPanel.children.append(self.refreshButton)
        return stackPanel
    }()
   
    let overlayTextBlock: TextBlock = {
        let textBlock = TextBlock()
        textBlock.textWrapping = .wrap
        textBlock.textAlignment = .center
        textBlock.textTrimming = .wordEllipsis
        textBlock.fontSize = 16
        textBlock.fontWeight = FontWeights.semiBold
        textBlock.maxHeight = 100
        textBlock.horizontalAlignment = .center
        return textBlock
    }()

    let overlayProgressRing: ProgressRing = {
        let progressRing = ProgressRing()
        progressRing.visibility = .collapsed
        progressRing.isActive = false
        return progressRing
    }()

    lazy var gridView: GridView = {
        let gridView = GridView()
        gridView.margin = Thickness(left: 24, top: 16, right: 24, bottom: 0)
        let itemsPanelTemplate = XamlReader.load("""
        <ItemsPanelTemplate
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">
            <ItemsWrapGrid x:Name="MaxItemsWrapGrid"
                           ItemWidth="350"
                           ItemHeight="380"    
                           Orientation="Horizontal"/>
        </ItemsPanelTemplate>
        """) as! ItemsPanelTemplate
        gridView.itemsPanel = itemsPanelTemplate
        gridView.isItemClickEnabled = true
        gridView.itemClick.addHandler { [weak self] (_, args) in
            guard
                let panel = args?.clickedItem as? StackPanel,
                let uri = panel.tag as? Uri
            else { return }
            _ = try? Process.run(URL(fileURLWithPath: "C://Program Files (x86)/Microsoft/Edge/Application/msedge.exe"), arguments: [uri.rawUri])
        }

        gridView.sizeChanged.addHandler { [weak self] (_, args) in
            guard
                let self,
                let args,
                let itemsWrapGrid = self.gridView.itemsPanelRoot as? ItemsWrapGrid
            else { return }
            let columns = Double(ceil(args.newSize.width / 350.0))
            itemsWrapGrid.itemWidth = Double(args.newSize.width) / columns
        }
        return gridView
    }()

    override init() {
        super.init()
        self.setupWindow()
        self.fetchArticles(category: categories[0])
    }

    func setupWindow() {
        self.title = "XCA News"
        self.content = navigationView
        self.extendsContentIntoTitleBar = true

        let micaBackdrop = MicaBackdrop()
        micaBackdrop.kind = .base
        self.systemBackdrop = micaBackdrop
    }

    func fetchPhaseDidChange(_ fetchPhase: DataFetchPhase<[Article]>) {
        switch fetchPhase {
            case .success(let articles):
                self.showOverlayView(false)
                self.overlayTextBlock.text = ""
                self.setOverlayProgressRing(isLoading: false)
                self.gridView.items.clear()
                articles.forEach { 
                    self.gridView.items.append(ArticleGridViewItem(article: $0)) 
                }

            case .failure(let error):
                self.showOverlayView(true)
                self.overlayTextBlock.text = error.localizedDescription
                self.setOverlayProgressRing(isLoading: false)

            case .fetching:
                self.showOverlayView(true)
                self.overlayTextBlock.text = ""
                self.setOverlayProgressRing(isLoading: true)

            case .empty:
                self.showOverlayView(true)
                self.overlayTextBlock.text = "There are no articles. Please check again later."
                self.setOverlayProgressRing(isLoading: false)

            default: break
        }
    }

    func showOverlayView(_ show: Bool) {
        overlayStackPanel.visibility = show ? .visible : .collapsed
        refreshContainer.visibility = show ? .collapsed : .visible
    }

    func setOverlayProgressRing(isLoading: Bool) {
        overlayProgressRing.isActive = isLoading ? true : false
        overlayProgressRing.visibility = isLoading ? .visible : .collapsed
        refreshButton.visibility = isLoading ? .collapsed : .visible
    }

    func handleRefresh() {
        guard
            let item = self.navigationView.selectedItem as? NavigationViewItem,
            let tag = (item.tag as? Uri)?.host,
            let category = Category(rawValue: tag)
        else { return }
        self.navigationView.header = category.text
        self.fetchArticles(category: category)
    }

    func fetchArticles(category: Category) {
        guard let dispatcherQueue = WinAppSDK.DispatcherQueue.getForCurrentThread() else { return }
        self.fetchPhase = .fetching
        Task {
            do {
                // let articles = Article.stubs
                let articles = try await api.fetch(from: category)
                print(articles)
                 _ = try? dispatcherQueue.tryEnqueue { [weak self] in
                    if articles.isEmpty {
                        self?.fetchPhase = .empty
                    } else {
                        self?.fetchPhase = .success(articles)
                    }
                }
            } catch {
                print(error.localizedDescription)
                 _ = try? dispatcherQueue.tryEnqueue { [weak self] in
                    self?.fetchPhase = .failure(error)
                }
            }
        }
    }

    func setOverlayStackPanelPosition(width: Double, height: Double) {
        let left = Double(width - self.overlayStackPanel.actualWidth) / 2
        let top = Double(height - self.overlayStackPanel.actualHeight) / 2
        Canvas.setLeft(self.overlayStackPanel, left)
        Canvas.setTop(self.overlayStackPanel, top)
    }
}