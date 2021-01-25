using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;
using Toybox.Application as App;

class ChangeDelegate extends WatchUi.BehaviorDelegate {
    var Storage = App.Storage;
    var pos = 1;
    
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        if (pos == 3) {
               var h = Storage.getValue("changeTime")[0];
               var min = Storage.getValue("changeTime")[1];
               var sec = Storage.getValue("changeTime")[2];
               App.getApp().setProperty("timer_"+Storage.getValue("setupTimer")+"_time", h*60*60+min*60+sec);
            WatchUi.switchToView(new SavedView(), new WatchUi.BehaviorDelegate(), WatchUi.SLIDE_UP);
        } else {
            pos++;
            Storage.setValue("changeTime_pos", pos);
            requestUpdate();
        }
    }
    
    function onPreviousPage() {
           var h = Storage.getValue("changeTime")[0];
           var min = Storage.getValue("changeTime")[1];
           var sec = Storage.getValue("changeTime")[2];
           if (pos == 1) {
               h = h==0 ? 23 : h-1;
           } else if (pos == 2) {
               min = min==0 ? 59 : min-1;
           } else if (pos == 3) {
               sec = sec==0 ? 59 : sec-1;
           }
           Storage.setValue("changeTime", [h, min, sec]);
           WatchUi.requestUpdate();
    }

    function onNextPage() {
           var h = Storage.getValue("changeTime")[0];
           var min = Storage.getValue("changeTime")[1];
           var sec = Storage.getValue("changeTime")[2];
           if (pos == 1) {
               h = h==23 ? 0 : h+1;
           } else if (pos == 2) {
               min = min==59 ? 0 : min+1;
           } else if (pos == 3) {
               sec = sec==59 ? 0 : sec+1;
           }
           Storage.setValue("changeTime", [h, min, sec]);
           WatchUi.requestUpdate();
    }
}
