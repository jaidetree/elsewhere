package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class MainLobby extends Room {

        public function MainLobby():void {
            var self = this;

            this.swf = "Rooms/MainLobby.swf";

            this.animations = {
                'panDown': ['down', 'bottom'],
                'panUp': ['up', 'top']
            };

            this.navigation = {
                navHall: 'ShortHallway',
                navLab: 'Lab',
                navExit: 'ExitHall',
                navLamps: 'Lamps'
            };

            this.objects = {
                key_1: {
                    action: 'environment.addToInventory',
                    msg: 'You have picked up a key.'
                }
            };

            this.frames = {
                'hallway2': function() { 
                    this.hide('animateUp');
                    this.show('animateDown');
                    this.show('navHall');
                    this.show('navLab');
                    this.show('navExit');
                    this.show('navLamps');
                },

                'bottom': function() {
                    this.hide('animateDown');
                    this.hide('navHall');
                    this.hide('navLab');
                    this.hide('navExit');
                    this.hide('navLamps');
                    this.show('animateUp');
                },

                'top': function() {
                    this.hide('animateUp');
                    this.show('animateDown');
                    this.show('navHall');
                    this.show('navLab');
                    this.show('navExit');
                    this.show('navLamps');
                }
            };

            this.events = [
                {
                    setup: 'click',
                    a: MouseEvent.CLICK,
                    on: 'animateDown',
                    will: 'animate',
                    using: 'panDown'
                },
                {
                    setup: 'click',
                    a: MouseEvent.CLICK,
                    on: 'animateUp',
                    will: 'animate',
                    using: 'panUp'
                },
            ];
        }
    }
}
