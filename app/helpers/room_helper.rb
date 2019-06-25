module RoomHelper
  def plural_form(number, string)
    if number > 1
      number.to_s + ' ' + string.pluralize
    else
      number.to_s + ' ' + string
    end
  end
end
