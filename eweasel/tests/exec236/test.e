indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization
	neutral (i: INTEGER) is do end

	local_string: STRING is
		do
			Result := "Hallo Welt"
		end

	make is
		require
			(agent: BOOLEAN do Result := True end).item ([])
		do
			print ("%N%NAddress op test%N")
			neutral ($MELT1)
--			e (Current, $ext_func)

			print ("%N%Nreordering  procedure tests%N")
			reordering_procedure_tests

			print ("%N%Nreordering function tests %N")
			reordering_function_tests

			print ("%N%Nreordering function tests2%N")
			reordering_function_tests2

			print ("%N%Ninline agent test%N")
			test_inline_agent

			print ("%N%Ninline agent test hard%N")
			test_inline_agent_hard

			print ("%N%Nincremental test 1%N")
			test_incr_1

			print ("%N%NPrecondition test%N")
			test_precond

			print ("%N%NEmpty agent test%N")
			empty_agent_test
			
			print ("%N%NMember agent call test%N")
			test_member_agent_call

			print ("%N%NComplex calling tests%N")
			test_complex_calling
		end

	ext_func (i: INTEGER) is
		do
			print (i.out)
		end

	reordering_procedure_tests is
		local
			r1: ROUTINE [ANY, TUPLE [INTEGER, STRING]]
			p1: PROCEDURE [ANY, TUPLE [INTEGER, STRING]]
			r2: ROUTINE [ANY, TUPLE [TEST, STRING, BOOLEAN]]
			p2: PROCEDURE [ANY, TUPLE [TEST, STRING, BOOLEAN]]
			t1: TUPLE [INTEGER, STRING]
			t2: TUPLE [TEST, STRING, BOOLEAN]
		do
			neutral ($MELT2)
			print ( "tets1 (ct manifest):      %N")

			p1 := agent f (1, ?, "hallo", ?, true)
			r1 := p1

			p1.call ([2, "welt"])
			print ("-----------------------------%N")
			r1.call ([2, "welt"])

			print ( "tets2 (ct tuple): %N")

			t1 := [2, "welt"]
			p1.call (t1)
			print ("-----------------------------%N")
			r1.call (t1)

			print ( "tets3 (ot manifest): %N")

			p2 := agent {TEST}.f (1, 2, ?, "welt ", ?)
			r2 := p2

			p2.call ([current, "hallo", true])
			print ("-----------------------------%N")
			r2.call ([current, "hallo", true])

			print ( "tets4 (ot tuple): %N")

			t2 := [current, "hallo", true]
			p2.call (t2)
			print ("-----------------------------%N")
			r2.call (t2)


		end

	f (a1, a2: INTEGER; a3, a4: STRING; a5: BOOLEAN) is
		do
			neutral ($MELT3)
			print ( "a1: " + a1.out + "%N")
			print ( "a2: " + a2.out + "%N")
			print ( "a3: " + a3.out + "%N")
			print ( "a4: " + a4.out + "%N")
			print ( "a5: " + a5.out + "%N")
		end

	f2 (a1, a2: INTEGER; a3, a4: STRING; a5: BOOLEAN): INTEGER is
		do
			neutral ($MELT4)
			print ( "a1: " + a1.out + "%N")
			print ( "a2: " + a2.out + "%N")
			print ( "a3: " + a3.out + "%N")
			print ( "a4: " + a4.out + "%N")
			print ( "a5: " + a5.out + "%N")
			Result := 10
		end

	reordering_function_tests is
		local
			l_f1: FUNCTION [ANY, TUPLE [INTEGER, STRING], INTEGER]
			l_f2: FUNCTION [ANY, TUPLE [TEST, STRING, BOOLEAN], INTEGER]
			l_r1: ROUTINE [ANY, TUPLE [INTEGER, STRING]]
			l_r2: ROUTINE [ANY, TUPLE [TEST, STRING, BOOLEAN]]
			t1: TUPLE [INTEGER, STRING]
			t2: TUPLE [TEST, STRING, BOOLEAN]
		do
			neutral ($MELT5)
			print ( "tets1 (ct manifest):      %N ")

			l_f1 := agent f2 (1, ?, "hallo", ?, true)
			l_r1 := l_f1

			l_f1.call ([2, "welt"])
			print ("result of test1: " + l_f1.last_result.out)
			io.new_line

			l_r1.call ([2, "welt"])
			print ("result of test1: " + l_f1.last_result.out)
			io.new_line

			print ( "tets2 (ct tuple): %N")

			t1 := [2, "welt"]
			l_f1.call (t1)
			print ("result of test2: " + l_f1.last_result.out)
			io.new_line

			l_r1.call (t1)
			print ("result of test2: " + l_f1.last_result.out)
			io.new_line

			print ( "tets3 (ot manifest): %N")

			l_f2 := agent {TEST}.f2 (1, 2, ?, "welt ", ?)
			l_r2 := l_f2

			l_f2.call ([current, "hallo", true])
			print ("result of test3: " + l_f2.last_result.out)
			io.new_line

			l_r2.call ([current, "hallo", true])
			print ("result of test3: " + l_f2.last_result.out)
			io.new_line

			print ( "tets4 (ot tuple): %N")

			t2 := [current, "hallo", true]
			l_f2.call (t2)
			print ("result of test4: " + l_f2.last_result.out)
			io.new_line

			l_r2.call (t2)
			print ("result of test4: " + l_f2.last_result.out)
			io.new_line
		end

	reordering_function_tests2 is
		local
			l_f1: FUNCTION [ANY, TUPLE [INTEGER, STRING], INTEGER]
			l_f2: FUNCTION [ANY, TUPLE [TEST, STRING, BOOLEAN], INTEGER]
			t1: TUPLE [INTEGER, STRING]
			t2: TUPLE [TEST, STRING, BOOLEAN]
			i: INTEGER
		do
			neutral ($MELT6)
			print ( "tets1 (ct manifest):   %N")

			l_f1 := agent f2 (1, ?, "hallo", ?, true)

			i :=  l_f1.item ([2, "welt"])
			print ("result of test1: " + l_f1.item ([2, "welt"]).out)
			io.new_line

			print ( "tets2 (ct tuple): %N")

			t1 := [2, "welt"]
			print ("result of test2: " + l_f1.item (t1).out)
			io.new_line

			print ( "tets3 (ot manifest): %N")

			l_f2 := agent {TEST}.f2 (1, 2, ?, "welt ", ?)

			print ("result of test3: " + l_f2.item ([current, "hallo", true]).out)
			io.new_line

			print ( "tets4 (ot tuple): %N")

			t2 := [current, "hallo", true]
			print ("result of test4: " + l_f2.item (t2).out)
			io.new_line
		end

	test_inline_agent is
		local
		do
			print ("test1: expecting 1111 and get:  " + (
				agent (i1, i2, i3, i4: INTEGER): INTEGER
					do
						result := i1 + i2 + i3 + i4
						neutral ($MELT7)
				end (?, 10, 100, ?)
				).item([1, 1000]).out)
			io.new_line
		end

	test_inline_agent_hard is
		local
		do
			print ("test1: expecting 1111 and get:   " + (
			agent (i1, i3: INTEGER): FUNCTION [ANY, TUPLE [INTEGER, INTEGER], INTEGER]
				do
					result := agent (a_i1, a_i2,a_i3,a_i4: INTEGER): INTEGER
						do
							result := a_i1 + a_i2 + a_i3 + a_i4
							neutral ($MELT8)
						end (i1, ?, i3, ?)
				end
			).item([1, 100]).item([10, 1000]).out)
			io.new_line
		end

	incr_test_1_f (i1, i2: INTEGER; s1, s2: STRING): STRING is
		do
			neutral ($MELT9)
			print ("   Function got integers: " + i1.out + ", " + i2.out + " and strings: " + s1 + ", " + s2)
			io.new_line
			Result := "Correct Result"
		end

	incr_test_1_p (b1, b2: BOOLEAN; i1, i2: INTEGER) is
		do
			neutral ($MELT10)
			print (" Procedure got booleans:  " + b1.out + ", " + b2.out + " and integers: " + i1.out + ", " + i2.out)
			io.new_line
		end

	test_incr_1 is
		do
			print ("  incr%N")
			neutral ($MELT11)
			incr_1_caller (
				agent incr_test_1_f (?, 2, ?, "Welt"),
				agent incr_test_1_p (?, False, ?, 2))
		end

	incr_1_caller (a_f: FUNCTION [ANY, TUPLE [INTEGER, STRING], STRING]; a_p: PROCEDURE [ANY, TUPLE [BOOLEAN, INTEGER]]) is
		local
			t1: TUPLE [INTEGER, STRING]
			t2: TUPLE [BOOLEAN, INTEGER]
		do
			neutral ($MELT12)
			print (" test1:      %N")
			print ("got: " + a_f.item ([1, "Hallo"]))

			print ("test2: %N")
			t1 := [1, "Hallo"]
			print ("got: " + a_f.item (t1))

			print ("test3: %N")
			a_p.call ([True, 1])

			print ("test4: %N")
			t2 := [True, 1]
			a_p.call (t2)
		end

	test_precond is
		local
			p: PROCEDURE [ANY, TUPLE]
			level: INTEGER
		do
			neutral ($MELT13)
			if level = 0 then
				p := agent (s1, s2: STRING) do print (s1 + s2) end
				p.call ([p, p])
			elseif level = 1 then
				p := agent {TEST}.empty_agent_test
				p.call ([])
			elseif level = 2 then
				p := agent {TEST}.empty_agent_test
				p.call (["string"])
			end
		rescue
			print (" Got precondition violation level: " + level.out + "%N")
			level := level + 1
			retry
		end

	empty_agent_test is
		do
			(agent do end).call ([])
			neutral ($MELT14)
		end


	pebble_function: FUNCTION [ANY, TUPLE, ANY]

	test_member_agent_call is
		do
			neutral ($MELT15)
			pebble_function := agent: STRING do Result := "Hallo" end
			pebble_function.call ([1, 2])
		end


	tcc: TUPLE [t: TUPLE [t: TUPLE [s: STRING]]]

	test_complex_calling is
		do
			neutral ($MELT16)
			tcc1
			print ("cp 1:%N")
			tcc2 ([[["hallo"]]])
			print ("cp 2:%N")
		end

	tcc1 is
		do
			neutral ($MELT17)
			tcc := [[["Hallo"]]]
			print ((agent (tcc.t.t.s).out).item ([]))
			io.new_line
		end

	tcc2 (a_tcc2: like tcc) is
		do
			neutral ($MELT18)
			print ((agent (tcc.t.t.s).out).item ([]))
			io.new_line
		end


	e (c: like Current; p: POINTER) is
		external
			"C inline"
		alias
			"[
				((void (*)(EIF_REFERENCE, EIF_INTEGER_32)) $p) ($c, 10);
			]"
		end

end -- class TEST


