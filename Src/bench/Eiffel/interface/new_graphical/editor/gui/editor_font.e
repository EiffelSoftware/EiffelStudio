indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_FONT

inherit
	EV_FONT
		redefine
			string_width
		end

create
	default_create,
	make_with_values

feature {NONE} -- Initialization
	
feature -- Status report

	string_width(a_string: STRING): INTEGER is
		do
			if is_proportional then
					-- Proportional font, we use the normal feature
				Result := {EV_FONT} Precursor(a_string)
			else
					-- Fixed font...small optimisation

					-- Initialize if necessary
				if internal_character_width = 0 then
					internal_character_width := width
				end
					-- Compute result.				
				Result := internal_character_width * a_string.count
			end
		end

feature {NONE} -- Implementation

	internal_character_width: INTEGER

end -- class EDITOR_FONT
