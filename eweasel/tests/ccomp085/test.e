

class TEST
create
	make
feature
	
	make
		do
			c_code_first
			c_code_second
		end
	
	c_code_first
			-- Important to parse "a.h" first.
		external
			"C use a.h"
		alias
			"c_function_a"
		end
		
	c_code_second
		external
			"C use b.h, a.h"
		alias
			"c_function"
		end

end
