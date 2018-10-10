note
	description: "[
		The configuration redirection.
		It can be loaded from a configuration file by using CONF_LOAD and stored to a configuration file
		by using the store feature.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_REDIRECTION

inherit
	CONF_VISITABLE

	CONF_FILE

	DEBUG_OUTPUT

create {CONF_PARSE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_file_name: READABLE_STRING_GENERAL; a_redirection_location: READABLE_STRING_GENERAL; a_uuid: detachable UUID)
			-- Creation with `a_redirection_location' and `a_uuid'.
		require
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_redirection_location_not_empty: a_redirection_location /= Void and not a_redirection_location.is_empty
		do
			set_file_name (a_file_name)
			redirection_location := a_redirection_location
			uuid := a_uuid
		ensure
			file_name_set: a_file_name.same_string (file_name)
			redirection_location_set: redirection_location.same_string (a_redirection_location)
			uuid_set: uuid = a_uuid
		end

feature -- Access, stored in configuration file

	redirection_location: READABLE_STRING_GENERAL
			-- Location for the redirection.

	evaluated_redirection_location: READABLE_STRING_32
		local
			exp: STRING_ENVIRONMENT_EXPANDER
		do
			create exp
			Result := exp.expand_string_32 (redirection_location, False)
		end

	uuid: detachable UUID
			-- Universal unique identifier that identifies this system.

	message: detachable READABLE_STRING_32
			-- Optional message, reported as warning.

feature -- Element change

	set_message (m: detachable READABLE_STRING_GENERAL)
			-- Set `message' to `m'.
		do
			if m = Void then
				message := Void
			else
				create {STRING_32} message.make_from_string_general (m)
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_uuid (an_uuid: like uuid)
			-- Set `uuid' to `a_uuid'.
		do
			uuid := an_uuid
		ensure
			uuid_set: uuid = an_uuid
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_redirection (Current)
		end

feature -- Output

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := {STRING_32} "Redirection to " + redirection_location
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
