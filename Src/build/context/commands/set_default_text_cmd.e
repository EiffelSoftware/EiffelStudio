indexing
	description: "Set the default text of a text component."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_DEFAULT_TEXT_CMD

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			if context.is_field then
				Result := Context_const.text_field_att_form_nbr
			else
				Result := Context_const.text_att_form_nbr
			end
		end

	name: STRING is
		do
			Result := Command_names.cont_set_default_text_cmd_name
		end

	context: TEXT_COMPONENT_C

	old_defaut_text: STRING

	work is
		do
			old_defaut_text := context.default_text
		end

	undo is
		local
			new_txt: STRING
		do
			new_txt := context.default_text
			context.set_default_text (old_defaut_text)
			old_defaut_text := new_txt
			{CONTEXT_CMD} Precursor
		end

end -- class SET_DEFAULT_TEXT_CMD

