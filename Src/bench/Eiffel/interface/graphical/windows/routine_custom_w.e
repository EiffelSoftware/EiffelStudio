indexing
	description: "Custom window for the routine tool."
	date: "$Date$"
	revision: "$Revision $"

class
	ROUTINE_CUSTOM_W

inherit

	CUSTOM_W

create
	make 

feature {NONE} -- Initialization

	option_one_b: TOGGLE_B
	option_two_b: TOGGLE_B
			-- Option buttons

	make (a_parent: COMPOSITE) is
			-- Create window with parent `a_parent'.
		local
			rbox: RADIO_BOX
		do
			create_interface (a_parent)
			set_title (Interface_names.t_Routine_custom_tool)
			create rbox.make (Interface_names.t_Empty, Current)
			rbox.set_always_one (True)
			attach_top (rbox, 0)
			attach_left (rbox, 0)
			attach_right (rbox, 0)
			attach_bottom_widget (buttons, rbox, 0)
			create option_one_b.make ("", rbox)
			create option_two_b.make ("", rbox)
			set_composite_attributes (Current)
		end

feature -- Access

	is_first_option_selected: BOOLEAN is
			-- Was the first option selected?
		do
			Result := option_one_b.state
		end

feature -- Update

	call (c: like caller; option_one_l,	option_two_l: STRING;
				is_first_option: BOOLEAN) is
			-- Popup tool with option one toggle with label 
			-- `option_one_l' and the second option toggle with
			-- label `option_two_l'. Also, set the first option toggle
			-- armed if `is_first_option' is true. Otherwize, arm the
			-- second toggle.
		require
			valid_args: c /= Void and then option_one_l /= Void
				and then option_two_l /= Void
			is_popped_down: not is_popped_up
		do
			caller := c
			option_one_b.set_text (option_one_l)
			option_two_b.set_text (option_two_l)
			if is_first_option then
				option_one_b.arm
			else
				option_two_b.arm
			end
			popup
		end

end -- class ROUTINE_CUSTOM_W
