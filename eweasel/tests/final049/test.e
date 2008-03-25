class TEST
create

	make

feature

	make is
		local
			a_any: A [ANY]
			a_integer: A [INTEGER]
			b_integer: B [INTEGER]
			i: INTEGER
			a: ANY
		do
			create b_integer
			a_integer := b_integer
			i := a_integer.item (1)
			i := a_integer.item (i)
			i := a_integer.item (i - 1)
			i := a_integer.item_bis (1)
			i := a_integer.item_bis (i)
			i := a_integer.item_bis (i - 1)
			i := b_integer.item (1)
			i := b_integer.item (i)
			i := b_integer.item (i - 1)
			i := b_integer.item_bis (1)
			i := b_integer.item_bis (i)
			i := b_integer.item_bis (i - 1)

			a_any := a_integer
			i := a_any.item (1)
			i := a_any.item (i)
			i := a_any.item (i - 1)
			a := a_any.item_bis (1)
			a := a_any.item_bis (i)
			a := a_any.item_bis (i - 1)
			i ?= a_any.item_bis (1)
			i ?= a_any.item_bis (i)
			i ?= a_any.item_bis (i - 1)
		end

end

