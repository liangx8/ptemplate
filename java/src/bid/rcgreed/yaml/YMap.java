package bid.rcgreed.yaml;

import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;

public class YMap implements YamlBase {
    final private Map<YamlBase, YamlBase> map = new HashMap<>();

    public void putInt(YamlBase key, int val) {
        map.put(key, YamlBase.fromInt(val));
    }

    public void putFloat(YamlBase key, float val) {
        map.put(key, YamlBase.fromFloat(val));
    }

    public void putString(YamlBase key, String val) {
        map.put(key, YamlBase.fromString(val));
    }

    public void put(YamlBase key, YamlBase value) {
        map.put(key, value);
    }

    @Override
    public void dump(final YamlWriter print) throws YamlException {
        var keys=map.keySet();
        for(var k:keys){
            print.renderIndent();
            k.dump(print);
            map.get(k).dump(print);
        }
    }

}
