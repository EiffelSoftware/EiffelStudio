class CT_ELEMENT 

inherit

	DOUBLE_CELL[STRING,POINTER]

Creation

	make

feature

	make is
		-- Create empty element ( Void, Null pointer )
		do
			put(Void,Default_pointer)
		end -- make

end
