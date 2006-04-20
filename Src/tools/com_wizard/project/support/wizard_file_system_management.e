indexing
	description: "File system management (file copy, deletion)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FILE_SYSTEM_MANAGEMENT

feature -- Basic Operations

	file_copy (a_source, a_destination: STRING) is
			-- Copy file `a_source' into `a_destination'.
			-- Does nothing if `a_source' is not a file.
		require
			non_void_source: a_source /= Void
			non_void_destination: a_destination /= Void
			valid_source: not a_source.is_empty
			valid_destination: not a_destination.is_empty
		local
			a_file_source, a_file_dest: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create a_file_source.make (a_source)
				if a_file_source.exists then
					a_file_source.open_read
					a_file_source.read_stream (a_file_source.count)
					create a_file_dest.make_open_write  (a_destination)
					a_file_dest.put_string (a_file_source.last_string)
					a_file_source.close
					a_file_dest.close
				end
			end
		rescue
			retried := True
			retry
		end

	file_delete (a_file_name: STRING) is
			-- Delete file `a_file_name'.
			-- Do nothing if `a_file_name' not a valid file name.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			a_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create a_file.make (a_file_name)
				if a_file.exists then
					a_file.delete
				end
			end
		rescue
			retried := True
			retry
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
end -- class WIZARD_FILE_SYSTEM_MANAGEMENT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
