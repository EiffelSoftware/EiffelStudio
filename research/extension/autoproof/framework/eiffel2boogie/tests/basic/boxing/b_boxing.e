class B_BOXING

feature

	boxing
		local
			a1, a2: ANY
			b: BOOLEAN
			i: INTEGER
		do
			b := False
			a1 := True
			a2 := b

			if attached {BOOLEAN} a1 as l_b1 and attached {BOOLEAN} a2 as l_b2 then
				check l_b1 end
				check not l_b2 end
			else
				check unreachable: False end
			end

			i := 17
			a1 := 4
			a2 := i

			if attached {INTEGER} a1 as l_i1 and attached {INTEGER} a2 as l_i2 then
				check l_i1 = 4 end
				check l_i2 = 17 end
			else
				check unreachable: False end
			end

			check has_to_fail: False end
		end

end
