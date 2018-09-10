note
	description: "An implementation of a verifier service using AutoProof."

class
	ES_AUTOPROOF_VERIFIER

inherit
	DISPOSABLE_SAFE
	VERIFIER_S

feature -- Status report

	is_running: BOOLEAN
			-- Is prover running?
		do
			Result := autoproof.is_running
		end

feature -- Verification

	verify_feature (f: E_FEATURE)
			-- <Precursor>
		do
			autoproof_command.execute_with_stone (create {FEATURE_STONE}.make (f))
		end

	verify_class (c: CLASS_C)
			-- <Precursor>
		do
			autoproof_command.execute_with_stone (create {CLASSC_STONE}.make (c))
		end

feature {NONE} -- Verification engine

	autoproof: E2B_AUTOPROOF
			-- Shared autoproof instance.
		once
			create Result.make
		end

	autoproof_command: ES_AUTOPROOF_COMMAND
			-- Shared autoproof command.
		once
			create Result.make
		ensure
			instance_free: class
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2018, Eiffel Software"
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
