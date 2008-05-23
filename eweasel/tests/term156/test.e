class TEST
inherit
	TEST1
		redefine
			f
		end
create
	make

feature

	make is
			--
		do

		end

	f (a: ANY; b: like a) is
			--
		do
			print ("FDfsdfdsS")
		end

end
