package environment {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;

    public class SwfLoader {
        private var mLoader:Loader = new Loader();
        private var mRequest:URLRequest;
        private var fileQ:Array = [];
        private var swfs:Array = [];
        private var swfsIndex:Array = [];
        private var totalFiles:int = 0;
        private var loadedFiles:int = 0;
        private var callback:Function;

        public function SwfLoader() {
            var self = this;
            this.mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                self.addSwf(self.url(), MovieClip(loadEvent.currentTarget.content));
            });
            
        }

        public function setCallback(callback:Function):void {
            this.callback = callback;
        }

        public function addFile(filename:String):void {
            this.fileQ.push(filename);
            this.totalFiles++;
        }

        public function loadFile(filename:String, callback:*=null):void {
            if ( callback !== null ) {
                this.setCallback(callback);
            }

            this.addFile(filename);
            this.load();
        }

        public function getFileCount():int {
            return this.loadedFiles;
        }

        public function url():String {
            return this.mRequest.url;
        }

        public function load():void {
            if ( this.fileQ.length < 1 ) {
                return;
            }

            var self = this,
                url = fileQ[0];

            trace("<<Loading: " + url);
            this.mRequest = new URLRequest(url);
            this.mLoader.load(mRequest);

        }

        public function getClip(index:*):MovieClip {
            var index = this.getIndex(index);

            return this.swfs[index];
        }

        public function getIndex(index:*):* {
            if ( typeof(index) === "number" ) {
                return index;
            }
            else if ( typeof(index) ) {
                return this.swfsIndex.indexOf(index);
            }
        }

        private function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
        }

        private function addSwf(url:String, swf:MovieClip) {
            var urls:Array = url.split('/');
            var filename:String = urls[urls.length - 1].replace(/\..*$/, '');

            trace('>>Loaded: ' + url);

            this.fileQ.shift();
            this.swfs.push(swf);
            this.swfsIndex.push(filename);
            this.loadedFiles++;

            if( this.callback['call'] ) {
                this.callback.call(this, swf);
            }

            this.load();
        }
    }
}
