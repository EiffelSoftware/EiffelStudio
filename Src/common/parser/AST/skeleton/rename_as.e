-- Abstract description of a renaming pair

class RENAME_AS

inherit

	AST_EIFFEL

feature -- Attributes

	old_name: FEATURE_NAME;
			-- Name of the renamed feature

	new_name: FEATURE_NAME;
			-- New name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			old_name ?= yacc_arg (0);
			new_name ?= yacc_arg (1);
		ensure then
			old_name_exists: old_name /= Void;
			new_name_exists: new_name /= Void;
		end;
	
end
