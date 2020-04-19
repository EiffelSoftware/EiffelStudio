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
			i: INTEGER
		do
			agent_f := agent {TEST}.f
			if attached deta then print ("1%N") end
			i := 1
			if attached {INTEGER_32} i then print ("2%N") end
			if attached {INTEGER_32}.max_value then print ("3%N") end

			if attached deta as y then print ("4%N") end
			i := 2
			if attached {INTEGER_32} i as y then print ("5%N") end
			if attached {INTEGER_32}.max_value as y then print ("6%N") end

			if attached {STRING} deta then print ("7%N") end
			if attached {STRING} deta as w then print ("8%N") end
			i := 1
			if attached {STRING} i as w then print ("9%N") end

			i := {INTEGER_32} 1
			if attached {STRING} i as w then print ("10%N") end
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

	agent_f: ROUTINE [ANY, TUPLE]

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
			e2: attached o as x2
			e3: attached {STRING} o
			e4: attached {STRING} o as x4
			e5: attached old o
			e6: attached old o as x6
			e7: attached {STRING} old o
			e8: attached {STRING} old o as x7

			p1: attached (o)
			p2: attached (o) as y2
			p3: attached {STRING} (o)
			p4: attached {STRING} (o) as y4
			p5: attached (old o)
			p6: attached (old o) as y6
			p7: attached {STRING} (old o)
			p8: attached {STRING} (old o) as y7

$COMMENT			s1: attached u + u
$COMMENT			s2: attached {STRING} u + u
			s3: attached (u + u)
			s4: attached (u + u) as w2
			s5: attached {STRING} (u + u)
			s6: attached {STRING} (u + u) as w4

$COMMENT			o1: attached old u + u
$COMMENT			o2: attached {STRING} old u + u
$COMMENT			o3: attached old u + old u
$COMMENT			o4: attached {STRING} old u + old u
			o5: attached old (u + u)
			o6: attached old (u + u) as v2
			o7: attached {STRING} old (u + u)
			o8: attached {STRING} old (u + u) as v4

			i1: attached -i
			i2: attached -i as j2
			i3: attached {STRING} -i
			i4: attached {STRING} -i as j4
			i5: attached old -i
			i6: attached old -i as j6
			i7: attached {STRING} old -i
			i8: attached {STRING} old -i as j7

			b1: attached not b
			b2: attached not b as c1
			b3: attached {STRING} not b
			b4: attached {STRING} not b as c2
			b5: attached old not b
			b6: attached old not b as c6
			b7: attached {STRING} old not b
			b8: attached {STRING} old not b as c7

			q1: attached o = u
			q2: attached o ~ u
			q3: attached o /= u
			q4: attached o /~ u
			q5: attached {STRING} o = u
			q6: attached {STRING} o ~ u
			q7: attached {STRING} o /= u
			q8: attached {STRING} o /~ u

			a1: attached agent_f
			a2: attached agent_f as p1
			a3: attached {STRING} agent_f
			a4: attached {STRING} agent_f as p2

			f1: attached g ([attached o, attached u, attached i, attached b], "", 4, True)
			f2: attached g ([attached o, attached u, attached i, attached b], "", 4, True) as bool1
			f3: attached {STRING} g ([attached o, attached u, attached i, attached b], "", 4, True)
			f4: attached {STRING} g ([attached o, attached u, attached i, attached b], "", 4, True) as bool2

			f5: attached g (<<attached o, attached u, attached i, attached b>>, "", 4, True)
			f6: attached g (<<attached o, attached u, attached i, attached b>>, "", 4, True) as bool3
			f7: attached {STRING} g (<<attached o, attached u, attached i, attached b>>, "", 4, True)
			f8: attached {STRING} g (<<attached o, attached u, attached i, attached b>>, "", 4, True) as bool4

			d1: attached u [1]
			d2: attached u [1] as d1
			d3: attached {STRING} u [1]
			d4: attached {STRING} u [1] as d2

			-- c1: attached Current -- Reported as syntax error
			-- c2: attached Current as cur1 -- Reported as syntax error
			c3: attached {STRING} Current
			c4: attached {STRING} Current as cur2

			t1: attached Current.f
			t2: attached Current.f as cur3
			t3: attached {STRING} Current.f
			t4: attached {STRING} Current.f as cur4

			w1: attached u implies u.is_empty
			w2: attached u as w implies w.is_empty
			w3: attached {STRING} u implies u.is_empty
			w4: attached {STRING} u as w implies w.is_empty

			v1: attached u and then u.is_empty
			v2: attached u as wa and then wa.is_empty
			v3: attached {STRING} u and then u.is_empty
			v4: attached {STRING} u as wb and then wb.is_empty

			n1: not attached u or else u.is_empty
			n2: not attached u as wc or else wc.is_empty
			n3: not attached {STRING} u or else u.is_empty
			n4: not attached {STRING} u as wd or else wd.is_empty
		end

end
