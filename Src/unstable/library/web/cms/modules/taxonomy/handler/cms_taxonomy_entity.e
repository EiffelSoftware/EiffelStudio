note
	description: "[
			Information related to content or taxonomy entity in a taxonomy container.
			
			Mainly used to build list of contents/entities associated with a term.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TAXONOMY_ENTITY

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_content: CMS_CONTENT; a_date: DATE_TIME)
			-- Build Current information from `a_content' dated by `a_date'.
		do
			content := a_content
			date := a_date
		end

feature -- Access

	content: CMS_CONTENT
			-- Content of the entity.

	date: DATE_TIME
			-- Date, usually related to last modification.

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := date < other.date
		end

end
