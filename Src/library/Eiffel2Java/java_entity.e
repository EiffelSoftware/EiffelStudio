indexing
	description: "Description of a java entity (either a class or an instance of a class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JAVA_ENTITY

feature -- Reflection

	method_id (feature_name: STRING; signature: STRING): POINTER is
			-- Find method_id for `feature_name' with signature 
			-- encoded by `signature'
		require
			feature_name_not_void: feature_name /= Void
			feature_name_not_empty: not feature_name.is_empty
			signature_not_void: signature /= Void
			signature_not_empty: not signature.is_empty
		deferred
		ensure
			method_exists: Result /= default_pointer	
		end

	field_id (attribute_name: STRING; signature: STRING): POINTER is
			-- Find field_id used for `attribute_name' with signature
			-- encoded by `signature'.
		require
			attribute_name_not_void: attribute_name /= Void
			attribute_name_not_empty: not attribute_name.is_empty
			signature_not_void: signature /= Void
			signature_not_empty: not signature.is_empty
		deferred
		end

feature -- call object's methods

	void_method (mid: POINTER; args: JAVA_ARGS) is
			-- Call a Java procedure with method_id "mid" and 
			-- arguments "args.
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	string_method (mid: POINTER; args: JAVA_ARGS): STRING is
			-- Call an instance function that returns a STRING.
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	integer_method (mid: POINTER; args: JAVA_ARGS): INTEGER is
			-- Call an instance function that returns an INTEGER.
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	short_method (mid: POINTER; args: JAVA_ARGS): INTEGER_16 is
			-- Call an instance function that returns a Short (in 
			-- Eiffel we still return an INTEGER).
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	long_method (mid: POINTER; args: JAVA_ARGS): INTEGER_64 is
			-- Call an instance function that returns an Long. This 
			-- function is not implemented. 
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	double_method (mid: POINTER; args: JAVA_ARGS): DOUBLE is
			-- Call an instance function that returns a DOUBLE.
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	float_method (mid: POINTER; args: JAVA_ARGS): REAL is
			-- Call an instance function that returns a REAL.
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	char_method (mid: POINTER; args: JAVA_ARGS): CHARACTER is
			-- Call an instance function that returns a char
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	boolean_method (mid: POINTER; args: JAVA_ARGS): BOOLEAN is
			-- Call an instance function that returns a boolean
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	object_method (mid: POINTER; args: JAVA_ARGS): JAVA_OBJECT is
			-- Call an instance function that returns a java object
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

	byte_method (mid: POINTER; args: JAVA_ARGS): INTEGER_8 is
			-- Call an instance function that return a byte
			-- ( 8-bit integer (signed)), in Eiffel return
			-- a INTEGER_8
		require
			mid_not_null: mid /= default_pointer
		deferred
		end

feature -- Access object's attributes

	integer_attribute (fid: POINTER): INTEGER is
			-- Access to an integer attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	string_attribute (fid: POINTER): STRING is
			-- Access to a String attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	object_attribute (fid: POINTER): JAVA_OBJECT is
			-- Access to a java object attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	boolean_attribute (fid: POINTER): BOOLEAN is
			-- Access to a boolean attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	char_attribute (fid: POINTER): CHARACTER is
			-- Access to a 'char' attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	float_attribute (fid: POINTER): REAL is
			-- Access to a 'float' attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	double_attribute (fid: POINTER): DOUBLE is
			-- Access to a double attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end
	
	byte_attribute (fid: POINTER): INTEGER_8 is
			-- Access to a 'byte' attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	short_attribute (fid: POINTER): INTEGER_16 is
			-- Access to a 'short' attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

	long_attribute (fid: POINTER): INTEGER_64 is
			-- Access to a 'long' attribute
		require
			fid_not_null: fid /= default_pointer
		deferred
		end

feature -- Setting object's attribute

	set_integer_attribute (fid: POINTER; value: INTEGER) is
			-- Set an 'integer' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			integer_attribute_set: integer_attribute (fid) = value
		end

	set_string_attribute (fid: POINTER; value: STRING) is
			-- Set a 'String' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			string_attribute_set: equal (string_attribute (fid), value)
		end
	
	set_object_attribute (fid: POINTER; value: JAVA_OBJECT) is
			-- Set a java object attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			object_attribute_set: object_attribute (fid) = value
		end

	set_boolean_attribute (fid: POINTER; value: BOOLEAN) is
			-- Set a 'boolean' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			boolean_attribute_set: boolean_attribute (fid) = value
		end

	set_char_attribute (fid: POINTER; value: CHARACTER) is 
			-- Set a 'char' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			char_attribute_set: char_attribute (fid) = value
		end

	set_float_attribute (fid: POINTER; value: REAL) is
			-- Set a 'float' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			float_attribute_set: float_attribute (fid) = value
		end

	set_double_attribute (fid: POINTER; value: DOUBLE) is
			-- Set a 'double' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			double_attribute_set: double_attribute (fid) = value
		end
	
	set_byte_attribute (fid: POINTER; value: INTEGER_8) is
			-- Set a 'byte' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			byte_attribute_set: byte_attribute (fid) = value
		end

	set_short_attribute (fid: POINTER; value: INTEGER_16) is
			-- Set a 'short' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			short_attribute_set: short_attribute (fid) = value
		end

	set_long_attribute (fid: POINTER; value: INTEGER_64) is
			-- Set a 'short' attribute to 'value'
		require
			fid_not_null: fid /= default_pointer
		deferred
		ensure
			long_attribute_set: long_attribute (fid) = value
		end

end -- class JAVA_ENTITY


--|----------------------------------------------------------------
--| Eiffel2Java: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

