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
			create directory_constants.make (4)
			create filename_constants.make (4)
			create pixmap_constants.make (4)
			create deleted_constants.make (4)
			create all_constant_names.make (4)
			create all_constants.make (4)
			create deferred_elements.make (4)
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
			Result.extend (Filename_constant_type)
			Result.extend (Pixmap_constant_type)
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

	directory_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All directory constants in system.
	
	filename_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All filename constants in system.
	
	pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All pixmap constants in system.
		
	deleted_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All constants that are currently flagged as deleted.
	
	string_is_constant_name (a_string: STRING): BOOLEAN is
			-- Is `a_string' already used as a constant name?
		require
			a_string_not_void: a_string /= Void
		do
			Result :=  all_constant_names.has (a_string)
		end

	matching_absolute_pixmap_constant (a_file_path: STRING): STRING is
			-- `Result' is name of absolute pixmap constant with `value'
			-- matching `a_file_path'. Case insensitive, and `Void' if
			-- none.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			pixmap_as_lower, path_as_lower: STRING
			pixmap_constant: GB_PIXMAP_CONSTANT
		do
			path_as_lower := a_file_path.as_lower
			from
				pixmap_constants.start
			until
				pixmap_constants.off or Result /= Void
			loop
				pixmap_constant ?= pixmap_constants.item
				if pixmap_constant.is_absolute then
					pixmap_as_lower := pixmap_constant.value.as_lower
					if pixmap_as_lower.is_equal (path_as_lower) then
						Result := pixmap_constant.name
					end
				end
				pixmap_constants.forth
			end
		end

	matching_directory_constant_name (a_file_path: STRING): STRING is
			-- `Result' is name of directory constant with `value'
			-- matching `a_file_path'. Case insensitive.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			constant_as_lower, path_as_lower: STRING
			directory_constant: GB_DIRECTORY_CONSTANT
		do
			path_as_lower := a_file_path.as_lower
			from
				directory_constants.start
			until
				directory_constants.off or Result /= Void
			loop
				directory_constant ?= directory_constants.item
				constant_as_lower := directory_constant.value.as_lower
				if constant_as_lower.is_equal (path_as_lower) then
					Result := directory_constant.name
				end
				directory_constants.forth
			end
		end
		
	matching_directory_constant_names (a_file_path: STRING): ARRAYED_LIST [STRING] is
			-- `Result' is name of directory constant with `value'
			-- matching `a_file_path'. Case insensitive.
		require
			a_file_path_not_void: a_file_path /= Void
		local
			constant_as_lower, path_as_lower: STRING
			directory_constant: GB_DIRECTORY_CONSTANT
		do
			create Result.make (2)
			path_as_lower := a_file_path.as_lower
			from
				directory_constants.start
			until
				directory_constants.off
			loop
				directory_constant ?= directory_constants.item
				constant_as_lower := directory_constant.value.as_lower
				if constant_as_lower.is_equal (path_as_lower) then
					Result.extend (directory_constant.name)
				end
				directory_constants.forth
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	directory_constant_by_name (directory_constant_name: STRING): GB_DIRECTORY_CONSTANT is
			-- `Result' is directory_constant named `directory_constant_name',
			-- or `Void' if none.
		local
			constant_as_lower, name_as_lower: STRING
			directory_constant: GB_DIRECTORY_CONSTANT
		do
			name_as_lower := directory_constant_name.as_lower
			from
				directory_constants.start
			until
				directory_constants.off or Result /= Void
			loop
				directory_constant ?= directory_constants.item
				if directory_constant.name.as_lower.is_equal (name_as_lower) then
					Result := directory_constant
				end
				directory_constants.forth
			end
		end

feature -- Element change

	remove_constant (a_constant: GB_CONSTANT) is
			-- Remove `a_constant' from all constants in system.
			-- Flag as deleted. Updates graphical representation
			-- of `constants_dialog'.
		require
			a_constant_not_void: a_constant /= Void
		do
			remove_constant_no_update (a_constant)
			constants_dialog.update_for_removal (a_constant)
		ensure
			constant_deleted: deleted_constants.has (a_constant)
		end
		
	remove_constant_no_update (a_constant: GB_CONSTANT) is
			-- Remove `a_constant' from all constants in system.
			-- Flag as deleted. No graphical update of `constants_dialog'
			-- is performed.
		require
			a_constant_not_void: a_constant /= Void
		do
			if a_constant.type.is_equal (String_constant_type) then
				string_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Integer_constant_type) then
				integer_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Directory_constant_type) then
				directory_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Pixmap_constant_type) then
				pixmap_constants.prune_all (a_constant)
			end
			all_constants.remove (a_constant.name)
			all_constant_names.prune_all (a_constant.name)
			deleted_constants.extend (a_constant)
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
		
	add_directory (directory_constant: GB_DIRECTORY_CONSTANT) is
			-- Add `directory_constant' to `directory_constants'
		require
			constant_not_void: directory_constant /= Void
		do
			directory_constants.extend (directory_constant)
			all_constant_names.extend (directory_constant.name)
			if deleted_constants.has (directory_constant) then
				deleted_constants.prune_all (directory_constant)
			end
			Constants_dialog.update_for_addition (directory_constant)
			all_constants.put (directory_constant, directory_constant.name)
		ensure
			contained: directory_constants.has (directory_constant)
			count_increased: directory_constants.count = old directory_constants.count + 1
		end
		
	add_filename (filename_constant: GB_FILENAME_CONSTANT) is
			-- Add `filename_constant' to `filename_constants'
		require
			constant_not_void: filename_constant /= Void
		do
			filename_constants.extend (filename_constant)
			all_constant_names.extend (filename_constant.name)
			if deleted_constants.has (filename_constant) then
				deleted_constants.prune_all (filename_constant)
			end
			Constants_dialog.update_for_addition (filename_constant)
			all_constants.put (filename_constant, filename_constant.name)
		ensure
			contained: filename_constants.has (filename_constant)
			count_increased: filename_constants.count = old filename_constants.count + 1
		end
	
	add_pixmap (pixmap_constant: GB_PIXMAP_CONSTANT) is
			-- Add `pixmap_constant' to `pixmap_constants'.
		require
			constant_not_void: pixmap_constant /= Void
		do
			pixmap_constants.extend (pixmap_constant)
			all_constant_names.extend (pixmap_constant.name)
			if deleted_constants.has (pixmap_constant) then
				deleted_constants.prune_all (pixmap_constant)
			end
			Constants_dialog.update_for_addition (pixmap_constant)
			all_constants.put (pixmap_constant, pixmap_constant.name)
		ensure
			contained: pixmap_constants.has (pixmap_constant)
			count_increased: pixmap_constants.count = old pixmap_constants.count + 1
		end		
		
	build_constant_from_xml (element: XM_ELEMENT) is
			-- Add a constant based on information in `element'.
		local
			current_element, constant_element: XM_ELEMENT
			current_name: STRING
			name, type, value: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			is_absolute: BOOLEAN
			directory, filename: STRING
			pixmap_constant: GB_PIXMAP_CONSTANT
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (type_string)
			if element_info /= Void then
				type := (element_info.data)
			end
			if type.is_equal (Pixmap_constant_type) and not deferred_building then
					-- Ensure that pixmap constants are built last, due to their dependencies
					-- on directory constants.
				deferred_elements.extend (element)
			else
				element_info := full_information @ (Constant_name_string)
				if element_info /= Void then
					name := (element_info.data)
				end
				element_info := full_information @ (Constant_value_string)
				if element_info /= Void then
					value := (element_info.data)
				end
				if type.is_equal (Pixmap_constant_type) then
					element_info := full_information @ (Is_absolute_string)
					if element_info /= Void then
						if element_info.data.is_equal (True_string) then
							is_absolute := True
						else
							is_absolute := False
						end
					end
					element_info := full_information @ (Directory_string)
					if element_info /= Void then
						directory := (element_info.data)
					end
					element_info := full_information @ (Filename_string)
					if element_info /= Void then
						filename := (element_info.data)
					end
					if value = Void then
						value := ""
					end
					create pixmap_constant.make_with_name_and_value (name, value, directory, filename, is_absolute)
					add_pixmap (pixmap_constant)
				else
					new_constant_from_data (name, type, value)
				end
			end
		end

feature {GB_CLOSE_PROJECT_COMMAND} -- Basic operation

	reset is
			-- Reset all constants referenced, back to original settings.
		do
			integer_constants.wipe_out
			string_constants.wipe_out
			all_constant_names.wipe_out
			pixmap_constants.wipe_out
			directory_constants.wipe_out
			filename_constants.wipe_out
			Constants_dialog.reset_list
			all_constants.clear_all
		end

feature {GB_XML_LOAD} -- Implementation

	build_deferred_elements is
			-- Build all XM_ELEMENT that were deferred for building
			-- after the others.
		do
			deferred_building := True
			from
				deferred_elements.start
			until
				deferred_elements.off
			loop
				build_constant_from_xml (deferred_elements.item)
				deferred_elements.forth
			end
			deferred_building := False
				-- Clear elements, so that next time a project is loaded, they
				-- do not appear.
			deferred_elements.wipe_out
		end

feature {NONE} -- Implementation

	deferred_elements: ARRAYED_LIST [XM_ELEMENT]
		-- All XM_ELEMENT that must be created last, due to their
		-- dependencies on other constants.	
		
	deferred_building: BOOLEAN
		-- Is deferred building currently executing.
		-- If so, actually create the type that will be deferred,
		-- otherwise defer its building.

	new_constant_from_data (name, type, value: STRING) is
			-- Create a new constant based on `name', `type' and `value'.
		local
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
			directory_constant: GB_DIRECTORY_CONSTANT
			filename_constant: GB_FILENAME_CONSTANT
		do
			if type.is_equal (Integer_constant_type) then
				create integer_constant.make_with_name_and_value (name, value.to_integer)
				add_integer (integer_constant)
			elseif type.is_equal (String_constant_type) then
				create string_constant.make_with_name_and_value (name, value)
				add_string (string_constant)
			elseif type.is_equal (Directory_constant_type) then
				create directory_constant.make_with_name_and_value (name, value)
				add_directory (directory_constant)
			elseif type.is_equal (Filename_constant_type) then
				create filename_constant.make_with_name_and_value (name, value)
				add_filename (filename_constant)
			end
		end

invariant
	integer_constants_not_void: integer_constants /= Void
	string_constants_not_void: string_constants /= Void
	deferred_elements_not_void: deferred_elements /= Void

end -- class GB_CONSTANTS_HANDLER
