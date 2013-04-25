package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class LongHallway extends Room {

        public function LongHallway():void {
            var self = this;

            this.swf = "Rooms/LongHallway.swf";

            this.animations = {
                'pan': ['hallwaymove', 'hallway0b']
            };

            this.navigation = {
                navHall: 'Hallway'
            };

            this.objects = {
                key_1: {
                    action: 'environment.addToInventory',
                    msg: 'You have picked up a key.'
                }
            };

            this.events = [
                {
                    setup: 'click',
                    a: MouseEvent.CLICK,
                    on: 'animatePan',
                    will: 'animate',
                    using: 'pan'
                },
                {
                    setup: 'toggle',
                    a: Event.ENTER_FRAME,
                    on: 'hallway0b',
                    will: 'show',
                    the: 'navHall'
                },
                {
                    setup: 'toggle',
                    a: Event.ENTER_FRAME,
                    on: 'hallway0b',
                    will: 'hide',
                    the: 'animatePan'
                }
            ];
        }
    }
}
