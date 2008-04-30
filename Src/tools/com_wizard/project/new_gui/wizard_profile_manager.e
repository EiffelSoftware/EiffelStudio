indexing
	description: "Store and retrieve profile items.%
					%A Profile is a set of values for all entries in GUI"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROFILE_MANAGER

inherit
	WIZARD_REGISTRY_STORE
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize instance.
		do
			create {ARRAYED_LIST [ROUTINE [ANY, TUPLE []]]} active_profile_change_actions.make (10)
			create {ARRAYED_LIST [FUNCTION [ANY, TUPLE [], WIZARD_PROFILE_ITEM]]} active_profile_save_actions.make (10)
		end

feature -- Access

	Default_profile: STRING is "default"
			-- Name of default profile

	available_profiles: LIST [STRING] is
			-- List of available profiles
		do
			if is_saved_list (Profiles_key) then
				Result := saved_list (Profiles_key)
				Result.compare_objects
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

	active_profile: STRING
			-- Active profile

	active_profile_change_actions: LIST [ROUTINE [ANY, TUPLE []]]
			-- List of routines to call when active profile changes

	active_profile_save_actions: LIST [FUNCTION [ANY, TUPLE [], WIZARD_PROFILE_ITEM]]
			-- List of routines to call when saving active profile to retrieve items

	found: BOOLEAN
			-- Did last call to `search' yield a result?

	found_item: WIZARD_PROFILE_ITEM
			-- Last instance yield by call to `search' if any

	save_blocked: BOOLEAN
			-- True when profile is being set
			-- This flag prevents saving profile while it's being set

feature -- Element Settings

	set_active_profile (a_profile: like active_profile) is
			-- Set `active_profile' with `a_profile'.
		require
			non_void_profile: a_profile /= Void
		local
			l_actions: like active_profile_change_actions
			l_old_saved_blocked: BOOLEAN
		do
			active_profile := a_profile
			if not a_profile.is_equal (Default_profile) then
				if not available_profiles.has (a_profile) then
					initialize_profile (a_profile)
				end
			end
			l_old_saved_blocked := save_blocked
			if not l_old_saved_blocked then
				save_blocked := True
			end
			l_actions := active_profile_change_actions
			from
				l_actions.start
			until
				l_actions.after
			loop
				l_actions.item.call (Void)
				l_actions.forth
			end
			save_blocked := l_old_saved_blocked
		ensure
			active_profile_set: active_profile = a_profile
		end

	set_save_blocked (a_value: BOOLEAN) is
			-- Set `save_blocked' with `a_value'.
		do
			save_blocked := a_value
		ensure
			save_blocked_set: save_blocked = a_value
		end

feature -- Basic Operations

	save_active_profile is
			-- Persist active profile if any.
			-- Add profile to available profiles if not there already.
			--| Profile items are stored in registry as follows:
			--| name1,value11,value12,...,value1n,##,name2,value21,value22,...,value2n,##,...,namen,valuen1,...,valuenn,##
		do
			if active_profile /= Void and not save_blocked then
				save_active_profile_as (active_profile)
			end
		end

	search_active_profile (a_name: STRING) is
			-- Search items of active profile if any for item with name `a_name'.
			-- Set `found_item' and `found' accordingly.
		require
			non_void_name: a_name /= Void
		local
			l_stored_list: LIST [STRING]
			l_name: STRING
		do
			found_item := Void
			found := False
			if active_profile /= Void then
				if is_saved_list (active_profile) then
					l_stored_list := saved_list (active_profile)
					from
						l_stored_list.start
						found := l_stored_list.item.is_equal (a_name)
					until
						l_stored_list.after or found
					loop
						l_stored_list.forth
						l_stored_list.forth
						if not l_stored_list.after then
							found := l_stored_list.item.is_equal (a_name)
						end
					end
					if found then
						l_name := l_stored_list.item
						l_stored_list.forth
						create found_item.make (l_name, l_stored_list.item)
					end
				end
			end
		ensure
			found_item_set: (found_item /= Void) = found
		end

	remove_active_profile is
			-- Remove active profile from profiles list.
		local
			l_stored_list: LIST [STRING]
		do
			if active_profile /= Void then
				if is_saved_list (Profiles_key) then
					l_stored_list := saved_list (Profiles_key)
					l_stored_list.prune_all (active_profile)
					save_list (l_stored_list, Profiles_key)
				end
				if is_saved_list (active_profile) then
					remove_entry (active_profile)
				end
			end
		end

feature {WIZARD_MAIN_WINDOW} -- Implementation

	Profiles_key: STRING is "Profiles"
			-- Key used to store profiles keys list

feature {NONE} -- Implementation

	initialize_profile (a_profile: STRING) is
			-- Initialize `a_profile' with values taken from `default_profile'.
		do
			set_active_profile (default_profile)
			save_active_profile_as (a_profile)
			set_active_profile (a_profile)
		end

	save_active_profile_as (a_profile: STRING) is
			-- Save current profile with name `a_profile'.
		require
			non_void_profile_name: a_profile /= Void
			unblocked_save: not save_blocked
		local
			l_item: WIZARD_PROFILE_ITEM
			l_stored_list: ARRAYED_LIST [STRING]
			l_profiles: LIST [STRING]
		do
			create l_stored_list.make (active_profile_save_actions.count)
			from
				active_profile_save_actions.start
			until
				active_profile_save_actions.after
			loop
				l_item := active_profile_save_actions.item.item (Void)
				l_stored_list.append (l_item.linear_representation)
				active_profile_save_actions.forth
			end
			save_list (l_stored_list, a_profile)
			if is_saved_list (Profiles_key) then
				l_profiles := saved_list (Profiles_key)
			else
				create {ARRAYED_LIST [STRING]} l_profiles.make (1)
			end
			if not l_profiles.has (a_profile) then
				l_profiles.extend (a_profile)
				save_list (l_profiles, Profiles_key)
			end
		end

	Profile_key_suffix: STRING is "_profile_key"
			-- Registry key name suffix for key storing profiles

invariant
	non_void_active_profile_change_actions: active_profile_change_actions /= Void

indexing
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
end -- class WIZARD_PROFILE_MANAGER


