indexing
	description	: "Information entered so far by the user in the profiler wizard"
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

	make is
			-- Assign default values
		local
			filename: FILE_NAME
		do
			set_workbench_mode
			
			wkb_existing_profile := find_execution_profile (True)
			flz_existing_profile := find_execution_profile (False)
			
			wkb_generate_execution_profile := (wkb_existing_profile = Void)
			flz_generate_execution_profile := (flz_existing_profile = Void)
			
			create filename.make_from_string (workbench_generation_path)
			filename.set_file_name ("profinfo")
			wkb_runtime_information_record := filename
			create filename.make_from_string (final_generation_path)
			filename.set_file_name ("profinfo")
			flz_runtime_information_record := filename
			
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
			
	finalized_mode: BOOLEAN is
			-- Analyse a system compiled in finalized mode?
		do
			Result := not workbench_mode
		end

	generate_execution_profile: BOOLEAN is
			-- Generate the execution profile from a Run-time information record?
		do
			if workbench_mode then
				Result := wkb_generate_execution_profile
			else
				Result := flz_generate_execution_profile
			end	
		end

	use_existing_execution_profile: BOOLEAN is
			-- Use an execution profile?
		do
			Result := not generate_execution_profile
		end
		
	existing_profile: FILE_NAME is
			-- Existing profile to use, Void if none
		do
			if workbench_mode then
				Result := wkb_existing_profile
			else
				Result := flz_existing_profile
			end
		end
			
	runtime_information_record: FILE_NAME is
			-- Runtime information record to use when generating the execution profile
		do
			if workbench_mode then
				Result := wkb_runtime_information_record
			else
				Result := flz_runtime_information_record
			end
		end
			
	runtime_information_type: STRING is
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

	default_query: STRING is "calls > 0"
			-- Default query input

	generation_path: STRING is
			-- Generation path for "profinfo.pfi"
		do
			if workbench_mode then
				Result := workbench_generation_path
			else
				Result := final_generation_path
			end
		end	

feature -- Element change

	set_workbench_mode is
			-- Analyse a system compiled in workbench mode.
		do
			workbench_mode := True
		ensure
			Result_set: workbench_mode
		end
		
	set_finalized_mode is
			-- Analyse a system compiled in finalized mode.
		do
			workbench_mode := False
		ensure
			Result_set: finalized_mode
		end
		
	set_generate_execution_profile is
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

	set_use_existing_execution_profile (an_existing_profile: FILE_NAME) is
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
		
	set_runtime_information_record (a_record: FILE_NAME) is
			-- Set the Runtime information record to use when generating 
			-- the execution profile to `a_record'.
		require
			valid_record: a_record /= Void
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

	set_runtime_information_type (a_profiler: STRING) is
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
			a_total_time_switch: BOOLEAN) is
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
			a_recursive_switch: BOOLEAN) is
		do
			eiffel_switch := a_eiffel_switch
			c_switch := a_c_switch
			recursive_switch := a_recursive_switch
		end

	set_query (a_query: STRING) is
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
			
	wkb_existing_profile: FILE_NAME
			-- Existing profile to use (Workbench mode)
	
	flz_existing_profile: FILE_NAME
			-- Existing profile to use (Finalized mode)

	wkb_runtime_information_record: FILE_NAME
			-- Runtime information record to use when generating the
			-- execution profile (Workbench mode)
			
	flz_runtime_information_record: FILE_NAME
			-- Runtime information record to use when generating the 
			-- execution profile (Finalized mode)
			
	wkb_runtime_information_type: STRING
			-- Type of profiler used to produce `runtime_information_record'
			-- (gcc profiler, eiffel profiler, ...)
			
	flz_runtime_information_type: STRING
			-- Type of profiler used to produce `runtime_information_record'
			-- (gcc profiler, eiffel profiler, ...)
			
	find_execution_profile (is_workbench_mode: BOOLEAN) : FILE_NAME is
			-- Find an existing execution profile for the workbench
			-- compilation mode if `workbench_mode' is set, for the
			-- finalized mode otherwise.
			-- 
			-- Return Void if not found.
		local
			dir: DIRECTORY
			path: STRING
			files: ARRAYED_LIST [STRING]
			file: STRING
			substring: STRING
		do
			if is_workbench_mode then
				path := workbench_generation_path
			else
				path := final_generation_path
			end
			create dir.make (path)
			files := dir.linear_representation
			
			from
				files.start
			until
				files.after or Result /= Void
			loop
				file := files.item
				if file.count > 4 then
					substring := file.substring (file.count - 3, file.count)
					if substring.is_equal ("."+Dot_profile_information) then
						create Result.make_from_string (path)
						Result.set_file_name (file)
					end
				end
				files.forth
			end
		end

end -- class EB_PROFILER_WIZARD_INFORMATION
