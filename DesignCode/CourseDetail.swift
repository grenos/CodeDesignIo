//
//  CourseDetail.swift
//  DesignCode
//
//  Created by Vasileios  Gkreen on 26/11/20.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

struct CourseDetail: View {
	
	var course: Course
	@Binding var show: Bool
	@Binding var active: Bool
	@Binding var activeIndex: Int
	
	var body: some View {
		ScrollView {
			VStack {
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
						
						Image(systemName: "xmark")
							.font(.system(size: 16, weight: .medium))
							.foregroundColor(.white)
							
							.frame(width: 36, height: 36)
							.background(Color.black)
							.clipShape(Circle())
							.onTapGesture {
								self.show = false
								self.active = false
								self.activeIndex = -1
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
				
				
				VStack(alignment: .leading, spacing: 30.0) {
					Text("Take your SwiftUI App to the AppStore with advannced techniques like API data, packages and CMS")
					
					Text("About this course")
						.font(.title).bold()
					
					Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
					
					Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
					
				}
				.padding(30)
			}
		}
		.edgesIgnoringSafeArea(.all)
	}
}

struct CourseDetail_Previews: PreviewProvider {
	static var previews: some View {
		CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
	}
}
