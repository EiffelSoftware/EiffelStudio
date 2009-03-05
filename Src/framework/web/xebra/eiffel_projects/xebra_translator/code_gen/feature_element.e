note
	description: "Summary description for {FEATURE_ELEMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make,
	make_with_locals

feature -- Access

	signature: STRING
			-- Signature of the feature

	locals: LIST [VARIABLE_ELEMENT]
			-- The local variables of the feature

	content: LIST [SERVLET_ELEMENT]
			-- The body expressions of the feature

feature -- Initialization

	make (a_signature: STRING; a_content: LIST [SERVLET_ELEMENT])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
		require
			signature_valid: not a_signature.is_empty
		local
			list: LIST [VARIABLE_ELEMENT]
		do
			create {LINKED_LIST [VARIABLE_ELEMENT]} list.make
			make_with_locals (a_signature, a_content, list)
		end

	make_with_locals (a_signature: STRING; a_content: LIST [SERVLET_ELEMENT]; some_locals: LIST[VARIABLE_ELEMENT])
			-- `a_signature': The signature of the feature
			-- `a_content': The feature body
			-- `some_locals': The local variables of the feature
		require
			signature_valid: not a_signature.is_empty
		do
			signature := a_signature
			locals := some_locals
			content := a_content
		end

feature -- Processing

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (signature)
			buf.indent
			if not locals.is_empty then
				buf.put_string ("local")
				buf.indent
				from
					locals.start
				until
					locals.after
				loop
					locals.item.serialize (buf)
					locals.forth
				end
				buf.unindent
			end
			buf.put_string ("do")
			buf.indent
			from
				content.start
			until
				content.after
			loop
				content.item.serialize (buf)
				content.forth
			end
			buf.unindent
			buf.put_string ("end")
			buf.unindent
		end

end
