indexing
	description:  "Method dispatcher for Eiffel routine and attribute access. Uses CECIL."
	keywords:     "method dispatch cecil"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end"

class METHOD_DISPATCHER

inherit
	FEATURE_TYPES

creation
	make

feature -- Initialisation
	make(ignore_invisible:BOOLEAN) is
		do
			if ignore_invisible then
				c_ignore_invisible
			end
		end

feature -- Status
	is_class_visible(class_name:STRING):BOOLEAN is
			-- unless a class is described as VISIBLE in the ace file, these
			-- feeatures will not work. Use is_class_visible to test whether
			-- you may use the other features of this class on it.
		require
			Valid_class_name: class_name /= Void and then not class_name.empty
		local
			c_class_name: ANY
		do
			c_class_name := class_name.to_c
			Result := c_is_class_visible($c_class_name)
		end

	is_valid_feature(class_name:STRING; feature_name:STRING):BOOLEAN is
			-- is the call 'class_name'.'feature_name' a valid feature call (of any signature)
		require
			Class_name_exists: class_name /= Void and then not class_name.empty
			Class_visible: is_class_visible(class_name)
			Feature_name_exists: feature_name /= Void and then not feature_name.empty
		local
			c_class_name, c_feature_name : ANY
		do
			c_class_name := class_name.to_c
			c_feature_name := feature_name.to_c
			Result := c_is_valid_feature($c_class_name, $c_feature_name)
		end

feature -- Creation
	create_object(class_name:STRING; make_proc_name:STRING; make_arg:ANY):ANY is
		require
			Class_name_valid: class_name /= Void and then not class_name.empty
			Make_proc_name_valid: make_proc_name /= Void and then not make_proc_name.empty
		local
			c_class_name, c_proc_name:ANY
		do
			c_class_name := class_name.to_c
			c_proc_name := make_proc_name.to_c

			Result := c_create_obj($c_class_name, $c_proc_name, $make_arg)
		end

feature -- Dispatch
	dispatch_feature (obj:ANY; feature_name:STRING; arg:ANY; feature_type:INTEGER) is
			-- dispatch any feature call
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_feature($obj, $c_feature_name, $arg, feature_type)
		end

	dispatch_procedure (obj:ANY; feature_name:STRING; arg:ANY) is
			-- dispatch a procedure call. Signature: PROC (ARG)
		do
			dispatch_feature (obj, feature_name, arg, Procedure)
		end

	dispatch_fn_reference (obj:ANY; feature_name:STRING; arg:ANY):ANY is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : REFERENCE
		do
			dispatch_feature (obj, feature_name, arg, Function_reference)
			Result := c_result_obj
		end

	dispatch_fn_boolean (obj:ANY; feature_name:STRING; arg:ANY):BOOLEAN is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : BOOLEAN
		do
			dispatch_feature (obj, feature_name, arg, Function_boolean)
			Result := c_result_bool
		end

	dispatch_fn_character (obj:ANY; feature_name:STRING; arg:ANY):CHARACTER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : CHARACTER
		do
			dispatch_feature (obj, feature_name, arg, Function_character)
			Result := c_result_char
		end

	dispatch_fn_integer (obj:ANY; feature_name:STRING; arg:ANY):INTEGER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : INTEGER
		do
			dispatch_feature (obj, feature_name, arg, Function_integer)
			Result := c_result_int
		end

	dispatch_fn_real (obj:ANY; feature_name:STRING; arg:ANY):REAL is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : REAL
		do
			dispatch_feature (obj, feature_name, arg, Function_real)
			Result := c_result_real
		end

	dispatch_fn_double (obj:ANY; feature_name:STRING; arg:ANY):DOUBLE is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : DOUBLE
		do
			dispatch_feature (obj, feature_name, arg, Function_double)
			Result := c_result_double
		end

	dispatch_fn_pointer (obj:ANY; feature_name:STRING; arg:ANY):POINTER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : POINTER
		do
			dispatch_feature (obj, feature_name, arg, Function_pointer)
			Result := c_result_pointer
		end

	dispatch_fn_bit (obj:ANY; feature_name:STRING; arg:ANY):BIT_REF is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : BIT_REF
		do
			dispatch_feature (obj, feature_name, arg, Function_bit)
			Result := c_result_bit
		end

	dispatch_field_reference (obj:ANY; feature_name:STRING):ANY is
			-- obtain a field (signature: FEATURE : ANY)
		do
			dispatch_feature (obj, feature_name, Void, Field_reference)
			Result := c_result_obj
		end

feature {NONE} -- External
	c_ignore_invisible is
		external
		   "C"
		end

	c_create_obj(c_str_class_name, c_make_proc_name, c_make_arg:POINTER):ANY is
		external
		   "C"
		end

	c_is_valid_feature(c_str_class_name:POINTER; c_str_feature_name:POINTER):BOOLEAN is
		external
		   "C"
		end

	c_is_class_visible(c_class_name:POINTER):BOOLEAN is
		external
		   "C"
		end

	c_dispatch_feature (c_obj:POINTER; c_feature:POINTER; c_any_arg:POINTER; feature_type:INTEGER) is
		external
		   "C"
		end

	c_result_char:CHARACTER is
		external
		   "C"
		end

	c_result_bool:BOOLEAN is
		external
		   "C"
		end

	c_result_int:INTEGER is
		external
		   "C"
		end

	c_result_real:REAL is
		external
		   "C"
		end

	c_result_double:DOUBLE is
		external
		   "C"
		end

	c_result_pointer:POINTER is
		external
		   "C"
		end

	c_result_bit:BIT_REF is
		external
		   "C"
		end

	c_result_obj:ANY is
		external
		   "C"
		end

end
	

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

