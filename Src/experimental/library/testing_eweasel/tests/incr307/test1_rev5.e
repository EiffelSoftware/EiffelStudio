
class TEST1 [G -> ANY create default_create end, H -> TEST rename hamster as turkey alias "+" end, I -> TEST2 [G, H] create make end]

create
	make
feature

	make (n: H)
		do
			z := n
		end

	try
		require
			ok: (agent (a: like y b: like z): BOOLEAN do Result := a = y and b = z end).item ([y, z])
		local
			x: G
		do
			print ("Entering try%N")
			create x
			print (z + 3); io.new_line
			print (z.turkey (4)); io.new_line
			print ("Leaving try%N")
		end
	y: G
	z: H

end
