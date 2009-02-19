
class TEST2 [G -> ANY create default_create end]

create
	make, make_from_generic
convert
	make_from_generic ({G}),
	to_generic: {G}

feature
	make
		do
			create z
		end

	make_from_generic (x: G)
		do
			print ("In make_from_generic%N")
			create z
		end

	to_generic: G
		do
			print ("In to_generic%N")
			create z
			create Result
		end

	z: G
end
