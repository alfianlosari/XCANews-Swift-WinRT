import Foundation
import UWP
import WinAppSDK
import WindowsFoundation
import WinUI
@_spi(WinRTImplements) import WindowsFoundation

class ArticleGridViewItem: GridViewItem {

    let article: Article

    init(article: Article) {
        self.article = article
        super.init()
        self.setupView()
    }

    func setupView() {
        self.verticalContentAlignment = .top
        self.horizontalContentAlignment = .stretch
        let panel = StackPanel()
        panel.margin = Thickness(left: 16, top: 16, right: 16, bottom: 16);
        panel.orientation = .vertical
        panel.spacing = 8

        let border = Border()
        let cornerRadius = CornerRadius(topLeft: 4, topRight: 4, bottomRight: 4, bottomLeft: 4)
        border.cornerRadius = cornerRadius
        border.background = SolidColorBrush(Colors.lightGray)

        let image = Image()
        if let uri = article.urlToImage {
            let bitmapImage = BitmapImage()
            bitmapImage.uriSource = Uri(uri)
            image.source = bitmapImage
        }
        image.height = 180
        image.stretch = .uniformToFill
        image.horizontalAlignment = .center
        border.child = image
        let title = TextBlock()
        title.textWrapping = .wrap
        title.textTrimming = .wordEllipsis
        title.fontSize = 18
        title.fontWeight = FontWeights.bold
        title.text = article.title
        title.maxHeight = 48
        panel.children.append(border)
        panel.children.append(title)


        if !article.descriptionText.isEmpty {
            let description = TextBlock()
            description.textWrapping = .wrap
            description.textTrimming = .wordEllipsis
            description.fontSize = 14
            description.text = article.descriptionText
            description.maxHeight = 76
            panel.children.append(description)
        }
        
        let caption = TextBlock()
        caption.textWrapping = .wrap
        caption.fontSize = 12
        caption.text = article.captionText
        caption.maxHeight = 16
        panel.children.append(caption)
        panel.tag = Uri(article.url)
        self.content = panel
    }
}