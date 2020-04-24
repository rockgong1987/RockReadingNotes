class UsingFileSystem {
    static function main() {
        var anotherHaxeCode = sys.io.File.getContent("UsingDate.hx");
        trace(anotherHaxeCode);
    }
}