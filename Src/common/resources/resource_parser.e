class RESOURCE_PARSER

inherit

	RESOURCE_LEX

feature -- Parsing

	parse (filename: STRING; table: RESOURCE_TABLE) is
			-- Parse the resource file `filename' and store the
			-- information in the resource table `table'.
		require
			filename_not_void: filename /= Void;
			filename_not_empty: not filename.empty
			table_not_void: table /= Void
		local
			resource_name: STRING
		do
			!! resource_file.make (filename);
			if resource_file.exists and then resource_file.is_readable then
				resource_file.open_read;
				if resource_file.readable then
					from
						line_number := 0;
						read_line
					until
						end_of_file
					loop
						parse_name;
						if last_token = Void then
							syntax_error ("Resource name expected")
						else
							resource_name := last_token;
							resource_name.to_lower;
							parse_colon;
							if last_token = Void then
								syntax_error ("%":%" expected")
							else
								parse_value;
								if last_token = Void then
									syntax_error ("Resource value expected")
								else
									table.force (last_token, resource_name)
								end
							end
						end;
						parse_separators
					end
				end;
				resource_file.close
			elseif not resource_file.exists then
				io.error.put_string ("Warning: Resource file %"");
				io.error.put_string (filename);
				io.error.put_string ("%" does not exist.");
				io.error.new_line
			else
				io.error.put_string ("Warning: Cannot read resource file %"");
				io.error.put_string (filename);
				io.error.put_string ("%".");
				io.error.new_line
			end
		end;
				
feature -- Errors

	syntax_error (message: STRING) is
			-- Display a warning message.
			-- Move the pointer to the next line in the file.
		require
			message_not_void: message /= Void
		do
			io.error.putstring ("Warning: resource file %"");
			io.error.putstring (resource_file.name);
			io.error.putstring ("%"%N%TSyntax error, line ");
			io.error.putint (line_number);
			io.error.putstring (": ");
			io.error.putstring (message);
			io.error.new_line;
			read_line
		end;

end -- class RESOURCE_PARSER
