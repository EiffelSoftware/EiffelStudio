indexing

	description:	
		"Cursors used in the interface."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision: "

class SHARED_CURSORS

inherit

	EIFFEL_ENV

feature -- Accepting cursor shapes

	cur_Class: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("clsscur.bm");
		end;

	cur_Object: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("objcur.bm");
		end;

	cur_Explain: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("explcur.bm");
		end;

	cur_System: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("systcur.bm");
		end;

	cur_Setstop: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("stopcur.bm");
		end; 

	cur_Feature: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("featcur.bm");
		end;

feature -- Non-Accepting cursor shapes

	cur_X_class: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xclsscur.bm");
		end;

	cur_X_object: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xobjcur.bm");
		end;

	cur_X_explain: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xexplcur.bm");
		end;

	cur_X_system: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xsystcur.bm");
		end;

	cur_X_setstop: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xstopcur.bm");
		end; 

	cur_X_feature: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("xfeatcur.bm");
		end;

feature {NONE} 

	cursor_file_content (fn: STRING): SCREEN_CURSOR is
		local
			full_path: FILE_NAME;
			a_pix: PIXMAP
		do
			create full_path.make_from_string (Cursor_path);
			full_path.set_file_name (fn);
			create a_pix.make;
			a_pix.read_from_file (full_path);
			create Result.make;
			if a_pix.is_valid then
				Result.set_pixmap (a_pix, a_pix);
			else
				io.error.put_string ("Warning: cannot read cursor file ");
				io.error.put_string (full_path);
				io.error.put_new_line;
			end;
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

end -- class SHARED_CURSORS
