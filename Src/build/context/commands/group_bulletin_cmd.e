indexing
	description: "Command to create a group."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class GROUP_CONTAINER_CMD 

inherit
	CONTEXT_CMD
		redefine
			context,
			undo, redo
		end

creation
	make

feature {NONE} -- Initialization

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_group_cmd_name
		end

	context: CONTAINER_C

	group_c: GROUP_C

feature 

	group_create (gp: GROUP_C) is
		do
			group_c := gp
			context.transform_in_group (group_c)
			group_c.reparent_container (context, ctxt_list)
			context.set_grouped (False)
			update_history
		end

	work is
		do
		end

	undo is
		do	
			group_c.cut
			context.transform_in_bulletin
--			Tree.display (context)
		end

	redo is
		do
			group_c.undo_cut
			context.transform_in_group (group_c)
--			Tree.display (group_c)
		end

end -- class GROUP_CONTAINER_CMD

