class Analytics

  def query(wordpress_id, start_date = Date.today - 1.year, end_date = Date.today)
    params = {
       "ids"         => "ga:93927784",
       "start-date"  => start_date.to_s,
       "end-date"    => end_date.to_s,
       "metrics"     => "ga:sessions,ga:pageviews,ga:uniquePageviews,ga:pageviewsPerSession,ga:avgTimeOnPage,ga:users",
       "filters"     => "ga:pagePath=~/#{wordpress_id}/[\\d+/]*$"
      }
    run_query(params).data.rows[0]
  end

  private

  def client
    @client ||= authorize
  end

  def authorize
    require 'google/api_client'
    client = Google::APIClient.new(:application_name => 'dailysuperheroes reports', :application_version => '1')
    key = Google::APIClient::PKCS12.load_key('config/dailysuperheroes reports-346401e64e58.p12', 'notasecret')
    service_account = Google::APIClient::JWTAsserter.new(
        '378604526763-ll6lgtaa5sf0mgv7r5lul3091e76rh48@developer.gserviceaccount.com',
        ['https://www.googleapis.com/auth/analytics.readonly', 'https://www.googleapis.com/auth/prediction'],
        key
      )
    client.authorization = service_account.authorize
    client
  end

  def analytics
    analytics ||= client.discovered_api('analytics', 'v3')
  end

  def run_query(params)
    client.execute(:api_method => analytics.data.ga.get, :parameters => params)
  end
end
