indexing
	description: "Change the displayed character for the password field."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	PASSWD_FIELD_CMD

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.text_field_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_text_max_cmd_name
		end

	context: PASSWORD_FIELD_C

	old_character: CHARACTER

	work is
		do
			old_character := context.character
		end

	undo is
		local
			new_character: CHARACTER
		do
			new_character := context.character
			context.set_character (old_character)
			old_character := new_character
			{CONTEXT_CMD} Precursor
		end

end -- class PASSWD_FIELD_CMD

