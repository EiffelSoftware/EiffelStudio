class BEFORE_CLASS

inherit
	TEXT_ITEM

creation
	make

feature

	make (c: like class_c) is
		do
			class_c := c;
		end;

	class_c: CLASS_C;

	class_name: STRING is
		do
			Result := clone (class_c.class_name);
			Result.to_upper
		end;
			
end

