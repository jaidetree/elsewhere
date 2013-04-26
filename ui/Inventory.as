package environment.ui {
    import flash.display.MovieClip;
    public class Inventory {
        private var itemList:Array = [];
        private var obtainedItems:Array = [];
        private var _mc:MovieClip;

        public function Inventory(mc:MovieClip) {
            this.mc(mc);

            for (var item in this._mc) {
                this._mc[item].visible = false;
                this.itemList.push(item);
            }
        }

        public function mc(mc=null) {
            if ( mc !== null ) {
                this._mc = mc;
            }

            return this._mc;
        }

        public function addItem(item) {
            if ( ! this.itemExists(item) || this.hasItem(item) ) {
                return false;
            }
            this.obtainedItems.push(item);
            this._mc[item].visible = true;

        }

        public function removeItem(itemIndex) {
            var index = this.getIndex(itemIndex);
            this._mc[index].visible = false;
            this.obtainedItems.remove( index );
        }

        public function itemExists(itemName):Boolean {
            for (var item in this.itemList ) {
                if( item === itemName ) {
                    return true;
                }
            }

            return false;
        }


        public function hasItem(itemIndex) {
            if ( this.getIndex(itemIndex) > -1 ) {
                return true;
            } else {
                return false;
            }
        }

        public function getItem(itemIndex) {
            return this.obtainedItems[ this.getIndex(itemIndex) ];
        }


        public function useItem(itemName) {
            var item:Object = this.getItem(itemName);
        }

        private function getIndex(itemIndex) {
            if ( typeof( itemIndex ) == "number" ) {
                return itemIndex;
            }

            else if ( typeof( itemIndex ) == "string" ) {
                return findByName(itemIndex);
            }

            else if ( typeof ( itemIndex ) == "object" ) {
                return this.obtainedItems.indexOf(itemIndex);
            }
        }

        private function findByName(itemName:String) {
            for ( var index in this.obtainedItems ) {
                if ( this.obtainedItems[index].title.toLowerCase() === itemName.toLowerCase() ) {
                    return index;
                }
            }
            return -1;
        }
        
    }
}
