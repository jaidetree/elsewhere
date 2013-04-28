package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class EndHall extends Room {
        protected var locked:Boolean = true;

        public function EndHall():void {
            var self = this;

            this.swf = "Rooms/EndHall.swf";

            this.dialogs = {
                intro: 'The hallway ends here.',
                leftSign: 'This sign looks like it has a symbol of a salamander on it.',
                rightSign: 'This sign looks likes it has a symbol of a mermaid on it.',
                door: 'The door is bolted shut. It looks like a key is needed for the lock.',
                unlocked: 'The door unlocks.'
            };

            this.navigation = {
                navShoeroom: 'Shoeroom',
                navTea: 'Tearoom',
                navExit: 'Stairway',
                navLobby: 'MainLobby'
            };

            this.objects = {
                door: function() {
                    if ( ! self.hasItem('blackkey') ) {
                        self.setDialog('door');
                    }
                },

                leftSign: { dialog: 'leftSign' },
                rightSign: { dialog: 'rightSign' }
            };

            this.frames = {
                'init': function() {
                    self.setDialog('intro');
                    self.show('door');
                    self.hide('navExit');

                    if ( self.locked && self.hasItem('blackkey') ) {
                        self.mc.gotoAndStop('unlocked');
                        self.currentFrame = self.mc.currentFrame;
                    }

                },
                'unlocked': function() {
                    self.show('navExit');
                    self.hide('door');
                    if ( ! self.locked && self.hasItem('blackkey') ) {
                        self.mc.gotoAndStop('ending');
                        self.currentFrame = self.mc.currentFrame;
                    }
                    self.locked = false;
                    self.setDialog('unlocked');
                }
            };
        }
    }
}
