class
	ATTRIBUTES

create
	default_create,
	make

feature {NONE} -- Initialization

	make
		do
			test_a := "F"
			test_b := "E"
			test_c := "D"
			test_d := "C"
			test_e := "B"
			test_f := "A"
		end

feature -- Access

	test_a: attached STRING
			-- Simple assignment
		attribute
			Result := "A"
		end

	test_b: attached STRING
			-- Simple creation
		attribute
			create Result.make_from_string ("B")
		end

	test_c: attached STRING
			-- Detached assignment
		local
			l_result: detachable STRING
		attribute
			if (1).min (0) = 0 then
				l_result := "C"
			end
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

	test_d: attached STRING
			-- Qualified assignment
		local
			l_result: detachable STRING
		attribute
			l_result := "D"
			Result := l_result
		end

	test_e: attached STRING
			-- Object test assignment
		local
			s: STRING
		attribute
			s := "E"
			if attached {like test_e} s as l_result then
				Result := l_result
			else
				create Result.make_empty
			end
		end

	test_f: attached STRING
			-- Other attribute assignment
		attribute
			Result := f
		end

feature {NONE} -- Access

	f: attached STRING
		do
			create Result.make_from_string ("F")
		end

feature -- Output

	display
		do
			print (test_a)
			print (test_b)
			print (test_c)
			print (test_d)
			print (test_e)
			print (test_f)
			print ('%N')
		end

end

