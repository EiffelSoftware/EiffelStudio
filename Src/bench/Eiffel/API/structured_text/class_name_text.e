indexing

	description: 
		"Item to denote a class_name.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_NAME_TEXT

inherit

	BASIC_TEXT
		rename
			make as old_make
		redefine
			append_to
		end

creation

	make

feature -- Initialization

    make (t: like image; c: like class_i) is
            -- Initialize Current with class_i `e'
            -- and image `t'.
        do
            image := t;
            class_i := c;
        ensure
            set: image = t and then
                    class_i = c
        end;

feature -- Property

	class_i: CLASS_I;
			-- Eiffel class associated with class text

feature -- Access

	file_name: STRING is
			-- Name of the file where the class text is stored;
			-- The final ".e" has been removed
		local
			count: INTEGER
		do
			if class_i = Void then
				!! Result.make (0)
			else
				Result := clone (class_i.file_name)
			end
			count := Result.count;
			if 
				count > 1 and then 
				Result.item (count) = 'e' and then
				Result.item (count - 1) = '.'
			then
				Result.head (count - 2)
			end
		ensure
			non_void_result: Result /= Void
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_class_name_text (Current)
		end

end -- class CLASS_NAME_TEXT
