class TEST

create
	make, make1, make2, make3, make4

feature {NONE} -- Creation

	make
		do
			create a.make1
			create a.make2
			create a.make3
			create a.make4
		end

	make1
		do
				-- Conditional instruction.
			if x then
				f
			else
				g
			end
		end

	make2
		do
				-- Conditional instruction.
			if x then
				f
			elseif y then
				g
			else
				h
			end
		end

	make3
		local
			t: TEST
		do
				-- Conditional expression.
			t :=
				if x then
					ff
				else
					gg
				end
		end

	make4
		local
			t: TEST
		do
				-- Conditional expression.
			t :=
				if x then
					ff
				elseif y then
					gg
				else
					hh
				end
		end

feature -- Access

	a: TEST

feature {NONE} -- Initialization

	f
		do
			$(F)a := Current
		end

	g
		do
			$(G)a := Current
		end

	h
		do
			$(H)create a.make
		end

	ff: TEST
		do
			$(F)a := Current
			Result := Current
		end

	gg: TEST
		do
			Result := Current
			$(G)a := Current
		end

	hh: TEST
		do
			Result := Current
			$(H)create a.make
		end

feature {NONE} -- Access

	x, y: BOOLEAN
		do
		end

end