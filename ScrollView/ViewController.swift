import UIKit

class ScrollView: UIView {
    var contentSize: CGSize = .zero
    override init(frame: CGRect) {
        super.init(frame: frame)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(pan)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let point = gestureRecognizer.translation(in: self)

        var bounds = self.bounds

        let newY = bounds.origin.y - point.y
        let minY = 0 as CGFloat
        let maxY = contentSize.height - bounds.size.height
        bounds.origin.y = max(minY, min(newY, maxY))

        self.bounds = bounds
        gestureRecognizer.setTranslation(.zero, in: self)
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = ScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)

        let red = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
        red.backgroundColor = .red

        let green = UIView(frame: CGRect(x: 40, y: 160, width: 200, height: 300))
        green.backgroundColor = .green

        let yellow = UIView(frame: CGRect(x: 150, y: 800, width: 100, height: 100))
        yellow.backgroundColor = .yellow

        scrollView.addSubview(red)
        scrollView.addSubview(green)
        scrollView.addSubview(yellow)

        view.addSubview(scrollView)
    }
}
