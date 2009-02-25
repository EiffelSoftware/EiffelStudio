class
	TEST

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			atta: ANY
			deta: detachable ANY
		do
			if attached deta then print ("1%N") end
			if attached {INTEGER_32} 1 then print ("2%N") end
			if attached {INTEGER_32}.max_value then print ("3%N") end

			if attached deta as y then print ("4%N") end
			if attached {INTEGER_32} 2 as y then print ("5%N") end
			if attached {INTEGER_32}.max_value as y then print ("6%N") end

			if attached {STRING} deta then print ("7%N") end
			if attached {STRING} deta as w then print ("8%N") end
			if attached {STRING} 1 as w then print ("9%N") end

			if attached {STRING} {INTEGER_32} 1 as w then print ("10%N") end
			if attached {STRING} {INTEGER_32}.max_value as w then print ("11%N") end

			deta := f

			if attached deta then print ("12%N") end
			if attached {PATH_NAME} deta then print ("13%N") end
			if attached {STRING} deta then print ("14%N") end
			if attached {PATH_NAME} deta as y then print ("15 - " + y + "%N") end
			if attached {STRING} deta as y then print ("16 - " + y + "%N") end
			if attached deta as y then print ("17 - " + y.out + "%N") end
			if attached deta as w then print ("18 - " + w.out + "%N") end
		end

	is_equal (o: like Current): BOOLEAN
		do
			Result := attached Precursor (o)
			Result := attached Precursor (o) as p
			Result := attached {STRING} Precursor (o)
			Result := attached {STRING} Precursor (o) as p
		end

	f: detachable STRING
		do
			create Result.make (10)
			Result.append ("TEST")
		end

	g (o: ANY; u: STRING; i: INTEGER; b: BOOLEAN): ANY
		do
			Result := ""
		ensure
			e1: attached o
			e2: attached o as x
			e3: attached {STRING} o
			e4: attached {STRING} o as x
			e5: attached old o
			e6: attached old o as x
			e7: attached {STRING} old o
			e7: attached {STRING} old o as x

			e1: attached (o)
			e2: attached (o) as x
			e3: attached {STRING} (o)
			e4: attached {STRING} (o) as x
			e5: attached (old o)
			e6: attached (old o) as x
			e7: attached {STRING} (old o)
			e7: attached {STRING} (old o) as x

$COMMENT			e1: attached u + u
$COMMENT			e3: attached {STRING} u + u
			e1: attached (u + u)
			e2: attached (u + u) as w
			e3: attached {STRING} (u + u)
			e4: attached {STRING} (u + u) as w

$COMMENT			e1: attached old u + u
$COMMENT			e3: attached {STRING} old u + u
$COMMENT			e1: attached old u + old u
$COMMENT			e3: attached {STRING} old u + old u
			e1: attached old (u + u)
			e2: attached old (u + u) as w
			e3: attached {STRING} old (u + u)
			e4: attached {STRING} old (u + u) as w

			e1: attached -i
			e2: attached -i as j
			e3: attached {STRING} -i
			e4: attached {STRING} -i as j
			e5: attached old -i
			e6: attached old -i as x
			e7: attached {STRING} old -i
			e7: attached {STRING} old -i as j

			e1: attached not b
			e1: attached not b as c
			e1: attached {STRING} not b
			e1: attached {STRING} not b as c
			e1: attached old not b
			e1: attached old not b as c
			e1: attached {STRING} old not b
			e1: attached {STRING} old not b as c

			e1: attached o = u
			e1: attached o ~ u
			e1: attached o /= u
			e1: attached o /~ u
			e1: attached {STRING} o = u
			e1: attached {STRING} o ~ u
			e1: attached {STRING} o /= u
			e1: attached {STRING} o /~ u

			a1: attached agent f
			a1: attached agent f as p
			a1: attached {STRING} agent f
			a1: attached {STRING} agent f as p

			e1: attached g ([attached o, attached u, attached i, attached b], "", 4, True)
			e1: attached g ([attached o, attached u, attached i, attached b], "", 4, True) as bool
			e1: attached {STRING} g ([attached o, attached u, attached i, attached b], "", 4, True)
			e1: attached {STRING} g ([attached o, attached u, attached i, attached b], "", 4, True) as bool

			e1: attached g (<<attached o, attached u, attached i, attached b>>, "", 4, True)
			e1: attached g (<<attached o, attached u, attached i, attached b>>, "", 4, True) as bool
			e1: attached {STRING} g (<<attached o, attached u, attached i, attached b>>, "", 4, True)
			e1: attached {STRING} g (<<attached o, attached u, attached i, attached b>>, "", 4, True) as bool

			b1: attached u [1]
			b1: attached u [1] as c
			b1: attached {STRING} u [1]
			b1: attached {STRING} u [1] as c

			c1: attached Current
			c1: attached Current as cur
			c1: attached {STRING} Current
			c1: attached {STRING} Current as cur

			c1: attached Current.f
			c1: attached Current.f as cur
			c1: attached {STRING} Current.f
			c1: attached {STRING} Current.f as cur

			e1: attached u implies u.is_empty
			e1: attached u as w implies w.is_empty
			e1: attached {STRING} u implies u.is_empty
			e1: attached {STRING} u as w implies w.is_empty

			e1: attached attached o
			e2: attached attached o as x
			e3: attached attached {STRING} o
			e4: attached attached {STRING} o as x
			e5: attached attached old o
			e6: attached attached old o as x
			e7: attached attached {STRING} old o
			e8: attached attached {STRING} old o as x

			e1: attached attached (o)
			e2: attached attached (o) as x
			e3: attached attached {STRING} (o)
			e4: attached attached {STRING} (o) as x
			e5: attached attached (old o)
			e6: attached attached (old o) as x
			e7: attached attached {STRING} (old o)
			e8: attached attached {STRING} (old o) as x

		end

end
