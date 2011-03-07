note
	description: "Summary description for {EV_RIBBON_COMBO_BOX_ITEM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_COMBO_BOX_ITEM

feature -- Query

	label: detachable STRING_32
			-- String label

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked
		local
			l_cache: like select_actions_cache
		do
			l_cache := select_actions_cache
			if l_cache = Void then
				create l_cache
				select_actions_cache := l_cache
			end
			Result := l_cache
		end

feature -- Command

	set_label (a_label: like label)
			-- Set `label' with `a_label'
		do
			label := a_label
		ensure
			set: label = a_label
		end

feature {EV_RIBBON_COMBO_BOX} -- Implementation

	select_actions_cache: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Lazy initialization
end
