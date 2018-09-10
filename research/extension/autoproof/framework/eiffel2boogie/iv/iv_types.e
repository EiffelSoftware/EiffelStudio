note
	description: "[
		Access to basic IV types and conversion facilities.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_TYPES

inherit
	E2B_SHARED_CONTEXT

	IV_SHARED_FACTORY

feature -- Access: default types

	bool: IV_TYPE
			-- Boolean type.
		once
			create {IV_BASIC_TYPE} Result.make_boolean
		end

	int: IV_TYPE
			-- Integer type.
		once
			create {IV_BASIC_TYPE} Result.make_integer
		end

	real: IV_TYPE
			-- Integer type.
		once
			create {IV_BASIC_TYPE} Result.make_real
		end

	nullary_type (a_name: STRING): IV_USER_TYPE
			-- User-defined type from a nullary type constructor.
		do
			create {IV_USER_TYPE} Result.make (a_name, <<>>)
		end

	ref: IV_USER_TYPE
			-- Reference type.
		once
			Result := nullary_type ("ref")
			Result.set_default_value (factory.void_)
			Result.set_rank_function ("ref_rank_leq")
		end

	field (a_content_type: IV_TYPE): IV_TYPE
			-- Field type that has content of type `a_content_type'.
		do
			create {IV_USER_TYPE} Result.make ("Field", << a_content_type >>)
		end

	field_content_type (a_field_type: IV_TYPE): IV_TYPE
			-- Content type of `a_field_type'.
		require
			is_field_type: attached {IV_USER_TYPE} a_field_type as user_type and then user_type.constructor ~ "Field"
		do
			check attached {IV_USER_TYPE} a_field_type as user_type then
				Result := user_type.parameters [1]
			end
		end

	heap: IV_TYPE
			-- Heap type.
		local
			l_param: IV_VAR_TYPE
		once
			create l_param.make_fresh
			create {IV_MAP_SYNONYM_TYPE} Result.make (<< l_param.name >>, << ref, field (l_param) >>, l_param, "HeapType", <<>>)
		end

	frame: IV_TYPE
			-- Frame type.
		local
			l_param: IV_VAR_TYPE
		once
			create l_param.make_fresh
			create {IV_MAP_SYNONYM_TYPE} Result.make (<< l_param.name >>, << ref, field (l_param) >>, bool, "Frame", <<>>)
		end

	type: IV_TYPE
			-- Type type.
		once
			Result := nullary_type ("Type")
		end

	set (a_content_type: IV_TYPE): IV_MAP_SYNONYM_TYPE
			-- Set type that has content of type `a_content_type'.
		do
			create Result.make (<<>>, << a_content_type >>, bool, "Set", << a_content_type >>)
			Result.set_default_value (factory.function_call ("Set#Empty", <<>>, Result))
			Result.set_rank_function ("Set#Subset")
		end

feature -- Type translation

	for_class_type (a_type: CL_TYPE_A): IV_TYPE
			-- Boogie type for `a_type'.
		require
			a_type_attached: attached a_type
		local
			l_class: CLASS_C
			l_user_type: IV_USER_TYPE
			l_constructor: STRING
			l_params, l_domain_types: ARRAY [IV_TYPE]
			l_default_function, l_type_inv_function, l_leq_function: STRING
			l_access_feature: FEATURE_I
		do
			l_class := a_type.base_class

			if a_type.is_integer or a_type.is_natural or a_type.is_character or a_type.is_character_32 then
				Result := int
			elseif a_type.is_boolean then
				Result := bool
			elseif a_type.is_real_32 or else a_type.is_real_64 then
				Result := real
			elseif helper.is_class_logical (l_class) then
					-- The class is mapped to a Boogie type
				l_constructor := helper.type_for_logical (l_class)
				if a_type.generics = Void then
					create l_params.make_empty
				else
					create l_params.make (1, a_type.generics.count)
					across
						a_type.generics as g
					loop
						check attached {CL_TYPE_A} g.item as t then
							l_params [g.target_index] := for_class_type (t)
						end
					end
				end

					-- Check if the class corresponds to a map type
				l_access_feature := helper.map_access_feature (l_class)
				if l_access_feature = Void then
						-- No: just use the user-defined type
					create l_user_type.make (l_constructor, l_params)
				else
						-- Yes: extract domain and range types from the access feature and make the user-defined type a synonym
					create l_domain_types.make (1, l_access_feature.argument_count)
					across
						l_access_feature.arguments as args
					loop
						l_domain_types [args.target_index] := for_class_type (helper.class_type_in_context (args.item, l_access_feature.written_class, l_access_feature, a_type))
					end
					create {IV_MAP_SYNONYM_TYPE} l_user_type.make (<<>>,
						l_domain_types,
						for_class_type (helper.class_type_in_context (l_access_feature.type, l_access_feature.written_class, l_access_feature, a_type)),
						l_constructor,
						l_params)
				end

					-- Check if the type has a default value
				l_default_function := helper.function_for_logical (l_class.feature_named_32 ("default_create"))
				if attached l_default_function then
					l_user_type.set_default_value (factory.function_call (l_default_function, << >>, l_user_type))
				end

					-- Check if the type has an invariant
				l_type_inv_function := helper.string_class_note_value (l_class, "where")
				if not l_type_inv_function.is_empty then
					l_user_type.set_type_inv_function (l_type_inv_function)
				end

					-- Check if the type has a rank function
				l_leq_function := helper.function_for_logical (l_class.feature_named_32 ("infix %"<=%""))
				if attached l_leq_function then
					l_user_type.set_rank_function (l_leq_function)
				end

				Result := l_user_type
			else
				Result := ref
			end
		end

	type_property (a_type: CL_TYPE_A; a_heap, a_expr: IV_EXPRESSION; a_is_exact, a_is_attached: BOOLEAN): IV_EXPRESSION
			-- For an expression `a_expr' originally of Eiffel type `a_type', an expression that states its precise Eiffel type in `a_heap';
			-- if `a_is_exact', then the dynamic type of the expression is known (for example, because it's Current).
		local
			l_boogie_type: IV_TYPE
			l_content_type: CL_TYPE_A
			l_fname: STRING
			l_arg, l_inv: IV_EXPRESSION
			l_type_properties: ARRAYED_LIST [STRING_32]
		do
			Result := factory.true_
			l_boogie_type := for_class_type (a_type)
			if l_boogie_type ~ ref then
				l_content_type := a_type
				if a_is_exact then
					if a_is_attached then
						l_fname := "attached_exact"
					else
						l_fname := "detachable_exact"
					end
				elseif not helper.is_class_any (l_content_type.base_class) then
					if a_is_attached then
						l_fname := "attached"
					else
						l_fname := "detachable"
					end
				else -- type is ANY
					if a_is_attached then
						Result := factory.and_ (factory.not_equal (a_expr, factory.void_), factory.heap_access (a_heap, a_expr, "allocated", bool))
					else
						Result := factory.heap_access (a_heap, a_expr, "allocated", bool)
					end
				end
				if l_fname /= Void then
					Result := factory.function_call (l_fname, << a_heap, a_expr, factory.type_value (l_content_type) >>, bool)
				end
				if helper.is_class_array (l_content_type.base_class) then
					Result := factory.and_clean (Result, factory.function_call ("ARRAY.inv", << a_heap, a_expr >>, bool))
				end
			elseif l_boogie_type ~ int then
					-- If we are not checking for overflows, no need to differentiate between kinds of ints
				Result := numeric_property (a_type, a_expr)
			elseif helper.is_class_logical (a_type.base_class) then
					-- Check if it is a logical type with some type properties
				l_type_properties := helper.class_note_values (a_type.base_class, "type_properties")
				if not l_type_properties.is_empty then
					if l_type_properties.count /= a_type.generics.count then
						helper.add_semantic_error (a_type.base_class, messages.logical_invalid_type_properties, -1)
					else
						across
							l_type_properties as prop
						loop
							check attached {CL_TYPE_A} a_type.generics [prop.target_index] as t then
								if for_class_type (t) ~ ref  then
									Result := factory.and_clean (Result, factory.function_call (prop.item, << a_heap, a_expr, factory.type_value (t) >>, bool))
								end
							end
						end
					end
				end
			end
				-- Check if the Boogie type has an invariant
			l_inv := l_boogie_type.type_inv (a_expr)
			if attached l_inv then
				Result := factory.and_clean (Result, l_inv)
			end
		end

	numeric_property (a_type: TYPE_A; a_expr: IV_EXPRESSION): IV_EXPRESSION
			-- Property associated with argument `a_name' of type `a_type'.
		require
			numeric_property: a_type.is_numeric or a_type.is_character
		local
			l_f_name: STRING
		do
			if attached {INTEGER_A} a_type as l_int_type then
				l_f_name := "is_integer_" + l_int_type.size.out
			elseif attached {NATURAL_A} a_type as l_nat_type then
				l_f_name := "is_natural_" + l_nat_type.size.out
			elseif attached {CHARACTER_A} a_type as l_char_type then
				if l_char_type.is_character_32 then
					l_f_name := "is_natural_32"
				else
					l_f_name := "is_natural_8"
				end
			else
				check False end
			end
			Result := factory.function_call (l_f_name, << a_expr >>, bool)
		end

end
