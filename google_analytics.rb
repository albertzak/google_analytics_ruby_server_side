class GoogleAnalytics

  def initialize(profile)
    @version = 1
    @profile = "UA-XXXXXXXX-X"
    @endpoint = "http://www.google-analytics.com/collect"
  end

  def event(attributes, uid=nil)
    attributes = transform(attributes, {
      category:        :ec,
      action:          :ea,
      label:           :el,
      value:           :ev,
      source:          :cs,
      medium:          :cm,
    })

    track({t: 'event'}.merge(attributes), uid)
  end

  def pageview(attributes, uid=nil)
    attributes = transform(attributes, {
      path:            :dp,
      title:           :dt,
      source:          :cs,
      medium:          :cm,
    })

    track({t: 'pageview'}.merge(attributes), uid)
  end

  def appview(attributes, uid=nil)
    attributes = transform(attributes, {
      app_name:        :an,
      app_version:     :av,
      screen_name:     :cd,
      medium:          :cm,
    })

    track({t: 'appview'}.merge(attributes), uid)
  end

  def transaction(attributes, uid=nil)
    attributes = transform(attributes, {
      id:              :ti,
      affiliation:     :ta,
      price:           :tr,
      currency:        :cu,
      source:          :cs,
      medium:          :cm,
    })

    track({t: 'transaction'}.merge(attributes), uid)
  end

  def item(attributes, uid=nil)
    attributes = transform(attributes, {
      id:              :ti,
      price:           :ip,
      quantity:        :iq,
      sku:             :ic,
      name:            :in,
      category:        :iv,
      currency:        :cu,
      source:          :cs,
      medium:          :cm,
    }, {
      quantity:        1,
      currency:        'USD',
    })

    track({t: 'item'}.merge(attributes), uid)
  end

  private

  def merge(a, b)
    b.blank? ? a : a.merge(b) 
  end

  def transform(hash, keymap, defaults={})
    out = Hash.new

    defaults.each do |k, v|
      next if hash.has_key?(k)
      pair = Hash.new
      pair[k] = v
      hash.merge!(pair)
    end
    
    hash.each_pair do |k, v|
      pair = Hash.new
      k = keymap[k.to_sym]      
      pair[k] = v
      out.merge!(pair)
    end

    out
  end

  def track(params, uid=nil)
    if uid.blank?
      params.merge!({
        cd1: 'anonymous'
      })
    else
      params.merge!({
        cd1: uid,
      })
    end

    post(required.merge(params))
  rescue StandardError => e
    puts e.backtrace
  end

  def post(payload)
    RestClient.post(@endpoint, payload, timeout: 4, open_timeout: 4) and true
  rescue  RestClient::Exception => e
    false
  end

  def required
    {
      v: @version,
      tid: @profile,
      cid: 0
    }
  end

end
