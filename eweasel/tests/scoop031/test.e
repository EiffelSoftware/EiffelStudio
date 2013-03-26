class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: separate A
		do
			create a.make (1)
			initialize (a)
			show (item, next)
			advance (move)
			show (item, next)
			wait (real)
		end

feature {NONE} -- Access

	item: separate FUNCTION [ANY, TUPLE, INTEGER]
	next: separate FUNCTION [ANY, TUPLE, INTEGER]
	move: separate PROCEDURE [ANY, TUPLE]
	real: separate FUNCTION [ANY, TUPLE, REAL_64]

	initialize (a: separate A)
		do
			item := agent a.item
			next := agent (x: separate A): INTEGER do Result := x.next end (a)
			move := agent a.advance
			real := agent a.real_value
		end

feature -- Output

	show (i, n: like item)
		do
			io.put_integer (i.item ([]))
			io.put_character (':')
			io.put_integer (n.item ([]))
			io.put_new_line
		end

feature -- Modification

	advance (m: like move)
		do
			m.call ([])
		end

feature -- Waiting

	wait (r: like real)
		local
			x: REAL_64
		do
			x := r.item ([])
		end

end
