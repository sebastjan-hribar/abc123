#encoding: utf-8
require_relative "abc123/version"
require 'green_shoes'
require 'nkf'

module Abc123

class Learn < Shoes
  url '/',                          :index
  url '/learn_addition',            :learn_addition
  url '/learn_words',               :learn_words

#####################
# index url start   #
#####################
  def index

    background cornsilk
    title "Uči se z mano", align: "center"

    flow do
      image("../images/horse.png", height: 200, width: 200)
      math = subtitle "Številke in črke", margin: 40, align: "center"

      image("../images/maths.png", height: 150, width: 150, margin_right: 20).click{visit '/learn_addition'}

      image("../images/abc.png", height: 150, width: 150).click{visit '/learn_words'}
    end
  end
#####################
# index url end     #
#####################


############################
# learn addition url start #
############################
  def learn_addition

    background cornsilk

      image("../images/home.png", height: 80, width: 80, margin_right: 20).click{visit '/'}


    ######################################
    # Preparation flow start             #
    ######################################
      @prep_flow = flow do
        @numbers_addition = [0,1,2,3,4,5]
        @all_images = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

        image("../images/math.png", height: 60, width: 60).click{
          @input_1 = @numbers_addition.sample.to_s
          @input_2 = @numbers_addition.sample.to_s

          @expression_flow.clear
          @solution_flow.clear
          @expression_flow.append do
            image("../images/#{@input_1}.png", height: 60, width: 60)
            image("../images/add.png", height: 60, width: 60)
            image("../images/#{@input_2}.png", height: 60, width: 60)
            image("../images/equals.png", height: 60, width: 60)
            image("../images/question.png", height: 60, width: 60)
          end

          @result = @input_1.to_i + @input_2.to_i

          @solution_flow.append do
            subtitle "Izberi pravilen odgovor:", margin: 15, :align => "center"
            @all_images.each do
              |img| image("../images/#{img}.png", margin: 20, height: 50, width: 50).click{
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
      @calc_flow = flow margin_top: 20 do
        @expression_flow = flow margin_left: 15 do
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
        subtitle "Nagrade", :align => "center"

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

        @words_images = ["mačka", "pes", "vlak", "žoga"]
        @word_sample = @words_images.sample
        @word_letters = []
        @alphabet = ["A", "B", "C", "Č", "D", "E", "F", "G", "H", "I", "J", "K",
         "L", "M", "N", "O", "P", "R", "S", "Š", "T", "U", "V", "Z", "Ž"]
      end
    ######################################
    # Words preparation flow end         #
    ######################################


    ######################################
    # Sample word image flow start       #
    ######################################
      @sample_flow = flow do
        image "../images/#{@word_sample}.png", margin_bottom: 15, height: 200, width: 200
      end
    ######################################
    # Sample word image flow end         #
    ######################################

      flow do
        @alphabet.each do
          |letter| button letter, height: 80, width: 80 do
              @word_letters << letter
              @input_display.append do
                flow do
                  para letter
                end
              end
          end
        end
      end

      image("../images/go.png", height: 100, width: 100, margin_right: 20).click{
        @word_input = @word_letters.join
        alert @word_input.downcase
          if @word_input == @word_sample.upcase
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
          }

      image("../images/restart.png", height: 100, width: 100).click{
        @sample_flow.clear
        @input_display.clear
        @word_sample = @words_images.sample
        @sample_flow.append do
          image "../images/#{@word_sample}.png", height: 250, width: 250
        end
      }


    ######################################
    # Input display flow start           #
    ######################################
      @input_display = flow do
        subtitle "Črke", :align => "center"
      end
    ######################################
    # Input display flow end             #
    ######################################


    ######################################
    # Word Rewards flow start            #
    ######################################
      @word_rewards_flow = flow  margin: 10 do
        subtitle "Nagrade", :align => "center"

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
