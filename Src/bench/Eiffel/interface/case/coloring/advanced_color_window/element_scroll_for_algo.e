indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	ELEMENT_SCROLL_FOR_ALGO

inherit

	--SCROLLABLE_LIST_ELEMENT

creation
	make
feature

	make(s : STRING ) is
	do
		value := s	
	end

	color_name : STRING

	set_color (s : STRING ) is
	do
		color_name := clone (s)
	end

	set_class (c: CLASS_DATA ) is
	do
		class_data := c
	end		

	class_data : CLASS_DATA

	value: STRING  

end -- class ELEMENT_SCROLL_FOR_ALGO
