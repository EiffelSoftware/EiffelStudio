indexing
	description:
		"[
			Objects that hold information regarding all constants in EiffelBuild.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONSTANTS_HANDLER

inherit
	ANY

	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_XML_UTILITIES
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create String_constants.make (4)
			create Integer_constants.make (4)
			create directory_constants.make (4)
			create pixmap_constants.make (4)
			create font_constants.make (4)
			create color_constants.make (4)
			create deleted_constants.make (4)
			create all_constant_names.make (4)
			create all_constants.make (4)
			create deferred_elements.make (4)
			all_constant_names.compare_objects
		ensure
			components_set: components = a_components
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
			Result.extend (Pixmap_constant_type)
			Result.extend (color_constant_type)
			Result.extend (font_constant_type)
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

	pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All pixmap constants in system.

	color_constants: ARRAYED_LIST [GB_CONSTANT]
		-- All color constants in system.

	font_constants: ARRAYED_LIST [GB_FONT_CONSTANT]
		-- All font constants in system.

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
			name_as_lower: STRING
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
			components.tools.constants_dialog.update_for_removal (a_constant)
		ensure
			constant_deleted: deleted_constants.has (a_constant)
		end

	remove_constant_no_update (a_constant: GB_CONSTANT) is
			-- Remove `a_constant' from all constants in system.
			-- Flag as deleted. No graphical update of `constants_dialog'
			-- is performed.
		require
			a_constant_not_void: a_constant /= Void
		local
			pixmap_constant: GB_PIXMAP_CONSTANT
			directory_constant: GB_DIRECTORY_CONSTANT
			referers: ARRAYED_LIST [GB_CONSTANT_CONTEXT]
		do
			if a_constant.type.is_equal (String_constant_type) then
				string_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Integer_constant_type) then
				integer_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Directory_constant_type) then
				directory_constants.prune_all (a_constant)
			elseif a_constant.type.is_equal (Pixmap_constant_type) then
				pixmap_constants.prune_all (a_constant)
				pixmap_constant ?= a_constant
					-- Update cross referers.
				if pixmap_constant /= Void then
					if not pixmap_constant.is_absolute then
						directory_constant ?= directory_constant_by_name (pixmap_constant.directory)
						check
							directory_constant_not_void: directory_constant /= Void
						end
						directory_constant.remove_cross_referer (pixmap_constant)
					end
				end
			end
			all_constants.remove (a_constant.name)
			all_constant_names.prune_all (a_constant.name)

				-- Now remove all referers.
			referers := a_constant.referers
			from
			until
				referers.is_empty
			loop
				referers.start
				referers.item.destroy
			end

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
			components.tools.constants_dialog.update_for_addition (integer_constant)
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
			components.tools.constants_dialog.update_for_addition (string_constant)
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
			components.tools.constants_dialog.update_for_addition (directory_constant)
			all_constants.put (directory_constant, directory_constant.name)
		ensure
			contained: directory_constants.has (directory_constant)
			count_increased: directory_constants.count = old directory_constants.count + 1
		end

	add_color (color_constant: GB_COLOR_CONSTANT) is
			-- Add `color_constant' to `color_constants'
		require
			constant_not_void: color_constant /= Void
		do
			color_constants.extend (color_constant)
			all_constant_names.extend (color_constant.name)
			if deleted_constants.has (color_constant) then
				deleted_constants.prune_all (color_constant)
			end
			components.tools.constants_dialog.update_for_addition (color_constant)
			all_constants.put (color_constant, color_constant.name)
		ensure
			contained: color_constants.has (color_constant)
			count_increased: color_constants.count = old color_constants.count + 1
		end

	add_font (font_constant: GB_FONT_CONSTANT) is
			-- Add `font_constant' to `font_constants'
		require
			constant_not_void: font_constant /= Void
		do
			font_constants.extend (font_constant)
			all_constant_names.extend (font_constant.name)
			if deleted_constants.has (font_constant) then
				deleted_constants.prune_all (font_constant)
			end
			components.tools.constants_dialog.update_for_addition (font_constant)
			all_constants.put (font_constant, font_constant.name)
		ensure
			contained: font_constants.has (font_constant)
			count_increased: font_constants.count = old font_constants.count + 1
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
			components.tools.constants_dialog.update_for_addition (pixmap_constant)
			all_constants.put (pixmap_constant, pixmap_constant.name)

				-- Now update cross referers if any.
			if not pixmap_constant.is_absolute then
				directory_constant_by_name (pixmap_constant.directory).add_cross_referer (pixmap_constant)
			end
		ensure
			contained: pixmap_constants.has (pixmap_constant)
			count_increased: pixmap_constants.count = old pixmap_constants.count + 1
		end

	build_constant_from_xml (element: XM_ELEMENT) is
			-- Add a constant based on information in `element'.
		local
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
					create pixmap_constant.make_with_name_and_value (name, value, directory, filename, is_absolute, components)
					add_pixmap (pixmap_constant)
				else
					new_constant_from_data (name, type, value)
				end
			end
		end

	flatten_constants (element: XM_ELEMENT) is
			-- Recurse through `element', and convert all constant values to manifest values
			-- in the XML.
		require
			element_not_void: element /= Void
		local
			current_element: XM_ELEMENT
			current_name: STRING
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			constant: GB_CONSTANT
		do
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name
					if current_name.is_equal (Constant_string) then

						full_information := get_unique_full_info (element)
						constant := all_constants.item ((full_information @ Constant_string).data)
						element.wipe_out
						add_string_data (element, constant.value_as_string)
					else
						flatten_constants (current_element)
					end
				end
				if not element.off then
					element.forth
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
			components.tools.constants_dialog.reset_contents
			all_constants.clear_all
		end

feature {GB_XML_LOAD, GB_XML_IMPORT} -- Implementation

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
			color_constant: GB_COLOR_CONSTANT
			font_constant: GB_FONT_CONSTANT
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
			elseif type.is_equal (color_constant_type) then
				create color_constant.make_with_name_and_value (name, build_color_from_string (value))
				add_color (color_constant)
			elseif type.is_equal (font_constant_type) then
				create font_constant.make_with_name_and_value (name, build_font_from_string (value))
				add_font (font_constant)
			end
		end

invariant
	integer_constants_not_void: integer_constants /= Void
	string_constants_not_void: string_constants /= Void
	deferred_elements_not_void: deferred_elements /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_CONSTANTS_HANDLER
