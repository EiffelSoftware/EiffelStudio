indexing
	description: "EiffelVision Toggle button.%
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		undefine
			build
		end

	EV_BUTTON_IMP
		redefine
			select_action,
			is_down,
			on_bn_clicked
		end

creation
	make,
	make_with_text

feature -- Status report
	
	state: BOOLEAN is
			-- Is toggle pressed
		do
			Result := is_down
		end 

feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if flag then
				current_state := 3
			else
				current_state := 1
			end
			invalidate
			on_bn_clicked
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_state (not state)
		end

feature -- Event - command association
	
	add_toggle_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- when the button is toggled.
		do
			add_command (Cmd_toggle, cmd, arg)
		end	

feature {NONE} -- Implementation

	select_action is
			-- Action to be down when `Oda_select'.
			-- It will draw only if we obtain 0 or 2.
			-- We need to have 4 values, because it is
			-- called each time the user press or unpress
			-- the button, then it is called twice for a
			-- usual click.
		do
			current_state := (current_state + 1) \\ 4
		end

	is_down: BOOLEAN is
			-- Say if the button is down or not.
		do
			inspect current_state
			when 0 then
				Result := False
			when 1 then
				Result := False
			when 2 then
				Result := True
			when 3 then
				Result := True
			else
				check
					not_possible: False
				end
			end
		end

	on_bn_clicked is
			-- When the button is pressed
			-- To implement
		do
			execute_command (Cmd_click, Void)
			execute_command (Cmd_toggle, Void)
		end

end -- class EV_TOGGLE_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
