
-- Built from the parser

class CLICK_LIST

inherit
	CONSTRUCT_LIST [CLICK_AST]
		export
			{ANY} area, lower, upper
		end

creation
	make, make_filled
	
feature 

	trace is
		local
			i: INTEGER;
		do
			io.error.putstring ("Click list is:%N");
			io.error.putstring (tagged_out);
			io.error.putstring ("Content is:%N");
			from
			until
				i = count
			loop
				i := i + 1;
				io.error.putstring (i_th (i).tagged_out)
			end
		end

end
