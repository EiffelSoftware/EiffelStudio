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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  