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
