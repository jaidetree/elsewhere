package environment.rooms {
    import flash.events.Event;
    import flash.events.MouseEvent;
    import environment.Room;
    import environment.Environment;

    public class Intro extends Room {
        public function Intro():void {
            var self = this;
            this.swf = "Rooms/Intro.swf";

            this.frames = {
                'video': function() {
                    self.mc.introVideo.addEventListener(Event.COMPLETE, this.startGame);
                    self.mc.btnSkip.addEventListener(MouseEvent.CLICK, this.startGame);
                }
            };
        }

        protected function startGame(e) {
            Environment.rooms.render('IntroDoor');
            this.mc.introVideo.removeEventListener(Event.COMPLETE, this.startGame);
            this.mc.btnSkip.removeEventListener(MouseEvent.CLICK, this.startGame);
        }
    }
}
