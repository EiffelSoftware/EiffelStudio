indexing

	description:
		"Text item to show the address of an object.";
	date: "$Date$";
	revision: "$Revision$"

class ADDRESS_TEXT

inherit
	BASIC_TEXT
		rename
			image as address,
			make as old_make
		redefine
			append_to
		end

creation
	make

feature -- Initialization

	make (addr: like address; a_name: STRING; eclass: E_CLASS) is
			-- Initialize Current with address is `addr' and
			-- `e_class' is `eclass' referenced by `a_name'.
		do
			name := a_name;
			address := addr;
			e_class := eclass
		end;

feature -- Properties

	name: STRING;
			-- Name of the object address (it is an attribute,
			-- local or argument name)

	e_class: E_CLASS;
			-- Eiffel class of which object at `address' as an
			-- instantiation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append `address' to `text'.
		do
			text.process_address_text (Current)
		end;

end -- class ADDRESS_TEXT
