indexing
	description: "Retrieves and sets the Assembly properties of the ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ASSEMBLIES

inherit
	IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_STUB
		redefine
			add_assembly,
			last_exception,
			store,
			wipe_out,
			add_assembly_user_precondition
		end
	LACE_AST_FACTORY
		export
			{NONE} all
		end

create 
	make
	
feature {NONE} -- Initialization

	make (ace: ACE_FILE_ACCESSER) is
			-- Initialize with all data taken from `ace_accesser'.
		require
			non_void_ace_accesser: ace /= Void
		local
			al: LACE_LIST [ASSEMBLY_SD]
		do
			ace_accesser := ace
			al ?= ace_accesser.root_ast.assemblies
			if al /= Void then
				from
						-- Detached store information from original.
					al := al.duplicate

						-- Initialize assemblies list
					create assemblies_table.make (al.count)
					al.start
				until
					al.after
				loop
					assemblies_table.put (al.item, al.item.cluster_name)
					al.forth
				end
			else
				create assemblies_table.make (13)	
			end
		end

feature -- Access

	wipe_out is
			-- clear currently held assemblies
		do
			assemblies_table.wipe_out
		end
		
	add_assembly (a_prefix, a_cluster_name, a_path: STRING; a_copy: BOOLEAN) is
			-- add an assembly to ace
		require else
			valid_prefix: a_prefix /= Void implies is_valid_prefix (a_prefix)
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: is_valid_cluster_name (a_cluster_name)
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_assembly: ASSEMBLY_SD
			l_cluster_name: STRING
		do
			l_cluster_name := clone (a_cluster_name)
			l_cluster_name.to_lower
			
			if not assemblies_table.has (l_cluster_name) then
				if a_prefix /= Void then
					create l_assembly.initialize (new_id_sd (l_cluster_name, True), new_id_sd (a_path, True), new_id_sd (a_prefix, False), Void, Void, Void)					
				else
					create l_assembly.initialize (new_id_sd (l_cluster_name, True), new_id_sd (a_path, True), Void, Void, Void, Void)
				end
				assemblies_table.put (l_assembly, l_cluster_name)
			else
				--create last_exception
			end
		end
		
	last_exception: EXCEPTION
			-- last exception to be raised

	store is
			-- save the assemblies to the ace file
		local
			l_assemblies: LACE_LIST [ASSEMBLY_SD]
			copy_assemblies: like assemblies_table
			cluster_name: ID_SD
		do
				-- Save assemblies
			copy_assemblies := clone (assemblies_table)
			l_assemblies := ace_accesser.root_ast.assemblies
			if l_assemblies = Void then
					-- if there is no assembly option then we need to create it
				create l_assemblies.make (copy_assemblies.count)
				ace_accesser.root_ast.set_assemblies (l_assemblies)
			end

				-- Insert assemblies in the order in which they were entered
				-- originally.
			from
				l_assemblies.start
			until
				l_assemblies.after
			loop
				cluster_name := l_assemblies.item.cluster_name
				
				if copy_assemblies.has (cluster_name) then
					l_assemblies.put (copy_assemblies.item (cluster_name))
					copy_assemblies.remove (cluster_name)
					l_assemblies.forth
				else
					l_assemblies.remove
				end
			end

				-- Insert at the end new clusters.
			if not copy_assemblies.is_empty then
				from
					copy_assemblies.start
				until
					copy_assemblies.after
				loop
					l_assemblies.extend (copy_assemblies.item_for_iteration)
					copy_assemblies.forth
				end
			end

			ace_accesser.apply
		end
		
feature -- User Preconditions

	add_assembly_user_precondition (a_prefix, a_cluster_name, a_path: STRING; a_copy: BOOLEAN): BOOLEAN is
		once
			Result := False
		end
		
		
feature -- Validation

	is_valid_eiffel_identifier (a_identifier: STRING): BOOLEAN is
			-- is `a_indentifer' a valid Eiffel identifier?
		require
			non_void_identifier: a_identifier /= Void
			valid_identifier: not a_identifier.is_empty
		local
			l_index: INTEGER
			l_char: CHARACTER
		do
			l_char := a_identifier.item (1)
			Result := l_char.is_alpha
			if Result then
				from 
					l_index := 1
				until
					l_index > a_identifier.count or 
						not Result
				loop
					Result := Result and (l_char.is_alpha or l_char.is_digit or l_char = '_')
					l_index := l_index + 1
				end
			end
		end

	is_valid_prefix (a_prefix: STRING): BOOLEAN is
			-- is `a_prefix' a valid prefix
		do
			Result := a_prefix /= Void implies not a_prefix.is_empty
			if Result then
				Result := is_valid_eiffel_identifier (a_prefix)
			end
		end

	is_valid_cluster_name (a_cluster_name: STRING): BOOLEAN is
			-- is `a_cluster_name' a valid cluster name
		do
			Result := a_cluster_name /= Void and not a_cluster_name.is_empty
		end
		

feature {NONE} -- Implementation
	
	format_cluster_name (a_cluster_name: STRING): STRING is
			-- format cluster name
		require
			non_void_cluster_name: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		do
			Result := clone (a_cluster_name)
			Result.to_lower
		ensure
			valid_result: Result /= Void
		end
		
		
feature {NONE} -- Initialization
	
	ace_accesser: ACE_FILE_ACCESSER
	assemblies_table: HASH_TABLE[ASSEMBLY_SD, STRING]

invariant
	non_void_ace_accesser: ace_accesser /= Void
	non_void_assemblies_table: assemblies_table /= Void

end -- class SYSTEM_ASSEMBLIES
