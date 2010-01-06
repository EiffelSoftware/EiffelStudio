
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.  Compiler dies with exception trace.

class 
	TEST
creation	
	make
feature
	
	make is 
		do
			print	(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(my_clone(my_clone(my_clone(my_clone(my_clone
				(Current))))))))))))))))))))))
				))))))))))))))))))))))))))))))
				))))))))))))))))))))))))))))))
				))))))))))))))))))$PAREN;
		end;

	my_clone (x: ANY): like x is
		do
			if x /= Void then
				Result := x.twin
			end
		end

end
