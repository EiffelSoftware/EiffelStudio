indexing

	description: "Handle view information.";
	date: "$Date$";
	revision: "$Revision $"

deferred class HANDLE_VIEW

inherit

	VIEW;

feature -- Property

	data: HANDLE_DATA is
			-- Data associated with Current
		deferred
		end;

end -- HANDLE_VIEW
