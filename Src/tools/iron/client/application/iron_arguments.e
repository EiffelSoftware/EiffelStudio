note
	description: "Summary description for {IRON_ARGUMENTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_ARGUMENTS

feature -- Arguments

	verbose_switch: STRING = "v|verbose"

	simulation_switch: STRING = "n|simulation"

	batch_switch: STRING = "b|batch"

	interactive_switch: STRING = "i|interactive"

	fill_argument_switches (a_switches: ARRAYED_LIST [ARGUMENT_SWITCH])
		do
			add_verbose_switch (a_switches)
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
			create Result.make_from_string_general ("Copyright Eiffel Software 2011-2013. All Rights Reserved.")
		end

	version: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ((create {IRON_CONSTANTS}).version)
		end

end
