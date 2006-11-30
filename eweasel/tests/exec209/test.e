class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
  			io.put_string (test1)
  			io.put_new_line
  			io.put_string (test2)
  			io.put_new_line
  			io.put_string (test3)
  			io.put_new_line
		end

feature {NONE} -- Tests
	 
	test1: STRING is
		do
			Result := once "Test1: OK"
		end

	test2: STRING is
		once
			Result := once "Test2: OK"
		end

	test3: STRING is
		indexing
			once_status: global
		once
			Result := once "Test3: OK"
		end

end 