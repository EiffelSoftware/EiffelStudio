deferred class EXPORT_I 

inherit

	PART_COMPARABLE;
	COMPILER_EXPORTER

feature -- Properties

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

feature -- Access

	is_exported_to (c: CLASS_C): BOOLEAN is
			-- Is current exported to `c'?
		do
			Result := valid_for (c)
		end;

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
		deferred
		end;

feature {COMPILER_EXPORTER} -- Queries

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export clause for client `client' ?
		require
			good_argument: client /= Void;
		deferred
		end;

    is_subset (other: EXPORT_I): BOOLEAN is
            -- Is Current a subset or equal to other?
        require
            valid_other: other /= Void
        deferred
        end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [since this relation is not symetric, we have to call
			-- something like "old_export_status.equiv (new_export_status)']
		require
			good_argument: other /= Void;
		deferred
		end;

	trace is
			-- Debug purpose
		deferred
		end;

feature {COMPILER_EXPORTER} -- Concatanation of export statuses

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		require
			good_argument: other /= Void
		deferred
		end;

feature -- Incrementality

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void
		deferred
		end;

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
			-- Append a representation of `Current' to `st'.
		deferred
		end

feature {FEATURE_CLAUSE_EXPORT, FORMAT_FEAT_CONTEXT} -- formatter

	format (ctxt: FORMAT_CONTEXT) is
		deferred
		end;

feature {NONE} -- Implementation

	S_l_curly: STRING is "{"
	S_r_curly: STRING is "}"

end
