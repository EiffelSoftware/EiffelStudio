class EXTEND_STACK [T] 

inherit

	FIXED_STACK [T]
		rename
			make as basic_make,
			put as fixed_stack_put
		end;

	FIXED_STACK [T]
		rename
			make as basic_make
		redefine
			put
		select
			put
		end

creation

	make
	
feature 

	make is
		do
			basic_make (Chunk)
		end;

	put (v: like item) is
			-- Put `v' onto the stack.
		do
			if count >= max_size then
				resize (lower, upper + Chunk)
			end;
			fixed_stack_put (v)
		end;

	
feature {NONE}

	Chunk: INTEGER is 50;
			-- Default size of the stack

end
