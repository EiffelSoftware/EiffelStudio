indexing
	description: "Retrieves and sets the External properties of the ace file"

class
	SYSTEM_EXTERNALS
	
inherit
	IEIFFEL_SYSTEM_EXTERNALS_IMPL_STUB
		redefine
			object_files,
			add_object_file,
			remove_object_file,
			replace_include_path,
			include_paths,
			add_include_path,
			remove_include_path,
			replace_object_file,
			store
		end
	LACE_AST_FACTORY
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Implementation

	make (ace: ACE_FILE_ACCESSER) is
		do
			ace_accesser := ace
			object_files_list := externals (object_keyword)
			include_paths_list := externals (include_path_keyword)
		end
		

feature -- Access

	object_files: OBJECT_FILES_ENUMERATOR is
			-- retieve tje list of assemblies
		do
			create Result.make (object_files_list);
		end
		
	include_paths: INCLUDE_PATHS_ENUMERATOR is
			-- retieve tje list of assemblies
		do
			create Result.make (include_paths_list);
		end
		
feature {NONE} -- Access

	externals (external_name: STRING): ARRAYED_LIST [STRING] is
			-- retieve a list of externals by name
		require
			ace_exists: ace_accesser /= Void
		local
			el: LACE_LIST [LANG_TRIB_SD]
			file_names: LACE_LIST [ID_SD]
			condition: BOOLEAN
		do
			create Result.make(0)
			el := ace_accesser.root_ast.externals
			if el /= Void then
				-- Detached store information from original.
				el := el.duplicate
				from
					el.start
				until
					el.after
				loop
					condition := false
					-- check to see what type of external needs extracting
					-- TODO: Remove the following line and implement as search and add
					-- in the corresponding features
					if external_name.is_equal (include_path_keyword) then
						condition := el.item.language_name.is_include_path	
					end
					if external_name.is_equal (object_keyword) then
						condition := el.item.language_name.is_object	
					end
					if condition then
						-- ertrieve the files names 		
						file_names := el.item.file_names
						check
							has_files: file_names /= Void
						end
						from
							file_names.start
						until
							file_names.after
						loop
							Result.extend (file_names.item.out)
							file_names.forth
						end
					end
					el.forth
				end
			end
		ensure
			Result_exists: Result /= Void
		end
		
feature -- Status report

	is_external_equal(first, other: STRING): BOOLEAN is
			-- are the two externals the same
			-- case and quote insesitive
		require
			first_exists: first /= Void
			valid_first: not first.is_empty
			other_exists: other /= Void
			valid_other: not other.is_empty
		local
			first_copy: STRING
			other_copy: STRING
		do
			Result := false
			first_copy := format_external(first)
			other_copy := format_external(other)
			
			first_copy.to_lower
			other_copy.to_lower
			
			if first_copy.is_equal(other_copy) then
				Result := true
			end
			
		end
		
	format_external(extern: STRING): STRING is
			-- format the external 'extern' to a ace compatible format
		require
			external_exists: extern /= Void
			valid_external: not extern.is_empty
		do
			Result := extern.clone(extern)
			if Result.index_of(' ', 1) > 0 then
				if not (Result.item (1) = '"') then
					Result.prepend_character('"')
				end
				if not (Result.item (Result.count) = '"') then
					Result.append_character('"')
				end
			end
			Result.replace_substring_all ("/", "\")
		end
		
		
feature -- Status setting

feature -- Element change

	add_object_file (object_file: STRING) is
			-- adds and object file to the list of object files
		require else
			valid_name: object_file /= Void
			non_empty_name: object_file.count > 0
		local
			path: STRING
			object_file_copy: STRING
			eiffel_dir: STRING
			addable: BOOLEAN
		do
			path := format_external (object_file)
			
			object_file_copy := object_file.clone (object_file)
			eiffel_dir := ace_accesser.ise_eiffel.clone (ace_accesser.ise_eiffel)
			
			object_file_copy.to_lower
			eiffel_dir.to_lower
			
			if object_file_copy.substring_index (eiffel_dir, 1) = 1 then
				path := path.substring (eiffel_dir.count + 1,  path.count)
				path.prepend (ace_accesser.Ise_eiffel_envvar)
			end
			
			from
				addable := true
				object_files_list.start
			until
				object_files_list.after or not addable
			loop
				if is_external_equal(path, object_files_list.item) then
					addable := false
				end
				object_files_list.forth
			end
			
			if addable then
				object_files_list.extend (path)
			end
		end
		
	remove_object_file (object_file: STRING) is
			-- removes and object file from the list of object files
		require else
			valid_name: object_file /= Void
			non_empty_name: object_file.count > 0
		do
			from
				object_files_list.start
			until
				object_files_list.after
			loop
				if is_external_equal (object_files_list.item, object_file) then
					object_files_list.remove
				end
				if not object_files_list.after then
					object_files_list.forth
				end
			end
		end
		
	replace_object_file (new_oject_file, old_object_file: STRING) is
			-- replace an object file with a new one
		require else
			valid_old_file: old_object_file /= Void
			non_empty_old_file: old_object_file.count > 0
			valid_new_file: new_oject_file /= Void
			non_empty_new_file: new_oject_file.count > 0
		do
			from
				object_files_list.start
			until
				object_files_list.after
			loop
				if is_external_equal(object_files_list.item, old_object_file) then
					object_files_list.replace (format_external(new_oject_file))
				end
				object_files_list.forth
			end
		end
		
		
	add_include_path (include_path: STRING) is
			-- adds and include path to the list of include paths 
		require else
			valid_name: include_path /= Void
			non_empty_name: include_path.count > 0
		local
			addable: BOOLEAN
			path: STRING
			include_path_copy: STRING
			eiffel_dir: STRING
		do
			path := format_external (include_path)
			
			include_path_copy := include_path.clone (include_path)
			eiffel_dir := ace_accesser.ise_eiffel.clone (ace_accesser.ise_eiffel)

			include_path_copy.to_lower
			eiffel_dir.to_lower
	
			if include_path_copy.substring_index (eiffel_dir, 1) = 1 then
				path := path.substring (eiffel_dir.count + 1,  path.count)
				path.prepend (ace_accesser.Ise_eiffel_envvar)
			end
			
			from
				addable := true
				include_paths_list.start
			until
				include_paths_list.after or not addable
			loop
				if is_external_equal(path, include_paths_list.item) then
					addable := false
				end
				include_paths_list.forth
			end
			
			if addable then
				include_paths_list.extend (path)
			end
		end
		
	remove_include_path (include_path: STRING) is
			-- removes and include path from the list of include paths
		require
			valid_name: include_path /= Void
			non_empty_name: include_path.count > 0
		do
			from
				include_paths_list.start
			until
				include_paths_list.after
			loop
				if is_external_equal(include_paths_list.item, include_path) then
					include_paths_list.remove
				end
				if not include_paths_list.after then
					include_paths_list.forth
				end
			end
		ensure
			removed: not include_paths_list.has (include_path)
		end
		
	replace_include_path (new_include_path, old_include_path: STRING) is
			-- replace an include path with a new one
		require else
			valid_old_path: old_include_path /= Void
			non_empty_old_path: old_include_path.count > 0
			valid_new_path: new_include_path /= Void
			non_empty_new_path: new_include_path.count > 0
		do
			from
				include_paths_list.start
			until
				include_paths_list.after
			loop
				if is_external_equal(include_paths_list.item, old_include_path) then
					include_paths_list.replace (format_external(new_include_path))
				end
				include_paths_list.forth
			end
		end

feature -- Basic operations

	store is
			-- save the current externals to the ace file
		local
			externals_list: LACE_LIST [LANG_TRIB_SD]
			external_item: LANG_TRIB_SD
			file_names: LACE_LIST [ID_SD]
			file_name: ID_SD
			string: STRING
		do
			create externals_list.make (0)
			ace_accesser.root_ast.set_externals (externals_list)
			
			-- Add the include paths to the ace
			if include_paths_list.count > 0 then
				create file_names.make (include_paths_list.count)
				file_name := new_id_sd(include_path_keyword, True)
				
				from 
					include_paths_list.start
				until
					include_paths_list.after
				loop
					-- replace all " in string with %"
					string := include_paths_list.item.clone(include_paths_list.item)
					string.replace_substring_all ("%"", "%%%"")
					file_names.extend (new_id_sd (string, True))
					include_paths_list.forth
				end
				
				create external_item.initialize (create {LANGUAGE_NAME_SD}.initialize (file_name), file_names)
				externals_list.extend (external_item)
			end
			
			-- Add the object files to the ace
			if object_files_list.count > 0 then
				create file_names.make (object_files_list.count)
				file_name := new_id_sd (object_keyword, True)
				
				from 
					object_files_list.start
				until
					object_files_list.after
				loop
					-- replace all " in string with %"
					string := object_files_list.item.clone(object_files_list.item)
					string.replace_substring_all ("%"", "%%%"")
					file_names.extend (new_id_sd (string, True))
					object_files_list.forth
				end
				
				create external_item.initialize (create {LANGUAGE_NAME_SD}.initialize (file_name), file_names)
				externals_list.extend (external_item)
			end
			ace_accesser.apply
		end
		

feature {NONE} -- Implementation

	object_files_list: ARRAYED_LIST [STRING]
	include_paths_list: ARRAYED_LIST [STRING]
	
	ace_accesser: ACE_FILE_ACCESSER
	
	include_path_keyword: STRING is "include_path"
	object_keyword: STRING is "object"

invariant
	invariant_clause: True -- Your invariant here

end -- class SYSTEM_EXTERNALS
