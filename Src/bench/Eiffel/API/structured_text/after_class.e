indexing

	description: 
		"Text item that appears add the end of class text.";
	date: "$Date$";
	revision: "$Revision $"

class AFTER_CLASS

inherit

	BEFORE_CLASS
		redefine
			image, append_to
		end

create

	make

feature -- Properties

	image: STRING is
			-- Text representing Current text
		do	
			create Result.make (0);
			Result.append (" -- class ");
			Result.append (e_class.name_in_upper);
		end;

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current after class item to `text'.
        do
			text.process_after_class (Current)
        end

end -- class AFTER_CLASS
