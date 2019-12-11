	note
	description: "Generic PREFERENCE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TYPED_PREFERENCE [G]

inherit
	PREFERENCE

feature {NONE} --Initialization

	make (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: G)
			-- New preference with `a_name' and `a_value'.
		require
			manager_not_void: a_manager /= Void
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
		do
			manager := a_manager
			name := a_name
			internal_value := a_value
			set_value (a_value)
			change_actions.extend (agent update_is_auto)
		ensure
			has_manager: manager /= Void
			has_name: name /= Void and not name.is_empty
			has_change_action: change_actions /= Void
		end

	make_from_string_value (a_manager: PREFERENCE_MANAGER; a_name: STRING; a_value: READABLE_STRING_GENERAL)
			-- Create preference and set value based on string value `a_value'.
		require
			manager_not_void: a_manager /= Void
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			value_valid: is_string_value_validated (a_value)
		do
			manager := a_manager
			name := a_name
			init_value_from_string (a_value)
			change_actions.extend (agent update_is_auto)
		ensure
			has_manager: manager /= Void
			has_name: name /= Void and not name.is_empty
			has_change_action: change_actions /= Void
		end

	init_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Set initial value from String `a_value'
		require
			a_value_attached: a_value /= Void
		do
			set_value_from_string (a_value)
		end

feature -- Status report

	is_valid_string_for_selection (s: READABLE_STRING_32): BOOLEAN
			-- <Precursor>
		do
			Result := is_string_value_validated (s)
		end

feature -- Modification

	set_value (a_value: G)
			-- Set the value.
		require
			value_not_void: a_value /= Void
		do
			previous_value := value
			internal_value := a_value
			if attached internal_change_actions as l_actions then
				l_actions.call ([Current])
			end
			if attached internal_typed_change_actions as l_actions then
				l_actions.call ([internal_value])
			end
		ensure
			value_set: internal_value = a_value
		end

	set_value_to_auto
			-- Set the value to match that of `auto_preference'.
		require
			has_auto_preference: auto_preference /= Void
		local
			l_value: like value
		do
				-- Implied by precondition `has_auto_preference'
			check attached auto_preference as l_auto_preference then
				l_value := l_auto_preference.value
				check attached l_value end -- implied by invariant `attached_auto_preference_has_value' and precondition `has_auto_preference'
				set_value (l_value)
			end
		ensure
			value_set: (attached auto_preference as el_auto_preference) and then internal_value = el_auto_preference.value
		end

	select_value_from_string (s: READABLE_STRING_32)
			-- <Precursor>
		do
			set_value_from_string (s)
		end

	set_auto_preference (a_pref: like Current)
			-- Use value of `a_pref' for "auto" value for Current.
		require
			a_pref_not_void: a_pref /= Void and then a_pref.has_value
		do
			auto_preference := a_pref
			a_pref.change_actions.extend (agent try_to_set_value_to_auto)
			set_value_to_auto
		ensure
			auto_set: auto_preference = a_pref
		end

feature -- Access

	value: G
			-- Actual value.
		do
			if is_auto then
					-- implied by `is_auto' and code from `update_is_auto'
				check attached auto_preference as l_auto_preference then
					Result := l_auto_preference.value
				end
			else
				Result := internal_value
			end
		end

	has_value: BOOLEAN
			-- Does Current have a value to use?
		do
			Result := value /= Void
		ensure then
			Result_implies_value_attached: Result implies value /= Void
		end

	typed_change_actions: ACTION_SEQUENCE [TUPLE [G]]
			-- Actions to be performed when `value' changes after actions of `change_actions'.
		local
			l_result: like internal_typed_change_actions
		do
			l_result := internal_typed_change_actions
			if l_result = Void then
				create l_result
				internal_typed_change_actions := l_result
			end
			Result := l_result
		ensure
			Result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	auto_default_value: G
			-- Value to use when Current is using auto by default (until real auto is set)
		deferred
		end

	try_to_set_value_to_auto
			-- Set the value to match that of `auto_preference' (only if `value' was not changed manually).		
		do
			if attached auto_preference as l_auto_preference then
				if (attached l_auto_preference.previous_value as l_previous_value) and then internal_value ~ l_previous_value then
					set_value_to_auto
				elseif (attached l_auto_preference.value as l_value) and then internal_value ~ l_value then
					set_value_to_auto
				end
			end
		end

	update_is_auto
			-- Update based on value if now the value is auto
		do
			is_auto := (attached auto_preference as l_auto_preference) and then internal_value ~ l_auto_preference.value
		end

	internal_typed_change_actions: detachable like typed_change_actions
			-- Storage for `typed_change_actions'.

	internal_value: G
			-- Internal value.

feature {TYPED_PREFERENCE} -- Implementation	

	previous_value: detachable like value
			-- Value held before this one, if any.

invariant
	typed_change_actions_not_void: typed_change_actions /= Void
	attached_auto_preference_has_value: (attached auto_preference as l_auto_preference) implies l_auto_preference.has_value

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class TYPED_PREFERENCE
