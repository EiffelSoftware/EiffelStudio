note
	description: "[
				Abstraction of CONF_SYSTEM and CONF_REDIRECTION as a file {CONF_FILE}.
				This includes routines about the `location' of the file (i.e the file path).
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_FILE

inherit
	ANY

	CONF_FILE_DATE
		export
			{NONE} all
		end

feature -- Status

	store_successful: BOOLEAN
			-- Was the last `store' operation successful?

	date_has_changed: BOOLEAN
			-- Did the file modification date of the configuration file change?
		require
			is_location_set: is_location_set
		do
			Result := file_modified_date (file_name) /= file_date
		end

	is_location_set: BOOLEAN
			-- Has the location of the configuration file been set?
		do
			Result := file_name /= Void and then not file_name.is_empty
		end

	is_storable: BOOLEAN
			-- Is current system storable?
			-- See `store'.
		local
			l_file: PLAIN_TEXT_FILE
		do
			if is_location_set and then attached file_name as l_file_name then
				create l_file.make_with_name (l_file_name)
				Result := (l_file.exists and then l_file.is_writable) or else l_file.is_creatable
			end
		end

feature -- Access, in compiled only

	directory: detachable PATH
			-- Directory where the configuration file is stored in platform specific format.

	file_name: detachable STRING_32
			-- File name of config file.

	file_path: detachable PATH
			-- File path of config file.
		do
			if attached file_name as fn then
				create Result.make_from_string (fn)
			end
		end

	file_date: INTEGER
			-- File modification date of config file.

feature -- Update, in compiled only

	set_file_name (a_file_name: like file_name)
			-- Set `file_name' to `a_file_name' and set `directory'.
		require
			a_file_name_valid: a_file_name /= Void implies not a_file_name.is_empty
		local
			fp: PATH
		do
			if a_file_name = Void then
				file_name := Void
				directory := Void
				file_date := 0
			else
				file_name := a_file_name
				create fp.make_from_string (a_file_name)
				directory := fp.parent
			end
		ensure
			name_set: file_name = a_file_name
			is_location_set: a_file_name /= Void implies is_location_set
		end

	set_file_date
			-- Set `file_date' to last modified date of `file_name'.
		require
			is_location_set: is_location_set
		do
			if attached file_name as fn then
				check is_location_set: not fn.is_empty end
				file_date := file_modified_date (fn)
			else
				file_date := 0
			end
		end

feature -- Conversion

	text: detachable READABLE_STRING_8
			-- Text representation of Current,
			-- Void if error occured.
		local
			l_print: CONF_PRINT_VISITOR
		do
			create l_print.make
			process (l_print)
			if not l_print.is_error then
				Result := l_print.text
			end
		end

feature -- Store to disk

	store
			-- Store system back to its config file (only system itself is stored, libraries are not stored).
		require
			is_location_set: is_location_set
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
		do
			store_successful := False
			create l_print.make
			process (l_print)
			if
				not l_print.is_error and
				attached file_name as fn -- implied by precondition `is_location_set'
			then
				create l_file.make_with_name (fn)
				if (l_file.exists and then l_file.is_writable) or else l_file.is_creatable then
					l_file.open_write
					l_file.put_string (l_print.text)
					l_file.close
					store_successful := True
				end
			end
		end

feature -- Visitor

	process (vis: CONF_VISITOR)
			-- Accept visitor `vis'
			--| i.e CONF_SYSTEM or CONF_REDIRECTION
		deferred
		end

invariant
	location_set: is_location_set implies attached file_name as fn and then not fn.is_empty and directory /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

