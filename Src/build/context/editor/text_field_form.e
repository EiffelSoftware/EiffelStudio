indexing
	description: "Page representing the properties of a TEXT_FIELD."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_FIELD_FORM

inherit
	EDITOR_FORM
		redefine
			initialize, context
		end

creation
	make

feature {NONE} -- Initialization

	initialize (par: EV_CONTAINER) is
		local
			cmd: CONTEXT_CMD
			arg: EV_ARGUMENT1 [CONTEXT_EDITOR]
		do
			Precursor (par)
			set_spacing (5)
			create arg.make (editor)

			create default_text.make_with_label (Current,
										Widget_names.text_field_text_name)
			create {SET_DEFAULT_TEXT_CMD} cmd
			default_text.add_return_command (cmd, arg)

			create passwd_character.make_with_label (Current,
										Widget_names.passwd_character_name)
			passwd_character.set_maximum_text_length (1)
			create {PASSWD_FIELD_CMD} cmd
			passwd_character.add_return_command (cmd, arg)

			create maximum_size.make_with_label (Current,
										Widget_names.maximum_size_name)
			create {TEXT_MAX_CMD} cmd
			maximum_size.add_return_command (cmd, arg)

			create read_only.make_with_text (Current,
										Widget_names.read_only_name)
			create {TEXT_READ_CMD} cmd
			read_only.add_toggle_command (cmd, arg)
		end

feature {NONE} -- GUI attributes

	default_text, passwd_character: EB_TEXT_FIELD

	maximum_size: INTEGER_TEXT_FIELD

	read_only: EV_CHECK_BUTTON

	context: TEXT_FIELD_C is
		do
			Result ?= Precursor
		end

feature -- Access

	reset is
			-- reset the content of the form
		local
			passwd_f: PASSWORD_FIELD_C
		do
			default_text.set_text (context.default_text)
			passwd_f ?= context
			if passwd_f /= Void then
				passwd_character.set_text (passwd_f.character.out)
				passwd_character.show
			else
				passwd_character.hide
			end
			maximum_size.set_int_value (context.maximum_text_length)
			read_only.set_state (not context.is_editable)
		end

	apply is
			-- update the context according to the content of the form
		local
			passwd_f: PASSWORD_FIELD_C
		do
			context.set_default_text (default_text.text)
			context.set_text (default_text.text)
			if passwd_character.shown then
				passwd_f ?= context
				if passwd_f /= Void then
					passwd_f.set_character (passwd_character.text.item (1))
				end
			end
			context.set_maximum_text_length (maximum_size.int_value)
		end

end -- class TEXT_FIELD_FORM

