
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature

	make is
		local
			b: B
			d: D
			e: E
			i: INTEGER
			l_array_b: ARRAY [B]
			l_array_d: ARRAY [D]
		do
			b := a
			d := a
			b := e
			d := e

			b ?= a
			d ?= a
			b ?= e
			d ?= e

			Current.item_b := a
			Current.item_d := a

			i := b + a
			i := d + a

			f (a, b)
			g (a, d)

			l_array_b := << a, b >>
			l_array_d := << a, d >>

			if a = b or a /= b then
			end
			if a = d or a /= d then
			end

			if a ~ b or a /~ b then
			end
			if a ~ d or a /~ d then
			end

			if b = a or b /= a then
			end
			if d = a or d /= a then
			end

			if b ~ a or b /~ a then
			end
			if d ~ a or d /~ a then
			end

		end

	f (b1, b2: B) is
		do
		end

	item_b: B assign put_b

	put_b (v: B) is
		do

		end

	item_d: D assign put_d

	put_d (v: D) is
		do

		end

	g (d1, d2: D) is
		do
		end

	a: A

end
