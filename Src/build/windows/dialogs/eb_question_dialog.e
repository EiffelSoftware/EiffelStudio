indexing
	description: "EiffelBuild question dialog." 
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EB_QUESTION_DIALOG

inherit
	EV_COMMAND

	CONSTANTS

feature -- Access

	is_popped_up: BOOLEAN is
		do
			Result := quest_d /= Void
		end

	popup_with_ok_cancel (par: QUEST_POPUPER; s: STRING; extra_message: STRING; help: BOOLEAN) is
			-- Popup Current question box with "ok" and "cancel",
			-- add "help" button if `help' is True.
		require
			valid_parent: par /= Void
			valid_parent_comp: par.popuper_parent /= Void
			valid_s: s /= Void
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
			valid_help: help /= Void
		local
			tmp: STRING
			top: TOP
		do
			make (par, help)
			quest_d.show_ok_cancel_buttons
			if extra_message = Void then
				tmp := s
			else
				tmp := clone (s)
				tmp.replace_substring_all ("%%X", extra_message)
			end
			quest_d.set_message (tmp)
			quest_d.show

--			top ?= c.popuper_parent
--			if top /= Void and then top.is_iconic_state then
--				quest_d.set_x_y (0, 0)
--			end
		end

	popup (par: QUEST_POPUPER; s: STRING; extra_message: STRING; help: BOOLEAN) is
			-- Popup Current question box with "yes" and "no" labels,
			-- add "help" button if `help' is True.
		require
			valid_parent: par /= Void
			valid_parent_comp: par.popuper_parent /= Void
			valid_s: s /= Void
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
			valid_help: help /= Void
		local
			tmp: STRING
			top: TOP
		do
			make (par, help)
			quest_d.show_yes_no_buttons
			if extra_message = Void then
				tmp := s
			else
				tmp := clone (s)
				tmp.replace_substring_all ("%%X", extra_message)
			end
			quest_d.set_message (tmp)
			quest_d.show

--			top ?= c.popuper_parent
--			if top /= Void and then top.is_iconic_state then
--				quest_d.set_x_y (0, 0)
--			end
		end

feature {NONE} -- Implementation
	
	quest_d: EV_QUESTION_DIALOG

	make (par: QUEST_POPUPER; help: BOOLEAN) is
		local
			arg: EV_ARGUMENT2 [QUEST_POPUPER, INTEGER]
--			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			create quest_d.make (par.popuper_parent)
			quest_d.set_title (Widget_names.question_window)
			if help then
				quest_d.add_help_button
				create arg.make (par, 3)
				quest_d.add_help_command (Current, arg)
			end

			create arg.make (par, 1)
			quest_d.add_yes_command (Current, arg)
			create arg.make (par, 2)
			quest_d.add_no_command (Current, arg)

			create arg.make (par, 1)
			quest_d.add_ok_command (Current, arg)
			create arg.make (par, 2)
			quest_d.add_cancel_command (Current, arg)
--			!! set_dialog_att 
--			set_dialog_att.execute (quest_d)
--			quest_d.set_action ("<Unmap>", Current, Void)
		end

	execute (arg: EV_ARGUMENT2 [QUEST_POPUPER, INTEGER]; ev_data: EV_EVENT_DATA) is
		do
			if arg.first /= Void then
				if arg.second = 1 then
					arg.first.question_ok_action
				elseif arg.second = 2 then
					arg.first.question_cancel_action
				elseif arg.second = 3 then
					arg.first.question_help_action
				end
			end
		end

end -- class EB_QUESTION_DIALOG

