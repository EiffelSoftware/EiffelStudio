--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Window describing the assembly of an Eiffel system (Ace, universe, ...)

class SYSTEM_W 

inherit

	PROJECT_CONTEXT;
	BAR_AND_TEXT
		rename
			attach_all as default_attach_all
		redefine
			hole, build_format_bar, build_widgets,
			open_command, save_as_command, quit_command, save_command,
			text_window, tool_name, editable, create_edit_buttons
		end;
	BAR_AND_TEXT
		redefine
			hole, build_format_bar, attach_all, build_widgets,
			open_command, save_as_command, quit_command, save_command,
			text_window, tool_name, editable, create_edit_buttons
		select
			attach_all
		end

creation

	make

feature {NONE}

	tool_name: STRING is do Result := l_System end;

	editable:BOOLEAN is True;
		-- System window is editable

feature 

	text_window: SYSTEM_TEXT;

	display is
		do
			if not realized then
				set_default_format;
				realize
			elseif not shown then
				set_default_format;
				set_default_position;
				show
			end;
			raise;
		end;
	
feature {NONE}
	
	create_edit_buttons is
		do
			!!open_command.make (edit_bar, text_window);
			!!save_command.make (edit_bar, text_window);
			!!save_as_command.make (edit_bar, text_window);
		end;

	build_widgets is
		do
			set_default_size;
			if tabs_disabled then
				!!text_window.make (new_name, global_form, Current);
			else
				!SYSTEM_TAB_TEXT!text_window.make (new_name, global_form, Current);
			end;
			!!edit_bar.make (new_name, global_form);
			build_bar;
			!!format_bar.make (new_name, global_form);
			build_format_bar;
			!!command_bar.make (new_name, global_form);
			build_command_bar;
			text_window.set_last_format (default_format);
			attach_all
		end;

	attach_all is
		do
			default_attach_all;
			global_form.detach_right (text_window);
			global_form.attach_right (command_bar, 0);
			global_form.attach_right_widget (command_bar, format_bar, 0);
			global_form.attach_right_widget (command_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, command_bar, 0);
			global_form.attach_bottom (command_bar, 0);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!showtext_command.make (format_bar, text_window);
				format_bar.attach_top (showtext_command, 0);
				format_bar.attach_left (showtext_command, 0);
			!!showlist_command.make (format_bar, text_window);
				format_bar.attach_top (showlist_command, 0);
				format_bar.attach_left_widget (showtext_command, showlist_command, 0);
			!!showclasses_command.make (format_bar, text_window);
				format_bar.attach_top (showclasses_command, 0);
				format_bar.attach_left_widget (showlist_command, showclasses_command, 0);
			!!showstatistics_command.make (format_bar, text_window);
				format_bar.attach_top (showstatistics_command, 0);
				format_bar.attach_left_widget (showclasses_command, showstatistics_command, 0);
			!!showmodified_command.make (format_bar, text_window);
				format_bar.attach_top (showmodified_command, 0);
				format_bar.attach_left_widget (showstatistics_command, showmodified_command, 0);
			!!showindexing_command.make (format_bar, text_window);
				format_bar.attach_top (showindexing_command, 0);
				format_bar.attach_left_widget (showmodified_command, showindexing_command, 0);
		end;

feature {NONE} -- Command bar

	command_bar: FORM;
			-- Bar with the command buttons

	build_command_bar is
		do
			!!shell_command.make (command_bar, text_window);
				command_bar.attach_right (shell_command, 0);
				command_bar.attach_left (shell_command, 0);
				command_bar.attach_bottom (shell_command, 0);
			!!case_storage_cmd.make (command_bar, text_window);
				command_bar.attach_left (case_storage_cmd, 0);
				command_bar.attach_bottom_widget (shell_command, case_storage_cmd, 10)
		end;

feature {NONE}

	hole: SYSTEM_HOLE;
			-- Hole caraterizing current

	open_command: OPEN_SYSTEM;
	save_command: SAVE_SYSTEM;
	save_as_command: SAVE_AS_SYSTEM;
--	check_command: CHECK_SYSTEM;
	quit_command: QUIT_SYSTEM;
	showlist_command: SHOW_CLUSTERS;
	showclasses_command: SHOW_CLASS_LIST;
	showmodified_command: SHOW_MODIFIED;
	showindexing_command: SHOW_INDEXING;
	showstatistics_command: SHOW_STATISTICS;
	shell_command: SHELL_COMMAND;
	case_storage_cmd: CASE_STORAGE

end
