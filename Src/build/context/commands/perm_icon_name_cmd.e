indexing
	description: "Set the icon name of a permanent window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_ICON_NAME_CMD

inherit
	CONTEXT_CMD
		redefine
			undo, context
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.window_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_perm_icon_name_cmd_name
		end

	context: WINDOW_C

	old_icon_name: STRING

	work is
		do
			old_icon_name := context.icon_name
		end

	undo is
		local
			new_icon_name: STRING
		do
			if not (old_icon_name = Void) then
				new_icon_name := context.icon_name
				context.set_icon_name (old_icon_name)
				old_icon_name := new_icon_name
			end
			{CONTEXT_CMD} Precursor
		end

end -- class PERM_ICON_NAME_CMD

