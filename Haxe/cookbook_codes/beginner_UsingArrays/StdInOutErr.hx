class StdInOutErr {
    static function main() {
        var line = Sys.stdin().readLine();
        trace(line);
        Sys.println(line);
        Sys.stderr().writeString(line);
    }
}