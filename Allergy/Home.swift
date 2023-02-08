//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergyContacts
import AllergyMockDataStorageProvider
import AllergySchedule
import AllergySharedContext
import SwiftUI


struct HomeView: View {
    enum Tabs: String {
        case schedule
        case contact
        case mockUpload
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.schedule
    @State var cameraPresented: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Button("Use Camera") {
                    cameraPresented = true
                }
            ScheduleView()
            }
                .tag(Tabs.schedule)
                .tabItem {
                    Label("SCHEDULE_TAB_TITLE", systemImage: "list.clipboard")
                }
                .fullScreenCover(isPresented: $cameraPresented) {
                    VStack {
                        Button("Close Camera") {
                            cameraPresented = false
                        }
                        CameraView()
                    }
                }
            Contacts()
                .tag(Tabs.contact)
                .tabItem {
                    Label("CONTACTS_TAB_TITLE", systemImage: "person.fill")
                }
            MockUploadList()
                .tag(Tabs.mockUpload)
                .tabItem {
                    Label("MOCK_UPLOAD_TAB_TITLE", systemImage: "server.rack")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
