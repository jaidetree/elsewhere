package environment {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class Room {
        protected var swf;
        protected var animations:Object;
        protected var navigation:Object;
        protected var objects:Object;
        protected var events:Array;
        protected var mc:MovieClip;

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
                msg: 'You have picked up a key.'
            }
        };
        */

        public function Room():void {
        }

        public function init():void {
            this.setupNav();
            this.setupObjects();
            this.setupAnimations();
            this.setupEvents();
            this.mc.gotoAndStop(0);
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


        protected function setupNav():void {
            var navigations = this.navigation, 
                navMovieClip,
                includes,
                self = this;


            for ( var uiName in navigations ) {
                navMovieClip = this.mc[uiName];
                navMovieClip.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){ 
                    Environment.rooms.render(navigations[uiName]);
                });
            }
        }

        protected function setupObjects():void {
        }

        protected function setupAnimations():void {
        }

        protected function animate(animationName):void {
            var self = this,
                animation = this.animations[animationName];

            self.mc.addEventListener(Event.ENTER_FRAME, function(e:Event){ 
                if ( self.mc.currentLabel === animation[1] || self.mc.currentFrame === animation[1] )  {
                    self.mc.stop();
                    self.mc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
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
