class A

feature {NONE} -- Initialization

	make_self_precursor (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
		end

	make_agent_precursor (x: ANY)
			-- Make sure `x' is targeted.
		do
			x.do_nothing
		end

end