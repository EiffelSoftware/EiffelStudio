indexing
	description: "Store and retrieve profile items.%
					%A Profile is a set of values for all entries in GUI"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROFILE_MANAGER

inherit
	WIZARD_REGISTRY_STORE
		export
			{NONE} all
		end

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

	available_profiles: LIST [STRING] is
			-- List of available profiles
		do
			if is_saved_list (Profiles_key) then
				Result := saved_list (Profiles_key)
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
			l_old_saved_blocked := save_blocked
			if not l_old_saved_blocked then
				save_blocked := True
			end
			active_profile := a_profile
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
		local
			l_item: WIZARD_PROFILE_ITEM
			l_stored_list: ARRAYED_LIST [STRING]
			l_profiles: LIST [STRING]
		do
			if active_profile /= Void and not save_blocked then
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
				save_list (l_stored_list, active_profile)
				if is_saved_list (Profiles_key) then
					l_profiles := saved_list (Profiles_key)
				else
					create {ARRAYED_LIST [STRING]} l_profiles.make (1)
				end
				if not l_profiles.has (active_profile) then
					l_profiles.extend (active_profile)
					save_list (l_profiles, Profiles_key)
				end
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

	Profile_key_suffix: STRING is "_profile_key"
			-- Registry key name suffix for key storing profiles

invariant
	non_void_active_profile_change_actions: active_profile_change_actions /= Void

end -- class WIZARD_PROFILE_MANAGER
