indexing

	description: 
		"Text item that is inserted before the class text.";
	date: "$Date$";
	revision: "$Revision $"

class BEFORE_CLASS

inherit

	TEXT_ITEM
		rename
			empty_string as  image
		end

creation

	make

feature -- Initialization

	make (c: like e_class) is
			-- Initialize Current with e_class `c'
		do
			e_class := c;
		ensure
			set: e_class = c
		end;

feature -- Properties

	e_class: CLASS_C;
			-- Associated compiled class

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current before class item to `text'.
        do
			text.process_before_class (Current)
        end

end -- class BEFORE_CLASS
