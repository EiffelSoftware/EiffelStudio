note
	description: "[
					Represent one item in {EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS}
																									]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_APPLICATION_MENU_RECENT_ITEM

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

feature {EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS} -- Implementation

	select_actions_cache: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Lazy initialization

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
