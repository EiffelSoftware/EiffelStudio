once class PLANET

create
	Mercury,
	Venus,
	Earth,
	Mars,
	Jupiter,
	Saturn,
	Uranus,
	Neptune

feature {NONE} -- Creation

	Mercury once mass := 3.303e+23; radius := 2.4397e6 end
	Venus once mass := 4.869e+24; radius := 6.0518e6 end
	Earth once mass := 5.976e+24; radius := 6.37814e6 end
	Mars once mass := 6.421e+23; radius := 3.3972e6 end
	Jupiter once mass := 1.900e+27; radius := 7.1492e7 end
	Saturn once mass := 5.688e+26; radius := 6.0268e7 end
	Uranus once mass := 8.686e+25; radius := 2.5559e7 end
	Neptune once mass := 1.024e+26; radius := 2.4746e7 end

feature -- Access

	instances: ITERABLE [PLANET]
			-- All known planets.
		once
			Result := <<
					create {PLANET}.Mercury,
					create {PLANET}.Venus,
					create {PLANET}.Earth,
					create {PLANET}.Mars,
					{PLANET}.Jupiter,
					{PLANET}.Saturn,
					{PLANET}.Uranus,
					{PLANET}.Neptune
				>>
		ensure
			instance_free: class
		end

feature -- Access

	name: STRING
		do
				Result :=
					inspect Current
					when {PLANET}.Mercury then "Mercury"
					when {PLANET}.Venus then "Venus"
					when {PLANET}.Earth then "Earth"
					when {PLANET}.Mars then "Mars"
					when {PLANET}.Jupiter then "Jupiter"
					when {PLANET}.Saturn then "Saturn"
					when {PLANET}.Uranus then "Uranus"
					when {PLANET}.Neptune then "Neptune"
					else
						"Unknown"
					end
		end

feature -- Measurement

	mass: REAL_64
			-- Planet mass.

	radius: REAL_64
			-- Planet radius.

	surface_gravity: REAL_64
		do
			Result := G * mass / (radius * radius)
		end

	surface_weight (other_mass: REAL_64): REAL_64
		do
			Result := other_mass * surface_gravity
		end

feature {NONE} -- Constants

    G: REAL_64 = 6.67300E-11
		-- Universal gravitational constant.

end
