
class EB_DOCUMENT 

inherit

	CONSTANTS;
	WINDOWS;
	ERROR_POPUPER
	

feature {NONE}

	document_name: STRING;

	directory_name: STRING;

feature 

	set_document_name (s: STRING) is
		do
			document_name := clone (s);
			document_name.to_lower
		end;

	set_directory_name (s: STRING) is
		do
			directory_name := clone(s);
		end;

feature 

	update (s: STRING) is
		
		local
			template_file_name: FILE_NAME;
			class_file_name: FILE_NAME;	
			new_template_file_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
			unix_command: STRING;
			mp: MOUSE_PTR;
		do
			!! template_file_name.make_from_string (Environment.templates_directory);
			template_file_name.set_file_name (document_name);

			!! class_file_name.make_from_string (directory_name);
			class_file_name.set_file_name (document_name);
			class_file_name.add_extension ("e");

			!! new_template_file_name.make_from_string (template_file_name);
			new_template_file_name.add_extension ("n");
			!!file.make_open_write (new_template_file_name);
			file.putstring (s);
			file.close;

			!! unix_command.make (10);
			unix_command.append (Environment.merge1_file);

			unix_command.extend (' ');
			unix_command.append (class_file_name);
			unix_command.extend (' ');
			unix_command.append (template_file_name);
			unix_command.extend (' ');
			unix_command.append (new_template_file_name);

			!! mp;
			mp.set_watch_shape;
			Environment.system (unix_command);
			mp.restore;
			if Environment.return_code < 0 then
				error_box.popup (Current, Messages.update_text_er, document_name);
			end;
		end;

	foo: STRING is
		local
			class_file_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;	
		do
			!! class_file_name.make_from_string (directory_name);
			class_file_name.set_file_name (document_name);
			class_file_name.add_extension ("e");
			!! file.make (class_file_name);
			if file.exists and then file.is_readable then
				file.open_read;
				!! Result.make (0);
				from
					file.readline;
				until
					file.end_of_file
				loop
					Result.append (file.laststring);
					Result.append ("%N");
					file.readline;
				end;
			else
				Result := "Cannot read file ";
				Result.append (file.name)
			end;
			file.close;
		end;

	save_text (txt: STRING) is
		local
			file: PLAIN_TEXT_FILE;
			class_file_name: FILE_NAME;
		do
			!! class_file_name.make_from_string (directory_name);
			class_file_name.set_file_name (document_name);
			class_file_name.add_extension ("e");
			!! file.make (class_file_name);
			if file.is_creatable then
				file.open_write;
				file.putstring (txt);
				file.close
			else
				Error_box.popup (Current,
						  Messages.write_file_er,
						  file.name)
			end;
		end;

end	
