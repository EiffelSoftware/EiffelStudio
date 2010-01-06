
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create

	make

feature

	make is
		do
			test_like_feature
			test_like_argument ("STRING")
			test_like_current
		end
		
	test_like_feature is
		local
			t: TUPLE [like i, INTEGER, INTEGER]
			a: ANY
		do
			a := [i, 0, 1]
			t ?= a
			if t /= Void then
				print ("Ok%N")
			else
				print ("Not Ok%N")
			end
		end
		
	test_like_current is
		local
			t: TUPLE [like Current, INTEGER, INTEGER]
			a: ANY
		do
			a := [Current, 0 , 0]
			t ?= a
			if t /= Void then
				print ("Ok%N")
			else
				print ("Not Ok%N")
			end
		end

	test_like_argument (arg: STRING) is
		local
			t: TUPLE [like arg, INTEGER, INTEGER]
			a: ANY
		do
			a := [arg, 0 , 0]
			t ?= a
			if t /= Void then
				print ("Ok%N")
			else
				print ("Not Ok%N")
			end
		end
		

	i: ARRAY [STRING] is
		do
			create Result.make (0, 1)
		end

end

