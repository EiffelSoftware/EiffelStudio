indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_ITEM

inherit
	FIGURE_ITEM	

creation
	make

feature {NONE}-- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo
			-- that goes with it.
		do
			make_with_title (par, "EV_SEGMENT")
		end


	class_path : STRING is
			-- path where class text is held
		do
			!!Result.make(0)
			Result.make_from_string("C:/Eiffel44/examples/vision2/tutorial/demo_items/new_item.e")
		end	

feature -- Access
	
	FIGURE: EV_SEGMENT is
		local
			pt1, pt2 :EV_POINT
		do
			!! Result.make
			!! pt1.set (110,30)
			!!pt2.set (200,50)
			Result.set (pt1, pt2)
			Result.set_line_width (2)
		end
end -- class NEW_ITEM
