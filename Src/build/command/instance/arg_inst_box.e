
class ARG_INST_BOX 

inherit

	ICON_BOX [ARG_INSTANCE]
		rename
			make as box_create
		export
			{ANY} all
		redefine
			new_icon,
			create_new_icon
		end	
	


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; tool: COMMAND_TOOL) is
		local
			parent_scrolled_w: SCROLLED_W
		do
			command_tool := tool
			box_create (a_name, a_parent)
			set_column_layout
			set_preferred_count (3)
			parent_scrolled_w ?= a_parent
			if parent_scrolled_w /= Void then
				parent_scrolled_w.set_working_area (Current)
			end
		end;

	
feature {NONE}

	new_icon: ARG_INST_ICON
		-- Type of icon contained in the current box

	command_tool: COMMAND_TOOL
		-- Parent comand tool

	create_new_icon is
		do
			!! new_icon.make (command_tool)
		end
		
end
