indexing
	description: "Code generator for type references"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_TYPE_REFERENCE_FACTORY

inherit
	ECDP_FACTORY

feature {ECDP_CONSUMER_FACTORY} -- Private Code Generator
		
	generate_type_reference (a_source: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
			-- | Create an instance of `EG_TYPE'
			-- | Initialize this instance with `a_source'
			-- | add type to `eg_types'
			-- | Set `last_return_type'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type: ECDP_TYPE
			l_type_name: STRING
		do
			create l_type_name.make_from_cil (a_source.base_type)
			if not Resolver.is_generated_type (l_type_name) then
				Resolver.add_external_type (l_type_name)
			end
			create l_type
			l_type.set_name (l_type_name)
			set_last_return_type (l_type)
		end

end -- class ECDP_TYPE_REFERENCE_FACTORY

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