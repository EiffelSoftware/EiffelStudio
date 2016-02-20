class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			t: detachable TEST
			u: A [TEST]
		do
			create x.make
			create u.make (Current)

			test_local_assignment_attached
			t := test_result_assignment_attached
			test_attribute_assignment_attached

			test_local_assignment_detachable
			t := test_result_assignment_detachable
			test_attribute_assignment_detachable

			test_attribute_assignment_stable

			test_local_attempt_attached
			t := test_result_attempt_attached
			test_attribute_attempt_attached

			test_local_attempt_detachable
			t := test_result_attempt_detachable
			test_attribute_attempt_detachable

			test_local_creation_call_attached
			t := test_result_creation_call_attached
			test_attribute_creation_call_attached

			test_local_creation_call_detachable
			t := test_result_creation_call_detachable
			test_attribute_creation_call_detachable

			test_attribute_creation_call_stable

--			test_local_creation_type
--			test_result_creation_type.do_nothing
--			test_attribute_creation_type_stable
--			test_attribute_creation_type_detachable
		end

feature {NONE} -- Tests: assignment

	test_local_assignment_attached
		local
			a: attached TEST
		do
			a := abc -- VEEN
			a.do_nothing
		end

	test_result_assignment_attached: attached TEST
		do
			Result := abc -- VEEN
		end

	test_attribute_assignment_attached
		do
			x := abc -- VEEN
			x.do_nothing
		end

	test_local_assignment_detachable
		local
			a: detachable TEST
		do
			a := abc -- VEEN
			a.do_nothing
		end

	test_result_assignment_detachable: detachable TEST
		do
			Result := abc -- VEEN
			Result.do_nothing
		end

	test_attribute_assignment_detachable
		do
			y := abc -- VEEN
			y.do_nothing -- VUTA(2)
		end

	test_attribute_assignment_stable
		do
			z := abc -- VEEN
			z.do_nothing
		end

feature {NONE} -- Tests: assignment attempt

	test_local_attempt_attached
		local
			a: attached TEST
		do
			a := Current
			a ?= abc -- VEEN
			a.do_nothing
		end

	test_result_attempt_attached: attached TEST
		do
			Result := Current
			Result ?= abc -- VEEN
		end

	test_attribute_attempt_attached
		do
			x := Current
			x ?= abc -- VJRV(3), VEEN
			x.do_nothing
		end

	test_local_attempt_detachable
		local
			a: detachable TEST
		do
			a := Current
			a ?= abc -- VEEN
			a.do_nothing
		end

	test_result_attempt_detachable: detachable TEST
		do
			Result := Current
			Result ?= abc -- VEEN
			Result.do_nothing
		end

	test_attribute_attempt_detachable
		do
			y := Current
			y ?= abc -- VEEN
			y.do_nothing -- VUTA(2)
		end

	test_attribute_attempt_stable
		do
			z := Current
			z ?= abc -- VBAR(2), VEEN
			z.do_nothing
		end

feature {NONE} -- Tests: creation

	test_local_creation_call_attached
		local
			a: attached TEST
		do
			create a.abc -- VEEN
			a.do_nothing
		end

	test_result_creation_call_attached: attached TEST
		do
			create Result.abc -- VEEN
		end

	test_attribute_creation_call_attached
		do
			create x.abc -- VEEN
			x.do_nothing
		end

	test_local_creation_call_detachable
		local
			a: detachable TEST
		do
			create a.abc -- VEEN
			a.do_nothing
		end

	test_result_creation_call_detachable: detachable TEST
		do
			create Result.abc -- VEEN
			Result.do_nothing
		end

	test_attribute_creation_call_detachable
		do
			create y.abc -- VEEN
			y.do_nothing -- VUTA(2)
		end

	test_attribute_creation_call_stable
		do
			create z.abc -- VEEN
			z.do_nothing
		end

--	test_local_creation_type_attached
--		local
--			a: attached TEST
--		do
--			create {ABC} a -- Error
--			a.do_nothing
--		end

--	test_result_creation_type_attached: attached TEST
--		do
--			create {ABC} Result -- Error
--		end

--	test_attribute_creation_type_attached
--		do
--			create {ABC} x -- Error
--			x.do_nothing
--		end

--	test_local_creation_type_detachable
--		local
--			a: detachable TEST
--		do
--			create {ABC} a -- Error
--			a.do_nothing
--		end

--	test_result_creation_type_attached: detachable TEST
--		do
--			create {ABC} Result -- Error
--			Result.do_nothing
--		end

--	test_attribute_creation_type_detachable
--		do
--			create {ABC} y -- Error
--			y.do_nothing -- Error
--		end

--	test_attribute_creation_type_stable
--		do
--			create {ABC} z -- Error
--			z.do_nothing
--		end

feature {NONE} -- Access

	x: attached TEST

	y: detachable TEST

	z: detachable TEST
		note
			option: stable
		attribute
		end

end
