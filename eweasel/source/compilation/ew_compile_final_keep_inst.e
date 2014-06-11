note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "July 18, 2002"

class EW_COMPILE_FINAL_KEEP_INST

inherit
	EW_START_COMPILE_INST;

feature
	compilation_options (a_test: EW_EIFFEL_EWEASEL_TEST): LIST [STRING]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		once
			create {ARRAYED_LIST [STRING]} Result.make (2)
			Result.extend ("-verbose")
			Result.extend ("-finalize")
			Result.extend ("-keep")
		end;

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
