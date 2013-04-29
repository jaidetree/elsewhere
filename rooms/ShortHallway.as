package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class ShortHallway extends Room {

        protected var trapSprung:Boolean = false;
        public function ShortHallway():void {
            var self = this;

            this.swf = "Rooms/ShortHallway.swf";

            this.dialogs = {
                intro: 'I stumble across a point where I can choose between two hallways. One seems to be safe, but the other one seems mesmerizing.',
                pot: 'Fresh cut plants have been arranged in this vase.',
                house: 'There is a mouse hole here. I can see light coming through on the other side.'
            };

            this.navigation = {
                navHall: 'LongHallway',
                navLobby: 'MainLobby',
                navTrip: 'Trip'
            };

            this.objects = {
                pot: { dialog: 'pot' },
                house: { dialog: 'house' }
            };

            this.frames = {
                '1': function() {
                    self.setDialog('intro');
                }
            };
        }
    }
}
