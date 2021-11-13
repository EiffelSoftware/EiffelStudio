class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Use a dedicated feature to exclude the effect of creation procedure checks.
			test_expression
			test_instruction
		end

feature {NONE} -- Testing

	test_expression
			-- Test attachment status in expressions.
		do
				-- Semi-strict conjunction.
			(a /= Void
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(attached a
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(attached a as x
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
				-- Semi-strict conjunction with negation.
			(not (a = Void)
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(not (not attached a)
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(not (not attached a as x)
				and then a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
				-- Semi-strict disjunction.
			(a = Void
				or else a.a = a -- Error only in MT
				or else a.f -- Error only in MT
				or else a.f -- Error
			).do_nothing
			(not (attached a)
				or else a.a = a -- Error only in MT
				or else a.f -- Error only in MT
				or else a.f -- Error
			).do_nothing
			(not (attached a as x)
				or else a.a = a -- Error only in MT
				or else a.f -- Error only in MT
				or else a.f -- Error
			).do_nothing
				-- Implication and semi-strict conjunction.
			(a /= Void
				implies a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(attached a
				implies a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
			(attached a as x
				implies a.a = a -- Error only in MT
				and then a.f -- Error only in MT
				and then a.f -- Error
			).do_nothing
		end

	test_instruction
			-- Test attachment status in instructions.
		local
			y: like a
		do
				-- Attachment tests.
			if a /= Void then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if attached a then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if attached a as x then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
				-- Negation.
			if not (a = Void) then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not (not attached a) then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not (not attached a as x) then
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
				-- Strict conjunction.
			if a /= Void and f then
				a.do_nothing -- Error
			end
			if attached a and f then
				a.do_nothing -- Error
			end
			if attached a as x and f then
				a.do_nothing -- Error
			end
				-- Semi-strict conjunction.
			if a /= Void and then f then
				a.do_nothing -- Error
			end
			if attached a and then f then
				a.do_nothing -- Error
			end
			if attached a as x and then f then
				a.do_nothing -- Error
			end
				-- Strict disjunction.
			if a = Void or f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not attached a or f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not attached a as x or f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
				-- Semi-strict disjunction.
			if a = Void or else f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not attached a or else f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if not attached a as x or else f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
				-- Implication.
			if a /= Void implies f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if attached a implies f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
			if attached a as x implies f then
				do_nothing
			else
				y := a.a -- Error only in MT
				a.do_nothing -- Error only in MT
				a.do_nothing -- Error
			end
		end

feature -- Access

	a: detachable TEST
			-- An attribute to check attachment status.

feature -- Basic operations

	f: BOOLEAN
			-- A query to set `a` to `Void`.
		do
			a := Void
			Result := True
		end

end
