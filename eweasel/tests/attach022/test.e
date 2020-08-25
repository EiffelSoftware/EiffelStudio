class TEST

create 
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			test (
				agent (o: detachable TEST): detachable TEST
					do
						Result := f (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create a
						Result := a.f (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create a
						Result := a.g (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create a
						Result := a.h (o)
					end,
				False
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create a
						Result := a.i (o)
					end,
				False
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [detachable TEST]
					do
						create {A [attached TEST]} a
						Result := a.f (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [detachable TEST]
					do
						create {A [attached TEST]} a
						Result := a.g (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create {B [attached TEST]} a
						Result := a.h (o)
					end,
				True
			)
			test (
				agent (o: detachable TEST): detachable TEST
					local
						a: A [attached TEST]
					do
						create {B [attached TEST]} a
						Result := a.i (o)
					end,
				True
			)
  		end

feature {NONE} -- Test

	test_number: INTEGER
			-- Number of the test

	test (c: attached FUNCTION [detachable TEST, detachable TEST]; e: BOOLEAN)
		local
			i: INTEGER
		do
			if i = 0 then
				i := 1
				if c.item ([Current]) = Current then
					i := 2
				else
						-- Incorrect result
					i := 3
				end
				if c.item ([Void]) /= Void then
						-- Incorrect result
					i := 3
				elseif e then
						-- Exception is not generated
					i := 3
				end
			end
			test_number := test_number + 1
			io.put_string ("Test " + test_number.out + ": ")
			if i = 2 then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		rescue
			if not e then
				i := 3
			end
			retry
		end

	f (a: detachable TEST): attached TEST
		external "C inline"
			alias "return eif_access($a);"
		end

end
