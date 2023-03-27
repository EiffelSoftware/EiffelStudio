note
	description: "Summary description for {IL_EMITTER_MD_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_CLI_FACTORY

inherit
	CLI_FACTORY

	REFACTORING_HELPER

feature -- Access

	debug_directory: CLI_DEBUG_DIRECTORY
		do
			create {IL_EMITTER_CLI_DEBUG_DIRECTORY} Result.make
		end

	pe_file (a_name: READABLE_STRING_32; console_app, dll_app, is_32bits_app: BOOLEAN; e: MD_EMIT): CLI_PE_FILE
		do
			check not_implemented: False then

			end
		end

	dispenser: MD_DISPENSER
		do
			create {IL_MD_DISPENSER} Result.make
		end

	dbg_writer (emitter: MD_EMIT; name: NATIVE_STRING; full_build: BOOLEAN): DBG_WRITER
		do
			debug ("refactor_fixme")
				to_implement ("TODO: DBG_WRITER")
			end
			check not_yet_implemented: False end

			create {IL_EMITTER_DBG_WRITER} Result.make (emitter, name, full_build)
		end

	strong_name (a_runtime_version: STRING_32): MD_STRONG_NAME
		do
			create {IL_MD_STRONG_NAME} Result.make_with_version (a_runtime_version)
		end

	assembly_info: MD_ASSEMBLY_INFO
		do
			create Result.make
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
