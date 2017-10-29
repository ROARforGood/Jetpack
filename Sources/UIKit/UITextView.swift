import UIKit


extension JetpackExtensions where Base: UITextView {
	
	public var text: Receiver<String?> {
        return jx_makeReceiver { $0.text = $1 }
	}

	public var attributedText: Receiver<NSAttributedString?> {
		return jx_makeReceiver { $0.attributedText = $1 }
	}

    public var textValues: Property<String?> {
        return jx_makeNotificationProperty(key: #function, name: .UITextViewTextDidChange) { $0.text }
    }
    
    public var attributedTextValues: Property<NSAttributedString?> {
        return jx_makeNotificationProperty(key: #function, name: .UITextViewTextDidChange) { $0.attributedText }
    }    
}

