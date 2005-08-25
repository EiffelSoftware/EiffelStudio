indexing
	description: "[
		An agumented assembly resolver to support consumer's ability to consume assemblies with dependencies
		in disparate locations.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMER_AGUMENTED_RESOLVER

inherit
	AR_RESOLVER
		rename
			make as resolver_make,
			make_with_name as resolver_make_with_name,
			common_initialization as resolver_common_initialization
		redefine
			resolve_by_name,
			get_assembly_name
		end

create
	make,
	make_with_name
	
feature {NONE} -- Initialization

	make (a_file_names: like look_up_file_names) is
			-- Initialize instance
		require
			a_file_names: a_file_names /= Void
			not_a_file_names_is_empty: not a_file_names.is_empty
		do
			resolver_make
			common_initialization (a_file_names)
		ensure
			look_up_file_names_set: look_up_file_names = a_file_names 
		end

	make_with_name (a_file_names: LIST [STRING]; a_name: like friendly_name) is
			-- Initialize instance and set `friendly_name' with `a_name'
		require
			a_file_names: a_file_names /= Void
			not_a_file_names_is_empty: not a_file_names.is_empty
			a_name_not_void: a_name /= Void
		do
			resolver_make_with_name (a_name)
			common_initialization (a_file_names)
		ensure
			friendly_name_set: friendly_name = a_name
			look_up_file_names_set: look_up_file_names = a_file_names
		end
	
	common_initialization (a_file_names: like look_up_file_names) is
			-- Additional initialization.
		require
			a_file_names: a_file_names /= Void
			not_a_file_names_is_empty: not a_file_names.is_empty
		do
			create names_table.make (13)
			names_table.compare_objects
			look_up_file_names := a_file_names
		ensure
			look_up_file_names_set: look_up_file_names = a_file_names
		end
	
feature -- Resolution
		
	resolve_by_name (a_domain: APP_DOMAIN; a_name: STRING; a_version: STRING; a_culture: STRING; a_key: STRING): ASSEMBLY is
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of assembly name `a_name'
			-- and optionally version `a_version', culture `a_culture' and public key token `a_key'
		local
			l_name: like get_assembly_name
			l_cursor: CURSOR
		do
			l_cursor := look_up_file_names.cursor
			from
				look_up_file_names.start
			until
				look_up_file_names.after or Result /= Void
			loop
				l_name := get_assembly_name (look_up_file_names.item)
				if l_name /= Void then
					if does_name_match (l_name, a_name, a_version, a_culture, a_key) then
						Result := load_assembly (look_up_file_names.item)
					end
				end
				look_up_file_names.forth
			end
			look_up_file_names.go_to (l_cursor)
			if Result = Void then
				Result := Precursor {AR_RESOLVER} (a_domain, a_name, a_version, a_culture, a_key)
			end
		ensure then
			look_up_file_names_cursor_unmoved: look_up_file_names.cursor.is_equal (old look_up_file_names.cursor)
		end
		
feature -- Implementation

	get_assembly_name (a_path: STRING): ASSEMBLY_NAME is
			-- Retrieve an assembly name from `a_path'
		do
			Result := names_table.item (a_path)
			if Result = Void then
				Result := Precursor {AR_RESOLVER} (a_path)
				if Result /= Void then
					names_table.extend (Result, a_path)
				end
			end
		end

	look_up_file_names: LIST [STRING]
			-- Lookup files names
			
	names_table: HASH_TABLE [ASSEMBLY_NAME, STRING]
			-- Table of path/assembly names
			-- Key: assembly file name path
			-- Value: Assembly name

invariant
	look_up_file_names_not_void: look_up_file_names /= Void
	names_table_not_void: names_table /= Void
	names_table_compares_objects: names_table.object_comparison
	
end -- class CONSUMER_AGUMENTED_RESOLVER
