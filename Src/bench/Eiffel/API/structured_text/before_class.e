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

	make (c: like class_c) is
			-- Initialize Current with class_c `c'
		do
			class_c := c;
		ensure
			class_c = c
		end;

feature -- Properties

	class_c: CLASS_C;
			-- Associated compiled class

	class_name: STRING is
			-- Class name of compiled class
		do
			Result := clone (class_c.class_name);
			Result.to_upper
		end;
			
feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current before class item to `text'.
        do
			text.process_before_class (Current)
        end

end -- class BEFORE_CLASS
