class EXTEND_STACK [T] 

inherit

	ARRAYED_STACK [T]
		rename
			make as basic_make,
			put as fixed_stack_put
		end;

	ARRAYED_STACK [T]
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
			array_make (1, Chunk)
		end;

	put (v: like item) is
			-- Put `v' onto the stack.
		require else
			True
		do
			if count >= capacity then
				resize (lower, upper + Chunk)
			end;
			fixed_stack_put (v)
		end;

	
feature {NONE}

	Chunk: INTEGER is 50;
			-- Default size of the stack

end
