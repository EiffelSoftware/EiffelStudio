

deferred class PREDEF_CMD 

inherit

	CMD;
	STORAGE_INFO
		export
			{NONE} all
		end;
	UNIX_ENV
		export
			{NONE} all
		end



	
feature 

	label: STRING;
	set_label (s: STRING) is do label := s end;

	eiffel_text: STRING is
		local
			fn, full_path: STRING;	
			f: UNIX_FILE
		do
			full_path := Commands_directory.duplicate;
			full_path.append ("/");
				fn := eiffel_type.duplicate;
				fn.to_lower;
				fn.append (".e");
			full_path.append (fn);
			!!f.make (full_path);
			f.open_read;
			f.readstream (f.count);
			Result := f.laststring;
			f.close;
		end;

end
