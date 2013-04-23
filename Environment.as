package  {
    import RoomsController;
    public class Environment {
        private stage;
        public RoomsController;
        
        public function Environment(stage) {
            var mLoader:Loader = new Loader(),
                mRequest = new URLRequest("as3_elsewhere.swf");
            this.stage = stage;
            
            mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                this.stage.addChild(loadEvent.currentTarget.content);
            });
            
            mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
            
            mLoader.load(mRequest);
        }
        
        function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
            trace(percent);
        }
    }
}
