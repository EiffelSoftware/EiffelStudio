indexing
	description: "Code generator for custom attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_CUSTOM_ATTRIBUTE_FACTORY

inherit
	ECDP_FACTORY

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.
		
	initialize_custom_attribute_declaration (a_source: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION) is
			-- | Create an instance of `EG_ATTRIBUTE_DECLARATION'
			-- | Initialize this instance with `a_source'
			-- | Set `last_custom_attribute_declaration'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type_name: STRING
			l_attribute_declaration: ECDP_ATTRIBUTE_DECLARATION
			i: INTEGER
		do
			create l_attribute_declaration.make
			create l_type_name.make_from_cil (a_source.name)
			l_attribute_declaration.set_name (l_type_name)
			if not l_type_name.is_empty and then not Resolver.is_generated_type (l_type_name) then
				Resolver.add_external_type (l_type_name)
			end
			from
				i := 0
			until
				a_source.arguments = Void or else i = a_source.arguments.count
			loop
				Code_dom_generator.generate_custom_attribute_argument (a_source.arguments.item (i))
				l_attribute_declaration.add_attribute (last_custom_attribute_argument)
				i := i + 1
			end
			
			set_last_custom_attribute_declaration (l_attribute_declaration)
		end

	initialize_custom_attribute_argument (a_source: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT) is
			-- | Create an instance of `EG_ATTRIBUTE_ARGUMENT'
			-- | Initialize this instance with `a_source'
			-- | Set `last_custom_attribute_argument'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type_name: STRING
			l_argument: ECDP_ATTRIBUTE_ARGUMENT
		do
			create l_type_name.make_from_cil (a_source.name)
			create l_argument
			l_argument.set_name (l_type_name)
			if not l_type_name.is_empty and then not Resolver.is_generated_type (l_type_name) then
				Resolver.add_external_type (l_type_name)
			end
			Code_dom_generator.generate_expression_from_dom (a_source.value)
			l_argument.set_value (last_expression)

			set_last_custom_attribute_argument (l_argument)
		end


end -- class ECDP_CUSTOM_ATTRIBUTE_FACTORY

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