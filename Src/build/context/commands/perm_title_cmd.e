indexing
	description: "Set the title of a permanent window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_TITLE_CMD

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.window_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_perm_title_cmd_name
		end

	context: WINDOW_C

	old_title: STRING

	work is
		do
			old_title := context.title
		end

	undo is
		local
			new_title: STRING
		do
			new_title := context.title
			context.set_visual_name (old_title)
			old_title := new_title
			{CONTEXT_CMD} Precursor
		end

end -- class PERM_TITLE_CMD

