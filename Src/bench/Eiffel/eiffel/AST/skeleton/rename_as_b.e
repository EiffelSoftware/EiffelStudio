indexing

	description: "Abstract description of a renaming pair. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class RENAME_AS_B

inherit

	RENAME_AS
		redefine
			old_name, new_name
		end;

	AST_EIFFEL_B

feature -- Attributes

	old_name: FEATURE_NAME_B;
			-- Name of the renamed feature

	new_name: FEATURE_NAME_B;
			-- New name

end -- class RENAME_AS_B
