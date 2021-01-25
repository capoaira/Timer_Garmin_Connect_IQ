using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;
using Toybox.Application as App;
using Toybox.Attention;

class TimerDelegate extends WatchUi.BehaviorDelegate {
    var Storage = App.Storage;
    var start = true;
    var timer = new Timer.Timer();
    
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function timerCallback() {
        if (Storage.getValue("count")+1 == App.getApp().getProperty("timer_"+Storage.getValue("actualTimer")+"_time")) {
            timer.stop();
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_ALARM);
            }
            if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(100, 1000),
                    new Attention.VibeProfile(0, 50),
                    new Attention.VibeProfile(100, 1000),
                    new Attention.VibeProfile(0, 50),
                    new Attention.VibeProfile(100, 1000),
                    new Attention.VibeProfile(0, 50),
                    new Attention.VibeProfile(100, 1000)
                ];
                Attention.vibrate(vibeData);
            }
            start = true;
        }
        Storage.setValue("count", Storage.getValue("count")+1);
        WatchUi.requestUpdate();
    }

    function onSelect() {
        if (start) {
            if (Storage.getValue("count") == App.getApp().getProperty("timer_"+Storage.getValue("actualTimer")+"_time")) {
                Storage.setValue("count", -1);
            }
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_START);
            }
            if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(100, 100),
                ];
                Attention.vibrate(vibeData);
            }
            timer.start(method(:timerCallback), 1000, true);
            start = false;
        } else {
            if (Attention has :playTone) {
                Attention.playTone(Attention.TONE_STOP);
            }
            if (Attention has :vibrate) {
                var vibeData =
                [
                    new Attention.VibeProfile(100, 100),
                ];
                Attention.vibrate(vibeData);
            }
            timer.stop();
            start = true;
            var menu = new WatchUi.Menu();
            menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Pause), :Pause);
            menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Reset), :Reset);
            WatchUi.switchToView(menu, new StopDelegate(), WatchUi.SLIDE_UP);
        }
    }
    
    function onMenu() {
           var menu = new WatchUi.Menu();
           menu.setTitle(WatchUi.loadResource(Rez.Strings.Select_timer));
        menu.addItem(App.getApp().getProperty("timer_1_name"), :Timer1);
        menu.addItem(App.getApp().getProperty("timer_2_name"), :Timer2);
        menu.addItem(App.getApp().getProperty("timer_3_name"), :Timer3);
        WatchUi.switchToView(menu, new MenuDelegate(), WatchUi.SLIDE_UP);
    }
}
