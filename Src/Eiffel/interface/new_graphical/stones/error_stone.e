indexing

	description:
		"Error object sent by the compiler to the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class ERROR_STONE

inherit
	FILED_STONE
		redefine
			help_text,
			is_storable
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make (an_errori: ERROR) is
		do
			error_i := an_errori
		end

feature -- Properties

	error_i: ERROR

feature -- Access

	code: STRING is
			-- Code error
		do
			Result := error_i.code
		end

	header: STRING_GENERAL is
		do
			Result := code.as_string_32
			if Result = Void then
				create {STRING_32}Result.make (0)
			end
		end

	is_storable: BOOLEAN is
			-- Error stone are not kept.
		do
			Result := False
		end

	help_text: STRING is
			-- Content of the file where the help is.
		do
			Result := origin_text
			if Result = Void or else Result.is_empty then
				Result := Interface_names.h_No_help_available.twin
			end
		end

	history_name: STRING is
		do
			Result := interface_names.err_error.as_string_32 + header
		end

	file_name: STRING is
			-- File where the help is
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (eiffel_layout.error_path)
			l_file_name.set_file_name (error_i.help_file_name)
			Result := l_file_name.string
		end

	stone_signature: STRING is do Result := code end

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Interro
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_interro
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ERROR_STONE
