class BEFORE_FEATURE

inherit
	TEXT_ITEM

creation
	make

feature

	make (c: like class_name; n: STRING) is
		do
			class_name := c;
			feature_name := n;
		end;

	class_name: STRING;
	
	feature_name: STRING; 

	is_prefix: BOOLEAN;

	is_infix: BOOLEAN;

	set_is_prefix is
		do
			is_prefix := True
		end;

	set_is_infix is
		do
			is_infix := True
		end;

end
		
