indexing
	description: "resource ID representation"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ID

inherit
	TDS_DEFINE_TABLE

feature -- Access

	number_id: INTEGER
			-- Number Id of the resource.

	name_id: STRING
			-- Name Id of the resource

	is_number: BOOLEAN
			-- Is the ID a number?

	has_number: BOOLEAN
			-- Does the ID have a number?

	has_name: BOOLEAN
			-- Does the ID have a name?

	cur_item: EV_TREE_ITEM

feature -- Element change

	set_number_id (a_id: INTEGER) is
			-- Set `number_id' to `a_id'.
		do
			number_id := a_id
			is_number := true
			has_number := true
		ensure
			number_id_set: number_id = a_id
			is_number_set: is_number
			has_number_set: has_number
		end

	set_name_id (a_id: STRING) is
			-- Set `name_id' to `a_id'.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			name_id := clone (a_id)
			is_number := false
			has_name := true
		ensure
			name_id_set: name_id.is_equal (a_id)
			is_number_set: not is_number
		end

	set_id (a_id: STRING) is
			-- Set properly `a_id' to the current object.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			if (a_id.is_integer) then
				set_number_id (a_id.to_integer)
			else
				set_name_id (a_id)
			end
		end

feature -- Conversion

	to_constant_style: STRING is
			-- Convert the `name_id' to a eiffel constant format if exists (ie like "Constant")
			-- Otherwise put the `number_id'.
		local
			first_character: STRING
		do
			if (not has_name) then
				Result := clone (number_id.out)
			else
				Result := to_variable_style

				first_character := Result.substring (1,1)
				first_character.to_upper

				Result.remove (1)
				Result.prepend_string (first_character)

				if define_table.has (name_id) then
					Result.append ("_constant")
				end
			end
		end

	to_variable_style: STRING is
			-- Convert the `name_id' to a eiffel variable format (ie like "variable").
		require
			name_id_exists: name_id /= Void and then name_id.count > 0
		do
			Result := clone (name_id)
			Result.to_lower
		end

	to_class_style (a_standard_class_name: STRING): STRING is
			-- Convert the `name_id' or `number_id' to a eiffel class format (ie like "CLASS").
		require
			a_standard_class_name_exists: a_standard_class_name /= Void and then a_standard_class_name.count > 0
		local
			temp: INTEGER
		do
			if has_name then
				Result := clone (name_id)
				Result.to_upper
			else
				Result := clone (a_standard_class_name)
				Result.append ("_")
				if number_id < 0 then
					temp := -number_id
					Result.append ("minus_")
					Result.append (temp.out)
				else
					Result.append (number_id.out)
				end	
			end
		end

feature -- Code generation

	display is
		do
			if (is_number) then
				io.putint (number_id)
			else
				io.putstring (name_id)
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (is_number) then
				a_resource_file.putint (number_id)
			else
				a_resource_file.putstring (name_id)
			end
		end

	generate_tree_view (a_tree_view: EV_TREE_ITEM) is -- ; on_tree_item_selection: PROCEDURE [ANY, TUPLE]) is
			-- Generate `a_tree_view' control from the tds memory structure.
		require
			a_tree_view_not_void: a_tree_view /= Void
       	local
			tv_item: EV_TREE_ITEM
		do
			if (is_number) then
				create tv_item.make_with_text (number_id.out)
			else
				create tv_item.make_with_text (name_id)
			end
--			tv_item.select_actions (~on_tree_item_selection)
			a_tree_view.extend (tv_item)
--			tv_item.set_data (a_tree_view.data)
--			cur_item:= tv_item
		end

--	on_tree_item_selection (cur_item: EV_TREE_NODE) is
--		local
--			res: TDS_RESOURCE
--		do
--			res:= tds.access_view_item (cur_item)
--		end

	generate_wel_code (a_text_file: PLAIN_TEXT_FILE) is
			-- Generate the eiffel code in `a_text_file'
		require
			a_text_file_exists: a_text_file.exists
		local
			wel_name: STRING
		do
			if (is_number) then
				a_text_file.putint (number_id)
			else
				wel_name := clone (name_id)
				wel_name.to_upper
				a_text_file.putstring (wel_name)
			end
		end

end -- class TDS_ID

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
