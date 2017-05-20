note
	description: "Callbacks needed to load an uuid from a configuration file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_UUID_CALLBACKS

inherit
	CONF_LOAD_CALLBACKS
		redefine
			on_start_tag,
			on_attribute,
			on_end_tag
		end

create
	make_with_file

feature {NONE} -- Initialization

	make_with_file (a_file: STRING_32)
		do
			file_name := a_file
			make
		end

feature -- Access

	file_name: STRING_32
			-- Path of the file being parsed.

	last_uuid: detachable UUID
			-- The last parsed uuid.

	last_redirected_location: detachable READABLE_STRING_GENERAL
			-- The last parsed location from <redirection location=".." />

	last_location: like last_redirected_location
			-- The last parsed location from <redirection location=".." />
		obsolete
			"Use directly last_redirected_location [Dec/2016]"
		do
			Result := last_redirected_location
		end

feature -- Callbacks

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Start of start tag.
		do
			if not is_error then
					-- check version
				check_version (a_namespace)

				is_system := a_local_part.is_case_insensitive_equal_general ("system")
				is_redirection := a_local_part.is_case_insensitive_equal_general ("redirection")
			end
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Start of attribute.
		do
			if not is_error then
				if
					(is_system or is_redirection) and
					a_local_part.is_case_insensitive_equal_general ("uuid")
				then --| xml attribute "uuid", relevant only for <system..> or <redirection..>
					if is_valid_uuid (a_value) then
						create last_uuid.make_from_string (a_value)
					else
						set_error (create {CONF_ERROR_UUID})
					end
				elseif --| xml attribute "location", relevant only for <redirection..>
					is_redirection and then
					a_local_part.is_case_insensitive_equal_general ("location")
				then
					last_redirected_location := a_value
				end
			end
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- End tag.
		do
			if not is_error then
				is_system := False
				is_redirection := False
			end
		end

feature {NONE} -- Implementation

	is_system: BOOLEAN
			-- Are we in a system tag?

	is_redirection: BOOLEAN
			-- Are we in a redirection tag?

invariant
	is_not_system_and_redirection: not (is_system and is_redirection)

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
