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

feature

	argument_position: INTEGER;

	argument_count: INTEGER;

	force (s: STRING; i: INTEGER) is
		do
			array_force (s, i);
			if i > argument_count then
				argument_count := i
			end;
		end;

	wipe_out is
		do
			array_wipe_out;
			argument_position := 1;
			argument_count := 1;
		end;

	current_item: STRING is
		do
			Result := item (argument_position);
			argument_position := argument_position + 1;
		end;

	no_more_arguments: BOOLEAN is
		do
			Result := argument_position > argument_count
		end

end
