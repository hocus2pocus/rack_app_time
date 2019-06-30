class App

  HEADERS = { 'Contetnt-Type' => 'text/plain' }

  def call(env)
    @request = Rack::Request.new(env)

    case @request.path_info
    when "/time"
      time_response
    else
      not_found_response
    end
  end

  private

  def time_response
    @format = TimeFormat.new(@request.params["format"].split(','))
    response = @format.call

    if response
      status, body = 200, ["#{response}\n"]
    else
      status, body = 400, ["Unknown time format #{@format.wrong_format}\n"]
    end

    Rack::Response.new(body, status, HEADERS).finish
  end

  def not_found_response
    [404, HEADERS, ["Unknown route [#{@request.path_info}]\n"]]
  end
end
