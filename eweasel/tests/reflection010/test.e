class
	TEST

create
	default_create,
	make

feature {ANY} -- Initialization

	make
			-- Run test.
		do
			report (({TEST}).type_id, 1)
			report (({attached TEST}).type_id, 2)
			report (({detachable TEST}).type_id, 3)
			report (({CELL [TEST]}).generic_parameter_type (1).type_id, 4)
			report (({CELL [attached TEST]}).generic_parameter_type (1).type_id, 5)
			report (({CELL [detachable TEST]}).generic_parameter_type (1).type_id, 6)
			report (reflector.field_static_type_of_type (1, ({CELL [TEST]}).type_id), 7)
			report (reflector.field_static_type_of_type (1, ({CELL [attached TEST]}).type_id), 8)
			report (reflector.field_static_type_of_type (1, ({CELL [detachable TEST]}).type_id), 9)
		end

feature {NONE} -- Output

	report (type_id: like {TYPE [ANY]}.type_id; test_number: NATURAL_8)
			-- Report whether an object of type identified by `type_id`
			-- as well as its attached and detachable versions can be created
			-- in test number `test_number`.
		local
			is_retried: BOOLEAN
			e: EXCEPTIONS
		do
			if is_retried then
				io.put_string ("Failed! ")
				create e
				if e.assertion_violation then
					inspect e.exception
					when {EXCEPTIONS}.precondition then
						io.put_string ("Precondition violation")
					when {EXCEPTIONS}.postcondition then
						io.put_string ("Postcondition violation")
					else
						io.put_string ("Assertion violation")
					end
					if attached e.tag_name as tag_name then
						io.put_string (": ")
						io.put_string (tag_name)
					end
				else
					io.put_string ("Unknown exception")
				end
			else
				io.put_string ("Test #")
				io.put_natural_8 (test_number)
				report_creation (". None: ", type_id)
				report_creation (". Attached: ", reflector.attached_type (type_id))
				report_creation (". Detachable: ", reflector.detachable_type (type_id))
			end
			io.put_character ('.')
			io.put_new_line
		rescue
			is_retried := True
			retry
		end

	report_creation (tag: STRING; type_id: like {TYPE [ANY]}.type_id)
			-- Report result of an object creation using `{REFLECTOR}.new_instance_of` with a prefix tag `tag`.
		do
			io.put_string (tag)
			io.put_string
				(if attached reflector.new_instance_of (type_id) then
					"OK"
				else
					"Void"
				end)
		end

feature {NONE} -- Reflection

	reflector: REFLECTOR
			-- A reflector object.
		once
			create Result
		end

end
