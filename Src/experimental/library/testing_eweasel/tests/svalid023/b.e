class B

inherit
	A
		redefine
			f
		end

feature

	f (b: detachable A)
		do
		end

end
