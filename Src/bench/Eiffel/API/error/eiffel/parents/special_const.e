indexing
	description: "Constants for special errors."
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIAL_CONST

feature -- Access: STRING

	string_case_1: STRING is "Class STRING must have an attribute `area' of type SPECIAL [CHARACTER]"

	string_case_2: STRING is "Class STRING must have exactly one attribute of reference type"

	string_case_3: STRING is "Class STRING must have at least one creation procedure having an integer argument"

	string_case_4: STRING is "Class STRING must have a procedure with an integer argument named `set_count'"

	string_case_5: STRING is "Class STRING must have an attribute of type integer named `internal_hash_code'"
	
feature -- Access: ARRAY

	array_case_1: STRING is "Class ARRAY must have exactly one formal generic parameter"

	array_case_2: STRING is "Class ARRAY must have an attribute `area' of type SPECIAL [T]"

	array_case_3: STRING is "Class ARRAY must have exactly one attribute of reference type"

	array_case_4: STRING is "Class ARRAY must have at least one creation procedure with two integer arguments"
	
feature -- Access: SPECIAL

	special_case_1: STRING is "Class SPECIAL must have exactly one formal generic parameter and be marked frozen"

	special_case_2: STRING is "Class SPECIAL must have a procedure `make (INTEGER)'"

	special_case_3: STRING is "Class SPECIAL must have a creation procedure `make (INTEGER)'"

	special_case_4: STRING is "Class SPECIAL must have a feature `item (INTEGER): Generic #1'"

	special_case_5: STRING is "Class SPECIAL must have a feature `put (Generic #1, INTEGER)'"

feature -- Access: Basic types

	basic_case_1: STRING is "Classes for basic types may not have generic parameters"

	basic_case_2: STRING is "Classes for basic types must have only one attribute with a good associated type"

	basic_case_3: STRING is "Classes for basic types must have one attribute of name `item'"

	basic_case_4: STRING is "Classes for basic types must have one procedure `set_item'"

	typed_pointer_case_1: STRING is "Class TYPED_POINTER must have one formal generic parameter"

	typed_pointer_case_2: STRING is "Class TYPED_POINTER must have one attribute of type POINTER"

	typed_pointer_case_3: STRING is "Class TYPED_POINTER must have one attribute of name `pointer_item'"

	typed_pointer_case_4: STRING is "Class TYPED_POINTER must have one procedure `set_item'"
	
feature -- Access: NATIVE_ARRAY

	native_array_case_1: STRING is "Class NATIVE_ARRAY must have one formal generic parameter"

	native_array_case_2: STRING is "Class NATIVE_ARRAY must have exactly one creation procedure `make'"

	native_array_case_3: STRING is "Class NATIVE_ARRAY must have a feature `item (INTEGER): Generic #1'"
	
	native_array_case_4: STRING is "Class NATIVE_ARRAY must have a feature `infix %"@%" (INTEGER): Generic #1'"
	
	native_array_case_5: STRING is "Class NATIVE_ARRAY must have a feature `put (INTEGER, Generic #1)'"

	native_array_case_6: STRING is "Class NATIVE_ARRAY must have a feature `count: INTEGER'"

end -- class SPECIAL_CONST
