indexing
	description: "Set the icon name of a permanent window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_ICON_CMD

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implemantation

	associated_form: INTEGER is
		do
			Result := Context_const.window_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_perm_icon_cmd_name
		end

	context: WINDOW_C

	old_pixmap_name: STRING

	old_pixmap: EV_PIXMAP

	work is
		do
			old_pixmap_name := context.icon_pixmap_name
			if old_pixmap_name = Void then
				old_pixmap := context.icon_pixmap
			end
		end

	undo is
		local
			new_name: STRING
		do
			new_name := context.icon_pixmap_name
			if old_pixmap_name /= Void then
				context.set_icon_pixmap (old_pixmap_name)
			else
				context.set_icon_pixmap (old_pixmap_name)
			end
			old_pixmap_name := new_name
			{CONTEXT_CMD} Precursor
		end

end -- class PERM_ICON_CMD

