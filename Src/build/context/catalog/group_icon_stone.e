indexing
	description: "Stone that is also an icon in a group box."
	Id: "$Id$"
	Revision: "$Revision$"
	Date: "$Date$"

class GROUP_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone, init_toolkit 
		redefine
			data, set_widget_default
		end
	TYPE_STONE
	REMOVABLE
	ERROR_POPUPER
	WINDOWS

feature 

	remove_yourself is
		local
			cut_command: CUT_GROUP_CMD
		do
			if data.group.not_used then
				!!cut_command
				cut_command.execute (data)
			else
				Error_box.popup (Current, 
					Messages.cannot_remove_group_er,
					data.group.entity_name)
			end
		end

	set_widget_default is
		do
			initialize_transport
		end
			
	data: CONTEXT_GROUP_TYPE

	popuper_parent: COMPOSITE is
		do
			Result := Context_catalog
		end

end
