indexing
	description: "Store objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SERIALIZER

inherit
	ANY

	SED_STORABLE_FACILITIES
		export
			{NONE} all
		end

	SHARED_LOGGER
		export
			{NONE} all
		end

feature -- Status report

	successful: BOOLEAN
			-- Was last operation successful?

	error_message: STRING
			-- Reason for failure
			
	last_file_position: INTEGER
			-- Position after last serialization

feature -- Basic Operations

	serialize (a: ANY; path: STRING; is_appending: BOOLEAN) is
			-- Serialize object `a' at the end of file `path' if `is_appending', otherwise
			-- reset content of `path'.
			-- Set `last_file_position' after storing.
		require
			non_void_object: a /= Void
			non_void_path: path /= Void
		local
			l_raw_file: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
		do
			if not retried then
				if is_appending then
					create l_raw_file.make_open_append (path)
				else
					create l_raw_file.make_open_write (path)
				end
				create l_writer.make (l_raw_file)
				l_writer.set_for_writing
				independent_store (a, l_writer, False)
				last_file_position := l_raw_file.count
				successful := True
			else
				successful := False
				error_message := "Cannot store into " + path
			end
			if l_raw_file /= Void and then not l_raw_file.is_closed then
				l_raw_file.close
			end
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			retried := True
			retry
		end

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


end
