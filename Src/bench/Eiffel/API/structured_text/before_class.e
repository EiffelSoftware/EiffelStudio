class BEFORE_CLASS

inherit
	TEXT_ITEM

creation
	make

feature

	make (c: like class_name) is
		do
			class_name := c;
		end;

	class_name: STRING;

end

