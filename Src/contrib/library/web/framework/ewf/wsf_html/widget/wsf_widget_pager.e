note
	description: "Summary description for {WSF_WIDGET_PAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_PAGER

inherit
	WSF_WIDGET

create
	make

feature {NONE} -- Initialization

	make (tpl: READABLE_STRING_8; a_lower, a_upper: NATURAL_64; a_step: NATURAL_64)
		do
			create template.make (tpl)
			lower := a_lower
			upper := a_upper
			step := a_step
		end

feature -- Change

	set_active_range (a_lower, a_upper: NATURAL_64)
		do
			if a_upper = 0 then
				active_range := [{NATURAL_64} 1, {NATURAL_64} 0]
			elseif a_lower > 0 and a_lower <= a_upper then
				active_range := [a_lower, a_upper]
			else
				active_range := Void
			end
		ensure
			valid_range: attached active_range as rg implies (rg.upper = 0 or else rg.lower <= rg.upper)
		end

feature -- Access

	template: URI_TEMPLATE

	lower: NATURAL_64

	upper: NATURAL_64

	step: NATURAL_64

	active_range: detachable TUPLE [lower_index, upper_index: NATURAL_64]

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		local
			l_step: INTEGER
			nb: INTEGER
			curr: INTEGER
			n, i: INTEGER
			tb: HASH_TABLE [detachable ANY, STRING_8]
		do
			a_html.append ("<div")
			a_html.append_character ('>')
			nb := ((upper - lower) // step).to_integer_32 + 1
			if nb > 1 then
				if attached active_range as rg then
					if rg.upper_index = 0 then
						-- all
					else
						curr := ((rg.lower_index - lower) // step).to_integer_32
						if step * curr.to_natural_64 < rg.lower_index then
							curr := curr + 1
						end
					end
				end

				l_step := step.to_integer_32
				create tb.make (2)
				tb.force (1, "lower")
				tb.force (step, "upper")
				if curr > 1 then
					if curr > 2 then
						tb.force (1, "lower")
						tb.force (l_step, "upper")

						a_html.append_character (' ')
						append_link_to_html (a_theme, "<<", template.expanded_string (tb), a_html)
						a_html.append_character (' ')
					end

					tb.force ((curr - 1) * l_step + 1, "lower")
					tb.force ((curr    ) * l_step    , "upper")

					a_html.append_character (' ')
					append_link_to_html (a_theme, "<", template.expanded_string (tb), a_html)
					a_html.append_character (' ')
				end

				from
					i := (curr - 1).max (1)
					n := 5
				until
					n = 0 or i > nb
				loop
					a_html.append_character (' ')

					tb.force ((i - 1) * l_step + 1, "lower")
					tb.force ((i    ) * l_step    , "upper")

					if i = curr then
						a_html.append ("<strong>")
					end
					append_link_to_html (a_theme, i.out, template.expanded_string (tb), a_html)
					if i = curr then
						a_html.append ("</strong>")
					end

					a_html.append_character (' ')

					i := i + 1
					n := n - 1
				end

				if curr < nb then
					a_html.append_character (' ')
					tb.force ((curr    ) * l_step + 1, "lower")
					tb.force ((curr + 1) * l_step    , "upper")
					append_link_to_html (a_theme, ">", template.expanded_string (tb), a_html)
					a_html.append_character (' ')

					if curr + 1 < nb then
						tb.force ((nb - 1) * l_step + 1, "lower")
						tb.force ( upper , "upper")

						a_html.append_character (' ')
						append_link_to_html (a_theme, ">>", template.expanded_string (tb), a_html)
						a_html.append_character (' ')
					end
				end
				a_html.append_character (' ')
				tb.force (1, "lower")
				tb.force (upper , "upper")
				append_link_to_html (a_theme, "all", template.expanded_string (tb), a_html)
				a_html.append_character (' ')
			end

			a_html.append ("</div>")
			debug
				a_html.append ("curr=" + curr.out +" step=" + step.out + " nb=" + nb.out)
			end
		end

feature -- Factory

	append_link_to_html (a_theme: WSF_THEME; a_text: detachable READABLE_STRING_GENERAL; a_path: STRING; a_html: STRING_8)
		do
			a_theme.append_link_to_html (a_text, a_path, Void, a_html)
		end

end
