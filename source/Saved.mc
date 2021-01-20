using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Timer;
using Toybox.Application as App;

class SavedView extends WatchUi.View {
    var Storage = App.Storage;
    var timer = new Timer.Timer();

    function initialize() {
        View.initialize();
    }
    
    function timerCallback() {
        timer.stop();

        var menu = new WatchUi.Menu();
        menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Select), :Select);
        menu.addItem(WatchUi.loadResource(Rez.Strings.Timer_Menu_Edit), :Edit);
        menu.setTitle(App.getApp().getProperty("timer_"+Storage.getValue("setupTimer")+"_name"));
        WatchUi.switchToView(menu, new TimerMenuDelegate(), WatchUi.SLIDE_UP);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        timer.start(method(:timerCallback), 500, true);
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
        var y = dc.getHeight()/2;
        var text = WatchUi.loadResource(Rez.Strings.Timer_Saved);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x, y, Graphics.FONT_LARGE, text, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}
