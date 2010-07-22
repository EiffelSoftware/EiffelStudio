

class TEST
create
	make
feature
	
	make
		do
			c_code
		end
	
	c_code
		external
			"C use b.h, a.h"
		alias
			"c_function"
		end

end
