
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
		do
			old_create (a_name, a_parent)
		end;

	
feature {NONE}

	new_icon: GROUP_ICON_STONE

end

