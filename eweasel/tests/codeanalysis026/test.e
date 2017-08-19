class TEST

create
	make

feature

	make
			-- Run test.
		do
			f.do_nothing
			g.do_nothing
		end

	f: ANY
			-- Initialize Result from a local of different type.
		local
			i: INTEGER
		do
			Result := i
		end

	g: ANY
			-- Initialize Result from a local of the same type.
		local
			i: detachable ANY
		do
			i := Current
			Result := i -- Warning: CA050
		end

end
