indexing
	description:
		"[
			Objects that hold information regarding all constants in EiffelBuild.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONSTANTS_HANDLER
	
inherit
	ANY
		redefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_XML_UTILITIES
		export
			{NONE} all
		redefine
			default_create
		end
	
create
	default_create
	
feature {NONE} -- Initialzation

	default_create is
			-- Create and initialize `Current'.
		do
			create String_constants.make (4)
			create Integer_constants.make (4)
			create deleted_constants.make (4)
			create all_constant_names.make (4)
			create all_constants.make (4)
			all_constant_names.compare_objects
		end

feature -- Access

	all_constant_names: ARRAYED_LIST [STRING]
		-- All names of constants referenced by `Current'.
		-- This prevents us from having to rebuild a list
		-- every time that we wish to determine if a string is
		-- already in use as a constant.

	supported_types: ARRAYED_LIST [STRING] is
			-- All supported constant types by name.
		once
			create Result.make (3)
			Result.extend (Integer_constant_type)
			Result.extend (String_constant_type)
			Result.extend (Directory_constant_type)
			Result.compare_objects
		ensure
			obejct_comparison_on: Result.object_comparison
		end
		
	all_constants: HASH_TABLE [GB_CONSTANT, STRING]	
		-- All constants accessible by name.

	integer_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All integer constants in system.
		
	string_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All string constants in system.
		
	deleted_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All constants that are currently flagged as deleted.
	
	string_is_constant_name (a_string: STRING): BOOLEAN is
			-- Is `a_string' already used as a constant name?
		require
			a_string_not_void: a_string /= Void
		do
			Result :=  all_constant_names.has (a_string)
		end

feature -- Element change

	remove_constant (a_constant: GB_CONSTANT) is
			-- Remove `a_constant' from all constants in system.
			-- Flag as deleted.
		require
			a_constant_not_void: a_constant /= Void
		do
				--| FIXME not good, as unoptimal.
			integer_constants.prune_all (a_constant)			
			string_constants.prune_all (a_constant)

			all_constant_names.prune_all (a_constant.name)
			deleted_constants.extend (a_constant)
			constants_dialog.update_for_removal (a_constant)
		ensure
			constant_deleted: deleted_constants.has (a_constant)
		end

	add_integer (integer_constant: GB_INTEGER_CONSTANT) is
			-- Add `integer_constant' to `integer_constants'.
		require
			constant_not_void: integer_constant /= Void
		do
			integer_constants.extend (integer_constant)
			all_constant_names.extend (integer_constant.name)
			if deleted_constants.has (integer_constant) then
				deleted_constants.prune_all (integer_constant)
			end
			Constants_dialog.update_for_addition (integer_constant)
			all_constants.put (integer_constant, integer_constant.name)
		ensure
			contained: integer_constants.has (integer_constant)
			count_increased: integer_constants.count = old integer_constants.count + 1
		end
		
	add_string (string_constant: GB_STRING_CONSTANT) is
			-- Add `string_constant' to `string_constants'
		require
			constant_not_void: string_constant /= Void
		do
			string_constants.extend (string_constant)
			all_constant_names.extend (string_constant.name)
			if deleted_constants.has (string_constant) then
				deleted_constants.prune_all (string_constant)
			end
			Constants_dialog.update_for_addition (string_constant)
			all_constants.put (string_constant, string_constant.name)
		ensure
			contained: string_constants.has (string_constant)
			count_increased: string_constants.count = old string_constants.count + 1
		end
		
	build_constant_from_xml (element: XM_ELEMENT) is
			-- Add a constant based on information in `element'.
		local
			current_element, constant_element: XM_ELEMENT
			current_name: STRING
			name, type, value: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (type_string)
			if element_info /= Void then
				type := (element_info.data)
			end
			element_info := full_information @ (Constant_name_string)
			if element_info /= Void then
				name := (element_info.data)
			end
			element_info := full_information @ (Constant_value_string)
			if element_info /= Void then
				value := (element_info.data)
			end
			new_constant_from_data (name, type, value)
		end

feature {GB_CLOSE_PROJECT_COMMAND} -- Basic operation

	reset is
			-- Reset all constants referenced, back to original settings.
		do
			integer_constants.wipe_out
			string_constants.wipe_out
			all_constant_names.wipe_out
			Constants_dialog.reset_list
			all_constants.clear_all
		end

feature {NONE} -- Implementation

	new_constant_from_data (name, type, value: STRING) is
			-- Create a new constant based on `name', `type' and `value'.
		local
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
		do
			if type.is_equal (Integer_constant_type) then
				create integer_constant.make_with_name_and_value (name, value.to_integer)
				add_integer (integer_constant)
			elseif type.is_equal (String_constant_type) then
				create string_constant.make_with_name_and_value (name, value)
				add_string (string_constant)
			end
		end

invariant
	integer_constants_not_void: integer_constants /= Void
	string_constants_not_void: string_constants /= Void

end -- class GB_CONSTANTS_HANDLER
