indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class TREE_DEMO_WINDOW

inherit

	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end
	
creation
	
	make

feature -- Access

	main_widget: EV_TREE is
		once
			!!Result.make (Current)
			Result.set_minimum_size(200,200)
		end
	
feature -- Status setting
        
	set_widgets is
		local
			tree_item: EV_TREE_ITEM
			tree_item2: EV_TREE_ITEM
		do
			!! tree_item.make_with_text (main_widget, "Item")
			!! tree_item2.make_with_text (tree_item, "Item 2")
			!! tree_item.make_with_text (main_widget, "Item 3")
			!! tree_item.make_with_text (main_widget, "Item 4")
			!! tree_item2.make_with_text (tree_item, "Item 5")
			!! tree_item2.make_with_text (tree_item, "Item 6")
			!! tree_item.make_with_text (tree_item2, "l3 item")

                end
	
	set_values is
		do
			set_title ("Tree demo")
		end

end -- class TREE_DEMO_WINDOW
