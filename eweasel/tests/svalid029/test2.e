class TEST2
inherit
	TEST1
		rename
			identity as foobar
		redefine
			f
		end

feature

	f (other: like Current)
		do
		end

end
