package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class ShortHallway extends Room {

        public function ShortHallway():void {
            var self = this;

            this.swf = "Rooms/ShortHallway.swf";

            this.navigation = {
                navHall: 'LongHallway',
                navLobby: 'MainLobby'
            };

            this.objects = {
                key_1: {
                    action: 'environment.addToInventory',
                    msg: 'You have picked up a key.'
                }
            };
        }
    }
}
