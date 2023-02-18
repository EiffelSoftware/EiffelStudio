note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	IRON_STRING_VARIABLE_EXPANSER_TEST_SET

inherit
	EQA_TEST_SET

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

feature -- Test routines

	test_expander
		local
			exp: IRON_STRING_VARIABLE_EXPANSER
			s: STRING_32
			l_test_var_1, l_test_var_2, l_test_var_3, l_test_var_4: IMMUTABLE_STRING_32
			l_test_value_1, l_test_value_2, l_test_value_3, l_test_value_4: IMMUTABLE_STRING_32
			env: STRING_TABLE [READABLE_STRING_32]
			k: READABLE_STRING_32
		do
			l_test_var_1 := "TEST_TMP_1"; l_test_value_1 := "Value_1"
			l_test_var_2 := "TEST"; l_test_value_2 := "Value_2"
			l_test_var_3 := "TEST123"; l_test_value_3 := "Value_3"
			l_test_var_4 := "_"; l_test_value_4 := "Value_4"

			create env.make (4)
			env.put (l_test_value_1, l_test_var_1)
			env.put (l_test_value_2, l_test_var_2)
			env.put (l_test_value_3, l_test_var_3)
			env.put (l_test_value_4, l_test_var_4)

			across env as ic loop
				execution_environment.put (ic, @ ic.key)
			end

			across env as ic loop
				k := @ ic.key.as_string_32

				s := "c:\foo\bar\$"+ k +"\blabla"
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string ({STRING_32} "c:\foo\bar\"+ ic +"\blabla"))

				s := "c:\foo\bar\${"+ k +"}\blabla"
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string ({STRING_32} "c:\foo\bar\"+ ic +"\blabla"))

				s := "c:\foo\bar\$("+ k +")\blabla"
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string ({STRING_32} "c:\foo\bar\"+ ic +"\blabla"))

				s := "$"+ k +"\blabla"
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string (ic +"\blabla"))

				s := "blabla/$"+ k
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string ({STRING_32} "blabla/" + ic))

				s := "$" + k + "/bla${"+ k + "}bla/$"+ k
				exp.expand_string_32 (s, agent env.item)
				assert ("replaced", s.same_string (ic + "/bla" + ic + "bla/" + ic))

			end
		end

end


