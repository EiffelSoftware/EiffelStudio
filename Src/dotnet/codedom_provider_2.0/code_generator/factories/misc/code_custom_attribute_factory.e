indexing
	description: "Code generator for custom attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CUSTOM_ATTRIBUTE_FACTORY

inherit
	CODE_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.
		
	initialize_custom_attribute_declaration (a_source: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION) is
			-- | Create an instance of `CODE_ATTRIBUTE_DECLARATION'
			-- | Initialize this instance with `a_source'
			-- | Set `last_custom_attribute_declaration'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			i, l_count: INTEGER
			l_arguments: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT_COLLECTION
			l_code_arguments: LIST [CODE_ATTRIBUTE_ARGUMENT]
			l_type: CODE_TYPE_REFERENCE
		do
			l_type := Type_reference_factory.type_reference_from_name (a_source.name)
			l_arguments := a_source.arguments
			if l_arguments /= Void then
				from
					l_count := l_arguments.count
					create {ARRAYED_LIST [CODE_ATTRIBUTE_ARGUMENT]} l_code_arguments.make (l_count)
				until
					i = l_count
				loop
					Code_dom_generator.generate_custom_attribute_argument (l_arguments.item (i))
					l_code_arguments.extend (last_custom_attribute_argument)
					i := i + 1
				end
			end
			set_last_custom_attribute_declaration (create {CODE_ATTRIBUTE_DECLARATION}.make (l_type, l_code_arguments))
		end

	initialize_custom_attribute_argument (a_source: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT) is
			-- | Create an instance of `CODE_ATTRIBUTE_ARGUMENT'
			-- | Initialize this instance with `a_source'
			-- | Set `last_custom_attribute_argument'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_argument: CODE_ATTRIBUTE_ARGUMENT
		do
			Code_dom_generator.generate_expression_from_dom (a_source.value)
			create l_argument.make (last_expression, a_source.name, Type_reference_factory.type_reference_from_code (current_type))
			set_last_custom_attribute_argument (l_argument)
		end

end -- class CODE_CUSTOM_ATTRIBUTE_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------