indexing

	description:
		"Export status for features exported to all classes.";
	date: "$Date$";
	revision: "$Revision $"

class S_EXPORT_ALL_I

inherit

	S_EXPORT_I
		redefine
			is_all
		end

feature -- Properties

	is_all: BOOLEAN is
			-- Is Current exported to all? 
			-- (Yes it is)
		do
			Result := True
		end;

feature -- Comparison

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_all
		end;

end -- class S_EXPORT_ALL_I
