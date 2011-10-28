
class TEST2 [G -> TEST create make end]
inherit
	TEST3 [G]
	
feature

	y: TEST
	   deferred
	   end

end

