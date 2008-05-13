
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class A

feature

	f (a_arg: ARRAY [like item]) is
		do
			$INST
			print (a_arg.generating_type)
			print ("%N")
		end

	g (a_arg: TUPLE [like item, like item]) is
		do
			$INST
			print (a_arg.generating_type)
			print ("%N")
		end

	item: X [like toto]

	toto: A

end
