#encoding: utf-8
require_relative "abc123/version"
require 'green_shoes'

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
    title "UČI SE Z MANO", align: "center"

    flow do
      image("../images/horse.png", height: 200, width: 200)
      math = subtitle "ŠTEVILKE IN ČRKE", margin: 40, align: "center"

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




    ######################################
    # Preparation flow start             #
    ######################################
      @prep_flow = flow do
        @numbers_addition = [0,1,2,3,4,5]
        @all_images = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
        image("../images/home.png", height: 80, width: 80, margin_right: 80).click{visit '/'}

        image("../images/math.png", height: 80, width: 80).click{
          @input_1 = @numbers_addition.sample.to_s
          @input_2 = @numbers_addition.sample.to_s

          @expression_flow.clear
          @solution_flow.clear
          @expression_flow.append do
            image("../images/#{@input_1}.png", margin_right: 15, height: 60, width: 60)
            image("../images/add.png", margin_right: 15, height: 60, width: 60)
            image("../images/#{@input_2}.png", margin_right: 15, height: 60, width: 60)
            image("../images/equals.png", margin_right: 15, height: 60, width: 60)
            image("../images/question.png", margin_right: 15, height: 60, width: 60)
          end

          @result = @input_1.to_i + @input_2.to_i

          @solution_flow.append do
            title "IZBERI PRAVILEN ODGOVOR:", margin_top: 25,margin_bottom: 25, :align => "center"
            @all_images.each do
              |img| image("../images/#{img}.png", margin_right: 30, margin_bottom: 30, height: 70, width: 70).click{
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

        @words_images = ["MAČKA", "PES", "VLAK", "ŽOGA"]
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
          image "../images/#{@word_sample}.png", height: 250, width: 250
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
