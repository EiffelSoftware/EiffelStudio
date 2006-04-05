indexing
	description: "To generate private key for .NET systems."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_KEY_GENERATOR

create
	default_create

feature -- Initialization

	generate_key (a_filename, a_runtime_version: STRING) is
			-- Generate a new key pair with 'a_filename' as filename for the specified
			-- .NET version
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
			a_runtime_version_not_void: a_runtime_version /= Void
		local
			a_file: RAW_FILE
			l_public_key: MANAGED_POINTER
			retried: BOOLEAN
			l_status: INTEGER
			l_signing: MD_STRONG_NAME
		do
			if not retried then
				status := No_error
				create l_signing.make_with_version (a_runtime_version)
				if l_signing.exists then
					l_public_key := l_signing.new_public_private_key_pair
					create a_file.make (a_filename)
					l_status := 2
					a_file.open_write
					l_status := 3
					a_file.put_managed_pointer (l_public_key, 0, l_public_key.count)
					l_status := 4
					a_file.close
					l_status := 5
				else
					status := Could_not_load_mscorsn_dll
				end
			end
		rescue
			retried := True
			inspect status
			when 0 then status := No_error
			when 1 then status := Could_not_generate_key
			when 2 then status := Could_not_open_in_write_mode
			when 3 then status := Could_not_write_to_file
			when 4 then status := Could_not_close_file
			when 5 then status := Could_not_free_data
			else
				status := Unknown_error
			end
			retry
		end

feature -- Status report

	successful: BOOLEAN is
			-- Was call to `generate_key' successful?
		do
			Result := status = No_error
		end

	error_message: STRING is
			-- Associated error message if not successful.
		do
			inspect
				status
			when No_error then Result := "No error."
			when Could_not_generate_key then Result := "Key could not be generated."
			when Could_not_close_file then Result := "Key file could not be closed."
			when Could_not_free_data then Result := "Key data could not be freed."
			when Could_not_load_mscorsn_dll then Result := "Could not load `mscorsn.dll' in memory."
			when Could_not_open_in_write_mode then Result := "Could not open key file in write mode."
			when Could_not_write_to_file then Result := "Could not write to key file."
			else
				Result := "Unknown error."
			end
		ensure
			error_message_not_void: Result /= Void
		end

feature {NONE} -- Access		

	status: INTEGER

feature {NONE} -- Constants

	No_error: INTEGER is 0
	Could_not_generate_key: INTEGER is 1
	Could_not_open_in_write_mode: INTEGER is 2
	Could_not_write_to_file: INTEGER is 3
	Could_not_close_file: INTEGER is 4
	Could_not_free_data: INTEGER is 5
	Could_not_load_mscorsn_dll: INTEGER is 6
	Unknown_error: INTEGER is 7;
			-- Status after call to `generate_key'.

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

end -- class IL_KEY_GENERATOR
