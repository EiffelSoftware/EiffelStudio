indexing
	description: "My button with ability to show explanation";
	date: "$Date$";
	revision: "$Revision$"

class
	FOCUSABLE_B

inherit
	PUSH_B    -- usually this would be PICT_COLOR_B
		rename 
			make as push_b_make
		end
	FOCUSABLE

creation
	make

feature

	make (a_name: STRING; a_parent: COMPOSITE)is
		do	
			-- initialize like PUSH_P
			push_b_make (a_name, a_parent)

			-- focus_string should not be void
			focus_string := a_name

			-- initialize focusable
			initialize_focus

			-- add_activate_action ...
		end;

	focus_label: FOCUS_LABEL_I is
		-- has to be redefined, so that it returns correct toolkit initializer
		-- to which object belongs for every instance of this class
		local
			ti: TOOLTIP_INITIALIZER
		do
			ti ?= top
			check
				ti/= void
			end
			Result := ti.label
		end

end -- class FOCUSABLE_B

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

