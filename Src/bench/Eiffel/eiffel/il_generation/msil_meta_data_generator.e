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
		end

	SHARED_INST_CONTEXT

	SHARED_AST_CONTEXT

	SHARED_IL_CONSTANTS
	
create
	make

feature -- Initialization

	make is
		do
		end

feature -- Generation

	generate_il_class_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate class description of `class_type'.
		do
			current_class_type := class_type
			is_class_external := class_c.is_external

				-- Generate class nature description
			il_generator.generate_class_header (class_c.is_fully_deferred,
				class_c.is_deferred, class_c.is_expanded, is_class_external, class_type.static_type_id)

			if not is_class_external then
					-- Generate ancestors for non-external classes
					--| We do not need to do it for external classes
					--| because the IL run-time already know about them.
				generate_ancestors (class_c, class_type)
			end
		end

feature {NONE} -- Feature generation

	generate_feature (feat: FEATURE_I; in_current_class: BOOLEAN; type_id: INTEGER) is
			-- Generate `feat' description.
		local
			is_deferred: BOOLEAN
			is_redefined: BOOLEAN
			is_frozen: BOOLEAN
			need_generation: BOOLEAN
			ext: EXTERNAL_I
			def: DEF_PROC_I
			attr: ATTRIBUTE_I
			il_ext: IL_EXTENSION_I
			inv: INVARIANT_FEAT_I
		do
			need_generation := True

			attr ?= feat
			if attr /= Void then
				need_generation := not attr.feature_name.is_equal (void_name)
			end

			if need_generation then
				if feat.has_arguments then
					il_generator.start_feature_description (feat.arguments.count)
				else
					il_generator.start_feature_description (0)
				end
				is_deferred := feat.is_deferred
				inv ?= feat
				is_redefined := not feat.is_origin and then inv = Void
				is_frozen := feat.is_frozen

				if not is_class_external then
					if in_current_class then
						il_generator.generate_feature_nature (is_redefined, is_deferred, is_frozen, feat.is_attribute)
						il_generator.generate_feature_identification (feat.external_name,
							feat.feature_id, feat.rout_id_set, in_current_class, type_id)

						generate_arguments (feat)
						generate_return_type (feat)

						if inv /= Void then
							il_generator.mark_invariant (feat.feature_id)
						end
						il_generator.create_feature_description
						il_generator.check_renaming_and_redefinition

						generate_feature_custom_attribute (current_class_type, feat)
					else
						il_generator.generate_feature_identification (feat.external_name,
								feat.feature_id, feat.rout_id_set, in_current_class, type_id)
						il_generator.check_renaming
					end
				else
					if in_current_class then
						ext ?= feat
						if ext /= Void then
							il_ext ?= ext.extension
							check
								has_alias: il_ext /= Void
							end
							il_generator.generate_external_identification (feat.feature_name,
									ext.alias_name, il_ext.type, feat.feature_id,
									  feat.rout_id_set.first, in_current_class, type_id,
									  il_ext.argument_types, il_ext.return_type)
							generate_arguments (feat)
							generate_return_type (feat)
						else
							def ?= feat
							if def /= Void then								
								il_ext ?= def.extension
								il_generator.generate_external_identification (feat.feature_name,
										il_ext.alias_name, il_ext.type, feat.feature_id,
										  feat.rout_id_set.first, in_current_class, type_id,
										  il_ext.argument_types, il_ext.return_type)
								generate_arguments (feat)
								generate_return_type (feat)
							else
								if attr /= Void then
									il_ext ?= attr.extension
									il_generator.generate_external_identification (feat.feature_name,
											il_ext.alias_name, il_ext.type, feat.feature_id,
											  feat.rout_id_set.first, in_current_class, type_id,
											  il_ext.argument_types, il_ext.return_type)
									generate_return_type (feat)
								else	
									-- Special case of manually added function in class of basic types.
									-- Does not need special generation
								end
							end
						end
					else
						il_generator.generate_feature_identification (feat.external_name,
							 feat.feature_id, feat.rout_id_set, in_current_class, type_id)
					end
				end
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
			int: INT_CONST_B
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
										if il_ext /= Void and then il_ext.type = enum_field_type then
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
