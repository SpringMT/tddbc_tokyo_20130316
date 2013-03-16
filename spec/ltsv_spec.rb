require __dir__ + '/spec_helper'

describe Ltsv do
  let(:ltsv) { Ltsv.new }
  describe :set do
    context 'valid' do
      context '新しくkey valueを入れる' do
        it do
          ltsv.set(:foo, "bar").should be_nil
          # TODO
          ltsv.instance_variable_get(:@data).should eql({foo: "bar"})
        end
      end
      context '重複しているkeyに対してvalueを入れる' do
        it do
          ltsv.set(:aaa, "foo")
          ltsv.set(:aaa, "foofoo")
          ltsv.instance_variable_get(:@data).should eql({aaa: "foofoo"})
        end
      end
      context '重複しているkeyに対してvalueを入れる (データの順番変わる)' do
        it do
          ltsv.set(:aaa, "foo")
          ltsv.set(:bbb, "bar")
          ltsv.set(:aaa, "foofoo")
          ltsv.instance_variable_get(:@data).should eql({bbb: "bar", aaa: "foofoo"})
        end
      end
      context 'valueが空文字' do
        it do
          ltsv.set(:aaa, "")
          ltsv.instance_variable_get(:@data).should eql({aaa: ""})
        end
      end
      context 'stringがkeyに来たときはkeyをsymbolに変換する' do
        it do
          ltsv.set("aaa", "bbb")
          ltsv.instance_variable_get(:@data).should eql({aaa: "bbb"})
        end
      end
    end
    context 'invalid' do
      context 'keyがnil' do
        it { expect { ltsv.set(nil, "foo") }.to raise_error ArgumentError }
      end
      context 'keyが空文字' do
        it { expect { ltsv.set("", "foo") }.to raise_error ArgumentError }
      end
      context 'valueがnil' do
        it { expect { ltsv.set("foo", nil) }.to raise_error ArgumentError }
      end
    end
  end

  describe :get do
    context 'valid' do
      context 'symbol' do
        it do
          ltsv.instance_variable_set(:@data, {aaa: "foo"})
          ltsv.get(:aaa).should be_eql "foo"
        end
      end
    end
    context 'invalid' do
      context 'keyがない' do
        it do
          ltsv.get(:aaa).should be_nil
        end
      end
    end
  end

  describe :dump do
    shared_examples_for :dump do |input, output_str|
      it do
        ltsv.instance_variable_set(:@data,  input)
        ltsv.dump.should eql(output_str)
      end
    end
    context "1つ" do
      it_behaves_like :dump, {aaa: "foo"}, "aaa:foo\n"
    end
    context "2つ" do
      it_behaves_like :dump, {aaa: "foo", bbb: "bar"}, "aaa:foo\tbbb:bar\n"
    end
    context 'tab' do
      it_behaves_like :dump, {aaa: "foo", bbb: "\t"}, "aaa:foo\tbbb:\\t\n"
    end
    context ':' do
      it_behaves_like :dump, {aaa: "foo", bbb: ":"}, "aaa:foo\tbbb:\\:\n"
    end
    context '\n' do
      it_behaves_like :dump, {aaa: "foo", bbb: "\n"}, "aaa:foo\tbbb:\\n\n"
    end

  end
end



