package environment.rooms {
    import environment.Room;
    import environment.Environment;

    public class Sandroom extends Room {

        public function Sandroom():void {
            var self = this;
            this.swf = "Rooms/Sandroom.swf";

            this.navigation = {
                navReturn: 'LongHallway'
            };

            this.dialogs = {
                intro: 'This mysterious room is filled with sand.',
                hole: 'How am I supposed to get out of here? Will I be able to get out of here? I better go find that underwater ocean fast...',
                sand: 'Luckily that pile of sand was there to break my fall.',
                final_intro: 'I make it back to the first room. This is where the underwater spirit told me to go',
                hole_final: [ 
                    'I pull out the rope, and it jumps out of my hands like a live snake. I hold onto it tightly as I fly up through the hole in the ceiling.',
                    function() { 
                        Environment.rooms.render('Finale');
                    }
                ]
            };

            this.objects = {
                'navUp': function() {
                    if ( self.hasItem('roperock') ) {
                        self.setDialog('hole_final');
                    } else {
                        self.setDialog('hole');
                    }
                },
                'sand': { dialog: 'sand' }
            };

            this.frames = {
                1: function() {

                    if ( self.hasItem('roperock') ) {
                        this.setDialog('final_intro');
                        self.hide('sand');
                    } else {
                        this.setDialog('intro');
                   } 
                }
            };
        }
    }
}
