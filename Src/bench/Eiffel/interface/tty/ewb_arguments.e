indexing

	description: 
		"Representation of arguments entered by the user%
		%while in the loop of the batch compiler.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ARGUMENTS

inherit
	ARRAY [STRING]
		rename
			wipe_out as array_wipe_out,
			force as array_force
		end;
	ARRAY [STRING]
		redefine
			wipe_out, force
		select
			wipe_out, force
		end

creation

	make

feature -- Properties

	argument_position: INTEGER;
			-- Current position of argument

	argument_count: INTEGER;
			-- Number of arguments

feature -- Access

	current_item: STRING is
			-- Current argument string at `argument_position'
		do
			Result := item (argument_position);
			argument_position := argument_position + 1;
		end;

	more_arguments: BOOLEAN is
			-- Are there more arguments?
		do
			Result := argument_position <= argument_count
		end

feature -- Update

	force (s: STRING; i: INTEGER) is
			-- Force string `s' at position `i'.
		do
			array_force (s, i);
			if i > argument_count then
				argument_count := i
			end;
		end;

	wipe_out is
			-- Clear arguments.
		require else
			True
		do
			make (lower, upper);
			argument_position := 1;
			argument_count := 1;
		end;

end -- class EWB_ARGUMENTS
