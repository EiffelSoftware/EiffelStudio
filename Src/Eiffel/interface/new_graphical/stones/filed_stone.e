indexing
	description: "Stone that has a file name associated with it."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	FILED_STONE 

inherit
	STONE
		redefine
			is_valid,
			synchronized_stone
		end
	
feature -- Access

	file_name: FILE_NAME is 
			-- Name of the file which parsing led 
			-- to the creation of current AST node.
		deferred
		end

	origin_text: STRING is
			-- Content of the file named `file_name'
			-- Void if unreadable file.
		local
			a_file: RAW_FILE
		do
			if is_valid then
				create a_file.make (file_name)
				if a_file.exists and then a_file.is_readable then
					a_file.open_read
					a_file.read_stream (a_file.count)
					a_file.close
					Result := a_file.last_string
				end
			end
		end

	is_valid: BOOLEAN is
			-- Does `Current' still represent a valid file?
		local
			testfile: RAW_FILE
		do
			create testfile.make (file_name)
			if testfile.exists then
				Result := True
			end
		end

	synchronized_stone: STONE is
			-- Valid stone corresponding to `Current' if `is_valid'
			-- or Void if not.
		do
			if is_valid then
				Result := Current
			end
		end
		
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

end -- class FILED_STONE
