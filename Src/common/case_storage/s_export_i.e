indexing

	description: 
		"Export status for features.";
	date: "$Date$";
	revision: "$Revision $"

deferred class S_EXPORT_I

feature -- Properties

	is_none: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_NONE
		do
			-- Do nothing
		end;

	is_set: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_SET_I ?
			-- (For future use)
		do
			-- Do nothing
		end;

	is_all: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_ALL_I ?
		do
			-- Do nothing
		end;

feature -- Comparison

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		require
			valid_other: other /= Void
		deferred
		end;

end -- class S_EXPORT_I
