
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.


indexing

	description: "Demonstrates run-time bug in assignment attempt"

class TEST

creation

	make

feature

	make is
		local
			a1: A1
			a2: A2
			b: B2
		do
			create b
			create a1
			a1.attempt (b)
			create a2
			a2.attempt (b)
			if a1.entity /= Void then
				print ("Ooops - a1.entity should be Void%N")
				a1.entity.call1
			end
		end

end
