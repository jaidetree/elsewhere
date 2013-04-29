package environment.rooms {
    import environment.Room;

    public class SandIntro extends Room {

        public function SandIntro():void {
            this.swf = "Rooms/SandIntro.swf";

            this.animations = {
                'intro': [0, 'endFrame']
            };

            this.navigation = {
                navHall: 'LongHallway'
            };

            this.dialogs = {
                intro: [
                    'I land hard into a pile of sand, harsh specks flying into my eye. I clamp my eye shut, wince, pry open my lid to get them out. This place looks like a stone laid basement. The darkness appears to be alive, and maddening if stared at long enough.',
                    'A dark female voice is in my head, speaking to me through telepathy: “You will die in thirty minutes if you do not make it to the underground ocean. I repeat. You will die. Hurry.”',
                    'I guess I’m not supposed to be here.'
                ]
            };

            this.frames = {
                1: function() {
                    this.setDialog('intro');
                }
            };
        }
    }
}
