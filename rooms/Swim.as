package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class Swim extends Room {
        protected var phase:Number = 0;

        public function Swim():void {
            var self = this;

            this.swf = "Rooms/Swim.swf";

            this.dialogs = {
                'intro': 'I lose all my items swimming in the water. I approach a dark androgynous person floating in the water.',
                'entity': [
                    'Entity: “How much time do you think you have you spent here?”',
                    'No time at all.',
                    function() { 
                        self.phase++; 
                        return '“Good answer. You can leave then. If you want me to show you the way out however, you need to give me something in return.”';
                    }
                ],
                'item': [
                    'Since all my items were washed away by the water, I have nothing but the clothes on my back. So I hand over my shoes.',
                    '“...I will accept this. Take this rock, and this braided rope. You will have to go back to the first room you came from and then use this rope to leave. Hurry, you don’t have much time.”',
                    function() { 
                        self.phase++; 
                        self.addItem('roperock');
                        return 'She doesn’t explain what thy are for, but I feel it’d be rude to ask. I thank her and swim back to shore.';
                    },
                    function() {
                        Environment.rooms.render('Stairs');
                    }
                ],
                'hint': [
                    '“Take a hint, human. You’re out of your element. Time to leave.”', 
                    function() {
                        Environment.rooms.render('Stairs');
                    }
                ]
            };

            this.objects = {
                'entity': function () {
                    if ( self.phase === 0 ) {
                        self.setDialog('entity');
                    }
                    else if ( self.phase === 1 ) {
                        self.setDialog('item');
                    }
                    else if ( self.phase === 2 ) {
                        self.setDialog('hint');
                    }
                }
            };

            this.frames = {
                '1': function () {
                    self.setDialog('intro');
                    self.clearInventory();
                }
            };

        }
    }
}
