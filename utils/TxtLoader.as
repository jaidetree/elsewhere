package environment.utils {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;

    public class TxtLoader {
        private static var txtFiles:Object = {};

        public function TxtLoader() {
        }

        public static function loadFile(url:String, callback=null):void {
            var mRequest:URLRequest;
            var mLoader:Loader = new Loader();
            var self = TxtLoader;

            mRequest = new URLRequest(url);
            mLoader.load(mRequest);
            mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                TxtLoader.txtFiles[url] = String(loadEvent.currentTarget.content);
                if ( typeof( callback ) == "function" ) {
                    callback(TxtLoader.txtFiles[url]);
                }
            });
        }

        public static function getTxt(index:*):* {
            return TxtLoader.txtFiles[index];
        }

        private static function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
        }
    }
}
