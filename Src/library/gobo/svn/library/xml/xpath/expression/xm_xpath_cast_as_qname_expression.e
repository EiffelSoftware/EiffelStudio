indexing

	description:

		"XPath cast as xs:QName Expressions"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_CAST_AS_QNAME_EXPRESSION

inherit

	XM_XPATH_COMPUTED_EXPRESSION
		redefine
			sub_expressions, evaluate_item, compute_special_properties, is_node_sequence
		end

create

	make

feature {NONE} -- Initialization
	
	make (an_expression: XM_XPATH_EXPRESSION) is
			-- Establish invariant.
		require
			source_expression_not_void: an_expression /= Void
		do
			source := an_expression
			compute_static_properties
			initialized := True
		ensure
			static_properties_computed: are_static_properties_computed
			source_set: source = an_expression
		end


feature -- Access
	
	item_type: XM_XPATH_ITEM_TYPE is
			--Determine the data type of the expression, if possible
		do
			Result := type_factory.qname_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	sub_expressions: DS_ARRAYED_LIST [XM_XPATH_EXPRESSION] is
			-- Immediate sub-expressions of `Current'
		do
			create Result.make (1)
			Result.put (source, 1)
			Result.set_equality_tester (expression_tester)
		end
	
feature -- Status report

	is_node_sequence: BOOLEAN is
			-- Is `Current' a sequence of zero or more nodes?
		do
			Result := False
		end

	display (a_level: INTEGER) is
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), "cast as QName")
			std.error.put_string (a_string)
			std.error.put_new_line
			source.display (a_level + 1)
		end

feature -- Optimization	

	check_static_type (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform static analysis of an expression and its subexpressions
		local
			l_xml_prefix, l_namespace_uri, l_local_name: STRING
			l_parser: XM_XPATH_QNAME_PARSER
			l_name_code: INTEGER
			l_qname_value: XM_XPATH_QNAME_VALUE
		do
			if source.is_string_value then
				create l_parser.make (source.as_string_value.string_value)
				if l_parser.is_valid then
					if not l_parser.is_prefix_present then
						l_xml_prefix := ""
						l_local_name := l_parser.local_name
						l_namespace_uri := ""
					else
						l_xml_prefix := l_parser.optional_prefix
						l_local_name := l_parser.local_name
						l_namespace_uri := a_context.uri_for_prefix (l_xml_prefix)
					end
				else
					set_last_error_from_string ("Argument to cast as xs:QName is not a lexical QName", Xpath_errors_uri, "XPTY0004", Static_error)
				end
				if not is_error then
					if not shared_name_pool.is_name_code_allocated (l_xml_prefix, l_namespace_uri, l_local_name) then
						shared_name_pool.allocate_name (l_xml_prefix, l_namespace_uri, l_local_name)
						l_name_code := shared_name_pool.last_name_code
					else
						l_name_code := shared_name_pool.name_code (l_xml_prefix, l_namespace_uri, l_local_name)
					end
					if l_name_code = -1 then
						set_last_error_from_string ("Resource failure trying to cast to xs:QName", Xpath_errors_uri, "FOER0000", Static_error)
					else
						create l_qname_value.make (l_name_code)
						set_replacement (a_replacement, l_qname_value)
					end
				end
			else
				set_last_error_from_string ("The argument of a QName constructor must be a string literal", Xpath_errors_uri, "XPTY0004", Static_error)
			end
			if a_replacement.item = Void then
				a_replacement.put (Current)
			end
		end

	optimize (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT; a_context_item_type: XM_XPATH_ITEM_TYPE) is
			-- Perform optimization of `Current' and its subexpressions.
		do
			-- This cannot happen at present - see `check_static_type'.
			-- For schema-aware version, `Current' might also be used for xs:NOTATION sub-types.
			a_replacement.put (Current)
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT) is
			-- Evaluate as a single item to `a_result'.
		do
			a_result.put (create {XM_XPATH_INVALID_ITEM}.make_from_string ("Cannot evaluate a cast to xs:QName at run-time.", Xpath_errors_uri, "FONS0003", Dynamic_error))
		end

feature {NONE} -- Implementation

	source: XM_XPATH_EXPRESSION
			-- Expression to be cast

	compute_cardinality is
			-- Compute cardinality.
		do
			set_cardinality_exactly_one
		end

	compute_special_properties is
			-- Compute special properties.
		do
			Precursor
			set_non_creating
		end

invariant

	source_expression_not_void: source /= Void

end
	
