note
	description	: "Abstract notion of a command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud  PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_COMMAND

inherit
	E_CMD

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_SHORTCUT_MANAGER

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

feature -- Access

	accelerator: EV_ACCELERATOR;
			-- Key combination that executes `Current'.

	referred_shortcut: MANAGED_SHORTCUT
			-- A referred managed shortcut.

	shortcut_string: STRING_GENERAL
			-- Shortcut string.
		do
			if referred_shortcut /= Void then
				Result := referred_shortcut.display_string
			elseif accelerator /= Void then
				Result := accelerator.out
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status report

	shortcut_available: BOOLEAN
			-- Is shortcut available?
		do
			if referred_shortcut /= Void then
				Result := not referred_shortcut.is_wiped
			elseif accelerator /= Void then
				Result := True
			end
		end

feature -- Status Change

	set_referred_shortcut (a_shortcut: like referred_shortcut)
			-- Set `referred_shortcut' with `a_shortcut'.
		do
			referred_shortcut := a_shortcut
		ensure
			referred_shortcut_set: referred_shortcut = a_shortcut
		end

	update (a_window: EV_WINDOW)
			-- Update `accelerator' and interfaces according to `referred_shortcut'.
		require
			a_window_not_void: a_window /= Void
		do
			update_accelerator (a_window)
		end

feature {NONE} -- Implementation

	update_accelerator (a_window: EV_WINDOW)
			-- Change `accelerator' according to `referred_shortcut' and
			-- update it in `a_window'.
		require
			a_window_not_void: a_window /= Void
		local
			l_accelerators: EV_ACCELERATOR_LIST
			l_accelerator: like accelerator
			l_compare_object: BOOLEAN
			l_dev_window: EB_VISION_WINDOW
		do
			collect_destroyed_accelerators

			if accelerator /= Void and then referred_shortcut /= Void then
				l_accelerators := a_window.accelerators
					-- Remove accelerator from related window.
				l_compare_object := l_accelerators.object_comparison
				l_accelerators.compare_references
				remove_accelerator_managed_from_list (l_accelerators)
				if l_compare_object then
					l_accelerators.compare_objects
				end

					-- Modify `accelerator' accordingly
				if not referred_shortcut.is_wiped then
					l_accelerator := accelerator
					if l_accelerator.parented then
							-- A paranted accelerator should be using in a existing window.
						l_accelerator := duplicate_accelerator (l_accelerator)
					end
					l_accelerator.set_key (referred_shortcut.key)
					if referred_shortcut.is_ctrl then
						l_accelerator.enable_control_required
					else
						l_accelerator.disable_control_required
					end
					if referred_shortcut.is_alt then
						l_accelerator.enable_alt_required
					else
						l_accelerator.disable_alt_required
					end
					if referred_shortcut.is_shift then
						l_accelerator.enable_shift_required
					else
						l_accelerator.disable_shift_required
					end
						-- Add new accelerator to `a_window'
					if l_accelerators.has (l_accelerator) then
						l_dev_window ?= a_window
						check not_void: l_dev_window /= Void end
						shortcut_manager.post_updating_actions_of (l_dev_window).extend_kamikaze (agent extend_accelerator (l_accelerators, l_accelerator))
					else
						extend_accelerator (l_accelerators, l_accelerator)
					end
					managed_accelerators.extend (l_accelerator)
				end
			end
		end

	extend_accelerator (a_list: EV_ACCELERATOR_LIST; a_acc: EV_ACCELERATOR)
			-- Extend an accelerator into the list.
		require
			a_list_not_void: a_list /= Void
			a_acc_not_void: a_acc /= Void
			a_list_not_have_a_acc: not a_list.has (a_acc)
		do
			a_list.extend (a_acc)
		end

	remove_accelerator_managed_from_list (a_list: EV_ACCELERATOR_LIST)
			-- Remove any managed accelerator from `a_list'. Also wipe it in `managed_accelerators'.
		require
			a_list_not_void: a_list /= Void
		local
			l_managed: like managed_accelerators
		do
			from
				l_managed := managed_accelerators
				l_managed.start
			until
				l_managed.after
			loop
				if a_list.has (l_managed.item) then
					a_list.prune_all (l_managed.item)
					l_managed.remove
				else
					l_managed.forth
				end
			end
		end

	duplicate_accelerator (a_acc: EV_ACCELERATOR): EV_ACCELERATOR
			-- Duplicate accelerator.
		require
			a_acc_not_void: a_acc /= Void
			a_acc_not_distroyed: not a_acc.is_destroyed
		do
			create Result.make_with_key_combination (a_acc.key, a_acc.control_required, a_acc.alt_required, a_acc.shift_required)
			Result.actions.append (a_acc.actions)
		ensure
			Result_not_void: Result /= Void
		end

	collect_destroyed_accelerators
			-- Remove destroyed or unparented accelerators from `managed_accelerators'.
		local
			l_accs: like managed_accelerators
		do
			from
				l_accs := managed_accelerators
				l_accs.start
			until
				l_accs.after
			loop
				if l_accs.item.is_destroyed or else not l_accs.item.parented then
					l_accs.remove
				else
					l_accs.forth
				end
			end
		end

	managed_accelerators: ARRAYED_LIST [EV_ACCELERATOR]
			-- Managed accelerators
			-- Each accelerator should be taken by one window.
			-- If current is any once object, destroyed/unparented accelerator might exist.
			-- Those accelerators should be removed by `collect_destroyed_accelerators' at a suitable timing.
		do
			if managed_accelerators_internal = Void then
				create Result.make (1)
				managed_accelerators_internal := Result
			else
				Result := managed_accelerators_internal
			end
		ensure
			Result_not_void: Result /= Void
		end

	managed_accelerators_internal: like managed_accelerators;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_COMMAND
