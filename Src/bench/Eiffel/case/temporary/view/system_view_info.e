indexing

	description: "Basic information about a system view.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_VIEW_INFO

inherit

	DATA

creation

	make

feature {NONE} -- Initialization

	make (i: like view_id; name: like view_name) is
			-- Initialize Current with `i' and `name'
		require
			valid_i: i > 0;
			valid_name: name /= Void
		do
			view_id := i;
			view_name := name
		ensure
			set: view_id = i and then view_name = name
		end;

feature -- Properties

	view_id: INTEGER;
		-- System id of View 

	view_name: STRING;
		-- System name of View

	focus: STRING is
		do
			!! Result.make (0);
			Result.append ("view_name: ");
			Result.append (view_name);
			Result.append (" view_id: ");
			Result.append_integer (view_id);
		end;

	stone: OTHER_VIEW_STONE is
			-- Stone for Current
		do
			!! Result.make (Current)
		end;

	stone_type: INTEGER is
		do
		end;

feature -- Setting

	set_view_name (s: STRING) is
		require
			valid_s: s /= Void
		do
			view_name := s
		end;

	set_view_id (i: INTEGER) is
		require
			valid_i: i > 0
		do
			view_id := i
		end

end -- class SYSTEM_VIEW_INFO
