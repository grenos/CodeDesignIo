//
//  CourseList.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 24/11/20.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct CourseList: View {
	
	@State var courses = courseData
	@State var active = false
	@State var activeIndex = -1
	@State var activeView = CGSize.zero
	
	var body: some View {
		
		ZStack {
			Color.black.opacity(Double(activeView.height / 500))
				.animation(.linear)
				.edgesIgnoringSafeArea(.all)
			
			ScrollView {
				VStack(spacing: 30.0) {
					Text("Courses")
						.font(.largeTitle).bold()
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.leading, 30)
						.padding(.top, 30)
						.blur(radius: active ? 20 : 0)
					
					ForEach(courses.indices, id: \.self) { index in
						GeometryReader { geometry in
							CourseView(show: $courses[index].show,
									   course: courses[index],
									   active: $active,
									   index: index,
									   activeIndex: $activeIndex,
									   activeView: $activeView
							)
							.offset(y: courses[index].show ? -geometry.frame(in: .global).minY : 0)
							.opacity(activeIndex != index && self.active ? 0 : 1)
							.scaleEffect(activeIndex != index && self.active ? 0.5 : 1)
							.offset(x: activeIndex != index && self.active ? SCREEN_SIZE.width : 0)
						}
						.frame(height: 280)
						.frame(maxWidth: courses[index].show ? .infinity : SCREEN_SIZE.width - 60)
						.zIndex(courses[index].show ? 1 : 0)
					}
				}
				.frame(width: SCREEN_SIZE.width)
				.animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
			}
			.animation(.linear)
		}
	}
}

struct CourseList_Previews: PreviewProvider {
	static var previews: some View {
		CourseList()
	}
}






struct CourseView: View {
	
	@Binding var show: Bool
	var course: Course
	
	@Binding var active: Bool
	var index: Int
	@Binding var activeIndex: Int
	
	@Binding var activeView: CGSize
	
	var body: some View {
		ZStack(alignment: .top) {
			VStack(alignment: .leading, spacing: 30.0) {
				Text("Take your SwiftUI App to the AppStore with advannced techniques like API data, packages and CMS")
				
				Text("About this course")
					.font(.title).bold()
				
				Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
				
				Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
				
			}
			.padding(30)
			.frame(maxWidth: show ? .infinity : SCREEN_SIZE.width - 60, maxHeight: show ? .infinity : 280, alignment: .top )
			.offset(y: show ? 460 : 0)
			.background(Color.white)
			.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
			.shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 20)
			.opacity(show ? 1 : 0)
			
			VStack {
				HStack(alignment: .top) {
					VStack(alignment: .leading, spacing: 8.0) {
						Text(course.title)
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(.white)
						Text(course.subtitle)
							.foregroundColor(.white).opacity(0.7)
					}
					Spacer()
					ZStack {
						Image(uiImage: course.logo)
							.opacity(show ? 0 : 1)
						
						VStack {
							Image(systemName: "xmark")
								.font(.system(size: 16, weight: .medium))
								.foregroundColor(.white)
						}
						.frame(width: 36, height: 36)
						.background(Color.black)
						.clipShape(Circle())
						.opacity(show ? 1 : 0)
					}
				}
				Spacer()
				Image(uiImage: course.image)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(maxWidth: .infinity)
					.frame(height: 140, alignment: .top)
			}
			.padding(show ? 30 : 20)
			.padding(.top, show ? 30 : 0)
			//		.frame(width: show ? SCREEN_SIZE.width : SCREEN_SIZE.width - 60, height: show ? SCREEN_SIZE.height : 280)
			.frame(maxWidth: show ? .infinity : SCREEN_SIZE.width - 60, maxHeight: show ? 460 : 280)
			.background(Color(course.color))
			.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
			.shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
			.gesture(
				show ?
				DragGesture()
					.onChanged({ value in
						guard value.translation.height < 300 else { return }
						guard value.translation.height > 0 else { return }
						self.activeView = value.translation
					})
					.onEnded({ value in
						if self.activeView.height > 50 {
							self.show = false
							self.active = false
							self.activeIndex = -1
						}
						self.activeView = .zero
					})
				: nil
			)
			.onTapGesture {
				self.show.toggle()
				self.active.toggle()
				if self.show {
					self.activeIndex = self.index
				}
				else {
					self.activeIndex = -1
				}
			}
			
			/*
				bad workaround 
			*/
//			if show {
//				CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex)
//					.background(Color.white)
//					.animation(nil)
//			}
			
		}
		.frame(height: show ? SCREEN_SIZE.height : 280)
		.scaleEffect(1 - self.activeView.height / 1000)
		.rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
		.animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0))
		.edgesIgnoringSafeArea(.all)
	}
}


struct Course: Identifiable {
	var id = UUID()
	var title: String
	var subtitle: String
	var image: UIImage
	var logo: UIImage
	var color: UIColor
	var show: Bool
}


var courseData = [
	Course(title: "Prototype design in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), show: false),
	Course(title: "SwiftUI Advance", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card6"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
	Course(title: "UI Design for developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), show: false)
]
