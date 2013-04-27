package environment {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;

    import environment.Environment;
    import environment.utils.TxtLoader;

    public class Room {
        protected var swf;
        protected var animations:Object;
        protected var navigation:Object;
        protected var objects:Object;
        protected var frames:Object;
        protected var events:Array;
        protected var dialogs:Object;
        protected var mc:MovieClip;
        protected var currentFrame:Number = 0;
        protected var isSetup:Boolean = false;

        /* 'intro': [0, 'endFrame'] */
        
        /*
        private var navigation:Object = {

            door_1: 'Basement', 
            door_2: 'Cellar',
            door_3: {
                className: 'LivingRoom',
                requires: ['key_1']
            }
        };

        private var objects:Object = {
            key_1: {
                action: 'environment.addToInventory',
                dialog: 'Dialog/IntroDoor.txt'
            }
        };
        */

        public function Room():void {
        }

        public function setup():void {
            this.setupDialogs();
        }

        public function init():void {
            if ( ! this.isSetup ) {
                this.setupNav();
                this.setupObjects();
                this.setupEvents();
                this.isSetup = true;
            }
            this.setupFrames();
            this.mc.gotoAndStop(this.currentFrame);
            Environment.clearDialog();
        }

        public function get(property:String) {
            return this[property];
        }

        public function setMovie(mc:MovieClip) {
            this.mc = mc;
        }

        public function getMovie():MovieClip {
            return this.mc;
        }

        protected function show(mcName):void {
            this.mc[mcName].visible = true;
        }

        protected function hide(mcName):void {
            this.mc[mcName].visible = false;
        }

        protected function setupDialogs():void {
            var self = this;
            var dialogs = this.dialogs;
            for ( var dialog in dialogs ) {
                TxtLoader.loadFile( dialogs[dialog] );
            }
        }

        protected function setupFrames():void {
            var self = this;
            var frames = this.frames;
            var frame;

            this.mc.addEventListener( Event.ENTER_FRAME, function(e:Event) { 
                if ( self.mc.currentFrame === self.currentFrame ) {
                    return false;
                }
                for ( var frameIndex in frames ) {
                    if ( self.mc.currentLabel == frameIndex || self.mc.currentFrame == frameIndex ) {
                        frames[frameIndex].call(self);
                        self.currentFrame = self.mc.currentFrame;
                        //self.mc.removeEventListener( Event.ENTER_FRAME, arguments.callee );
                    }
                }
            });
        }

        protected function setupNav():void {
            var navigations = this.navigation, 
                self = this;


            for ( var uiName in navigations ) {
                var navMovieClip = this.mc[uiName];
                this.setupNavEvent(navMovieClip, navigations[uiName]);
            }
        }

        protected function setupNavEvent(navMovieClip, clipName):void {
            navMovieClip.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){ 
                Environment.rooms.render(clipName);
            });
        }

        protected function setupObjects():void {
            var self = this;
            for (var i in this.objects) {
                var object = this.objects[i];
                if( object['dialog'] ) {
                    this.setupObjectHandler(i, this.dialogs[object['dialog']] );
                }
            }
        }

        protected function setupObjectHandler(i, dialog):void {
            Environment.view[i].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
                Environment.displayDialog( dialog );
            });
        }

        protected function setDialog(dialogName):void {
            Environment.displayDialog( this.dialogs[dialogName] );            
        }

        protected function animate(animationName):void {
            var self = this,
                animation = this.animations[animationName];

            self.mc.addEventListener(Event.ENTER_FRAME, function(e:Event){ 
                if ( self.mc.currentLabel === animation[1] || self.mc.currentFrame === animation[1] )  {
                    self.mc.stop();
                    self.mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    self.currentFrame = self.mc.currentFrame;
                }
            });

            self.mc.gotoAndPlay(animation[0]);

        }

        protected function setupEvents():void {
            var events = this.events,
                event,
                self = this;

            for (var handle in events ) {
                event = events[handle];

                if ( event.setup == "click" ) {
                    this.setupClickEvent(event);
                }
                else if ( event.setup == "toggle" ) {
                    this.setupToggleEvent(event);
                }
            }
        }

        protected function setupToggleEvent(event):void {
            var self = this;
            self.mc.addEventListener(event.a, function(e:Event) {
                if ( self.mc.currentLabel === event.on || self.mc.currentFrame === event.on ) {
                    self.mc[event.the].visible = ( event.will === 'show' ) ? true : false;
                    self.mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                }
            });
        }
        protected function setupClickEvent(event):void {
            var self = this;
            self.mc[event.on].addEventListener(event.a, function(e:MouseEvent) {
                if ( event.will === 'animate' ) {
                    self.animate(event.using);
                }
            });
        }

    }
}
