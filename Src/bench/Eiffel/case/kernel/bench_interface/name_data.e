indexing

	description: "Data that has a name.";
	date: "$Date$";
	revision: "$Revision $"

deferred class NAME_DATA

inherit

	COMPARABLE
		undefine 
			copy, is_equal
		end;
	DATA
		undefine 
			copy, is_equal
		end

feature -- Properties

	name: STRING is
			-- Current name
		deferred
		end;

feature -- Comparison 

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current's name before or after other's name?
		do
			Result := name < other.name
		end;

feature -- Setting

	set_name (s: STRING) is
			-- Update `name'.
		require
			valid_name: s /= Void;
			not_empty: not s.empty
		deferred
		end;

	--update_from_namer (namer: NAMER_WINDOW) is
	--	do
	--		set_name (namer.entered_text);
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (False, False);
	--		namer.set_text (name);
	--	end;

feature -- Update

	update_name is
			-- Update relevant details after a name change.
		deferred
		end;

invariant

	non_void_name: name /= Void

end -- class NAME_DATA
