note
	description: "[
		Defines validator classes for an input field.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_DROP_DOWN_LIST_TAG

inherit
	XTAG_F_WRAPPABLE_CONTROL_TAG
		redefine
			make,
			internal_put_attribute
		end

create
	make

feature -- Initialization

	make
		do
			Precursor
			create {XTAG_TAG_VALUE_ARGUMENT} selected_index.make ("1")
			create {XTAG_TAG_VALUE_ARGUMENT} type.make ("STRING")
			internal_drop_down_objects := ""
		ensure then
			selected_index_attached: attached selected_index
		end

feature {NONE} -- Access

	drop_down_items: detachable XTAG_TAG_ARGUMENT
			-- The function which provides the items (can be None, then no items are displayed)

	selected_index: XTAG_TAG_ARGUMENT
			-- The index that should be selected

	type: XTAG_TAG_ARGUMENT
			-- The type of the elements in the list. Default if not set: STRING

	internal_drop_down_objects: STRING
			-- Stores the name of the hashmap (for the items) in the generated class
		
	label: detachable XTAG_TAG_ARGUMENT
			-- An optional label

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			Precursor (a_id, a_attribute)
			if a_id.is_equal ("items") then
				drop_down_items := a_attribute
			end
			if a_id.is_equal ("selected_index") then
				selected_index := a_attribute
			end
			if a_id.is_equal ("type") then
				type := a_attribute
			end
			if a_id.is_equal ("label") then
				label := a_attribute
			end
		end

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		local
			l_items_name, l_list_value, l_option_value: STRING
			l_drop_down_objects: STRING
		do
			if attached label as l_label then
				a_servlet_class.render_html_page.append_expression (response_variable_append + 
				"(%"<label for=%%%"" + a_name + "%%%">" + l_label.value (current_controller_id) +
				"</label>%")")
			end
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<select selectedIndex=%%%"" + selected_index.value (current_controller_id) + "%%%" name=%%%"" + a_name + "%%%">%")")
			l_drop_down_objects := a_servlet_class.new_variable ("HASH_TABLE [" + type.value (current_controller_id) + " , STRING]")
			a_servlet_class.make_feature.append_expression ("create " + l_drop_down_objects + ".make (5)")
			internal_drop_down_objects := l_drop_down_objects
			if attached drop_down_items as ll_drop_down_objects then
				if ll_drop_down_objects.is_dynamic or ll_drop_down_objects.is_variable then
					l_list_value := ll_drop_down_objects.plain_value (current_controller_id)
				else
					l_list_value := "%"" + ll_drop_down_objects.value (current_controller_id) + "%""
				end

				l_items_name := a_servlet_class.render_html_page.new_local ("LIST [STRING]")
				a_servlet_class.render_html_page.append_expression ("from")
				a_servlet_class.render_html_page.append_expression (l_items_name
					+ " := " + l_list_value)
				a_servlet_class.render_html_page.append_expression (l_items_name + ".start")
				a_servlet_class.render_html_page.append_expression ("until")
				a_servlet_class.render_html_page.append_expression (l_items_name + ".after")
				a_servlet_class.render_html_page.append_expression ("loop")
				l_option_value := a_servlet_class.render_html_page.new_local ("STRING")
				a_servlet_class.render_html_page.append_expression (l_option_value + " := unique_id")
				a_servlet_class.render_html_page.append_expression
						(response_variable_append + "(%"<option value=%%%"%"+" + l_option_value + "+%"%%%">%" + " +
						l_items_name +".item.out + " + "%"</option>%")")
				a_servlet_class.render_html_page.append_expression (l_drop_down_objects + "[" + l_option_value + "] := " +
						l_items_name + ".item")
				a_servlet_class.render_html_page.append_expression (l_items_name + ".forth")
				a_servlet_class.render_html_page.append_expression ("end")
			end
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"</select>%")")
		end

	transform_to_correct_type (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_name, a_argument_name: STRING): STRING
			-- <Precursor>
		do
			Result := "if attached {" + type.value (current_controller_id) + "} " + internal_drop_down_objects + "[" +  a_argument_name + "] as dd_argument then "
			Result := Result + a_variable_name + " := dd_argument "
			Result := Result + "end"
		end

end
