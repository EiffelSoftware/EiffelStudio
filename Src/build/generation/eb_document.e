
class EB_DOCUMENT 

inherit

	UNIX_ENV
		export
			{NONE} all
		end;



	
feature {NONE}

	Template_directory: STRING is
		once
			Result := Generated_directory.duplicate;
			Result.append ("/.templates");
		end;

	
feature 

	set_document_name (s: STRING) is
		do
			document_name := s.duplicate;
			document_name.to_lower
		end;

	
feature {NONE}

	document_name: STRING;

	
feature 

	set_directory_name (s: STRING) is
		do
			directory_name := s.duplicate
		end;

	
feature {NONE}

	directory_name: STRING;

	
feature 

	update (s: STRING) is
		
		local
			template_file_name: STRING;
			class_file_name: STRING;	
			new_template_file_name: STRING;
			file: UNIX_FILE;
			unix_command: STRING;
			temp: ANY
		do
			template_file_name := Template_directory.duplicate;
			template_file_name.append ("/");
			template_file_name.append (document_name);

			class_file_name := directory_name.duplicate;
			class_file_name.append ("/");
			class_file_name.append (document_name);
			class_file_name.append (".e");

			new_template_file_name := template_file_name.duplicate;
			new_template_file_name.append (".n");
			!!file.make_open_write (new_template_file_name);
			file.putstring (s);
			file.close;

			!!unix_command.make (0);
			unix_command.append (EiffelBuild_directory);
			unix_command.append ("/bin/merge1 ");
			unix_command.append (class_file_name);
			unix_command.append (" ");
			unix_command.append (template_file_name);
			unix_command.append (" ");
			unix_command.append (new_template_file_name);

			temp := unix_command.to_c;
			eb_document_system ($temp);
		end;

feature {NONE} -- External features

	eb_document_system (cmd: ANY) is
		external
			"C"
		alias
			"system"
		end; -- eb_document_system
	
end	
