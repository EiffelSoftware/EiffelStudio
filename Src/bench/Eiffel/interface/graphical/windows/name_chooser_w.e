indexing

	description:	
		"Window to choose a name."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class NAME_CHOOSER_W 

inherit

	COMMAND_W;
	FILE_SEL_D
		rename
			make as file_sel_d_create,
			popup as file_sel_d_popup,
			popdown as file_sel_d_popdown
		end;
	FILE_SEL_D
		rename
			make as file_sel_d_create
		redefine
			popup, popdown
		select
			popup, popdown
		end;
	SHARED_BENCH_LICENSES;
	WINDOW_ATTRIBUTES

create

	make
	
feature -- Initialization

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		do
			file_sel_d_create (Interface_names.n_X_resource_name, a_composite)
			hide_help_button
			add_ok_action (Current, Current)
			add_cancel_action (Current, Void)
			set_title (Interface_names.t_Select_a_file)
			set_exclusive_grab
			set_default_position (false)
			set_composite_attributes (Current)
			realize
		end;

feature -- Graphical Interface

	call (a_command: COMMAND) is
			-- Record calling command `a_command' and popup current.
		do
			last_caller := a_command;
			popup
		ensure
			last_caller_recorded: last_caller = a_command
		end;

	set_window (wind: COMPOSITE) is
		do
			window := wind
		end;

	popdown is
			-- Popdown the name chooser.
		do
			last_directory_viewed.wipe_out;
			if directory /= Void then
				last_directory_viewed.append (directory);
			end
			file_sel_d_popdown
		end;

feature {PROJECT_W} -- Re mapping

	popup is
			-- Popup file selection window.
		local
			new_x, new_y: INTEGER
		do
			if not last_directory_viewed.is_empty then
				set_directory (last_directory_viewed)
			end
			if is_popped_up then popdown end;
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
			file_sel_d_popup
		end;

feature {NONE} -- Properties

	last_caller: COMMAND
			-- Last command which popped up current

	window: WIDGET;
			-- Window to which the file selection will apply

	last_directory_viewed: STRING is
			-- Last directory viewed
		once
			create Result.make (0);
		end

feature 

	set_last_directory_viewed(st:STRING) is
			-- Set the last directory viewed.
		do
			last_directory_viewed.wipe_out
			last_directory_viewed.append(st)
		end

feature {NONE} -- Implementation

	work (argument: ANY) is
		do
			popdown;
			if argument = Current then
				last_caller.execute (Current)
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class NAME_CHOOSER_W
