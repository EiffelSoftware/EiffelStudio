indexing
	description: "Representation of a non-Eiffel compiled class that is external to current system."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EXTERNAL_CLASS_C

inherit
	CLASS_C
		redefine
			lace_class, make
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
		do
				-- Create data structures to hold features information.
			nb := external_class.fields.count + external_class.constructors.count +
				external_class.procedures.count + external_class.functions.count

			create creators.make (external_class.constructors.count)
			create l_feat_tbl.make (nb)
			l_feat_tbl.set_feat_tbl_id (class_id)
			create l_orig_tbl.make (nb)
			l_feat_tbl.set_origin_table (l_orig_tbl)

				-- Initializes feature table.
			process_features (l_feat_tbl, external_class.fields)
			process_features (l_feat_tbl, external_class.constructors)
			process_features (l_feat_tbl, external_class.procedures)
			process_features (l_feat_tbl, external_class.functions)

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
--			class_interface.process_features (l_feat_tbl)

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

feature -- Status report

	is_nested: BOOLEAN
			-- Is current external class a nested type?
			
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
				parent_type := type_from_consumed_type (external_class.parent)
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
					parent_type := type_from_consumed_type (external_class.interfaces.item (i))
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
			parents_filled: Current /= System.system_object_class.compiled_class implies parents.count > 0
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
					l_external_type := type_from_consumed_type (l_member.return_type)
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
						l_external_type := type_from_consumed_type (l_args.item (j).type)
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
			i, j, k, l, nb: INTEGER
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
			l_rout_id_set: ROUT_ID_SET
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
					if not external_class.is_expanded then
						l_creators.put (l_all_export, l_member.eiffel_name)
						l_feat.set_export_status (l_none_export)
					else
						l_feat.set_export_status (l_all_export)
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
						l_ext.set_type (feature {SHARED_IL_CONSTANTS}.Static_type)
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

				create l_rout_id_set.make (1)
				if l_member.is_attribute then
					l_rout_id_set.put (Routine_id_counter.next_attr_id)
				else
					l_rout_id_set.put (Routine_id_counter.next_rout_id)
				end

				l_feat.set_rout_id_set (l_rout_id_set)
				l_feat.set_feature_name (l_member.eiffel_name)
				l_feat.set_feature_id (feature_id_counter.next)
				
				l_written_type := type_from_consumed_type (l_member.declared_type)
				l_feat.set_written_in (l_written_type.class_id)
				l_feat.set_origin_class_id (l_written_type.class_id)
				l_feat.set_written_feature_id (l_feat.feature_id)
				
				if l_written_type.class_id = class_id then
					l_feat.set_is_origin (True)
				end

				if l_member.has_return_value then			
					l_external_type := type_from_consumed_type (l_member.return_type)
					add_syntactical_supplier (l_external_type)
					
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
						j := l_args.lower
						k := l_args.upper
						create l_feat_arg.make (k - j + 1)
						create l_arg_ids.make (1, k - j + 1)
					until
						j > k
					loop
						l_external_type := type_from_consumed_type (l_args.item (j).type)
						l_feat_arg.put_i_th (l_external_type, l + 1)
						l_names_heap.put (l_args.item (j).eiffel_name)
						l_feat_arg.argument_names.put (l_names_heap.found_item, l)
						
						l_names_heap.put (l_args.item (j).type.name)
						l_arg_ids.put (l_names_heap.found_item, l + 1)
						
						add_syntactical_supplier (l_external_type)
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
				l_enclosing_type := type_from_consumed_type (l_nested.enclosing_type)
				is_nested := True
				enclosing_class := l_enclosing_type.associated_class
			end
		end

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CL_TYPE_A is
			-- Given an external type `c' get its associated CL_TYPE_A.
		require
			c_not_void: c /= Void
		local
			l_assembly: ASSEMBLY_I
			l_result: CLASS_I
			l_class: CLASS_C
			l_name: STRING
			l_is_array: BOOLEAN
			l_generics: ARRAY [TYPE_A]
			l_array_type: CONSUMED_ARRAY_TYPE
		do
			l_assembly := lace_class.cluster.referenced_assemblies.item (c.assembly_id)
			l_array_type ?= c
			l_is_array := l_array_type /= Void
			if l_is_array then
				create l_generics.make (1, 1)
				l_generics.put (type_from_consumed_type (l_array_type.element_type), 1)
				create {GEN_TYPE_A} Result.make (
					System.native_array_class.compiled_class.class_id, l_generics)
			else
				l_name := c.name
				l_result := l_assembly.dotnet_classes.item (l_name)
				if l_result = Void then
						-- Case where this is a class from `mscorlib' that is in fact
						-- written as an Eiffel class, e.g. INTEGER, ....
					if l_name.is_equal ("System.Byte") or l_name.is_equal ("System.SByte") then
						l_result := System.integer_8_class
					elseif l_name.is_equal ("System.Int16") or l_name.is_equal ("System.UInt16") then
						l_result := System.integer_16_class
					elseif l_name.is_equal ("System.Int32") or l_name.is_equal ("System.UInt32") then
						l_result := System.integer_32_class
					elseif l_name.is_equal ("System.Int64") or l_name.is_equal ("System.UInt64") then
						l_result := System.integer_64_class
					elseif l_name.is_equal ("System.IntPtr") or l_name.is_equal ("System.UIntPtr") then
						l_result := System.pointer_class
					elseif l_name.is_equal ("System.Double") then
						l_result := System.double_class
					elseif l_name.is_equal ("System.Single") then
						l_result := System.real_class
					elseif l_name.is_equal ("System.Char") then
						l_result := System.character_class
					elseif l_name.is_equal ("System.Boolean") then
						l_result := System.boolean_class
					end
				end
				
				if not l_result.is_compiled then
					Workbench.add_class_to_recompile (l_result)
				end
				l_class := l_result.compiled_class
				Result := l_class.actual_type				
			end
		ensure
			result_not_void: Result /= Void
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

invariant
	il_generation: System.il_generation
	valid_enclosing_class: is_nested implies enclosing_class /= Void

end -- class EXTERNAL_CLASS_C
