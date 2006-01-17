indexing

	description:
		"Parser for the resource file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class RESOURCE_PARSER

inherit

	RESOURCE_LEX

feature -- Parsing

	parse_file (filename: FILE_NAME; table: RESOURCE_TABLE) is
			-- Parse the resource file `filename' and store the
			-- information in the resource table `table'.
		require
			filename_not_void: filename /= Void;
			filename_not_empty: not filename.is_empty
			table_not_void: table /= Void
		local
			resource_name: STRING
		do
			create resource_file.make (filename);
			if not resource_file.exists then 
				-- Do nothing (no message) if the resource file does not exist
			elseif resource_file.is_readable then
				resource_file.open_read;
				if resource_file.readable then
					from
						line_number := 0;
						read_line;
						parse_separators
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
			else
				io.error.put_string ("Warning: Cannot read resource file %"");
				io.error.put_string (filename);
				io.error.put_string ("%".");
				io.error.put_new_line
			end
		end;
				
feature -- Errors

	syntax_error (message: STRING) is
			-- Display a warning message.
			-- Move the pointer to the next line in the file.
		require
			message_not_void: message /= Void
		do
			io.error.put_string ("Warning: resource file %"");
			io.error.put_string (resource_file.name);
			io.error.put_string ("%"%N%TSyntax error, line ");
			io.error.put_integer (line_number);
			io.error.put_string (": ");
			io.error.put_string (message);
			io.error.put_new_line;
			read_line
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class RESOURCE_PARSER
