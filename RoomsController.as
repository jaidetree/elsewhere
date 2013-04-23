package  {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import Room;

    public class RoomsController {
        public RoomsController;
        
        public function RoomsController(stage) {
        }

        public function loadRoom() {
            var mLoader:Loader = new Loader(),
                mRequest = new URLRequest("as3_elsewhere.swf");
            
            mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                this.stage.addChild(loadEvent.currentTarget.content);
            });
            
            mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
            
            mLoader.load(mRequest);
        }
        
        private function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
            trace(percent);
        }
    }
}
