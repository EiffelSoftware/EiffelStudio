class TEST

inherit
	EXCEPTIONS
create
	make

feature {NONE}

	make
		local
			l_retried: BOOLEAN
			l_dev: ROUTINE_FAILURE
		do
			if not l_retried then
				test
			end
		rescue
			print (tag_name); io.put_new_line
			l_dev ?= exception_manager.last_exception
			print (l_dev = Void); io.put_new_line
			l_retried := True
			retry
		end

	
	test
		do
			raise ("Test")
		rescue
			raise ("Test rescue")
		end
	
end