-- Cache for invariant byte code

class INV_BYTE_CACHE 

inherit

	CACHE [INVARIANT_B, CLASS_ID]

creation

	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
