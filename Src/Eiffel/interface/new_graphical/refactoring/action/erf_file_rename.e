note
	description: "This allows undoable file renaming."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FILE_RENAME

inherit
	ERF_ACTION

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_original_name: STRING; a_new_name: STRING)
			-- Rename `an_original_name' into `a_new_name'
		require
			an_original_name_not_void: an_original_name /= void
			a_new_name_not_void: a_new_name /= void
		do
			original_name := an_original_name
			new_name := a_new_name
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error during the file rename.

	error_message: STRING_GENERAL
			-- Error message for the last error.

feature -- Basic operations

	undo
			-- Undo the actions.
		local
			l_file, l_dst_file: RAW_FILE
		do
				-- don't rename if destination file exists
			create l_dst_file.make (original_name)
			if not l_dst_file.exists then
				create l_file.make (new_name)
				if l_file.exists then
						-- fix for bad change_name behaviour on windows (if new_name and old_name are equal the file is removed)
					if not original_name.is_equal (new_name) then
						l_file.change_name (original_name)
					end
				end
			else
				is_error := True
				error_message := warning_messages.w_not_rename (new_name, original_name)
			end
		end

	redo
			-- Redo the actions.
		local
			l_file, l_dst_file: RAW_FILE
		do
				-- don't rename if destination file exists
			create l_dst_file.make (new_name)
			if not l_dst_file.exists then
				create l_file.make (original_name)
				if l_file.exists then
						-- fix for bad change_name behaviour on windows (if new_name and old_name are equal the file is removed)
					if not original_name.is_equal (new_name) then
						l_file.change_name (new_name)
					end
				end
			else
				is_error := True
				error_message := warning_messages.w_not_rename (original_name, new_name)
			end
		end

feature {NONE} -- Implementation

	original_name: STRING
			-- Original file name

	new_name: STRING
			-- New file name

invariant
	original_name_set: original_name /= void and not original_name.is_empty
	new_name_set: new_name /= void and not new_name.is_empty
	error_implies_message: is_error implies error_message /= Void and then not error_message.is_empty

note
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

end
