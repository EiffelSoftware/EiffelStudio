indexing
	description: "Second pass controler: it is the result of the incrementality%
		%test after the second pass"
	date: "$Date$"
	revision: "$Revision$"

class PASS2_CONTROL 

inherit
	PASS_CONTROL
		redefine
			wipe_out, make
		end

	SHARED_EXTERNALS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			Precursor {PASS_CONTROL}
			create old_externals.make
			old_externals.compare_objects
		end

feature -- Access

	old_externals: LINKED_LIST [INTEGER]
			-- Old externals written in a class
			-- | Processed by feature `pass2_control' of FEATURE_TABLE

	new_externals: LINKED_LIST [INTEGER]
			-- New externals written in a class
			-- | Processed by feature `feature_unit' of INHERIT_TABLE 

feature -- Settings

	set_new_externals (l: like new_externals) is
			-- Assign `l' to `new_externals'.
		require
			l_not_void: l /= Void
		do
			new_externals := l
		ensure
			new_externals_set: new_externals = l
		end

	remove_external (s: INTEGER) is
			-- Add `s' to `old_externals'.
		require
			s_valid: s > 0
		do
			old_externals.start
			old_externals.search (s)
			if old_externals.after then
				old_externals.put_front (s)
			end
		end

feature -- Processing

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
				Externals.remove_occurrence (old_externals.item)
				old_externals.forth
			end

			from
				new_externals.start
			until
				new_externals.after
			loop
				Externals.add_occurrence (new_externals.item)
				new_externals.forth
			end
		end

feature -- Removal

	wipe_out is
			-- Empty the structure
		do
			Precursor {PASS_CONTROL}
			old_externals.wipe_out
			new_externals := Void
		end

end -- class PASS2_CONTROL
