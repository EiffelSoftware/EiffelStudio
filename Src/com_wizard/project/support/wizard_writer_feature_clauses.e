indexing
	description: "Eiffel class feature clauses used by WIZARD_CLASS_WRITER"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_FEATURE_CLAUSES

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

feature -- Access

	Initialization: INTEGER is 1
	
	Access: INTEGER is 2
	
	Measurement: INTEGER is 3

	Status_report: INTEGER is 4
	
	Element_change: INTEGER is 5
	
	Basic_operations: INTEGER is 6

	Implementation: INTEGER is 7
	
	Externals: INTEGER is 8
			-- Feature clauses

	feature_clauses: HASH_TABLE [STRING, INTEGER] is
			-- Feature clauses
		once
			create Result.make (10)
			Result.put (Initialization_title, Initialization)
			Result.put (Access_title, Access)
			Result.put (Measurement_title, Measurement)
			Result.put (Status_report_title, Status_report)
			Result.put (Element_change_title, Element_change)
			Result.put (Basic_operations_title, Basic_operations)
			Result.put (Implementation_title, Implementation)
			Result.put (Externals_title, Externals)
		end

	is_valid_clause (a_clause: INTEGER): BOOLEAN is
			-- Is `a_clause' a valid feature clause?
		do
			Result := a_clause = Initialization or
						a_clause = Access or
						a_clause = Basic_operations or
						a_clause = Implementation or
						a_clause = Externals or
						a_clause = Element_change or
						a_clause = Status_report or
						a_clause = Measurement
		end

feature {NONE} -- Implementation
	
	Externals_title: STRING is "Externals"
	
end -- class WIZARD_WRITER_FEATURES_CLAUSES

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
  