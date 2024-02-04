import Foundation
import UWP
import WinAppSDK
import WindowsFoundation
import WinUI
@_spi(WinRTImplements) import WindowsFoundation

public class XCANewsApp: Application {
    lazy var m_window: MainWindow = .init()

    override public init() {
        super.init()

        unhandledException.addHandler { (_, args:UnhandledExceptionEventArgs!) in
            print("Unhandled exception: \(args.message)")
        }
    }

    override public func onLaunched(_ args: WinUI.LaunchActivatedEventArgs?) throws {
        resources.mergedDictionaries.append(XamlControlsResources())
        try m_window.activate()   
    }

    override open func queryInterface(_ iid: IID) -> IUnknownRef? {
        switch iid {
        case __ABI_Microsoft_UI_Xaml_Markup.IXamlMetadataProviderWrapper.IID:
            let ixmp = __ABI_Microsoft_UI_Xaml_Markup.IXamlMetadataProviderWrapper(self)
            return ixmp?.queryInterface(iid)
        default:
            return super.queryInterface(iid)
        }
    }
}
