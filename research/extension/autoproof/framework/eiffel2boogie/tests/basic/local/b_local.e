class B_LOCAL

feature

	default_values_for_local
		local
			a: INTEGER
			b: NATURAL
			c: REAL_64
			d: BOOLEAN
			e: ANY
		do
			check a = 0 end
			check b = 0 end
			check c = 0.0 end
			check d = False end
			check e = Void end
		end

	local_initialization
		local
			a: INTEGER
			b: NATURAL
			c: REAL_64
			d: BOOLEAN
			e: ANY
		do
			a := 1
			b := 2
			c := 3.4
			d := True
			e := Current

			check a = 1 end
			check b = 2 end
			check c = 3.4 end
			check d = True end
			check e = Current end
		end

	local_assignment
		local
			a, b: INTEGER
			c, d: ANY
		do
			a := 1
			b := 2
			a := b
			check a = 2 end
			c := Void
			d := Current
			c := d
			check c = Current end
		end

	argument_assignment (a: INTEGER; b: ANY)
		require
			a = 3
			b = Current
		local
			c: INTEGER
			d: ANY
		do
			c := a
			check c = 3 end
			d := b
			check d = Current end
		end

end
