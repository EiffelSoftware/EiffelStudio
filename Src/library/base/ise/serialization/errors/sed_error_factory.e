note
	description: "Objects that provide instances of SED_ERROR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julian Rogers"
	last_editor: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_ERROR_FACTORY

feature -- Access

	new_internal_error (a_msg: STRING): SED_ERROR
			-- Generic error message when something fails internally
		require
			a_msg_not_void: a_msg /= Void
		do
			create Result.make_with_string (a_msg)
		ensure
			result_not_void: Result /= Void
		end

	new_invalid_object_error (a_obj: ANY): SED_ERROR
			-- Object `a_obj' was retrieved but is not valid.
		do
			create Result.make_with_string ("Invalid retrieved object of type " + internal.type_name (a_obj))
		ensure
			result_not_void: Result /= Void
		end

	new_object_mismatch_error (a_obj: ANY): SED_ERROR
			-- Object `a_obj' was retrieved but its content is still mismatched.
		do
			create Result.make_with_string ("Unfixable object of type " + internal.type_name (a_obj))
		ensure
			result_not_void: Result /= Void
		end

	new_format_mismatch (a_old_version, a_new_version: NATURAL_32): SED_ERROR
			-- Return an error when the format is different from what we expected upon retrieval
		do
			create Result.make_with_string ("Storable format mismatch, got " + a_old_version.out + " but expected " + a_new_version.out + ".")
		ensure
			result_not_void: Result /= Void
		end

	new_missing_type_error (a_stored_type, a_adapted_type: STRING): SED_ERROR
			-- Return a error representing a missing type `a_stored_type' possibly adapted to `a_adapted_type'.
		require
			a_stored_type_not_void: a_stored_type /= Void
			a_adapted_type_not_void: a_adapted_type /= Void
		do
			if a_stored_type ~ a_adapted_type then
				create Result.make_with_string ("Unknown class type" + a_stored_type)
			else
				create Result.make_with_string ("Unknown class type" + a_stored_type + " and unknown adapted class type " + a_adapted_type)
			end
		ensure
			result_not_void: Result /= Void
		end

	new_missing_attribute_error (a_type_id: INTEGER; a_attribute_name: STRING): SED_ERROR
			-- Return a error representing a missing attribute named `a_attribute_name' in type `a_type'.
		require
			a_type_id_non_negative: a_type_id >= 0
			a_attribute_name_not_void: a_attribute_name /= Void
		local
			l_type: STRING
		do
			l_type := internal.class_name_of_type (a_type_id)
			create Result.make_with_string ("No attribute named '" + a_attribute_name + "' in type " + l_type)
		ensure
			result_not_void: Result /= Void
		end

	new_unknown_attribute_type_error (a_type_id: INTEGER; a_attribute_name: STRING): SED_ERROR
			-- Return a error representing an attribute whose type is unknown.
		require
			a_type_id_non_negative: a_type_id >= 0
			a_attribute_name_not_void: a_attribute_name /= Void
		local
			l_type: STRING
		do
			l_type := internal.class_name_of_type (a_type_id)
			create Result.make_with_string ("Attribute named '" + a_attribute_name + "' in type " + l_type + " has an unknown type")
		ensure
			result_not_void: Result /= Void
		end

	new_storable_version_mismatch_error (a_type_id: INTEGER; a_old_version_str: detachable STRING): SED_ERROR
			-- Return an error representing a mismatch in the storable_version attribute in type `a_type'.
		require
			a_type_id_non_negative: a_type_id >= 0
		local
			l_type, l_error_msg: STRING
			l_new_version: detachable IMMUTABLE_STRING_8
		do
			l_type := internal.class_name_of_type (a_type_id)
			l_new_version := internal.storable_version_of_type (a_type_id)
			create l_error_msg.make (256)
			l_error_msg.append ("Different version in class " + l_type + ".%N")
			l_error_msg.append ("Old version: ")
			if a_old_version_str = Void then
				l_error_msg.append ("None")
			else
				l_error_msg.append (a_old_version_str)
			end
			l_error_msg.append ("New version: ")
			if l_new_version = Void then
				l_error_msg.append ("None")
			else
				l_error_msg.append (l_new_version)
			end
			create Result.make_with_string (l_error_msg)
		ensure
			result_not_void: Result /= Void
		end


	new_attribute_count_mismatch (a_type_id: INTEGER; a_received_attribute_count: INTEGER): SED_ERROR
			-- Return an error representing an attribute count mismatch for type `a_type' with a received attribute count of `a_received_attribute_count'.
		require
			a_type_id_non_negative: a_type_id >= 0
		local
			l_type: STRING
		do
			l_type := internal.class_name_of_type (a_type_id)
			create Result.make_with_string ("Attribute count mismatch in class " + l_type +
				" Expected " + internal.persistent_field_count_of_type (a_type_id).out + ", Received " + a_received_attribute_count.out)
		ensure
			result_not_void: Result /= Void
		end

	new_attribute_mismatch (a_type_id: INTEGER; a_attribute_name: STRING; a_attribute_type_id, a_received_attribute_type_id: INTEGER): SED_ERROR
			-- Return an error representing an attribute mismatch for attribute `a_attribute_name' of type `a_type' with
		require
			a_type_id_non_negative: a_type_id >= 0
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

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
