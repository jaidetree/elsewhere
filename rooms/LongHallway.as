package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class LongHallway extends Room {

        public function LongHallway():void {
            var self = this;

            this.swf = "Rooms/LongHallway.swf";

            this.dialogs = {
                intro_left: "This hallway is an extension of the first room. It feels ancient. Fear grows in me for intruding this place, but curiosity makes me feel bold.",
                intro_right: "This wood paneled hallway looks like it was made by a different civilization. Over the high arching doorway, roots sprawl their limbs along the walls. A strange creature is sitting in a chair. He looks friendly and cute.",
                sand: "This way leads back to the room filled with sand, where I came from.",
                batpig: '“Hello, my name is Feluvius and welcome to the 23rd wing! You’ve come at a great time; there’s finally peace and quiet. The mad scientist has holed himself in the basement. Say, why don’t you go to the laboratory and grab me a light for my pipe?”', 
                matches: 'Feluvius: “Ah, I thank you sir. Go check out that pitch-black room next. Even creatures of darkness need a light now and then.”',
                bye: 'Feluvius: “Toodaloo, friend!”',
                ending: 'This side of the hallway feels dead compared to the rest of the rooms I’ve been in.'
            };

            this.animations = {
                'pan': ['hallwaymove', 'hallway0b']
            };

            this.navigation = {
                navHall: 'ShortHallway',
                navSand: 'Sandroom'
            };

            this.objects = {
                batpig: function () {
                    if ( self.hasItem('roperock') ) {
                        self.setDialog('bye');
                    }
                    else if ( ! self.hasItem('matches') ) {
                        self.setDialog('batpig');
                    }
                    else if ( self.hasItem('matches' ) ) {
                        self.setDialog('matches');
                    }
                },
                animatePan: function() {
                    self.animate('pan');
                }
            };

            this.frames = {
                'hallway0': function () {
                    if ( self.hasItem('roperock' ) ) {
                        self.setDialog('ending');
                    } else {
                        self.setDialog('intro_left');
                    }

                    self.hide('navHall');
                    self.show('animatePan');
                    self.hide('batpig');
                    self.hide('navSand');
                },
                'hallwaymove': function () {
                    self.hide('navHall');
                    self.hide('animatePan');
                },
                'hallway0b': function () {
                    self.show('batpig');
                    if ( self.hasItem('roperock' ) ) {
                        self.setDialog('sand');
                    } else {
                        self.setDialog('intro_right');
                    }
                    self.currentFrame = self.mc.currentFrame;
                    self.show('navSand');
                    self.show('navHall');
                    self.hide('animatePan');
                }
            };
        }
    }
}
