note
	description: "In memory representation of a PE file for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_CLI_PE_FILE

inherit
	CLI_PE_FILE

	CIL_PE_FILE -- From library "il_emitter"
		rename
			md_method_writer as method_writer
		end

	MD_UTILITIES
		export
			{NONE} padding, file_alignment
		end

	REFACTORING_HELPER

create
	make

feature -- Access

	debug_directory: detachable CLI_DEBUG_DIRECTORY
		do
			to_implement ("Not yet implemented")
		end

	debug_info: detachable MANAGED_POINTER
			-- Data for storing debug information in PE files.
		do
			to_implement ("Not yet implemented")
		end

	public_key: detachable MD_PUBLIC_KEY
		do
			to_implement ("Not yet implemented")
		end

	signing: detachable MD_STRONG_NAME
			-- Hold data for strong name signature.
		do
			to_implement ("Not yet implemented")
		end

	resources: detachable CLI_RESOURCES
			-- Hold data for resources.
		do
			to_implement ("Not yet implemented")
		end

	cli_header_has_flag_strong_name_signed: BOOLEAN
			-- Has CLI Header flag "strong_name_signed" ?
		do
			to_implement ("Not yet implemented")
		end

feature -- Settings

	set_entry_point_token (token: INTEGER)
			-- Set `token' as entry point of current CLI image.
		do
			to_implement ("Not yet implemented")
		end

	set_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_debug_info: MANAGED_POINTER)

			-- Set `debug_directory' to `a_cli_debug_directory' and `debug_info'
			-- to `a_debug_info'.
		do
			to_implement ("Not yet implemented")
		end

	set_public_key (a_key: like public_key; a_signing: like signing)
			-- Set `public_key' to `a_key'.
		do
			to_implement ("Not yet implemented")
		end

	set_resources (r: like resources)
			-- Set `resources' with `r'
		do
			to_implement ("Not yet implemented")
		end


note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
