require "csv"

class Types::Address
  attr_accessor :city, :street

  def initialize(city, street)
    self.city = city
    self.street = street
  end

  def to_db
    "(#{CSV.generate_line([city, street]).strip})"
  end

  def self.from_db(serialized_address)
    new(
      *CSV.parse(serialized_address[1..-2]).first
    )
  end

  alias to_s to_db
  alias inspect to_db

  def self.unquote(part)
    if part && (part.start_with?('"') || part.start_with?("'"))
      part[1..-2]
    else
      part
    end
  end
end
