indexing

	description: 
		"Execution of a list of commands as a result of callbacks.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	VISION_COMMAND_LIST

inherit
	MEL_COMMAND
		undefine
			copy, is_equal
		end

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as list_make
		end;

	EVENT_HDL
		undefine
			copy, is_equal
		end

	READ_EVENT_X
		undefine
			copy, is_equal
		end

	SHARED_CALLBACK_STRUCT
		undefine
			copy, is_equal
		end

	MEL_CALLBACK_STRUCT_CONSTANTS
		undefine
			copy, is_equal
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

	insert_command (command: COMMAND; argument: ANY) is
			-- Insert `command' with `argument' to list of commands.
		require
			command_not_void: command /= Void
		local
			exec: COMMAND_EXEC
		do
			!! exec.make (command, argument)
			put_front (exec)
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
			context_data: CONTEXT_DATA;
			com_exec: COMMAND_EXEC;
			command_clone: COMMAND;
			widget_m: WIDGET_IMP;
			event: MEL_EVENT;
			widget_oui: WIDGET
		do
			set_last_callback_struct (callback_struct);
			start;
				-- Duplicate list just in case that commands are removed
				-- during the executing of the callbacks.
			from
				start
			until
				after
			loop
				com_exec := item;
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
						context_data := create_context_data (widget_oui, event)
					end;
					com_exec.execute (context_data)
				else
					com_exec.execute (Void)
				end;
				if not after then
					-- Just in case that commands are removed during the executing of the callbacks
					forth
				end
			end
		end;

feature {NONE} -- Implementation

	find_vision_parent (a_widget: MEL_OBJECT): WIDGET_IMP is
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

	create_context_data (widget_oui: WIDGET; event: MEL_EVENT): CONTEXT_DATA is
			-- Context data associated with Current motif callback
		local
			reason: INTEGER
		do
			reason := callback_struct.reason;
			if reason = 0 then
					-- Then it is a X event callback
				Result := create_context_data_from_event (widget_oui, event)
			elseif reason = XmCR_DEFAULT_ACTION then
				Result := click_data (widget_oui)
			elseif reason = XmCR_SINGLE_SELECT then
				Result := single_data (widget_oui)
			elseif reason = XmCR_BROWSE_SELECT then
				Result := browse_data (widget_oui)
			elseif reason = XmCR_MOVING_INSERT_CURSOR then
				Result := motion_data (widget_oui)
			elseif reason = XmCR_MODIFYING_TEXT_VALUE then
				Result := modify_data (widget_oui)
			elseif reason = XmCR_EXPOSE then
				Result := expose_data (widget_oui, event)
			elseif reason = XmCR_INPUT then
				Result := create_context_data_from_event (widget_oui, event)
			elseif reason = XmCR_NONE then
				!! Result.make (widget_oui)
			elseif event /= Void then
					-- No context data specific for a motif callback.
					-- Create a context data from `event'.
				Result := create_context_data_from_event (widget_oui, event)
			else
				!! Result.make (widget_oui)
			end
		ensure
			has_result: Result /= Void
		end;

feature {NONE} -- Implementation
 
	browse_data (widget_oui: WIDGET): SINGLE_DATA is
			-- Context data for `browse' action
		local
			c_struct: MEL_LIST_CALLBACK_STRUCT;
			mel_string: MEL_STRING;
			str: STRING
		do
			c_struct ?= callback_struct;
			mel_string := c_struct.item;
			if mel_string /= Void then
				str := mel_string.to_eiffel_string
			end;
			!! Result.make (widget_oui,
					c_struct.item_position,
					str)
		end;
 
	click_data (widget_oui: WIDGET): CLICK_DATA is
			-- Context data for `click' action
		local
			c_struct: MEL_LIST_CALLBACK_STRUCT;
			mel_string: MEL_STRING;
			str: STRING
		do
			c_struct ?= callback_struct;
			mel_string := c_struct.item;
			if mel_string /= Void then
				str := mel_string.to_eiffel_string
			end;
			!! Result.make (widget_oui,
					c_struct.item_position,
					str)
		end;

	single_data (widget_oui: WIDGET): SINGLE_DATA is
			-- Context data for `single' action
		local
			c_struct: MEL_LIST_CALLBACK_STRUCT;
			mel_string: MEL_STRING;
			str: STRING
		do
			c_struct ?= callback_struct;
			mel_string := c_struct.item;
			if mel_string /= Void then
				str := mel_string.to_eiffel_string
			end;
			!! Result.make (widget_oui,
					c_struct.item_position,
					str)
		end;
 
	modify_data (widget_oui: WIDGET): MODIFY_DATA is
			-- Context data for `modify' action
		local
			c_struct: MEL_TEXT_VERIFY_CALLBACK_STRUCT;
		do
			c_struct ?= callback_struct;
			!! Result.make (widget_oui,
					c_struct.current_insert,
					c_struct.new_insert,
					c_struct.start_pos,
					c_struct.end_pos,
					c_struct.text_string)
		end;
 
	motion_data (widget_oui: WIDGET): MOTION_DATA is
			-- Context data for `motion' action
		local
			c_struct: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			c_struct ?= callback_struct;
			!! Result.make (widget_oui,
					c_struct.current_insert,
					c_struct.new_insert);
		end;

end -- class MEL_COMMAND_LIST


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

