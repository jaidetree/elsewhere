package environment.rooms {
    import environment.Room;
    import environment.Environment;

    public class Finale extends Room {
        public function Finale():void {
            var self = this;
            this.swf = "Rooms/Finale.swf";

            this.dialogs = {
                intro: [
                    'The door and rope disappear instantly. I land hard on the ground, my bare feet skidding on the rough pavement. My hands are clutching the rock. As I examine it more closely it is no longer a rock, but the set of keys I’d lost.',
                    'Checking my phone 12:02 pm. True to my words, I really was there for no time at all: I still have enough time now to walk back home and drive to work.',
                    function() {
                        self.show('restart');
                        self.mc.restart.gotoAndPlay(2);
                    }
                ]
            };

            this.objects = {
                'restart': function() {
                    Environment.restart();
                }
            };

            this.frames = {
                1: function() {
                    this.hide('restart');
                    self.setDialog('intro');
                }
            };
        }
    }
}
