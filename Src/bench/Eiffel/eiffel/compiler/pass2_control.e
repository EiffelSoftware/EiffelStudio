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

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			Precursor {PASS_CONTROL}
			create old_externals.make (50)
			create new_externals.make (50)
		end

feature -- Settings

	add_external (an_external: EXTERNAL_I) is
			-- Assign `an_external' to `new_externals'.
		require
			an_external_not_void: an_external /= Void
		do
			new_externals.extend (an_external)
		end

	remove_external (an_external: EXTERNAL_I) is
			-- Add `an_external' to `old_externals'.
		require
			an_external_not_void: an_external /= Void
		do
			if not old_externals.has (an_external) then
				old_externals.extend (an_external)
			end
		end

feature -- Processing

	process_externals is
			-- Update the system external feature controler
		require
			new_externals_exists: new_externals /= Void
		local
			l_is_il_generation: BOOLEAN
		do
			l_is_il_generation := System.il_generation
			from
				old_externals.start
			until
				old_externals.after
			loop
				Externals.remove_occurrence (old_externals.item.external_name_id)
				if l_is_il_generation then
					Il_c_externals.remove_external (old_externals.item)
				end
				old_externals.forth
			end

			from
				new_externals.start
			until
				new_externals.after
			loop
				Externals.add_occurrence (new_externals.item.external_name_id)
				if l_is_il_generation then
					Il_c_externals.add_external (new_externals.item)
				end
				new_externals.forth
			end
		end

feature -- Removal

	wipe_out is
			-- Empty the structure
		do
			Precursor {PASS_CONTROL}
			old_externals.wipe_out
			new_externals.wipe_out
		end

feature -- Access

	old_externals: ARRAYED_LIST [EXTERNAL_I]
			-- Old externals written in a class
			-- | Processed by feature `pass2_control' of FEATURE_TABLE

	new_externals: ARRAYED_LIST [EXTERNAL_I]
			-- New externals written in a class
			-- | Processed by feature `feature_unit' of INHERIT_TABLE

end -- class PASS2_CONTROL
