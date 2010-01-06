class C

inherit
	B
		redefine
			f0
		end

feature

	f0 alias "+" convert: BOOLEAN is
		do
		end

end