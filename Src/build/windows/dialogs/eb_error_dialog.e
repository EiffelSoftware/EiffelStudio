indexing
	description: "EiffelBuild error dialog." 
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EB_ERROR_DIALOG

inherit
	EV_COMMAND

	CONSTANTS

feature -- Access

	popup (par: ERROR_POPUPER; s: STRING; extra_message: STRING) is
		require
			valid_parent: par /= Void
			valid_parent_comp: par.popuper_parent /= Void
			valid_s: s /= Void
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING
		do
			make (par)
			if extra_message = Void then
		   		tmp := s
			else
		   		tmp := clone (s)
				tmp.replace_substring_all ("%%X", extra_message)
			end
			error_d.set_message (tmp)
			error_d.show
		end

	is_popped_up: BOOLEAN is
		do
			Result := error_d /= Void
		end

feature -- Status setting

	error_string: STRING is
		once
			!! Result.make (0)
		end

	put_string (an_error: STRING) is
		do
			error_string.append (an_error)
		end

	put_clickable_string (a: ANY; s: STRING) is
		do
			error_string.append (s)
		end

	new_line is
		do
			error_string.extend ('%N')
		end

	put_char (c: CHARACTER) is
		do
			error_string.extend (c)
		end

	put_int (i: INTEGER) is
		do
			error_string.append_integer (i)
		end

	clear is
		do
			error_string.wipe_out
		end

	display_error_message (par: ERROR_POPUPER) is
		require
			valid_c: par /= Void
			valid_parent_comp: par.popuper_parent /= Void
		do
			make (par)
			error_d.set_message (clone (error_string))
			error_string.wipe_out
			error_d.show
		end

feature {NONE} -- Implementation

	error_d: EV_ERROR_DIALOG

	make (par: ERROR_POPUPER) is
		local
			arg: EV_ARGUMENT1 [ERROR_POPUPER]
--			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			create error_d.make_default (par.popuper_parent, Widget_names.error_window, Void)
			create arg.make (par)
			error_d.add_ok_command (Current, arg)
--			!! set_dialog_att
--			set_dialog_att.execute (error_d)
--			error_d.set_action ("<Unmap>", Current, Void)
		end

	execute (arg: EV_ARGUMENT1 [ERROR_POPUPER]; ev_data: EV_EVENT_DATA) is
		do
			if arg.first /= Void then
				arg.first.continue_after_error_popdown
			end
		end

end -- class EB_ERROR_DIALOG

