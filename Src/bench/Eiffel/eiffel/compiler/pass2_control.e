-- Second pass controler: it is the result of the incrementality test after
-- the second pass

class PASS2_CONTROL 

inherit

	PASS_CONTROL
		rename
			make as basic_make,
			wipe_out as basic_wipe_out
		end;
	PASS_CONTROL
		redefine
			wipe_out, make
		select
			wipe_out, make
		end;
	SHARED_EXTERNALS
		export
			{NONE} all
		end;

creation

	make

feature

	old_externals: LINKED_LIST [STRING];
			-- Old externals written in a class
			-- | Processed by feature `pass2_control' of FEATURE_TABLE

	new_externals: LINKED_LIST [STRING];
			-- New externals written in a class
			-- | Processed by feature `feature_unit' of INHERIT_TABLE 

feature 

	make is
			-- Initialization
		do
			basic_make;
			!!old_externals.make;
		end;

	set_new_externals (l: like new_externals) is
			-- Assign `l' to `new_externals'.
		do
			new_externals := l;
		end;

	remove_external (s: STRING) is
			-- Add `s' to `old_externals'.
		do
			old_externals.start;
			old_externals.put_right (s);
		end;

	process_externals is
			-- Update the system external feature controler
		require
			new_externals_exists: new_externals /= Void
		do
			from
				old_externals.start
			until
				old_externals.after
			loop
				Externals.remove_occurence (old_externals.item);
				old_externals.forth;
			end;
			from
				new_externals.start
			until
				new_externals.after
			loop
				Externals.add_occurence (new_externals.item);
				new_externals.forth;
			end;
		end;

	wipe_out is
			-- Empty the structure
		do
			basic_wipe_out;
			old_externals.wipe_out;
			new_externals := Void;
		end;

end
