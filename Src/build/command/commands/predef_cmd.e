

deferred class PREDEF_CMD 

inherit

	CMD;
	SHARED_STORAGE_INFO;
	PREDEF_CMD_IDENTIFIERS
	
feature 

	make is
		do
			predefined_command_table.put (Current, identifier)
		end;

	label: STRING is
		do
			Result := eiffel_type
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.predef_command_pixmap
		end;

	help_file_name: STRING is
		do
			Result := Help_const.pred_command_help_fn
		end;

	eiffel_text: STRING is
		local
			fn, full_path: STRING;	
			f: PLAIN_TEXT_FILE
		do
			full_path := clone (Environment.predefined_commands_directory);
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
