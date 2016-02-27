def sales_params
  {
    sales: [
      {
        date: '20140103',
        time: '0700',
        code: 'FL',
        value: '2.00'
      },
      {
        date: '20140103',
        time: '0815',
        code: 'DO',
        value: '1.00'
      }
    ]
  }
end

def single_sale_params
  {
    sales: {
      date: '20140103',
      time: '0700',
      code: 'FL',
      value: '2.00'
    }
  }
end

def json_response
  JSON.parse(response.body)
end
