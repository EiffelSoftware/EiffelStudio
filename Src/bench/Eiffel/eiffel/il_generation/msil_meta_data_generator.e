indexing
	description: "Generates MSIL metadata for a particular type"
	date: "$Date$"
	revision: "$Revision$"

class
	MSIL_META_DATA_GENERATOR

inherit
	IL_META_DATA_GENERATOR
		rename
			context as byte_context
		redefine
			generate_il_features_description
		end

	SHARED_INST_CONTEXT

	SHARED_AST_CONTEXT

	SHARED_GENERATION
		export
			{NONE} all
		end
	
create
	make

feature -- Initialization

	make is
			-- Initialize metadata generator.
		do
		end

feature -- Generation

	generate_il_class_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate class description of `class_type'.
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

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
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

	generate_metadata (classes: ARRAY [CLASS_C]) is
			-- Store Eiffel names to allow roundtrip
			-- when consuming metadata again.
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

				il_generator.generate_interface_feature_identification (feat.external_name,
					feat.feature_id, feat.is_attribute)

				generate_arguments (feat)
				generate_return_type (feat)

				il_generator.create_feature_description

				generate_feature_custom_attribute (current_class_type, feat)
			end
		end

	generate_feature (feat: FEATURE_I; is_static: BOOLEAN) is
			-- Generate `feat' description.
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
					name := feat.external_name
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

	generate_inherited_feature (feat: FEATURE_I; feat_id: INTEGER) is
			-- Generate `feat' description.
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
				
				name := feat.external_name

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

feature {NONE} -- Implementation

	generate_class_custom_attribute (class_type: CLASS_TYPE) is
			-- Generate class custom attribute of `class_type' if any.
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
				imp.add_ca (class_type.static_type_id, il_generator.static_id_of (cb.info.type),
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

end -- class MSIL_META_DATA_GENERATOR
