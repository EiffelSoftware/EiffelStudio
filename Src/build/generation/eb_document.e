
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

	error: BOOLEAN;
			-- Was there an error when updating the document?

	document_file_name: FILE_NAME is
		do
			!! Result.make_from_string (directory_name);
			Result.set_file_name (document_name);
			Result.add_extension ("e");
		end;

	is_file_name_valid: BOOLEAN is
		do
			Result := document_file_name.is_valid
		end;

feature 

	update (new_templ: STRING) is
		local
			template_file_name: FILE_NAME;
			class_file_name: FILE_NAME;	
			new_template_file_name: FILE_NAME;
			file, new_tmp_file: RAW_FILE;
			user_file, old_tmp_file: RAW_FILE
			merge_result: STRING
			different: BOOLEAN;
			merger: MERGER
		do
			error := False;
			!! template_file_name.make_from_string (Environment.templates_directory);
			template_file_name.set_file_name (document_name);

			class_file_name := document_file_name;

			!! new_template_file_name.make_from_string (template_file_name);
			new_template_file_name.add_extension ("n");
			!!file.make_open_write (new_template_file_name);
			file.putstring (new_templ);
			file.close;

			!! file.make (template_file_name)
			if not file.exists then
				file.open_write;
				file.putstring (new_templ)
				file.close
			end

			!! user_file.make (class_file_name)
			if user_file.exists then
				!! merger;
				debug ("MERGER")
					io.error.putstring ("start parsing file: ");
					io.error.putstring (document_name);
					io.error.putstring ("... ");
				end;
				merger.parse_files (template_file_name,
					class_file_name,
					new_template_file_name);
				debug ("MERGER")
					io.error.putstring ("finished%N")
				end;
				error := merger.error;
				if not error then
					if merger.require_merge then
						debug ("MERGER")
							io.error.putstring ("start merging file: ");
							io.error.putstring (document_name);
							io.error.putstring ("... ");
						end;
						merger.merge_files (template_file_name,
								class_file_name,
								new_template_file_name);
						debug ("MERGER")
							io.error.putstring ("finished%N")
						end;
						merge_result := merger.merge_result;
							-- Merge went ok
						user_file.open_read;
						if user_file.count > 0 then
							user_file.readstream (user_file.count);
						end;
						user_file.close;
						if not user_file.last_string.is_equal 
									(merger.merge_result) 
						then 
							debug ("MERGER")
								io.error.putstring ("updating file: ");
								io.error.putstring (document_name);
								io.error.putstring ("%N");
							end;
								-- Only update if necessary
							user_file.open_write;
							user_file.put_string (merge_result);
							user_file.close;
						end;
								-- Copy new template file as old_template;
						!! new_tmp_file.make (new_template_file_name);
						!! old_tmp_file.make (template_file_name);
						old_tmp_file.wipe_out
						old_tmp_file.append (new_tmp_file)
						new_tmp_file.delete
					end
				end
			else
				user_file.wipe_out;
				!! new_tmp_file.make (new_template_file_name);
				!! old_tmp_file.make (template_file_name);
				old_tmp_file.wipe_out

				-- new_template_file > class_file
				user_file.append (new_tmp_file)

				-- new_template_file > template_file
				old_tmp_file.append (new_tmp_file)
				
				-- rm new_template_file
				new_tmp_file.delete
			end
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
				Error_dialog.popup (Current,
						  Messages.write_file_er,
						  file.name)
			end;
		end;

end	
