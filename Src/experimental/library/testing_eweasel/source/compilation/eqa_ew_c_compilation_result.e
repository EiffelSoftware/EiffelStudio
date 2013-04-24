note
	description: "[
					A C compilation result
																]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "93/08/30"
	revision: "$Revision$"

class EQA_EW_C_COMPILATION_RESULT

inherit
	EQA_EW_RESULT

feature -- Properties

	failure: BOOLEAN
			-- Did an error occur while doing C compilations
			-- and or links?

	compilations_completed: BOOLEAN
			-- Did all compilations/links finish successfully?

	summary: STRING
			-- Summary of `Current'
		do
			create Result.make (0)
			if failure then
				Result.append ("failure ")
			else
				Result.append ("no_failure ")
			end
			if compilations_completed then
				Result.append ("C_compilation_completed")
			else
				Result.append ("C_compilation_not_completed")
			end
		end

feature -- Update

	set_compilations_completed (a_b: BOOLEAN)
			-- Set `compilations_completed' with `a_b'
		do
			compilations_completed := a_b
		end

	update (a_line: READABLE_STRING_8)
			-- Update `Current' to reflect the presence of
			-- `a_line' as next line in C compilation process output.
		local
			l_s: SEQ_STRING
		do
			create l_s.make (a_line.count)
			l_s.append (a_line)
			l_s.to_lower
			l_s.start
			l_s.search_string_after (Failure_string1, 0)
			if not l_s.after then
				failure := True
			end
			l_s.start
			l_s.search_string_after (Failure_string2, 0)
			if not l_s.after then
				failure := True
			end
			l_s.start
			l_s.search_string_after (Failure_string3, 0)
			if not l_s.after then
				failure := True
			end
			l_s.start
			l_s.search_string_after (Failure_string4, 0)
			if not l_s.after then
				failure := True
			end
			l_s.start
			l_s.search_string_after (Completed_string, 0)
			if not l_s.after then
				compilations_completed := True
			end
		end

feature -- Comparison

	matches (other: EQA_EW_C_COMPILATION_RESULT): BOOLEAN
			-- Do `Current' and `other' represent the
			-- same compilation result?
		require
			other_not_void: other /= Void
		do
			Result := equal (Current, other)
		end


feature {NONE} -- String constants

	Failure_string1: STRING = "fatal error"

	Failure_string2: STRING = "fatal:"

	Failure_string3: STRING = " error "

	Failure_string4: STRING = "waiting for unfinished jobs"

	Completed_string: STRING = "c compilation completed"

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
