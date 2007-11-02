class TEST 
create
	make
feature

	make is
		local
			ta: TEST1 [A]
			tb: TEST1 [B]
			tc: TEST1 [C]
			tva: TEST1 [variant A]
			tvb: TEST1 [variant B]
			tvc: TEST1 [variant C]
			la: LIST [A]
			lb: LIST [B]
			lc: LIST [C]
			a: A
			b: B
			c: C
		do
			create a
			create b
			create c

--			create {ARRAYED_LIST [B]} la.make (1)	-- Catcall conformance issue
			la.extend (a)

			create {ARRAYED_LIST [A]} la.make (1)
			la.extend (a)
			create {ARRAYED_LIST [B]} lb.make (1)
			lb.extend (b)
			create {ARRAYED_LIST [C]} lc.make (1)
			lc.extend (c)

			create ta.make
			create tb.make
			create tc.make

			create tva.make
			create tvb.make
			create tvc.make

			ta.arrayed_list.extend (a)
			ta.arrayed_list.extend (b)
			ta.arrayed_list.extend (c)

			print ("List of " + ta.arrayed_list.generating_type.out + "%N")
			ta.arrayed_list.do_all (agent (v: A)
				do
					if v /= Void then
						print ("generating type is " + v.generating_type.out + "%N")
					end
				end)

--			tb.arrayed_list.extend (a)		-- Rejected by normal conformance
			tb.arrayed_list.extend (b)
--			tb.arrayed_list.extend (c)		-- Rejected by normal conformance

--			tc.arrayed_list.extend (a)		-- Rejected by normal conformance
--			tc.arrayed_list.extend (b)		-- Rejected by normal conformance
			tc.arrayed_list.extend (c)

			ta.set_item (a)
			ta.set_item (b)
			ta.set_item (c)

			ta.set_lists (la, la)
			ta.operate

			ta.set_lists (la, lb)	-- Catcall conformance rejection
			ta.operate

			ta.set_lists (la, lc)	-- Catcall conformance rejection
			ta.operate

			ta := tb	-- Catcall conformance rejection
			ta := tc	-- Catcall conformance rejection
--			tb := tc	-- Normal conformance rejection

			tva := tvb
			tva := tvc
--			tvb := tvc	-- Normal conformance rejection

			tva.arrayed_list.extend (a)
			tva.arrayed_list.extend (b)
			tva.arrayed_list.extend (c)

			print ("List of " + tva.arrayed_list.generating_type.out + "%N")
			from
				tva.arrayed_list.start
			until
				tva.arrayed_list.after
			loop
				if tva.arrayed_list.item /= Void then
					print ("generating type is " + tva.arrayed_list.item.generating_type.out + "%N")
				end
				tva.arrayed_list.forth
			end

--			tvb.arrayed_list.extend (a)		-- Rejected by normal conformance
			tvb.arrayed_list.extend (b)
--			tvb.arrayed_list.extend (c)		-- Rejected by normal conformance

--			tvc.arrayed_list.extend (a)		-- Rejected by normal conformance
--			tvc.arrayed_list.extend (b)		-- Rejected by normal conformance
			tvc.arrayed_list.extend (c)

			tva.set_item (a)	-- Catcall rejection since variant
			tva.set_item (b)	-- Catcall rejection since variant
			tva.set_item (c)	-- Catcall rejection since variant

			tva.set_lists (la, lb)	-- Catcall rejection since variant
			tva.operate

			tva.set_lists (lb, lc)	-- Catcall rejection since variant
			tva.operate

			tva.set_lists (lc, lb)	-- Catcall rejection since variant
			tva.operate
		end

end
