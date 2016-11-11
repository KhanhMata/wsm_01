module PositionsHelper
  def check_status position
    case
    when position.disabled?
      "wall.png"
    when position.freedesk?
      "freedesk.png"
    when position.staff?
      "staff.png"
    else
      "freespace.jpg"
    end
  end
end
