package environment.utils {
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;

    public class TxtLoader {
        private static var txtFiles:Object = {};

        public function TxtLoader() {
        }

        public static function loadFile(url:String, callback=null):void {
            var mRequest:URLRequest;
            var mLoader:URLLoader = new URLLoader();
            var self = TxtLoader;

            mRequest = new URLRequest("Dialog/" + url);
            mLoader.dataFormat = URLLoaderDataFormat.TEXT;
            mLoader.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                TxtLoader.txtFiles[url] = String(mLoader.data);
                if ( typeof( callback ) == "function" ) {
                    //callback(TxtLoader.txtFiles[url]);
                }
            });
            mLoader.load(mRequest);
        }

        public static function getTxt(index:*):String {
            return TxtLoader.txtFiles[index];
        }

        private static function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
        }
    }
}
