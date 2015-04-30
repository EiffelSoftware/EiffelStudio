note
	description: "Options for any html item during CMS theme output."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HTML_OPTIONS

feature -- Access

	css_classes: detachable ARRAYED_LIST [READABLE_STRING_8]
			-- Optional additional css classes.

feature -- Element change	

	add_css_class (a_class: READABLE_STRING_8)
			-- Add css class `a_class'.
		local
			l_css_classes: like css_classes
		do
			l_css_classes := css_classes
			if l_css_classes = Void then
				create l_css_classes.make (1)
				css_classes := l_css_classes
			end
			l_css_classes.force (a_class)
		end

	remove_css_class (a_class: READABLE_STRING_GENERAL)
			-- Remove css class `a_class'.
		local
			l_css_classes: like css_classes
		do
			l_css_classes := css_classes
			if l_css_classes /= Void then
				from
					l_css_classes.start
				until
					l_css_classes.after
				loop
					if a_class.is_case_insensitive_equal (l_css_classes.item) then
						l_css_classes.remove
						l_css_classes.finish
					end
					l_css_classes.forth
				end
			end
		end

end
