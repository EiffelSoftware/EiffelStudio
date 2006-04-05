indexing
	description: "Retrieves and sets the External properties of the ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
			dotnet_resources,
			add_dotnet_resource,
			remove_dotnet_resource,
			replace_dotnet_resource,
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
			dotnet_resources_list := externals (dotnet_resource_keyword)
		end
		
feature -- Access

	object_files: EIFFEL_STRING_ENUMERATOR is
			-- retrieves enumerator of project object files
		do
			create Result.make (object_files_list);
		end
		
	include_paths: EIFFEL_STRING_ENUMERATOR is
			-- retrieves enumerator of project include paths
		do
			create Result.make (include_paths_list);
		end
		
	dotnet_resources: EIFFEL_STRING_ENUMERATOR is
			-- retrieves enumerator of project .NET resources
		do
			create Result.make (dotnet_resources_list);
		end
		
feature -- Access

	object_files_list: ARRAYED_LIST [STRING]
			-- Object files
			
	include_paths_list: ARRAYED_LIST [STRING]
			-- Include paths
			
	dotnet_resources_list: ARRAYED_LIST [STRING]
			-- .NET resources
	
	ace_accesser: ACE_FILE_ACCESSER
		
feature {NONE} -- Internal Access

	externals (external_name: STRING): ARRAYED_LIST [STRING] is
			-- retieve a list of externals by name `external_name'
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
					if external_name.is_equal (include_path_keyword) then
						condition := el.item.language_name.is_include_path	
					end
					if external_name.is_equal (object_keyword) then
						condition := el.item.language_name.is_object	
					end
					if external_name.is_equal (dotnet_resource_keyword) then
						condition := el.item.language_name.is_dotnet_resource	
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

	is_external_equal (first, other: STRING): BOOLEAN is
			-- are externals `first' and `other' equal with disregard
			-- to case and leading and trailing quotes
		require
			first_exists: first /= Void
			valid_first: not first.is_empty
			other_exists: other /= Void
			valid_other: not other.is_empty
		do
			Result := format_external (first).as_lower.is_equal (format_external (other).as_lower)
		end
		
	format_external (external_item: STRING): STRING is
			-- format the external `extern' to a ace compatible format
		require
			non_void_external_item: external_item /= Void
			valid_external_item: not external_item.is_empty
		do
			Result := external_item.twin
			if not (Result.item (1) = '"') then
				Result.prepend_character('"')
			end
			if not (Result.item (Result.count) = '"') then
				Result.append_character('"')
			end
			Result.replace_substring_all ("/", "\")
		end

feature -- Element change

	add_object_file (object_file: STRING) is
			-- adds `object_file' to `object_files_list'
		require else
			non_void_object_file: object_file /= Void
			valid_object_file: not object_file.is_empty
		do
			add_external (object_file, object_files_list)
		end
		
	remove_object_file (object_file: STRING) is
			-- removes `object_file' from `object_files_list'
		require else
			non_void_object_file: object_file /= Void
			valid_object_file: not object_file.is_empty
		do
			remove_external (object_file, object_files_list)
		end
		
	replace_object_file (new_object_file, object_file: STRING) is
			-- replaces `object_file' with `new_oject_file' in `object_files_list'
		require else
			non_void_new_object_file: new_object_file /= Void
			valid_new_object_file: not new_object_file.is_empty
			non_void_object_file: object_file /= Void
			valid_object_file: not object_file.is_empty
		do
			replace_external (new_object_file, object_file, object_files_list)
		end
		
	add_include_path (include_path: STRING) is
			-- adds `include_path' to `include_paths_list' 
		require else
			non_void_include_path: include_path /= Void
			valid_include_path: not include_path.is_empty
		do
			add_external (include_path, include_paths_list)			
		end
		
	remove_include_path (include_path: STRING) is
			-- removes `include_path' from `include_paths_list'
		require else
			non_void_include_path: include_path /= Void
			valid_include_path: not include_path.is_empty
		do
			remove_external (include_path, include_paths_list)	
		end
		
	replace_include_path (new_include_path, include_path: STRING) is
			-- replaces `include_path' with `new_include_path' in `include_paths_list'
		require else
			non_void_new_include_path: new_include_path /= Void
			valid_new_include_path: not new_include_path.is_empty
			non_void_include_path: include_path /= Void
			valid_include_path: not include_path.is_empty
		do
			replace_external (new_include_path, include_path, include_paths_list)
		end
		
	add_dotnet_resource (dotnet_resource: STRING) is
			-- adds `dotnet_resource' to `dotnet_resources_list' 
		require else
			non_void_dotnet_resource: dotnet_resource /= Void
			valid_dotnet_resource: not dotnet_resource.is_empty
		do
			add_external (dotnet_resource, dotnet_resources_list)			
		end
		
	remove_dotnet_resource (dotnet_resource: STRING) is
			-- removes `dotnet_resource' from `include_paths_list'
		require else
			non_void_dotnet_resource: dotnet_resource /= Void
			valid_dotnet_resource: not dotnet_resource.is_empty
		do
			remove_external (dotnet_resource, dotnet_resources_list)	
		end
		
	replace_dotnet_resource (new_dotnet_resource, dotnet_resource: STRING) is
			-- replaces `dotnet_resource' with `new_dotnet_resource' in `dotnet_resources_list'
		require else
			non_void_new_dotnet_resource: new_dotnet_resource /= Void
			valid_new_dotnet_resource: not new_dotnet_resource.is_empty
			non_void_dotnet_resource: dotnet_resource /= Void
			valid_dotnet_resource: not dotnet_resource.is_empty
		do
			replace_external (new_dotnet_resource, dotnet_resource, dotnet_resources_list)
		end

feature -- Basic operations

	store is
			-- save the current externals to the ace file
		require else
			non_void_root_ast: ace_accesser.root_ast /= Void
		local
			externals_list: LACE_LIST [LANG_TRIB_SD]
		do
			-- create new external ast list
			create externals_list.make (include_paths_list.count + object_files_list.count + dotnet_resources_list.count)
			ace_accesser.root_ast.set_externals (externals_list)
			
			store_externals (include_paths_list, include_path_keyword, True)
			store_externals (object_files_list, object_keyword, True)
			store_externals (dotnet_resources_list, dotnet_resource_keyword, False)
			ace_accesser.apply
		end

feature {NONE} -- Implementation

	add_external (external_item: STRING; external_list: ARRAYED_LIST [STRING]) is
			-- adds `external_item' to `external_list'
		require
			non_void_external: external_item /= Void
			valid_external: not external_item.is_empty
			non_void_external_list: external_list /= Void
		local
			formatted_path: STRING
			can_add: BOOLEAN
		do
			formatted_path := format_external (external_item)
			
			from
				can_add := true
				external_list.start
			until
				external_list.after or not can_add
			loop
				if is_external_equal (formatted_path, external_list.item) then
					can_add := false
				end
				external_list.forth
			end
			
			if can_add then
				external_list.extend (formatted_path)
			end
		end
		
	remove_external (external_item: STRING; external_list: ARRAYED_LIST [STRING]) is
			-- removes `external_item' from `external_list'
		require
			non_void_external: external_item /= Void
			valid_external: not external_item.is_empty
			non_void_external_list: external_list /= Void
		do
			from
				external_list.start
			until
				external_list.after
			loop
				if is_external_equal (external_list.item, external_item) then
					external_list.remove
				end
				if not external_list.after then
					external_list.forth
				end
			end
		end
		
	replace_external (new_external_item, external_item: STRING; external_list: ARRAYED_LIST [STRING]) is
			-- replace `external_item' with `new_external_item' in `external_list'
		require
			non_void_new_external: new_external_item /= Void
			valid_new_external: not new_external_item.is_empty
			non_void_external: external_item /= Void
			valid_external: not external_item.is_empty
			non_void_external_list: external_list /= Void
		do
			from
				external_list.start
			until
				external_list.after
			loop
				if is_external_equal(external_list.item, external_item) then
					external_list.replace (format_external (new_external_item))
				end
				external_list.forth
			end
		end

	store_externals (external_list: ARRAYED_LIST [STRING]; external_keyword: STRING; add_quotes: BOOLEAN) is
			-- store contents of `external_list' in external `external_keyword' section
			-- External will be wrapped in additional "..." if `add_quotes' is true
		require
			non_void_external_list: external_list /= Void
			non_void_external_keyword: external_keyword /= Void
			valid_external_keyword: external_keyword.is_equal (include_path_keyword) or 
									external_keyword.is_equal (object_keyword) or 
									external_keyword.is_equal (dotnet_resource_keyword)
			non_void_ast_externals: ace_accesser.root_ast.externals /= Void
		local
			external_item: LANG_TRIB_SD
			file_names: LACE_LIST [ID_SD]
			file_name: ID_SD
			unquoted_name: STRING
		do		
			if not external_list.is_empty then
				create file_names.make (external_list.count)
				file_name := new_id_sd (external_keyword, True)
				from 
					external_list.start
				until
					external_list.after
				loop
					-- replace all " in string with %"
					if add_quotes then
						file_names.extend (new_id_sd (external_list.item, True))	
					else
						unquoted_name := external_list.item.twin
						unquoted_name.prune_all_leading ('%"')
						unquoted_name.prune_all_trailing ('%"')
						file_names.extend (new_id_sd (unquoted_name, True))
					end
					external_list.forth
				end
				create external_item.initialize (create {LANGUAGE_NAME_SD}.initialize (file_name), file_names)
				ace_accesser.root_ast.externals.extend (external_item)
			end
		end

feature {NONE} -- Keyword Constants

	include_path_keyword: STRING is "include_path"
			-- keyword for ace include paths
			
	object_keyword: STRING is "object"
			-- keyword for ace object files
			
	dotnet_resource_keyword: STRING is "dotnet_resource"
			-- keyword for ace .NET resources
	
invariant
	non_void_ace_accesser: ace_accesser /= Void
	non_void_include_paths_list: include_paths_list /= Void
	non_void_object_files_list: object_files_list /= Void
	non_void_dotnet_resources_list: dotnet_resources_list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class SYSTEM_EXTERNALS
