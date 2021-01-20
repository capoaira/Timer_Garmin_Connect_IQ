using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application as App;

class MenuDelegate extends WatchUi.MenuInputDelegate {
    var Storage = App.Storage;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var menu = new WatchUi.Menu();
        menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Select), :Select);
        menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Edit), :Edit);
        if (item == :Timer1) {
            Storage.setValue("setupTimer", 1);
            menu.setTitle(App.getApp().getProperty("timer_1_name"));
            WatchUi.pushView(menu, new TimerMenuDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :Timer2) {
            Storage.setValue("setupTimer", 2);
            menu.setTitle(App.getApp().getProperty("timer_2_name"));
            WatchUi.pushView(menu, new TimerMenuDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :Timer3) {
            Storage.setValue("setupTimer", 3);
            menu.setTitle(App.getApp().getProperty("timer_3_name"));
            WatchUi.pushView(menu, new TimerMenuDelegate(), WatchUi.SLIDE_UP);
        }
    }
}
