indexing
	description: "Description of a class in the system"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DESCRIPTOR

inherit
	IEIFFEL_CLASS_DESCRIPTOR_IMPL_STUB
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
			is_generic,
			is_in_system
		end

	COMPILER_EXPORTER

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
			Result := clone (compiler_class.name)
			REsult.to_upper
		ensure then
			result_exists: Result /= Void
		end

	external_name: STRING is
			-- Class external name.
		do
			Result := compiler_class.external_name
		ensure then
			result_exists: Result /= Void
		end

	description: STRING is
			-- Class description.
		do
			create Result.make (50)
			if is_deferred then
				Result.append ("deferred ")
			end
			if is_generic then
				Result.append ("generic ")
			end
			if is_external then
				Result.append ("external ")
			end
			Result.append ("class " + name)
			if is_external then
				Result.append (", %Nexternal name: " + external_name)
			end
			if is_in_system then
				if 
					tool_tip /= Void and then 
					not tool_tip.is_empty
				then
					Result.append ("%N")
					Result.append ("Description: ")
					Result.append (tool_tip)
				end
			end
			Result.prune_all ('%R')
			Result.prune_all ('%T')
		end

	tool_tip: STRING is
			-- Class Tool Tip.
		local
			indexing_clause: INDEXING_CLAUSE_AS
		do
			if is_in_system then
				indexing_clause := compiler_class.compiled_class.ast.top_indexes
				if indexing_clause /= Void then
					Result := indexing_clause.description
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
			client_list: LINKED_LIST [CLASS_C]
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
			supplier_list: LINKED_LIST [CLASS_C]
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
			descendant_list: LINKED_LIST [CLASS_C]
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
		do
			if is_in_system then
				Result := compiler_class.compiled_class.is_external
			end
		end

	is_generic: BOOLEAN is
			-- Is class generic?
		do
			if is_in_system then
				Result := compiler_class.compiled_class.generics /= Void
			end
		end

feature {NONE} -- Implementation

	compiler_class: CLASS_I
			-- Associated compiler structure.

end -- class CLASS_DESCRIPTOR
