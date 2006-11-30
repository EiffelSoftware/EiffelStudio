
class TEST
inherit
	TEST1 $ACTUAL
		redefine
			make
		end
create
	make
feature
	
	make is
		local
			t: HASH_TABLE [TEST1 $ACTUAL, STRING]
		do
			create t.make (10)
			t.put (create {TEST1 $ACTUAL}, "Weasel")
		end

end
