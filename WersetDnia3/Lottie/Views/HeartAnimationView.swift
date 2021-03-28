//
//  LottieView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import SwiftUI
import Lottie

protocol LottieAnimationProtocol {
    
    var animation: LottieAnimation { get set }
    var animationView: AnimationView { get set }
    
}

struct HeartAnimationView: UIViewRepresentable, LottieAnimationProtocol {
    
    @ObservedObject var vm: VerseViewModel
    var isLiked: Bool = false
    var animation: LottieAnimation
    var animationView = AnimationView()

    func makeUIView(context: UIViewRepresentableContext<HeartAnimationView>) -> UIView {
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
        guard let verse = vm.verses?[index] else { return }
        guard isLiked != verse.likedLocally else { return }
        isLiked = verse.likedLocally
        animationView.play(fromProgress: isLiked ? 0 : 38, toProgress: isLiked ? 38 : 0, loopMode: .playOnce, completion: nil)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<HeartAnimationView>) {
        context.coordinator.parent.animate()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: HeartAnimationView

        init(_ parent: HeartAnimationView) {
            self.parent = parent
        }
    }
    
}
