indexing

	description: 
		"Constants for special errors.";
	date: "$Date$";
	revision: "$Revision $"

class SPECIAL_CONST

feature -- Access

	Case_1: STRING is "Class TO_SPECIAL must have one formal generic parameter";

	Case_2: STRING is "Class TO_SPECIAL must have an attribute of type SPECIAL [T]";

	Case_3: STRING is "Class TO_SPECIAL must have a procedure `make_area'.";

	Case_4: STRING is "Class STRING must inherit from parent TO_SPECIAL [CHARACTER]";

	Case_5: STRING is "Class STRING must have exactly one attribute of reference type";

	Case_6: STRING is "Class STRING must have at least one creation procedure having an integer argument";

	Case_7: STRING is "Class ARRAY must have exactly one formal generic parameter";

	Case_8: STRING is "Class ARRAY must inherit from TO_SPECIAL [Generic #1]";

	Case_9: STRING is "Class ARRAY must have exactly one attribute of reference type";

	Case_10: STRING is "Class ARRAY must have at least one creation procedure with two integer arguments";

	Case_11: STRING is "Class SPECIAL must have exactly one formal generic parameter";

	Case_12: STRING is "Class SPECIAL must have a feature `item (INTEGER): Generic #1'";

	Case_13: STRING is "Class SPECIAL must have a feature `put (Generic #1, INTEGER)'";

	Case_14: STRING is "Non-expanded classes for basic types may not have generic parameters";

	Case_15: STRING is "Non-expanded classes for basic types must have only one attribute with a good associated type";

	Case_16: STRING is "Non-expanded classes for basic types may not have creation procedure";
	
	Case_17: STRING is "Class STRING must have a procedure with an integer argument named `set_count'";

	Case_18: STRING is "Class TUPLE must inherit from ARRAY [ANY]";

	Case_19: STRING is "Class TUPLE must have exactly one creation procedure `make'";

end -- class SPECIAL_CONST
