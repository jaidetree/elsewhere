package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;
    import flash.display.SimpleButton;

    public class Lamps extends Room {

        protected var rescued:Boolean = false;
        public function Lamps():void {
            var self = this;

            this.swf = "Rooms/Lamps.swf";

            this.dialogs = {
                intro: 'A series of lamps spill pools of light about them in an otherwise dark room. Revealed is a great root sprouting forth over a vase of sunflowers. On closer inspection, one of them looks unsettling.',
                sunflowers_1: 'Schmael: “Ooooooo! Woe is me! Curse this pot, curses to these flowers! They don’t understand me! No one understands, except Mr. Centipede...But he’s gooone!!!!! He left me!!!!!!”',
                sunflowers_2: '“He went down that hole over there, down that root!!!! Help him!!! Help him!!!”',
                lamps: 'I can’t seem to identify the power source for these lamps. Battery operated maybe?',
                hole: 'There is a dark abyss where the root has grown from. I can’t tell how deep it is.',
                roots: 'This appears to be a main branch of the roots.',
                together: 'They look happy to be together again.',
                key: 'My centipeeeeedee!!!! My centipede, how I missed you!!! Take the key to my heart, you!'
            };

            this.navigation = {
               navDoor: 'MainLobby'
            };

            this.animations = {
                'rescue': ['rescue', 'rescued']
            };

            this.objects = {

                hole: function() {
                    self.animate('rescue');
                    if ( self.hasItem('yarn') ) {
                        self.animate('rescue');
                    } else {
                        self.setDialog('hole');
                    }
                },

                sunflowers: function() {
                    self.hide('lamps');
                    self.hide('hole');
                    self.hide('roots');
                    self.hide('navDoor');
                    self.hide('sunflowers');

                    self.setDialog('sunflowers_1');

                    if ( self.rescued ) {
                        self.mc.gotoAndStop('together');
                    } else {
                        self.mc.gotoAndStop('closeup');
                    }
                },

                lamps: { dialog: 'lamps' },
                roots: { dialog: 'roots' }
            };

            this.frames = {
                '1': function() {
                    self.setDialog('intro');
                },
                'closeup': function() {
                    Environment.view['roomContainer'].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { 
                        Environment.view['roomContainer'].removeEventListener(MouseEvent.CLICK, arguments.callee);
                        self.setDialog('sunflowers_2');
                        Environment.view['roomContainer'].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { 
                            Environment.view['roomContainer'].removeEventListener(MouseEvent.CLICK, arguments.callee);
                            self.mc.gotoAndStop(1);
                            self.setDialog('intro');
                            self.show('lamps');
                            self.show('hole');
                            self.show('roots');
                            self.show('navDoor');
                            self.show('sunflowers');
                        });
                    });
                },
                'together': function() {
                    self.setDialog('together');
                    if ( ! self.hasItem('whitekey') ) {
                        self.setDialog('key');
                        Environment.view['roomContainer'].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
                            self.addItem('whitekey');
                            self.mc.gotoAndStop('rescued');
                            Environment.view['roomContainer'].removeEventListener(MouseEvent.CLICK, arguments.callee);
                        });
                    } else {
                        Environment.view['roomContainer'].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
                            self.addItem('whitekey');
                            self.mc.gotoAndStop('rescued');
                            Environment.view['roomContainer'].removeEventListener(MouseEvent.CLICK, arguments.callee);
                        });
                    }
                },
                'rescue': function() {
                    self.hide('lamps');
                    self.hide('hole');
                    self.hide('roots');
                    self.hide('navDoor');
                    self.hide('sunflowers');
                },
                'rescued': function() {
                    if ( ! self.rescued ) {
                        self.rescued = true;
                        self.mc.gotoAndStop('together');
                    } else {
                        self.show('lamps');
                        self.show('roots');
                        self.show('navDoor');
                        self.show('sunflowers');
                        self.currentFrame = self.mc.currentFrame;
                    }
                }
            };
        }
    }
}
