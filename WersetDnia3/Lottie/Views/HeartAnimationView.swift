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
    
    private mutating func like() {
        print("like")
        guard isLiked != vm.isLiked else { return }
        isLiked = vm.isLiked
        animationView.play(fromProgress: 0, toProgress: 38, loopMode: .playOnce, completion: nil)
    }
    
    private mutating func unlike() {
        print("unlike")
        guard isLiked != vm.isLiked else { return }
        isLiked = vm.isLiked
        animationView.play(fromFrame: 38, toFrame: 0, loopMode: .playOnce, completion: nil)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<HeartAnimationView>) {
        vm.isLiked ? context.coordinator.parent.like() : context.coordinator.parent.unlike()
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
