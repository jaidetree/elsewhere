package environment.rooms {
    import environment.Room;

    public class HallwayLegs extends Room {

        public function HallwayLegs():void {
            this.swf = "Rooms/HallwayLegs.swf";

            this.animations = {
                'intro': [0, 'endFrame']
            };

            this.navigation = {
                navHall: 'LongHallway'
            };

            this.dialogs = {
                'intro': 'hallwaylegs.txt'
            };

            this.frames = {
                1: function() {
                    this.setDialog('intro');
                }
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
