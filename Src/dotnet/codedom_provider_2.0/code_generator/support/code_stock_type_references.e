indexing
	description: "References to standard .NET types"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_STOCK_TYPE_REFERENCES

inherit
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

feature -- Access

	None_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to NONE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Void"))
		end

	Object_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to NONE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Object"))
		end

	Boolean_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to BOOLEAN
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Boolean"))
		end

	Double_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to System.Double
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Double"))
		end

	Type_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to SYSTEM_TYPE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Type"))
		end
		
end -- class CODE_STOCK_TYPE_REFERENCES

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