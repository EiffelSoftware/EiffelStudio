indexing
	description: "Code generator for array expressions"
	date: "$$"
	revision: "$$"		
	
class
	CODE_ARRAY_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_array_create_expression (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION) is
			-- | Create instance of `EG_ARRAY_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_create_expression'
			-- | Set `last_expression'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION
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
			an_array_indexer_expression: CODE_ARRAY_INDEXER_EXPRESSION
		do
			create an_array_indexer_expression.make
			initialize_array_indexer_expression (a_source, an_array_indexer_expression)
			set_last_expression (an_array_indexer_expression)
		ensure
			non_void_last_expression: last_expression /= Void
			array_indexer_expression_ready: last_expression.ready
		end		

feature {NONE} -- Implementation

	initialize_array_create_expression (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION; an_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION) is
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
				if not Resolver.is_generated_type (l_type_name) then
					Resolver.add_external_type (l_type_name)
				end
				an_array_create_expression.set_array_type (l_type_name)
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_creation_type, ["array creation expression"])
			end
			size := a_source.size_expression
			if size /= Void then
				code_dom_generator.generate_expression_from_dom (size)
				an_array_create_expression.set_size (last_expression)
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_array_size, [])
			end
			generate_initializers (a_source, an_array_create_expression)
		ensure
			array_create_expression_ready: an_array_create_expression.ready
		end

	generate_initializers (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION; an_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION) is
			-- Generate array initializers.
		require
			non_void_source: a_source /= Void
			non_void_array_create_expression: an_array_create_expression /= Void
		local
			i: INTEGER
			initializers: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			l_dictionary: CODE_DICTIONARY
			
			a_feature: CODE_SNIPPET_FEATURE
			l_eiffel_type_name: STRING
			l_feature_creation_array_name: STRING
			l_feature_impl: STRING
			already_created: BOOLEAN
		do
			initializers := a_source.initializers
			if initializers /= Void then
				if initializers.count > 0 then
					l_eiffel_type_name := Resolver.eiffel_type_name (a_source.create_type.base_type)
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
						l_feature_impl.append ("%T")
						if not Resolver.is_feature (l_feature_creation_array_name) then
							Resolver.add_feature ("NATIVE_ARRAY [l_eiffel_type_name]", l_feature_creation_array_name)
							l_feature_impl.append (l_feature_creation_array_name)
							l_feature_impl.append (" (a_native_array: NATIVE_ARRAY [SYSTEM_OBJECT]): NATIVE_ARRAY [")
							l_feature_impl.append (l_eiffel_type_name)
							l_feature_impl.append ("] is%N")

								-- Add feature comment
							l_feature_impl.append ("%T%T%T-- Convert NATIVE_ARRAY [SYSTEM_OBJECT] to NATIVE_ARRAY [")
							l_feature_impl.append (l_eiffel_type_name)
							l_feature_impl.append ("]%N")

							l_feature_impl.append ("%T%Tlocal%N")
							l_feature_impl.append ("%T%T%Tl_counter, l_nb: INTEGER%N")
							l_feature_impl.append ("%T%T%Tl_temp: ")
							l_feature_impl.append (l_eiffel_type_name)
							l_feature_impl.append ("%N%T%Tdo%N")
							l_feature_impl.append ("%T%T%Tcreate Result.make (a_native_array.count)%N")
							l_feature_impl.append ("%T%T%Tfrom%N")
							l_feature_impl.append ("%T%T%T%Tl_nb := a_native_array.count%N")
							l_feature_impl.append ("%T%T%Tuntil%N")
							l_feature_impl.append ("%T%T%T%Tl_counter >= l_nb%N")
							l_feature_impl.append ("%T%T%Tloop%N")
							l_feature_impl.append ("%T%T%T%Tl_temp ?= a_native_array.item (l_counter)%N")
							l_feature_impl.append ("%T%T%T%TResult.put (l_counter, l_temp)%N")
							l_feature_impl.append ("%T%T%T%Tl_counter := l_counter + 1%N")
							l_feature_impl.append ("%T%T%Tend%N")
							l_feature_impl.append ("%T%Tend%N")
							a_feature.set_value (l_feature_impl)
							current_type.add_feature (a_feature)
						end
					end
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_initializers, ["array create expression"])
			end
		end		

	initialize_array_indexer_expression (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION; an_array_indexer_expression: CODE_ARRAY_INDEXER_EXPRESSION) is
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
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_target_object, ["array indexer expression"])
			end
			generate_indices (a_source, an_array_indexer_expression)
		ensure
			array_indexer_expression_ready: an_array_indexer_expression.ready
		end

	generate_indices (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION; an_array_indexer_expression: CODE_ARRAY_INDEXER_EXPRESSION) is
			-- Generate array indices.
		require
			non_void_source: a_source /= Void
			non_void_array_indexer_expression: an_array_indexer_expression /= Void
		local
			i: INTEGER
			indices: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
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
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_indices, ["array indexer expression"])
			end
		end		

end -- class CODE_ARRAY_EXPRESSION_FACTORY

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