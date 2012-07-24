
class TEST4 [G -> ANY create default_create end]

inherit
	TEST3 [G]
		redefine
			f
		end

feature

	f
		local
			x: G
		do
			create x
			print (x.generating_type); io.new_line
		end

end
