indexing

	description: "Explanation text.";
	date: "$Date$";
	revision: "$Revision $"

class EXPLANATION_DATA

inherit

	DESCRIPTION_DATA
		redefine
			default_value,
			is_valid_for
		end

creation

	make_with_default, make_from_storer

feature -- Properties

	default_value: STRING is "<<explanation>>"

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			ld: LINKABLE_DATA
		do
			ld ?= data;
			--Result := ld /= Void and then ld.explanation = Current
		end;

end -- class EXPLANATION_DATA

