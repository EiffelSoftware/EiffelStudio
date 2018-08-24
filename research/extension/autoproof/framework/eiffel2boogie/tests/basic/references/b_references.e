class B_REFERENCES

feature

	void_check
		local
			a: ANY
		do
			check a = Void end
			check not attached a end
		end

	void_call
		local
			a: ANY
		do
			a.do_nothing
		end

	non_void_call (a: ANY)
		note
			explicit: contracts, wrapping
		require
			modify ([])
		do
			if a /= Void then
				a.do_nothing
			end
			if attached a as l_a then
				l_a.do_nothing
			end
		end

	non_void_contract (a, b, c: ANY)
		note
			explicit: contracts, wrapping
		require
			a /= Void
			attached b
			attached {B_REFERENCES} c
		do
			a.do_nothing
			b.do_nothing
			if attached {B_REFERENCES} c as l_c then
				l_c.non_void_call (Current)
			else
				check unreachable: False end
			end
		end

end
