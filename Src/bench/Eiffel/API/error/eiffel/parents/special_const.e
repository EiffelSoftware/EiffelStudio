-- Constants for special errors

class SPECIAL_CONST

feature

	Case_1: STRING is "Class TO_SPECIAL must have one formal generic parameter";

	Case_2: STRING is "Class TO_SPECIAL must have an attribute of type SPECIAL [T]";

	Case_3: STRING is "Class TO_SPECIAL must have a procedure `make_area'.";

	Case_4: STRING is "Class STRING must inherit from parent TO_SPECIAL [CHARACTER]";

	Case_5: STRING is "Class STRING must have exactly one reference attribute";

	Case_6: STRING is "Class STRING should have only one creation procedure having an integer argument";

	Case_17: STRING is "Class STRING should have a procedure with an integer argument named `set_count'";

	Case_7: STRING is "Class ARRAY must have exactly one formal generic parameter";

	Case_8: STRING is "Class ARRAY must inherit from TO_SPECIAL [Generic #1]";

	Case_9: STRING is "Class ARRAY must have exactly one reference attribute";

	Case_10: STRING is "Class ARRAY should have only one creation procedure with two integer arguments";

	Case_11: STRING is "Class SPECIAL must have exacly one formal generic parameter";

	Case_12: STRING is "Class SPECIAL must have a feature `item (INTEGER): Generic #1'";

	Case_13: STRING is "Class SPECIAL must have a feature `put (Generic #1, INTEGER)'";

	Case_14: STRING is "Simple reference type classes cannot have generic parameters";

	Case_15: STRING is "Simple reference type classes must have only one attribute with a good associated type";

	Case_16: STRING is "Simple reference type classes cannot have creation procedure";

end
