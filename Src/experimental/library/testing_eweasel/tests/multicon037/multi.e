class MULTI [G -> {TUPLE [a: COMPARABLE] rename item as item_1 end, TUPLE [b: NUMERIC] rename put as put_2 end}]
feature

g: G

test
    local
		l_comparable: COMPARABLE
	do
		g.put (g.item (1), 1)
		g.a := 5
		g.b := l_comparable
--		g.put (g[1], 1)
		g := g
	end
end

