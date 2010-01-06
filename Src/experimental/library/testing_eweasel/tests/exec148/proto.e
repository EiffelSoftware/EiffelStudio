
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class PROTO [S -> SUBJECT, T]
	
feature
		
	set_func (aspf: FUNCTION [S, TUPLE[S], T]) is
		do
			create func
			print (func.generating_Type)
			print ("%N")
			print (aspf.generating_type)
			print ("%N")
			func ?= aspf
		ensure
			-- Note that 'aspf' is of the same type as 'func', therefore:
			proper_function_provided: aspf /= Void implies func /= Void
		end

feature -- Access
	
	func: FUNCTION [S, TUPLE[S], T]
		
end -- class PROTO
