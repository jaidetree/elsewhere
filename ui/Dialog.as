package environment.ui {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import environment.utils.TxtLoader;

    public class Dialog {
        private var textList:Array = [];
        private var index:Number = 0;
        private var _mc:TextField;

        public function Dialog(mc:TextField) {
            this.mc( mc );
            mc.addEventListener(MouseEvent.CLICK, this.cycleDialog);
        }

        public function showText(file) {
            var txt:String = TxtLoader.getTxt(file);
            var mc = this.mc();
            this.textList = txt.split(String.fromCharCode(13) + String.fromCharCode(13));
            mc.text = this.textList[0];
            this.index = 0;
        }

        private function cycleDialog(e:MouseEvent) {
            var mc = this.mc();
            if ( this.index < this.textList.length ) {
                this.index++;
                mc.text = this.textList[this.index];
            } else {
                mc.text = "";
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
