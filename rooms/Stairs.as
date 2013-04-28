package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class Stairs extends Room {

        public function Stairs():void {
            var self = this;

            this.swf = "Rooms/Stairs.swf";

            this.dialogs = {
                intro: 'I enter a tight space with tilted walls. Items are lined along the walls to ward off the bad energy with triangles, salt, iron. Despite these precautions the room has an ominous vibe. I have a hard time breathing in here. ',
                yarn: 'This ball of yarn looks out of place. I’ll hold on to it.',
                hatch_key: 'he white key opens the latched door. I can hear water down below.',
                tv: 'The TV is off but I hear a buzzing electrical noise coming from it.',
                salt: 'There is a large bag of unused salt. It’d be fun to dump it all over the shaggy carpet.',
                pyramids: 'There are many pyramids in this room. They are made of different light colored stones.',
                open: 'That way doesn’t appear to be open.',
                carpet: 'The yarn carpet looks soft to touch.',
                hatch: 'The hatch door is locked up.'
            };

            this.navigation = {
               navDown: 'Sea',
                navHall: 'EndHall'
            };

            this.objects = {
                yarn: function() {
                    if ( ! self.hasItem(this) ) {
                        self.setDialog('yarn');
                        self.addItem(this);
                        self.hide('yarn');
                    }
                },

                hatch: function() {
                    if( self.hasItem('blackkey') ) {
                        self.show('signAnimation');
                        self.mc.signAnimation.play();
                        self.show('navDown');
                        self.hide('hatch');
                    }
                    else {
                        self.setDialog('hatch');
                    }
                },

                tv: { dialog: 'tv' },
                salt: { dialog: 'salt' },
                pyramids: { dialog: 'pyramids' },
                open: { dialog: 'open' },
                carpet: { dialog: 'carpet' }
            };

            this.frames = {
                '1': function() {
                    self.setDialog('intro');
                    self.show('yarn');
                    self.hide('signAnimation');
                    self.hide('navDown');
                }
            };
        }
    }
}
