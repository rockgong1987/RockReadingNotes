# Haxe Programming cookbook
## Beginner  
### Using arrays
#### Creation
    var arrayOfStrings:Array<String> = ["Apple", "Pear", "Banana"];
    trace(arrayOfStrings);

    var arrayOfFloats = [10.2, 40.5, 60.3];
    trace(arrayOfFloats);
#### Array comprehension
    var aInts = [for(int in 0...5) i];
    trace(aInts); // [0,1,2,3,4]

    var aEvens = [for(i in 0...5) i*2];
    trace(aEvents); // [0,2,4,6,8]

    var aChars = [for(c in 65...70) String.fromCharCode(c)];
    trace(aChars); // ['A','B','C','D','E']

    var x = 1;
    var aBits = [while(x < 128) x = x * 2]
    trace(aBits); // [2,4,8,16,32,64,128]
#### Adding elements
    var arrayOfStrings:Array<String> = [];
    arrayOfStrings.insert(0, "Hello");
    arrayOfStrings.unshift("Haxe");
    arrayOfString.push("World");