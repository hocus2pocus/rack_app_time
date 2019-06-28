class App
  def call(env)
    @request = Rack::Request.new(env)
    @format = TimeFormat.new(@request.params["format"].split(','))
    [status, headers, body]
  end

  private

  def status
    @format.wrong_format? ? 400 : wrong_status? ? 200 : 404
  end

  def headers
    { 'Contetnt-Type' => 'text/plain' }
  end

  def body
    a = []

    case status
    when 200
      a << "#{@format.call}\n"
    when 400
      a << "Unknown time format #{@format.wrong_format}\n"
    when 404
      a << "Unknown route [#{@request.path_info}]\n"
    end

  end

  def wrong_status?
    @request.path_info == "/time"
  end
end
