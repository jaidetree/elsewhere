package environment.rooms {
    import environment.Room;

    public class Trip extends Room {

        public function Trip():void {
            this.swf = "Rooms/Trip.swf";

            this.dialogs = {
                intro: 'The void pulls me in and I feel drawn ever forward as time accelerates. If I go down this path I might never return. The darkness consumes my entire vision, and I feel completely alone yet comforted. Here, I could get lost forever.'
            };
            this.navigation = {
                navReturn: 'ShortHallway'
            };

            this.frames = {
                1: function() {
                    this.setDialog('intro');
                }
            };
        }
    }
}
