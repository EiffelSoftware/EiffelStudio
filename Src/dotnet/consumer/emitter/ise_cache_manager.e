indexing
	description: "Simplistic interface for client assemblies"
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_CACHE_MANAGER
	
inherit
	EMITTER
		rename
			make as make_emitter,
			error_category as error_category_emitter,
			error_message_table as error_message_table_emitter
		export 
			{NONE} all
		undefine
			start
		redefine
			process_error,
			display_status
		end

	ISE_CACHE_MANAGER_ERRORS
		export
			{NONE} all
		select
			error_category,
			error_message_table
		end
		
	CACHE_PATH
		export
			{NONE} all
		end

create
	make,
	make_with_path

feature {NONE}-- Initialization 

	make is
			-- create an instance of ISE_CACHE_MANAGER
		do
			is_successful := True
			last_error_message := ""	
			no_output := True

			assembly_consumer.set_status_printer (agent display_status)
			assembly_consumer.set_error_printer (agent process_error)
		end

	make_with_path (a_path: STRING) is
			-- create instance of ISE_CACHE_MANAGER with ISE_EIFFEL path set to `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		do
			set_internal_eiffel_path (a_path)
			make
		end

feature -- Access

	is_successful: BOOLEAN

	last_error_message: STRING
		-- last error message

feature -- Basic Oprtations

	consume_gac_assembly (aname, aversion, aculture, akey: STRING) is
			-- consume an assembly from the gac defined by
			-- "'aname', Version='aversion', Culture='aculture', PublicKeyToken='akey'"
		require
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_void_key: akey /= Void
			non_empty_name: aname.count > 0
			non_empty_version: aversion.count > 0
			non_empty_culture: aculture.count > 0
			non_empty_key: akey.count > 0
		local
			assembly: ASSEMBLY
		do
			is_successful := True
			last_error_message := ""
			
			assembly := feature {ASSEMBLY}.load_string (fully_quantified_name (aname, aversion, aculture, akey).to_cil)
			if assembly /= Void then
				consume_in_eac (assembly)
			else
				set_error (Cannot_load_gac_assembly, Void)
				process_error (error_message)
			end
		ensure
			successful: is_successful
		end

	relative_folder_name (aname, aversion, aculture, akey: STRING): STRING is
			-- retruns the relative path to an assembly
		require
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_empty_name: aname.count > 0
			non_empty_version: aversion.count > 0
			non_empty_culture: aculture.count > 0
		local
			assembly: ASSEMBLY
		do
			assembly := feature {ASSEMBLY}.load_string (fully_quantified_name (aname, aversion, aculture, akey).to_cil)	
			if assembly /= Void then
				Result := relative_assembly_path (assembly.get_name)
				Result := Result.substring (1, Result.count - 1)
			else
				set_error (Cannot_load_assembly, Void)
				process_error (error_message)
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.count > 0
		end

	assembly_info_from_assembly (apath: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a local assembly's information
		require
			non_void_path: apath /= Void
			non_empty_path: apath.count > 0
		local
			caf: CONSUMED_ASSEMBLY_FACTORY
			assembly: ASSEMBLY
		do
			assembly := feature {ASSEMBLY}.load_from (apath.to_cil)	
			if assembly /= Void then
				create caf
				Result := caf.consumed_assembly (assembly)
			else
				set_error (Cannot_load_assembly, Void)
				process_error (error_message)
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Basic Operations

	fully_quantified_name (aname, aversion, aculture, akey: STRING): STRING is
			-- returns "'aname', Version='aversion', Culture='aculture', PublicKeyToken='akey'"
		require
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_empty_name: aname.count > 0
			non_empty_version: aversion.count > 0
			non_empty_culture: aculture.count > 0
		local
			full_name: STRING
		do
			Result := aname.clone (aname)
			Result.append (", Version=" + aversion)
			Result.append (", Culture=" + aculture)
			Result.append (", PublicKeyToken=")
			if akey /= Void and akey.count > 0 then
				Result.append (akey)
			else
				Result.append ("null")				
			end
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.count > 0
		end

feature {NONE} -- Internal Agents

	start is
			-- dummy routine
		do
			--| no code!
		end

	process_error (s: STRING) is
			-- process an error message
		do
			is_successful := False
			last_error_message := s.clone (s)
		end

	display_status (s: STRING) is
			-- Display progress status.
		do
			--| Do nothing
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class ISE_CACHE_MANAGER
