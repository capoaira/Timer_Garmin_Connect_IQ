using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application as App;

class TimerMenuDelegate extends WatchUi.MenuInputDelegate {
    var Storage = App.Storage;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :Select) {
            Storage.setValue("actualTimer",  Storage.getValue("setupTimer"));
            Storage.setValue("count", 0);
            WatchUi.pushView(new TimerView(), new TimerDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :Edit) {
            WatchUi.pushView(new ChangeView(), new ChangeDelegate(), WatchUi.SLIDE_UP);
        }
    }
}
