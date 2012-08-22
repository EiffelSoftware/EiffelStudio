note

	description:

		"xsl:attribute-set element nodes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_ATTRIBUTE_SET

inherit

	XM_XSLT_STYLE_ELEMENT
		redefine
			make_style_element, validate, is_attribute_set, as_attribute_set
		end

	XM_XSLT_PROCEDURE

	XM_XPATH_AXIS

create {XM_XSLT_NODE_FACTORY}

	make_style_element

feature {NONE} -- Initialization

	make_style_element (an_error_listener: XM_XSLT_ERROR_LISTENER; a_document: XM_XPATH_TREE_DOCUMENT;  a_parent: XM_XPATH_TREE_COMPOSITE_NODE;
		an_attribute_collection: XM_XPATH_ATTRIBUTE_COLLECTION; a_namespace_list:  DS_ARRAYED_LIST [INTEGER];
		a_name_code: INTEGER; a_sequence_number: INTEGER; a_configuration: like configuration)
			-- Establish invariant.
		do
			create slot_manager.make
			Precursor (an_error_listener, a_document, a_parent, an_attribute_collection, a_namespace_list, a_name_code, a_sequence_number, a_configuration)
		end

feature -- Access

	attribute_set_name_code: INTEGER
			-- Fingerprint of QName

	use: STRING
			-- Value of supplied `use' attribute

	attribute_set_elements: DS_ARRAYED_LIST [XM_XSLT_ATTRIBUTE_SET]
			-- Other attribute-sets referenced by `Current'

	reference_count: INTEGER
			-- Count of references to `Current'

feature -- Element change

	increment_reference_count
			-- Increment `reference_count'.
		do
			reference_count := reference_count + 1
		ensure
			reference_count_incremented: reference_count = old reference_count + 1
		end

	prepare_attributes
			-- Set the attribute list for the element.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [INTEGER]
			l_name_code: INTEGER
			l_expanded_name, l_name_attribute: STRING
			l_error: XM_XPATH_ERROR_VALUE
		do
			if attribute_collection /= Void then
				from
					l_cursor := attribute_collection.name_code_cursor
					l_cursor.start
				until
					l_cursor.after or any_compile_errors
				loop
					l_name_code := l_cursor.item
					l_expanded_name := shared_name_pool.expanded_name_from_name_code (l_name_code)
					if STRING_.same_string (l_expanded_name, Name_attribute) then
						l_name_attribute := attribute_value_by_index (l_cursor.index)
						STRING_.left_adjust (l_name_attribute)
						STRING_.right_adjust (l_name_attribute)
					elseif STRING_.same_string (l_expanded_name, Use_attribute_sets_attribute) then
						use := attribute_value_by_index (l_cursor.index)
					else
						check_unknown_attribute (l_name_code)
					end
					l_cursor.forth
				variant
					attribute_collection.number_of_attributes + 1 - l_cursor.index
				end
			end
			if l_name_attribute = Void then
				report_absence ("name")
			else
				if is_qname (l_name_attribute) then
					generate_name_code (l_name_attribute)
					if last_generated_name_code = -1 then
						report_compile_error (name_code_error_value)
					else
						attribute_set_name_code := last_generated_name_code
					end
				else
					create l_error.make_from_string ("Name attribute is not a QName",
																 Xpath_errors_uri, "XTSE0020", Static_error)
					report_compile_error (l_error)
				end
			end
			attributes_prepared := True
		end

	validate
			-- Check that the stylesheet element is valid.
			-- This is called once for each element, after the entire tree has been built.
			-- As well as validation, it can perform first-time initialisation.
		local
			an_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]
			an_attribute: XM_XSLT_ATTRIBUTE
			a_cursor: DS_ARRAYED_LIST_CURSOR [XM_XSLT_ATTRIBUTE_SET]
			an_error: XM_XPATH_ERROR_VALUE
		do
			check_top_level (Void)
			an_iterator := new_axis_iterator (Child_axis)
			from
				an_iterator.start
			until
				any_compile_errors or else an_iterator.after
			loop
				an_attribute ?= an_iterator.item
				if an_attribute = Void then
					create an_error.make_from_string ("Only xsl:attribute is allowed within xsl:attribute-set",
																 Xpath_errors_uri, "XTSE0010", Static_error)
					report_compile_error (an_error)
				end
				an_iterator.forth
			end

			if use /= Void then

				-- Identify any attribute sets that this one refers to

				create attribute_set_elements.make_default
				accumulate_attribute_sets (use, attribute_set_elements)
				if not any_compile_errors then

					-- Check for circularity

					from
						a_cursor := attribute_set_elements.new_cursor; a_cursor.start
					until
						a_cursor.after
					loop
						a_cursor.item.check_circularity (Current)
						a_cursor.forth
					variant
						attribute_set_elements.count + 1 - a_cursor.index
					end
				end
			else
				create used_attribute_sets.make (0)
			end
			validated := True
		end

	check_circularity (an_origin: like Current)
			-- Check for circularity of reference.
		local
			a_cursor: DS_ARRAYED_LIST_CURSOR [XM_XSLT_ATTRIBUTE_SET]
			an_error: XM_XPATH_ERROR_VALUE
		do
			if an_origin = Current then
				create an_error.make_from_string ("The definition of the attribute set is circular",
															 Xpath_errors_uri, "XTSE0720", Static_error)
				report_compile_error (an_error)
			elseif validated then

				-- If this attribute set isn't validated yet, we don't check it.
				-- The circularity will be detected when the last attribute set
				--  in the cycle gets validated.

				if attribute_set_elements /= Void then
					from
						a_cursor := attribute_set_elements.new_cursor; a_cursor.start
					until
						a_cursor.after
					loop
						a_cursor.item.check_circularity (an_origin)
						a_cursor.forth
					variant
						attribute_set_elements.count + 1 - a_cursor.index
					end
				end
			end
		end

	compile (a_executable: XM_XSLT_EXECUTABLE)
			-- Compile `Current' to an excutable instruction.
		local
			l_body: XM_XPATH_EXPRESSION
			l_trace_wrapper: XM_XSLT_TRACE_INSTRUCTION
			l_instruction: XM_XSLT_COMPILED_ATTRIBUTE_SET
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			last_generated_expression := Void
			if reference_count > 0 then
				compile_sequence_constructor (a_executable, new_axis_iterator (Child_axis), True)
				l_body := last_generated_expression
				if l_body = Void then
					create {XM_XPATH_EMPTY_SEQUENCE} l_body.make
				end
				create l_replacement.make (Void)
				l_body.simplify (l_replacement)
				l_body := l_replacement.item
				if configuration.is_tracing then
					create l_trace_wrapper.make (l_body, a_executable, Current)
					l_trace_wrapper.set_source_location (principal_stylesheet.module_number (system_id), line_number)
					l_trace_wrapper.set_parent (Current)
					l_body := l_trace_wrapper
				end
				create l_instruction.make (fingerprint_from_name_code (attribute_set_name_code),
													used_attribute_sets,
													a_executable,
													l_body,
													line_number,
													system_id,
													slot_manager)
				a_executable.attribute_set_manager.add_attributes (l_instruction, attribute_set_name_code)
			end
			last_generated_expression := Void
		end

feature -- Conversion

	is_attribute_set: BOOLEAN
			-- Is `Current' an xsl:attribute-set?
		do
			Result := True
		end

	as_attribute_set: XM_XSLT_ATTRIBUTE_SET
			-- `Current' seen as an xsl:attribute-set
		do
			Result := Current
		end

end
