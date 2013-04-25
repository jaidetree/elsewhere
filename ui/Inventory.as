package environment.ui {
    public class Inventory {
        private var itemList:Array = [];

        public function Inventory() {
        }

        public function addItem(item) {
            this.itemList.push(item);
        }

        public function removeItem(itemIndex) {
            this.itemList.remove( this.getIndex(itemIndex) );
        }


        public function hasItem(itemIndex) {
            if ( this.getIndex(itemIndex) > -1 ) {
                return true;
            } else {
                return false;
            }
        }

        public function getItem(itemIndex) {
            return this.itemList[ this.getIndex(itemIndex) ];
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
                return this.itemList.indexOf(itemIndex);
            }
        }

        private function findByName(itemName:String) {
            for ( var index in this.itemList ) {
                if ( this.itemList[index].title.toLowerCase() === itemName.toLowerCase() ) {
                    return index;
                }
            }
            return -1;
        }
        
    }
}
