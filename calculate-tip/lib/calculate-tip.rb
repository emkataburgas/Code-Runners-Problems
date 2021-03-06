#!/usr/bin/env ruby

require 'optparse'
require 'rest-client'
require 'json'

options = {}
options[:amount] = 0
options[:tip] = 15
show_flag = true

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage of calculate-tip"
  opt.separator "Exaple command:"
  opt.separator " calculate-tip --amount 10 --tip 5"
  opt.separator "Returns"
  opt.separator " Total amount with tip: 10.5"
  opt.separator " Tip amount: 0.5"
  opt.separator "Options:" 
        
  show_flag = false if ARGV.include?("--help")
  number_of_args = ARGV.size
 

  opt.on("--amount BILL", Float, "Amount of the bill. It is mandatory and must be positive.") do |bill|
    if bill > 0 
      options[:amount] = bill 
    else 
      puts "Amount cannot be negative or 0."
      show_flag = false
    end
  end

  opt.on("--tip PERCENT", Float, "Tip(%), must be positive. The default value is 15%.") do |percent| 
    if percent >= 0   
      options[:tip] = percent 
    else
      puts "Tip cannot be negative."
      show_flag = false
    end
  end

  opt.on("--help", "Help") do
    puts opt
  end

  opt.parse!
      
  if number_of_args == 0
    show_flag = false

    puts "Please provide amount: "
    amount = gets.chomp
    puts "Please provide tip (%): "
    tip = gets.chomp
    
    if tip == ""
      tip = 15 
    else
      tip = tip.to_i
    end

    amount, currency = amount.split(' ')
    amount = amount.to_i

    response = RestClient.post 'http://office.code-runners.com:8888', {:amount => amount, :tip => tip}
    response_hash = JSON.parse(response)


    def show(amount_with_tip, tip, currency = nil)
      puts "Total amount with tip: #{amount_with_tip} #{currency}"
      tip_rounded = tip.round(1)
      puts "Tip amount: #{tip_rounded} #{currency}"
    end

    if amount > 0 and tip >= 0
      show(response_hash["amount_with_tip"], response_hash["tip"], currency)
    else 
      puts "Please enter valid values."
    end 
  end

  if show_flag
    response = RestClient.post 'http://office.code-runners.com:8888', {:amount => options[:amount], :tip => options[:tip]}
    response_hash = JSON.parse(response)


  def show(amount_with_tip, tip)
    puts "Total amount with tip: #{amount_with_tip}"
    puts "Tip amount: #{tip}"
  end

  show(response_hash["amount_with_tip"], response_hash["tip"]) 
  end
end

