indexing
	description: "C++ export status used in WIZARD_WRITER_CPP_CLASS"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_CPP_EXPORT_STATUS

feature -- Access

	Public, Protected, Private: INTEGER is unique
			-- Status
	
	cpp_status_keywords: HASH_TABLE [STRING, INTEGER] is
			-- Status keywords
		once
			create Result.make (10)
			Result.put (Protected_title, Protected)
			Result.put (Public_title, Public)
			Result.put (Private_title, Private)
		end

	is_valid_export_status (a_export_status: INTEGER): BOOLEAN is
			-- Is `a_export_status' a valid export status?
		do
			Result := a_export_status = Public or
						a_export_status = Protected or
						a_export_status = Private
		end

feature {NONE} -- Implementation

	Protected_title: STRING is "protected"
			-- Protected export status
	
	Public_title: STRING is "public"
			-- Public exprot status

	Private_title: STRING is "private"
			-- Private export status

invariant

	complete_cpp_status_keywords: cpp_status_keywords.has (Protected) and cpp_status_keywords.has (Public)

end -- class WIZARD_WRITER_CPP_EXPORT_STATUS

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
