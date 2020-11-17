//
//  Home.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 22/09/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct Home: View {
	
	@State var showProfile = false
	@State var viewState = CGSize.zero
	@State var showContent = false
	
    var body: some View {
	
		ZStack {
			Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
				.edgesIgnoringSafeArea(.all)
			
			
			// VISIBLE HOME SCREEN
			HomeView(showProfile: $showProfile, showContent: $showContent)
			.padding(.top, 44)
			.background(
				VStack {
					LinearGradient(
						gradient: Gradient(colors: [Color("background2"), Color.white]),
						startPoint: .top, endPoint: .bottom
					)
					.frame(height: 200)
					Spacer()
				}
				.background(Color.white)
			)
			.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
			.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
			.offset(y: showProfile ? -450 : 0)
			.rotation3DEffect(
				Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0),
				axis: (x: 10, y:0, z:0)
			)
			.scaleEffect(showProfile ? 0.9 : 1)
			.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
			.edgesIgnoringSafeArea(.all)
			
			
			
			
			// HIDDEN MENU
			MenuView()
				.background(Color.black.opacity(0.001))
				.offset(y: showProfile ? 0 : SCREEN_SIZE.height)
				.offset(y: viewState.height)
				.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
				.onTapGesture{
					self.showProfile.toggle()
				}
				.gesture(
					DragGesture().onChanged { value in
						self.viewState = value.translation
						
						if value.translation.height < -200 {
							self.viewState = .zero
						}
					}
					.onEnded { value in
						if self.viewState.height > 50 {
							self.showProfile = false
						}
						self.viewState = .zero
					}
				)
				
			
			/*
				This looks shit but it's the only way to get transition
				on a view that gets mounted with a boolean. It can't be an if else
				that hides one view and shoes the other
			*/
			if showContent {
				Color.white.edgesIgnoringSafeArea(.all)
				ContentView()
					.transition(.move(edge: .trailing))
					.animation(.spring())
				
				VStack {
					HStack {
						Spacer()
						Image(systemName: "xmark")
							.frame(width: 36, height: 36)
							.foregroundColor(.white)
							.background(Color.black)
							.clipShape(Circle())
					}
					Spacer()
				}
				.offset(x: -16, y: 16)
				.transition(.move(edge: .top))
				.animation(.spring())
				.onTapGesture {
					self.showContent = false
				}
			}
			
		}
		
		
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct AvatarView: View {
	
	@Binding var showProfile: Bool
	
	var body: some View {
		Button(action: {self.showProfile.toggle()}) {
			Image("Avatar")
				.renderingMode(.original)
				.resizable()
				.frame(width: 36, height: 36)
				.clipShape(Circle())
		}
	}
}


let SCREEN_SIZE = UIScreen.main.bounds
