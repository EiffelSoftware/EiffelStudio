note
	description: "[
		Defines validator classes for an input field.
	]"
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
		ensure then
			selected_index_attached: attached selected_index
		end

feature {NONE} -- Access

	drop_down_items: XTAG_TAG_ARGUMENT
			-- The function which provides the items (can be None, then no items are displayed)
			
	selected_index: XTAG_TAG_ARGUMENT
			-- The index that should be selected

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
		end

	html_representation (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_name: STRING)
			-- <Precursor>
		local
			l_items_name: STRING
		do
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<select selectedIndex=%%%"" + selected_index.value (current_controller_id) + "%%%" " + a_name + ">%")")
			if attached drop_down_items then
				l_items_name := a_servlet_class.render_html_page.new_local ("LIST [STRING]")
				a_servlet_class.render_html_page.append_expression ("from")
				a_servlet_class.render_html_page.append_expression (l_items_name 
					+ " := " + current_controller_id + "." + drop_down_items.plain_value (current_controller_id))
				a_servlet_class.render_html_page.append_expression (l_items_name + ".start")
				a_servlet_class.render_html_page.append_expression ("until")
				a_servlet_class.render_html_page.append_expression (l_items_name + ".after")
				a_servlet_class.render_html_page.append_expression ("loop")				
				a_servlet_class.render_html_page.append_expression
						(response_variable_append + "(%"<option>%" + " +
						l_items_name +".item + " + "%"</option>%")")
				a_servlet_class.render_html_page.append_expression (l_items_name + ".forth")
				a_servlet_class.render_html_page.append_expression ("end")
			end
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"</select>%")")
		end

end
