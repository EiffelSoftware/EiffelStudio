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
			l_lines: LIST [STRING]
			l_new_lines: ARRAYED_LIST [STRING]
			l_line: STRING
			l_blank: CHARACTER
			n: INTEGER
			l_is_not_empty: BOOLEAN
		do
			if not text.is_empty then
				l_lines := text.split ('%N')
				text.wipe_out
				from
					l_blank := ' '
					create l_new_lines.make (l_lines.count)
					l_lines.start
				until
					l_lines.after
				loop
					l_line := l_lines.item
					n := l_line.count
					if n > 0 then
						l_line.left_adjust
						if n > l_line.count then
							l_line.prepend_character (l_blank)
							l_is_not_empty := True
						end
						n := l_line.count
						l_line.right_adjust
						if n > l_line.count then
							l_line.append_character (l_blank)
							l_is_not_empty := True
						end
					end
					if
						   (l_line.count = 0)
						or (l_line.count = 1 and then l_line.item(1) = l_blank)
						or (l_line.count = 2 and then l_line.item(1) = l_blank and l_line.item (2) = l_blank)
					then
						-- nothing
					else
						l_new_lines.extend (l_line)
					end
					l_lines.forth
				end
				if l_new_lines /= Void and then l_new_lines.count > 0 then
					from
						l_new_lines.start
					until
						l_new_lines.after
					loop
						l_line := l_new_lines.item
						text.append_string (l_line)
						if not l_new_lines.islast then
							text.append_character ('%N')
						end
						l_new_lines.forth
					end
				end
				if text.count = 0 and l_is_not_empty then
					text.append_character (l_blank)
				end
			end
		end

--	update
--		local
--			i: INTEGER
--			t: like text
--			l_cleaning: BOOLEAN
--			l_is_first_space: BOOLEAN
--			l_is_empty_line: BOOLEAN
--			l_line_start: INTEGER
--		do
--			from
--				i := 1
--				t := text
--				l_cleaning := True
--				l_is_first_space := True
--				l_is_empty_line := True
--				l_line_start := 1
--			until
--				i > t.count
--			loop
--				if l_cleaning then
--					if t.item (i).is_space then
--						if l_is_first_space then
--							t.put (' ', i)
--							i := i + 1
--						else
--							t.remove (i)
--						end
--					elseif t.item (i) = '%N' then
--						t.remove (i)
--						l_line_start := i
--						l_is_empty_line := True
--					else
--						l_is_empty_line := False
--						l_cleaning := False
--						i := i + 1
--					end
--				else
--					if t.item (i) = '%N' then
--						t.remove (i)
--						l_line_start := i
--						l_is_empty_line := True
--						l_cleaning := True
--					else
--						i := i + 1
--					end
--				end
--				l_is_first_space := False
--			end
--		end

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
