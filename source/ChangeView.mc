using Toybox.WatchUi;
using Toybox.Application as App;
using Toybox.Graphics;

class ChangeView extends WatchUi.View {
    var Storage = App.Storage;
    var actualTimer = Storage.getValue("setupTimer");

    function initialize() {
        View.initialize();
        var time = App.getApp().getProperty("timer_"+Storage.getValue("actualTimer")+"_time")-Storage.getValue("count");
        var sec = time%60;
        time -= sec;
        var min = (time/60)%60;
        time -= min;
        var h = (time/60/60)%60;
        Storage.setValue("changeTime", [h, min, sec]);
        Storage.setValue("changeTime_pos", 1);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        var x = dc.getWidth()/2;
        var y = percentInPx(20);
        var text = App.getApp().getProperty("timer_"+actualTimer+"_name");
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER);
        y = percentInPx(50);
        var time = Storage.getValue("changeTime");
        for (var i=0; i<3; i++) {
            time[i] = padLeft(time[i]);
        }
        text = Lang.format("$1$:$2$:$3$", time);
        dc.drawText(x, y, App.getApp().getProperty("font_size"), text, Graphics.TEXT_JUSTIFY_CENTER);
        var textLenght = dc.getTextWidthInPixels(text, App.getApp().getProperty("font_size"));
        var screenWidth = dc.getWidth();
        var padding = (screenWidth-textLenght)/2;
        x = padding + dc.getTextWidthInPixels("00:", App.getApp().getProperty("font_size"))*(Storage.getValue("changeTime_pos")-1);
        
        dc.drawText(x, y+11, App.getApp().getProperty("font_size"), ".....", Graphics.TEXT_JUSTIFY_LEFT);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function percentInPx(percent) {
        return System.getDeviceSettings().screenWidth / 100 * percent;
    }
    
    function padLeft(s) {
        return s.toString().length() == 1 ? "0"+s : s;
    }
}
