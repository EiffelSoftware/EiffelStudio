indexing

	description: 
		"Event handler for mouse button click events.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_CLICK_HAND_X 

inherit

	ARRAY [LINKED_LIST [COMMAND_EXEC]]
		rename
			make as array_make
		export
			{NONE} all
		end;

	COMMAND
		undefine
			is_equal, copy
		end;

	SHARED_CALLBACK_STRUCT
		undefine
			is_equal, copy
		end;

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
				put (new_list, i);
				i := i+1
			end;
			multi_click_time := 200;
			compare_objects;
		ensure
			default_is_200: multi_click_time = 200
		end;

feature -- Status report

	multi_click_time: INTEGER
			-- Multi click time

	callback_added: BOOLEAN
			-- Has the callback been added to event handler?

feature -- Status setting

	set_multi_click_time (time: INTEGER) is
		do
			multi_click_time := time
		end;

	set_callback_added is
			-- Set `callback_added' to True
		do
			callback_added := True
		ensure
			callback_added: callback_added
		end;

feature -- Element change

	add (number: INTEGER; a_command: COMMAND; argument: ANY) is
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

	remove (number: INTEGER; a_command: COMMAND; argument: ANY) is
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
			butclick_data: BUTCLICK_DATA;
			list: LINKED_LIST [COMMAND_EXEC];
			be: MEL_BUTTON_EVENT;
			buttons: BUTTONS;
			number: INTEGER;
			widget_m: WIDGET_IMP
		do
			be ?= last_callback_struct.event;
			if be.is_button_press then
				click_time := be.time;
			elseif be.is_button_release and then
				(be.time - click_time < multi_click_time)
			then
				widget_m ?= last_callback_struct.widget;
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
				end
				list := item (number);
				from
					list.start
				until
					list.after
				loop
					if list.item.command.context_data_useful then
						!! buttons.make (5);
						buttons.put (True, number);
						!! butclick_data.make (widget_m.widget_oui,
								be.x, be.y, be.x_root, be.y_root,
								number, buttons);
						list.item.execute (butclick_data)
					else
						list.item.execute (Void)
					end;
					if not list.after then
						-- This condition is need just in case
						-- the above callback removes itself
						-- (or any other callback) from the Current list.
						list.forth
					end
				end
			end
		end; 

feature {NONE} -- Implementation

	click_time: INTEGER;
			-- Last recorded button press time

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

