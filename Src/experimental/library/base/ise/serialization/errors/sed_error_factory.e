note
	description: "Objects that provide instances of SED_ERROR"
	author: "Julian Rogers"
	last_editor: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_ERROR_FACTORY

feature -- Access

	new_missing_type_error (a_type: STRING): SED_ERROR
			-- Return a error representing a missing type `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			create Result.make_with_string ("Unknown class type" + a_type)
		ensure
			result_not_void: Result /= Void
		end

	new_missing_attribute_error (a_type_id: INTEGER; a_attribute_name: STRING): SED_ERROR
			-- Return a error representing a missing attribute named `a_attribute_name' in type `a_type'.
		require
			a_type_id_positive: a_type_id >= 0
			a_attribute_name_not_void: a_attribute_name /= Void
		local
			l_type: STRING
		do
			l_type := internal.class_name_of_type (a_type_id)
			create Result.make_with_string ("No attribute named '" + a_attribute_name + "' in class " + l_type)
		ensure
			result_not_void: Result /= Void
		end

	new_attribute_count_mismatch (a_type_id: INTEGER; a_received_attribute_count: INTEGER): SED_ERROR
			-- Return an error representing an attribute count mismatch for type `a_type' with a received attribute count of `a_received_attribute_count'.
		require
			a_type_id_positive: a_type_id >= 0
		local
			l_type: STRING
		do
			l_type := internal.class_name_of_type (a_type_id)
			create Result.make_with_string ("Attribute count mismatch in class " + l_type + " Expected " + internal.field_count_of_type (a_type_id).out + ", Received " + a_received_attribute_count.out)
		ensure
			result_not_void: Result /= Void
		end

	new_attribute_mismatch (a_type_id: INTEGER; a_attribute_name: STRING; a_attribute_type_id, a_received_attribute_type_id: INTEGER): SED_ERROR
			-- Return an error representing an attribute mismatch for attribute `a_attribute_name' of type `a_type' with
		require
			a_type_id_positive: a_type_id >= 0
			a_attribute_name_not_void: a_attribute_name /= Void
			a_attribute_type_id_non_negative: a_attribute_type_id >= 0
			a_received_attribute_type_id_non_negative: a_received_attribute_type_id >= 0
		do
			create Result.make_with_string ("Attribute mismatch in class " +
				internal.class_name_of_type (a_type_id) + " for attribute '" + a_attribute_name +
				"'. Expected " + internal.class_name_of_type (a_attribute_type_id) + ", Received " +
				internal.class_name_of_type (a_received_attribute_type_id))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	internal: INTERNAL
			-- Once access to internal.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

end
