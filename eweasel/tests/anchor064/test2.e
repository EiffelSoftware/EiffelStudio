class TEST2 [G -> ANY create default_create end]

inherit
	TEST1 [G]
		redefine
			f
		end
feature
	f
		do
		end

end
