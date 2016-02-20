class A [G]

create
	make

feature {NONE} -- Creation

	make (c: attached G)
		local
			t: detachable G
		do
			test_local_assignment
			t := test_result_assignment
			test_attribute_assignment_stable
			test_attribute_assignment_unstable

			test_local_attempt (c)
			t := test_result_attempt (c)
			test_attribute_attempt_stable (c)
			test_attribute_attempt_unstable (c)

			test_local_creation_call
			t := test_result_creation_call
			test_attribute_creation_call_stable
			test_attribute_creation_call_unstable

--			test_local_creation_type
--			test_result_creation_type.do_nothing
--			test_attribute_creation_type_stable
--			test_attribute_creation_type_unstable
		end

feature {NONE} -- Tests: assignment

	test_local_assignment
		local
			a: G
		do
			a := abc -- VEEN
			a.do_nothing
		end

	test_result_assignment: G
		do
			Result := abc -- VEEN
		end

	test_attribute_assignment_stable
		do
			x := abc -- VEEN
			x.do_nothing
		end

	test_attribute_assignment_unstable
		do
			y := abc -- VEEN
			y.do_nothing -- VUTA(2)
		end

feature {NONE} -- Tests: assignment attempt

	test_local_attempt (c: attached G)
		local
			a: G
		do
			a := c
			a ?= abc -- VEEN
			a.do_nothing
		end

	test_result_attempt (c: attached G): G
		do
			Result := c
			Result ?= abc -- VEEN
		end

	test_attribute_attempt_stable (c: attached G)
		do
			x := c
			x ?= abc -- VJRV(3), VEEN
			x.do_nothing
		end

	test_attribute_attempt_unstable (c: attached G)
		do
			y := c
			y ?= abc -- VJRV(3), VEEN
			y.do_nothing -- VUTA(2)
		end

feature {NONE} -- Tests: creation

	test_local_creation_call
		local
			a: G
		do
			create a.abc -- VGCC(1)
			a.do_nothing
		end

	test_result_creation_call: G
		do
			create Result.abc -- VGCC(1)
		end

	test_attribute_creation_call_stable
		do
			create x.abc -- VGCC(1)
			x.do_nothing
		end

	test_attribute_creation_call_unstable
		do
			create y.abc -- VGCC(1)
			y.do_nothing -- VUTA(2)
		end

--	test_local_creation_type
--		local
--			a: G
--		do
--			create {ABC} a -- Error
--			a.do_nothing
--		end

--	test_result_creation_type: G
--		do
--			create {ABC} Result -- Error
--		end

--	test_attribute_creation_type_stable
--		do
--			create {ABC} x -- Error
--			x.do_nothing
--		end

--	test_attribute_creation_type_unstable
--		do
--			create {ABC} y -- Error
--			y.do_nothing -- Error
--		end

feature {NONE} -- Access

	x: G
		note
			option: stable
		attribute
		end

	y: G

end
