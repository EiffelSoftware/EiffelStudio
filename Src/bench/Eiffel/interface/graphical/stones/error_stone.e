indexing

	description: 
		"Error object sent by the compiler to the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class ERROR_STONE

inherit

	EIFFEL_ENV;
	FILED_STONE
		redefine
			help_text
		end

create

	make

feature {NONE} -- Initialization

	make (an_errori: ERROR) is
		do
			error_i := an_errori
		end;
 
feature -- Properties

	error_i: ERROR;

feature -- Access

	code: STRING is
			-- Code error
		do
			Result := error_i.code
		end;

	header: STRING is 
		do 
			Result := code;
			if Result = Void then
				create Result.make (0)
			end;
		end;

	stone_type: INTEGER is do Result := Explain_type end;

	stone_name: STRING is
		do
			Result := Interface_names.s_Explain_stone
		end;

	help_text: LINKED_LIST [STRING] is
			-- Content of the file where the help is
		local
			a_file: RAW_FILE;
			a_line: STRING
		do
			create Result.make;
			if is_valid then
				create a_file.make (file_name);
				if a_file.exists and then a_file.is_readable then
					from
						a_file.open_read;
						a_file.readline;
					until
						a_file.end_of_file
					loop
						a_line := clone (a_file.laststring);
						Result.extend (a_line);
						a_file.readline;
					end
				end
			end
			if Result.is_empty then
				Result.put_front (Interface_names.h_No_help_available)
			end;
		end;

	file_name: STRING is
			-- File where the help is
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (help_path);
			fn.set_file_name (error_i.help_file_name);
			Result := fn
		end;

	set_file_name (s: STRING) is do end;
			-- Do nothing

	click_list: ARRAY [CLICK_STONE] is do end;

	stone_signature: STRING is do Result := code end;

	icon_name: STRING is
		do
			Result := code;
			if Result = Void then
				create Result.make (0)
			end;
		end;

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- No
		do
			-- Do nothing
		end

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Explain
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_explain
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_error (Current)
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

end -- class ERROR_STONE
