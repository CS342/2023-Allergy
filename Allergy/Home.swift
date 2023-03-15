//
// This source file is part of the CS342 2023 Allergy Team Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import AllergyContacts
import AllergySchedule
import AllergySharedContext
import SwiftUI


struct HomeView: View {
    enum Tabs: String {
        case schedule
        case contact
        case galleryView
    }
    
    
    @AppStorage(StorageKeys.homeTabSelection) var selectedTab = Tabs.schedule
    @State var cameraPresented = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ScheduleView()
                .tag(Tabs.schedule)
                .tabItem {
                    Label("SCHEDULE_TAB_TITLE", systemImage: "list.clipboard")
                }
            Contacts()
                .tag(Tabs.contact)
                .tabItem {
                    Label("CONTACTS_TAB_TITLE", systemImage: "person.fill")
                }
            GalleryTab()
                .tag(Tabs.galleryView)
                .tabItem {
                    Label("GALLERYVIEW_TAB_TITLE", systemImage: "list.clipboard")
                }
        }
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AllergyScheduler())
    }
}
#endif
