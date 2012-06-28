indexing

	description:

		"xsl:text element nodes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_TEXT

inherit

	XM_XSLT_STRING_CONSTRUCTOR
		redefine
			validate, returned_item_type
		end

create {XM_XSLT_NODE_FACTORY}

	make_style_element

feature -- Access

	select_and_content_error: STRING is
			-- Error code when both select expression and content are mutually exclusive
		do
			Result := "not possible"
		end

feature -- Element change

	prepare_attributes is
			-- Set the attribute list for the element.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [INTEGER]
			l_name_code: INTEGER
			l_expanded_name, l_doe_attribute: STRING
			l_error: XM_XPATH_ERROR_VALUE
		do
			if attribute_collection /= Void then
				from
					l_cursor := attribute_collection.name_code_cursor
					l_cursor.start
				variant
					attribute_collection.number_of_attributes + 1 - l_cursor.index				
				until
					l_cursor.after or any_compile_errors
				loop
					l_name_code := l_cursor.item
					l_expanded_name := shared_name_pool.expanded_name_from_name_code (l_name_code)
					if STRING_.same_string (l_expanded_name, Disable_output_escaping_attribute) then
						l_doe_attribute := attribute_value_by_index (l_cursor.index)
					end
					l_cursor.forth
				end
			end
			if l_doe_attribute /= Void then
				if STRING_.same_string (l_doe_attribute, "yes") then
					create l_error.make_from_string ("disable-output-escaping is not supported", Xpath_errors_uri, "XTRE1620", Dynamic_error)
					report_compile_error (l_error)
				elseif not STRING_.same_string (l_doe_attribute, "no") then
					create l_error.make_from_string ("disable-output-escaping attribute must be either 'yes' or 'no'", Xpath_errors_uri, "XTSE0020", Static_error)
					report_compile_error (l_error)
				end
			end
			attributes_prepared := True
		end

	validate is
			-- Check that the stylesheet element is valid.
		local
			l_error: XM_XPATH_ERROR_VALUE
			l_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
		do
			check_within_template
			l_iterator := new_axis_iterator (Child_axis); l_iterator.start
			if l_iterator.after then
				create value.make ("")
			elseif l_iterator.item.node_type = Element_node then
				create l_error.make_from_string ("xsl:text must not contain any child elements.", Xpath_errors_uri, "XTSE0010", Static_error)
				report_compile_error (l_error)
			elseif l_iterator.item.node_type = Text_node then
				create value.make (l_iterator.item.string_value)
			else
				create l_error.make_from_string ("xsl:text must only contain a single text node.", Xpath_errors_uri, "XTSE0010", Static_error)
				report_compile_error (l_error)
			end
			Precursor
		end
			
	compile (a_executable: XM_XSLT_EXECUTABLE) is
			-- Compile `Current' to an excutable instruction.
		do
			create {XM_XSLT_COMPILED_VALUE_OF} last_generated_expression.make (a_executable, value, False, principal_stylesheet.module_number (system_id), line_number)
		end

feature {XM_XSLT_STYLE_ELEMENT} -- Restricted

	returned_item_type: XM_XPATH_ITEM_TYPE is
			-- Type of item returned by this instruction
		do
			Result := text_node_kind_test
		end

feature {NONE} -- Implementation

	value: XM_XPATH_STRING_VALUE
			-- String value of text node

end
