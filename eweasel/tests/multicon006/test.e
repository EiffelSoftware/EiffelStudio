
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
	TEST
creation	
	make
feature
	make  is
			-- foo
		local
			l_multi_integer: MULTI[INTEGER]
			l_multi_integer_ref: MULTI[INTEGER_REF]
			l_tuple_integer: TUPLE[i: INTEGER]
			l_tuple_integer_ref: TUPLE[i: INTEGER_REF]
		do
			create l_multi_integer
			l_multi_integer.set_g(3)
			l_multi_integer.set_tuple ([l_multi_integer.g])
			l_tuple_integer := l_multi_integer.tuple
			print (l_tuple_integer.i)
			l_tuple_integer_ref := l_multi_integer.proc_tuple
			print (l_tuple_integer.i)
			print ( l_multi_integer.tuple.g)
			print ( l_multi_integer.proc_tuple.h)

			
			create l_multi_integer_ref
			l_multi_integer_ref.set_g(7)
			l_multi_integer_ref.set_tuple ([l_multi_integer_ref.g])
			l_tuple_integer_ref := l_multi_integer_ref.tuple
			print (l_tuple_integer_ref.i)
			l_tuple_integer_ref := l_multi_integer_ref.proc_tuple
			print (l_tuple_integer_ref.i)
			print ( l_multi_integer_ref.tuple.g)
			print ( l_multi_integer_ref.proc_tuple.h)

			l_tuple_integer_ref := l_multi_integer_ref.tuple
			print (l_tuple_integer_ref.i)
			print ("%N")
		end	
end
