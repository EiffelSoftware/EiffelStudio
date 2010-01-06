
class TEST1 [G -> ANY create default_create end, H -> TEST rename hamster as turkey alias "+" end, I -> TEST2 [G, H] create make end]

create
	make
feature

	make (n: H)
		do
			z := h
		end

	try
		require
			ok: (agent (a: like y b: like z): BOOLEAN do Result := a = y and b = z end).item ([y, z])
		local
			x: G
		do
			create x
			print (z + 3)
		end
	y: G
	z: H

end
