//
//  StarAnimationView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 01/05/2021.
//

import SwiftUI
import Lottie

protocol LottieAnimationProtocol {
    
    var animation: LottieAnimation { get set }
    var animationView: AnimationView { get set }
    
}

struct StarAnimationView: UIViewRepresentable, LottieAnimationProtocol {
    
    @ObservedObject var vm: VerseViewModel
    var isLiked: Bool = false
    var animation: LottieAnimation
    var animationView = AnimationView()

    func makeUIView(context: UIViewRepresentableContext<StarAnimationView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        animationView.animation = Animation.named(animation.name)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }
    
    private mutating func animate() {
        guard let index = Calendar.current.ordinality(of: .day, in: .year, for: vm.date) else { return }
        let isLiked = vm.verses[index].likes?.contains(where: { $0.id == deviceID }) ?? false
        guard isLiked != self.isLiked else { return }
        self.isLiked = isLiked
        animationView.play(fromFrame: isLiked ? 4 : 36, toFrame: isLiked ? 36 : 4, loopMode: .playOnce, completion: nil)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<StarAnimationView>) {
        context.coordinator.parent.animate()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: StarAnimationView

        init(_ parent: StarAnimationView) {
            self.parent = parent
        }
    }
    
}
