package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class Lab extends Room {

        public function Lab():void {
            var self = this;

            this.swf = "Rooms/Lab.swf";

            this.dialogs = {
                intro: 'I stumble upon the scientist’s lab. The scene is clustered, chaotic, with tracks leading to a locked door in the corner. I don’t think they were able to unlock the door.',
                book: 'These appear to be the scientist’s diaries. It seems he became holed up in his own lab, and couldn’t find a way out. Click here to read more.',
                matches: 'I don’t think I need anything else here, but a box of matches is always useful.',
                have_matches: 'None of these things look useful right now.',
                cabinet: 'There is monopoly money in the bottom-most cabinet. I’ll just leave it there.',  
                table_items: 'I don’t know how to use any of these things.',
                tub: 'This looks like a bath tub. I wouldn’t want to use it though.',
                tubes: 'These tubes contents don’t seem safe. I better leave them alone.',
                shoot: 'Is this a garbage shoot?',
                machine: 'This is an adding machine.',
                top_cabinet: 'An unorganized file cabinet',
                levers: 'I don’t want to turn this on.'
            };

            this.navigation = {
                navDoor: 'MainLobby'
            };

            this.animations = {
                slideUp: ['slideup', 'dialog'],
                slideDown: ['down', 'hidden']
            };

            this.objects = {
                matches: function() {
                    if ( Environment.ui.inventory.hasItem(this) ) {
                        self.setDialog('have_matches');
                    } else {
                        Environment.addToInventory(this);
                        self.setDialog('matches');
                    }
                },
                book: function() {
                    self.setDialog('book');
                    Environment.ui.dialog.mc().addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { 
                        self.animate('slideUp');
                        self.show('screen');
                        self.clearDialog();
                        e.target.removeEventListener(MouseEvent.CLICK, arguments.callee );
                    } );

                },

                tableItems: { dialog: 'table_items' },
                cabinet: { dialog: 'cabinet' },
                drawer: { dialog: 'top_cabinet' },
                tub: { dialog: 'tub' },
                tubes: { dialog: 'tubes' },
                shoot: { dialog: 'shoot' },
                machine: { dialog: 'machine' },
                levers: { dialog: 'levers' }
            };

            this.frames = {
                '1': function() {
                    this.setDialog('intro');
                    this.hide('screen');
                },
                'dialog': function() {
                    self.mc.addEventListener( MouseEvent.CLICK, function(e:MouseEvent) {
                        self.animate('slideDown');
                        self.hide('screen');
                        self.mc.removeEventListener(MouseEvent.CLICK, arguments.callee );
                    });
                },

                'hidden': function() {
                    this.mc.gotoAndStop(0);
                    self.currentFrame = 0;
                }
            };
        }
    }
}
