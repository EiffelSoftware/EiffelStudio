
note
	description: "[
		Defines validator classes for an input field.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_DROP_DOWN_LIST_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
		do
			make_base		
		end

feature {NONE} -- Access

	drop_down_items: XTAG_TAG_ARGUMENT
			-- The function which provides the items

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("items") then
				drop_down_items := a_attribute
			end
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_items_name: STRING
		do
			a_servlet_class.render_html_page.append_expression (response_variable_append + "(%"<select>%")")
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
