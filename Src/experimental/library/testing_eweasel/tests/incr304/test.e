
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST
create
	make

feature {NONE}

	make is
		do
			x := ({NONE}).attempt ("Weasel")
			if x /= Void then
				print ("Value is not Void%N")
				print (x)
				print ("%N")
			else
				print ("Value is Void%N")
			end
		end

	x: NONE
end
