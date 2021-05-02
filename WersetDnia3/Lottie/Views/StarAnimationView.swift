//
//  StarAnimationView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 01/05/2021.
//

import SwiftUI
import Lottie

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
        guard let verse = vm.verses?[index] else { return }
        guard isLiked != verse.likedLocally else { return }
        isLiked = verse.likedLocally
        animationView.play(fromFrame: isLiked ? 4 : 36, toFrame: isLiked ? 36 : 4, loopMode: .playOnce, completion: nil)
    //    animationView.play(fromProgress: isLiked ? 0 : 1, toProgress: isLiked ? 1 : 0, loopMode: .playOnce, completion: nil)
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
