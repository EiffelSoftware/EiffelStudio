indexing

	description: 
		"Event handler for mouse button events.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_HAND_X 

inherit

	ARRAY [LINKED_LIST [COMMAND_EXEC]]
		rename
			make as array_make
		export
			{NONE} all
		end;

	MEL_COMMAND
		undefine
			is_equal, copy
		end;

	READ_EVENT_X
		undefine
			is_equal, copy
		end;

	SHARED_CALLBACK_STRUCT
		undefine
			is_equal, copy
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an event handler for `widget_oui' triggered by the
			-- call-back specified by `resource'.
		local
			new_list: LINKED_LIST [COMMAND_EXEC];
			i: INTEGER
		do
			array_make (1, 5);
			from
				i := 1
			until
				i > 5
			loop
				!! new_list.make;
				new_list.compare_objects;
				put (new_list, i);
				i := i+1
			end;
		end;

feature -- Element change

	add_command (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions.
		require
			number_in_range: number >= 1 and number <= 5
		local
			command_info: COMMAND_EXEC
		do
			!! command_info.make (a_command, argument);
			item (number).extend (command_info)
		end;

feature -- Removal

	remove_command (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions.
		require
			number_in_range: number >= 1 and number <= 5
		local
			command_info: COMMAND_EXEC;
			is_removed: BOOLEAN;
			list: LINKED_LIST [COMMAND_EXEC]
		do
			!! command_info.make (a_command, argument);
			list := item (number);
			debug
				if list.has (command_info) then
					print (" found%N");
				else
					print (" not found%N");
				end;
			end
			list.start;
			list.search (command_info);
			if not list.after then
				list.remove;
			end
		end;

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Callback routine to be called from
			-- C when a mouse button event occurs,
		local
			button_data: BUTTON_DATA;
			list: LINKED_LIST [COMMAND_EXEC];
			be: MEL_BUTTON_EVENT;
			buttons: BUTTONS;
			number: INTEGER;
			widget_m: WIDGET_IMP
		do
			be ?= callback_struct.event;
			if be.is_button_one then
				number := 1
			elseif be.is_button_two then
				number := 2
			elseif be.is_button_three then
				number := 3
			elseif be.is_button_four then
				number := 4
			elseif be.is_button_five then
				number := 5
			else
				number := 1
			end;
			widget_m ?= callback_struct.widget;
			if widget_m = Void then
				widget_m := find_vision_parent 
					(callback_struct.widget)
			end;
			list := item (number);
			from
				set_last_callback_struct (callback_struct);
				!! buttons.make (5);
				buttons.put (True, number);
				if be.is_button_press then
					button_data := button_press_data (widget_m.widget_oui, be);
				else
					button_data := button_release_data (widget_m.widget_oui, be);
				end;
				list.start
			until
				list.after
			loop
				if list.item.command.context_data_useful then
					list.item.execute (button_data)
				else
					list.item.execute (Void)
				end;
				if not list.after then
					-- This condition is need just in case
					-- the above callback removes itself
					-- (or any other callback) from the Current list.
					list.forth
				end
			end;
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

end -- class BUTTON_CLICK_HAND_X


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

