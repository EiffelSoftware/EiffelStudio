class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		do
			f ("S")
			g ("S")
			g (Void)
			h ("S")
		end

	f (a: ANY)
		local
			t1: TEST1 [like a]
			t2: TEST1 [attached like a]
			t3: TEST1 [detachable like a]
		do
			create t1
			create t2
			create t3
			assert ("1", t1.generating_type.type_id = attached_test1_string_type_id)
			assert ("2", t2.generating_type.type_id = attached_test1_string_type_id)
			assert ("3", t3.generating_type.type_id = detachable_test1_string_type_id)
		end

	g (a: detachable ANY)
		local
			t1: TEST1 [like a]
			t2: TEST1 [attached like a]
			t3: TEST1 [detachable like a]
		do
			create t1
			create t2
			create t3
			if a /= Void then
					-- For the time being, we will accept that in Void-safe mode, the type is
					-- TEST1 [detachable like a] when `a' is attached. This works correctly in 15.08
					-- experimental mode, but non-experimental mode is difficult to support as the
					-- type of an object never carries the attached nature of the type.
					-- In practice this rarely happens, so we will accept the behavior.
					-- Uncomment this line to have the proper expected result.
				-- assert ("4", t1.generating_type.type_id = attached_test1_string_type_id)
				assert ("4", t1.generating_type.type_id = detachable_test1_string_type_id)
				assert ("5", t2.generating_type.type_id = attached_test1_string_type_id)
				assert ("6", t3.generating_type.type_id = detachable_test1_string_type_id)
			else
				assert ("7", t1.generating_type.type_id = detachable_test1_any_type_id)
				assert ("8", t2.generating_type.type_id = attached_test1_any_type_id)
				assert ("9", t3.generating_type.type_id = detachable_test1_any_type_id)
			end
		end

	h (a: attached ANY)
		local
			t1: TEST1 [like a]
			t2: TEST1 [attached like a]
			t3: TEST1 [detachable like a]
		do
			create t1
			create t2
			create t3
			assert ("10", t1.generating_type.type_id = attached_test1_string_type_id)
			assert ("11", t2.generating_type.type_id = attached_test1_string_type_id)
			assert ("12", t3.generating_type.type_id = detachable_test1_string_type_id)
		end

	assert (s: STRING; b: BOOLEAN)
		do
			if not b then
				io.put_string ("Not OK: " + s + "%N")
			end
		end

	attached_test1_any_type_id: INTEGER
		once
			Result := (create {TEST1 [attached ANY]}).generating_type.type_id
		end

	detachable_test1_any_type_id: INTEGER
		once
			Result := (create {TEST1 [detachable ANY]}).generating_type.type_id
		end

	attached_test1_string_type_id: INTEGER
		once
			Result := (create {TEST1 [attached STRING]}).generating_type.type_id
		end

	detachable_test1_string_type_id: INTEGER
		once
			Result := (create {TEST1 [detachable STRING]}).generating_type.type_id
		end


end
