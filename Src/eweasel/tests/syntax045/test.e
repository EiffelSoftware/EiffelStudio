indexing

	meaning:
		"$(OPEN)
			This verbatim string should never be reported
			in a warning, because it is written in indexing clause.
		$(CLOSE)"

class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
				-- Empty verbatim strings
			test_equality (
				"$(OPEN)
				$(CLOSE)",
				""
			)
			test_equality (
				"$(OPEN)
$(CLOSE)",
				""
			)
			test_equality (
				"$(OPEN)
					$(CLOSE)",
				""
			)
				-- Verbatim strings with data
			test_equality (
				"$(OPEN)
				ABC
				$(CLOSE)",
				"$(INDENT)ABC"
			)
			test_equality (
				"$(OPEN)
				ABC
				abc
				$(CLOSE)",
				"$(INDENT)ABC%N$(INDENT)abc"
			)
			test_equality (
				"$(OPEN)
				ABC 	
				$(CLOSE)",
				"$(INDENT)ABC %T"
			)
			test_equality (
				"$(OPEN)
				ABC
				 abc
				$(CLOSE)",
				"$(INDENT)ABC%N$(INDENT) abc"
			)
			test_equality (
				"$(OPEN)
				 ABC
				abc
				$(CLOSE)",
				"$(INDENT) ABC%N$(INDENT)abc"
			)
			test_equality (
				"$(OPEN)
				 ABC
				 abc
				$(CLOSE)",
				"$(INDENT)$(SPACE)ABC%N$(INDENT)$(SPACE)abc"
			)
				-- Verbatim strings with special data
			test_equality (
				"$(OPEN)
				$(CLOSE)
				$(CLOSE)",
				"$(INDENT)%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				$(CLOSE)
				$(CLOSE)
				$(CLOSE)",
				"$(INDENT)%/$(CLOSE_CODE)/%N$(INDENT)%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				$(CLOSE) 	
				$(CLOSE)",
				"$(INDENT)%/$(CLOSE_CODE)/ %T"
			)
			test_equality (
				"$(OPEN)
				$(CLOSE)
				 $(CLOSE)
				$(CLOSE)",
				"$(INDENT)%/$(CLOSE_CODE)/%N$(INDENT) %/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				 $(CLOSE)
				$(CLOSE)
				$(CLOSE)",
				"$(INDENT) %/$(CLOSE_CODE)/%N$(INDENT)%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				 $(CLOSE)
				 $(CLOSE)
				$(CLOSE)",
				"$(INDENT)$(SPACE)%/$(CLOSE_CODE)/%N$(INDENT)$(SPACE)%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)"
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%""
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)"
				abc$(CLOSE)"
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%"%N$(INDENT)abc%/$(CLOSE_CODE)/%""
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)" 	
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%" %T"
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)"
				 abc$(CLOSE)"
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%"%N$(INDENT) abc%/$(CLOSE_CODE)/%""
			)
			test_equality (
				"$(OPEN)
				 ABC$(CLOSE)"
				abc$(CLOSE)"
				$(CLOSE)",
				"$(INDENT) ABC%/$(CLOSE_CODE)/%"%N$(INDENT)abc%/$(CLOSE_CODE)/%""
			)
			test_equality (
				"$(OPEN)
				 ABC$(CLOSE)"
				 abc$(CLOSE)"
				$(CLOSE)",
				"$(INDENT)$(SPACE)ABC%/$(CLOSE_CODE)/%"%N$(INDENT)$(SPACE)abc%/$(CLOSE_CODE)/%""
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)
				abc$(CLOSE)
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%N$(INDENT)abc%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE) 	
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/ %T"
			)
			test_equality (
				"$(OPEN)
				ABC$(CLOSE)
				 abc$(CLOSE)
				$(CLOSE)",
				"$(INDENT)ABC%/$(CLOSE_CODE)/%N$(INDENT) abc%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				 ABC$(CLOSE)
				abc$(CLOSE)
				$(CLOSE)",
				"$(INDENT) ABC%/$(CLOSE_CODE)/%N$(INDENT)abc%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				 ABC$(CLOSE)
				 abc$(CLOSE)
				$(CLOSE)",
				"$(INDENT)$(SPACE)ABC%/$(CLOSE_CODE)/%N$(INDENT)$(SPACE)abc%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)
				$(CLOSE_OTHER)"
				$(CLOSE)",
				"$(INDENT)%/$(CLOSE_OTHER_CODE)/%""
			)
				-- Verbatim strings with non-empty opener and closer
			test_equality (
				"++$(OPEN)
				]"
				$(CLOSE)++",
				"$(INDENT)%/93/%""
			)
			test_equality (
				"++$(OPEN)
				}"
				$(CLOSE)++",
				"$(INDENT)%/125/%""
			)
			test_equality (
				"%$(OPEN)
				$(CLOSE)%",
				""
			)
			test_equality (
				"$(OPEN)%
				%$(CLOSE)",
				"%/$(OPEN_CODE)/%/$(CLOSE_CODE)/"
			)
			test_equality (
				"$(OPEN)$(CLOSE)",
				"%/$(OPEN_CODE)/%/$(CLOSE_CODE)/"
			)
		end

feature {NONE} -- Tests

	test_number: INTEGER
			-- Last test number

	test_equality (s1, s2: STRING) is
			-- Check if `s1' and `s2' are not void and are equal.
		do
			test_number := test_number + 1
			io.put_string ("Test " + test_number.out + ": ")
			if s1 /= Void and then s2 /= Void and then equal (s1, s2) then
				io.put_string ("OK%N")
			else
				io.put_string ("FAILED: ")
				print_string (s1)
				io.put_string (" instead of ")
				print_string (s2)
				io.put_character ('%N')
			end
		ensure
			test_number_increased: test_number = old test_number + 1
		end

feature {NONE} -- Output

	print_string (s: STRING) is
			-- Print string `s' escaping special characters.
		local
			i: INTEGER
			c: CHARACTER
		do
			io.put_character ('%"')
			from
				i := 1
			until
				i > s.count
			loop
				c := s.item (i)
				inspect c
				when
					'%/0/' .. '%/8/',
					'%/10/' .. '%/31/', '%/127/' .. '%/255/' then
					io.put_string ("%%/")
					io.put_integer (c.code)
					io.put_character ('/')
				when '%"' then
					io.put_string ("%%%"")
				when '%%' then
					io.put_string ("%%%%")
				when '%'' then
					io.put_string ("%%%'")
				when '%T' then
					io.put_string ("%%T")
				else
					io.put_character (c)
				end
				i := i + 1
			end
			io.put_character ('%"')
		end

invariant

	non_negative_test_number: test_number >= 0

indexing

	meaning:
		"$(OPEN)
			This verbatim string should never be reported
			in a warning, because it is written in indexing clause.
		$(CLOSE)"

end