using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application as App;

class StopDelegate extends WatchUi.MenuInputDelegate {
	var Storage = App.Storage;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
    	if (item == :Pause) {
			WatchUi.pushView(new TimerView(), new TimerDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :Reset) {
			WatchUi.pushView(new TimerView(), new TimerDelegate(), WatchUi.SLIDE_UP);
            Storage.setValue("count", 0);
        }
    }
}
