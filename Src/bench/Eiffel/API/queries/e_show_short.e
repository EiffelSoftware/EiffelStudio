indexing

	description:
		"Show the short form of a class.";
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_SHORT

inherit
	E_CLASS_CMD
		rename
			work as execute
		redefine
			execute
		end

create
	make, default_create

feature -- Status report

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

feature -- Status setting

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

feature -- Output

	execute is
			-- Execute Current command.
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			create ctxt;
			ctxt.set_is_short;
			ctxt.set_feature_clause_order (feature_clause_order);
			ctxt.set_one_class_only;
			ctxt.format (current_class);
			if not ctxt.error then
				structured_text := ctxt.text
			else
				create structured_text.make;
			end
		end;

end -- class E_SHOW_SHORT
