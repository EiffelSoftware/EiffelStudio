indexing

	description:	
		"Model for custom windows."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CUSTOM_W

inherit

	COMMAND;
	WINDOW_ATTRIBUTES;
	FORM_D
		rename
			make as form_d_make
		export
			{NONE} form_d_make
		end

feature -- Access

	caller: CUSTOM_CALLER
			-- Associated caller

feature -- Status report

	window: WIDGET
			-- Widget where popup will be placed

feature -- Status setting

	set_window (wind: like window) is
			-- Set `window' to `win'.
		do
			window := wind
		end;  

feature {NONE} -- Interface initialization

	buttons: FORM;
			-- Buttons specifying the choice

	create_interface (a_parent: COMPOSITE) is
			-- Create interface with ok, cancel and apply button
			-- at bottom with `a_parent'
		local
			ok_b, apply_b, cancel_b: PUSH_B;
			sep: THREE_D_SEPARATOR
		do
			form_d_make ("", a_parent);
			set_exclusive_grab;
			create buttons.make ("", Current);
			create ok_b.make (Interface_names.b_Ok, buttons);
			create apply_b.make (Interface_names.b_Apply, buttons);
			create cancel_b.make (Interface_names.b_Cancel, buttons);
			create sep.make (Interface_names.t_Empty, buttons);
			buttons.set_fraction_base (17);
			attach_left (buttons, 5);
			attach_right (buttons, 5);
			attach_bottom (buttons, 5);
			buttons.attach_left (sep, 0);
			buttons.attach_right (sep, 0);
			buttons.attach_top (sep, 2);
			buttons.attach_top_widget (sep, ok_b, 2);
			buttons.attach_top_widget (sep, apply_b, 2);
			buttons.attach_top_widget (sep, cancel_b, 2);
			buttons.attach_bottom (ok_b, 0);
			buttons.attach_bottom (apply_b, 0);
			buttons.attach_bottom (cancel_b, 0);
			buttons.attach_left (ok_b, 0);
			buttons.attach_right_position (ok_b, 5);
			buttons.attach_left_position (apply_b, 6);
			buttons.attach_right_position (apply_b, 11);
			buttons.attach_left_position (cancel_b, 12);
			buttons.attach_right (cancel_b, 0);
			ok_b.add_activate_action (Current, ok_action);
			cancel_b.add_activate_action (Current, Void);
			apply_b.add_activate_action (Current, apply_action);
		end;

	ok_action, apply_action: ANY is
			-- Action constants
		once
			create Result;
		end

feature -- Execution

	execute (arg: ANY) is
			-- Execute the action of the buttons
		do
			if arg = ok_action then
				unrealize;
				popdown;
				caller.execute_ok_action (Current)
			elseif arg = apply_action then
				caller.execute_apply_action (Current)
			else
				unrealize;
				popdown
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CUSTOM_W
