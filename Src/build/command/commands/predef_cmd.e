

deferred class PREDEF_CMD 

inherit

	CMD;
	SHARED_STORAGE_INFO;
	
feature 

	label: STRING;

	set_label (s: STRING) is do label := s end;

	eiffel_text: STRING is
		local
			fn, full_path: STRING;	
			f: UNIX_FILE
		do
			full_path := clone (Environment.Commands_directory);
			full_path.extend (Environment.directory_separator);
				fn := clone (eiffel_type);
				fn.to_lower;
				fn.append (".e");
			full_path.append (fn);
			!!f.make (full_path);
			f.open_read;
			f.readstream (f.count);
			Result := f.laststring;
			f.close;
		end;

	remove_class is do end;

	recreate_class is do end;

end
