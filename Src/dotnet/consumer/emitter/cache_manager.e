indexing
	description: "Simplistic interface for client assemblies"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_MANAGER
	
inherit
	EMITTER
		rename
			make as make_emitter,
			error_category as error_category_emitter,
			error_message_table as error_message_table_emitter
		export 
			{NONE} all
			{CACHE_MANAGER} clr_version
			{ANY} compact_and_clean_cache, cache_reader, cache_writer
		undefine
			start
		end

	CACHE_MANAGER_ERRORS
		export
			{NONE} all
		select
			error_category,
			error_message_table
		end

create
	make,
	make_with_path

feature {NONE}-- Initialization 

	make (a_clr_version: STRING) is
			-- create an instance of CACHE_MANAGER
		do
			cache_path_make (a_clr_version)
			is_successful := True
			last_error_message := ""	
			create cache_writer.make (clr_version)
			create cache_reader.make (clr_version)
			create assembly_resolver.make (feature {APP_DOMAIN}.current_domain)
		end
		
	make_with_path (a_path: STRING; a_clr_version: STRING) is
			-- create instance of CACHE_MANAGER with ISE_EIFFEL path set to `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		do
			set_internal_eiffel_cache_path (a_path)
			make (a_clr_version)
		end
		
feature -- Access

	is_successful: BOOLEAN
	
	last_error_message: STRING
		-- last error message
		
	assembly_resolver: ASSEMBLY_RESOLVER
		-- assembly resolver used to resolve references that cannot be resolved by default implementation
		
feature -- Basic Oprtations

	consume_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_assembly: ASSEMBLY
		do
			is_successful := True
			last_error_message := ""
			
			add_to_eac := True
			l_assembly := feature {ASSEMBLY}.load_string (fully_quantified_name (a_name, a_version, a_culture, a_key))
			assembly_resolver.add_resolver_path_from_assembly (l_assembly)
			add_assembly_to_eac (l_assembly.location)
			assembly_resolver.remove_resolver_path_from_assembly (l_assembly)
		ensure
			successful: is_successful
		end
		
	consume_assembly_from_path (a_path: STRING) is
			-- Consume assembly located `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_paths: LIST [STRING]
		do	
			is_successful := True
			last_error_message := ""

			from
				l_paths := a_path.split (';')
				l_paths.start
			until
				l_paths.after
			loop			
				assembly_resolver.add_resolver_assembly (l_paths.item)
				l_paths.forth
			end

			add_to_eac := True
			from
				l_paths := a_path.split (';')
				l_paths.start
			until
				l_paths.after
			loop
				assembly_resolver.add_resolver_path_from_file_name (l_paths.item)
				add_assembly_to_eac (l_paths.item)
				assembly_resolver.remove_resolver_path_from_file_name (l_paths.item)
				l_paths.forth
			end
		ensure
			successful: is_successful
		end
		
	relative_folder_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_assembly: ASSEMBLY
			l_ca: CONSUMED_ASSEMBLY
		do
			l_assembly := feature {ASSEMBLY}.load_string (fully_quantified_name (a_name, a_version, a_culture, a_key))	
		
			l_ca := cache_writer.consumed_assembly_from_path (l_assembly.location)
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
				Result.prune_all_trailing ('\')
			end
		end
		
	relative_folder_name_from_path (a_path: STRING): STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
		do		
			l_ca := cache_writer.consumed_assembly_from_path (a_path)
			if l_ca /= Void then
				Result := relative_assembly_path_from_consumed_assembly (l_ca)
				Result.prune_all_trailing ('\')
			end
		end

	assembly_info_from_assembly (a_path: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a local assembly's information.
			-- If assembly has already been consumed then function will
			-- return found matching CONSUMED_ASSEMBLY. 
			-- If you need to use resulting CONSUMED_ASSEMBLY.folder_name
			-- then you need to query CONSUMED_ASSEMBLY.is_consumed = True to
			-- know that that name exists.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_assembly: ASSEMBLY
		do
			if cache_reader.is_assembly_in_cache (a_path, False) then
				Result := cache_writer.consumed_assembly_from_path (a_path)	
			end
			if Result = Void then
				l_assembly := load_from_gac_or_path (a_path)
				if l_assembly /= Void then
					Result := cache_writer.consumed_assembly_from_path (l_assembly.location)		
				end
			end
		ensure
			non_void_result: Result /= Void
		end		

feature {NONE} -- Basic Operations

	fully_quantified_name (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- returns "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := a_name.twin
			if a_version /= Void and not a_version.is_empty then
				Result.append (", Version=" + a_version)
				if a_culture /= Void and not a_culture.is_empty then
					Result.append (", Culture=" + a_culture)
					if a_key /= Void and not a_key.is_empty then
						Result.append (", PublicKeyToken=" + a_key)
					end
				end
			end
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end

feature {NONE} -- Internal Agents

	start is
			-- dummy routine
		do
			--| no code!
		end		

invariant
	assembly_resolver_not_void: assembly_resolver /= Void
	cache_writer_not_void: cache_writer /= Void
	cache_reader_not_void: cache_reader /= Void

end -- class CACHE_MANAGER
