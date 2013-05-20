note
	description: "Summary description for {WSF_WITH_CSS_CLASS}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WITH_CSS_CLASS

feature -- Status report

	css_classes: detachable LIST [READABLE_STRING_8]

feature -- Change

	reset_css_classes
		do
			css_classes := Void
		end

	add_css_classes (a_classes: detachable ITERABLE [READABLE_STRING_8])
		do
			if a_classes /= Void then
				across
					a_classes as c
				loop
					add_css_class (c.item)
				end
			end
		end

	add_css_class (a_class: READABLE_STRING_8)
		require
			is_valid_css_class: is_valid_css_class (a_class)
		local
			lst: like css_classes
		do
			lst := css_classes
			if lst = Void then
				create {ARRAYED_LIST [READABLE_STRING_8]} lst.make (1)
				lst.compare_objects
				css_classes := lst
			end
			lst.force (a_class)
		end

	remove_css_class (a_class: READABLE_STRING_8)
		require
			is_valid_css_class: is_valid_css_class (a_class)
		local
			lst: like css_classes
		do
			lst := css_classes
			if lst /= Void then
				lst.prune_all (a_class)
			end
		end

feature -- Query

	is_valid_css_class (s: detachable READABLE_STRING_8): BOOLEAN
		do
			Result := s /= Void implies (not s.is_empty)
			-- To complete
		end

feature -- Conversion

	append_css_class_to (a_target: STRING; a_additional_classes: detachable ITERABLE [READABLE_STRING_8])
		local
			f: BOOLEAN
			cl: READABLE_STRING_8
		do
			if css_classes /= Void or a_additional_classes /= Void then
				a_target.append (" class=%"")
				f := True -- is first

				if attached css_classes as l_classes then
					across
						l_classes as c
					loop
						cl := c.item
						if not cl.is_empty then
							if f then
								f := False
							else
								a_target.append_character (' ')
							end
							a_target.append (cl)
						end
					end
				end
				if attached a_additional_classes as l_classes then
					across
						l_classes as c
					loop
						cl := c.item
						if not cl.is_empty then
							if not f then
								a_target.append_character (' ')
							end
							a_target.append (cl)
						end
					end
				end
				a_target.append_character ('%"')
			end
		end

end
