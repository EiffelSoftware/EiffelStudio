note
	description: "Summary description for {IRON_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_ARGUMENTS

feature -- Arguments

	is_verbose_switch_used: BOOLEAN = True

	version_switch: IMMUTABLE_STRING_32
		deferred
		end

	logo_switch: IMMUTABLE_STRING_32
		deferred
		end

	verbose_switch: STRING = "v|verbose"

	simulation_switch: STRING = "n|simulation"

	batch_switch: STRING = "b|batch"

	interactive_switch: STRING = "i|interactive"

	fill_argument_switches (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			add_verbose_switch (a_switches)
			add_version_switch (a_switches)
			add_logo_switch (a_switches)
		end

	add_logo_switch (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			a_switches.extend (create {ARGUMENT_SWITCH}.make (logo_switch, "Display logo information", True, False))
		end

	add_version_switch (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			a_switches.extend (create {ARGUMENT_SWITCH}.make (version_switch, "Display version information", True, False))
		end

	add_verbose_switch (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			a_switches.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output", True, False))
		end

	add_batch_interactive_switch (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			a_switches.extend (create {ARGUMENT_SWITCH}.make (batch_switch, "Batch mode", True, False))
			a_switches.extend (create {ARGUMENT_SWITCH}.make (interactive_switch, "Interactive mode", True, False))
		end

	add_simulation_switch (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			a_switches.extend (create {ARGUMENT_SWITCH}.make (simulation_switch, "Simulation mode", True, False))
		end

feature -- Access

	has_option (a_name: READABLE_STRING_GENERAL): BOOLEAN
		deferred
		end

	verbose: BOOLEAN
		do
			Result := has_option (verbose_switch)
		end

	is_simulation: BOOLEAN
		do
			Result := has_option (simulation_switch)
		end

	is_batch: BOOLEAN
		do
			Result := has_option (batch_switch) and not has_option (interactive_switch)
		end

feature -- Access		

	copyright: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ("Copyright Eiffel Software 2011-2024. All Rights Reserved.")
		end
	
	version: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ((create {IRON_CONSTANTS}).version)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
