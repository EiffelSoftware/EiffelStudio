indexing
	description: "[
			Factory to create a custom attribute to a specific
			.NET feature or class given provided information.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_ATTRIBUTE_FACTORY

inherit
	SHARED_IL_CODE_GENERATOR
		export
			{NONE} il_generator, Il_label_factory
			{ANY} all
		end
		
	SHARED_INST_CONTEXT
		export
			{NONE} inst_context
			{ANY} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} context
			{ANY} all
		end

feature -- Settings

	set_feature_custom_attributes (a_feature: FEATURE_I; a_feature_token: INTEGER) is
			-- Extract all defined custom attribute of `a_feature' if any
			-- and applied them to `a_feature_token'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_token_valid: a_feature_token /= 0
		local
			feature_as: FEATURE_AS
			attributes: EIFFEL_LIST [CREATION_EXPR_AS]
		do
			feature_as := a_feature.body
			if feature_as /= Void then
				attributes := feature_as.custom_attribute
				if attributes /= Void then
					generate_custom_attribute (a_feature_token, il_generator.current_class_type,
						attributes)
				end
			end
		end

feature {IL_CODE_GENERATOR} -- Generation

	generate_custom_attribute (a_owner_token: INTEGER; class_type: CLASS_TYPE;
			ca: EIFFEL_LIST [CREATION_EXPR_AS])
		is
			-- Generate custom attributes represented by `ca' in `class_type'
			-- using `a_owner_token' as target.
		require
			a_owner_token_valid: a_owner_token /= 0
			class_type_not_void: class_type /= Void
			has_custom_attributes: ca /= Void
		local
			cb: CREATION_EXPR_B
			l_creation_external: CREATION_EXTERNAL_B
			l_extension: IL_EXTENSION_I
			count: INTEGER
			param: BYTE_LIST [EXPR_B]
			param_b: PARAMETER_B
			exp: CREATION_EXPR_AS
			l_ca: MD_CUSTOM_ATTRIBUTE
			l_ctor_token: INTEGER
			l_class_c: CLASS_C
		do
			from
					-- Initialize data structures needed to perform a `type_check'
					-- and to create a `byte_node' for every creation expression
					-- that represent the custom attribute
				l_class_c := class_type.associated_class
				Inst_context.set_cluster (l_class_c.cluster)
				context.clear2
				if not l_class_c.is_external then
					context.set_current_class (l_class_c)
				end
				ca.start
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

					-- FIXME: Manu 06/02/2002 we should also take currently
					-- defined custom attributes.
				l_creation_external ?= cb.call
				if l_creation_external /= Void then
					l_extension ?= l_creation_external.extension
					l_ctor_token := l_extension.token
				end

					-- Clean up of AST_CONTEXT for next type checking.
				context.clear2

				param := cb.call.parameters
				if param /= Void then
					count := param.count
				end

					-- Start initialization of custom attribute.
				create l_ca.make

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
						add_custom_attribute_argument (l_ca, param_b.expression)
						param.forth
					end
				end

					-- Mark end of custom attribute
				l_ca.put_integer_16 (0)
				
					-- Assign `l_ca' to `a_owner_token'.
				il_generator.define_custom_attribute (a_owner_token, l_ctor_token, l_ca)
			end
		end

feature {NONE} -- Generation

	add_custom_attribute_argument (a_ca_blob: MD_CUSTOM_ATTRIBUTE; e: EXPR_B) is
			-- Add `e' to list of arguments needed by custom attribute
			-- creation routine.
		require
			blob_not_void: a_ca_blob /= Void
			e_not_void: e /= Void
		local
			real: REAL_CONST_B
			int: INTEGER_CONSTANT
			char: CHAR_CONST_B
			bool: BOOL_CONST_B
			string: STRING_B
			nested_b: NESTED_B
			ext: EXTERNAL_B
			il_ext: IL_EXTENSION_I
			l_target: ACCESS_EXPR_B
			l_feat: FEATURE_B
		do
				-- Depending on type of `e' we have to call the feature which
				-- adds an argument of type `e' to the currently generated
				-- custom attribute
			bool ?= e
			if bool /= Void then
				a_ca_blob.put_boolean (bool.value)
			else
				int ?= e
				if int /= Void then
					inspect int.size
					when 8 then a_ca_blob.put_integer_8 (int.value.to_integer_8)
					when 16 then a_ca_blob.put_integer_16 (int.value.to_integer_16)
					when 32 then a_ca_blob.put_integer_32 (int.value)
					when 64 then a_ca_blob.put_integer_64 (int.to_integer_64)
					end
				else
					string ?= e
					if string /= Void then
						a_ca_blob.put_string (string.value)
					else
						real ?= e
						if real /= Void then
							a_ca_blob.put_double (real.value.to_real)
						else
							char ?= e
							if char /= Void then
								a_ca_blob.put_character (char.value)
							else
								nested_b ?= e
								if nested_b /= Void then
									ext ?= nested_b.message
									if ext /= Void then
										il_ext ?= ext.extension
										if
											il_ext /= Void and then
											il_ext.type = feature {SHARED_IL_CONSTANTS}.enum_field_type
										then
											a_ca_blob.put_integer_32 (ext.external_name.to_integer)
										else
											check
												not_supported_type: False
											end
										end
									else
										l_target ?= nested_b.target
										if l_target /= Void then
											l_feat ?= nested_b.message
											if
												l_feat /= Void and
												l_feat.feature_name_id = feature {PREDEFINED_NAMES}.to_cil_name_id
											then
												string ?= l_target.expr
												if string /= Void then
													a_ca_blob.put_string (string.value)
												end
											end
										else
											check
												not_supported_type: False
											end
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

end -- class CUSTOM_ATTRIBUTE_FACTORY
