indexing

	description:
		"Control class of Eiffelbuild applications.%
		%Determines the transition from state to state%
		%for a given transition label.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONTROL 

inherit

	ARRAY [HASH_TABLE [INTEGER, STRING]]
		rename
			make as array_make,
			put as array_put
		end;
	GRAPHICS
		undefine
			is_equal, setup, copy, consistent 
		end

creation

	make

feature {NONE}

	make (nb_states: INTEGER) is
		local
			i: INTEGER;
			new_entry: HASH_TABLE [INTEGER, STRING]
		do
			array_make (1, nb_states);
			from	
				i := 1
			until
				i > nb_states
			loop
				!!new_entry.make (5);
				array_put (new_entry, i);
				i := i + 1
			end
		end;

feature

	Exit_from_application: INTEGER is -2;
			-- Exit status
 
	Return_to_previous: INTEGER is -1;
			-- Return status
 
	state: INTEGER;
			-- Current state

	previous_state: INTEGER;
			-- Previous state

	set_initial_state (initial_state: INTEGER) is
			-- Set state to `initial_state'. 
		do
			state := initial_state;
			previous_state := state;
			current_transitions := item (state)
		end;

	put (origin_state, destination_state: INTEGER; label: STRING) is
			-- Specify transition `label' going from
			-- `origin_state to `destination_state'.
		do
			item (origin_state).put (destination_state, label)
		end;

	current_transitions: HASH_TABLE [INTEGER, STRING];
			-- Current transition table

	transit (label: STRING) is
			-- Transit from current `state' to another
			-- state for transition `label'.
		local
			temp: INTEGER;
		do
			if current_transitions.has (label) then
				temp := state;
				state := current_transitions.item (label);
				if (state = Return_to_previous) then
					state := previous_state;
					previous_state := temp;
					current_transitions := item (state)
				elseif (state = Exit_from_application) then
					exit
				else
					previous_state := temp;
					current_transitions := item (state)
				end;
			end;
		end;

		-- Guillaume
	set_current_state (new_state: INTEGER) is
		do
			previous_state := state
			state := new_state
		end

	editing_mode: INTEGER is -3
			-- Editing mode

end -- CONTROL 

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

