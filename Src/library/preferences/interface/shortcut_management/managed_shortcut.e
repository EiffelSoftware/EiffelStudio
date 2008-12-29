note
	description: "Objects represents a managed shortcut"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MANAGED_SHORTCUT

feature -- Access

	name: STRING_GENERAL
			-- Name of the shortcut.
		deferred
		end

	key: EV_KEY
			-- Actual key.
		deferred
		ensure
			a_key_not_void: Result /= Void
		end

	display_string: STRING
			-- String representation of key combination.
		local
			a_key: STRING
		do
			if is_wiped then
				Result := ""
			else
				create Result.make (0)
				if is_ctrl then
					Result.append ("Ctrl+")
				end
				if is_alt then
					Result.append ("Alt+")
				end
				if is_shift then
					Result.append ("Shift+")
				end
				a_key := key.out.twin
					--| We only need to convert the key to upper case if
					--| it is one character long such as 'a'. Other keys
					--| do not need to be converted.
				if a_key.count = 1 then
					a_key.to_upper
				end
				Result.append (a_key)
			end
		ensure
			Result_not_void: Result /= Void
		end

	group: MANAGED_SHORTCUT_GROUP
			-- Group of the shortcut.

	overridden_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when Current is overriden within `group'.
		do
			if overridden_actions_internal = Void then
				create overridden_actions_internal
			end
			Result := overridden_actions_internal
		ensure
			Result_not_void: Result /= Void
		end

	modification_deny_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when modificaton is denied.
		do
			if modification_deny_actions_internal = Void then
				create modification_deny_actions_internal
			end
			Result := modification_deny_actions_internal
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status change

	set_group (a_group: MANAGED_SHORTCUT_GROUP)
			-- Set `group' with `a_group'.
			-- Change elements in `group' and `a_group' also.
		local
			l_shortcut: MANAGED_SHORTCUT
		do
			if a_group = group then
					-- Do nothing if setting the same group.
			else
				if a_group = Void then
					if group /= Void then
						group.remove_shortcut (Current)
					end
				else
					if not a_group.has (Current) then
						a_group.add_shortcut (Current)
						if group /= Void then
							group.remove_shortcut (Current)
						end
					else
						l_shortcut := a_group.found_item
						check
							l_shortcut_not_void: l_shortcut /= Void
						end
						if not l_shortcut.is_fixed then
								-- Override a non fixed shortcut and call related action.
							l_shortcut.set_is_wiped (True)
							a_group.add_shortcut (Current)
							if group /= Void then
								group.remove_shortcut (Current)
							end
							if l_shortcut /= Current then
								l_shortcut.overridden_actions.call (Void)
							end
						else
								-- Failed, we set the group but wipe current.
							set_is_wiped (True)
						end
					end
				end
				group := a_group
			end
		ensure
			group_set: group = a_group
			group_element_set: 		((old group) /= Void implies not (old group).shortcuts.has (Current)) and
									(a_group /= Void implies a_group.shortcuts.has (Current))
		end

	set_values (a_key: like key; alt, ctrl, shift: BOOLEAN)
			-- Set values.
		require
			modifiable: modifiable_with (a_key, alt, ctrl, shift)
		local
			l_shortcut: MANAGED_SHORTCUT
		do
			if a_key = Void then
				set_is_wiped (True)
			else
				if group /= Void then
					if group.has_key_combination (a_key, alt, ctrl, shift) then
						l_shortcut := group.found_item
						l_shortcut.set_is_wiped (True)
						if l_shortcut /= Current then
							l_shortcut.overridden_actions.call (Void)
						end
					end
				end
				set_is_wiped (False)
			end
		end

feature -- Status report

	is_ctrl: BOOLEAN
		deferred
		end

	is_alt: BOOLEAN
		deferred
		end

	is_shift: BOOLEAN
		deferred
		end

	is_fixed: BOOLEAN
			-- Can this shortcut be overriden when inserting a same one in `group'?

	is_wiped: BOOLEAN
			-- If true, shortcut management doesn't take current into account when comparing.

	matches_shortcut (a_shortcut: like Current): BOOLEAN
			-- Do `a_shortcut' matches current?
		do
			if a_shortcut /= Void then
				if not a_shortcut.is_wiped then
					Result := matches (a_shortcut.key, a_shortcut.is_alt, a_shortcut.is_ctrl, a_shortcut.is_shift)
				end
			end
		end

	matches (a_key: like key; alt, ctrl, shift: BOOLEAN): BOOLEAN
			-- Do combinations of `a_key', `alt', `ctrl' an `shift' match Current?
		require
			a_key_not_void: a_key /= Void
		do
			if not is_wiped then
				Result := (is_alt = alt)
					and then (is_ctrl = ctrl)
					and then (is_shift = shift)
				if Result then
					Result := key.code = a_key.code
				end
			end
		end

	modifiable_with (a_key: like key; alt, ctrl, shift: BOOLEAN): BOOLEAN
			-- Is current modifiable considering shortcuts in `group'?
		do
			if group = Void then
				Result := True
			else
				if group.has_key_combination (a_key, alt, ctrl, shift) then
					Result := not group.found_item.is_fixed
				else
					Result := True
				end
			end
		end

feature {MANAGED_SHORTCUT, MANAGED_SHORTCUT_GROUP} -- Implementation

	set_is_wiped (a_b: BOOLEAN)
			-- Set `is_wiped' with `a_b'
		require
			not_a_b_implies_modifiable: not a_b implies modifiable_with (key, is_alt, is_ctrl, is_shift)
		do
			is_wiped := a_b
		ensure
			is_wiped_set: is_wiped = a_b
		end

feature {NONE} -- Implementation

	modification_deny_actions_internal: EV_NOTIFY_ACTION_SEQUENCE

	overridden_actions_internal: EV_NOTIFY_ACTION_SEQUENCE;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
