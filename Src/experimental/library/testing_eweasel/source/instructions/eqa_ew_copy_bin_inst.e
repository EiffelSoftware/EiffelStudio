note
	description: "Copy file using RAW_FILE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_COPY_BIN_INST

inherit
	EQA_EW_COPY_INST
--		redefine
--			copy_file
--		end

create
	make
	
feature -- Properties

	substitute: BOOLEAN = True
			-- Do not substitute lines of copied files

feature {NONE} -- Implementation

--FIXME: copy raw_file instead of plain text file?
--	copy_file (src: like new_file; env: EQA_EW_TEST_ENVIRONMENT; dest: like new_file)
--			-- Append lines of file `src', with environment
--			-- variables substituted according to `env' (but
--			-- only if `substitute' is true) to
--			-- file `dest'.
--		do
--			dest.open_write
--			src.open_read
--			src.copy_to (dest)
--			src.close
--			dest.close
--		end

	new_file (a_file_name: STRING): RAW_FILE
			-- <Precursor>
		do
			create Result.make (a_file_name)
		end

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
