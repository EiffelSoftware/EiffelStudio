note
	description: "[
					An Eiffel validity error
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_EIFFEL_VALIDITY_ERROR

inherit
	EQA_EW_EIFFEL_ERROR
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make (a_name: like class_name; a_code: like validity_code)
			-- Create current validity error with `a_name' and `a_code'.
		require
			a_name_not_void: a_name /= Void
			a_code_not_void: a_code /= Void
		do
			class_name := a_name
			validity_code := a_code
		ensure
			class_name_set: class_name = a_name
			validity_code_set: validity_code = a_code
		end

feature -- Properties

	validity_code: STRING
			-- Validity code which was violated

feature -- Modification

	set_validity_code (a_code: STRING)
			-- Set `validity_code' with `a_code'
		require
			a_code_not_void: a_code /= Void
		do
			validity_code := a_code
		ensure
			validity_code_set: validity_code = a_code
		end

feature -- Summary

	summary: STRING
			-- Summary description for current
		do
			create Result.make (0)
			Result.append ("Validity error")
			if not equal (class_name, "")  then
				Result.append (" in class ")
				Result.append (class_name)
			end
			Result.append (" code ")
			if validity_code /= Void then
				Result.append (validity_code)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := class_name.is_equal (other.class_name) and validity_code.is_equal (other.validity_code)
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := class_name < other.class_name or else
				(equal (class_name, other.class_name) and validity_code < other.validity_code)
		end

invariant
	validity_code_not_void: validity_code /= Void

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
