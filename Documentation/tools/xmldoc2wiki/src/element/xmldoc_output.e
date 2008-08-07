indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_OUTPUT

inherit
	XMLDOC_ITEM

	XMLDOC_WITH_CONTENT
		rename
			make as make_with_content
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_content
		end

feature -- Access

	output: STRING
			-- Associated `output' name

	matched (n: STRING): BOOLEAN
		do
			if output = Void then
				Result := True
			elseif n = Void then
				Result := False
			else
				Result := n.is_equal (output)
			end
		end

feature -- Element change

	set_output (v: like output)
			-- Set `output'
		require
			v_attached: v /= Void
		do
			output := v
			output.left_adjust
			output.right_adjust
			output.to_lower
		end

end
