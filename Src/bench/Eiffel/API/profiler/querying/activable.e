indexing

	description:
		"Notion of an activatable / inactivatable part of the total %
		%query.";
	date: "$Date$";
	revision: "$Revision$"

class ACTIVATABLE

feature -- Properties

	is_active: BOOLEAN is
			-- Is `Current' taken into account during the
			-- computation of the result of the query?
		do
			Result := int_active;
		end;

feature -- Setting

	activate is
		do
			int_active := true;
		ensure
			activated: is_active;
		end;

	inactivate is
		do
			int_active := false;
		ensure
			inactivated: not is_active;
		end;

feature {NONE} -- Attributes

	int_active: BOOLEAN;

end -- class ACTIVATABLE
