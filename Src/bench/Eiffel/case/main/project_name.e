indexing

	description: "EiffelCase project name.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_NAME

inherit

	STRING

creation

	make

feature -- Properties

	system_view_id: INTEGER;

	project_name: STRING

feature -- Setting

	set_names (proj_n, view_n: STRING) is
			-- Set view_name to `n'.
		require
			valid_proj_n: proj_n /= Void
		do
			project_name := proj_n;
			if project_name.item (1) = '.' then
				extend ('[');
				append (project_name);
				extend (']')
			else
				append (project_name);
			end;
			if view_n /= Void then
				append (": ");
				append (view_n);
			end
		end;

	set_system_view_id (i: INTEGER) is
			-- Set view_id to `n'.
		require
			valid_i: i > 0
		do
			system_view_id := i
		end

end -- class PROJECT_NAME
