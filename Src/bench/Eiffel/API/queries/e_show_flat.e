indexing

	description:
		"Show the flat form of a class.";
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_FLAT

inherit
	E_CLASS_CMD
		redefine
			execute
		end

creation
	make, do_nothing

feature -- Output

	execute is
			-- Execute Current command.
		local
			ctxt: CLASS_TEXT_FORMATTER
		do
			!! ctxt;
			ctxt.format (current_class);
			if not ctxt.error then
				structured_text := ctxt.text
			else
				!! structured_text.make;
			end
		end;

end -- class E_SHOW_FLAT
