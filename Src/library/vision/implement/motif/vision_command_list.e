indexing

	description: 
		"Execution of a list of commands as a result of MOTIF callback";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	VISION_COMMAND_LIST

inherit
	MEL_COMMAND;

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as list_make
		end;

	EVENT_HDL
		redefine
			is_equal
		end;

	READ_EVENT_X
		redefine
			is_equal
		end;

	SHARED_CALLBACK_STRUCT
		redefine
			is_equal
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			list_make;
			compare_objects
		end

feature -- Element change

	add_command (command: COMMAND; argument: ANY) is
			-- Add `command' with `argument' to list of commands.
		require
			command_not_void: command /= Void
		local
			exec: COMMAND_EXEC
		do
			!! exec.make (command, argument)
			extend (exec)
		end

feature -- Removal

	remove_command (command: COMMAND; argument: ANY) is
			-- Remove all `command' with `argument' from the list of commands.
		require
			command_not_void: command /= Void
		local
			command_info: COMMAND_EXEC
		do
			start;
			!! command_info.make (command, argument);
			search (command_info);
			if not after then
				remove
			end
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute list of commands
		local
			a_list: like Current;
			context_data: CONTEXT_DATA;
			com_exec: COMMAND_EXEC;
			command_clone: COMMAND;
			widget_m: WIDGET_M;
			event: MEL_EVENT;
			widget_oui: WIDGET
		do
			set_last_callback_struct (callback_struct);
			start;
				-- Duplicate list just in case that commands are removed
				-- during the executing of the callbacks.
			a_list := duplicate (count);
			from
				a_list.start
			until
				a_list.after
			loop
				com_exec := a_list.item;
				if com_exec.command.context_data_useful then
					if (context_data = Void) then
						event := callback_struct.event;
						widget_m ?= callback_struct.widget;
						if widget_m = Void then
							-- Callback was on widget that may have not a corresponding
							-- vision widget (eg cancel_button in FONT_BOX_M or
							-- scrollbar in SCALE_M).
							-- Try the first available EiffelVision widget.
							widget_m := find_vision_parent (callback_struct.widget)
						end;
						widget_oui := widget_m.widget_oui;
						if event = Void then
							!! context_data.make (widget_oui)
						else
							context_data := create_context_data (widget_oui, event)
						end
					end;
					com_exec.execute (context_data)
				else
					com_exec.execute (Void)
				end;
				a_list.forth
			end
		end;

feature {NONE} -- Implementation

	find_vision_parent (a_widget: MEL_OBJECT): WIDGET_M is
			-- Find `a_widget' parent that is recorded in EiffelVision
		require
			valid_widget: a_widget /= Void;
			has_parent: a_widget.parent /= Void
		do
			Result ?= a_widget.parent;
			if Result = Void then
				Result := find_vision_parent (a_widget.parent)
			end
		ensure
			found: Result /= Void
		end;

end -- class MEL_COMMAND_LIST

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
