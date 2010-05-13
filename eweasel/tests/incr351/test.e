class TEST

create
	make

feature

	make
			-- Run test.
		local
		do
		end

	reference_special: ARRAY [TEST1]

	id: TEST1

	$COMMENT

invariant
	test: reference_special.for_all (agent (a_test: TEST1): BOOLEAN do Result := a_test.id = id end)

end
