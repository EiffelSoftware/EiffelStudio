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
			-- | Create instance of `CODE_ARRAY_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_create_expression'
			-- | Set `last_expression'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type: CODE_TYPE_REFERENCE
			l_size: INTEGER
			l_size_expression: CODE_EXPRESSION
			l_initializers: LIST [CODE_EXPRESSION]
			l_inits: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			l_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION
			l_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			l_create_type := a_source.create_type
			if l_create_type /= Void then
				l_type := Type_reference_factory.type_reference_from_reference (l_create_type)
				l_size := a_source.size				
				if a_source.size_expression /= Void then
					code_dom_generator.generate_expression_from_dom (a_source.size_expression)
					l_size_expression := last_expression
				end
				l_inits := a_source.initializers
				l_initializers := expressions_from_collection (l_inits)
				if l_size > 0 or l_size_expression /= Void or l_initializers /= Void then
					create l_array_create_expression.make (l_type, l_size, l_size_expression, l_initializers)
					if l_inits /= Void then
						generate_initializer_feature (l_type, l_array_create_expression)
					end
					set_last_expression (l_array_create_expression)
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_array_information, [current_context])
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_creation_type, ["array creation expression"])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_array_indexer_expression (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION) is
			-- | Create instance of `CODE_ARRAY_INDEXER_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_indexer_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target: CODE_EXPRESSION
			l_indices: ARRAYED_LIST [CODE_EXPRESSION]
			l_ind: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			i, l_count: INTEGER
		do
			if a_source.target_object /= Void then
				l_ind := a_source.indices
				if l_ind /= Void then
					code_dom_generator.generate_expression_from_dom (a_source.target_object)
					l_target := last_expression
					from
						l_count := l_ind.count
						create l_indices.make (l_count)
					until
						i = l_count
					loop
						code_dom_generator.generate_expression_from_dom (l_ind.item (i))
						l_indices.extend (last_expression)
						i := i + 1
					end
					set_last_expression (create {CODE_ARRAY_INDEXER_EXPRESSION}.make (l_target, l_indices))
				else
					event_manager.raise_event ({CODE_EVENTS_IDS}.missing_indices, ["array indexer expression"])
				end
			else
				event_manager.raise_event ({CODE_EVENTS_IDS}.missing_target_object, ["array indexer expression"])
			end
		end

feature {NONE} -- Implementation

	generate_initializer_feature (a_array_type: CODE_TYPE_REFERENCE; a_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION) is
			-- Generate array initializers.
		require
			non_void_type: a_array_type /= Void
			non_void_array_create_expression: a_array_create_expression /= Void
		local
			l_feature: CODE_SNIPPET_FEATURE
			l_array_creation_feature_name: STRING
			l_feature_impl: STRING
		do
			if not a_array_type.name.is_equal ("System.Object") then
				create l_array_creation_feature_name.make (10 + a_array_type.eiffel_name.count)
				l_array_creation_feature_name.append ("new_array_")
				l_array_creation_feature_name.append (a_array_type.eiffel_name.as_lower)
				a_array_create_expression.set_conversion_feature_name (l_array_creation_feature_name)

				if not current_type.features.has (l_array_creation_feature_name) then
					create l_feature_impl.make (250)
					l_feature_impl.append ("%T")
					l_feature_impl.append (l_array_creation_feature_name)
					l_feature_impl.append (" (a_native_array: NATIVE_ARRAY [SYSTEM_OBJECT]): NATIVE_ARRAY [")
					l_feature_impl.append (a_array_type.eiffel_name)
					l_feature_impl.append ("] is%N")
	
						-- Add feature comment
					l_feature_impl.append ("%T%T%T-- Convert NATIVE_ARRAY [SYSTEM_OBJECT] to NATIVE_ARRAY [")
					l_feature_impl.append (a_array_type.eiffel_name)
					l_feature_impl.append ("]%N")
	
					l_feature_impl.append ("%T%Tlocal%N")
					l_feature_impl.append ("%T%T%Tl_counter, l_nb: INTEGER%N")
					l_feature_impl.append ("%T%T%Tl_temp: ")
					l_feature_impl.append (a_array_type.eiffel_name)
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

					create l_feature.make (l_array_creation_feature_name, l_feature_impl)
					l_feature.set_frozen (True)
					l_feature.set_constant (False)
					l_feature.set_once_routine (False)
					l_feature.set_overloaded (False)
					l_feature.set_feature_kind (Implementation)
					current_type.add_feature (l_feature)
				end
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