class TEST

inherit
	EXCEPTIONS
create
	make

feature {NONE}

	make
		do
			test_develop_exception
			test_assertion_violation
			test_signal_failure
		end

feature -- Develop exception

	test_develop_exception
		local
			tried: BOOLEAN
		do
			if not tried then
				try
			else
				print (is_developer_exception_of_name (Test_exception_name)); io.new_line
			end
		rescue
			print (is_developer_exception_of_name (Test_exception_name)); io.new_line
			tried := True
			retry
		end

	try
		do
			try2
		rescue
		end

	try2
		do
			raise (Test_exception_name)
		end

feature -- Assertion violation

	test_assertion_violation
		local
			tried: BOOLEAN
		do
			if not tried then
				try_ass
			else
				print (assertion_violation); io.new_line
			end
		rescue
			print (assertion_violation); io.new_line
			tried := True
			retry
		end

	try_ass
		do
			try2_ass
		rescue
		end

	try2_ass
		do
			check False end
		end
		
feature -- Signal failure

	test_signal_failure
		local
			tried: BOOLEAN
		do
			if not tried then
				try_sig
			else
				print (is_signal); io.new_line
			end
		rescue
			print (is_signal); io.new_line
			tried := True
			retry
		end

	try_sig
		do
			try2_sig
		rescue
		end

	try2_sig
		do
			raise_bad_access
		end
	
feature

	raise_bad_access
		external
			"C inline"
		alias
			"[
				char * p = 1;
				*p = 10;
			]"
		end

	Test_exception_name: STRING = "Test"
end