indexing
	description: "Icon that appears in a LABEL_BOX."
	date: "$Date$"
	revision: "$Revision$"

class
	LABEL_ICON

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end
	LABEL_STONE
	REMOVABLE

creation

	make
	
feature {NONE}

	cmd_editor: COMMAND_EDITOR

	
feature 

	data: CMD_LABEL

	make (ed: like cmd_editor) is
		do
			cmd_editor := ed
		end

	set_widget_default is
		do
			initialize_transport
		end

	remove_yourself is
		do
			cmd_editor.remove_label (data)
		end

invariant

	visible: (implementation /= Void and then managed) implies shown

end -- class LABEL_ICON
