class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    delete_enter = @text.gsub("\\n", "")
    delete_spaces = delete_enter.gsub(" ", "")
    @character_count_without_spaces = delete_spaces.length

    @word_count = @text.split.count

    list_words = @text.split
    occurence_count = 0
    list_words.each do |word|
      if word.downcase == @special_word.downcase
        occurence_count = occurence_count + 1
      end
    end

    @occurrences = occurence_count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    effective_interest_rate = @apr / (100*12)

    total_no_payments = @years * 12


    @monthly_payment = @principal * (effective_interest_rate / (1 - (1 + effective_interest_rate)**(- total_no_payments)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @hours/((365 * 24) + 6)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum - @minimum

    median = @numbers[0]
    halfway = @count / 2

    if @count.even?
      median = (@sorted_numbers[halfway - 1] + @sorted_numbers[halfway])/2
    else
      median = @sorted_numbers[halfway]
    end

    @median = median


    @sum = @numbers.sum

    @mean = @sum / @count

    calculate_var_list = []

    @numbers.each do |num|
      calculate_var_list.push((num - @mean)**2)
    end

    @variance = calculate_var_list.sum / (@count)

    @standard_deviation = Math.sqrt(@variance)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    mode = @numbers.max_by { |v| freq[v] }

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
