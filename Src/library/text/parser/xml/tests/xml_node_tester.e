note
	date: "$Date$"
	revision: "$Revision$"

class
	XML_NODE_TESTER

inherit
	XML_NODE_ITERATOR
		redefine
			process_element,
			process_attribute
		end

feature -- Visitor

	has_error: BOOLEAN
		do
			Result := error_count > 0
		end

	error_count: INTEGER
	errors: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	reset
		do
			error_count := 0
			errors := Void
		end

	report_error (m: READABLE_STRING_GENERAL)
		local
			errs: like errors
		do
			io.error.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (m))
			io.error.put_new_line
			errs := errors
			if errs = Void then
				create errs.make (1)
				errors := errs
			end
			errs.extend (m)
			error_count := error_count + 1
		end

feature -- Visitor

	check_named_node (x: XML_NAMED_NODE)
		do
			if not x.has_same_name (x.name) then
				report_error (x.generator + ".has_same_name (..)")
			end
			if not x.has_same_ns_uri (x.ns_uri) then
				report_error (x.generator + ".has_same_ns_uri (..)")
			end
			if not x.has_same_ns_prefix (x.ns_prefix) then
				report_error (x.generator + ".has_same_ns_prefix (..)")
			end
		end

	process_element (e: XML_ELEMENT)
			-- Process character data `e'.
		do
			last_element := e

			check_named_node (e)

			if attached e.parent as p then
				if attached e.ns_prefix as l_prefix then
					if not p.has_element_by_qualified_name (e.ns_uri, e.name) then
						report_error (p.generator + ".has_element_by_qualified_name (..)")
					else
						if p.element_by_qualified_name (e.ns_uri, e.name) = Void then
							report_error (e.generator + ".element_by_qualified_name (..)")
						end
						if attached {XML_ELEMENT} p as pe then
							if attached pe.elements_by_qualified_name (e.ns_uri, e.name) as lst then
								if ∃ c: lst ¦ c = e then
								else
									report_error (pe.generator + ".elements_by_name (..)")
								end
							else
								report_error (pe.generator + ".elements_by_name (..)")
							end
						end
					end
				else
					if not p.has_element_by_name (e.name) then
						report_error (p.generator + ".has_element_by_name (..)")
					else
						if p.element_by_name (e.name) = Void then
							report_error (e.generator + ".element_by_name (..)")
						end
						if attached {XML_ELEMENT} p as pe then
							if attached pe.elements_by_name (e.name) as lst then
								if ∃ c: lst ¦ c = e then
								else
									report_error (pe.generator + ".elements_by_name (..)")
								end
							else
								report_error (pe.generator + ".elements_by_name (..)")
							end
						end
					end
				end
				if ∃ c: p.elements ¦ c = e then
				else
					report_error (p.generator + ".elements")
				end
			end
			Precursor (e)
		end

	process_attribute (att: XML_ATTRIBUTE)
			-- Process attribute `att'.
		do
			check_named_node (att)
			if attached {XML_ELEMENT} att.parent as e then
				if e /= last_element then
					report_error ("last_element not synchronized")
				end
				if not e.has_attribute_by_name (att.name) then
					report_error (e.generator + ".has_attribute_by_name (..)")
				end
				if e.attribute_by_name (att.name) = Void then
					report_error (e.generator + ".attribute_by_name (..)")
				end
				if ∃ c: e.attributes ¦ c = att then
				else
					report_error (e.generator + ".attributes")
				end
			end

		end

feature {NONE} -- Implementation

	last_element: detachable XML_ELEMENT

end
