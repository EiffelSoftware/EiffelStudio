class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		local
			a: PROCEDURE [ANY, TUPLE]
			f_a: FUNCTION [ANY, TUPLE, ANY]
			f_i: FUNCTION [ANY, TUPLE, INTEGER]
			f_b: FUNCTION [ANY, TUPLE, BOOLEAN]
			i: INTEGER
			b: BOOLEAN
			s: ANY
		do
			a := agent print ("TEST")
			a.call (Void)
			io.put_new_line

			f_a := agent default
			s := f_a.item (Void)

			f_b := agent is_equal (Current)
			b := f_b.item (Void)

			a := agent copy (Current)
			a.call (Void)

			a := agent (x: INTEGER) do end
			a.call ([1])

			f_i := agent (x: INTEGER): INTEGER do io.put_string (x.out) end
			i := f_i.item ([12])
			io.put_new_line

			f_a := agent (x: INTEGER): STRING do io.put_string (x.out) end
			s := f_a.item ([21])
			io.put_new_line

			f_b := agent {LINKED_LIST [INTEGER]}.before
			b := f_b.item ([create {LINKED_LIST [INTEGER]}.make])

			a := agent {LINKED_LIST [ANY]}.extend
			a.call ([create {LINKED_LIST [INTEGER]}.make, "STRING"])

			a := agent {ARRAYED_LIST [INTEGER]}.extend
			a.call ([create {ARRAYED_LIST [INTEGER]}.make (10), 12])

			a := agent {ARRAYED_LIST [ANY]}.extend
			a.call ([create {ARRAYED_LIST [ANY]}.make (10), "STRING"])
		end

end
