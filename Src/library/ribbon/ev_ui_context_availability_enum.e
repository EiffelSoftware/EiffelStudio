note
	description: "[
					Specifies values that identify the availability of a contextual tab.
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UI_CONTEXT_AVAILABILITY_ENUM

feature -- Enum

	not_available: NATURAL_32 = 0
				-- UI_CONTEXTAVAILABILITY_NOTAVAILABLE

	available: NATURAL_32 = 1
  				-- UI_CONTEXTAVAILABILITY_AVAILABLE

  	active: NATURAL_32 = 2
  				-- UI_CONTEXTAVAILABILITY_ACTIVE

feature -- Contract support

	is_valie (a_value: NATURAL_32): BOOLEAN
			-- If `a_value' valid?
		do
			Result := a_value = not_available or else
						a_value = available or else
						a_value = active
		end
end
