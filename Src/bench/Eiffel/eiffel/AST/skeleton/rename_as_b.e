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
		undefine
			simple_format
		redefine
			format
		end

feature -- Attributes

	old_name: FEATURE_NAME_B;
			-- Name of the renamed feature

	new_name: FEATURE_NAME_B;
			-- New name

feature -- Formatter

	format (ctxt : FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			old_name.format (ctxt);
			ctxt.put_space;
			ctxt.put_text_item (ti_As_keyword);
			ctxt.put_space;
			new_name.format (ctxt);
			ctxt.commit
		end;
	
end -- class RENAME_AS_B
