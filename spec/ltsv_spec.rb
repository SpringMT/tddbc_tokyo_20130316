class Ltsv
  def initialize
    # TODO data名前は後で返る
    @data = {}
  end
  def set(key, value)
  end

end


describe Ltsv do
  describe :set_data do
    context 'valid' do
      context '新しくkey valueを入れる' do
        subject { Ltsv.new }
        it do
          subject.set(:foo, "bar").should be_nil
          subject.dump.should eql("foo:bar\n")
        end
      end
      context '重複しているkeyに対してvalueを入れる' do
      end
      context 'valueが空文字' do
      end
    end
    context 'invalid' do
      context 'keyがnil' do
      end
      context 'keyが空文字' do
      end
      context 'valueがnil' do
      end
    end
  end
  describe :get do
  end
  describe :dump do
    context '' do
    end
    context '' do
    end
    context '' do
    end

  end
end



