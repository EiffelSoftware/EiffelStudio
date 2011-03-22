class TEST

create
	make

feature {NONE} -- Creation

        make
        	local
        		b: BOOLEAN
        		t: TEST
		do
			t := f1
			t := f2
			t := f3
			t := f4
			t := f5
			b := g1
			b := g2
			b := g3
			b := g4
			b := g5
		end

feature -- Access

	f1: TEST
		once
			Result := Current
		end

	f2: TEST
		once ("OBJECT")
			Result := Current
		end

	f3: TEST
		once ("THREAD")
			Result := Current
		end

	f4: TEST
		once ("PROCESS")
			Result := Current
		end

	f5: TEST
		note
			once_status: "global"
		once
			Result := Current
		end

	g1: BOOLEAN
		once
		end

	g2: BOOLEAN
		once ("OBJECT")
		end

	g3: BOOLEAN
		once ("THREAD")
		end

	g4: BOOLEAN
		once ("PROCESS")
		end

	g5: BOOLEAN
		note
			once_status: "global"
		once
		end

end
