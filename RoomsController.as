package environment {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;
    import environment.SwfLoader;

    public class RoomsController extends MovieClip {
        private var rooms:Array = [];
        private var swfLoader;

        public function RoomsController() {
            this.swfLoader = new SwfLoader();
        }

        public function setupRooms(roomList:Array) {
            var self = this;
            for( var i in roomList ) {
                var roomName:String = "";
                var room = roomList[i];
                var roomRef:Object;

                roomName = Environment.getClassName(room);
                roomRef = { roomName: roomName.toLowerCase(), controller: room };
                this.rooms.push(roomRef);
                this.swfLoader.addFile(room.get('swf'));
            }

            this.swfLoader.setCallback(function(mc:MovieClip) {
                var url = self.swfLoader.url();
                var roomIndex = self.swfLoader.getFileCount() - 1;
                self.rooms[roomIndex].controller.setMovie(mc);

                if( roomIndex == 0 ) {
                    self.render(0);
                }
            });

            this.swfLoader.load();
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
            Environment.view['roomContainer'].addChild(room.controller.getMovie());
            room.controller.init();
        }
    }
}
