
class GROUP_BOX 

inherit

	ICON_BOX [CONTEXT_GROUP_TYPE]
		rename
			make as old_create
		redefine
			new_icon
		end

creation

	make
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			parent_scrolled_w: SCROLLED_W
		do
			old_create (a_name, a_parent)
			parent_scrolled_w ?= a_parent
			if parent_scrolled_w /= Void then
				parent_scrolled_w.set_working_area (Current)
			end
		end;

	
feature {NONE}

	new_icon: GROUP_ICON_STONE

end

