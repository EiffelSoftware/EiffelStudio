note
	description: "[
					Group tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_GROUP_DATA

inherit
	ER_TREE_NODE_DATA

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "group_"
			xml_constants := {ER_XML_CONSTANTS}.group
			new_unique_command_name
		end

feature -- Query

	size_definition: detachable STRING
			-- Size definition of buttons

	is_ideal_sizes_large_checked: BOOLEAN
			-- Is ideal sizes including Large?

	is_ideal_sizes_medium_checked: BOOLEAN
			-- Is ideal sizes including Medium?

	is_ideal_sizes_small_checked: BOOLEAN
			-- Is ideal sizes including Small?

	is_scale_large_checked: BOOLEAN
			-- Is scale including Large?			

	is_scale_medium_checked: BOOLEAN
			-- Is scale including Medium?

	is_scale_small_checked: BOOLEAN
			-- Is scale including Small?

	is_scale_popup_checked: BOOLEAN
			-- Is scale including Popup?

feature -- Command

	set_size_definition (a_size_definition: like size_definition)
			-- Set `size_definition' with `a_size_definition'
		do
			size_definition := a_size_definition
		end

	set_ideal_sizes_large_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_large_checked' with `a_bool'
		do
			is_ideal_sizes_large_checked := a_bool
			if a_bool then
				is_ideal_sizes_medium_checked := False
				is_ideal_sizes_small_checked := False
			end
		end

	set_ideal_sizes_medium_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_medium__checked' with `a_bool'
		do
			is_ideal_sizes_medium_checked := a_bool
			if a_bool then
				is_ideal_sizes_large_checked := False
				is_ideal_sizes_small_checked := False
			end
		end

	set_ideal_sizes_small_checked (a_bool: BOOLEAN)
			-- Set `is_ideal_sizes_small_checked' with `a_bool'
		do
			is_ideal_sizes_small_checked := a_bool
			if a_bool then
				is_ideal_sizes_medium_checked := False
				is_ideal_sizes_large_checked := False
			end
		end

	set_scale_large_checked (a_bool: BOOLEAN)
			-- Set `is_scale_large_checked' with `a_bool'
		do
			is_scale_large_checked := a_bool
		end

	set_scale_medium_checked (a_bool: BOOLEAN)
			-- Set `is_scale_medium_checked' with `a_bool'
		do
			is_scale_medium_checked := a_bool
		end

	set_scale_small_checked (a_bool: BOOLEAN)
			-- Set `is_scale_small_checked' with `a_bool'
		do
			is_scale_small_checked := a_bool
		end

	set_scale_popup_checked (a_bool: BOOLEAN)
			-- Set `is_scale_popup_checked' with `a_bool'
		do
			is_scale_popup_checked := a_bool
		end

end
