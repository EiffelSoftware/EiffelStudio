deferred class S_EXPORT_I 

feature

	is_none: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_NONE
		do
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

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		require
			valid_other: other /= Void
		deferred
		end;

end
