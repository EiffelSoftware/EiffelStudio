indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create character format 
		do
			base_make (an_interface)
		end
	
	initialize is
			-- Do nothing
		do
			is_initialized := True
		end
		
feature -- Access

	font: EV_FONT is
			-- Font of the current format
		do
		end
	
	color: EV_COLOR is
			-- Color of the current format
		do
		end

	background_color: EV_COLOR is
			-- Color of the current format
		do
		end
		
	effects: EV_CHARACTER_FORMAT_EFFECTS is
			-- Character format effects applicable to `font'
		do
		end

feature -- Status setting
		
	set_font (a_font: EV_FONT) is
			-- Make `value' the new font
		do
		end

	set_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
		end

	set_background_color (a_color: EV_COLOR) is
			-- Make `value' the new color
		do
		end
		
	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS) is
			-- Make `an_effect' the new `effects'
		do
		end

feature {NONE} -- Implementation

	destroy is
			-- 
		do
			
		end

end -- class EV_CHARACTER_FORMAT_IMP
