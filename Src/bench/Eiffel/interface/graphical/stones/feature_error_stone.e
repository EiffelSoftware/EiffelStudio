indexing

	description: 
		"Stone for a feature that has a error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_ERROR_STONE

inherit

	FEATURE_STONE
		rename
			make as feat_make
		redefine
			process, line_number
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_pos: INTEGER) is
			-- Initialize stone with `a_feature' and error position `a_pos;.
		do
			feat_make (a_feature);
			error_position := a_pos
		end;

feature -- Access

	error_position: INTEGER
			-- Character position of error in `e_feature'.

	line_number: INTEGER is
			-- Line number of error 
		local
			file: RAW_FILE;
			start_line_pos: INTEGER;
		do
			create file.make (file_name);
			if file.is_readable then
				file.open_read;
				from
				until
					file.position > error_position + 1 or else file.end_of_file
				loop
					start_line_pos := file.position;
					Result := Result + 1;
					file.readline;
				end;
				file.close;
			end
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			if is_valid then
				hole.process_feature_error (Current)
			else
				warner (hole.target.top).gotcha_call (invalid_stone_message)
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

end -- class FEATURE_ERROR_STONE
