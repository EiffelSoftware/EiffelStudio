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
			is_generic
		end

	COMPILER_EXPORTER

create
	make_with_class_i
	
feature {NONE} -- Initialization

	make_with_class_i (a_class: CLASS_I) is
			-- Initialize structure with `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_class_compiled: a_class.compiled
		do
			create_item
			compiler_class := a_class
		end

feature -- Access

	name: STRING is
			-- Class name.
		do
			Result := compiler_class.name
		ensure then
			result_exists: Result /= Void
		end

	description: STRING is
			-- Class description.
			--| FIXME For the moment, only returns the external name.
		local
			indexing_clause: INDEXING_CLAUSE_AS
		do
			indexing_clause := compiler_class.compiled_class.ast.top_indexes
			if indexing_clause /= Void then
				Result := indexing_clause.external_name
			else
				create Result.make_from_string ("No description available")
			end
		ensure then
			result_exists: Result /= Void
		end

	feature_names: ECOM_ARRAY [STRING] is
			-- List of names of class features.
		local
			names: ARRAY [STRING]
		do
			names := compiler_class.compiled_class.api_feature_table.current_keys
			create Result.make_from_array (names, 1, <<1>>, <<names.count>>)
		ensure then
			result_exists: Result /= Void
		end

	features: ECOM_VARIANT is
			-- List of class features.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: LIST [E_FEATURE]
			f: FEATURE_DESCRIPTOR
			i: INTEGER
		do
			l := compiler_class.compiled_class.written_in_features
			create res.make (1, l.count)
			from
				l.start
				i := 1
			until
				l.after
			loop
				create f.make_with_class_i_and_feature_i (compiler_class, l.item.associated_feature_i)
				res.put (f, i)
				i := i + 1
				l.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<l.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end
		
	feature_count: INTEGER is
			-- Number of class features.
		do
			Result := compiler_class.compiled_class.written_in_features.count
		end

	flat_features: ECOM_VARIANT is
			-- List of class features including ancestor features.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			l: ARRAYED_LIST [FEATURE_I]
			f: FEATURE_DESCRIPTOR
			i: INTEGER
		do
			l := compiler_class.compiled_class.feature_table.linear_representation
			create res.make (1, l.count)
			from
				l.start
				i := 1
			until
				l.after
			loop
				create f.make_with_class_i_and_feature_i (compiler_class, l.item)
				res.put (f, i)
				i := i + 1
				l.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<l.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void			
		end

	flat_feature_count: INTEGER is
			-- Number of flat class features.
		do
			Result := compiler_class.compiled_class.feature_table.count
		end
		
	feature_with_name (a_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature with name `a_name' in `Current'.
			-- Void if none.
		require
			name_not_void: a_name /= Void
		local
			f: FEATURE_I
		do
			f := compiler_class.compiled_class.feature_table.item (a_name)
			if f /= Void then
				create {FEATURE_DESCRIPTOR} Result.make_with_class_i_and_feature_i (compiler_class, f)
			end
		end

	clients: ECOM_VARIANT is
			-- List of class clients.
		local
			client_list: LINKED_LIST [CLASS_C]
			res: ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			client: CLASS_DESCRIPTOR
			i: INTEGER
		do
			client_list := compiler_class.compiled_class.clients
			create res.make (1, client_list.count - 1)
			from
				client_list.start
				i := 1
			until
				client_list.after
			loop
				if client_list.item /= compiler_class.compiled_class then
					create client.make_with_class_i (client_list.item.lace_class)
					res.put (client, i)
					i := i + 1
				end
				client_list.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	client_count: INTEGER is
			-- Number of class client.
		do
			Result := compiler_class.compiled_class.clients.count - 1
		end
		
	suppliers: ECOM_VARIANT is
			-- List of class suppliers.
		local
			supplier_list: LINKED_LIST [CLASS_C]
			res: ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			supplier: CLASS_DESCRIPTOR
			i: INTEGER
		do
			supplier_list := compiler_class.compiled_class.suppliers.classes
			create res.make (1, supplier_list.count - 1)
			from
				supplier_list.start
				i := 1
			until
				supplier_list.after
			loop
				if supplier_list.item /= compiler_class.compiled_class then
					create supplier.make_with_class_i (supplier_list.item.lace_class)
					res.put (supplier, i)
					i := i + 1
				end
				supplier_list.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	supplier_count: INTEGER is
			-- Number of class suppliers.
		do
			Result := compiler_class.compiled_class.suppliers.classes.count - 1
		end

	ancestors: ECOM_VARIANT is
			-- List of class direct ancestors.
		local
			ancestor_list: FIXED_LIST [CL_TYPE_A]
			res: ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ancestor: CLASS_DESCRIPTOR
			i: INTEGER
		do
			ancestor_list := compiler_class.compiled_class.parents
			create res.make (1, ancestor_list.count)
			from
				ancestor_list.start
				i := 1
			until
				ancestor_list.after
			loop
				create ancestor.make_with_class_i (ancestor_list.item.associated_class.lace_class)
				res.put (ancestor, i)
				i := i + 1
				ancestor_list.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	ancestor_count: INTEGER is
			-- Number of direct ancestors.
		do
			Result := compiler_class.compiled_class.parents.count
		end
		
	descendants: ECOM_VARIANT is
			-- List of class direct descendants.
		local
			descendant_list: LINKED_LIST [CLASS_C]
			res: ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			descendant: CLASS_DESCRIPTOR
			i: INTEGER
		do
			descendant_list := compiler_class.compiled_class.descendants
			create res.make (1, descendant_list.count)
			from
				descendant_list.start
				i := 1
			until
				descendant_list.after
			loop
				create descendant.make_with_class_i (descendant_list.item.lace_class)
				res.put (descendant, i)
				i := i + 1
				descendant_list.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end
		
	descendant_count: INTEGER is
			-- Number of direct descendants.
		do
			Result := compiler_class.compiled_class.descendants.count
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
			Result := compiler_class.compiled_class.is_deferred
		end

	is_external: BOOLEAN is
			-- Is class external?
		do
			Result := compiler_class.compiled_class.is_external
		end

	is_generic: BOOLEAN is
			-- Is class generic?
		do
			Result := compiler_class.compiled_class.generics /= Void
		end

feature {NONE} -- Implementation

	compiler_class: CLASS_I
			-- Associated compiler structure.

end -- class CLASS_DESCRIPTOR
