-- Abstract representation of a routine-or-attribute offset table
-- for DLE in final mode

deferred class

	DLE_POLY_TABLE [T -> ENTRY]

inherit

	POLY_TABLE [T]
		redefine
			min_used, has_one_type
		end;

	SHARED_DLE;

	SHARED_TABLE

feature -- Access

	min_used: INTEGER is
			-- Minimum used type id
			-- When dealing with DLE, we have to take a pessimistic
			-- approach and consider that the minimum type id is used
			-- so that we can handle cases where it is not used in the
			-- static system but is in the dynamic
		do
			Result := min_type_id
		end;

feature -- Status report

	has_one_type: BOOLEAN is
			-- Is the type table not polymorphic?
			--| THIS IS TEMPORARY.
		do
			Result := false
		end;

	has_changed: BOOLEAN is
			-- Is the current table (dynamic system) different from
			-- the one generated in the static system?
		require
			dynamic_system: System.is_dynamic
		local
			entry: ENTRY
		do
			from
				finish
			until
				Result or before
			loop
				entry := item;
				Result := entry.used and not entry.was_used;
				back
			end
		end;

invariant

	dle_system: System.extendible or System.is_dynamic

end -- class DLE_POLY_TABLE
