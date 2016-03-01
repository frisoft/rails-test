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

def sale_factory
  sale = WithPassword.new(Sale.new({date: '20160227', time: '2012', code: 'AB', value: 12.99}))
  sale.password = 'strongpassword'
  sale.save!
  sale
end
