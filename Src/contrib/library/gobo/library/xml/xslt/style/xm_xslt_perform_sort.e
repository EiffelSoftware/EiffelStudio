note

	description:

		"xsl:perform-sort element nodes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_PERFORM_SORT

inherit

	XM_XSLT_STYLE_ELEMENT
		redefine
			validate, returned_item_type, is_permitted_child,
			may_contain_sequence_constructor, is_perform_sort
		end

create {XM_XSLT_NODE_FACTORY}

	make_style_element

feature -- Status report

	may_contain_sequence_constructor: BOOLEAN
			-- Is `Current' allowed to contain a sequence constructor?
		do
			Result := True
		end

	is_permitted_child (a_style_element: XM_XSLT_STYLE_ELEMENT): BOOLEAN
			-- Is `a_style_element' a permitted child of `Current'?
		do
			Result := a_style_element.is_sort
		end

	is_perform_sort: BOOLEAN
			-- Is `Current' an xsl:perform-sort?
		do
			Result := True
		end

feature -- Element change

	prepare_attributes
			-- Set the attribute list for the element.
		local
			a_cursor: DS_ARRAYED_LIST_CURSOR [INTEGER]
			a_name_code: INTEGER
			an_expanded_name, a_select_attribute: STRING
		do
			if attribute_collection /= Void then
				from
					a_cursor := attribute_collection.name_code_cursor
					a_cursor.start
				until
					a_cursor.after or any_compile_errors
				loop
					a_name_code := a_cursor.item
					an_expanded_name := shared_name_pool.expanded_name_from_name_code (a_name_code)
					if STRING_.same_string (an_expanded_name, Select_attribute) then
						a_select_attribute := attribute_value_by_index (a_cursor.index)
						STRING_.left_adjust (a_select_attribute)
						STRING_.right_adjust (a_select_attribute)
					else
						check_unknown_attribute (a_name_code)
					end
					a_cursor.forth
				variant
					attribute_collection.number_of_attributes + 1 - a_cursor.index
				end
			end
			if a_select_attribute /= Void then
				generate_expression (a_select_attribute)
				select_expression := last_generated_expression
			end
			attributes_prepared := True
		end

	validate
			-- Check that the stylesheet element is valid.
		local
			l_child_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			l_sort: XM_XSLT_SORT
			l_fallback: XM_XSLT_FALLBACK
			l_finished: BOOLEAN
			l_error: XM_XPATH_ERROR_VALUE
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			check_within_template
			check_sort_comes_first (True)
			if select_expression /= Void then
				create l_replacement.make (Void)
				type_check_expression (l_replacement, "select", select_expression)
				select_expression := l_replacement.item
				if has_child_nodes then
					from
						l_child_iterator := new_axis_iterator (Child_axis)
						l_child_iterator.start
					until
						l_finished or else l_child_iterator.after
					loop
						l_sort ?= l_child_iterator.item
						if l_sort = Void then

							-- may be a whitespace text node or xsl:fallback

							if l_child_iterator.item.node_type = Text_node and then is_all_whitespace (l_child_iterator.item.string_value) then
								-- do nothing
							else
								l_fallback ?= l_child_iterator.item
								if l_fallback = Void then
									create l_error.make_from_string (STRING_.concat (node_name, " may only have xsl:sort children or insignificant whitespace"),
										Xpath_errors_uri, "XTSE1040", Static_error)
									report_compile_error (l_error)
									l_finished := True
								end
							end
						end
						l_child_iterator.forth
					end
				end
			end
			validated := True
		end

	compile (a_executable: XM_XSLT_EXECUTABLE)
			-- Compile `Current' to an excutable instruction.
		local
			l_sort_key_list: DS_ARRAYED_LIST [XM_XSLT_SORT_KEY_DEFINITION]
			l_content: XM_XPATH_EXPRESSION
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			assemble_sort_keys
			if not any_compile_errors then
				l_sort_key_list := sort_keys
				if select_expression /= Void then
					create {XM_XSLT_SORT_EXPRESSION} last_generated_expression.make (select_expression, l_sort_key_list)
				else
					compile_sequence_constructor (a_executable, new_axis_iterator (Child_axis), True)
					l_content := last_generated_expression
					if l_content = Void then
						create {XM_XPATH_EMPTY_SEQUENCE} l_content.make
					end
					create l_replacement.make (Void)
					l_content.simplify (l_replacement)
					l_content := l_replacement.item
					create {XM_XSLT_SORT_EXPRESSION} last_generated_expression.make (l_content, l_sort_key_list)
				end
			end
		end

feature {XM_XSLT_STYLE_ELEMENT} -- Restricted

	returned_item_type: XM_XPATH_ITEM_TYPE
			-- Type of item returned by this instruction
		do
			if select_expression /= Void then
				Result := select_expression.item_type
			else
				Result := common_child_item_type
			end
		end

feature {NONE} -- Implementation

	select_expression: XM_XPATH_EXPRESSION
			-- Optional select expression

end
