# Google Analytics server-side ruby wrapper

[https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide]()

## Usage

### Events

      GoogleAnalytics.new.event({
        category: 'Payment',
        action: 'Pay',
        label: 'Pay Now',
        value: 4
      })
      
### Pageviews
      
      GoogleAnalytics.new.pageview({
        path: '/landing',
        title: 'Exclusive Offer',
        source: 'Weekly Campaign',
        medium: 'Email'
      })
      
### Appviews
      
      GoogleAnalytics.new.appview({
        app_name: 'Mobile',
        app_version: '1.0.0',
        screen_name: 'First Launch Tutorial'
      })
      
### Transactions
      
      GoogleAnalytics.new.transaction({
        id: 7,
        affiliation: 'Credit Card',
        price: 9.95,
        currency: 'USD'
      })
      
### Items
      
      GoogleAnalytics.new.item({
        id: 7,
        price: 9.95,
        sku: 'llama_kiss',
        name: 'Llama Kiss',
        category: 'Fun'
      })
      
      
      
