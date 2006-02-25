indexing

	description:	
		"General window to let the user confirm something."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CONFIRMER_W 

inherit

	COMMAND_W;
	NAMER;
	QUESTION_D
		rename
			make as question_create,
			popup as question_popup
		end;
	QUESTION_D
		rename
			make as question_create
		redefine
			popup
		select
			popup
		end;

create
	make
	
feature -- Initialization

	make (a_composite: COMPOSITE) is
			-- Create a confirmer window.
		do
			question_create (Interface_names.n_X_resource_name, a_composite);
			set_title (Interface_names.t_Confirm);
			hide_help_button;
			add_ok_action (Current, Current);
			add_cancel_action (Current, Void);
			set_default_position (false);
			realize
		end;

feature -- Graphical Interface

	popup is
			-- Popup corfimer window.
		local
			new_x, new_y: INTEGER
		do
			if window /= Void then
				new_x := window.real_x + (window.width - width) // 2;
				new_y := window.real_y + (window.height - height) // 2;
			else
				new_x := (screen.width - width) // 2;
				new_y := (screen.height - height) // 2
			end;
			if new_x + width > screen.width then
				new_x := screen.width - width
			end;
			if new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			end;
			if new_y < 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y);
			question_popup
		end;

	call (a_command: COMMAND; a_message, ok_label: STRING) is
			-- Record calling command `a_command' and popup current,
			-- with the message `a_message'.
		do
			last_caller := a_command;
			set_exclusive_grab;
			set_ok_label (ok_label);
			set_message (a_message);
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	set_window (wind: COMPOSITE) is
		do
			window := wind
		end;
	
feature {NONE} -- Implementation

	work (argument: ANY) is
		do
			popdown;
			if argument = Current then
				last_caller.execute (Current)
			end
		end;

feature {NONE} -- Properties

	last_caller: COMMAND
			-- Last command which popped up current

	window: WIDGET;
			-- Window to which the confirmation will apply

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

end -- class CONFIRMER_W
