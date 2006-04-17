indexing
	description: "Tool to view the cluster hierarchy"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_TOOL

inherit
	EB_TOOL
		rename
			make as tool_make
		redefine
			menu_name,
			pixmap
		end

	EB_SHARED_MANAGERS

	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Make a new cluster tool.
		require
			a_manager_exists: a_manager /= Void
			a_window_exists: a_window /= Void
		do
			window := a_window
			tool_make (a_manager)
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			create widget.make
			widget.associate_with_window (window)
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			sep: EV_TOOL_BAR_SEPARATOR
			but: EV_TOOL_BAR_BUTTON
		do
			create show_current_class_cluster_cmd.make
			show_current_class_cluster_cmd.set_tooltip (Interface_names.e_Show_class_cluster)
			show_current_class_cluster_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_view)
			show_current_class_cluster_cmd.set_name ("Show_class_cluster")
			show_current_class_cluster_cmd.add_agent (agent show_current_class_cluster)
			show_current_class_cluster_cmd.set_menu_name (Interface_names.m_Show_class_cluster)

			create mini_toolbar
			mini_toolbar.extend (window.new_cluster_cmd.new_mini_toolbar_item)
			mini_toolbar.extend (window.new_class_cmd.new_mini_toolbar_item)
--| This button is not really necessary and it takes some place in the mini toolbar.
--			create sep
--			mini_toolbar.extend (sep)
--			mini_toolbar.extend (window.delete_class_cluster_cmd.new_mini_toolbar_item)
			create sep
			mini_toolbar.extend (sep)
			but := show_current_class_cluster_cmd.new_mini_toolbar_item
			but.drop_actions.extend (agent show_class)
			but.drop_actions.extend (agent show_group)
			mini_toolbar.extend (but)

			widget.refresh
			if not widget.is_empty and Workbench.is_already_compiled then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		ensure
			toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'.
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end

			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (
				explorer_bar, widget, title, True, mini_toolbar
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Bar containing a button for a new cluster and class.

	widget: EB_CLASSES_TREE
			-- tree representing clusters and classes in the system.

	window: EB_DEVELOPMENT_WINDOW
			-- development window `Current' is in.

	title: STRING is
			-- title of the tool.
		do
			Result := Interface_names.t_Cluster_tool
		end

	menu_name: STRING is
			-- name as it may appear in a menu.
		do
			Result := Interface_names.m_Cluster_tool
		end

	pixmap: EV_PIXMAP is
			-- pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.icon_cluster_symbol
		end

	show_current_class_cluster_cmd: EB_STANDARD_CMD
			-- Command that highlights currently edited object in the cluster tree.

feature -- Status setting

	set_stone (st: STONE) is
			-- A stone was dropped in `Current's parent.
			-- Maybe we should enable `show_current_class_cluster_cmd'.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	synchronize is
			-- The system was recompiled, update `Current'.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	on_project_loaded is
			-- A project has been created or loaded. Enable the locate command if necessary.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	on_project_unloaded is
			-- The current project has been unloaded. Disable the locate command if necessary.
		do
			show_current_class_cluster_cmd.disable_sensitive
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			widget.recycle
			widget := Void
			window := Void
		end

feature {NONE} -- Implementation

	show_class (st: CLASSI_STONE) is
			-- Display the class relative to `st' in the cluster tree.
		do
			widget.show_class (st.class_i)
		end

	show_group (st: CLUSTER_STONE) is
			-- Display the class relative to `st' in the cluster tree.
		do
			widget.show_subfolder (st.group, st.path)
		end

	show_current_class_cluster is
			-- Highlight currently edited object in the cluster tree.
		local
			conv_class: CLASSI_STONE
			conv_cluster: CLUSTER_STONE
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				conv_class ?= window.stone
				if conv_class /= Void then
					widget.show_class (conv_class.class_i)
				else
					conv_cluster ?= window.stone
					if conv_cluster /= Void then
						widget.show_subfolder (conv_cluster.group, conv_cluster.path)
					else
							-- The current stone is neither a class stone nor a cluster stone.
						create wd.make_with_text (Warning_messages.w_Choose_class_or_cluster)
						wd.show_modal_to_window (window.window)
					end
				end
			else
				if window.stone /= Void then
					create wd.make_with_text (Warning_messages.w_Could_not_locate (window.stone.stone_signature))
					wd.show_modal_to_window (window.window)
				end
			end
		rescue
			retried := True
			retry
		end

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

end -- class EB_CLUSTER_TOOL
