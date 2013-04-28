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

            this.dialogs = {
                'intro': 'Roots sprout out above the closest door. Next to it is a mask that is smiling as though it has secrets to tell. Another door has a large candelabra beside it. The last door visible has the horns of a bull thrusting proudly above it’s mantle.',
                'floor': 'When I walk this direction, the floorboards quickly melt away to nothing. I feel I have stepped off the map of existence. I better go back. This worlds seems to have different booby traps.'
            };

            this.navigation = {
                navHall: 'ShortHallway',
                navLab: 'Lab',
                navExit: 'EndHall',
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
                    this.setDialog('intro')
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
                    this.setDialog('floor');
                },

                'top': function() {
                    this.mc.gotoAndStop('hallway2');
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
