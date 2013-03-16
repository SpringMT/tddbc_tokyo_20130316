class Ltsv
  def initialize
    # TODO data名前は後で返る
    @data = {}
  end
  def set(key, value)
    raise ArgumentError if key.nil? || key.empty? || value.nil?

    case key
    when String
      key = key.to_sym
    when Symbol
      key
    else
      raise ArgumentError, 'key is String or Symbol'
    end

    if @data.key? key
      @data.delete key
    end
    @data[key] = value
    nil
  end

  def get(key)
    @data[key]
  end

  def dump
    list = @data.inject([]) do |init, (key, val)|
      val.gsub!(/\t/, "\\t")
      val.gsub!(/\:/, "\\:")
      val.gsub!(/\n/, "\\n")
      init << "#{key}:#{val}"
    end
    ltsv_str = list.join "\t"
    "#{ltsv_str}\n"
  end
end


