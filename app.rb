require 'sinatra'
require 'sinatra/reloader' if development?
require_relative File.expand_path('lib/company.rb', __dir__)

configure do
  @path = 'lib/subscribers.csv'
  set :company, Company.new(File.expand_path(@path, __dir__))
end

get '/' do
  erb :index
end

get '/all' do
  @subscribers = settings.company.all_subscribers
  @title = 'Subscribers'
  erb :all
end

get '/nolimit' do
  @subscribers = settings.company.get_subscribers_by_tarif(1)
  @title = 'Subscribers with no limits'
  erb :all
end

get '/combined' do
  @subscribers = settings.company.get_subscribers_by_tarif(2)
  @title = 'Subscribers with combined'
  erb :all
end

get '/by_time' do
  @subscribers = settings.company.get_subscribers_by_tarif(3)
  @title = 'Subscribers by time'
  erb :all
end

get '/by_name' do
  if params['name']
    @title = params['name']
    @title = "Subscribers with name #{'"' + params['name'] + '"'}"
    @arr = params['name'].split(' ')
    @sub = { 'firstName' => @arr[0], 'lastName' => @arr[1] }
    @subscribers = settings.company.find_subscriber_by_name(@sub)
    @subscribers ||= 'Can\'t find subscribers with such name'

    erb :all
  else
    @type = 'name'
    erb :search
  end
end

get '/by_phone' do
  if params['phone']
    @title = "Subscribers with phone #{'"' + params['phone'] + '"'}"
    @num = Integer(params['phone'])
    @subscribers = settings.company.find_subscriber_by_number(@num)

    erb :all
  else
    @type = 'phone'
    erb :search
  end
end

get '/payment' do
  if params['phone'] && params['minutes']
    @phone = Integer(params['phone'])
    @minutes = Integer(params['minutes'])
    @sum = settings.company.calc_receipt(@phone, @minutes)
  end
  erb :receipt
end

get '/add' do
  erb :add
end

post '/add' do
  if params['first'] && params['last'] && params['tarif']
    @title = 'User added'
    @sub = { 'firstName' => params['first'], 'lastName' => params['last'],
             'tarif' => Integer(params['tarif']) }
    @number = settings.company.add_subscriber
    @subscribers = settings.company.find_subscriber_by_number(@number)
    erb :all
  end
end

get '/delete' do
  if params['name']
    @title = 'Subscribers deleted'
    @arr = params['name'].split(' ')
    @sub_h = { 'firstName' => @arr[0], 'lastName' => @arr[1] }
    @subscribers = settings.company.find_subscriber_by_name(@sub_h)
    @subscribers ||= 'Can\'t find subscribers with such name'
    settings.company.delete_subscriber(@sub_h)
    erb :all
  else
    @type = 'name'
    @action = 'Delete'
    erb :search
  end
end
