class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
  			io.put_string (test1a)
  			io.put_new_line
  			io.put_string (test1b)
  			io.put_new_line
  			io.put_string (test2a)
  			io.put_new_line
  			io.put_string (test2b)
  			io.put_new_line
  			io.put_string (test3a)
  			io.put_new_line
  			io.put_string (test3b)
  			io.put_new_line
		end

feature {NONE} -- Tests
	 
	test1a, test1b: STRING is
		do
			Result := "Test1: OK"
		end

	test2a, test2b: STRING is
		indexing
			tag: value
		do
			Result := "Test2: OK"
		end

	test3a, test3b: STRING is
		indexing
			once_status: global
		once
			Result := "Test3: OK"
		end

end 