indexing

	description: 
		"Export status for features exported to no classes.";
	date: "$Date$";
	revision: "$Revision $"

class S_EXPORT_NONE_I

inherit

	S_EXPORT_I
		redefine
			is_none
		end

feature -- Properties

	is_none: BOOLEAN is
			-- Is Current exported to none?
			-- (Yes it is)
		do
			Result := true
		end;

feature -- Comparison

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_none
		end;

end -- class S_EXPORT_NONE_I
