class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run the test.
		do
			f (Current, Current)
		end

feature -- Test

	x1
		do
		end

	f (x2: separate TEST; y: separate TEST)
		local
			x3: detachable separate TEST
		do
			separate y as x1 do end -- Clash with a feature name.
			separate y as x2 do end -- Clash with a feature argument name.
			separate y as x3 do end -- Clash with a feature local name.
			(agent (x4: detachable separate TEST; z: separate TEST)
				local
					x5: detachable separate TEST
				do
					separate z as x4 do end -- Clash with an agent argument name.
					separate z as x5 do end -- Clash with an agent local name.
				end
			(Void, Current)).do_nothing
			if attached y as x6 then
				separate y as x6 do end -- Clash with an object test local name.
			end
			across
				out as x7
			loop
				separate y as x7 do end -- Clash with a loop cursor name.
			end
			separate y as x8 do
				separate y as x8 do end -- Clash with an inline separate argument name.
			end
			separate y as x9, y as x9 do end -- Clash with an inline separate argument name.
		end

end
