String.class_eval do
  def compress
    squish.gsub('> <', '><')
  end
end
