indexing
	description: "Set the Widget's Focus";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	FOCUS_LINE

inherit

	LINE_MESSAGE;
	CONSTANTS

feature -- Property

	focus_label: EV_LABEL is
			-- Label where focus_string is displayed
		deferred
		end;

feature -- Setting

--	set_focus (widget: EV_WIDGET; help_id: STRING) is
--			-- Set help line to show when cursor is in `widget'.
--		-- Help line displayed is found thanks to the given `help_id' key
--		require
--			has_widget : widget /= Void;
--			has_id : help_id /= Void
--		do
--			if not messages.empty then
--			if set_focus_line_command = Void then
--					--| Only way to initialize command
--			!! set_focus_line_command.make (Current)
--			end;
--			if messages.has (help_id) then
--					widget.add_enter_action (set_focus_line_command, messages.item (help_id));
--					widget.add_leave_action (set_focus_line_command, " ")
--					if set_focus_line_command.widget_is_entered then
--						set_focus_line_command.execute (messages.item (help_id));
--					end;
--			--else
--		--		io.error.putstring ("Can not find help keyword ");
--			--	io.error.putstring (help_id);
--				--io.error.putstring ("%NPlease Contact I.S.E");
--				--io.error.new_line;
--			end;
--		end
--	end 

	set_focus_with_string (widget: EV_WIDGET; str: STRING) is
			-- Set help line to show when cursor is in `widget'.
			-- Help line displayed is directly the given `str' string.
-- 		require
-- 			has_widget : widget /= Void
-- 			has_string : str /= Void
-- 			valid_string: str.count > 0
 		do
-- 			if set_focus_line_command = Void then
-- 					--| Only way to initialize command
-- 				!! set_focus_line_command.make (Current)
-- 			end
-- 			widget.add_enter_action (set_focus_line_command, str)
-- 			widget.add_leave_action (set_focus_line_command, " ")
-- 			if set_focus_line_command.widget_is_entered then
-- 				set_focus_line_command.execute (str)
-- 			end
		end   

feature {NONE} -- Implementation

	messages: HASH_TABLE [STRING, STRING] is
			-- Help line messages
		once
			!! Result.make (30);
			read_messages_in (Environment.Inline_file)
		end;

	set_focus_line_command: SET_FOCUS_LINE_COM;
			-- Command to set the help line shown

	change_focus_to (widget: EV_WIDGET; old_help_id, new_help_id: STRING) is
			-- Change focus_label from `old_help_id' to `new_help_id'.
		require
			valid_command: set_focus_line_command /= Void
		local
			old_focus, new_focus: STRING
		do
-- 			old_focus := messages.item (old_help_id);
-- 			new_focus := messages.item (new_help_id);
-- 			widget.remove_enter_action (set_focus_line_command, old_focus);
-- 			widget.add_enter_action (set_focus_line_command, new_focus);
-- 			set_focus_line_command.update (new_focus);
		end;

end -- class FOCUS_LINE
