
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EVENT_HAND_O 

inherit

	LINKED_LIST [COMMAND_EXEC]
		rename
			make as linked_list_make,
			remove as list_remove
		export
			{NONE} all
		end;

	EVENT_HDL;

	G_ANY_I
		export
			{NONE} all
		end

creation

	make
	
feature 

	add (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- call-back `resource' of `screen_object' is triggered.
		local
			command_info: COMMAND_EXEC
		do
			!!command_info.make (a_command, argument);
			finish;
			add_right (command_info)
		end; 

	create_context_data (widget_oui: WIDGET): CONTEXT_DATA is
                      -- Context data for the current action
        do
			!!Result.make (widget_oui)
 		end;
 
	call_back (widget_oui: WIDGET) is
			--
		local
			context_data, context_data_void: CONTEXT_DATA
		do
			if (not empty) 
			then
				from
					start
				until
					off
				loop
					if item.command.context_data_useful then
						if (context_data = Void) then
							context_data := create_context_data (widget_oui)
						else
							context_data := clone (context_data)
						end;
                        			item.execute (context_data)
                    			else
                        			item.execute (context_data_void)
                    			end;
					if not off then
						forth
					end
                		end
            		end
        	end;

	make (screen_object: POINTER; resource: STRING; widget_oui: WIDGET) is
			-- Create an event handler for `widget_oui' triggered by the
			-- openlook call-back specified by `resource'.
		require
			resource_exists: not (resource = Void)
		
		local
			ext_name: ANY;
		do
			linked_list_make;
			ext_name := resource.to_c;		
			add_action (screen_object, Current, $call_back, widget_oui, $ext_name);
			call_back (widget_oui)
		end;

	remove (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of actions to execute when the
			-- call-back `resource' of `screen_object' is triggered.
		local
			command_info: COMMAND_EXEC;
			is_removed: BOOLEAN
		do
			!!command_info.make (a_command, argument);
			start;
			compare_objects;
			search (command_info);
			compare_references;
			if not off then
				list_remove;
				is_removed := true
			end
		end

feature {NONE} -- External features

	add_action (scr_obj: POINTER; obj: G_ANY_I; cb: POINTER; oui: WIDGET; res: ANY) is
		external
			"C"
		end; 

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
