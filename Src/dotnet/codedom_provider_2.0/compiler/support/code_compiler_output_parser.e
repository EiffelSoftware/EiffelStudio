indexing
	description: "Trivial Eiffel compiler output parser"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_COMPILER_OUTPUT_PARSER

create
	make

feature -- Initialization

	make is
		do
			create error_code.make_empty
			create error_text.make_empty
			create what_to_do_text.make_empty
		ensure
			non_void_error_code: error_code /= Void
			non_void_error_text: error_text /= Void
			non_void_what_to_do_text: what_to_do_text /= Void
		end
		

feature -- Access

	compiler_output: STRING
			-- Compiler output.

feature -- Access

	error_code: STRING
			-- Error code.
	
	error_text: STRING
			-- Text associated to error code.
	
	what_to_do_text: STRING
			-- What to do text associated to error code.
			
	error_line: INTEGER
			-- Error line.	
			
	successfull_compilation: BOOLEAN
			-- Is compiler_output indicate that compilation successed?
			

feature -- Basic operations

	parse (a_compiler_output: STRING) is
			-- Parse `a_compiler_outpur' and set attribute of class.
		require
			non_void_a_compiler_output: a_compiler_output /= Void
			not_empty_a_compiler_output: not a_compiler_output.is_empty
		local
			index: INTEGER
			index_2: INTEGER
			l_line_str: STRING
		do
			if a_compiler_output.has_substring (Successful_compilation_keyword) then
				successfull_compilation := True
			else
				successfull_compilation := False
				if a_compiler_output.has_substring (Error_line_keyword) then
					index := a_compiler_output.substring_index (Error_line_keyword, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						l_line_str := a_compiler_output.substring (index + Error_line_keyword.count, index_2)
						--error_line := l_line_str.to_integer
					end
				end
				if a_compiler_output.has_substring (Error_code_keyword) then
					index := a_compiler_output.substring_index (Error_code_keyword, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						error_code := a_compiler_output.substring (index + Error_code_keyword.count, index_2)
					end
				end
				if a_compiler_output.has_substring (Error_text_keyword) then
					index := a_compiler_output.substring_index (Error_text_keyword, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						error_text := a_compiler_output.substring (index + Error_text_keyword.count, index_2)
					end
				end
				if a_compiler_output.has_substring (Error_text_keyword_2) then
					index := a_compiler_output.substring_index (Error_text_keyword_2, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						error_text := a_compiler_output.substring (index + Error_text_keyword_2.count, index_2)
					end
				end
				if a_compiler_output.has_substring (Syntax_error_keyword) then
					index := a_compiler_output.substring_index (Syntax_error_keyword, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						error_text := a_compiler_output.substring (index, index_2)
					end
				end
				if a_compiler_output.has_substring (What_to_do_keyWord) then
					index := a_compiler_output.substring_index (What_to_do_keyWord, 1)
					if index > 0 then
						index_2 := a_compiler_output.index_of ('%N', index)
						what_to_do_text := a_compiler_output.substring (index + What_to_do_keyWord.count, index_2)
					end
				end
			end
		ensure
		end

feature {NONE} -- Implementation

	Successful_compilation_keyword: STRING is 
			-- Message displayed at the end of a successfull compilation.
		once
			Result := "System recompiled."
		ensure
			non_void_successful_compilation: Result /= Void
			not_empty_successful_compilation: not Result.is_empty
		end

	Error_code_keyword: STRING is "Error code:"
			-- Error code message

	Error_line_keyword: STRING is "Line:"
			-- Error line keyword.

	Error_text_keyword: STRING is "Type error:"
			-- Type error keyword.
			
	Error_text_keyword_2: STRING is "Error:"
			-- Type error keyword.
			
	Syntax_error_keyword: STRING is "Syntax error at line"
			-- Syntax error keyword.
	
	What_to_do_keyWord: STRING is "Type error:"
			-- What to do keyword.


invariant
	non_void_error_code: error_code /= Void
	non_void_error_text: error_text /= Void
	non_void_what_to_do_text: what_to_do_text /= Void

end -- class CODE_COMPILER_OUTPUT_PARSER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------