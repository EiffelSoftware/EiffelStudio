indexing
	description: "[
		Assembly resolver used to help failed loading assemblies when the CLR attempted to load
		the them using only their display names or parts of their display names
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_RESOLVER
		
inherit
	ANY
	
	KEY_ENCODER
		export
			{NONE} all
		end
		
	DISPOSABLE
		redefine
			dispose
		end
	
	MARSHAL_BY_REF_OBJECT
		rename
			make as make_marhaller
		end
	
create
	make
	
feature {COM_ISE_CACHE_MANAGER} -- Initialization

	make (a_domain: APP_DOMAIN) is
			-- create instance and attach to app domain `a_domain'
		require
			non_void_domain: a_domain /= Void
			non_finalizing_domain: not a_domain.is_finalizing_for_unload
		do
			app_domain := a_domain
			create resolver_paths.make (7)
			resolver_paths.compare_objects
			app_domain.add_assembly_resolve (create {RESOLVE_EVENT_HANDLER}.make (Current, $resolve_reference))
		end
		
feature -- Access
		
	resolver_paths: ARRAYED_LIST [STRING]
			-- array of prioritized paths to resolve an assembly reference with
			
	app_domain: APP_DOMAIN
			-- app domain that resolver is associated with
		
feature -- Basic operations
		
	get_resolver_path_from_assembly (a_ass: ASSEMBLY): STRING is
			-- retrieves path where `a_ass' resides
		require
			non_void_ass: a_ass /= Void
		do
			Result := get_resolver_path_from_file_name (a_ass.location)
		end
		
	get_resolver_path_from_file_name (a_file_name: STRING): STRING is
			-- retrieves path where `a_file_name' resides
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			l_location: STRING
			l_is_network_path: BOOLEAN
		do
			l_location := a_file_name
			if not l_location.is_empty then
				l_location.replace_substring_all ("/", "\")
				if l_location.count > 2 and then l_location.substring (1, 2).is_equal ("\\") then
						-- PATH doesn't evaluate network paths correctly so leading '\\'
						-- requires removal.
					l_is_network_path := True
					l_location.prune_all_leading ('\')
				end
				l_location := feature {PATH}.get_directory_name (l_location)
				if not l_location.is_empty then
					if l_is_network_path then
						l_location.prepend ("\\")
					end
					Result := l_location
				end
			end
		end
		
	resolve_reference (sender: SYSTEM_OBJECT; a_args: RESOLVE_EVENT_ARGS): ASSEMBLY is
			-- attempt to resolve an assembly reference
		local
			l_assembly_path: STRING
		do
			from
				resolver_paths.start
			until
				Result /= Void or resolver_paths.after
			loop
				create l_assembly_path.make (resolver_paths.item.count + a_args.name.length + 5)
				l_assembly_path.append (resolver_paths.item.twin)
				l_assembly_path.append_character ('\')
				l_assembly_path.append (get_assembly_name (a_args.name))
				l_assembly_path.append (".dll")
				if (create {RAW_FILE}.make (l_assembly_path)).exists then
					Result := load_assembly (l_assembly_path)
					if Result /= Void and then not is_good_match (Result, a_args.name) then
						Result := Void
					end	
				end
				if Result = Void then
					l_assembly_path.keep_head (l_assembly_path.count - 3)
					l_assembly_path.append ("exe")
					if (create {RAW_FILE}.make (l_assembly_path)).exists then
						Result := load_assembly (l_assembly_path)
						if Result /= Void and then not is_good_match (Result, a_args.name) then
							Result := Void
						end
					end
				end
				resolver_paths.forth
			end
		end
		
feature -- Extension

	add_resolver_path (a_path: STRING) is
			-- add path `a_path' to `resolver_paths'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {DIRECTORY}.make (a_path)).exists
		local
			l_twin_path: STRING
		do
			l_twin_path := a_path.twin
			l_twin_path.to_lower
			resolver_paths.extend (l_twin_path)	
		end
		
	add_resolver_path_from_assembly (a_ass: ASSEMBLY) is
			-- add assembly's `a_ass' source path to list of `resolver_paths'
		require
			non_void_ass: a_ass /= Void
		local
			l_path: STRING
		do
			l_path := get_resolver_path_from_assembly (a_ass)
			if l_path /= Void then
				add_resolver_path (l_path)
			end
		end
		
	add_resolver_path_from_file_name (a_file_name: STRING) is
			-- add file's `a_file_name' source path to list of `resolver_paths'
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			l_path: STRING
		do
			l_path := get_resolver_path_from_file_name (a_file_name)
			if l_path /= Void then
				add_resolver_path (l_path)
			end
		end
		
feature -- Removal

	remove_resolver_path (a_path: STRING) is
			-- removes path `a_path' from `resolver_paths'
		require
			non_void_path: a_path /= Void
		local
			l_twin_path: STRING
		do
			l_twin_path := a_path.twin
			l_twin_path.to_lower
			resolver_paths.search (l_twin_path)
			if not resolver_paths.after then
				resolver_paths.remove
			end
		end
		
	remove_resolver_path_from_assembly (a_ass: ASSEMBLY) is
			-- removes assembly's `a_ass' source path from list of `resolver_paths'
		require
			non_void_ass: a_ass /= Void
		local
			l_path: STRING
		do
			l_path := get_resolver_path_from_assembly (a_ass)
			if l_path /= Void then
				remove_resolver_path (l_path)
			end
		end
		
	remove_resolver_path_from_file_name (a_file_name: STRING) is
			-- removes file's `a_file_name' source path from list of `resolver_paths'
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			l_path: STRING
		do
			l_path := get_resolver_path_from_file_name (a_file_name)
			if l_path /= Void then
				remove_resolver_path (l_path)
			end
		end

	remove_from_app_domain is
			-- removes current instance from notified app domain events
		do
			if app_domain.is_finalizing_for_unload then
				app_domain.remove_assembly_resolve (create {RESOLVE_EVENT_HANDLER}.make (Current, $resolve_reference))
			end
		end
		
	dispose is
			-- clean up
		do
			remove_from_app_domain
		end
		
feature {NONE} -- Implementation

	load_assembly (a_path: STRING): ASSEMBLY is
			-- attempt to load assembly at `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := feature {ASSEMBLY}.load_from (a_path)
			end
		rescue
			l_retried := True
			retry
		end
	
	get_assembly_name (a_name: STRING): STRING is
			-- retrieve assembly name from a full or partial display name `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			Result := a_name.split (',') @ (1)
		end

	is_good_match (a_ass: ASSEMBLY; a_match_name: STRING): BOOLEAN is
			-- checks to see if assembly `a_ass' matches info in `a_match_name'
		require
			non_void_ass: a_ass /= Void
			non_void_name: a_match_name /= Void
			valid_name: not a_match_name.is_empty
		local
			l_name: STRING
			l_version: STRING
			l_culture: STRING
			l_key: STRING
			l_parts: LIST[STRING]
			l_ass_name: ASSEMBLY_NAME
		do
			l_parts := a_match_name.split (',')
			l_name := l_parts @ 1
			
			l_ass_name := a_ass.get_name
			Result := l_name.is_equal (l_ass_name.name)
			if Result and l_parts.count > 2 then
				from 
					l_parts.go_i_th (2)
				until
					l_parts.after or not Result
				loop
					l_parts.item.prune_all_leading (' ')
					
					if l_version = Void and l_parts.item.substring_index ("Version=", 1) > 0then
						l_version := l_parts.item.substring (9, l_parts.item.count)
						Result := l_version.is_equal (l_ass_name.version.to_string)
						
					elseif l_culture = Void and l_parts.item.substring_index ("Culture=", 1) > 0 then	
						l_culture := l_parts.item.substring (9, l_parts.item.count)
						if l_culture.as_lower.is_equal ("neutral") then
							Result := (l_ass_name.culture_info.to_string.length = 0)
						else
							Result := l_culture.is_equal (l_ass_name.culture_info.to_string)
						end
						
					elseif l_key = Void and l_parts.item.substring_index ("PublicKeyToken=", 1) > 0 then
						l_key := l_parts.item.substring (16, l_parts.item.count)
						l_key.to_lower
						if l_ass_name.get_public_key_token /= Void then
							Result := l_key.is_equal (encoded_key (l_ass_name.get_public_key_token))
						else
							Result := l_key.is_empty or l_key.is_equal ("null")
						end
						
					end
					l_parts.forth
				end				
			end
		end

invariant
	non_void_resolver_paths: resolver_paths /= Void
	non_void_app_domain: app_domain /= Void

end -- class ASSEMBLY_RESOLVER
