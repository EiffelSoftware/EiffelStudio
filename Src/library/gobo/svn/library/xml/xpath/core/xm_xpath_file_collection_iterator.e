indexing

	description:

		"Objects that iterate cheaply over a file collection"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_FILE_COLLECTION_ITERATOR

inherit

	XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_NODE]

	XM_XPATH_STANDARD_NAMESPACES
		export {NONE} all end

	XM_XPATH_ERROR_TYPES
		export {NONE} all end
	
	UT_SHARED_URL_ENCODING
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_entries: ARRAY [STRING]; a_base_uri: UT_URI; a_context: XM_XPATH_CONTEXT) is
			-- Set `entries' to `a_entries'.
		require
			a_entries_not_void: a_entries /= Void
			a_base_uri_not_void: a_base_uri /= Void and then a_base_uri.is_absolute
			dynamic_context_not_void: a_context /= Void
		do
			entries := a_entries
			size := entries.count
			base_uri := a_base_uri
			saved_context := a_context
		ensure
			entries_set: entries = a_entries
			correct_size: size = entries.count
			base_uri_set: base_uri = a_base_uri
			dynamic_context_saved: saved_context = a_context
		end

feature -- Access

	item: XM_XPATH_NODE
			-- Value or node at the current position

feature -- Status report

	after: BOOLEAN is
			-- Are there any more items in the sequence?
		do
			Result := item = Void
		end

feature -- Cursor movement

	forth is
			-- Move to next position.
		local
			a_file_name: STRING
			a_file_uri: UT_URI
			an_error: XM_XPATH_ERROR_VALUE
		do
			from item := Void until item /= Void or position > size loop
				position := position + 1
				if position <= size then
					a_file_name := entries.item (position)
					if not Url_encoding.has_excluded_characters (a_file_name) then
						
						-- for now, we just ignore errors, continuing around the loop

						create a_file_uri.make_resolve (base_uri, a_file_name)
						if saved_context.available_documents.is_document_mapped (a_file_uri.full_uri) then
							create an_error.make_from_string ("Incompatiable isolation-levels between collection " + base_uri.full_reference + " and document " + a_file_uri.full_reference,
																									Gexslt_eiffel_type_uri, "ISOLATION-LEVEL", Dynamic_error)
							set_last_error (an_error)
							position := size + 1
						else
							saved_context.build_document (a_file_uri.full_reference)
							if not saved_context.is_build_document_error then
								item := saved_context.last_parsed_document
							end
						end
					end
				end
			end
			index := index + 1
		end

feature -- Duplication

	another: like Current is
			-- Another iterator that iterates over the same items as the original;
			-- The new iterator will be repositioned at the start of the sequence
		do
			create Result.make (entries, base_uri, saved_context)
		end

feature {NONE} -- Implementation

	entries: ARRAY [STRING]
			-- Directory entries

	size: INTEGER
			-- Size of `entries'

	position: INTEGER
			-- Position within `entries'

	base_uri: UT_URI
			-- Base URI for file name

	saved_context: XM_XPATH_CONTEXT
			-- Saved dynamic context

invariant

	entries_not_void: entries /= Void
	base_uri_not_void: base_uri /= Void and then base_uri.is_absolute
	saved_context_not_void: saved_context /= Void

end
	
