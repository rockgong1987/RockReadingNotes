class UsingDate {
    static function main() {
        var dn : Date = Date.now();

        trace(dn);
        trace(dn.getSeconds()); // 0~59
        trace(dn.getMinutes()); // 0~59
        trace(dn.getHours()); // 0~23
        trace(dn.getDate()); // 1~31
        trace(dn.getDay()); // 0~6
        trace(dn.getMonth()); // 0~11
        trace(dn.getFullYear()); // 4-digit

        trace(DateTools.format(dn, "%Y-%m-%d_%H:%M:%S"));
        trace(DateTools.format(dn, "%r"));
        trace(DateTools.format(dn, "%T"));
        trace(DateTools.format(dn, "%F"));
        trace(DateTools.format(dn, "%b %d, %Y"));

        // calculate with date
        var dayInMs = 24 * 60 * 60 * 1000;
        var today = dn;
        var yesterday = DateTools.delta(today, -dayInMs);
        var tomorrow = DateTools.delta(today, dayInMs);
        var nextWeek = DateTools.delta(today, dayInMs * 7);
        trace("today : ", today);
        trace("yesterday : ", yesterday);
        trace("tomorrow : ", tomorrow);
        trace("nextWeek : ", nextWeek);
    }
}