indexing
	description: "Eiffel class feature clauses used by WIZARD_CLASS_WRITER"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
	
	Externals_title: STRING is "Externals";
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_WRITER_FEATURES_CLAUSES

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
