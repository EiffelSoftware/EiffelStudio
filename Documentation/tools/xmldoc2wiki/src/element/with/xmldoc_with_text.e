indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_TEXT

feature -- Access

	text: STRING
			-- Associated text

	is_empty: BOOLEAN
		do
			Result := text = Void or else text.is_empty
		end

feature -- Element change

	set_text (t: like text)
			-- Set `text' to `t'
		require
			t_attached: t /= Void
		do
			text := t
		end

end
