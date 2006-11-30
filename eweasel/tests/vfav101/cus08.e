class C

inherit
	A
	B
		redefine
			f0
		end

feature

	f0 alias "+": BOOLEAN is
		do
		end

end