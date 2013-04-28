package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class Shoeroom extends Room {

        public function Shoeroom():void {
            var self = this;

            this.swf = "Rooms/Shoeroom.swf";

            this.dialogs = {
                intro: 'I feel anxious and paranoid standing in here. The darkness appears to have eyes, and faces. The room is nearly obscure, the halo of a one eyed statue haunts in the corner. I can make out a fire pit in the center of the room.',
                eyes: 'Why won’t they stop staring?',
                statue: 'She knows I’m an intruder here.',
                firepit: 'The fire pit illuminates the interior. It’s not so scary in here after all but there is a sense of melancholy and change.',
                tree: 'It looks like a tapestry. I’m not sure what it’s supposed to mean. Maybe it’s just an artsy tree but it could be a map of the world or an expression of vitality, too.',
                moths: 'Pinned moths hang on the wall. The moth in the center has eyes on its wings.',
                statues: 'A tall statue stands over two crying children.',
                trunks: 'Many heavy trunks are stacked here. They appear very dirty and used.',
                stool: 'Maybe I’ll just sit here for a while...',
                teacup: 'It seems the statues were standing guard over this cup. The cup is porcelain, and strangely clear of dust.',
                owl: 'Owl: “OoooOoOoooo!”',
                fireroom: 'The space is entrancing, roots sprout across the floor and up to the ceiling. The fire reveals a tapestry of a mystical tree, an owl beside it, and a set of old fashion trunks. A dressing mirror stands beside a Grecian statue that guards the room.'
            };

            this.navigation = {
                navHall: 'EndHall'
            };

            this.objects = {
                teacup: function() {
                    if ( ! self.hasItem(this) ) {
                        Environment.addToInventory(this);
                        self.setDialog('teacup');
                        this.visible = false;
                    }
                },
                firepit: function() {
                    if ( self.hasItem('matches') ) {
                        self.setDialog('firepit');
                        self.mc.gotoAndStop('fireroom');
                        self.currentFrame = self.mc.currentFrame;
                    }
                },

                eyes: { dialog: 'eyes' },
                trunks: { dialog: 'trunks' },
                statue: { dialog: 'statue' },
                tapestry: { dialog: 'tapestry' },
                moths: { dialog: 'moths' },
                statues: { dialog: 'statues' },
                trunks: { dialog: 'trunks' },
                stool: { dialog: 'stool' },
                owl: { dialog: 'owl' }
            };

            this.frames = {
                'shoeroom': function() {
                    this.setDialog('intro');
                    self.show('eyes');
                    self.show('statue');
                    self.show('firepit');
                    self.hide('tapestry');
                    self.hide('moths');
                    self.hide('statues');
                    self.hide('trunks');
                    self.hide('stool');
                    self.hide('teacup');
                    self.hide('owl');
                },
                'fireroom': function() {
                    this.setDialog('fireroom');
                    self.hide('eyes');
                    self.hide('statue');
                    self.hide('firepit');
                    self.show('tapestry');
                    self.show('moths');
                    self.show('statues');
                    self.show('trunks');
                    self.show('stool');
                    self.show('teacup');
                    self.show('owl');
                }
            };
        }
    }
}
