indexing
	description: "Representation of a non-Eiffel compiled class that is external to current system."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CLASS_C

inherit
	CLASS_C
		rename
			cluster as assembly
		redefine
			lace_class,
			is_true_external,
			make,
			assembly
		end

create
	make

feature {NONE} -- Initialization

	make (l: CLASS_I) is
			-- Create instance of a compiled class using 'l'.
		do
			Precursor {CLASS_C} (l)
			is_external := True
		end

feature -- Initialization

	process_degree_5 is
			-- Read XML data and analyzes syntactical suppliers.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
		do
				-- Initialize `external_class' which will be used later by
				-- `initialize_from_xml_data', then it is discarded to save
				-- some memory as we do not use it anymore.
			create l_reader
			external_class ?= l_reader.new_object_from_file (lace_class.file_name)

			if external_class = Void then
					-- For some reasons, the XML file could not be retried.
				error_handler.insert_error (create {VIIC}.make (Current))
				error_handler.raise_error
			else
				private_external_name := external_class.dotnet_name

					-- This initialization is required as `initialize_from_xml_data'
					-- needs proper information about classes to build correct feature
					-- signature.
				is_deferred := external_class.is_deferred
				is_expanded := external_class.is_expanded
				is_enum := external_class.is_enum
				is_frozen := external_class.is_frozen

					-- Initializes inheritance structure
				process_parents

					-- Check if it is a nested type or not.
				process_nesting

					-- Initializes client/supplier relations.
				process_syntax_features (external_class.fields)
				process_syntax_features (external_class.constructors)
				process_syntax_features (external_class.procedures)
				process_syntax_features (external_class.functions)

					-- Remove further processing except degree_4 since we assume that
					-- imported XML is correct.
				degree_3.remove_class (Current)
				degree_2.remove_class (Current)
				degree_1.remove_class (Current)
				System.degree_minus_1.remove_class (Current)
			end
		ensure
			external_class_not_void: external_class /= Void
			not_in_degree_3: not degree_3_needed
			not_in_degree_2: not degree_2_needed
			not_in_degree_1: not degree_1_needed
			not_in_degree_minus_1: not degree_minus_1_needed
		end

	process_degree_4 is
			-- Read XML data and create feature table.
		require
			external_class_not_void: external_class /= Void
		local
			nb: INTEGER
			l_feat_tbl: like feature_table
			l_orig_tbl: SELECT_TABLE
			l_fields, l_constructors, l_procedures, l_functions: ARRAY [CONSUMED_ENTITY]
		do
				-- Create data structures to hold features information.
			l_fields := external_class.fields
			l_constructors := external_class.constructors
			l_procedures := external_class.procedures
			l_functions := external_class.functions
			nb := l_fields.count + l_constructors.count +
				l_procedures.count + l_functions.count

			create creators.make (l_constructors.count)
			create l_feat_tbl.make (nb)
			l_feat_tbl.set_feat_tbl_id (class_id)
			create l_orig_tbl.make (nb)
			l_feat_tbl.set_origin_table (l_orig_tbl)

				-- Initializes feature table.
			process_features (l_feat_tbl, l_fields)
			process_features (l_feat_tbl, l_constructors)
			process_features (l_feat_tbl, l_procedures)
			process_features (l_feat_tbl, l_functions)

				-- Update creators to Void when no creators are available
				-- on an expanded class.
			if creators.count = 0 and then is_expanded then
				creators := Void
			end

				-- Initialize `types'.
			init_types

				-- Create CLASS_INTERFACE instance
			init_class_interface

				-- Topological sort has been done and therefore all parents of current class
				-- have been processed yet.
			class_interface.process_features (l_feat_tbl)

				-- Save freshly computed feature table on disk.
			Tmp_feat_tbl_server.put (l_feat_tbl)
			external_class := Void
		ensure
			external_class_void: external_class = Void
			feature_table_not_void: feature_table /= Void
			types_not_void: types /= Void
			class_interface_not_void: class_interface /= Void
		end

feature -- Access

	lace_class: EXTERNAL_CLASS_I
			-- Corresponding lace class.

	external_class: CONSUMED_TYPE
			-- Data read from XML file.

	enclosing_class: CLASS_C
			-- Class in which Current class is defined when `is_nested'.

	assembly: ASSEMBLY_I is
			-- Associated assembly of current.
		do
			Result := lace_class.assembly
		end

	type_from_consumed_type_in_assembly (
			an_assembly: ASSEMBLY_I;
			c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
		is
			-- Given an external type `c' in assembly `an_assembly'
			-- get its associated CL_TYPE_A.
			-- Void, if `c' is not part of system.
		require
			an_assembly_not_void: an_assembly /= Void
			c_not_void: c /= Void
		do
			Result := internal_type_from_consumed_type_in_assembly (an_assembly, False, c)
		end

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A is
			-- Given an external type `c' get its associated CL_TYPE_A.
			-- Void, if `c' is not part of system.
		require
			c_not_void: c /= Void
			c_in_assembly_of_current_class:
				lace_class.assembly.referenced_assemblies.item (c.assembly_id) /= Void
		do
			Result := internal_type_from_consumed_type (False, c)
		end

feature -- Status report

	is_nested: BOOLEAN
			-- Is current external class a nested type?

	is_true_external: BOOLEAN is True
			-- Is class an instance of EXTERNAL_CLASS_C?
			-- If yes, we do not generate it.

feature -- Query

	has_associated_property_setter (a_feat: FEATURE_I): BOOLEAN is
			-- Associated property setter of `a_feat' if any.
		require
			a_feat_not_void: a_feat /= Void
			a_feat_is_function: a_feat.is_function
			a_feat_is_external: a_feat.is_external
		local
			l_reader: EIFFEL_XML_DESERIALIZER
			l_consumed_type: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_prop: CONSUMED_PROPERTY
			i, nb: INTEGER
			done: BOOLEAN
		do
				-- Initialize `external_class' which will be used later by
				-- `initialize_from_xml_data', then it is discarded to save
				-- some memory as we do not use it anymore.
			create l_reader
			l_consumed_type ?= l_reader.new_object_from_file (lace_class.file_name)
			
				-- It should not be Void, since we were able to parse it before, but it
				-- is possible that someone might remove the file or other external
				-- events, so we protect our call.
			if l_consumed_type /= Void then
				l_properties := l_consumed_type.properties
				from
					i := l_properties.lower
					nb := l_properties.upper
				until
					i > nb or done
				loop
					l_prop := l_properties.item (i)
					if l_prop /= Void then
						if l_prop.getter.eiffel_name.is_equal (a_feat.feature_name) then
							done := True
							Result := l_prop.setter /= Void
						end
					end
					i := i + 1
				end
			end
		end
		
feature {NONE} -- Initialization

	process_parents is
			-- Initialize inheritance clause of Current using `external_class'
		require
			system_object_not_void: System.system_object_class /= Void
			system_object_compiled: System.system_object_class.is_compiled
		local
			parent_type: CL_TYPE_A
			parent_class: CLASS_C
			i, nb: INTEGER
			pars: like parents
		do
			nb := 1
			if external_class.interfaces /= Void then
				nb := nb + external_class.interfaces.count
			end

			create pars.make (nb)

			if external_class.parent /= Void then
				parent_type := internal_type_from_consumed_type (True, external_class.parent)
				pars.extend (parent_type)
				parent_class := parent_type.associated_class
				parent_class.add_descendant (Current)
				add_syntactical_supplier (parent_type)
			elseif external_class.is_interface then
					-- Force inheritance to `System.Object' for interfaces.
				is_interface := True
				parent_class := System.system_object_class.compiled_class
				pars.extend (parent_class.actual_type)
				parent_class.add_descendant (Current)
				syntactical_suppliers.start
				syntactical_suppliers.search (parent_class)
				if not syntactical_suppliers.after then
					syntactical_suppliers.extend (parent_class)
				end
			end

			if external_class.interfaces /= Void and not external_class.interfaces.is_empty then
				from
					i := external_class.interfaces.lower
					nb := external_class.interfaces.upper
				until
					i > nb
				loop
					parent_type := internal_type_from_consumed_type (True,
						external_class.interfaces.item (i))
					pars.extend (parent_type)
					parent_class := parent_type.associated_class
					parent_class.add_descendant (Current)
					add_syntactical_supplier (parent_type)
					i := i + 1
				end
			end
			parents := pars
		ensure
			parents_not_void: parents /= Void
			parents_filled:
				Current /= System.system_object_class.compiled_class implies parents.count > 0
		end

	process_syntax_features (a_features: ARRAY [CONSUMED_ENTITY]) is
			-- Get all features and make sure all referenced types are in system.
		require
			a_features_not_void: a_features /= Void
		local
			l_member: CONSUMED_ENTITY
			l_args: ARRAY [CONSUMED_ARGUMENT]
			i, j, k, l, nb: INTEGER
			l_external_type: CL_TYPE_A
		do
			from
				i := a_features.lower
				nb := a_features.upper
			until
				i > nb
			loop
				l_member := a_features.item (i)

				if l_member.has_return_value then
					l_external_type := internal_type_from_consumed_type (True, l_member.return_type)
					add_syntactical_supplier (l_external_type)
				end

				if l_member.has_arguments then
					from
						l_args := l_member.arguments
						l := 0
						j := l_args.lower
						k := l_args.upper
					until
						j > k
					loop
						l_external_type := internal_type_from_consumed_type (True,
							l_args.item (j).type)
						add_syntactical_supplier (l_external_type)
						l := l + 1
						j := j + 1
					end
				end

				i := i + 1
			end
		end

	process_features (a_feat_tbl: like feature_table; a_features: ARRAY [CONSUMED_ENTITY]) is
			-- Get all features and make sure all referenced types are in system.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			has_origin_table: a_feat_tbl.origin_table /= Void
			a_features_not_void: a_features /= Void
		local
			l_member: CONSUMED_ENTITY
			l_literal: CONSUMED_LITERAL_FIELD
			l_constructor: CONSUMED_CONSTRUCTOR
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg_ids: ARRAY [INTEGER]
			i, j, k, l, m, nb, l_record_pos: INTEGER
			l_orig_tbl: SELECT_TABLE
			l_creators: like creators
			l_external_type, l_written_type: CL_TYPE_A
			l_feat: FEATURE_I
			l_attribute: ATTRIBUTE_I
			l_proc: PROCEDURE_I
			l_deferred: DEF_PROC_I
			l_external: EXTERNAL_I
			l_constant: CONSTANT_I
			l_ext: IL_EXTENSION_I
			l_all_export: EXPORT_ALL_I
			l_none_export: EXPORT_NONE_I
			l_feat_arg: FEAT_ARG
			l_names_heap: like Names_heap
		do
			from
				i := a_features.lower
				nb := a_features.upper
				l_orig_tbl := a_feat_tbl.origin_table
				l_creators := creators
				l_names_heap := Names_heap
				create l_all_export
				create l_none_export
			until
				i > nb
			loop
				l_deferred := Void
				l_external := Void
				l_constant := Void

				l_member := a_features.item (i)

				if l_member.is_attribute then
					if l_member.is_literal then
						l_literal ?= l_member
						check
							l_literal_not_void: l_literal /= Void
						end
						if external_class.is_enum then
							create {EXTERNAL_FUNC_I} l_external
							l_feat := l_external
						else
							create l_constant.make
							l_feat := l_constant
						end
					else
						create l_attribute.make
						l_feat := l_attribute
					end
				elseif l_member.is_deferred then
					if l_member.has_return_value then
						create {DEF_FUNC_I} l_deferred
					else
						create {DEF_PROC_I} l_deferred
					end
					l_feat := l_deferred
				else
					if l_member.is_artificially_added then
							-- Special care of `|', `to_integer' and `from_integer' of
							-- enum classes which have to be non-external feature.
						if l_member.has_return_value then
							create {DYN_FUNC_I} l_feat
						else
							create {DYN_PROC_I} l_feat
						end
					else
						if l_member.has_return_value then
							create {EXTERNAL_FUNC_I} l_external
						else
							create {EXTERNAL_I} l_external
						end
						l_feat := l_external
					end
				end

					-- Add creation routine to `creators' if any.
				l_constructor ?= l_member
				if l_constructor /= Void then
						-- Special case for value type where creation routines
						-- are simply generated as normal feature and cannot be used
						-- as creation procedure because usually there are more
						-- than one possible creation routine and this is forbidden
						-- by Eiffel specification on expanded.
					l_creators.put (l_all_export, l_member.eiffel_name)
					if external_class.is_expanded then
						l_feat.set_export_status (l_all_export)
					else
						l_feat.set_export_status (l_none_export)
					end
				else
					if l_member.is_public then
						l_feat.set_export_status (l_all_export)
					else
						l_feat.set_export_status (l_none_export)
					end
				end

				create l_ext
				if l_external /= Void then
					l_external.set_extension (l_ext)
				elseif l_deferred /= Void then
					l_deferred.set_extension (l_ext)
				elseif l_attribute /= Void then
					l_attribute.set_extension (l_ext)
				end

				if l_member.is_static then
					if l_member.is_attribute then
						if external_class.is_enum then
							l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Enum_field_type)
						else
							l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Static_field_type)
						end
					else
						if l_member.is_prefix or l_member.is_infix then
							check
								not_manually_added: not l_member.is_artificially_added
							end
							l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Operator_type)
						else
							l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Static_type)
						end
					end
				else
					if l_member.is_attribute then
						l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Field_type)
					elseif l_constructor /= Void then
						l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Creator_type)
					elseif l_deferred /= Void then
						l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Deferred_type)
					else
						l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Normal_type)
					end
				end

				l_ext.set_base_class (l_member.declared_type.name)

				if l_ext.type = feature {SHARED_IL_CONSTANTS}.Enum_field_type then
					l_names_heap.put (l_literal.value)
					l_ext.set_alias_name_id (l_names_heap.found_item)
				else
					l_names_heap.put (l_member.dotnet_name)
					l_ext.set_alias_name_id (l_names_heap.found_item)
				end

				if l_member.has_return_value then
					l_external_type := internal_type_from_consumed_type (True, l_member.return_type)

					l_feat.set_type (l_external_type)

					l_names_heap.put (l_member.return_type.name)
					l_ext.set_return_type (l_names_heap.found_item)

					if l_constant /= Void then
						set_constant_value (l_constant, l_external_type, l_literal.value)
					end
				end

				if l_member.has_arguments then
					from
						l_args := l_member.arguments
						l := 0
						m := 0
						j := l_args.lower
						k := l_args.upper
						if not l_member.is_artificially_added and (l_member.is_infix or l_member.is_prefix) then
							check
								l_args_big_enough: l_member.is_infix implies l_args.lower + 1 <= l_args.upper
								l_args_big_enough2: l_member.is_prefix implies l_args.count = 1
							end
							l_record_pos := j + 1
						else
							l_record_pos := j
						end
						create l_feat_arg.make (k - l_record_pos + 1)
						create l_arg_ids.make (1, k - j + 1)
					until
						j > k
					loop
						if j >= l_record_pos then
							l_external_type := internal_type_from_consumed_type (True,
								l_args.item (j).type)
							l_feat_arg.put_i_th (l_external_type, m + 1)
							l_names_heap.put (l_args.item (j).eiffel_name)
							l_feat_arg.argument_names.put (l_names_heap.found_item, m)
							m := m + 1
						end

						l_names_heap.put (l_args.item (j).type.name)
						l_arg_ids.put (l_names_heap.found_item, l + 1)

						l := l + 1
						j := j + 1
					end
					l_proc ?= l_feat
					check
						is_procedure: l_proc /= Void
					end
					l_ext.set_argument_types (l_arg_ids)
					l_proc.set_arguments (l_feat_arg)
				end

				l_feat.set_is_infix (l_member.is_infix)
				l_feat.set_is_prefix (l_member.is_prefix)

				l_feat.set_is_frozen (l_member.is_frozen)
				if l_member.is_prefix then
					l_feat.set_feature_name (
						Prefix_infix_names.prefix_feature_name_with_symbol (l_member.eiffel_name))
				elseif l_member.is_infix then
					l_feat.set_feature_name (
						Prefix_infix_names.infix_feature_name_with_symbol (l_member.eiffel_name))
				else
					l_feat.set_feature_name (l_member.eiffel_name)
				end
				l_feat.set_feature_id (feature_id_counter.next)

				l_written_type := internal_type_from_consumed_type (True, l_member.declared_type)
				l_feat.set_written_in (l_written_type.class_id)
				l_feat.set_origin_class_id (l_written_type.class_id)
				l_feat.set_written_feature_id (l_feat.feature_id)

					-- Let's find the right routine id, i.e. reuse one
					-- because current feature is a redefinition or create
					-- a new one.
				compute_rout_id_set (a_feat_tbl, l_feat, l_member)

				check
					not_already_inserted: not a_feat_tbl.has_id (l_feat.feature_name_id)
				end
				a_feat_tbl.put (l_feat, l_feat.feature_name_id)
				l_orig_tbl.put (l_feat, l_feat.rout_id_set.first)
				i := i + 1
			end
		end

	process_nesting is
			-- If `external_class' represent an instance of CONSUMED_NESTED_TYPE
			-- we initialize `enclosing_class' correctly.
		require
			external_class_not_void: external_class /= Void
		local
			l_nested: CONSUMED_NESTED_TYPE
			l_enclosing_type: CL_TYPE_A
		do
			l_nested ?= external_class
			if l_nested /= Void then
				l_enclosing_type := internal_type_from_consumed_type (True, l_nested.enclosing_type)
				is_nested := True
				enclosing_class := l_enclosing_type.associated_class
				add_syntactical_supplier (l_enclosing_type)
			end
		end

feature {NONE} -- Implementation

	compute_rout_id_set (a_feat_tbl: FEATURE_TABLE; a_feat: FEATURE_I; a_member: CONSUMED_ENTITY) is
			-- Compute a new `rout_id_set' for `a_feat' based on
			-- info of current class and parent classes. If we do not found a matching routine
			-- in a parent class, then we set `is_origin' on `a_feat'.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_feat_tbl_has_origin_table: a_feat_tbl.origin_table /= Void
			a_feat_not_void: a_feat /= Void
			a_feat_with_no_rout_id_set: a_feat.rout_id_set = Void
			a_member_not_void: a_member /= Void
		local
			l_rout_id_set: ROUT_ID_SET
			l_feat: FEATURE_I
			l_parent_class: CLASS_C
		do
				-- We need to look up parents of current class to find if some routine IDs
				-- have been assigned or not. At this stage `a_feat' contains valid data,
				-- only `rout_id_set' of `a_feat' has not yet been set.
				-- 
				-- Note: Manu 08/13/2002
				-- In most cases the below alogorithm is going to find an inherited
				-- routine id, however in the case where a MethodImpl has been done in current
				-- class, we do not get a routine because it is private, or if it is public
				-- we cannot yet trace back to which inherited feature/class MethodImpl has been
				-- done, so we will create a new routine id, we will not do a merge, which seems to
				-- be the .NET behavior anyway.

			create l_rout_id_set.make (1)
				
			if not a_member.is_virtual then
					-- Either it is a new feature of current or an inherited one,
					-- in the first case we create a new routine id, otherwise we reuse the
					-- parent one.
				if a_feat.written_class /= Current then
					l_feat := matching_external_feature_in (a_feat, a_feat.written_class, a_member)
					check
						l_feat_not_void: l_feat /= Void
					end
					l_rout_id_set.merge (l_feat.rout_id_set)
				end
			else
					-- It is virtual, we need to find out from where we are coming.
					-- We first check on all interfaces of current class, and only when
					-- we do not find any matching routine, then we check the main parent.
				from
					parents.start
				until
					parents.after
				loop
					if parents.item.associated_class.is_interface then
						l_feat := matching_external_feature_in (a_feat,
							parents.item.associated_class, a_member)
						if l_feat /= Void then
							l_rout_id_set.merge (l_feat.rout_id_set)
						end
					else
						check
							no_parent_found_yet: l_parent_class = Void
						end
						l_parent_class := parents.item.associated_class
					end
					parents.forth
				end
			end
		
			if l_feat = Void and l_parent_class /= Void then
					-- Let's check the main parent now.
				l_feat := matching_external_feature_in (a_feat, l_parent_class, a_member)
				if l_feat /= Void then
					l_rout_id_set.merge (l_feat.rout_id_set)
				end
			end

			if l_rout_id_set.is_empty then
					-- No existing routine id has been found, let's create a new one.
				if a_feat.is_attribute then
					l_rout_id_set.put (Routine_id_counter.next_attr_id)
				else
					l_rout_id_set.put (Routine_id_counter.next_rout_id)
				end
					-- Because no previous routine could be found, this is an origin.
				a_feat.set_is_origin (True)
			end

				-- Insert the computed routine IDs.
			a_feat.set_rout_id_set (l_rout_id_set)
		ensure
			a_feat_updated: a_feat.rout_id_set /= Void and then not a_feat.rout_id_set.is_empty
			not_already_inserted:
				not a_feat.rout_id_set.linear_representation.there_exists (
					agent (a_feat_tbl.origin_table).has)
		end

	matching_external_feature_in (
			a_feat: FEATURE_I; a_class: CLASS_C; a_member: CONSUMED_ENTITY): FEATURE_I
		is
			-- Look up a feature whose external name is `a_name_id' in `a_class'.
		require
			a_feat_not_void: a_feat /= Void
			a_class_not_void: a_class /= Void
			a_class_is_true_external: a_class.is_true_external
			a_member_not_void: a_member /= Void
		local
			l_feat_tbl: FEATURE_TABLE
			l_feat: FEATURE_I
			l_found: BOOLEAN
			i, nb: INTEGER
			l_other_ext, l_feat_ext: IL_EXTENSION_I
		do
			l_feat_ext ?= a_feat.extension

			if l_feat_ext = Void then
					-- If it does not have an extension is either means that `a_feat' is either:
					-- 1 - a constant
					-- 2 - an artificially added feature such as `from_integer', `infix "|"' and
					--     `to_integer' on all enum types.
					--
					-- In those cases, we can safely assume that because the aboves features
					-- are frozen, that generating a new routine id is not going to be harmfull.
				check
					frozen_feature: a_feat.is_frozen or a_feat.is_constant
				end
			else
					-- Let's find a matching inherited feature.
				l_feat_tbl := a_class.feature_table
				from
					l_feat_tbl.start
					l_found := False
				until
					l_feat_tbl.after or else Result /= Void
				loop
					l_feat := l_feat_tbl.item_for_iteration
					l_other_ext ?= l_feat.extension
						-- We only analyze an inherited routine `l_feat' when it makes sense:
						-- 1 - `l_feat' should be defined in a class that is an ancestor of the
						--      class where `a_feat' is defined.
						-- 2 - It should have an extension part, since `a_feat' has one.
						-- 3 - It should have the same external name
						-- 4 - Both routines seems to be coming from the same class, otherwise
						--     the parent one should not be frozen (as it makes no sense to be
						--     able to redefine a frozen feature.
					if
						a_feat.written_class.simple_conform_to (l_feat.written_class) and then
						l_other_ext /= Void and then
						l_other_ext.alias_name_id = l_feat_ext.alias_name_id and then
						(a_feat.written_class = l_feat.written_class or else not l_feat.is_frozen)
					then
							-- We found a routine, let's check that is the right one
							-- by comparing their return type and their arguments type.
						if
							l_feat.type.same_as (a_feat.type) and then
							l_feat.argument_count = a_feat.argument_count
						then
							if l_feat.argument_count = 0 then
								l_found := True
							else
								from
									i := l_other_ext.argument_types.lower
									nb := l_other_ext.argument_types.upper
									l_found := True
								until
									i > nb or not l_found
								loop
									l_found := l_other_ext.argument_types.item (i) =
										l_feat_ext.argument_types.item (i)
									
									i := i + 1
								end
							end
							if l_found then
									-- We found an inherited feature matching current.
									-- If we are in an interface and that a parent interface
									-- already define the same feature, then we have to create
									-- a new routine ID.
								if is_interface then
									if
										not a_feat.is_deferred or else
										a_feat.written_class = l_feat.written_class
									then
										Result := l_feat
									end
								else
									Result := l_feat
								end
							end
						end
					end
					l_feat_tbl.forth
				end
			end
		end
		
	internal_type_from_consumed_type (
			force_compilation: BOOLEAN; c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
		is
			-- Given an external type `c' get its associated CL_TYPE_A.
			-- If `force_compilation' automatically add it for later compilation
		require
			c_not_void: c /= Void
			c_in_assembly_of_current_class:
				lace_class.assembly.referenced_assemblies.item (c.assembly_id) /= Void
		do
			Result := internal_type_from_consumed_type_in_assembly (
				lace_class.assembly.referenced_assemblies.item (c.assembly_id),
				force_compilation, c)
		end

	internal_type_from_consumed_type_in_assembly (
			an_assembly: ASSEMBLY_I; force_compilation: BOOLEAN;
			c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A
		is
			-- Given an external type `c' in assembly `an_assembly' get its
			-- associated CL_TYPE_A.
			-- If `force_compilation' automatically add it for later compilation
		require
			assembly_not_void: an_assembly /= Void
			c_not_void: c /= Void
		local
			l_result: CLASS_I
			l_class: CLASS_C
			l_is_array: BOOLEAN
			l_generics: ARRAY [TYPE_A]
			l_array_type: CONSUMED_ARRAY_TYPE
			l_type_a: CL_TYPE_A
			vtct: VTCT
		do
			l_array_type ?= c
			l_is_array := l_array_type /= Void
			if l_is_array then
				l_type_a := internal_type_from_consumed_type (force_compilation,
					l_array_type.element_type)
				if l_type_a /= Void then
					create l_generics.make (1, 1)
					l_generics.put (l_type_a, 1)
					create {NATIVE_ARRAY_TYPE_A} Result.make (
						System.native_array_class.compiled_class.class_id, l_generics)				
				end
			else
				l_result := an_assembly.dotnet_classes.item (c.name)
				if l_result = Void then
						-- Case where this is a class from `mscorlib' that is in fact
						-- written as an Eiffel class, e.g. INTEGER, ....
					check
						has_basic: Basic_type_mapping.has (c.name)
					end
					l_result := Basic_type_mapping.item (c.name)
				end
				
				if l_result = Void then
						-- Type could not be found. Something must be inconsistent in 
						-- this assembly.
					create vtct
					vtct.set_class (Current)
					vtct.set_dotnet_class_name (c.name)
					Error_handler.insert_error (vtct)
					Error_handler.raise_error
				else
					if force_compilation and then not l_result.is_compiled then
						Workbench.add_class_to_recompile (l_result)
					end
					if l_result.is_compiled then
						l_class := l_result.compiled_class
						Result := l_class.actual_type
					end
				end
			end
		ensure
			result_not_void: force_compilation implies Result /= Void
		end

	basic_type_mapping: HASH_TABLE [CLASS_I, STRING] is
			-- Mapping between name of basic class in mscorlib and Eiffel CLASS_I.
		once
			create Result.make (20)
			Result.put (System.boolean_class, "System.Boolean")
			Result.put (System.character_class, "System.Char")
			Result.put (System.integer_8_class, "System.Byte")
			Result.put (System.integer_8_class, "System.SByte")
			Result.put (System.integer_16_class, "System.Int16")
			Result.put (System.integer_16_class, "System.UInt64")
			Result.put (System.integer_32_class, "System.Int32")
			Result.put (System.integer_32_class, "System.UInt32")
			Result.put (System.integer_64_class, "System.Int64")
			Result.put (System.integer_64_class, "System.UInt64")
			Result.put (System.pointer_class, "System.IntPtr")
			Result.put (System.pointer_class, "System.UIntPtr")
			Result.put (System.real_class, "System.Single")
			Result.put (System.double_class, "System.Double")
		ensure
			basic_type_mapping_not_void: Result /= Void
		end

	set_constant_value (a_constant: CONSTANT_I; a_external_type: CL_TYPE_A; a_value: STRING) is
			-- Set `value' of `a_constant' with data of `a_value' using `a_external_type'
			-- to find out type of constant.
		require
			a_constant_not_void: a_constant /= Void
			a_external_type_not_void: a_external_type /= Void
			a_value_not_void: a_value /= Void and then not a_value.is_empty
		local
			l_int: INTEGER_CONSTANT
			l_val: like a_value
			l_is_negative: BOOLEAN
			l_value: VALUE_I
			l_bool_value: BOOL_VALUE_I
			l_char_value: CHAR_VALUE_I
			l_double_value: REAL_VALUE_I
			l_real_value: FLOAT_VALUE_I
			l_string_value: STRING_VALUE_I
			l_int32: INTEGER
			l_double: DOUBLE
			l_real: REAL
		do
				-- FIXME: Manu 05/06/2002: Below code for reading double and float
				-- does not work, but I did not check yet why.
			if a_external_type.is_double then
				create l_int.make_default
				l_int.initialize_from_hexa ("0x" + a_value)
				l_int32 := l_int.upper;
				($l_double).memory_copy ($l_int32, 4)
				l_int32 := l_int.lower;
				($l_double + 4).memory_copy ($l_int32, 4)

				create l_double_value
				l_double_value.set_double_value (l_double)
				l_value := l_double_value
			elseif a_external_type.is_real then
				create l_int.make_default
				l_int.initialize_from_hexa ("0x" + a_value)
				l_int32 := l_int.lower;
				($l_real).memory_copy ($l_int32, 4)

				create l_real_value
				l_real_value.set_real_value (l_real)
				l_value := l_real_value
			elseif a_external_type.is_integer then
				if a_value.item (1) = '-' then
					l_val := a_value.substring (2, a_value.count)
					l_is_negative := True
				else
					l_val := a_value
				end
				create l_int.make_default
				l_int.initialize (l_is_negative, l_val)
				l_value := l_int
			elseif a_external_type.is_boolean then
				a_value.to_lower
				create l_bool_value
				l_bool_value.set_bool_val (a_value.is_equal (a_value.True_constant))
				l_value := l_bool_value
			elseif a_external_type.is_character then
				check
					valid_count: a_value.count = 1
				end
				create l_char_value
				l_char_value.set_char_val (a_value.item (1))
				l_value := l_char_value
			elseif a_external_type.associated_class.lace_class = System.system_string_class then
				create l_string_value
				l_string_value.set_system_string_value (a_value)
				l_value := l_string_value
			end
			a_constant.set_value (l_value)
		end

	add_syntactical_supplier (cl: CL_TYPE_A) is
			-- Add every class mentioned in `cl' to `syntactical_suppliers' list.
		require
			cl_not_void: cl /= Void
		do
			syntactical_suppliers.force (cl.associated_class)
			if cl.has_generics then
				check
					one_generic_parameter: cl.generics.count = 1
					lower_is_one: cl.generics.lower = 1
					has_class: cl.generics.item (1).associated_class /= Void
				end
				syntactical_suppliers.force (cl.generics.item (1).associated_class)
			end
		ensure
			inserted_class: syntactical_suppliers.has (cl.associated_class)
			inserted_generic_parameter: cl.has_generics implies
				syntactical_suppliers.has (cl.generics.item (1).associated_class)
		end

	prefix_infix_names: PREFIX_INFIX_NAMES is
		once
			create Result
		end

invariant
	il_generation: System.il_generation
	is_external_set: is_external
	is_true_external_set: is_true_external
	valid_enclosing_class: is_nested implies enclosing_class /= Void

end -- class EXTERNAL_CLASS_C
