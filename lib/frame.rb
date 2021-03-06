# frozen_string_literal: true

# Frame class
class Frame
  STRIKE = 10
  SPARE = 10
  TOTAL_NUMBER_OF_FRAMES = 10

  attr_reader :number
  attr_accessor :roll_one, :roll_two, :bonus_roll, :score

  def initialize(number)
    @number = number
    @roll_one = nil
    @roll_two = nil
    @bonus_roll = nil
    @score = 0
  end

  def calculate_score
    @score = if tenth_frame?
               calculate_tenth_frame_score
             else
               calculate_regular_frame_score
             end
  end

  def strike?
    roll_one == STRIKE
  end

  def spare?
    !strike? && roll_one + roll_two == SPARE
  end

  def spare_or_strike?
    spare? || strike?
  end

  def finished?
    if tenth_frame?
      tenth_frame_finished?
    else
      strike? || !roll_two.nil?
    end
  end

  def tenth_frame?
    number == 10
  end

  private

  def tenth_frame_finished?
    return false if roll_two.nil?
    return true unless spare_or_strike?

    !bonus_roll.nil?
  end

  def calculate_tenth_frame_score
    if finished?
      roll_one + roll_two + (bonus_roll.nil? ? 0 : bonus_roll)
    elsif !roll_two.nil?
      roll_one + roll_two
    else
      roll_one
    end
  end

  def calculate_regular_frame_score
    if finished? && !strike?
      roll_one + roll_two
    else
      roll_one
    end
  end
end
