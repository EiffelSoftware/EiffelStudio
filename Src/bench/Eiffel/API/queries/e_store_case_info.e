indexing

	description: 
		"Command to store Eiffelcase readable format of system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_STORE_CASE_INFO 

inherit

	E_CMD
		redefine
			executable
		end

create

	make, do_nothing

feature -- Initialization

	make (display: like output_window; rew: like reverse_engineering_window) is
			-- Initialize Current with `output_window' is `display'.
		require
			valid_display: display /= Void
		do
			output_window := display;
			reverse_engineering_window := rew
		end;

feature -- Properties

	executable: BOOLEAN is
			-- May `execute' be called?
		do
			Result := output_window /= Void
		end;
			
feature -- Execution

	execute_back is
		local
--			format_storage: FORMAT_CASE_STORAGE
		do
			--!! format_storage.make (output_window, reverse_engineering_window);
			--format_storage.execute
		end;

	execute is
		do
			if case_interface /= Void then
				if case_interface.is_iconic_state then
					case_interface.set_normal_state
				end
				case_interface.show
				case_interface.raise
			else
				create case_interface.make (output_window, reverse_engineering_window)	
			end
		end;

feature {NONE} -- Properties

	reverse_engineering_window: DEGREE_OUTPUT;
			-- Output window of the reverse engineering

	output_window: OUTPUT_WINDOW;
			-- Output window used to display during the
			-- execution of Current.

	case_interface: CASE_INTERFACE;
			-- Reverse engineer tool window.

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

end -- class E_STORE_CASE_INFO
