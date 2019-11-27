package bid.rcgreed.yaml;

import java.util.ArrayList;
import java.util.List;

public class YamlArray implements YamlBase {
    private final List<YamlBase> data=new ArrayList<>();
    public void add(YamlBase obj){
        data.add(obj);
    }
    public void addInt(int val){
        data.add(YamlBase.fromInt(val));
    }
    public void addString(String val){
        data.add(YamlBase.fromString(val));
    }
    @Override
    public void dump(YamlWriter writer) throws YamlException {
        for(var yb: data){
            writer.renderIndent();
            var promoted=writer.promoted();
            yb.dump(promoted);
            promoted.done();
        }
    }


}