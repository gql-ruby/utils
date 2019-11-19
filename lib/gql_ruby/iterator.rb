require 'dry/initializer'
require 'dry/monads'
require 'pry'

module GqlRuby
  class Iterator
    extend Dry::Initializer
    include Dry::Monads[:maybe]

    param :iterable
    option :index, default: -> { 0 }

    attr_reader :value

    def next
      @value = Maybe(@index).and Maybe(iterable.shift)
      @index +=1 unless value == None
      value
    end

    def peek
      Maybe(index).and Maybe(iterable.first)
    end
  end
end
