class EWB_ACTIVATABLE

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

end -- class EWB_ACTIVATABLE
