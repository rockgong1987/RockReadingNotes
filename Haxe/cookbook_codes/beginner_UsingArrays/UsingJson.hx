typedef MyStruct = {
    name : String,
    age : Int,
    height : Float,
    nickname : Array<String>
}

class UsingJson {
    static function main() {
        var mys : MyStruct = {
            name : "Rock",
            age : 33,
            height : 170.0,
            nickname : ["Rooster", "Worker"]
        };
        var jsonString : String = haxe.Json.stringify(mys);
        trace(jsonString);

        var mys2 : MyStruct = haxe.Json.parse(jsonString);
        trace(mys2);

        trace(mys2.name);
        trace(mys2.age);
        trace(mys2.height);
        trace(mys2.nickname);
        for (nn in mys2.nickname) {
            trace(nn);
        }
    }
}