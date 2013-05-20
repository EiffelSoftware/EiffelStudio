note
	description: "Summary description for {WSF_WITH_CSS_STYLE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WITH_CSS_STYLE

feature -- Status report

	css_style: detachable CSS_STYLE

feature -- Change

	reset_css_style
		do
			css_style := Void
		end

	add_css_style (a_style: like css_style)
		local
			s: like css_style
		do
			s := css_style
			if s = Void then
				css_style := a_style
			elseif a_style /= Void then
				css_style := s + a_style
			end
		end

feature -- Conversion

	append_css_style_to (a_target: STRING)
		do
			if attached css_style as l_css_style then
				a_target.append (" style=%"")
				l_css_style.append_inline_to (a_target)
				a_target.append_character ('%"')
			end
		end

end
