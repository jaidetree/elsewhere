package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class Beach extends Room {

        public function Beach():void {
            var self = this;

            this.dialogs = {
                'intro': 'This is a deep cavern lit by a single lantern. Stalagmites rise from the water to greet me, luring me beyond to the abyss. There is a shadow, in the distance.'
            };

            this.swf = "Rooms/Beach.swf";

            this.navigation = {
                navSwim: 'Swim'
            };

            this.frames = {
                '1': function () {
                    self.setDialog('intro');
                }
            };

        }
    }
}
