indexing
	author: "Zoran Simic"

class
	TEST
create
	make

feature
	make is
		do
			test_reverse_assignment ("123")
		end

	test_reverse_assignment (a_hashable: HASHABLE) is
	   local
		  l_tuple: TUPLE
		  l_string: STRING
		  i: INTEGER
	   do
		  i := 2
		  l_string ?= a_hashable
		  if l_string /= Void then
			 print (l_string)
			 print ("%N")
			 print (l_string + "%N")   --bad
		  end
		  l_string ?= 11   --bad
		  if l_string /= Void then
			 print (l_string)
			 print ("%N")
			 print (l_string + "%N")   --bad
		  end
		  l_string ?= i   --bad
		  if l_string /= Void then
			 print (l_string)
			 print ("%N")
			 print (l_string + "%N")   --bad
		  end

		  l_tuple ?= a_hashable
		  if l_tuple /= Void then
			 print (l_tuple.object_comparison) 	-- bad
			 print ("%N")
		  end
		  l_tuple ?= 11   --bad
		  if l_tuple /= Void then
			 print (l_tuple.object_comparison)   --bad
			 print ("%N")
		  end
		  l_tuple ?= i   --bad
		  if l_tuple /= Void then
			 print (l_tuple.object_comparison)   --bad
			 print ("%N")
		  end

	   end

end
