indexing
	description: "Descriptor of Automation Data Type"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR

inherit
	WIZARD_DATA_TYPE_DESCRIPTOR


feature -- Status report

	is_equal_data_type (other: WIZARD_DATA_TYPE_DESCRIPTOR): BOOLEAN is
			-- Is `other' describes same data type?
		local
			other_automation: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR
		do
			other_automation ?= other
			if other_automation /= Void then
				Result := type = other_automation.type or 
					(type = Vt_void or type = Vt_hresult) and (other.type = Vt_void or other.type = Vt_hresult)
			end
		end

feature -- Visitor

	visit (a_visitor: WIZARD_DATA_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		do
			a_visitor.process_automation_data_type (Current)
		end

end -- class WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

