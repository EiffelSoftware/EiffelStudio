class TEST 
create
	make
feature

	make
		local
			ta: TEST1 [A]
			tb: TEST1 [B]
			tc: TEST1 [C]
			tva: TEST1 [variant A]
			tvb: TEST1 [variant B]
			tvc: TEST1 [variant C]
			la: MY_LIST [frozen A]
			lb: MY_LIST [frozen B]
			lc: MY_LIST [frozen C]
			a: frozen A
			b: frozen B
			c: frozen C
		do
			create a
			create b
			create c

			create {MY_ARRAYED_LIST [frozen B]} la.make (1)	-- Catcall conformance issue: VGCC(3)
			la.extend (a)

			create {MY_ARRAYED_LIST [frozen A]} la.make (1)
			la.extend (a)
			create {MY_ARRAYED_LIST [frozen B]} lb.make (1)
			lb.extend (b)
			create {MY_ARRAYED_LIST [frozen C]} lc.make (1)
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

			tb.arrayed_list.extend (a)		-- Rejected by normal conformance: VUAR(2)
			tb.arrayed_list.extend (b)
			tb.arrayed_list.extend (c)		-- Rejected by normal conformance: VUAR(2)

			tc.arrayed_list.extend (a)		-- Rejected by normal conformance: VUAR(2)
			tc.arrayed_list.extend (b)		-- Rejected by normal conformance: VUAR(2)
			tc.arrayed_list.extend (c)

			ta.set_item (a)
			ta.set_item (b)
			ta.set_item (c)

			ta.set_lists (la, la)
			ta.operate

			ta.set_lists (la, lb)	-- Catcall conformance rejection: VUAR(2)
			ta.operate

			ta.set_lists (la, lc)	-- Catcall conformance rejection: VUAR(2)
			ta.operate

			ta := tb	-- Catcall conformance rejection: VJAR
			ta := tc	-- Catcall conformance rejection: VJAR
			tb := tc	-- Normal conformance rejection: VJAR

			tva := tvb
			tva := tvc
			tvb := tvc	-- Normal conformance rejection: VJAR

			tva.arrayed_list.extend (a) -- Catcall error, non monomorphic actual generic: Catcall
			tva.arrayed_list.extend (b) -- Catcall error, non monomorphic actual generic: Catcall
			tva.arrayed_list.extend (c) -- Catcall error, non monomorphic actual generic: Catcall

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

				-- We should fix the compiler to only report only VUAR(2) and no Catcall.
			tvb.arrayed_list.extend (a)		-- Rejected by normal conformance: VUAR(2), Catcall
			tvb.arrayed_list.extend (b)		-- Catcall error, non monomorphic actual generic: Catcall
			tvb.arrayed_list.extend (c)		-- Rejected by normal conformance: VUAR(2), Catcall

			tvc.arrayed_list.extend (a)		-- Rejected by normal conformance: VUAR(2), Catcall
			tvc.arrayed_list.extend (b)		-- Rejected by normal conformance: VUAR(2), Catcall
			tvc.arrayed_list.extend (c)		-- Catcall error, non monomorphic actual generic: Catcall

			tva.set_item (a)	-- Catcall rejection since variant: Catcall
			tva.set_item (b)	-- Catcall rejection since variant: Catcall
			tva.set_item (c)	-- Catcall rejection since variant: Catcall

			tva.set_lists (la, lb)
			tva.operate

			tva.set_lists (lb, lc)
			tva.operate

			tva.set_lists (lc, lb)
			tva.operate
		end

end
