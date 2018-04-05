class TEST

create
	make

feature {NONE} -- Testing

	make
			-- Run test.
		do
				-- Single branch without else.
			if out = "" then
				do_nothing
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			end

				-- Single branch with else.
			if out = "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			else
			end

				-- Two branches without else.
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then	-- CA017
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			elseif out ~ "" then
			end

				-- Two branches with else.
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
			elseif out ~ "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then	-- CA017
			else	-- CA017
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			elseif out ~ "" then
			else
			end

				-- Multiple branches without else.
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017
			end
			if out = "" then
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then	-- CA017
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			elseif out ~ "" then
			elseif out < "" then
			end

				-- Multiple branches with else.
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017
			else	-- CA017
			end
			if out = "" then
			elseif out ~ "" then
			elseif out < "" then	-- CA017: invert condition.
			else
				do_nothing
			end
			if out = "" then
			elseif out ~ "" then
			elseif out < "" then
				do_nothing
			else	-- CA017
			end
			if out = "" then
			elseif out ~ "" then
				do_nothing
			elseif out < "" then	-- CA017
			else	-- CA017
			end
			if out = "" then
				do_nothing
			elseif out ~ "" then
			elseif out < "" then	-- CA017
			else	-- CA017
			end
			if out = "" then	-- CA017: the whole instruction can be removed.
			elseif out ~ "" then
			elseif out < "" then
			else
			end
		end

end
