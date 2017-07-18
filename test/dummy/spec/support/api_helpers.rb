module ApiHelpers
  def api(path, user = nil)
    "/api/#{Api.version}#{path}" +

      # Normalize query string
      (path.index('?') ? '' : '?') +

      # Append private_token if given a User object
      (user.respond_to?(:global_login_token) ?
        "&global_login_token=#{user.global_login_token}" : "")
  end

  def json_response
    @_json_response ||= JSON.parse(response.body)
  end
end
