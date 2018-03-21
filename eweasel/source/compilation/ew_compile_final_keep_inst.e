note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_COMPILE_FINAL_KEEP_INST

inherit
	EW_START_COMPILE_INST

feature
	compilation_options (a_test: EW_EIFFEL_EWEASEL_TEST): LIST [READABLE_STRING_32]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		once
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (2)
			Result.extend ({STRING_32} "-verbose")
			Result.extend ({STRING_32} "-finalize")
			Result.extend ({STRING_32} "-keep")
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
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


end
