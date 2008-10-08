class TEST

creation 
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			test (
				agent (o: ?TEST): ?TEST
					do
						Result := f (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create a
						Result := a.f (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create a
						Result := a.g (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create a
						Result := a.h (o)
					end,
				False
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create a
						Result := a.i (o)
					end,
				False
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [?TEST]
					do
						create {A [!TEST]} a
						Result := a.f (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [?TEST]
					do
						create {A [!TEST]} a
						Result := a.g (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create {B [!TEST]} a
						Result := a.h (o)
					end,
				True
			)
			test (
				agent (o: ?TEST): ?TEST
					local
						a: A [!TEST]
					do
						create {B [!TEST]} a
						Result := a.i (o)
					end,
				True
			)
  		end

feature {NONE} -- Test

	test_number: INTEGER
			-- Number of the test

	test (c: FUNCTION [ANY, TUPLE [?TEST], ?TEST]; e: BOOLEAN)
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

	f (a: ?TEST): !TEST
		external "C inline"
			alias "return eif_access($a);"
		end

end
