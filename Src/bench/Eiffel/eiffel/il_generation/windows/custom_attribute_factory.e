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
	ANY

	SHARED_IL_CODE_GENERATOR
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

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
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
			attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			l_attributes: BYTE_LIST [BYTE_NODE]
			l_class_c: CLASS_C
		do
			if not a_feature.is_attribute and not a_feature.is_type_feature then
				l_attributes := a_feature.custom_attributes
			else
				feature_as := a_feature.body
				if feature_as /= Void then
					attributes := feature_as.custom_attributes
					if attributes /= Void then
							-- Initialize data structures needed to perform a `type_check'
							-- and to create a `byte_node' for every creation expression
							-- that represent the custom attribute
						l_class_c := cil_generator.current_class_type.associated_class
						Inst_context.set_cluster (l_class_c.cluster)
						context.initialize (l_class_c, l_class_c.actual_type, l_class_c.feature_table)
						feature_checker.init (context)
						feature_checker.custom_attributes_type_check_and_code (a_feature, attributes)
						l_attributes ?= feature_checker.last_byte_node
					end
				end
			end
			if l_attributes /= Void then
				generate_custom_attributes (a_feature_token, l_attributes)
			end
		end

feature {CIL_CODE_GENERATOR} -- Generation

	generate_custom_attributes (a_owner_token: INTEGER; ca: BYTE_LIST [BYTE_NODE]) is
			-- Generate custom attributes represented by `ca'
			-- using `a_owner_token' as target.
		require
			a_owner_token_valid: a_owner_token /= 0
			has_custom_attributes: ca /= Void
		local
			ca_b: CUSTOM_ATTRIBUTE_B
			cb: CREATION_EXPR_B
			l_creation_external: EXTERNAL_B
			l_extension: IL_EXTENSION_I
			count: INTEGER
			param: BYTE_LIST [EXPR_B]
			param_b: PARAMETER_B
			l_tuple_const, l_sub_tuple_const: TUPLE_CONST_B
			l_ca: MD_CUSTOM_ATTRIBUTE
			l_ctor_token: INTEGER
			l_creation_class: CLASS_C
			l_type: CL_TYPE_I
		do
			from
				ca.start
			until
				ca.after
			loop
				ca_b ?= ca.item
				cb := ca_b.creation_expr
				l_type ?= cb.type
				l_creation_class := l_type.base_class
				l_tuple_const := ca_b.tuple

				l_creation_external ?= cb.call
				if l_creation_external /= Void then
					l_extension ?= l_creation_external.extension
					l_ctor_token := l_extension.token
				end

				param := cb.call.parameters
				if param /= Void then
					count := param.count
				else
					count := 0
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
						add_fixed_argument (l_ca, param_b.expression)
						param.forth
					end
				end

					-- Generate name argument
				if l_tuple_const /= Void then
					l_ca.put_integer_16 (l_tuple_const.expressions.count.to_integer_16)
					
					from
						l_tuple_const.expressions.start
					until
						l_tuple_const.expressions.after					
					loop
						l_sub_tuple_const ?= l_tuple_const.expressions.item
						check
							tuple_present: l_sub_tuple_const /= Void
						end
						add_named_argument (l_ca, l_creation_class, l_sub_tuple_const)
						l_tuple_const.expressions.forth
					end
				else
					l_ca.put_integer_16 (0)
				end

					-- Assign `l_ca' to `a_owner_token'.
				cil_generator.define_custom_attribute (a_owner_token, l_ctor_token, l_ca)

				ca.forth
			end
		end

feature {NONE} -- Generation

	add_named_argument (a_ca_blob: MD_CUSTOM_ATTRIBUTE; a_class: CLASS_C; a_tuple: TUPLE_CONST_B) is
			-- Lookup named argument in `a_tuple' and insert it in `a_ca_blob'.
		require
			blob_not_void: a_ca_blob /= Void
			tuple_not_void: a_tuple /= Void
			tuple_valid: a_tuple.expressions.count = 2
		local
			l_expr_b: EXPR_B
			l_feat: FEATURE_I
			l_extension: IL_EXTENSION_I
			l_string_b: STRING_B
			l_feat_name: STRING
			l_cl_type: CL_TYPE_I
			l_ext_class: EXTERNAL_CLASS_C
			l_type_name: STRING
		do
			l_string_b ?= a_tuple.expressions.first
			check
				has_string: l_string_b /= Void
			end
			l_feat_name := l_string_b.value.as_lower
			
			l_feat := a_class.feature_table.item (l_feat_name)
			check
				has_feature: l_feat /= Void
			end

				-- First mark if it is an attribute or a property.
			if l_feat.is_attribute then
				a_ca_blob.put_integer_8 (0x53)
			else
				a_ca_blob.put_integer_8 (0x54)
			end

				-- Then mark type of attribute or property.
			l_expr_b ?= a_tuple.expressions.i_th (2)
			check
				has_expression: l_expr_b /= Void
			end
			l_cl_type ?= l_expr_b.type
			if l_cl_type /= Void and then l_cl_type.is_enum then
				a_ca_blob.put_integer_8 (0x55)
				create l_type_name.make_from_string (l_cl_type.il_type_name (Void))
				l_type_name.append_character (',')
				l_ext_class ?= l_cl_type.base_class
				check
					l_ext_class_not_void: l_ext_class /= Void
				end
				l_type_name.append (l_ext_class.assembly.full_name)
				a_ca_blob.put_string (l_type_name)
			else
				a_ca_blob.put_integer_8 (l_expr_b.type.element_type)
			end
	
				-- Put name of attribute or property.
			if l_feat.written_class.is_external then
				l_extension ?= l_feat.extension
				l_feat_name := l_extension.alias_name
				if not l_feat.is_attribute then
					l_feat_name := l_feat_name.twin
					l_feat_name.remove_head (4)
				end
			end
			a_ca_blob.put_string (l_feat_name)

				-- Finally generate value.
			add_fixed_argument (a_ca_blob, l_expr_b)
		end

	add_fixed_argument (a_ca_blob: MD_CUSTOM_ATTRIBUTE; e: EXPR_B) is
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
			il_enum_ext: IL_ENUM_EXTENSION_I
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
					inspect int.il_element_type
					when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then a_ca_blob.put_integer_8 (int.integer_8_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then a_ca_blob.put_integer_16 (int.integer_16_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then a_ca_blob.put_integer_32 (int.integer_32_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then a_ca_blob.put_integer_64 (int.integer_64_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then a_ca_blob.put_natural_8 (int.natural_8_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then a_ca_blob.put_natural_16 (int.natural_16_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then a_ca_blob.put_natural_32 (int.natural_32_value)
					when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then a_ca_blob.put_natural_64 (int.natural_64_value)
					end
				else
					string ?= e
					if string /= Void and then string.is_dotnet_string then
						a_ca_blob.put_string (string.value)
					else
						real ?= e
						if real /= Void then
							a_ca_blob.put_real_64 (real.value.to_double)
						else
							char ?= e
							if char /= Void then
								a_ca_blob.put_character (char.value)
							else
								nested_b ?= e
								ext ?= e
								if nested_b /= Void or ext /= Void then
									if ext = Void then
										ext ?= nested_b.message
									end
									if ext /= Void then
										il_ext ?= ext.extension
										if
											il_ext /= Void and then
											il_ext.type = {SHARED_IL_CONSTANTS}.enum_field_type
										then
											il_enum_ext ?= il_ext
											check
												il_enum_ext_not_void: il_enum_ext /= Void
											end
											a_ca_blob.put_integer_32 (il_enum_ext.value)
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
												l_feat.feature_name_id = {PREDEFINED_NAMES}.to_cil_name_id
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
