indexing
	description: "Code generator for array expressions"
	date: "$$"
	revision: "$$"		
	
class
	ECDP_ARRAY_EXPRESSION_FACTORY

inherit
	ECDP_EXPRESSION_FACTORY

create
	make			

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_array_create_expression (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION) is
			-- | Create instance of `EG_ARRAY_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_create_expression'
			-- | Set `last_expression'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_array_create_expression: ECDP_ARRAY_CREATE_EXPRESSION
		do
			create an_array_create_expression.make
			initialize_array_create_expression (a_source, an_array_create_expression)
			set_last_expression (an_array_create_expression)
		ensure
			non_void_last_expression: last_expression /= Void
			array_create_expression_ready: last_expression.ready
		end		

	generate_array_indexer_expression (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION) is
			-- | Create instance of `EG_ARRAY_INDEXER_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_indexer_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_array_indexer_expression: ECDP_ARRAY_INDEXER_EXPRESSION
		do
			create an_array_indexer_expression.make
			initialize_array_indexer_expression (a_source, an_array_indexer_expression)
			set_last_expression (an_array_indexer_expression)
		ensure
			non_void_last_expression: last_expression /= Void
			array_indexer_expression_ready: last_expression.ready
		end		

feature {NONE} -- Implementation

	initialize_array_create_expression (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION; an_array_create_expression: ECDP_ARRAY_CREATE_EXPRESSION) is
			-- | Use `eg_generated_types' if already built to set `array_type', else build `EG_TYPE'.
			-- | Set `size'. 
			-- | Call `generate_initializers' if any.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_array_create_expression: an_array_create_expression /= Void
		local
			l_type_name: STRING
			l_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			size: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_create_type := a_source.create_type
			if l_create_type /= Void then
				code_dom_generator.generate_type_reference_from_dom (l_create_type)
				create l_type_name.make_from_cil (l_create_type.base_type)
				if not eiffel_types.is_generated_type (l_type_name) then
					eiffel_types.add_external_type (l_type_name)
				end
				an_array_create_expression.set_array_type (l_type_name)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_creation_type, ["array creation expression"])
			end
			size := a_source.size_expression
			if size /= Void then
				code_dom_generator.generate_expression_from_dom (size)
				an_array_create_expression.set_size (last_expression)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_array_size, [])
			end
			generate_initializers (a_source, an_array_create_expression)
		ensure
			array_create_expression_ready: an_array_create_expression.ready
		end

	generate_initializers (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION; an_array_create_expression: ECDP_ARRAY_CREATE_EXPRESSION) is
			-- Generate array initializers.
		require
			non_void_source: a_source /= Void
			non_void_array_create_expression: an_array_create_expression /= Void
		local
			i: INTEGER
			initializers: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			an_initializer: SYSTEM_DLL_CODE_EXPRESSION
			l_dictionary: ECDP_DICTIONARY
			
			a_feature: ECDP_SNIPPET_FEATURE
			l_eiffel_type_name: STRING
			l_feature_creation_array_name: STRING
			l_feature_impl: STRING
			already_created: BOOLEAN
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
			l_count: INTEGER
			l_name: SYSTEM_STRING
		do
			initializers := a_source.initializers
			if initializers /= Void then
				if initializers.count > 0 then
					l_eiffel_type_name := Eiffel_types.eiffel_type_name (a_source.create_type.base_type)
					from
					until
						i = initializers.count					
					loop
						code_dom_generator.generate_expression_from_dom (initializers.item (i))
						an_array_create_expression.add_initializer (last_expression)
						i := i + 1
					end
					l_feature_creation_array_name := "new_array_" + l_eiffel_type_name
					l_feature_creation_array_name.to_lower
					l_members := Members_mapping.members
					if l_members /= Void then
						from
							i := 0
							l_count := l_members.count
							l_name := l_feature_creation_array_name.to_cil
						until
							i = l_count or already_created
						loop
							already_created := l_members.item (i).name.equals (l_name)
							i := i + 1
						end
					end
					an_array_create_expression.set_array_creation_feature (l_feature_creation_array_name)
					if not l_eiffel_type_name.is_equal ("SYSTEM_OBJECT") and then not already_created then
						create l_dictionary
						create a_feature.make
						a_feature.set_frozen (True)
						a_feature.set_constant (False)
						a_feature.set_once_routine (False)
						a_feature.set_overloaded (False)
						a_feature.set_type_feature ("Implementation")
						a_feature.set_name (l_feature_creation_array_name)

						create l_feature_impl.make (250)
						l_feature_impl.append (l_dictionary.Tab)
						if not Eiffel_types.features.has (l_feature_creation_array_name) then
							Eiffel_types.add_feature ("NATIVE_ARRAY [l_eiffel_type_name]", l_feature_creation_array_name)
							l_feature_impl.append (l_feature_creation_array_name)
							l_feature_impl.append (" (a_native_array: NATIVE_ARRAY [SYSTEM_OBJECT]): NATIVE_ARRAY [")
							l_feature_impl.append (l_eiffel_type_name)
							l_feature_impl.append ("] is" + l_dictionary.New_line)

								-- Add feature comment
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + "-- ")
							l_feature_impl.append ("Convert NATIVE_ARRAY [SYSTEM_OBJECT] to NATIVE_ARRAY [")
							l_feature_impl.append (l_eiffel_type_name + "]")
							l_feature_impl.append (l_dictionary.New_line)

							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + "local" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("l_counter, l_nb: INTEGER" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + "l_temp: ")
							l_feature_impl.append (l_eiffel_type_name + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + "do" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("create Result.make (a_native_array.count)" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("from" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("l_nb := a_native_array.count" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("until" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("l_counter >= l_nb" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("loop" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("l_temp ?= a_native_array.item (l_counter)" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("Result.put (l_counter, l_temp)" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("l_counter := l_counter + 1" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + l_dictionary.Tab)
							l_feature_impl.append ("end" + l_dictionary.New_line)
							l_feature_impl.append (l_dictionary.Tab + l_dictionary.Tab + "end" + l_dictionary.New_line)
							a_feature.set_value (l_feature_impl)
							current_type.add_feature (a_feature)
						end
					end
				end
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_initializers, ["array create expression"])
			end
		end		

	initialize_array_indexer_expression (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION; an_array_indexer_expression: ECDP_ARRAY_INDEXER_EXPRESSION) is
			-- | Call `generate_expression_from_dom' to generate `expression' and `indices'.
			-- | Equivalent to call feature `item' on the array with appropriate indice.
			-- | Support only unidimensional array for the moment.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_array_indexer_expression: an_array_indexer_expression /= Void
		local
			a_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			a_target_object := a_source.target_object
			if a_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (a_target_object)
				an_array_indexer_expression.set_target_object (last_expression)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_target_object, ["array indexer expression"])
			end
			generate_indices (a_source, an_array_indexer_expression)
		ensure
			array_indexer_expression_ready: an_array_indexer_expression.ready
		end

	generate_indices (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION; an_array_indexer_expression: ECDP_ARRAY_INDEXER_EXPRESSION) is
			-- Generate array indices.
		require
			non_void_source: a_source /= Void
			non_void_array_indexer_expression: an_array_indexer_expression /= Void
		local
			i: INTEGER
			indices: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			an_indice: SYSTEM_DLL_CODE_EXPRESSION
		do
			indices := a_source.indices
			if indices /= Void then
				from
				until
					i = indices.count					
				loop
					code_dom_generator.generate_expression_from_dom (indices.item (i))
					an_array_indexer_expression.add_indice (last_expression)
					i := i + 1
				end
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_indices, ["array indexer expression"])
			end
		end		

end -- class ECDP_ARRAY_EXPRESSION_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------