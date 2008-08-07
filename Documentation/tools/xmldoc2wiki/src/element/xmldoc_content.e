indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_CONTENT

inherit
	XMLDOC_ITEM

	DEBUG_OUTPUT

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (t: STRING) is
			-- Initialize `Current'.
		require
			t_attached: t /= Void
		do
			create text.make_empty
			append_text (t)
		ensure
			new_string: t /= text
		end

feature -- Access

	is_empty: BOOLEAN
			-- Is content empty?
		do
			Result := text = Void or else text.is_empty
		end

	text: STRING
			-- Associated text

	to_integer: INTEGER
			-- Associated integer
		do
			if text.is_integer then
				Result := text.to_integer
			end
		end

feature -- Element change

	update
		local
			i: INTEGER
			t: like text
			l_cleaning: BOOLEAN
		do
			from
				i := 1
				t := text
				l_cleaning := True
			until
				i > t.count
			loop
				if l_cleaning then
					if t.item (i).is_space then
						t.remove (i)
					else
						l_cleaning := False
						i := i + 1
					end
				else
					if t.item (i) = '%N' then
						l_cleaning := True
					end
					i := i + 1
				end
			end
		end

	append_text (t: like text)
			-- Append `t' to `text'
		require
			t_attached: t /= Void
		do
			text.append_string (t)
--			update
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string ("Content(" + text.count.out + ")=")
			if text.count > 10 then
				Result.append_string (text.substring (1, 30) + "...")
			else
				Result.append_string (text)
			end
		end

invariant
	text_attached: text /= Void

end
