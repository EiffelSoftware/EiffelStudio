
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
			template_file_name: STRING;
			class_file_name: STRING;	
			new_template_file_name: STRING;
			file: UNIX_FILE;
			unix_command: STRING;
			msg: STRING;
		do
			template_file_name := clone (Environment.templates_directory);
			template_file_name.extend (Environment.directory_separator);
			template_file_name.append (document_name);

			class_file_name := clone (directory_name);
			class_file_name.extend (Environment.directory_separator);
			class_file_name.append (document_name);
			class_file_name.append (".e");

			new_template_file_name := clone (template_file_name);
			new_template_file_name.append (".n");
			!!file.make_open_write (new_template_file_name);
			file.putstring (s);
			file.close;

			!!unix_command.make (0);
			unix_command.append (Environment.eiffelBuild_bin);
			unix_command.extend (Environment.directory_separator);
			unix_command.append (Environment.merge1_file_name);
			unix_command.extend (' ');
			unix_command.append (class_file_name);
			unix_command.extend (' ');
			unix_command.append (template_file_name);
			unix_command.extend (' ');
			unix_command.append (new_template_file_name);

			Environment.system (unix_command);
			if Environment.return_code < 0 then
				!!msg.make (0);
				msg.append ("System call failed%N");
				msg.append ("%NCould not update ");
				msg.append (document_name);
				msg.append (" text");
				error_box.popup (Current, msg);
			end;
		end;

	updated_text: STRING is
		local
			class_file_name: STRING;
			file: UNIX_FILE;	
		do

			class_file_name := clone (directory_name);
			class_file_name.extend (Environment.directory_separator);
			class_file_name.append (document_name);
			class_file_name.append (".e");
			!!file.make_open_read (class_file_name);
			!!Result.make (0);
			from
				file.readline;
			until
				file.end_of_file
			loop
				Result.append (file.laststring);
				Result.append ("%N");
				file.readline;
			end;
			file.close;
	end;

end	
