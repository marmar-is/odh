module AmbassadorsHelper

  # Display the label for a child (we don't know how much info we have)
  # Used on prospective children
  def display_child_label(child)
    if !child.full_name.blank?
      child.full_name
    elsif !child.email.blank?
      child.email
    elsif !child.phone.blank?
      number_to_phone(child.phone, area_code: true)
    else
      "False Child"
    end
  end

end
