indexing
	description: "Hole used to add a formal argument %
				% to a command."
	date: "$Date$"
	revision: "$Revision$"

class
	ARG_HOLE

inherit

	CMD_EDITOR_HOLE
		redefine
			process_type, process_context, compatible
		end

creation

	make

feature 

	stone_type: INTEGER is
		do
		end

	compatible (st: STONE): BOOLEAN is
		do
			Result := 
				st.stone_type = Stone_types.context_type or else
				st.stone_type = Stone_types.type_stone_type or else
				st.stone_type = Stone_types.application_object_type
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.type_pixmap
		end

	create_focus_label is
		do
			set_focus_string (Focus_labels.argument_label)
		end
	
feature {NONE}

	process_type (dropped: TYPE_STONE) is
		local
			c: GROUP_C
			t: CONTEXT_GROUP_TYPE
		do
			c ?= dropped.data
			t ?= dropped.data
			if (c = Void) and (t = Void) then
				command_editor.add_argument (dropped)
			end
		end

	process_context (dropped: CONTEXT_STONE) is
		do
			process_type (dropped)
		end

end -- class ARG_HOLE
