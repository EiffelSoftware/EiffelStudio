note
	description: "Fixes violations of rule #87 ('Mergeable conditionals')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_MERGEABLE_CONDITIONALS_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_ifs

feature {NONE} -- Initialization
	make_with_ifs (a_class: attached CLASS_C; a_if_1: attached IF_AS; a_if_2: attached IF_AS)
			-- Initializes `Current' with class `a_class'. `a_if_1' and `a_if_2' are the if blocks to be merged.
		do
			make (ca_names.mergeable_conditionals_fix, a_class)
			first := a_if_1
			second := a_if_2
		end

feature {NONE} -- Implementation

	execute (a_class: attached CLASS_AS)
		local
			l_new, l_indent, l_temp: STRING
		do
			create l_new.make_empty
			create l_indent.make_empty

				-- Calculate the indentation of the first if block. TODO: Refactor.
			l_temp := matchlist.i_th (first.if_keyword (matchlist).index - 1).text_32 (matchlist)
			l_indent := l_temp.substring (l_temp.index_of ('%T', 1), l_temp.count)

				-- Combine then-parts.

			l_new.append (l_indent + "if " + first.condition.text_32 (matchlist) + " then%N")

			if attached first.compound as f_compound then
				l_new.append (l_indent + "%T" + f_compound.text_32 (matchlist) + "%N")
				if attached second.compound as s_compound then
					l_new.append (l_indent + "%T" + s_compound.text_32 (matchlist) + "%N")
				end
			elseif attached second.compound as s_compound then
				l_new.append (l_indent + "%T" + s_compound.text_32 (matchlist) + "%N")
			end

				-- Combine else-parts.

			if attached first.else_part as f_else then
				l_new.append (l_indent + "else%N" + l_indent + "%T" + f_else.text_32 (matchlist) + "%N")
				if attached second.else_part as s_else then
					l_new.append (l_indent + "%T" + s_else.text_32 (matchlist) + "%N")
				end
				l_new.append (l_indent + "end")
			elseif attached second.else_part as s_else then
				l_new.append (l_indent + "else%N" + l_indent + "%T" + s_else.text_32 (matchlist) + "%N" + l_indent + "end")
			else
				l_new.append (l_indent + "end")
			end

			first.replace_text (l_new, matchlist)
				-- Remove second if block.
			second.remove_text (matchlist)
		end

	first: IF_AS
		-- The first if block to be merged.

	second: IF_AS
		-- The second if block to be merged.

end
