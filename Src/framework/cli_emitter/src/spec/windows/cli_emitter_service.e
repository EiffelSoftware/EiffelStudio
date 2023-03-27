note
	description: "[
			Interface managing CLI emitter service (IL code generation).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_EMITTER_SERVICE

feature -- Settings

	is_using_il_emitter: BOOLEAN
			-- Is compiler using IL_EMITTER solution to generate CIL code?
		once
			Result := attached {EXECUTION_ENVIRONMENT}.item ("ISE_IL_EMITTER") as v and then
				v.is_case_insensitive_equal ("true")
		end

feature -- Setup

	setup_cil_code_generation (a_clr_runtime_version: detachable READABLE_STRING_GENERAL)
			-- Setup CIL code generation underlying services for the runtime `a_clr_runtime_version`.
		do
			if attached (create {CLR_HOST_FACTORY}).runtime_host (a_clr_runtime_version) as l_host then
					-- CLR Host initialized for `a_clr_runtime_version`
			else
				check clr_host_set: False end
			end
		end

feature -- Factory

	md_factory: CLI_FACTORY
		once
			if is_using_il_emitter then
				create {IL_EMITTER_CLI_FACTORY} Result
			else
				create {CLI_WRITER_CLI_FACTORY} Result
			end
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
