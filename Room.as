package environment {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class Room {
        protected var swf;
        protected var animations:Object;
        protected var navigation:Object;
        protected var objects:Object;
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
        }

        public function get(property:String) {
            return this[property];
        }

        public function setMovie(mc:MovieClip) {
            this.mc = mc;
        }


        protected function setupNav():void {
            var navigations = this.navigation, 
                navMovieClip,
                includes,
                self = this;


            for( var uiName in navigations ) {
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

    }
}
