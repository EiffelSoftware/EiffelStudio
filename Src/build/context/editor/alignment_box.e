
class ALIGNMENT_BOX 

inherit

	ICON_BOX [CONTEXT]
		rename
			make as box_create
		redefine
			new_icon, create_new_icon
		end
	

creation

	make

	
feature {NONE}

	new_icon: ALIGNMENT_ICON;

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			box_create (a_name, a_parent)
		end;

	
feature {NONE}

	create_new_icon is
		do
			!!new_icon.make (Current)
		end;

	
feature 

	remove_icon (i: ALIGNMENT_ICON) is
		do
			icons.start;
			icons.search_same (i);
			if not icons.offright then
				go (icons.position);
				remove
			end
		end;

end

