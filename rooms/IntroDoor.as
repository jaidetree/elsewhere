package environment.rooms {
    import environment.Room;

    public class IntroDoor extends Room {

        public function IntroDoor():void {
            this.swf = "Rooms/IntroDoor.swf";

            this.animations = {
                'intro': [0, 'endFrame']
            };

            this.navigation = {
                navDoor: 'HallwayLegs'
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
