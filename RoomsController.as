package environment {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.display.MovieClip;
    import environment.utils.SwfLoader;

    public class RoomsController extends MovieClip {
        private var rooms:Array = [];
        private var swfLoader;
        private var currentRoom;

        public function RoomsController() {
            this.swfLoader = new SwfLoader();
        }

        public function setupRooms(roomList:Array) {
            var self = this;
            for( var i in roomList ) {
                var roomName:String = "";
                var room = roomList[i];
                var roomRef:Object;

                room.setup();

                roomName = Environment.getClassName(room);
                roomRef = { roomName: roomName.toLowerCase(), controller: room };
                this.rooms.push(roomRef);
                this.swfLoader.addFile(room.get('swf'));
            }

            this.swfLoader.setCallback(function(mc:MovieClip) {
                var url = self.swfLoader.url();
                var roomIndex = self.swfLoader.getFileCount() - 1;
                self.rooms[roomIndex].controller.setMovie(mc);

            });

            this.swfLoader.onComplete(function() { 
                self.render(0);
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
            var currentRoom;
            var mc = room.controller.getMovie();
            if ( mc.visible === false ) {
                mc.visible = true;
                room.controller.resetFrames();
            } else {
                Environment.view['roomContainer'].addChild(room.controller.getMovie());
            }

            if ( this.currentRoom ) {
                currentRoom = this.currentRoom.controller.getMovie();
                currentRoom.visible = false;
            }
            room.controller.init();
            this.currentRoom = room;
        }
    }
}
