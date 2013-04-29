package environment.rooms {
    import environment.Room;
    import environment.Environment;

    public class IntroDoor extends Room {

        public function IntroDoor():void {
            this.swf = "Rooms/IntroDoor.swf";

            this.animations = {
                'intro': [0, 'endFrame']
            };

            this.navigation = {
                navDoor: 'SandIntro'
            };

            this.frames = {
                '1': function() {
                    Environment.view['uiContainer'].visible = true;
                }
            };
        }
    }
}
