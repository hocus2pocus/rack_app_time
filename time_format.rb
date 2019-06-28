class TimeFormat

  attr_reader :wrong_format

  VALID_FORMATS = {
   'year' => '%Y',
   'month' => '%m',
   'day' => '%d',
   'hour' => '%H',
   'minute' => '%M',
   'second' => '%S'
  }

  def initialize(time_format)
    @time_format = time_format
    @wrong_format = []
    @correct_format = []
    check_format
  end

  def call
    @correct_format.map { |v| Time.now.strftime(VALID_FORMATS[v]) }.join("-")
  end

  def check_format
    @time_format.each do |v|
      VALID_FORMATS.include?(v) ? @correct_format << v : @wrong_format << v
    end
  end

  def wrong_format?
    @wrong_format.any?
  end
end
