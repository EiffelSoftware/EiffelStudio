indexing
	description: "Common heir for generating IL (MSIL, JVM) metadata for a particular type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_META_DATA_GENERATOR

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize metadata generator.
		do
		end

feature {IL_CODE_GENERATOR} -- Settings

	set_current_class_type (cl_type: like current_class_type) is
			-- Set `current_class_type' to `cl_type'.
		require
			cl_type_not_void: cl_type /= Void
		do
			current_class_type := cl_type
		ensure
			current_class_type_set: current_class_type = cl_type
		end

	set_current_class (cl: like current_class) is
			-- Set `current_class' to `cl'.
		require
			cl_not_void: cl /= Void
		do
			current_class := cl
		ensure
			current_class_set: current_class = cl
		end

feature -- Generation

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Generate class description
		require
			class_type_not_void: class_type /= Void
		local
			name, element_name, file_name: STRING
			native_array: NATIVE_ARRAY_CLASS_TYPE
			is_frozen_class: BOOLEAN
			class_c: CLASS_C
		do
			native_array ?= class_type
			if native_array /= Void then
					-- Generate association with a NATIVE_ARRAY []
				name := native_array.il_type_name
				element_name := native_array.il_element_type_name
				il_generator.generate_class_mappings (name,
					class_type.static_type_id, -1, "", element_name)
			else
				name := class_type.type.il_type_name
				class_c := class_type.associated_class
				is_frozen_class := class_c.is_frozen

				if class_c.is_external or else not is_frozen_class then
						-- Generate mapping for external class or for the
						-- interface representation of an Eiffel class.
					il_generator.generate_class_mappings (name,
						class_type.static_type_id, class_type.static_type_id,
						class_c.lace_class.base_name, Empty_string)
				end
				if not class_c.is_external then
						-- Generate mapping for the implementation class
						-- representation of an Eiffel class.
					if System.line_generation then
						file_name := class_c.file_name
					else
						file_name := Empty_string
					end
					if not is_frozen_class then
						il_generator.generate_class_mappings ("Implementation." + name,
							class_type.implementation_id,
							class_type.static_type_id, file_name, Empty_string)
					else
						il_generator.generate_class_mappings (name,
							class_type.implementation_id,
							class_type.static_type_id, file_name, Empty_string)
					end
				end
			end
		end

	generate_il_class_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate class description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		local
			is_frozen: BOOLEAN
		do
			set_current_class_type (class_type)
			set_current_class (class_c)

			if class_c.is_external then
				-- Generate class nature description
				il_generator.generate_class_header (class_c.is_fully_deferred,
					class_c.is_deferred, class_c.is_frozen, class_c.is_expanded,
					True, -- Class is external
					class_type.static_type_id)
			else
				is_frozen := class_c.is_frozen

				if not is_frozen then
						-- Define interface
					il_generator.generate_class_header (
						True, -- is_fully_deferred
						True, -- is_deferred
						False, -- is_frozen
						False, -- is_expanded,
						False, -- Class is not external,
						class_type.static_type_id)
					generate_interface_ancestors (class_c, class_type, False)
				end

					-- Define implementation
				il_generator.generate_class_header (
					False, -- is_fully_deferred
					class_c.is_deferred,
					is_frozen,
					class_c.is_expanded,
					False, -- is_external
					class_type.implementation_id)

				if not is_frozen then
					generate_implementation_ancestors (class_c, class_type)
				else
					generate_interface_ancestors (class_c, class_type, True)
				end
			end
		end

	generate_metadata (classes: ARRAY [CLASS_C]) is
			-- Store Eiffel names to allow roundtrip
			-- when consuming metadata again.
		require
			classes_not_void: classes /= Void
		local
			i, nb: INTEGER
			class_c: CLASS_C
			metadata_generator: EAC_META_DATA_GENERATOR
		do
			from
				i := classes.lower
				nb := classes.upper
				create metadata_generator.make
			variant
				nb - i + 1
			until
				i > nb
			loop
				class_c := classes.item (i)
				if class_c /= Void and then class_c.is_external and then
				class_c.ast.top_indexes /= Void and then
				class_c.ast.top_indexes.assembly_name /= Void then
					metadata_generator.add (class_c)
				end
				i := i + 1
			end
			metadata_generator.generate
		end

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
			set_current_class_type (class_type)
			set_current_class (class_c)

				-- Generate interface features on Eiffel classes
			if not class_c.is_external then
				inst_context.set_cluster (class_c.cluster)
				if not class_c.is_frozen then
					generate_interface_features (class_c, class_type)
				else
					generate_implementation_features (class_c, class_type)
				end
			end
		end
		
	generate_interface_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				il_generator.start_features_list (current_class_type.static_type_id)
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_interface_feature (feat)
				features.forth
			end

			il_generator.end_features_list
		end

	generate_implementation_features (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features written in `class_c'.
		local
			select_tbl: SELECT_TABLE
			features: SEARCH_TABLE [INTEGER]
			feat: FEATURE_I
		do
			from
				select_tbl := class_c.feature_table.origin_table
				features := class_type.class_interface.features
				il_generator.start_features_list (current_class_type.static_type_id)
				features.start
			until
				features.after
			loop
				feat := select_tbl.item (features.item_for_iteration)
				generate_feature (feat, False)
				features.forth
			end

			il_generator.end_features_list
		end

	generate_class_custom_attribute (class_type: CLASS_TYPE) is
			-- Generate class custom attribute of `class_type' if any.
		require
			class_type_not_void: class_type /= Void
		local
			imp: COM_IL_CODE_GENERATOR
			attributes: EIFFEL_LIST [CREATION_EXPR_AS]
		do
			check
				has_ast: class_type.associated_class.most_recent_ast /= Void
			end
			attributes := class_type.associated_class.most_recent_ast.custom_attribute
			if attributes /= Void then
				generate_custom_attribute (class_type, attributes)
				imp ?= il_generator.implementation
				check
					imp_not_void: imp /= Void
				end

				imp.generate_class_ca
			end
		end

feature {IL_CODE_GENERATOR} -- Feature generation

	generate_feature (feat: FEATURE_I; is_static: BOOLEAN) is
			-- Generate `feat' description.
		require
			feat_not_void: feat /= Void
		local
			is_deferred: BOOLEAN
			is_redefined: BOOLEAN
			is_frozen: BOOLEAN
			inv: INVARIANT_FEAT_I
			name: STRING
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				if feat.has_arguments then
					il_generator.start_feature_description (feat.arguments.count)
				else
					il_generator.start_feature_description (0)
				end
				is_deferred := feat.is_deferred
				inv ?= feat
				is_redefined := not feat.is_origin and then inv = Void
				is_frozen := feat.is_frozen
				
				if is_static then
					if feat.is_c_external then
						name := encoder.feature_name (current_class_type.static_type_id, feat.body_index)
					else
						name := "$$" + feat.external_name
					end
				else
					if feat.is_c_external then
						name := feat.feature_name
					else
						name := feat.external_name
					end
				end

				il_generator.generate_feature_identification (name, feat.feature_id,
					is_redefined, is_deferred, is_frozen, feat.is_attribute,
					is_static and then feat.is_c_external, is_static)
				
				generate_arguments (feat)
				generate_return_type (feat)

				if inv /= Void then
					il_generator.mark_invariant (feat.feature_id)
				end
				il_generator.create_feature_description
				generate_feature_custom_attribute (current_class_type, feat)
			end
		end


	generate_creation_routines (class_c: CLASS_C) is
			-- Generate description for creation routines of `class_c' if any.
		require
			class_c_not_void: class_c /= Void
		local
			a: ARRAY [INTEGER]
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			feat_tbl: FEATURE_TABLE
			i: INTEGER
		do
			if not class_c.is_external then
				creators := class_c.creators	
				if creators /= Void and then not creators.is_empty then
					from
						create a.make (0, class_c.creators.count - 1)
						creators.start
						feat_tbl := class_c.feature_table
					until
						creators.after
					loop
						a.put (feat_tbl.item (creators.key_for_iteration).feature_id, i)
						creators.forth
						i := i + 1
					end
					il_generator.mark_creation_routines (a)
				end
			end
		end

	generate_arguments (feat: FEATURE_I) is
			-- Generate arguments' description of `feat'.
		require
			feat_not_void: feat /= Void
		local
			feat_arg: FEAT_ARG
			type_i: TYPE_I
			i: INTEGER
		do
			if feat.has_arguments then
				feat_arg := feat.arguments
				from
					il_generator.start_arguments_list (feat_arg.count)
					feat_arg.start
					i := 1
				until
					feat_arg.after
				loop
					type_i := feat_arg.item.actual_type.type_i
					check
						type_i_not_void: type_i /= Void
					end
					if not type_i.has_formal then
						if not type_i.is_none then
							il_generator.generate_feature_argument (feat_arg.item_name (i), type_i)
						else
							check
								False
							end
						end
					else
 						il_generator.generate_feature_argument (feat_arg.item_name (i),
							byte_context.real_type (type_i))
					end
					feat_arg.forth
					i := i + 1
				end

				il_generator.end_arguments_list
			end
		end

	generate_return_type (feat: FEATURE_I) is
			-- Generate return type of `feat' if any.
		require
			feat_not_void: feat /= Void
		local
			type_i: TYPE_I
		do
			if
				feat.is_function or
				feat.is_attribute or feat.is_constant
			then
					-- Current feature is a function
				type_i := feat.type.actual_type.type_i
				check
					type_i_not_void: type_i /= Void
				end
				if not type_i.has_formal then
					if not type_i.is_none then
						il_generator.generate_feature_return_type (type_i)
					else
						check
							False
						end
					end
				else
 					il_generator.generate_feature_return_type (byte_context.real_type (type_i))
				end
			end
		end

feature {NONE} -- Feature generation

	generate_interface_feature (feat: FEATURE_I) is
			-- Generate interface `feat' description.
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				if feat.has_arguments then
					il_generator.start_feature_description (feat.arguments.count)
				else
					il_generator.start_feature_description (0)
				end

				if feat.is_c_external then
					il_generator.generate_interface_feature_identification (feat.feature_name,
						feat.feature_id, feat.is_attribute)
				else
					il_generator.generate_interface_feature_identification (feat.external_name,
						feat.feature_id, feat.is_attribute)
				end

				generate_arguments (feat)
				generate_return_type (feat)

				il_generator.create_feature_description

				generate_feature_custom_attribute (current_class_type, feat)
			end
		end

	generate_inherited_feature (feat: FEATURE_I; feat_id: INTEGER) is
			-- Generate `feat' description.
		require
			feat_not_void: feat /= Void
		local
			is_deferred: BOOLEAN
			is_redefined: BOOLEAN
			is_frozen: BOOLEAN
			is_static: BOOLEAN
			inv: INVARIANT_FEAT_I
			name: STRING
		do
			if feat.feature_name_id /= Names_heap.void_name_id then
				if feat.has_arguments then
					il_generator.start_feature_description (feat.arguments.count)
				else
					il_generator.start_feature_description (0)
				end
				is_deferred := False
				inv ?= feat
				is_redefined := not feat.is_origin and then inv = Void
				is_frozen := feat.is_frozen
				is_static := False
				
				if feat.is_c_external then
					name := feat.feature_name
				else
					name := feat.external_name
				end

				il_generator.generate_feature_identification (name, feat_id,
					is_redefined, is_deferred, is_frozen, feat.is_attribute,
					is_static, is_static)
				
				generate_arguments (feat)
				generate_return_type (feat)

				if inv /= Void then
					il_generator.mark_invariant (feat_id)
				end
				il_generator.create_feature_description
				generate_feature_custom_attribute (current_class_type, feat)
			end
		end

feature {NONE} -- Implementation: ancestors description

	generate_interface_ancestors (class_c: CLASS_C; class_type: CLASS_TYPE; is_implementation_class: BOOLEAN) is
			-- Generate ancestors map of `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
			cl_type: CLASS_TYPE
			l_list: SEARCH_TABLE [INTEGER]
			id: INTEGER
			pars: SEARCH_TABLE [CLASS_INTERFACE]
			class_interface: CLASS_INTERFACE
			nb_generics: INTEGER
		do
			parents := class_c.parents
			create class_interface.make_from_context (class_c.class_interface, class_type)
			create pars.make (parents.count)
			from
				byte_context.set_class_type (class_type)
				il_generator.start_parents_list
				create l_list.make (parents.count)
				parents.start
			until
				parents.after
			loop
				parent_type ?= byte_context.real_type (parents.item.type_i)
				cl_type := parent_type.associated_class_type
				if not cl_type.associated_class.is_external then
					id := cl_type.static_type_id
					if not l_list.has (id) then
							-- We only insert once a parent, for .NET it is useless to
							-- do it twice.
						l_list.force (id)
						il_generator.add_to_parents_list (id)
						pars.force (parent_type.associated_class_type.class_interface)
					end
				end
				parents.forth
			end
			class_interface.set_parents (pars)
			class_type.set_class_interface (class_interface)
			if is_implementation_class then
				if class_c.is_generic then
					nb_generics := class_c.generics.count
				end
				il_generator.add_eiffel_interface (nb_generics)
			end
			il_generator.end_parents_list
		end

	generate_implementation_ancestors (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate ancestors map of `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			nb_generics: INTEGER
--			parents: FIXED_LIST [CL_TYPE_A]
--			parent_type: CL_TYPE_I
--			cl_type: CLASS_TYPE
--			pars: SEARCH_TABLE [CLASS_INTERFACE]
--			class_interface: CLASS_INTERFACE
		do
			if class_c.is_generic then
				nb_generics := class_c.generics.count
			end
-- FIXME: following code to use when we are able to do single inheritance
-- to avoid code duplication of stubs.
-- 			parents := class_c.parents
-- 			byte_context.set_class_type (class_type)
-- 			il_generator.start_parents_list
-- 			parent_type ?= byte_context.real_type (parents.first.type_i)
-- 			cl_type := parent_type.associated_class_type
-- 			il_generator.add_to_parents_list (cl_type.implementation_id)
			il_generator.add_eiffel_interface (nb_generics)
			il_generator.add_interface (class_type.static_type_id)
			il_generator.end_parents_list
		end

feature {NONE} -- Implementation: Custom Attributes

	generate_feature_custom_attribute (class_type: CLASS_TYPE; feat: FEATURE_I) is
			-- Generate feature custom attribute of `class_type' if any.
		require
			class_type_not_void: class_type /= Void
			feat_not_void: feat /= Void
		local
			imp: COM_IL_CODE_GENERATOR
			feature_as: FEATURE_AS
			attributes: EIFFEL_LIST [CREATION_EXPR_AS]
		do
			feature_as := feat.body
			if feature_as /= Void then
				attributes := feature_as.custom_attribute
				if attributes /= Void then
					generate_custom_attribute (class_type, attributes)
					imp ?= il_generator.implementation
					check
						imp_not_void: imp /= Void
					end

					imp.generate_feature_ca (feat.feature_id)
				end
			end
		end

	generate_custom_attribute (class_type: CLASS_TYPE; ca: EIFFEL_LIST [CREATION_EXPR_AS]) is
			-- Generate custom attribute represented by `ca'.
			-- If `is_class' it is a custom attribute on `class_type'
		require
			class_type_not_void: class_type /= Void
			has_custom_attributes: ca /= Void
		local
			imp: COM_IL_CODE_GENERATOR
			cb: CREATION_EXPR_B
			count: INTEGER
			param: BYTE_LIST [EXPR_B]
			param_b: PARAMETER_B
			exp: CREATION_EXPR_AS
		do
			from
					-- Initialize data structures needed to perform a `type_check'
					-- and to create a `byte_node' for every creation expression
					-- that represent the custom attribute
				Inst_context.set_cluster (class_type.associated_class.cluster)
				context.clear2
				ca.start

					-- Custom attribute generation is only supported in
					-- COM_IL_CODE_GENERATOR.
				imp ?= il_generator.implementation
				check
					imp_not_void: imp /= Void
				end
			until
				ca.after
			loop
				exp := ca.item
				ca.forth

					-- Type checking and byte code generation
					-- Since the first statement in `type_check' of CREATION_EXPR_AS
					-- is `context.pop (1)' we insert a dummy Void element.
				context.put (Void)
				exp.type_check
				context.start_lines
				cb := exp.byte_node

					-- Clean up of AST_CONTEXT for next type checking.
				context.clear2

				param := cb.call.parameters
				if param /= Void then
					count := param.count
				end

					-- Start initialization of custom attribute.
				imp.add_ca (class_type.implementation_id, il_generator.implementation_id_of (cb.info.type),
					count)

					-- Generate value of arguments if any.
				if count > 0 then
					from
						param.start
					until
						param.after
					loop
						param_b ?= param.item
						check
							param_b_not_void: param_b /= Void
						end
						add_custom_attribute_argument (param_b.expression)
						param.forth
					end
				end
			end
		end

	add_custom_attribute_argument (e: EXPR_B) is
			-- Add `e' to list of arguments needed by custom attribute
			-- creation routine.
		local
			real: REAL_CONST_B
			int: INTEGER_CONSTANT
			char: CHAR_CONST_B
			bool: BOOL_CONST_B
			string: STRING_B
			imp: COM_IL_CODE_GENERATOR
			nested_b: NESTED_B
			ext: EXTERNAL_B
			il_ext: IL_EXTENSION_I
		do
			imp ?= il_generator.implementation
			check
				imp_not_void: imp /= Void
			end

				-- Depending on type of `e' we have to call the feature which
				-- adds an argument of type `e' to the currently generated
				-- custom attribute
			bool ?= e
			if bool /= Void then
				imp.add_caboolean_arg (bool.value)
			else
				int ?= e
				if int /= Void then
					imp.add_cainteger_arg (int.value)
				else
					string ?= e
					if string /= Void then
						imp.add_castring_arg (string.value)
					else
						real ?= e
						if real /= Void then
							imp.add_cadouble_arg (real.value.to_double)
						else
							char ?= e
							if char /= Void then
								imp.add_cacharacter_arg (char.value)
							else
								nested_b ?= e
								if nested_b /= Void then
									ext ?= nested_b.message
									if ext /= Void then
										il_ext ?= ext.extension
										if il_ext /= Void and then il_ext.type = feature {SHARED_IL_CONSTANTS}.enum_field_type then
											imp.add_catyped_arg (ext.external_name.to_integer, il_generator.static_id_of (ext.type))
										else
											check
												not_supported_type: False
											end
										end
									else
										check
											not_supported_type: False
										end
									end
								else
									check
										not_supported_type: False
									end
								end
							end
						end
					end
				end
			end	
		end

feature {NONE} -- Implementation

	written_type_id (class_c: CLASS_C; feat: FEATURE_I): INTEGER is
			-- Return static_type_id of class that defined `feat'.
		require
			class_c_not_void: class_c /= Void
			feat_not_void: feat /= Void
		local
			written_in: INTEGER
			cl_type_a: CL_TYPE_A
			written_class: CLASS_C
		do
			written_in := feat.written_in
				-- If `feat' is defined in current class, that's easy and we
				-- return `current_type_id'. Otherwise we have to find the
				-- correct CLASS_TYPE object where `feat' is written.
			if class_c.class_id = written_in then
				Result := current_type_id
			else
				written_class := System.class_of_id (written_in) 
					-- We go through the hierarchy only when `written_class'
					-- is generic, otherwise for the most general case where
					-- `written_class' is not generic it will take a long
					-- time to go through the inheritance hierarchy.
				if written_class.types.count > 1 then
					cl_type_a := current_class_type.type.type_a
					Result := cl_type_a.find_class_type (written_class)
						.type_i.associated_class_type.static_type_id
				else
					Result := written_class.types.first.static_type_id
				end
			end
		end

	current_class_type: CLASS_TYPE
			-- Current class type being analyzed.

	current_type_id: INTEGER is
			-- Static type_id of class being analyzed.
		require
			current_class_type_set: current_class_type /= Void
		do
			Result := current_class_type.static_type_id
		end

	current_class: CLASS_C
			-- Current class being treated.

	Empty_string: STRING is ""
			-- Empty string

end -- class IL_META_DATA_GENERATOR

