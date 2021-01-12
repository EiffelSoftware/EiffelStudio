note
	description: "Objects that represent an EiffelBuild Pixmap constant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PIXMAP_CONSTANT

inherit
	GB_CONSTANT
		redefine
			generate_xml
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

create
	make_with_name_and_value

create {GB_PIXMAP_SETTINGS_DIALOG}
	set_attributes

feature {NONE} -- Initialization

	make_with_name_and_value (a_name, a_value, a_directory, a_filename: STRING; absolute: BOOLEAN; a_components: GB_INTERNAL_COMPONENTS)
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
			a_directory_not_void: a_directory /= Void
			a_filename_not_void: a_filename /= Void
			a_components_not_void: a_components /= Void
		do
			set_attributes (a_name, a_value, a_directory, a_filename, absolute, a_components)
			retrieve_pixmap_image
		ensure
			name_set: name.same_string (a_name) and name /= a_name
			value_set: value.same_string (a_Value) and value /= a_value
			components_set: components = a_components
		end

feature {GB_PIXMAP_SETTINGS_DIALOG}

	set_attributes (a_name, a_value, a_directory, a_filename: STRING; absolute: BOOLEAN; a_components: GB_INTERNAL_COMPONENTS)
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_not_void: a_name /= Void
			a_value_not_void: a_value /= Void
			a_directory_not_void: a_directory /= Void
			a_filename_not_void: a_filename /= Void
			a_components_not_void: a_components /= Void
		do
			components := a_components
			name := a_name.twin
			value := a_value.twin
			directory := a_directory.twin
			filename := a_filename.twin
			is_absolute := absolute
			if referers = Void then
				create referers.make (4)
			end
		ensure
			name_set: name.same_string (a_name) and name /= a_name
			value_set: value.same_string (a_Value) and value /= a_value
			components_set: components = a_components
		end

	convert_to_full
			-- Convert representation of a pixmap constant, `Current', into
			-- a fully referenced constant with a context.
		require
			directory_is_constant: not is_absolute implies components.constants.directory_constant_by_name (directory) /= Void
		local
			file_name: PATH
		do
			if not is_absolute then
				directory := components.constants.directory_constant_by_name (directory).name
				check
					directory_matched: directory /= Void
				end
			else
				create file_name.make_from_string (directory)
				file_name := file_name.extended (filename)
				value := file_name.utf_8_name
			end
			create referers.make (4)
			retrieve_pixmap_image
		end


feature -- Access

	pixmap: EV_PIXMAP
		-- Pixmap represented by `Current'.

	is_absolute: BOOLEAN
			-- Does `Current' reference an absolute constant or a relative constant?

	type: STRING
			-- Type represented by `Current'
		once
			Result := Pixmap_constant_type
		end

	value: STRING
		-- Value of `Current' as full file location to referenced pixmap.
		-- only set if `is_absolute' is True.

	directory: STRING
		-- Name of directory constant using comprising `Current'.
		-- Not set if `is_absolute'.

	filename: STRING
		-- Name of file name constants comprising `Current'.
		-- Not set if `is_absolute'.

	value_as_string: STRING
			-- Value represented by `Current' as a STRING.
			-- If not absolute, then `Result' is evaluated full path.
		local
			directory_constant: GB_DIRECTORY_CONSTANT
			directory_value: STRING
		do
			if is_absolute then
				Result := value.twin
			else
				directory_constant ?= components.constants.all_constants.item (directory)
				check
					directory_constant_not_void: directory_constant /= Void
				end
				directory_value := directory_constant.value_as_string
				if directory_value.item (directory_value.count).is_equal (Directory_separator) then
						-- Strip out any ending directory separators, as some platforms may include
						-- these.
					directory_value := directory_value.substring (1, directory_value.count - 1)
				end
				Result := directory_value + Directory_separator.out + filename
			end
		end

	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (small_pixmap)
			Result.extend (name)
			Result.extend (type)
			if is_absolute then
				Result.extend ("Absolute : " + value)
			else
				Result.extend ("Relative to %"" + directory + "%"")
			end
			Result.set_data (Current)
		end

feature -- Status setting

	generate_xml (element: XM_ELEMENT)
			-- Generate an XM representation of `Current' in `element'.
		do
			add_element_containing_string (element, type_string, type)
			add_element_containing_string (element, constant_name_string, name)
			add_element_containing_string (element, Constant_value_string, value_as_string)
			add_element_containing_boolean (element, is_absolute_string, is_absolute)
			if directory /= Void then
				add_element_containing_string (element, directory_string, directory)
			end
			if filename /= Void then
				add_element_containing_string (element, filename_string, filename)
			end
		end

feature {GB_PIXMAP_SETTINGS_DIALOG, GB_DIRECTORY_CONSTANT} -- Implementation

	update
			-- Rebuild representations of `Current', and update all referers within system.
		local
			constant_context: GB_CONSTANT_CONTEXT
			execution_agent: PROCEDURE [EV_PIXMAP, STRING_GENERAL]
			file_name: PATH
		do
			if is_absolute then
				create file_name.make_from_string (directory)
				file_name := file_name.extended (filename)
				value := file_name.utf_8_name
			end
				-- Update image held internally.
			retrieve_pixmap_image
			from
				referers.start
			until
				referers.off
			loop
				constant_context := referers.item
				execution_agent ?= new_gb_ev_any (constant_context).execution_agents.item (constant_context.field)
				check
					execution_agent_not_void: execution_agent /= Void
				end
				execution_agent.call ([pixmap, value])
				referers.forth
			end
		end

feature {NONE} -- Implementation

	retrieve_pixmap_image
			-- Retrieve actual image of pixmap represented by `Current'.
		local
			file: RAW_FILE
			file_name: PATH
			directory_constant: GB_DIRECTORY_CONSTANT
			directory_value: STRING
		do
			if is_absolute then
				create file.make (value)
				if file.exists then
					create pixmap
					pixmap.set_with_named_file (value)
					small_pixmap := pixmap.twin
					small_pixmap := scaled_pixmap (pixmap, 16, 16)
				else
					pixmap := Icon_missing_pixmap_small @ 1
					small_pixmap := pixmap.twin
				end
			else
				directory_constant := components.constants.directory_constant_by_name (directory)
				check
					directory_constant_found: directory_constant /= Void
				end
				directory_value := directory_constant.value
				if directory_value.item (directory_value.count).is_equal (Directory_separator) then
					directory_value := directory_value.substring (1, directory_value.count - 1)
				end
				create file_name.make_from_string (directory_value)
				file_name := file_name.extended (filename)
				create file.make_with_path (file_name)
				if file.exists then
					create pixmap
					pixmap.set_with_named_path (file_name)
					small_pixmap := pixmap.twin
					small_pixmap := scaled_pixmap (pixmap, 16, 16)
				else
					pixmap := Icon_missing_pixmap_small @ 1
					small_pixmap := pixmap.twin
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_PIXMAP_CONSTANT
