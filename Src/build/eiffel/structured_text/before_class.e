class BEFORE_CLASS

inherit
	TEXT_ITEM

creation
	make

feature

	make (c: ANY) is
		-- ANY - like class_c
		do
			--class_c := c;
		end;

	class_name: STRING is
		do
			!! Result.make (0) -- added
			--Result := clone (class_c.class_name);
			--Result.to_upper
		end;
			
end
