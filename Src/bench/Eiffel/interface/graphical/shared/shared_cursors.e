indexing

	description:	
		"Cursors used in the interface.";
	date: "$Date$";
	revision: "$Revision: "

class SHARED_CURSORS

inherit

	EIFFEL_ENV

feature {NONE} -- Properties

	cur_watch: SCREEN_CURSOR is
			-- Cursor to be used when waiting for the end of an execution
		local
			ct: CURSOR_TYPE;
		once
			!! ct;
			!! Result.make;
			Result.set_type (ct.watch)
		end;

	cur_Class: SCREEN_CURSOR is
		once
			Result := cursor_file_content ("classcur.bm");
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
			Result := cursor_file_content ("entitcur.bm");
		end;

feature {NONE} 

	cursor_file_content (fn: STRING): SCREEN_CURSOR is
		local
			full_path: FILE_NAME;
			a_pix: PIXMAP
		do
			!! full_path.make_from_string (Bitmap_path);
			full_path.set_file_name (fn);
			!! a_pix.make;
			a_pix.read_from_file (full_path);
			!! Result.make;
			if a_pix.is_valid then
				Result.set_pixmap (a_pix, a_pix);
			else
				io.error.putstring ("Warning: cannot read cursor file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;

end -- class SHARED_CURSORS
