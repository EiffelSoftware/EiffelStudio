indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_TEXT_CONTAINER

inherit
	XMLDOC_ITEM

	XMLDOC_WITH_CONTENT
		rename
			make as make_content
		redefine
			valid_item
		end

feature {NONE} -- Initialization

	make
			-- Initialize Current.
		do
			make_content
		end

feature -- Access

	text_representation: XMLDOC_CONTENT
			-- Text representation for Current and `items'
		local
			i: XMLDOC_ITEM
			s: STRING
		do
			from
				create s.make_empty
				items.start
			until
				items.after
			loop
				i := items.item
				if {t: XMLDOC_WITH_TEXT} i then
					s.append (t.text)
				elseif {tc: XMLDOC_TEXT_CONTAINER} i then
					s.append (tc.text_representation.text)
				end
				items.forth
			end
			create Result.make_with_text (s)
		ensure
			Result_attached: Result /= Void
		end

feature -- Element change

	valid_item (i: XMLDOC_ITEM): BOOLEAN
			-- is_text_or_container
		do
			Result := ({ot_t: XMLDOC_TEXT} i)
					or ({ot_c: XMLDOC_TEXT_CONTAINER} i)
					or ({ot_l: XMLDOC_LINK} i)
					or ({ot_i: XMLDOC_IMAGE} i)
					-- or ({ot_h: XMLDOC_HEADING} i)
		end

end
