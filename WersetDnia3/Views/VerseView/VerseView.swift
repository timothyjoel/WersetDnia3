//
//  VerseView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI
import Combine

struct VerseView: View {
     
    @ObservedObject var vm = VerseViewModel()
    @State var showSettings: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                VerseImageBackground(vm: vm)
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    VerseStatisticsView(vm: vm)
                    VerseSection(vm: vm)
                    Spacer()
                    BottomButtons(vm: vm)
                }
                .frame(width: UIScreen.width)
                NavigationLink(destination: LikedVersesView(), isActive: $showSettings) { }
            }
            .onAppear(perform: {
                vm.observeVerse()
            })
            .navigationBarTitleDisplayMode(.large)
            .navigationBarTitle(Text("Werset dnia"))
            .navigationBarItems(leading:
                                    Button(action: {
                                        vm.showToday()
                                    }, label: {
                                        Text("Dzisiaj")
                                        .foregroundColor(Color.customLabel)
                                            .font(.boldedText)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.leading)
                                    })
                , trailing:
                    
                    Menu {
                        Button(action: {
                            print("TappedButton2")
                            showSettings = true
                        }, label: {
                            HStack {
                                Image(icon: .star)
                                Text("Ulubione wersety")
                            }
                        })
                        
                        Button(action: {
                            print("Ciekawostki")
                        }, label: {
                            HStack {
                                Text("Ciekawostki")
                                Image(icon: .lightBulb)
                            }
                        })
                        
                        Button(action: {
                            print("Settings tapped")
                            showSettings = true
                        }, label: {
                            HStack {
                                Text("Ustawienia")
                                Image(icon: .settings)
                            }
                        })
                        
                    } label: {
                        Image(image: .menu)
                            .rotationEffect(.degrees(180), anchor: .center)
                            .rotation3DEffect(.degrees(180), axis: (x: 1.0, y: 0.0, z: 0.0))
                    }
                    
                    )
//                    Button(action: {
//                        print("tapped")
//                    }, label: {
//                        Image(image: .menu)
//                            .rotationEffect(.degrees(180), anchor: .center)
//                            .rotation3DEffect(.degrees(180), axis: (x: 1.0, y: 0.0, z: 0.0))
//                    }))
        }
               
    }
    
}

struct VerseView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VerseView().preferredColorScheme($0)
        }
    }
}

struct VerseStatisticsView: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        
        HStack (alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Image(icon: .star)
                .foregroundColor(Color.customLabel)
            Text("\(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].likes?.count ?? 0)")
                .foregroundColor(Color.customLabel)
            Image(icon: .message)
                .foregroundColor(Color.customLabel)
            Text("\(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].comments?.count ?? 0)")
                .foregroundColor(Color.customLabel)
            Spacer()
        })
        .padding(.horizontal)
        
    }
}

struct VerseImageBackground: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        VStack (spacing: 0) {
            Spacer()
            VStack (spacing: 0) {
                Image(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].image)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.width*2, height: UIScreen.height*0.65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.main1)
                    .offset(x: UIScreen.width/4, y: 20)
            }
        }
    }
}

struct VerseSection: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        VStack (spacing: 8) {
            Text(vm.date.string)
                .foregroundColor(.customLabel)
                .font(.header2)
                .multilineTextAlignment(.center)
                .transition(.opacity)
            Text(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].path)
                .foregroundColor(.customLabel)
                .font(.header2)
                .multilineTextAlignment(.center)
                .transition(.opacity)
            Text(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].text)
                .foregroundColor(.customLabel)
                .font(.header3Regular)
                .multilineTextAlignment(.center)
                .transition(.opacity)
        }
        .padding(.horizontal)
    }
}

struct BottomButtons: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        HStack (alignment: .center) {
            Button(action: {
                vm.show(.backward)
            }, label: {
                Image(image: .leftArrow)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.customSectionTitle)
                    .frame(width: 60, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            Spacer()
            Button(action: {
                vm.tapStar()
            }, label: {
                StarAnimationView(vm: vm, animation: .star)
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            Spacer()
            Button(action: {
                vm.show(.forward)
            }, label: {
                Image(image: .rightArrow)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.main1)
                    .frame(width: 60, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            })
        }
        .padding(.horizontal)
    }
}
