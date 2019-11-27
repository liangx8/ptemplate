package bid.rcgreed.yaml;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

public class YDict implements YamlBase {
    private static class YPair {
        public YamlBase key;
        public YamlBase val;
    }

    private static YPair newPair(YamlBase key, YamlBase value) {
        var pair = new YPair();
        pair.key = key;
        pair.val = value;
        return pair;
    }

    final private List<YPair> data = new ArrayList<>();

    public void addInt(YamlBase k, int val) {
        data.add(newPair(k, YamlBase.fromInt(val)));
    }

    @Override
    public void dump(YamlWriter print) throws YamlException{
        for(var it : data){
            print.renderIndent();
            var promoted=print.promoted();
            it.key.dump(promoted);
            promoted.done();
            promoted=print.promoted();
            it.val.dump(promoted);
            promoted.done();
        }
    }

}