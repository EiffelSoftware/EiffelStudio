indexing
	description: "Tree item associated to a favorite item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FAVORITES_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			data
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONTEXT_MENU_HANDLER
		undefine
			default_create, is_equal, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (an_item: EB_FAVORITES_ITEM) is
			-- Create a tree item from `an_item', a favorite item.
		require
			an_item_non_void: an_item /= Void
		local
			conv_feat: EB_FAVORITES_FEATURE
			conv_class: EB_FAVORITES_CLASS
			conv_folder: EB_FAVORITES_FOLDER
		do
			default_create
			data := an_item
			drop_actions.set_veto_pebble_function (agent droppable)
			drop_actions.extend (agent remove_feature)
			drop_actions.extend (agent remove_class)
			drop_actions.extend (agent remove_folder)

			if an_item.is_class then
					-- ...or a class.
				conv_class ?= an_item
				if conv_class.associated_stone /= Void then
					set_pebble_function (agent pebble_adapter (conv_class.associated_stone))
				end
				if conv_class.associated_class_i /= Void then
					set_pixmap (pixmap_from_class_i (conv_class.associated_class_i))
				else
					set_pixmap (pixmaps.icon_pixmaps.class_uncompiled_icon)
				end
				drop_actions.extend (agent drop_folder_after)
				drop_actions.extend (agent drop_feature_stone_after)
				drop_actions.extend (agent drop_class_stone_after)
			elseif an_item.is_folder then
				conv_folder ?= an_item
					-- `an_item' is either a folder...
				set_pebble_function (agent pebble_adapter (conv_folder))
				drop_actions.extend (agent conv_folder.add_feature_stone)
				drop_actions.extend (agent conv_folder.add_class_stone)
				drop_actions.extend (agent conv_folder.add_favorite_folder)
				set_pixmap (pixmaps.icon_pixmaps.folder_blank_icon)
			elseif an_item.is_feature then
					-- ...or a feature.
				conv_feat ?= an_item
				set_pebble_function (agent pebble_adapter (conv_feat.associated_stone))
				if conv_feat.associated_e_feature /= Void then
					set_pixmap (pixmap_from_e_feature (conv_feat.associated_e_feature))
				end
				drop_actions.extend (agent drop_feature_stone_after)
				drop_actions.extend (agent drop_folder_after)
			end
			set_accept_cursor (an_item.mouse_cursor)
			set_deny_cursor (an_item.Xmouse_cursor)
			set_configurable_target_menu_mode
			set_configurable_target_menu_handler (agent context_menu_handler)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu handler
		do
			if context_menu_factory /= Void then
				context_menu_factory.favorites_menu (a_menu, a_target_list, a_source, a_pebble, Current)
			end
		end

feature -- Status setting

	remove_feature (a_favorite_stone: EB_FAVORITES_FEATURE_STONE) is
			-- Remove a feature from the tree, but not `Current'
		local
			old_feat: EB_FAVORITES_FEATURE
		do
			old_feat := a_favorite_stone.origin
			old_feat.parent.start
			old_feat.parent.prune (old_feat)
		end

	remove_class (a_favorite_stone: EB_FAVORITES_CLASS_STONE) is
			-- Remove a class from the tree, but not `Current'
		local
			old_class: EB_FAVORITES_CLASS
		do
			old_class := a_favorite_stone.origin
			old_class.parent.start
			old_class.parent.prune (old_class)
		end

	remove_folder (a_folder: EB_FAVORITES_FOLDER) is
			-- Remove `a_folder' from the tree
		do
			a_folder.parent.start
			a_folder.parent.prune (a_folder)
		end

	drop_folder_after (a_folder: EB_FAVORITES_FOLDER) is
			-- Put `an_item' to the right of `data' in `data's parent
		local
			l_fav: EB_FAVORITES_ITEM
		do
			if data.is_feature then
				l_fav ?= data.parent
			else
				l_fav := data
			end
			if l_fav /= Void then
				l_fav.parent.add_item_after (a_folder, l_fav)
			end
		end

	drop_class_stone_after (a_stone: CLASSI_STONE) is
			-- Put `a_stone' to the right of `data' in `data's parent.
		do
			data.parent.add_stone_after (a_stone, data)
		end

	drop_feature_stone_after (a_stone: FEATURE_STONE) is
			-- Put `a_stone' to the right of `data' in `data's parent.
		do
			data.parent.add_stone_after (a_stone, data)
		end

	refresh is
			-- After a recompilation, get the right icon,
			-- delete `Current' if the class was removed,...
		local
			cl: EB_FAVORITES_CLASS
			ff: EB_FAVORITES_FEATURE
			child: EB_FAVORITES_TREE_ITEM
		do
			from
				start
			until
				after
			loop
				child ?= item
				if child /= Void then
					child.refresh
				end
				forth
			end
			data.refresh
			cl ?= data
			if cl /= Void then
				set_pebble_function (agent pebble_adapter (cl.associated_stone))
				if cl.associated_class_i /= Void then
					set_pixmap (pixmap_from_class_i (cl.associated_class_i))
				else
					set_pixmap (pixmaps.icon_pixmaps.class_uncompiled_icon)
				end
			else
				ff ?= data
				if ff /= Void then
					set_pebble_function (agent pebble_adapter (ff.associated_stone))
					if ff.associated_e_feature /= Void then
						set_pixmap (pixmap_from_e_feature (ff.associated_e_feature))
					end
				end
			end
		end

	expand_recursively is
			-- Expand all children of `Current'.
		local
			child: EB_FAVORITES_TREE_ITEM
		do
			if is_expandable then
				expand
			end
			from
				start
			until
				after
			loop
				child ?= item
				if child /= Void then
					child.expand_recursively
				end
				forth
			end
		end

feature -- Access

	data: EB_FAVORITES_ITEM
			-- item represented by Current.

feature {NONE} -- Implementation

	droppable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		local
			a_folder: EB_FAVORITES_FOLDER
			a_fav_class_stone: EB_FAVORITES_CLASS_STONE
		do
			a_folder ?= a_pebble
			if a_folder /= Void then
					-- Do not drop a folder on one of its children.
				Result := not a_folder.has_recursive_child (data)
			else
				a_fav_class_stone ?= a_pebble
				if a_fav_class_stone /= Void then
						-- Do not drop on feature or picked class.
					Result := not data.is_feature and then data /= a_fav_class_stone.origin
				else
						-- Some class stone was selected.
					Result := True
				end
			end
		end

	pebble_adapter (a_pebble: like pebble): like pebble
			-- Pebble adapter to enable control right click
		require
			a_pebble_not_void: a_pebble /= Void
		do
			if not ev_application.ctrl_pressed then
				Result := a_pebble
			end
		end

invariant

	data_not_void: data /= Void

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

end -- class EB_FAVORITES_TREE_ITEM
