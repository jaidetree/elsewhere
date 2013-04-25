package environment {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;

    public class RoomsController extends MovieClip {
        private var rooms:Array = [];

        public function RoomsController() {
        }

        public function setupRooms(roomList:Array) {
            for( var i in roomList ) {
                var roomName:String = "";
                var room = roomList[i];
                var roomRef:Object;

                roomName = Environment.getClassName(room);
                roomRef = { roomName: roomName.toLowerCase(), controller: room, mc: {} };
                this.rooms.push(roomRef);
                this.loadRoom(room.get('swf'), i);
            }

        }

        public function loadRoom(filename:String, roomIndex:Number) {
            var mLoader:Loader = new Loader(),
                mRequest = new URLRequest(filename),
                self = this;
            
            mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(loadEvent:Event){ 
                self.rooms[roomIndex].mc = MovieClip(loadEvent.currentTarget.content);
                self.rooms[roomIndex].controller.setMovie(self.rooms[roomIndex].mc);
                if( roomIndex == 0) {
                    self.onRoomsLoaded();
                }
            });
            
            //mLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
            
            mLoader.load(mRequest);
        }
        
        private function onProgressHandler(mProgress:ProgressEvent) {
            var percent:Number = mProgress.bytesLoaded/mProgress.bytesTotal;
        }

        private function onRoomsLoaded() {
            this.render(0);
        }

        protected function getRoom(roomIndex) {
            if ( typeof(roomIndex) == "number" ) {
                return this.rooms[roomIndex];
            }
            else if ( typeof(roomIndex) == "string" ) {
                return this.getRoomByName(roomIndex);
            }
        }

        protected function getRoomByName(roomIndex) {
            roomIndex = roomIndex.toLowerCase();

            for ( var i = 0; i < this.rooms.length; i++ ) {
                if ( this.rooms[i].roomName == roomIndex ) {
                    return this.rooms[i];
                }
            }

            return false;
        }

        public function render(roomIndex) {
            var room = this.getRoom(roomIndex);
            Environment.view['roomContainer'].removeChildAt(0);
            Environment.view['roomContainer'].addChild(room.mc);
            room.controller.init();
        }
    }
}
