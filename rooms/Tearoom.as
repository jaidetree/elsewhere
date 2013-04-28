package environment.rooms {
    import environment.Room;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import environment.Environment;

    public class Tearoom extends Room {

        public function Tearoom():void {
            var self = this;
            var convos:Object = {
                talked_to_spikey: false,
                talked_to_happy: false,
                talked_to_prude: false,
                talked_to_sad: false,
                spikey_cycle: false,
                happy_cycle: false,
                prude_cycle: false,
                sad_cycle: false
            };

            this.swf = "Rooms/Tearoom.swf";

            this.dialogs = {
                intro: 'The room is dark, diabolic, and in all corners cacti thrive. A great root looms over a tea party hosted around a well with four ghost girls. Time seems to be at a stand-still.',
                closet: [
                    'Prude girl: “So rude. Don’t open that!”',
                    'I manage a peek before I shut it. Looks like the girls keep their clothes and toys here. Inside the closet also stands a mirror.'
                ],
                banners: 'The banners have inverted stars as emblems. The girls seem to be part of a strange sorority.',
                bucket: 'A bucket with a rope for getting water from the well. The bottom is stained rusty red.',
                door: 'The door is bolted shut. It looks like a key is needed for the lock.',
                cacti: 'There are many cacti here.',
                spikey_1: 'If she’s unhappy she should just go somewhere else with her key. This party is awesome!',
                spikey_2: 'Hey you, how long do you stay in here for our party? That scientist didn’t come at first, but after a few hours I finally convinced him how fun we were and let me drag him here for the party.',
                spikey_3: 'I shudder. I don’t see the scientist anywhere in this room. What did they do with him?',
                spikey_key: 'Time’s running out now. You’ll join us soon.',
                happy_1: 'We’re having a magnificent tea party, but lately she keeps being sad and ruins our fun. She can’t take a joke! Seriously, what a downer. I’m happy. We’re happy. Amandala, why can’t you just be a happy? Hey you, kick her out her chair and join us instead.',
                happy_2: 'Did you see what that crazy old nerd was making in his lab? Talk about lame. Glad we finally got him to drag him away from his work, he was a riot. He cried even more than that loser over there. Speaking of which... Amandalaaa, are you still being weird and not talking to anyone?',
                happy_3: 'I wouldn’t want to talk to these mean girls either.',
                happy_key: 'Wow. I bet you feel really good about yourself right now, don’t you? You should’ve just left her alone; she needs to learn how to be adult like us.',
                prude_1: 'She’s pathetic letting her emotions rule her like that. I always put a lot of effort into organizing our parties, you should be happy we let you even come here in the first place.',
                prude_2: 'Maybe I’ll invite Feluvius next time. He’s way more fun. Amandala can go be cute and cry in the corner or something.',
                prude_key: 'So cliché, couldn’t you have done something more interesting like give her a jug of poison instead?',
                sad_1: [ 
                    '...I can’t leave.',
                    'I can barely make out what she whispers to me. It appears the ghost girl is cursed to be in this room for some reason.'
                ],
                sad_2: '“No! I’m not giving you the key.”',
                sad_3: 'If she really can’t leave she doesn’t need the key. But I can’t talk to her when she’s like this. Maybe if I show her some kindness she won’t be so clenched up.',
                sad_key: '“...Don’t waste time here. You need to leave this place.”',
                sad_teacup: [
                    'Thank you. I’d ask you to join but you probably wouldn’t like this party... You need this key right?',
                    'The girl drops the key. It’s a black, chalky, and rough to the touch.',
                    'The party will be over soon.',
                    'I wonder why the scientist never came while he was still alive to get the key to the underground ocean? Did he really want to stay here after all?'
                ]
            };

            this.navigation = {
                navExit: 'EndHall'
            };

            this.objects = {
                sad: function() {
                    var cycle:Number = 2;

                    if ( convos.sad_cycle ) {
                        cycle = 3;
                    } else {
                        cycle = 2; 
                    } 

                    convos.sad_cycle = !convos.sad_cycle;

                    if ( self.hasItem('blackkey') ) {
                        self.setDialog('sad_key');
                        return;
                    }
                    else if ( self.hasItem('teacup') ) {
                        self.addItem('blackkey');
                        self.setDialog('sad_teacup');
                        return; 
                    }
                    if ( convos.talked_to_sad === false ) {
                        self.setDialog('sad_1');
                        convos.talked_to_sad = true;
                        return
                    } else {
                        self.setDialog('sad_' + cycle);
                        return;
                    }
                },

                spikey: function() {
                    var cycle:Number = 2;

                    if ( convos.spikey_cycle ) {
                        cycle = 3;
                    } else {
                        cycle = 2; 
                    } 
                    convos.spikey_cycle = !convos.spikey_cycle;

                    if ( self.hasItem('blackkey') ) {
                        self.setDialog('spikey_key');
                        return;
                    }
                    if ( convos.talked_to_spikey === false ) {
                        self.setDialog('spikey_1');
                        convos.talked_to_spikey = true;
                        return
                    } else {
                        self.setDialog('spikey_' + cycle);
                        return;
                    }
                },

                happy: function() {
                    var cycle:Number = 2;

                    if ( convos.happy_cycle ) {
                        cycle = 3;
                    } else {
                        cycle = 2; 
                    } 

                    convos.happy_cycle = !convos.happy_cycle;

                    if ( self.hasItem('blackkey') ) {
                        self.setDialog('happy_key');
                        return;
                    }
                    if ( convos.talked_to_happy === false ) {
                        self.setDialog('happy_1');
                        convos.talked_to_happy = true;
                        return
                    } else {
                        self.setDialog('happy_' + cycle);
                        return;
                    }
                },

                prude: function() {
                    if ( self.hasItem('blackkey') ) {
                        self.setDialog('prude_key');
                        return;
                    }
                    if ( convos.talked_to_prude === false ) {
                        self.setDialog('prude_1');
                        convos.talked_to_prude = true;
                        return
                    } else {
                        self.setDialog('prude_2');
                        return;
                    }
                },

                closet: { dialog: 'closet' },
                bucket: { dialog: 'bucket' },
                cacti: { dialog: 'cacti' },
                banners: { dialog: 'banners' }
            };
        }
    }
}
