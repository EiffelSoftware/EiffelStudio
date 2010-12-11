class TEST

inherit
	EXCEPTION_MANAGER

create
	make

feature

	make
		do
			test_make_empty
			test_make_filled
		end

	test_make_empty
		local
			s: SPECIAL [INTEGER]
			retried: BOOLEAN
		do
			if not retried then
				create s.make_empty (-4)
			elseif last_exception.code /= {EXCEP_CONST}.Check_instruction then
				io.put_string ("Not OK!")
				io.put_new_line
			end
		rescue
			retried := True
			retry
		end

	test_make_filled
		local
			s: SPECIAL [INTEGER]
			retried: BOOLEAN
		do
			if not retried then
				create s.make_filled (-4, -4)
			elseif last_exception.code /= {EXCEP_CONST}.Check_instruction then
				io.put_string ("Not OK!")
				io.put_new_line
			end
		rescue
			retried := True
			retry
		end

end
