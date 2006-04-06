indexing
	description: "Loads a configuration from a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD

inherit
	SHARED_CONF_FACTORY

	CONF_ACCESS

feature -- Status

	is_error: BOOLEAN
			-- Was there an error during the retrieval?

	last_error: CONF_ERROR
			-- The last error message.

feature -- Access

	last_system: CONF_SYSTEM
			-- The last retrieved system.

	last_uuid: UUID
			-- The last retrieved uuid.

feature -- Basic operation

	retrieve_configuration (a_file: STRING) is
			-- Retreive the configuration in `a_file' and make it available in `last_system'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_callback: CONF_LOAD_PARSE_CALLBACKS
			l_directory: STRING
			i, cnt: INTEGER
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
			create l_callback.make
			parse_file (a_file, l_callback)
			if l_callback.is_error then
				is_error := True
				l_callback.last_error.set_file (a_file)
				last_error := l_callback.last_error
			elseif not is_error then
				last_system := l_callback.last_system
				last_system.set_file_name (a_file)
				last_system.set_file_date
				cnt := a_file.count
				i := a_file.last_index_of ('/',cnt)
				if i = 0 then
					i := a_file.last_index_of ('\', cnt)
				end
				check
					filename_start_found: i >= 0
				end
				l_directory := a_file.substring (1, i)
				from
					l_targets := last_system.targets
					l_targets.start
				until
					l_targets.after
				loop
					l_targets.item_for_iteration.set_location (l_directory)
					l_targets.forth
				end
			end
		ensure
			no_error_implies_last_system_not_void: not is_error implies last_system /= Void
		end

	retrieve_uuid (a_file: STRING) is
			-- Retrieve the uuid of the configuration in `a_file' and make it available in `last_uuid'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_callback: CONF_LOAD_UUID_CALLBACKS
		do
			create l_callback.make
			parse_file (a_file, l_callback)
			if l_callback.is_error then
				is_error := True
				l_callback.last_error.set_file (a_file)
				last_error := l_callback.last_error
			else
				last_uuid := l_callback.last_uuid
			end
		ensure
			no_error_implies_last_uuid_not_void: not is_error implies last_uuid /= Void
		end


feature {NONE} -- Implementation

	parse_file (a_file: STRING; a_callback: CONF_LOAD_CALLBACKS) is
			-- Parse `a_file' using `a_callbacks'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_callback_not_void: a_callback /= Void
		local
			l_file: KL_TEXT_INPUT_FILE
			l_test_file: PLAIN_TEXT_FILE
			l_parser: XM_PARSER
			l_ns_cb: XM_NAMESPACE_RESOLVER
		do
			is_error := False

			create {XM_EIFFEL_PARSER} l_parser.make

			create l_ns_cb.set_next (a_callback)
			l_parser.set_callbacks (l_ns_cb)

			create l_file.make (a_file)
			create l_test_file.make (a_file)
			l_file.open_read
			if not l_file.is_open_read or else not l_test_file.is_plain then
				is_error := True
				last_error := create {CONF_ERROR_FILE}.make (a_file)
			else
				l_parser.parse_from_stream (l_file)
				l_file.close
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
end
