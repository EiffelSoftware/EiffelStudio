note
	description: "Summary description for {FEATURE_ELEMENT}."
	author: "sandro"
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

	feature_name: STRING
	locals: LIST [VARIABLE_ELEMENT]
	content: LIST [SERVLET_ELEMENT]

	make (a_feature_name: STRING; a_content: LIST[SERVLET_ELEMENT])
		local
			list: LIST [VARIABLE_ELEMENT]
		do
			create {LINKED_LIST [VARIABLE_ELEMENT]} list.make
			make_with_locals (a_feature_name, a_content, list)
		end

	make_with_locals (a_feature_name: STRING; a_content: LIST[SERVLET_ELEMENT]; some_locals: LIST[VARIABLE_ELEMENT])
		do
			feature_name := a_feature_name
			locals := some_locals
			content := a_content
		end

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>			
		do
			buf.put_string (feature_name)
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
