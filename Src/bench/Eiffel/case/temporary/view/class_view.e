indexing

	description: "View information for a given class.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_VIEW

inherit

	LINKABLE_VIEW

creation

	make

feature {NONE} -- Initialization

	make (class_data: CLASS_DATA) is
			-- Initialize Current with `class_data'.
		do
			update_from (class_data);
		end

end -- class CLASS_VIEW
