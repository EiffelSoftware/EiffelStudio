-- Constants for special errors

class SPECIAL_CONST

feature

	Case_1: INTEGER is unique;
			-- Class TO_SPECIAL must have one formal generic parameter

	Case_2: INTEGER is unique;
			-- Class TO_SPECIAL must have an attribute of type
			-- SPECIAL [T]

	Case_3: INTEGER is unique;
			-- Class TO_SPECIAL must have a procedure `make_area'.

	Case_4: INTEGER is unique;
			-- Class STRING doesn't inherit from parent TO_SPECIAL [CHARACTER]

	Case_5: INTEGER is unique;
			-- Class STRING has not exactly one reference attribute

	Case_6: INTEGER is unique;
			-- Class STRING should have only one creation procedure
			-- having an integer argument

	Case_17: INTEGER is unique;
			-- Class STRING should have a procedure with an integer argument
			-- named `set_count'

	Case_7: INTEGER is unique;
			-- Class ARRAY doesn't have exactly one forma generic parameter

	Case_8: INTEGER is unique;
			-- Class ARRAY doesn't inherit from parent TO_SPECIAL [Generic #1]

	Case_9: INTEGER is unique;
			-- Class ARRAY has not exactly one reference attribute

	Case_10: INTEGER is unique;
			-- Class ARRAY hould have only one creation procedure with
			-- two integer arguments

	Case_11: INTEGER is unique;
			-- Class SPECIAL has not exacly one formal generic parameter

	Case_12: INTEGER is unique;
			-- Class SPECIAL has not a feature `item (INTEGER): Generic #1'

	Case_13: INTEGER is unique;
			-- Class SPECIAL has not a feature `put (Generic #1, INTEGER)'

	Case_14: INTEGER is unique;
			-- Simple reference type classes cannot have generic parameters

	Case_15: INTEGER is unique;
			-- Simple reference type classes must have only one 
			-- attribute with a good associated type

	Case_16: INTEGER is unique;
			-- Simple reference type classes cannot have creation
			-- procedure

end
