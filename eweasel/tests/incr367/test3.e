
class TEST3
inherit
	TEST2
		redefine
			default_create
		end
feature
	default_create
		do
			print ("Stoat%N")
		end
end
