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
			string_width,
			is_proportional
		end

create
	default_create,
	make_with_values,
	make_with_font

feature {NONE} -- Initialization

	make_with_font (a_font: EV_FONT) is
		do
			default_create
			implementation.set_values (
				a_font.family, 
				a_font.weight,
				a_font.shape,
				a_font.height,
				a_font.preferred_families
				)
		end
	
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
	
	is_proportional: BOOLEAN is
		do
			if not internal_is_proportional_computed then
				internal_is_proportional := Precursor
				internal_is_proportional_computed := True
			end
			Result := internal_is_proportional
		end

	internal_character_width: INTEGER

	internal_is_proportional: BOOLEAN

	internal_is_proportional_computed: BOOLEAN

end -- class EDITOR_FONT
