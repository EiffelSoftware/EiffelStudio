
class ARG_INST_BOX 

inherit

	ICON_BOX [ARG_INSTANCE]
		rename
			make as box_create
		export
			{ANY} all
		redefine
			new_icon
		end	
	

creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			box_create (a_name, a_parent)
		end;

	
feature {NONE}

	new_icon: ARG_INST_ICON;
		
end
