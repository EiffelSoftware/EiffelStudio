indexing

	description:
		"Parser for the resource file.";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_PARSER

inherit

	RESOURCE_LEX

feature -- Parsing

	parse_resource_value (a_value: STRING) is
			-- Parse the value `a_value'.
		require
			a_value_not_void: a_value /= Void;
			a_value_not_empty: not a_value.empty
		do
			line := a_value;
			parse_value;
			if not is_last_token_valid then
				error_code := Malformed_token
			end
		end;
			
	parse_file (file_name: STRING; table: RESOURCE_TABLE) is
			-- Parse file `file_name' and put result in `table'
		require
			file_name_not_void: file_name /= Void;
			file_name_not_empty: not file_name.empty
		do
			open_file (file_name)
			if resource_file.is_open_read and then resource_file.readable then
				from
				until
					end_of_file
				loop
					parse (table)
					if not end_of_file and then not is_last_token_valid then
						print_syntax_error
					end
				end
				close_file
			end
		end;

	parse (table: RESOURCE_TABLE) is
			-- Parse the resource file `filename' and store the
			-- information in the resource table `table'.
		require
			table_not_void: table /= Void;
		local
			resource_name: STRING
		do
			if resource_file.is_open_read then
				if resource_file.readable then
					from
						error_code := 0;
						read_line;
						parse_separators
					until
						end_of_file or else error_code /= 0
					loop
						parse_name;
						if not is_last_token_valid then
							error_code := No_resource_name
						else
							resource_name := last_token;
							resource_name.to_lower;
							parse_colon;
							if not is_last_token_valid then
								error_code := No_colon
							else
								parse_value;
debug("RESOURCE_VALIDATE")
	io.error.putstring ("`is_last_token_valid'? --> ");
	if is_last_token_valid then
		io.error.putstring ("YES")
	else
		io.error.putstring ("NO (at line ");
		io.error.putint (line_number);
		io.error.putstring (")")
	end;
	io.error.new_line
end;
								if not is_last_token_valid then
									error_code := Malformed_token
								else
									table.force (last_token, resource_name)
								end
							end
						end;
						if error_code = 0 then
							parse_separators
						end;
debug("RESOURCE_VALIDATE")
	io.error.putstring ("After evaluating one resource, there is ");
	if error_code /= 0 then
		io.error.putstring ("an")
	else
		io.error.putstring ("no")
	end;
	io.error.putstring (" error detected...");
	io.error.new_line;
	io.error.putstring ("Evaluation of `end_of_file or else error_code /= 0' yields: ");
	io.error.putbool (end_of_file or else error_code /= 0);
	io.error.new_line
end
					end
				end
			end
		end
				
feature -- File handling

	open_file (filename: STRING) is
			-- Open `resource_file' for reading.
		require
			filename_not_void: filename /= Void;
			filename_not_empty: not filename.empty
		do
			!! resource_file.make (filename);
			if not resource_file.exists then 
				-- Do nothing (no message) if the resource file does not exist
			elseif resource_file.is_readable then
				resource_file.open_read
				line_number := 0;
			else
				io.error.put_string ("Warning: Cannot read resource file %"");
				io.error.put_string (filename);
				io.error.put_string ("%".");
				io.error.new_line
			end
		end;

	close_file is
			-- Close `resource_file'.
		do
			resource_file.close
		end

feature -- Errors

	is_last_token_valid: BOOLEAN is
			-- Is the last token parsed a valid one?
		do
			Result := last_token /= Void
		end;

	error_code: INTEGER;
			-- Code to indicate the latest parse error

	print_syntax_error is
			-- Display a warning message.
			-- Move the pointer to the next line in the file.
		do
			io.error.putstring ("Warning: resource file %"");
			io.error.putstring (resource_file.name);
			io.error.putstring ("%"%N%TSyntax error, line ");
			io.error.putint (line_number);
			io.error.putstring (": ");
			inspect
				error_code
			when Malformed_token then
				io.error.putstring ("Resource value expected.")
			when No_resource_name then
				io.error.putstring ("Resource name exptected.")
			when No_colon then
				io.error.putstring ("%":%" expected.")
			else
				io.error.putstring ("Unknown error occured.")
			end;
			io.error.new_line
		end;

feature -- Error codes

	Malformed_token: INTEGER is 1;
	No_resource_name: INTEGER is 2;
	No_colon: INTEGER is 3

end -- class RESOURCE_PARSER
