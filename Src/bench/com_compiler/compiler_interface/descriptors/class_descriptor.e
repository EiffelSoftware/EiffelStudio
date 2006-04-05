indexing
	description: "Description of a class in the system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DESCRIPTOR

inherit
	IEIFFEL_CLASS_DESCRIPTOR_IMPL_STUB
		undefine
			is_equal
		redefine
			name,
			description,
			tool_tip,
			external_name,
			feature_names,
			features,
			feature_count,
			flat_features,
			flat_feature_count,
			inherited_features,
			inherited_feature_count,
			creation_routines,
			creation_routine_count,
			clients,
			client_count,
			suppliers,
			supplier_count,
			ancestors,
			ancestor_count,
			descendants,
			descendant_count,
			class_path,
			is_deferred,
			is_external,
			is_obsolete,
			obsolete_message,
			is_true_external,
			is_generic,
			is_library,
			is_in_system,
			assertions,
			member_of
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end
	
	COMPARABLE

create
	make_with_class_i
	
feature {NONE} -- Initialization

	make_with_class_i (a_class: CLASS_I) is
			-- Initialize structure with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			compiler_class := a_class
		end

feature -- Access

	name: STRING is
			-- Class name.
		do
			Result := compiler_class.name.twin
		ensure then
			result_exists: Result /= Void
		end

	external_name: STRING is
			-- Class external name.
		do
			check
				is_external: is_external
			end
			Result := compiler_class.external_name
		ensure then
			result_exists: Result /= Void
		end

	description: STRING is
			-- Class description.
		do
			Result := tool_tip
		end

	tool_tip: STRING is
			-- Class Tool Tip.
		local
			indexing_clause: INDEXING_CLAUSE_AS
			l_res: STRING
			l_lines: LIST [STRING]
		do
			if is_in_system then
				if compiler_class.compiled_class.ast /= Void then
					indexing_clause := compiler_class.compiled_class.ast.top_indexes
					if indexing_clause /= Void then
						l_res := indexing_clause.description
						if l_res /= Void then
							l_res.replace_substring_all ("%R", "")
							l_lines := l_res.split ('%N')
							create Result.make (l_res.count)
							from
								l_lines.start
							until
								l_lines.after
							loop
								l_lines.item.prune_all_leading ('%T')
								l_lines.item.prune_all_leading (' ')
								l_lines.item.prune_all_leading ('%T')
								l_lines.item.prune_all_leading (' ')
								l_lines.item.prune_all_trailing (' ')
								Result.append (l_lines.item)
								Result.append_character (' ')
								l_lines.forth
							end
						end
					end					
				end
			end
		end

	is_in_system: BOOLEAN is
			-- Is class in system?
		do
			Result := compiler_class.compiled
		end

	feature_names: ECOM_ARRAY [STRING] is
			-- List of names of class flat features.
		local
			names, res: ARRAY [STRING]
		do
			if is_in_system then
				names := compiler_class.compiled_class.api_feature_table.current_keys
				create res.make (1, names.count)
				res.copy (names)
				create Result.make_from_array (res, 1, <<1>>, <<res.count>>)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end

	features: FEATURE_ENUMERATOR is
			-- List of class features.
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: LIST [E_FEATURE]
			f: FEATURE_DESCRIPTOR
		do
			if is_in_system then
				l := compiler_class.compiled_class.written_in_features
				create res.make (l.count)
				from
					l.start
				until
					l.after
				loop
					create f.make_with_class_i_and_feature_i (compiler_class, l.item.associated_feature_i)
					res.extend (f)
					l.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end
		
	feature_count: INTEGER is
			-- Number of class features.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.written_in_features.count
			end
		end

	flat_features: FEATURE_ENUMERATOR is
			-- List of class features including ancestor features.
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: ARRAYED_LIST [FEATURE_I]
			f: FEATURE_DESCRIPTOR
		do
			if is_in_system then
				l := compiler_class.compiled_class.feature_table.linear_representation
				create res.make (l.count)
				from
					l.start
				until
					l.after
				loop
					create f.make_with_class_i_and_feature_i (compiler_class, l.item)
					res.extend (f)
					l.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void			
		end

	flat_feature_count: INTEGER is
			-- Number of flat class features.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.feature_table.count
			end
		end
		
	inherited_features: FEATURE_ENUMERATOR is
			-- List of all inherited class features.
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: ARRAYED_LIST [FEATURE_I]
			f: FEATURE_DESCRIPTOR
		do
			if is_in_system then
				l := compiler_class.compiled_class.feature_table.linear_representation
				create res.make (l.count)
				from
					l.start
				until
					l.after
				loop
					if l.item.written_in /= compiler_class.compiled_class.feature_table.feat_tbl_id then
						create f.make_with_class_i_and_feature_i (compiler_class, l.item)
						res.extend (f)						
					end
					l.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void			
		end
		
	inherited_feature_count: INTEGER is
			-- Number of inherited features.
		do
			if is_in_system then
				Result := inherited_features.count
			end		
		end
		
	creation_routines: FEATURE_ENUMERATOR is
			-- Creation routines of current.
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: HASH_TABLE [EXPORT_I, STRING]
		do
			if is_in_system then
				l := compiler_class.compiled_class.creators
				if l /= Void then
					create res.make (l.count)
					from
						l.start
					until
						l.after
					loop
						res.extend (feature_with_name (l.key_for_iteration))
						l.forth
					end
				else
					create res.make (0)
				end
				create Result.make (res)
			end
		ensure then
			result_exists: Result /= Void
		end
		
	creation_routine_count: INTEGER is
			-- 
		do
			if is_in_system then
				Result := creation_routines.count
			end
		end

	feature_with_name (a_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature with name `a_name' in `Current'.
			-- Void if none.
		require
			name_not_void: a_name /= Void
		local
			f: FEATURE_I
		do
			if is_in_system then
				f := compiler_class.compiled_class.feature_table.item (a_name)
				if f /= Void then
					create {FEATURE_DESCRIPTOR} Result.make_with_class_i_and_feature_i (compiler_class, f)
				end
			end
		end

	clients: CLASS_ENUMERATOR is
			-- List of class clients.
		local
			client_list: LIST [CLASS_C]
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			client: CLASS_DESCRIPTOR
		do
			if is_in_system then
				client_list := compiler_class.compiled_class.clients
				create res.make (client_list.count)
				from
					client_list.start
				until
					client_list.after
				loop
					if client_list.item /= compiler_class.compiled_class then
						create client.make_with_class_i (client_list.item.lace_class)
						res.extend (client)
					end
					client_list.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end

	client_count: INTEGER is
			-- Number of class clients.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.clients.count - 1
			end
		end
		
	suppliers: CLASS_ENUMERATOR is
			-- List of class suppliers.
		local
			supplier_list: LIST [CLASS_C]
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			supplier: CLASS_DESCRIPTOR
		do
			if is_in_system then
				supplier_list := compiler_class.compiled_class.suppliers.classes
				create res.make (supplier_list.count)
				from
					supplier_list.start
				until
					supplier_list.after
				loop
					if supplier_list.item /= compiler_class.compiled_class then
						create supplier.make_with_class_i (supplier_list.item.lace_class)
						res.extend(supplier)
					end
					supplier_list.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end

	supplier_count: INTEGER is
			-- Number of class suppliers.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.suppliers.classes.count - 1
			end
		end

	ancestors: CLASS_ENUMERATOR is
			-- List of class direct ancestors.
		local
			ancestor_list: FIXED_LIST [CL_TYPE_A]
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ancestor: CLASS_DESCRIPTOR
		do
			if is_in_system then
				ancestor_list := compiler_class.compiled_class.parents
				create res.make (ancestor_list.count)
				from
					ancestor_list.start
				until
					ancestor_list.after
				loop
					create ancestor.make_with_class_i (ancestor_list.item.associated_class.lace_class)
					res.extend (ancestor)
					ancestor_list.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end

	ancestor_count: INTEGER is
			-- Number of direct ancestors.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.parents.count
			end
		end
		
	descendants: CLASS_ENUMERATOR is
			-- List of class direct descendants.
		local
			descendant_list: LIST [CLASS_C]
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			descendant: CLASS_DESCRIPTOR
		do
			if is_in_system then
				descendant_list := compiler_class.compiled_class.descendants
				create res.make (descendant_list.count)
				from
					descendant_list.start
				until
					descendant_list.after
				loop
					create descendant.make_with_class_i (descendant_list.item.lace_class)
					res.extend (descendant)
					descendant_list.forth
				end
				create Result.make (res)
			end
		ensure then
			result_exists: is_in_system implies Result /= Void
		end
		
	descendant_count: INTEGER is
			-- Number of direct descendants.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.descendants.count
			end
		end
		
	class_path: STRING is
			-- Full path to file.
		do
			Result := compiler_class.file_name
		ensure then
			result_exists: Result /= Void
		end

	is_deferred: BOOLEAN is
			-- Is class deferred?
		do
			if is_in_system then
				Result := compiler_class.compiled_class.is_deferred
			end
		end

	is_external: BOOLEAN is
			-- Is class external?
		local
			l_class_i: EXTERNAL_CLASS_I
		do
			if is_in_system then
				Result := compiler_class.compiled_class.is_external
			else
				l_class_i ?= compiler_class
				Result := l_class_i /= Void
			end
		end
		
    is_obsolete: BOOLEAN is
            -- Is obsolete feature?
        do
			if is_in_system then
				Result := compiler_class.compiled_class.is_obsolete
			end
        end
        
    obsolete_message: STRING is
            -- Obsolete message?
        do
			if is_in_system then
				Result := compiler_class.compiled_class.obsolete_message
			else
				create Result.make_empty
			end
        end
		
    is_true_external: BOOLEAN is
            -- Is true external class?
		local
			l_file_name: STRING
        do
			if compiler_class.compiled_class /= Void then
				Result := compiler_class.compiled_class.is_true_external
			else
				l_file_name := compiler_class.file_name.out
				if l_file_name.count > 5 then
					Result := l_file_name.substring (l_file_name.count - 4, l_file_name.count).is_equal (".info")
				end
			end          
        end

	is_generic: BOOLEAN is
			-- Is class generic?
		do
			if is_in_system then
				Result := compiler_class.compiled_class.generics /= Void
			end
		end
		
	is_library: BOOLEAN is
			-- Is class part of a library.
		do
			if is_in_system then
				Result := compiler_class.compiled_class.cluster.is_library
			end
		end
		
	assertions: INTEGER is
			-- assertions
		do
			if compiler_class.assertion_level.check_precond then
				Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_require
			end
			if compiler_class.assertion_level.check_postcond then
				Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_ensure
			end
			if compiler_class.assertion_level.check_invariant then
				Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_invariant
			end
			if compiler_class.assertion_level.check_loop then
				Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_loop
			end
			if compiler_class.assertion_level.check_check then
				Result := Result + feature {ECOM_EIF_ASSERTIONS_ENUM}.eif_assertions_check
			end
		end
		
	member_of: CLUSTER_DESCRIPTOR is
			-- Cluster class is member of
		do
			create Result.make_with_cluster_i (compiler_class.cluster)
		end
		
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Compare on names
		do
			Result := name < other.name
		end
		
feature {NONE} -- Implementation

	compiler_class: CLASS_I;
			-- Associated compiler structure.

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
end -- class CLASS_DESCRIPTOR
