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
        protected var lastFrame:Number = -1;
        protected var isSetup:Boolean = false;

        public function Room():void {
        }

        public function setup():void {
            this.setupDialogs();
        }

        public function init():void {
            var currentFrame:Number;
            if ( ! this.isSetup ) {
                this.setupNav();
                this.setupObjects();
                this.setupEvents();
                this.setupFrames();
                this.isSetup = true;
            }
            this.clearDialog();
            this.mc.gotoAndStop(this.currentFrame);

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

        public function resetFrames():void {
            this.lastFrame = 0;
            this.mc.removeEventListener( Event.ENTER_FRAME, this.onEnterFrame );
            this.mc.addEventListener( Event.ENTER_FRAME, this.onEnterFrame );
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
                if ( RegExp(/\.txt$/g).test(dialogs[dialog]) === false ) { 
                    continue;
                }
                TxtLoader.loadFile( dialogs[dialog] );
            }
        }

        protected function setupFrames():void {
            var self = this;
            var frame;

            this.mc.addEventListener( Event.ENTER_FRAME, this.onEnterFrame );
        }

        protected function onEnterFrame(e:Event) {
            var frames = this.frames;
            if ( this.lastFrame === this.mc.currentFrame ) {
                return;
            }
            for ( var frameIndex in frames ) {
                if ( this.mc.currentLabel == frameIndex || this.mc.currentFrame == int(frameIndex) ) {
                    this.lastFrame = this.mc.currentFrame;
                    frames[frameIndex].call(this);
                }
            }
            //this.currentFrame = this.mc.currentFrame;
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
                e.target.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
                Environment.rooms.render(clipName);
            });
        }

        protected function setupObjects():void {
            var self = this;
            var mc = this.mc;
            for (var i in this.objects) {
                var objectData = this.objects[i];
                if ( ! mc[i] ) {
                    continue;
                }
                this.setObjectCallback(i, objectData);
            }
        }

        protected function setObjectCallback(mcName, objectData):void {
            var callback:Function;
            var self = this;
            var mc = this.mc;
            if ( typeof (objectData) === "function" ) {
                callback = function() {
                    objectData.call(mc[mcName]);
                };
            } 
            else if( "dialog" in objectData ) {
                callback = function() {
                    self.setDialog( objectData.dialog );
                };
            }

            mc[mcName].addEventListener(MouseEvent.CLICK, function(e:MouseEvent){ 
                callback();
            });
        }

        protected function setDialog(dialogName):void {
            Environment.displayDialog( this.dialogs[dialogName] );            
        }

        protected function clearDialog():void {
            Environment.clearDialog();
        }


        protected function animate(animationName, updateState:Boolean = false):void {
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
