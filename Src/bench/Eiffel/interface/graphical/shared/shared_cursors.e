indexing

	description:	
		"Cursors used in the interface.";
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
				io.error.putstring ("Warning: cannot read cursor file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;

end -- class SHARED_CURSORS
