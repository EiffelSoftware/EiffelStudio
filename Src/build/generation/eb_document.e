
class EB_DOCUMENT 

inherit

	UNIX_ENV
		export
			{NONE} all
		end;

	WINDOWS;

	ERROR_POPUPER



	
feature {NONE}

	Template_directory: STRING is
		once
			Result := clone (Generated_directory);
			Result.append ("/.templates");
		end;

	
feature 

	set_document_name (s: STRING) is
		do
			document_name := clone (s);
			document_name.to_lower
		end;

	
feature {NONE}

	document_name: STRING;

	
feature 

	set_directory_name (s: STRING) is
		do
			directory_name := clone(s);
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
			msg: STRING;
		do
			template_file_name := clone (Template_directory);
			template_file_name.append ("/");
			template_file_name.append (document_name);

			class_file_name := clone (directory_name);
			class_file_name.append ("/");
			class_file_name.append (document_name);
			class_file_name.append (".e");

			new_template_file_name := clone (template_file_name);
			new_template_file_name.append (".n");
			!!file.make_open_write (new_template_file_name);
			file.putstring (s);
			file.close;

			!!unix_command.make (0);
			unix_command.append (EiffelBuild_bin);
			unix_command.append ("/bin/merge1 ");
			unix_command.append (class_file_name);
			unix_command.append (" ");
			unix_command.append (template_file_name);
			unix_command.append (" ");
			unix_command.append (new_template_file_name);

			system (unix_command);
			if return_code /= 0 then
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
			class_file_name.append ("/");
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
