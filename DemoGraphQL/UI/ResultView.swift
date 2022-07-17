//
//  ResultView.swift
//  DemoGraphQL
//
//  Created by Yuan on 2022/7/17.
//

import SwiftUI

struct ResultView: View {
    @Binding var detail: String
    
    var body: some View {
        Text(detail)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(detail: .constant("Nothing to show"))
    }
}
