indexing
	description: "Retrieve objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DESERIALIZER

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

feature -- Access

	deserialized_object: ANY
			-- Last deserialized object

feature -- Status report

	successful: BOOLEAN
			-- Was last retrieval successful?

feature -- Basic Operations

	deserialize (path: STRING; a_pos: INTEGER) is
			-- Deserialize object previously serialized in `path' at position `a_pos'.
		require
			non_void_path: path /= Void
			valid_path: (create {RAW_FILE}.make (path)).exists
		local
			retried: BOOLEAN
			l_raw_file: RAW_FILE
			l_reader: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				create l_raw_file.make_open_read (path)
				l_raw_file.go (a_pos)
				create l_reader.make (l_raw_file)
				l_reader.set_for_reading
				deserialized_object := retrieved (l_reader, True)
				successful := deserialized_object /= Void
			else
				successful := False
			end
			if l_raw_file /= Void and then not l_raw_file.is_closed then
				l_raw_file.close
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
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
