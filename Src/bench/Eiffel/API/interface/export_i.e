deferred class EXPORT_I 

inherit
	PART_COMPARABLE

	
feature -- Queries

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export clause for client `client' ?
		require
			good_argument: client /= Void;
		deferred
		end;

	is_none: BOOLEAN is
			-- Is the current object an instance of EXPORT_NONE_I ?
		do
			-- Do nothing
		end;

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			-- Do nothing
		end;

	is_all: BOOLEAN is
			-- Is the current object an instance of EXPORT_ALL_I ?
		do
			-- Do nothing
		end;

feature -- Concatanation of export statuses

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		require
			good_argument: other /= Void
		deferred
		end;

feature -- Incrementality

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [since this relation is not symetric, we have to call
			-- something like "old_export_status.equiv (new_export_status)']
		require
			good_argument: other /= Void;
		deferred
		end;

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		deferred
		end;


feature -- Debug purpose

	trace is
			-- Debug purpose
		deferred
		end;

feature -- formatter

	infix "<" (other: EXPORT_I): BOOLEAN is
		deferred
		end;
			

end
