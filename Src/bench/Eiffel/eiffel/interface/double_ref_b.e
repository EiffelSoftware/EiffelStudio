-- Class DOUBLE_REF

class DOUBLE_REF_B 

inherit

	CLASS_REF_B

creation

	make
	
feature 

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
		do
			Result := desc.is_double;
		end; -- valid

end
