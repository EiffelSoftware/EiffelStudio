indexing

	description:

		"xsl:variable element nodes"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_VARIABLE

inherit

	XM_XSLT_VARIABLE_DECLARATION
		redefine
			make_style_element, prepare_attributes, is_xslt_variable, as_xslt_variable
		end

	XM_XPATH_CARDINALITY

create {XM_XSLT_NODE_FACTORY}

	make_style_element

feature {NONE} -- Initialization
	
	make_style_element (an_error_listener: XM_XSLT_ERROR_LISTENER; a_document: XM_XPATH_TREE_DOCUMENT;  a_parent: XM_XPATH_TREE_COMPOSITE_NODE;
		an_attribute_collection: XM_XPATH_ATTRIBUTE_COLLECTION; a_namespace_list:  DS_ARRAYED_LIST [INTEGER];
		a_name_code: INTEGER; a_sequence_number: INTEGER; a_configuration: like configuration) is
			-- Establish invariant.
		do
			cached_variable_fingerprint := -1
			is_instruction := True
			create references.make (5)
			create slot_manager.make
			Precursor (an_error_listener, a_document, a_parent, an_attribute_collection, a_namespace_list, a_name_code, a_sequence_number, a_configuration)
		end

feature -- Access

	required_type: XM_XPATH_SEQUENCE_TYPE is
			-- Static type of the variable
		local
			a_document_test: XM_XPATH_NODE_KIND_TEST
		do
			if as_type /= Void then
				Result := as_type
			elseif select_expression /= Void then
				if select_expression /= Void and then select_expression.is_empty_sequence then
					create Result.make_any_sequence -- apparently, returning empty sequence as the type gives problems with static type checking
				else

					-- Try to infer the type from the select expression

					create Result.make (select_expression.item_type, select_expression.cardinality)
				end
			elseif has_child_nodes then
				create a_document_test.make_document_test
				create Result.make (a_document_test, Required_cardinality_exactly_one)
			else

				-- No select attribute or content: value is an empty string

				create Result.make_single_string
			end
		end

	preparation_state: INTEGER
			-- Used by `prepare_attributes'

feature -- Element change

	prepare_attributes is
			-- Set the attribute list for the element.
		require else
			preparation_state: preparation_state < 2
		local
			an_error: XM_XPATH_ERROR_VALUE
		do
			if preparation_state > 0 then
				create an_error.make_from_string ("Circular reference to variable", Xpath_errors_uri, "XTDE0640", Static_error)
				report_compile_error (an_error)
			else
				preparation_state := 1
				Precursor
				preparation_state := 2
			end
		end

	compile (a_executable: XM_XSLT_EXECUTABLE) is
			-- Compile `Current' to an excutable instruction.
		local
			l_local_variable: XM_XSLT_LOCAL_VARIABLE
			l_global_variable: XM_XSLT_GLOBAL_VARIABLE
			l_replacement: DS_CELL [XM_XPATH_EXPRESSION]
		do
			last_generated_expression := Void
			if references.count = 0 then
				is_redundant_variable := True
			end
			if not is_redundant_variable then
				check
					strictly_positive_slot_number: slot_number > 0
				end
				if is_global_variable then
					create l_global_variable.make_global_variable (a_executable, variable_name, slot_number, slot_manager)
					initialize_instruction (a_executable, l_global_variable)
					l_global_variable.set_required_type (required_type)
					fixup_binding (l_global_variable)					
					last_generated_expression := l_global_variable
				else
					create l_local_variable.make (a_executable, variable_name, slot_number)
					initialize_instruction (a_executable, l_local_variable)
					l_local_variable.set_required_type (required_type)
					-- fixup_binding omitted, as that is done by `compile_variable'

					last_generated_expression := l_local_variable
				end
				if last_generated_expression /= Void then
					create l_replacement.make (Void)
					last_generated_expression.simplify (l_replacement)
					last_generated_expression := l_replacement.item
					if not last_generated_expression.is_error then
						l_replacement.put (Void)
						last_generated_expression.check_static_type (l_replacement, static_context, any_item)
						last_generated_expression := l_replacement.item
					end
					if last_generated_expression.is_error then
						report_compile_error (last_generated_expression.error_value)
					else
						l_replacement.put (Void)
						last_generated_expression.optimize (l_replacement, static_context, any_item)
						last_generated_expression := l_replacement.item
					end
				end
			end
		end

feature -- Conversion

	is_xslt_variable: BOOLEAN is
			-- Is `Current' an xsl:variable?
		do
			Result := True
		end

	as_xslt_variable: XM_XSLT_VARIABLE is
			-- `Current' seen as an xsl:variable
		do
			Result := Current
		end

end
