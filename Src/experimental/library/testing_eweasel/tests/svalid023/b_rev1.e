class B

inherit
	A
		redefine
			f
		end

feature

	f (b: detachable B)
		do
		end

end
