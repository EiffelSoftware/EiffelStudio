note
	description	: "Information entered so far by the user in the profiler wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_INFORMATION

inherit
	EB_WIZARD_INFORMATION

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature  {NONE} -- Initialization

	make
			-- Assign default values
		do
			set_workbench_mode

			wkb_existing_profile := find_execution_profile (True)
			flz_existing_profile := find_execution_profile (False)

			wkb_generate_execution_profile := (wkb_existing_profile = Void)
			flz_generate_execution_profile := (flz_existing_profile = Void)

			wkb_runtime_information_record := project_location.workbench_path.extended ("profinfo")
			flz_runtime_information_record := project_location.final_path.extended ("profinfo")

			wkb_runtime_information_type := "eiffel"
			flz_runtime_information_type := "eiffel"

			set_query (default_query)
			set_output_switches (True, True, True, True, True, True)
			set_language_switches (True, False, False)
		ensure
			query_not_void: query /= Void
		end

feature -- Access

	workbench_mode: BOOLEAN
			-- Analyse a system compiled in workbench mode?

	finalized_mode: BOOLEAN
			-- Analyse a system compiled in finalized mode?
		do
			Result := not workbench_mode
		end

	generate_execution_profile: BOOLEAN
			-- Generate the execution profile from a Run-time information record?
		do
			if workbench_mode then
				Result := wkb_generate_execution_profile
			else
				Result := flz_generate_execution_profile
			end
		end

	use_existing_execution_profile: BOOLEAN
			-- Use an execution profile?
		do
			Result := not generate_execution_profile
		end

	existing_profile: PATH
			-- Existing profile to use, Void if none
		do
			if workbench_mode then
				Result := wkb_existing_profile
			else
				Result := flz_existing_profile
			end
		end

	runtime_information_record: PATH
			-- Runtime information record to use when generating the execution profile
		do
			if workbench_mode then
				Result := wkb_runtime_information_record
			else
				Result := flz_runtime_information_record
			end
		end

	runtime_information_type: STRING
			-- Type of profiler used to produce `runtime_information_record'
			-- (gcc profiler, eiffel profiler, ...)
		do
			if workbench_mode then
				Result := wkb_runtime_information_type
			else
				Result := flz_runtime_information_type
			end
		end

	name_switch: BOOLEAN
			-- Switch for the feature names

	number_of_calls_switch: BOOLEAN
			-- Switch for the number of calls

	percentage_switch: BOOLEAN
			-- Switch for the percentage of time

	time_switch: BOOLEAN
			-- Switch for the amount of time
			-- spent in the function itself

	descendant_switch: BOOLEAN
			-- Switch for the amount of time
			-- spent in the called functions

	total_time_switch: BOOLEAN
			-- Switch for the amount of time
			-- spent in both the function itself
			-- and the called ones.

	eiffel_switch: BOOLEAN
			-- Switch for output of eiffel features

	c_switch: BOOLEAN
			-- Switch for output of c functions

	recursive_switch: BOOLEAN
			-- Switch for display of recursive funtions.

	query: STRING
			-- query input

	default_query: STRING = "calls > 0"
			-- Default query input

	generation_path: PATH
			-- Generation path for "profinfo.pfi"
		do
			if workbench_mode then
				Result := project_location.workbench_path
			else
				Result := project_location.final_path
			end
		end

feature -- Element change

	set_workbench_mode
			-- Analyse a system compiled in workbench mode.
		do
			workbench_mode := True
		ensure
			Result_set: workbench_mode
		end

	set_finalized_mode
			-- Analyse a system compiled in finalized mode.
		do
			workbench_mode := False
		ensure
			Result_set: finalized_mode
		end

	set_generate_execution_profile
			-- Generate the execution profile from a Run-time information record.
		do
			if workbench_mode then
				wkb_generate_execution_profile := True
			else
				flz_generate_execution_profile := True
			end
		ensure
			flag_set: generate_execution_profile
		end

	set_use_existing_execution_profile (an_existing_profile: like existing_profile)
			-- Use the existring execution profile named `an_existing_profile'.
		require
			valid_profile: an_existing_profile /= Void
		do
			if workbench_mode then
				wkb_generate_execution_profile := False
				wkb_existing_profile := an_existing_profile
			else
				flz_generate_execution_profile := False
				flz_existing_profile := an_existing_profile
			end
		ensure
			flag_set: use_existing_execution_profile
			profile_not_void: existing_profile /=  Void
			profile_set: existing_profile.is_equal (an_existing_profile)
		end

	set_runtime_information_record (a_record: PATH)
			-- Set the Runtime information record to use when generating
			-- the execution profile to `a_record'.
		require
			valid_record: a_record /= Void
			a_record_has_entry: attached a_record.entry
		do
			if workbench_mode then
				wkb_runtime_information_record := a_record
			else
				flz_runtime_information_record := a_record
			end
		ensure
			runtime_information_not_void: runtime_information_record /= Void
			runtime_information_set: runtime_information_record.is_equal (a_record)
		end

	set_runtime_information_type (a_profiler: STRING)
			-- Set the type of profiler used to produce `runtime_information_record'
			-- to `a_profiler'.
		require
			valid_profiler: a_profiler /= Void
		do
			if workbench_mode then
				wkb_runtime_information_type := a_profiler
			else
				flz_runtime_information_type := a_profiler
			end
		ensure
			type_not_void: runtime_information_type /= Void
			type_set: runtime_information_type.is_equal (a_profiler)
		end

	set_output_switches (
			a_name_switch: BOOLEAN;
			a_number_of_calls_switch: BOOLEAN;
			a_percentage_switch: BOOLEAN;
			a_time_switch: BOOLEAN;
			a_descendant_switch: BOOLEAN;
			a_total_time_switch: BOOLEAN)
		do
			name_switch := a_name_switch
			number_of_calls_switch := a_number_of_calls_switch
			percentage_switch := a_percentage_switch
			time_switch := a_time_switch
			descendant_switch := a_descendant_switch
			total_time_switch := a_total_time_switch
		end

	set_language_switches (
			a_eiffel_switch: BOOLEAN;
			a_c_switch: BOOLEAN;
			a_recursive_switch: BOOLEAN)
		do
			eiffel_switch := a_eiffel_switch
			c_switch := a_c_switch
			recursive_switch := a_recursive_switch
		end

	set_query (a_query: STRING)
			-- Set query input.
		require
			a_query_not_void: a_query /= Void
		do
			query := a_query
		ensure
			query_not_void: query /= Void
		end

feature {NONE} -- Implementation

	wkb_generate_execution_profile: BOOLEAN
			-- Generate the execution profile from a Run-time information record?

	flz_generate_execution_profile: BOOLEAN
			-- Generate the execution profile from a Run-time information record?

	wkb_existing_profile: PATH
			-- Existing profile to use (Workbench mode)

	flz_existing_profile: PATH
			-- Existing profile to use (Finalized mode)

	wkb_runtime_information_record: PATH
			-- Runtime information record to use when generating the
			-- execution profile (Workbench mode)

	flz_runtime_information_record: PATH
			-- Runtime information record to use when generating the
			-- execution profile (Finalized mode)

	wkb_runtime_information_type: STRING
			-- Type of profiler used to produce `runtime_information_record'
			-- (gcc profiler, eiffel profiler, ...)

	flz_runtime_information_type: STRING
			-- Type of profiler used to produce `runtime_information_record'
			-- (gcc profiler, eiffel profiler, ...)

	find_execution_profile (is_workbench_mode: BOOLEAN) : PATH
			-- Find an existing execution profile for the workbench
			-- compilation mode if `workbench_mode' is set, for the
			-- finalized mode otherwise.
			--
			-- Return Void if not found.
		local
			path: PATH
			files: ARRAYED_LIST [PATH]
			l_u: FILE_UTILITIES
		do
			if is_workbench_mode then
				path := project_location.workbench_path
			else
				path := project_location.final_path
			end
			files := l_u.ends_with (path, "." + Dot_profile_information, 0)

			if not files.is_empty then
				Result := files.first
			end
		end

invariant
	wkb_runtime_information_record_has_entry: attached wkb_runtime_information_record as l_wrecord and then attached l_wrecord.entry
	flz_runtime_information_record_has_entry: attached flz_runtime_information_record as l_frecord and then attached l_frecord.entry

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class EB_PROFILER_WIZARD_INFORMATION
