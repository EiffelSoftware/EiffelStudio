indexing
	description: "Support for CodeDOM Visitor."

class
	CODE_SUPPORT

inherit
	CODE_TYPE_CONVERTER_EIFFEL_TO_DOTNET

feature --{CODEDOM_VISITOR} -- Implementation

	fill_collection (eiffel_list: EIFFEL_LIST [AST_EIFFEL]; dotnet_list: ILIST) is
			-- fill `dotnet_list' with `eiffel_list'.
		require
			non_void_eiffel_list: eiffel_list /= Void
			valid_dotnet_list: dotnet_list /= Void and then dotnet_list.count = 0
		do
			from
				eiffel_list.start
			until
				eiffel_list.after
			loop
				added := dotnet_list.add (eiffel_list.item)
				eiffel_list.forth
			end
		ensure
			dotnet_list_set: dotnet_list.count = eiffel_list.count
		end

	line_pragma (line_number: INTEGER): SYSTEM_DLL_CODE_LINE_PRAGMA is
			-- generate line pragma for `an_as'.
		require
			valid_line_number: line_number > 0
		do
			create Result.make ("", line_number)
		ensure
			non_void_line_pragma: Result /= Void
		end

	visitor: CODE_CODEDOM_VISITOR is
			-- visitor
		once
			create Result.make
		ensure
			non_void_visitor: Result /= Void
		end

	last_element_created: SYSTEM_DLL_CODE_OBJECT is
			-- Retrieve last element generated.
		do
			Result := internal_last_element_created.item (0)
		ensure
			non_void_last_created_element: Result /= Void
		end
	
	last_custom_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION is
			-- Retrieve last custom attribute generated.
		do
			Result := Internal_last_custom_attribute.item (0)
		ensure
			non_void_last_custom_attribute: Result /= Void
		end

	current_type: SYSTEM_DLL_CODE_TYPE_DECLARATION is
			-- Retrieve last custom attribute generated.
		do
			Result := Internal_current_type.item (0)
		ensure
			non_void_current_type: Result /= Void
		end

	current_element: SYSTEM_OBJECT is
			-- Retrieve current element.
			-- | Not a SYSTEM_DLL_CODE_OBJECT, because of collections.
		do
			check
				has_elements: Internal_current_element.count > 0
			end
			Result ?= internal_current_element.peek
		ensure
			non_void_last_current_element: Result /= Void
		end

feature -- Basic Operations

	pop_current_element (a_current_element: SYSTEM_OBJECT) is
			-- Depile current element.
		require
			correct_pop: a_current_element.equals (current_element)
		local
			dummy: SYSTEM_OBJECT
		do
			check
				has_elements: Internal_current_element.count > 0
			end
			dummy := Internal_current_element.pop
		end

feature -- Status Setting

	set_last_element_created (an_element: SYSTEM_DLL_CODE_OBJECT) is
			-- Set `last_element_created' with `an_element'.
		require
			non_void_an_element: an_element /= Void
		do
			internal_last_element_created.put (0, an_element)
		ensure
			last_element_created_set: last_element_created = an_element
		end	

	set_current_element (an_element: SYSTEM_OBJECT) is
			-- Set `current_element' with `an_element'.
		require
			non_void_an_element: an_element /= Void
		do
			internal_current_element.push (an_element)
		ensure
			current_element_set: current_element = an_element
		end
		
	set_current_type (a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Set `current_type' with `an_element'.
		require
			non_void_type: a_type /= Void
		do
			internal_current_type.put (0, a_type)
		ensure
			current_type_set: current_type = a_type
		end	

	set_last_custom_attribute (a_ca: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION) is
			-- Set `last_custom_attribute' with `a_ca'.
		require
			non_void_a_ca: a_ca /= Void
		do
			internal_last_custom_attribute.put (0, a_ca)
		ensure
			last_element_created_set: last_custom_attribute = a_ca
		end
		
--	set_method_name (a_name: STRING) is
--		require
--			non_void_a_name: a_name /= Void
--			not_empty_a_name: not a_name.is_empty
--		do
--			internal_method_name.put (a_name)
--		ensure
--			method_name_set: method_name.is_equal (a_name)
--		end

feature {NONE} -- Implementation

	internal_last_element_created: NATIVE_ARRAY [SYSTEM_DLL_CODE_OBJECT] is
			-- internal representation of `last_element_created'.
		once
			create Result.make (1)
		ensure
			non_void_internal_last_element_created: Result /= Void
		end

	internal_current_element: SYSTEM_STACK is
			-- internal representation of `current_element'.
		once
			create Result.make
		ensure
			non_void_internal_current_element: Result /= Void
		end

	internal_last_custom_attribute: NATIVE_ARRAY [SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION] is
			-- internal representation of `last_custom_attribute'.
		once
			create Result.make (1)
		ensure
			non_void_internal_last_custom_attribute: Result /= Void
		end
		
	internal_current_type: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_DECLARATION] is
			-- internal representation of `current_type'.
		once
			create Result.make (1)
		ensure
			non_void_current_type: Result /= Void
		end
		
--	internal_method_name: CELL [STRING] is
--			-- internal representation of `method_name'.
--		once
--			create Result.put (Void)
--		ensure
--			non_void_internal_method_name: Result /= Void
--		end

	added: INTEGER
			-- dummy variable used when apply a add function and return an INTEGER.

end -- CODE_SUPPORT
