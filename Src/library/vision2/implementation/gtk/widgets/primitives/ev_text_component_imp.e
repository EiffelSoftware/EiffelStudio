indexing

	description: 
		"EiffelVision text component, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_IMP
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} change_actions_internal	
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_change_actions is
			-- The text has been changed by the user.
		deferred
		end
		
feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width + 10)
				-- 10 = size of handle
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
			Result := font.string_width ("W")
		end
		
	font: EV_FONT is
			-- Current font displayed by widget. (This can be removed if text component is made fontable)
		deferred
		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

