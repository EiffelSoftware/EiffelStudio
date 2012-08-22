note

	description:

		"Objects that implement the XPath doc-available() function"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_DOC_AVAILABLE

inherit

	XM_XPATH_DOC_ROUTINES

	XM_XPATH_SYSTEM_FUNCTION
		redefine
			evaluate_item, check_arguments, pre_evaluate, compute_special_properties
		end

	XM_XPATH_SHARED_NODE_KIND_TESTS
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make
			-- Establish invariant
		do
			name := "doc-available"; namespace_uri := Xpath_standard_functions_uri
			fingerprint := Doc_available_function_type_code
			minimum_argument_count := 1
			maximum_argument_count := 1
			create arguments.make (1)
			arguments.set_equality_tester (expression_tester)
			initialized := True
		end

feature -- Access

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type of the expression, where known
		do
			Result := type_factory.boolean_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

feature -- Status report

	required_type (argument_number: INTEGER): XM_XPATH_SEQUENCE_TYPE
			-- Type of argument number `argument_number'
		do
			create Result.make_optional_string
		end

feature -- Evaluation

	evaluate_item (a_result: DS_CELL [XM_XPATH_ITEM]; a_context: XM_XPATH_CONTEXT)
			-- Evaluate as a single item to `a_result'.
		local
			l_iri_reference: STRING
			l_uri: UT_URI
		do
			arguments.item (1).evaluate_item (a_result, a_context)
			if a_result.item = Void or else a_result.item.is_error then -- suppress errors
				a_result.put (create {XM_XPATH_BOOLEAN_VALUE}.make (False))
			else
				l_iri_reference := escaped_uri (a_result.item.string_value)
				if Url_encoding.has_excluded_characters (l_iri_reference) or l_iri_reference.occurrences ('#') > 1 then
					a_result.put (create {XM_XPATH_INVALID_ITEM}.make_from_string (STRING_.concat (l_iri_reference, " is not a valid xs:anyURI"),
						Xpath_errors_uri, "FODC0005", Dynamic_error))
				else
					create l_uri.make_resolve (base_uri, l_iri_reference)
					parse_document (a_result.item.string_value, base_uri, a_context)
					if last_evaluated_document = Void then
						a_result.put (create {XM_XPATH_BOOLEAN_VALUE}.make (False))
					elseif last_evaluated_document.is_error then
						a_result.put (create {XM_XPATH_BOOLEAN_VALUE}.make (False))
					else
						a_result.put (create {XM_XPATH_BOOLEAN_VALUE}.make (last_evaluated_document.is_document))
					end
				end
			end
		end

	pre_evaluate (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT)
			-- Pre-evaluate `Current' at compile time.
		do
			a_replacement.put (Current)
		end

feature {XM_XPATH_EXPRESSION} -- Restricted

	compute_cardinality
			-- Compute cardinality.
		do
			set_cardinality_optional
		end

	compute_special_properties
			-- Compute special properties.
		do
			initialize_special_properties
			set_peer_nodeset
			set_ordered_nodeset
			set_non_creating
		end

feature {XM_XPATH_FUNCTION_CALL} -- Local

	check_arguments (a_replacement: DS_CELL [XM_XPATH_EXPRESSION]; a_context: XM_XPATH_STATIC_CONTEXT)
			-- Check arguments during parsing, when all the argument expressions have been read.
		do
			Precursor (a_replacement, a_context)
			base_uri := a_context.base_uri
		end

feature {NONE} -- Implementation

	base_uri: UT_URI
			-- Base URI from static context

end

