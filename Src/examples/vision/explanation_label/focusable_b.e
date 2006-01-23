indexing
	description: "My button with ability to show explanation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
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


end -- class FOCUSABLE_B

