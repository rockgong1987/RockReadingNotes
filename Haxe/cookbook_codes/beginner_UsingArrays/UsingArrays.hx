class UsingArrays {
    static function main() {
        // print
        var arrayOfStrings:Array<String> = ["Apple", "Pear", "Banana"];
        trace(arrayOfStrings);

        var arrayOfFloats = [10.2, 40.5, 60.3];
        trace(arrayOfFloats);

        // comprehension
        var aInts = [for(i in 0...5) i];
        trace(aInts);
        var aEvens = [for(i in 0...5) i * 2];
        trace(aEvens);
        var aChars = [for(c in 65...70) String.fromCharCode(c)];
        trace(aChars);
        var x = 1;
        var aBits = [while(x < 128) x = x * 2];
        trace(aBits);

        // append
        var arrayOfStrings:Array<String> = [];
        arrayOfStrings.insert(0, "Hello");
        arrayOfStrings.unshift("Haxe");
        arrayOfStrings.push("World");
        arrayOfStrings = arrayOfStrings.concat(["foo", "bar"]);
        trace(arrayOfStrings);

        // remove
        var arrayOfStrings:Array<String> = ["first", "foo", "middle", "foo", "foo2", "foo3", "last"];
        arrayOfStrings.remove("middle");
        trace(arrayOfStrings);
        arrayOfStrings.splice(0, 3);
        trace(arrayOfStrings);
        arrayOfStrings.shift();
        trace(arrayOfStrings);
        arrayOfStrings.pop();
        trace(arrayOfStrings);

        // retrieve
        var arrayOfStrings:Array<String> = ["first", "foo", "middle", "foo", "last"];
        var first = arrayOfStrings[0];
        var last = arrayOfStrings[arrayOfStrings.length - 1];
        var firstOccurrence = arrayOfStrings[arrayOfStrings.indexOf("foo")];
        var lastOccurrence = arrayOfStrings[arrayOfStrings.lastIndexOf("foo")];
        trace(first);
        trace(last);
        trace(firstOccurrence);
        trace(lastOccurrence);

        // iterate
        for (item in arrayOfStrings) {
            trace("iteract item : " + item);
        }
        
        var a1 = ["a", "b", "c"];
        var a2 = [11, 22, 33];
        for (i in 0...a1.length) {
            trace(i + " : " + a1[i] + ", " + a2[i]);
        }

        // copy
        var list:Array<String> = ["first", "second", "last"];
        var copiedList = list.copy();
        copiedList.push("best");
        trace(list);
        trace(copiedList);

        // filter
        var list:Array<String> = ["apple", "pear", "banana"];
        var filteredList = list.filter(function (v) return v == "banana");
        trace(filteredList);

        // map
        var list:Array<String> = ["First", "Second", "Last"];
        var importantList = list.map(function (v) return v.toUpperCase());
        trace(importantList);
        var unimportantList = [for(v in list) v.toLowerCase()];
        trace(unimportantList);

        var list:Array<String> = ["1.1", "1.2", "1.3"];
        var listAsFloats:Array<Float> = list.map(Std.parseFloat);
        trace(listAsFloats);

        // reverse
        var list:Array<String> = ["first", "second", "last"];
        list.reverse();
        trace(list);

        // slice
        var list:Array<String> = ["first", "second", "last"];
        var slicedList = list.slice(1, 2);
        trace(slicedList);

        // sort
        var arrayOfInts:Array<Int> = [1, 5, 2, 4, 3];
        arrayOfInts.sort(function(a, b) return a - b);
        trace(arrayOfInts);

        // display
        var list:Array<String> = ["first", "second", "last"];
        var listJoined:String = list.join(" / ");
        trace(listJoined);
        var listAsString:String = list.toString();
        trace(listAsString);

        // multi-dimension
        var arrayTwoD:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0]];
        var arrayTwoD:Array<Array<Int>> = [for (x in 0...2) [for (y in 0...3) 0]];
        var arrayThreeD:Array<Array<Array<Int>>> = [
            [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
            [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
        ];
        trace(arrayTwoD[0][0]);
        trace(arrayThreeD[0][0][0]);
    }
}