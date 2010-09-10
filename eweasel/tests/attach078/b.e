class
	B

inherit
	A [ANY]
		redefine
			f
		end

feature

	f (a: detachable ANY)
		do
		end

end