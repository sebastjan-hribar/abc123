#encoding: utf-8
require_relative "abc123/version"
require_relative "abc123/helpers_math.rb"
require 'green_shoes'

include Helpers

module Abc123

class Learn < Shoes
  url '/',                         :index
  url '/learn_math',               :learn_math
  url '/learn_words',              :learn_words

#####################
# index url start   #
#####################
  def index

    background cornsilk

    flow do
      image("../images/education.png", height: 300, width: 300, margin_left: 330)
    end
    
    flow do
      image("../images/maths.png", height: 150, width: 150, margin_right: 20).click{visit '/learn_math'}
      image("../images/abc.png", height: 150, width: 150).click{visit '/learn_words'}
    end
  end
#####################
# index url end     #
#####################


############################
# learn addition url start #
############################
  def learn_math

    background cornsilk

        #@numbers = (0..9)
        @all_images = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    ######################################
    # Preparation flow start             #
    ######################################
      @prep_flow = flow do

        image("../images/add.png", height: 80, width: 80).click{
          @operator = "add"
        }
        image("../images/subtract.png", height: 80, width: 80).click{
          @operator = "subtract" 
        }
        image("../images/multiply.png", height: 80, width: 80).click{
          @operator = "multiply" 
        }
        image("../images/divide.jpg", height: 120, width: 120).click{
          @operator = "divide" 
        }

        image("../images/home.png", height: 80, width: 80, margin_right: 80).click{visit '/'}

        image("../images/math.png", height: 80, width: 80).click{
          
          
          @input_1 = input1
          @input_2 = input2

          @expression_flow.clear
          @solution_flow.clear
          @expression_flow.append do
            image("../images/numbers/#{@input_1.to_s}.png", margin_right: 15, height: 60, width: 60)
            image("../images/#{@operator}.png", margin_right: 15, height: 60, width: 60)
            image("../images/numbers/#{@input_2.to_s}.png", margin_right: 15, height: 60, width: 60)
            image("../images/equals.png", margin_right: 15, height: 60, width: 60)
            image("../images/question.png", margin_right: 15, height: 60, width: 60)
          end

          @result = -1
          while @result < 0 do
            @result = compute(@operator, @input_1, @input_2)
          end
          @solution_flow.append do
            title "IZBERI PRAVILEN ODGOVOR:", margin_top: 25,margin_bottom: 25, :align => "center"
            @all_images.each do
              |img| image("../images/numbers/#{img}.png", margin_right: 30, margin_bottom: 30, height: 70, width: 70).click{
              @solution = img.to_i
                if @result == @solution
                  @right_answers.append do
                    image "../images/right.png"
                  end
                else
                  @wrong_answers.append do
                    image "../images/wrong.png"
                  end
                end
              @expression_flow.clear
              @solution_flow.clear
              }
            end
          end
        }
      end
    ######################################
    # Preparation flow end               #
    ######################################


    ######################################
    # Calculation flow start             #
    ######################################
      @calc_flow = flow margin_top: 50, margin_bottom: 50 do
        @expression_flow = flow do
        end
      end
    ######################################
    # Calculation flow end               #
    ######################################


    ######################################
    # Solution flow start                #
    ######################################
      @solution_flow = flow do
      end
    ######################################
    # Solution flow end                  #
    ######################################


    ######################################
    # Rewards flow start                 #
    ######################################
      @rewards_flow = flow  margin: 10 do
        subtitle "NAGRADE", :align => "center"

        @right_answers = flow do
        border black
        end

        @wrong_answers = flow do
        border black
        end

      end
    ######################################
    # Rewards flow end                   #
    ######################################

  end
############################
# learn addition url end   #
############################


############################
# learn words url start    #
############################
    def learn_words
      background cornsilk
    ######################################
    # Words preparation flow start       #
    ######################################
      @words_prep_flow = flow do
        image("../images/home.png", height: 80, width: 80, margin_right: 20).click{visit '/'}

        @words_images = Dir.entries("../images/letters").each {|word| word.gsub!(".png", "")}
        @words_images.delete(".")
        @words_images.delete("..")
        @word_sample = @words_images.sample
        @word_letters = []
        @alphabet = ["A", "B", "C", "Č", "D", "E", "F", "G", "H", "I", "J", "K",
         "L", "M", "N", "O", "P", "R", "S", "Š", "T", "U", "V", "X", "Y", "Z", "Ž"]
      end
    ######################################
    # Words preparation flow end         #
    ######################################


    ######################################
    # Sample word image flow start       #
    ######################################
      @sample_flow = flow do
        image "../images/letters/#{@word_sample}.png", margin_bottom: 15, height: 200, width: 200
      end
    ######################################
    # Sample word image flow end         #
    ######################################

      flow do
        @alphabet.each do
          |letter| button letter, height: 50, width: 50 do
              @word_letters << letter
              @word_display.append do
                subtitle letter, height: 50, width: 30
              end
          end
        end
      end

      image("../images/go.png", height: 100, width: 100, margin_right: 20).click{
        @word_input = @word_letters.join
          if @word_input == @word_sample
            @word_right_answers.append do
              image "../images/right.png"
            end
          else
            @word_wrong_answers.append do
              image "../images/wrong.png"
            end
          end
          @word_letters = []
          @word_input = ""
          @word_solution_flow.append{subtitle @word_sample, margin_top: 20, height: 50, width: 150}
          }

      image("../images/restart.png", height: 100, width: 100).click{
        @sample_flow.clear
        @word_display.clear
        @word_solution_flow.clear
        @word_sample = @words_images.sample
        @sample_flow.append do
          image "../images/letters/#{@word_sample}.png", height: 250, width: 250
        end
      }


    ######################################
    # Input display flow start           #
    ######################################
      @input_display = flow do
        background lightblue
        subtitle "ČRKE", :align => "center"
        @word_display = flow do
        end
        @word_solution_flow = flow do
        end
      end
    ######################################
    # Input display flow end             #
    ######################################


    ######################################
    # Word Rewards flow start            #
    ######################################
      @word_rewards_flow = flow margin: 10 do
        subtitle "NAGRADE", :align => "center"

        @word_right_answers = flow do
        border black
        end

        @word_wrong_answers = flow do
        border black
        end

      end
    ######################################
    # Word Rewards flow en               #
    ######################################

    end
############################
# learn words url end      #
############################

end #class Shoes end

  Shoes.app title: "Abc123", height: 1000, width: 850

end # module Abc123 end
