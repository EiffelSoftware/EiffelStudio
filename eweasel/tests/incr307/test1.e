
class TEST1 [G -> ANY create default_create end, H, I -> TEST2 [G, H] create make end]

feature

	try
		require
			ok: (agent (a: like y b: like z): BOOLEAN do Result := a = y and b = z end).item ([y, z])
		local
			x: G
		do
			create x
		end
	y: G
	z: H

end
