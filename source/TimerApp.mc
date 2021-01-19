using Toybox.Application as App;

class TimerApp extends App.AppBase {
	var Storage = App.Storage;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	App.Storage.clearValues();
    	if (Storage.getValue("actualTimer") == null) {
    		Storage.setValue("actualTimer", 1);
    		Storage.setValue("count", 0);
    	}
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	Storage.setValue("count", 0);
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new TimerView(), new TimerDelegate() ];
    }

}
