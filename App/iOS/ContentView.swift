//
//  ContentView.swift
//  Staging
//
//  Created by uematsushun on 2021/05/03.
//

import SwiftUI
import Sample1

struct ContentView: View {
  var body: some View {
    Text(SamplePackage().text)
      .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
