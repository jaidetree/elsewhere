package  {
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import Room;

    public class Room {
        private environment;

        private swf = "TestRoom.swf";
        
        private animations:Object = {
            'intro': [0, 'endFrame']
        };

        private navigation:Object = {
            door_1: 'Basement', 
            door_2: 'Cellar',
            door_3: {
                class: 'LivingRoom',
                requires: ['']
            },
        };

        private objects:Object = {
            key_1: {
                action: 'environment.addToInventory',
                msg: 'You have picked up a key.'
            }
        };

        public function Room(environment):void {
            this.environment = environment;
        }
    }
}
