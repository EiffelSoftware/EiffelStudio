indexing
	description	: "Text item to show the address of an object."
	date		: "$Date$"
	revision	: "$Revision$"

class ADDRESS_TEXT

inherit
	BASIC_TEXT
		rename
			image as address,
			make as old_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

	make (addr: like address; a_name: STRING; eclass: CLASS_C) is
			-- Initialize Current with address is `addr' and
			-- `e_class' is `eclass' referenced by `a_name'.
		do
			address := addr
			name := a_name
			e_class := eclass
		end

feature -- Properties

	name: STRING
			-- Name of the object address (it is an attribute,
			-- local or argument name)

	e_class: CLASS_C
			-- Eiffel class of which object at `address' is an
			-- instantiation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append `address' to `text'.
		do
			text.process_address_text (Current)
		end

end -- class ADDRESS_TEXT
