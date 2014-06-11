note
	description: "A code analysis run process."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "05/2014"

class
	EW_CODE_ANALYSIS_PROCESS

inherit

	EW_EIFFEL_COMPILATION
		rename
			next_compile_result as next_analysis_result,
			next_compile_result_type as next_analysis_result_type
		redefine
			next_analysis_result,
			next_analysis_result_type
		end

feature -- Class body

	next_analysis_result_type: EW_CODE_ANALYSIS_RESULT
			-- <Precursor>
		do
			check
				callable: False
			then
			end
		end

	next_analysis_result: like next_analysis_result_type
			-- <Precursor>
		do
			Result := Precursor
			if not Result.is_status_known then
					-- Save raw compiler output so it can
					-- be displayed
				Result.set_raw_compiler_output (savefile_contents)
			end
		end

note
	copyright: "[
		Copyright (c) 1984-2007, University of Southern California and contributors.
		All rights reserved.
	]"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
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
