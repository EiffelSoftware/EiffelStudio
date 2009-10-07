note
	description	: "Object that encapsulates an organised set of favorite classes %
				  %The favorites are project-wide."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES

inherit
	EB_FAVORITES_ITEM_LIST
		export
			{ANY} string_representation
		redefine
			default_create,
			on_item_added,
			on_item_removed
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_string

create {EB_FAVORITES}
	make, make_filled

feature {NONE} -- Initialization

	default_create
			-- Initialization.
		do
			make (10)
			create observer_list.make (10)
			is_initialized := True
			enable_sensitive
			Eiffel_project.manager.close_agents.extend (agent disable_sensitive)
			Eiffel_project.manager.create_agents.extend (agent enable_sensitive)
		end

feature -- Initialization

	make_with_string (a_string: STRING)
			-- [Re]Initialize the favorites from `a_string'.
		local
			analyzed_string: STRING
			retried: INTEGER
		do
			if retried = 0 then
				if is_initialized then
						-- Erase the current favorites
					wipe_out
				else
					default_create
				end

				if a_string /= Void and then a_string.substring_index (name, 1) = 1 then
					analyzed_string := a_string.substring (name.count + 2, a_string.count)
					analyzed_string := initialize_with_string (analyzed_string)
				else
					-- This string does not represent a set of Favorites.
				end
				on_update
			elseif retried = 1 then
				wipe_out
				on_update
			elseif retried = 2 then
				wipe_out
			end
		rescue
			retried := retried + 1
			loading_error := True
			retry
		end

feature -- Observer Pattern

	add_observer (a_observer: EB_FAVORITES_OBSERVER)
		do
			observer_list.extend (a_observer)
		end

	remove_observer (a_observer: EB_FAVORITES_OBSERVER)
		do
			observer_list.start
			observer_list.prune_all (a_observer)
		end

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER])
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			a_folder_item: EB_FAVORITES_FOLDER
			new_path: like a_path
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_added (a_item, a_path)
				observer_list.forth
			end

				-- Add childs as well - if the added item was a folder -.
			if a_item.is_folder then
				a_folder_item ?= a_item
				new_path := a_path.twin
				new_path.extend (a_folder_item)
				from
					a_folder_item.start
				until
					a_folder_item.after
				loop
					on_item_added (a_folder_item.item, new_path)
					a_folder_item.forth
				end
			end
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER])
			-- `a_item' has been removed.
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_removed (a_item, a_path)
				observer_list.forth
			end
		end

	on_update
			-- The favorites have changed. Recompute the observers.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_update
				observer_list.forth
			end
		end

feature -- Status report

	sensitive: BOOLEAN
			-- Are observers sensitive?

	loading_error: BOOLEAN
			-- Did an error occur while loading the favorites?

feature -- Element change

	refresh
			-- Get rid of all dead classes.
		do
			refresh_folder (Current)
		end

	enable_sensitive
			-- Make all observers sensitive.
		do
			if not sensitive then
				sensitive := True
				from
					observer_list.start
				until
					observer_list.after
				loop
					observer_list.item.enable_sensitive
					observer_list.forth
				end
			end
		end

	disable_sensitive
			-- Make all observers sensitive.
		do
			if sensitive then
				sensitive := False
				from
					observer_list.start
				until
					observer_list.after
				loop
					observer_list.item.disable_sensitive
					observer_list.forth
				end
			end
		end

	feature_renamed (a_feat: E_FEATURE; a_new_name: STRING)
			-- Feature has been renamed in the system, from `a'
		require
			a_feat_not_void: a_feat /= Void
			a_new_name_not_void: a_new_name /= Void
		do
			renamed_feature := a_feat
			renamed_feature_name := a_new_name
			refresh
			renamed_feature := Void
			renamed_feature_name := Void
		end

feature {NONE} -- Implementation

	parent: EB_FAVORITES_ITEM_LIST
			-- Parent for Current
		do
			Result := Current
		end

	name: STRING = "Favorites"
			-- Name of the item.

	is_initialized: BOOLEAN
			-- Is the class initialized?

	refresh_folder (f: EB_FAVORITES_ITEM_LIST)
			-- Get rid of dead classes among children of `f'.
		local
			l_item: EB_FAVORITES_ITEM
			conv_l: EB_FAVORITES_ITEM_LIST
			conv_c: EB_FAVORITES_CLASS
			conv_f: EB_FAVORITES_FEATURE
			cli: CLASS_I
			clu: CONF_GROUP
		do
			from
				f.start
			until
				f.after
			loop
				l_item := f.item

				if l_item.is_class then
					conv_c ?= l_item
					cli := conv_c.associated_class_i
					if cli /= Void then
						clu := cli.group
						if cli.is_valid and clu.is_valid then
							refresh_folder (conv_c)
							f.forth
						else
							f.remove
						end
					else
						f.remove
					end
				elseif l_item.is_folder then
					conv_l ?= l_item
					refresh_folder (conv_l)
					f.forth
				elseif l_item.is_feature then
					conv_f ?= l_item
					check conv_f /= void end
					if attached conv_f.associated_e_feature as l_feat and then l_feat.is_valid then
						if attached renamed_feature as l_rf and then l_feat.same_as (l_rf) then
								-- A feature has been renamed.
							if attached l_rf.associated_class.feature_with_name (renamed_feature_name) as l_nfeat then
								conv_f.set_from_stone (create {FEATURE_STONE}.make (l_nfeat))
							end
						end
						f.forth
					else
						f.remove
					end
				end
			end
		end

	renamed_feature: detachable E_FEATURE
			-- Renamed features.
			-- To be wipe out when refreshed.

	renamed_feature_name: detachable STRING
			-- The name `renamed_feature' has been renamed.

feature {NONE} -- Attributes

	observer_list: ARRAYED_LIST [EB_FAVORITES_OBSERVER]

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_FAVORITES
