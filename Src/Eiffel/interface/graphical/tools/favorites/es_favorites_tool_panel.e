indexing
	description	: "Tool to view the favorites"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ES_FAVORITES_TOOL_PANEL

inherit
	EB_TOOL
		rename
			make as tool_make
		redefine
			attach_to_docking_manager,
			build_docking_content,
			build_mini_toolbar,
			internal_recycle,
			show
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW; a_tool: like tool_descriptor; a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Make a new favorites tool.
		require
			a_manager_exists: a_manager /= Void
			a_favorites_manager_exists: a_favorites_manager /= Void
			a_tool_attached: a_tool /= Void
			not_a_tool_is_recycled: not a_tool.is_recycled
		do
			favorites_manager := a_favorites_manager
			tool_make (a_manager, a_tool)
		ensure
			tool_descriptor_set: tool_descriptor = a_tool
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			-- The widget has already been created, so do nothing.
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content.
		local
			l_tree: EB_FAVORITES_TREE
		do
			Precursor {EB_TOOL}(a_docking_manager)
			l_tree := favorites_manager.widget
			content.drop_actions.extend (agent l_tree.remove_class_stone)
			content.drop_actions.extend (agent l_tree.remove_feature_stone)
			content.drop_actions.extend (agent l_tree.remove_folder)
			content.drop_actions.extend (agent l_tree.add_stone)
			content.drop_actions.extend (agent l_tree.add_folder)
			content.drop_actions.extend (agent on_drop)
		end

	build_mini_toolbar is
			-- Build `mini_toolbar'
		local
			sd: SD_TOOL_BAR
			sdb: SD_TOOL_BAR_BUTTON
		do
			create sd.make
			mini_toolbar := sd

			create sdb.make
			sdb.set_tooltip (Interface_names.t_organize_favorites)
			sdb.select_actions.extend (agent favorites_manager.organize_favorites)
			sdb.set_pixmap (pixmaps.mini_pixmaps.general_edit_icon)
			sd.extend (sdb)
			sd.update_size
		end

feature -- Initialization

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		do
			Result := favorites_manager.widget
		end

feature -- Command

	show is
			-- Show tool.
		local
			w: EV_WIDGET
		do
			Precursor {EB_TOOL}
			w := favorites_manager.widget
			if w /= Void and then w.is_displayed and then w.is_sensitive then
				favorites_manager.widget.set_focus
			end
		end

feature -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if favorites_manager /= Void then
				favorites_manager.recycle
				favorites_manager := Void
			end
			Precursor {EB_TOOL}
		end

feature {NONE} -- Implementation

	on_drop (a_stone: STONE) is
			-- Set focus to content.
		do
			content.set_focus
		end

	favorites_manager: EB_FAVORITES_MANAGER;
			-- Associated favorites manager.

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

end -- class EB_FAVORITES_TOOL
