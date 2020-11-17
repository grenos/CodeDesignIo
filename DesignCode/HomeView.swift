//
//  HomeView.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 22/09/2020.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct HomeView: View {
	
	@Binding var showProfile: Bool
	@State var showupdate = false
	@Binding var showContent: Bool
	
	
	var body: some View {
		ScrollView {
			VStack {
				HStack {
					Text("Watching")
						.modifier(CustomFontModifier(type: "Bold", size: 28))
					
					Spacer()
					AvatarView(showProfile: $showProfile)
					
					Button(action: {self.showupdate.toggle()}) {
						Image(systemName: "bell")
							.renderingMode(.original)
							.font(.system(size: 16, weight: .medium))
							.frame(width: 36, height: 36)
							.background(Color.white)
							.clipShape(Circle())
							.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
							.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
					}
					.sheet(isPresented: $showupdate) {
						UpdateList()
					}
				}
				.padding(.horizontal)
				.padding(.leading, 14)
				.padding(.top, 30)
				.padding(.bottom, 10)
				
				
				ScrollView(.horizontal, showsIndicators: false) {
					WatchRingsView()
						.padding(.horizontal, 30)
						.padding(.bottom, 30)
						.onTapGesture {
							self.showContent = true
						}
				}
				
				
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 20) {
						ForEach(sectionData) { item in
							GeometryReader { geometry in
								SectionView(section: item)
									.rotation3DEffect(
										Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20),
										axis: (x: 0, y: 10, z: 0)
									)
							}
							.frame(width: 275, height: 275)
						}
					}
					.padding(30)
					.padding(.bottom, 30)
				}
				.offset(y: -30)
				
				
				HStack {
					Text("Courses")
						.font(.title).bold()
					Spacer()
				}
				.padding(.leading, 30)
				.offset(y: -60)
				
				SectionView(section: sectionData[2], width: SCREEN_SIZE.width - 60, height: 267)
					.offset(y: -60)
				
				Spacer()
			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView(showProfile: .constant(false), showContent: .constant(false))
	}
}




struct SectionView: View {
	
	var section: Section
	var width: CGFloat = 275
	var height: CGFloat = 275
	
	var body: some View {
		VStack {
			HStack(alignment: .top) {
				Text(section.title)
					.font(.system(size: 24, weight: .bold))
					.frame(width: 160, alignment: .leading)
					.foregroundColor(.white)
				Spacer()
				Image(section.logo)
			}
			
			Text(section.text.uppercased())
				.frame(maxWidth: .infinity, alignment: .leading)
			
			section.image
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 210)
		}
		.padding(.top, 20)
		.padding(.horizontal, 20)
		.frame(width: width, height: height)
		.background(section.color)
		.cornerRadius(30)
		.shadow(color: section.color.opacity(0.5), radius: 20, x: 0, y: 20)
	}
}




struct Section: Identifiable {
	var id = UUID()
	var title: String
	var text: String
	var logo: String
	var image: Image
	var color: Color
}


let sectionData = [
	Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
	Section(title: "Build a SwiftUI app", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color("card2")),
	Section(title: "Deploy your app on the App Store", text: "18 Sections", logo: "Logo1", image: Image("Card3"), color: Color("card3")),
]



struct WatchRingsView: View {
	var body: some View {
		HStack(spacing: 30) {
			HStack(spacing: 12.0) {
				RingView(color1: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
				VStack(alignment: .leading, spacing: 4) {
					Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
					Text("Watched 10 minutes today").modifier(FontModifier(style: .caption))
				}
				.modifier(FontModifier())
			}
			.padding(8)
			.background(Color.white)
			.cornerRadius(20)
			.modifier(ShadowModifier())
			
			HStack(spacing: 12.0) {
				RingView(color1: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), color2: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), width: 32, height: 32, percent: 72, show: .constant(true))
			}
			.padding(8)
			.background(Color.white)
			.cornerRadius(20)
			.modifier(ShadowModifier())
			
			HStack(spacing: 12.0) {
				RingView(color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 26, show: .constant(true))
			}
			.padding(8)
			.background(Color.white)
			.cornerRadius(20)
			.modifier(ShadowModifier())
		}
	}
}
