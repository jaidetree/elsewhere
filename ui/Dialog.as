package environment.ui {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import environment.utils.TxtLoader;

    public class Dialog {
        protected var textList:Array = [];
        private var index:Number = 0;
        private var _mc:TextField;

        public function Dialog(mc:TextField) {
            this.mc( mc );
            mc.addEventListener(MouseEvent.CLICK, this.cycleDialog);
        }

        public function setText(txt) {
            var mc = this.mc();

            if ( typeof ( txt ) == "object" ) {
                this.textList = txt;
            }
            else if ( RegExp(/\.txt$/g).test(txt) ) {
                txt = TxtLoader.getTxt(txt);
                this.textList = txt.split('\n\n');
            } 
            else {
                this.textList = [ txt ];
            }
            this.index = 0;
            this.update();
        }


        public function clear() {
            this.mc().text = "";
        }

        private function update() {
            var i = this.index;
            var mc = this.mc();
            if ( this.textList[i] is Function ) {
                var answer = this.textList[i]();
                if ( typeof ( answer ) === "string" ) {
                    mc.text = answer;
                } else {
                    return; 
                }
            } else {
                mc.text = this.textList[i];
            }

            if ( this.textList.length > 1 && this.index < this.textList.length - 1 ) {
                mc.text = mc.text + ' (click to continue)';
            }
        }

        private function cycleDialog(e:MouseEvent) {
            var mc = this.mc();
            if ( this.index < this.textList.length - 1 ) {
                this.index++;
                this.update();
            }        
        }


        public function mc(mc=null) {
            if ( mc !== null ) {
               this._mc = mc;
            }

            return this._mc;
        }
    }
}
