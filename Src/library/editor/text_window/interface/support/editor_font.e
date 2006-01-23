indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				Result := Precursor {EV_FONT} (a_string)
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
				internal_is_proportional := Precursor {EV_FONT} 
				internal_is_proportional_computed := True
			end
			Result := internal_is_proportional
		end

	internal_character_width: INTEGER

	internal_is_proportional: BOOLEAN

	internal_is_proportional_computed: BOOLEAN;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITOR_FONT
