indexing
	description: "Interface between the analyzer and the application through dialog boxes"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_MANAGER

feature

	dialog_message: DIALOG_MESSAGE is
			-- Create an intro dialog boxe
		require	
--			parent_not_void: dialog_parent /= Void
		once
			!! Result.make (dialog_parent)
		ensure
			dialog_message_exists: Result.exists
		end

	dialog_error: DIALOG_ERROR is
			-- Create a error dialog boxe
		require	
--			parent_not_void: dialog_parent /= Void
		once
			!! Result.make (dialog_parent)
		ensure
			dialog_error_exists: Result.exists
		end

feature -- Access

	dialog_parent: WEL_COMPOSITE_WINDOW
			-- Parent of the dialog.

	std_out: INTEGER is 1
			-- Constant for the standard output

	std_error: INTEGER is 2
			-- Constant for the error output

	interface: INTERFACE_MANAGER is
		once
			!! Result
		end

feature -- Element change

	set_dialog_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set `parent_dialog' to `a_parent'.
		require
--			a_parent_not_void: a_parent /= Void
		do
			dialog_parent := a_parent
		ensure
--			parent_set: dialog_parent = a_parent
		end

	display_text (output: INTEGER ; a_string: STRING) is
			-- Display `a_string' in the `output'.
		require
			a_string_not_void: a_string /= Void
		do
			if (output = std_out) then
--				dialog_message.show
--				dialog_message.static_info.set_text (a_string)
			end
	
			if (output = std_error) then
--				dialog_error.show
--				dialog_error.static_info.set_text (a_string)
			end
		end
	
	hide_message is
			-- Hide the message dialog box.
		do
			dialog_message.hide
		end

	hide_error is
			-- Hide the error dialog box.
		do
			dialog_error.hide
		end

	hide_all is
			-- Hide all the dialog boxes.
		do
			hide_message
			hide_error
		end

	do_terminate is
			-- Close the dialog box
		do
			if (dialog_message /= Void) then
				dialog_message.terminate (0)
			end

			if (dialog_error /= Void) then
				dialog_error.terminate (0)
			end
		end

	l_of_include_file: LINKED_LIST [STRING] is
		once
			create Result.make
		end

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
end -- class INTERFACE_MANAGER
