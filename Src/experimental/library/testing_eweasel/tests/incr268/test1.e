
class TEST1 [G]
inherit
	ANY
		redefine
			default_create
		end
create
	default_create
feature
	default_create is
		do
			precursor
			print ("In TEST1 create%N")
		end

	value: G

	val: INTEGER

end
