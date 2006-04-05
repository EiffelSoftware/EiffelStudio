indexing
	description: "Template file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	PLAIN_TEXT_TEMPLATE_FILE
	
create
	make
	
feature {NONE} -- Implementation

	make (atemplate_filename: STRING) is
			-- create an instance of this object
		require
			template_file_exists: (create {PLAIN_TEXT_FILE}.make (atemplate_filename)).exists
		do
			create symbol_table.make (13)
			symbol_table.compare_objects
			template_filename := atemplate_filename.twin
		end
	
feature -- Access

	symbol_value (asymbol: STRING): STRING is
			-- retrieve a symbols value
		require
			symbol_exists: symbol_table.has (format_symbol (asymbol))
		do
			Result := symbol_table.item (format_symbol (asymbol))
		ensure
			non_void_Result: Result /= Void
			non_empty_Result: not Result.is_empty
		end
		
	symbol_table: HASH_TABLE [STRING, STRING]
		-- hash table of symbols and their associated values
		
	current_line: STRING
		-- current line that has been read from the template - and to be written to the file after process_token

	do_not_write: BOOLEAN
		-- is the output being written to?
		
	template_filename: STRING
		-- the source template file
		
feature -- Basic Operations

	add_symbol (asymbol, avalue: STRING) is
			-- add a new symbol 'asymbol' with the value 'avalue' to 'symbol_table'
		require
			non_void_symbol: asymbol /= Void
			non_empty_symbol: not asymbol.is_empty
			non_void_value: avalue /= Void
			symbol_exists: not symbol_table.has (format_symbol (asymbol))
		do
			symbol_table.put (avalue, format_symbol (asymbol))
		ensure
			symbol_added: symbol_table.has (format_symbol (asymbol))
		end
		
	remove_symbol (asymbol: STRING) is
			-- remove the symbol 'asymbol' from 'symbol_table'
		require
			non_void_symbol: asymbol /= Void
			non_empty_symbol: not asymbol.is_empty
			symbol_exists: symbol_table.has (format_symbol (asymbol))
		do
			symbol_table.remove (asymbol)
		ensure
			symbol_removed: not symbol_table.has (format_symbol (asymbol))
		end
		
	save_file (afilename: STRING) is
			-- save a text file created from the template file
		local
			template: PLAIN_TEXT_FILE
			output: PLAIN_TEXT_FILE
		do
			create template.make_open_read (template_filename)
			create output.make_open_write (afilename)
			
			from
			until
				template.end_of_file
			loop
				template.read_line
				if not do_not_write then
					pre_process_line (template.laststring, 1)
					check
						non_void_current_line: current_line /= Void
					end
					output.putstring (current_line)
					if current_line.count > 0 and current_line.item (current_line.count) /= '%N' then
						output.new_line
					end
				end
			end
			
			template.close
			output.close
		end
		
feature {NONE} -- Basic Operations
		
	pre_process_line (in: STRING; astart_pos: INTEGER) is
			-- recieves a line from the template file and returns the result
		require
			non_void_in: in /= Void
			start_pos_greater_than_zero: astart_pos > 0
		local
			var_start: INTEGER
			var_end: INTEGER
			var: STRING
		do
			current_line := in.twin
			if astart_pos < in.count then
				var_start := in.substring_index (start_token, astart_pos)
				if var_start > 0 then
					var_end := in.substring_index (end_token, var_start + 2)
					if var_end > 0 then
						var := in.substring (var_start, var_end)
						var.to_upper
						process_token (var, var_start)
						pre_process_line (current_line, var_end + 1)					
					end
				end
			end
		end
		
	process_token (token: STRING; token_pos: INTEGER) is
		local
			unwrapped_token: STRING
		do
			unwrapped_token := unwrap_token (token)
			if token_commands.has (unwrapped_token) then
				--| cut token up
			else
				if symbol_table.has (unwrapped_token) then
					current_line.replace_substring_all (token, symbol_table.item (unwrapped_token))
				end
			end
		end
		
feature -- Formatting

	format_symbol (asymbol: STRING): STRING is
			-- format a symbol name
		do
			Result := asymbol.twin
			Result.to_upper
			Result.replace_substring_all (" ", "")
		end
	
feature {NONE} -- Formatting

	wrap_token (atoken: STRING): STRING is
			-- format a token name into a template file token
		require
			non_void_token: atoken /= Void
			non_empty_token: not atoken.is_empty
		do
			Result := atoken.twin
			Result.prepend (start_token)
			Result.append (end_token)
			Result.to_upper
		ensure
			non_void_Result: Result /= Void
			non_empty_Result: not Result.is_empty
		end
		
	unwrap_token (atoken: STRING): STRING is
			-- remove the leading and trailing characters from 'atoken'
		require
			non_void_token: atoken /= Void
			valid_token_length: atoken.count >= start_token.count + end_token.count
		do
			Result := atoken.substring (start_token.count + 1, atoken.count - end_token.count)
		ensure
			non_void_Result: Result /= Void
		end
		
	
feature -- Element Change

	set_symbol_value (asymbol, avalue: STRING) is
			-- set a symbol value
		require
			non_void_symbol: asymbol /= Void
			non_empty_symbol: not asymbol.is_empty
			non_void_value: avalue /= Void
			symbol_exists: symbol_table.has (asymbol)
		do
			symbol_table.replace (avalue, asymbol)
		ensure
			symbol_value_set: symbol_table.item (asymbol).is_equal (avalue)
		end
		
	set_do_not_write (avalue: BOOLEAN) is
			-- set the write status of the output file
		do
			do_not_write := avalue
		end
		
	
feature {NONE} -- Implementation

	start_token: STRING is "[!"
			-- Start token character(s)
			
	end_token: STRING is "]"
			-- End token character(s)

	token_commands: HASH_TABLE [PROCEDURE [ANY, TUPLE [STRING, STRING]], STRING] is
			-- Hash table of [processing agent (source_line, token_name), token name]
		do
			create Result.make (1)
		end
		
invariant
	non_void_start_token: start_token /= Void
	non_empty_start_token: not start_token.is_empty
	non_void_end_token: end_token /= Void
	non_empty_end_token: not end_token.is_empty
	non_void_token_commands: token_commands /= Void
	non_void_template_filename: template_filename /= Void
	non_empty_template_filename: not template_filename.is_empty
	
indexing
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
end -- class PLAIN_TEXT_TEMPLATE_FILE