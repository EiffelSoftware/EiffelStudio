indexing
	description: "Objects that represent an EiffelBuild Pixmap constant."
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
	
	GB_SHARED_CONSTANTS
	
create
	make_with_name_and_value
	
create {GB_PIXMAP_SETTINGS_DIALOG}
	set_attributes
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name, a_value, a_directory, a_filename: STRING; absolute: BOOLEAN) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void
		do
			name := clone (a_name)
			value := clone (a_value)
			directory := clone (a_directory)
			filename := clone (a_filename)
			is_absolute := absolute
			create referers.make (4)
			retrieve_pixmap_image
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end
		
feature {GB_PIXMAP_SETTINGS_DIALOG}
		
	set_attributes (a_name, a_value, a_directory, a_filename: STRING; absolute: BOOLEAN) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
		do
			name := clone (a_name)
			value := clone (a_value)
			directory := clone (a_directory)
			filename := clone (a_filename)
			is_absolute := absolute
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end
		
	convert_to_full is
			-- Convert representation of a pixmap constant, `Current', into
			-- a fully referenced constant with a context.
		require
			directory_is_constant: not is_absolute implies Constants.directory_constant_by_name (directory) /= Void
		local
			file_name: FILE_NAME
		do
			if not is_absolute then
				directory := Constants.directory_constant_by_name (directory).name
				check
					directory_matched: directory /= Void
				end
			else
				create file_name.make_from_string (directory)
				file_name.extend (filename)
				value := file_name.out
			end
			create referers.make (4)
			retrieve_pixmap_image
		end
		

feature -- Access

	pixmap: EV_PIXMAP
		-- Pixmap represented by `Current'.
		
	small_pixmap: EV_PIXMAP
		-- Small version of `pixmap'.

	is_absolute: BOOLEAN
			-- Does `Current' reference an absolute constant or a relative constant?

	type: STRING is
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
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
			-- If not absolute, then `Result' is evaluated full path.
		local
			directory_constant: GB_DIRECTORY_CONSTANT
			directory_value: STRING
		do
			if is_absolute then
				Result := clone (value)	
			else
				directory_constant ?= constants.all_constants.item (directory)
				check
					directory_constant_not_void: directory_constant /= Void
				end
				directory_value := directory_constant.value_as_string
				if directory_value.item (directory_value.count).is_equal (Directory_seperator) then
						-- Strip out any ending directory separators, as some platforms may include
						-- these.
					directory_value := directory_value.substring (1, directory_value.count - 1)
				end
				Result := directory_value + Directory_seperator.out + filename
			end
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (small_pixmap)
			Result.extend (name)			
			Result.extend (type)
			Result.extend (" ")
			Result.set_data (Current)
		end

feature -- Status setting

	generate_xml (element: XM_ELEMENT) is
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

	update is
			-- Rebuild representations of `Current', and update all referers within system.
		local
			constant_context: GB_CONSTANT_CONTEXT
			execution_agent: PROCEDURE [ANY, TUPLE [EV_PIXMAP]]
			file_name: FILE_NAME
		do
			if is_absolute then
				create file_name.make_from_string (directory)
				file_name.extend (filename)
				value := file_name.out
			end
				-- Update image held internally.
			retrieve_pixmap_image
			from
				referers.start
			until
				referers.off
			loop
				constant_context := referers.item
				execution_agent ?= new_gb_ev_any (constant_context).execution_agents.item (constant_context.attribute)
				check
					execution_agent_not_void: execution_agent /= Void
				end
				execution_agent.call ([pixmap])
				referers.forth
			end
		end
		

feature {NONE} -- Implementation

	retrieve_pixmap_image is
			-- Retrieve actual image of pixmap represented by `Current'.
		local 
			file: RAW_FILE
			file_name: FILE_NAME
			directory_constant: GB_DIRECTORY_CONSTANT
			directory_value: STRING
		do
			if is_absolute then
				create file.make (value)
				if file.exists then
					create pixmap
					pixmap.set_with_named_file (value)
					small_pixmap := clone (pixmap)
					small_pixmap := scaled_pixmap (pixmap, 16, 16)
				else
					pixmap := Icon_missing_pixmap_small @ 1
					small_pixmap := clone (pixmap)
				end
			else
				directory_constant := constants.directory_constant_by_name (directory)	
				check
					directory_constant_found: directory_constant /= Void
				end
				directory_value := directory_constant.value
				if directory_value.item (directory_value.count).is_equal (Directory_seperator) then
					directory_value := directory_value.substring (1, directory_value.count - 1)
				end
				create file_name.make_from_string (directory_value)
				file_name.extend (filename)
				create file.make (file_name)
				if file.exists then
					create pixmap
					pixmap.set_with_named_file (file_name)
					small_pixmap := clone (pixmap)
					small_pixmap := scaled_pixmap (pixmap, 16, 16)
				else
					pixmap := Icon_missing_pixmap_small @ 1
					small_pixmap := clone (pixmap)
				end
			end
		end

end -- class GB_PIXMAP_CONSTANT
