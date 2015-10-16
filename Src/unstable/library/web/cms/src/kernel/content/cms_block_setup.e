note
	description: "Settings for CMS_BLOCK, that could be set and overwritten via CMS configuration."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOCK_SETUP

feature -- Access

	title: detachable READABLE_STRING_32
			-- Optional title.

	weight: INTEGER
			-- Weight used to order blocks.
			-- Default: 0.

	conditions: detachable LIST [CMS_BLOCK_CONDITION]
			-- Optional block condition to be enabled.			

feature -- Element change	

	set_title (a_title: detachable READABLE_STRING_GENERAL)
			-- Set `title' with `a_title'.
		do
			if a_title = Void then
				title := Void
			else
				title := a_title.as_string_32
			end
		end

	set_weight (w: like weight)
			-- Set `weight' to `w'.
		do
			weight := w
		end

	add_condition (a_condition: CMS_BLOCK_CONDITION)
			-- Add condition `a_condition'.
		local
			l_conditions: like conditions
		do
			l_conditions := conditions
			if l_conditions = Void then
				create {ARRAYED_LIST [CMS_BLOCK_CONDITION]} l_conditions.make (1)
				conditions := l_conditions
			end
			l_conditions.force (a_condition)
		end

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
