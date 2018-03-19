class TEST

create
	make

feature {NONE} -- Testing

	make
			-- Run test.
		do
				-- Instructions.
			if out = "" then
				do_nothing
			else
				do_nothing
			end
			if out /= "" then -- CA046
				do_nothing
			else
				do_nothing
			end
			if out /= "" then
				do_nothing
			end
			if out /= "" then
				do_nothing
			elseif out /= "" then
				do_nothing
			else
				do_nothing
			end
			if out ~ "" then
				do_nothing
			else
				do_nothing
			end
			if out /~ "" then -- CA046
				do_nothing
			else
				do_nothing
			end
			if out /~ "" then
				do_nothing
			end
			if out /~ "" then
				do_nothing
			elseif out /= "" then
				do_nothing
			else
				do_nothing
			end
				-- Expressions.
			;(if out = "" then
				0
			else
				0
			end).do_nothing
			;(if out /= "" then -- CA046
				0
			else
				0
			end).do_nothing
			;(if out /= "" then
				0
			elseif out /= "" then
				0
			else
				0
			end).do_nothing
			;(if out ~ "" then
				0
			else
				0
			end).do_nothing
			;(if out /~ "" then -- CA046
				0
			else
				0
			end).do_nothing
			;(if out /~ "" then
				0
			elseif out /= "" then
				0
			else
				0
			end).do_nothing
		end

end
