note

	description: 
		"Converts input file to a `Makefile'"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$" 

class CONVERTER

create

	make

feature {NONE} -- Initialization

	make (arguments: ARRAY [STRING])
			-- Converts input file to a `Makefile'.
			-- Arguments: <input_file> [<output_file>].
			-- The input_file is the name of file to be converted.
		local
			i_file_name: FILE_NAME
		do
			if not (arguments.count = 2 or else arguments.count = 3) then
				print ("Incorrect usage: ")
				print (arguments.item (0));
				print (" <input file> [<output_file>]");
				error := True
			else
				create i_file_name.make_from_string (arguments.item (1));
				create input_file.make (i_file_name);
				if 
					not configure_file.exists or else
					not configure_file.is_readable
				then
					print ("Cannot read file configuration file ")
					print (configure_file.name);
					error := True
				elseif 
					not input_file.exists or else
					not input_file.is_readable
				then
					print ("Cannot read input file ")
					print (i_file_name);
					error := True
				end

				if arguments.count = 3 then
					output_file_name := clone (arguments.item (2))
				end
			end;
			if not error then
				process_configure_file;
				if not error then
					convert_file
				end
			end;
		end

feature {NONE} -- Access

	error: BOOLEAN
			-- Did an error occur?

	configure_file: RAW_FILE
			-- Name of the configure file
		local	
			f_name: FILE_NAME
		once
			create f_name.make_from_string ("config");
			f_name.add_extension ("sh");
			create Result.make (f_name);
		end

	input_file: RAW_FILE
			-- Name of the input file to be converted

	Configure_name: STRING = "-configure";
			-- Name of the configure option on the command line

	configure_list: LINKED_LIST [CONFIGURE_VALUE]
			-- List of configure value found in `configure_file'

	output_file_name: STRING
			-- Specified output name

	makefile: RAW_FILE
			-- Makefile file
		local	
			f_name: FILE_NAME
		once
			if output_file_name /= Void then
				create f_name.make_from_string (output_file_name);
			else
				create f_name.make_from_string ("makefile");
			end
			create Result.make (f_name)
		end

feature {NONE} -- Update

	process_configure_file
			-- Process file `configure_file' and fill `configure_list'.
		require
			valid_configure_file: configure_file /= Void and then
					configure_file.exists and then
					configure_file.is_readable
		local
			configure_line: STRING
		do
			create configure_list.make;
			if not configure_file.empty then
				configure_file.open_read;
				from
					configure_file.read_line
				until
					configure_file.end_of_file or else error
				loop
					configure_line := configure_file.last_string;
					if 
						not configure_line.empty and then
						configure_line.item (1) /= '#'
					then
						analyze_configure_line (configure_line)
					end;
					configure_file.read_line
				end
				configure_file.close
			end
			debug ("CONFIGURE")
				if not error then
					print ("Processing option file%N");
					from
						configure_list.start
					until
						configure_list.after
					loop
						configure_list.item.trace;
						configure_list.forth
					end
					io.put_new_line;
					io.read_line
				end
			end
		end;

	convert_file
			-- Convert file `input_file' using `option_list' to 
			-- generate `Makefile' in the current working directory.
		require
			valid_input_file: input_file /= Void and then
					input_file.exists and then
					input_file.is_readable;
			valid_configure_list: configure_list /= Void
		local
			output: STRING;
			c_value: CONFIGURE_VALUE
		do
			if makefile.is_creatable then
				debug ("CONVERTING")
					print ("Converting input file%N");
					io.put_new_line;
					io.read_line
				end				
				if not input_file.empty then
					input_file.open_read;
					input_file.read_stream (input_file.count);
					input_file.close;
					output := clone (input_file.last_string);
					from
						configure_list.start
					until
						configure_list.after
					loop
						c_value := configure_list.item;
						output.replace_substring_all
							(c_value.name, c_value.value)
						configure_list.forth
					end
					makefile.open_write;
					makefile.put_string (output);
					makefile.close
				end
			else
				print ("Cannot create makefile")
			end
		end;

	analyze_configure_line (configure_line: STRING)
			-- Analyze `configure_list' and extract the
			-- configure values. Set `error' to true if
			-- an error occurs.
		require
			valid_line: configure_line /= Void;
			line_not_empty: not configure_line.empty
		local
			colon_pos, start_quote_pos, end_quote_pos: INTEGER;
			count: INTEGER;
			msg: STRING;
			name, value: STRING;
			c_value: CONFIGURE_VALUE
		do
			colon_pos := configure_line.index_of ('=', 1);
			count := configure_line.count;
			if (colon_pos <= 1) or else (colon_pos >= count) then
				error := True;
				msg := "Could not process `="
			else
				start_quote_pos := 
					configure_line.index_of ('%'', colon_pos + 1);
	
				if (start_quote_pos = 0) or else (start_quote_pos >= count) then
					msg := "Could not process first quote"
					error := True
				else	
					end_quote_pos := 
						configure_line.index_of ('%'', start_quote_pos + 1);
					if end_quote_pos = 0 then
						msg := "Could not process second quote"
						error := True
					else
						create name.make (10);
						name.extend ('$');
						name.append (configure_line.substring (1, colon_pos - 1));
						start_quote_pos := start_quote_pos + 1;
						end_quote_pos := end_quote_pos - 1;
						if start_quote_pos > end_quote_pos then
							value := ""
						else
							value := configure_line.substring 
								(start_quote_pos, end_quote_pos)
						end
					end
				end
			end
			if error then	
				print (msg)
				io.put_new_line;
				print ("usage: <name>: %"<value>%"");
			else
				create c_value.make (name, value);
				configure_list.extend (c_value)
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CONVERTER
