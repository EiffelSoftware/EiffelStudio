note
	description: "Tool to view the cluster hierarchy"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GROUPS_TOOL_PANEL

inherit
	EB_TOOL
		redefine
			make,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			internal_recycle,
			show
		end

	EB_SHARED_MANAGERS

	SHARED_WORKBENCH

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: EB_DEVELOPMENT_WINDOW; a_tool: like tool_descriptor)
			-- Make a new cluster tool.
		do
			window := a_manager
			Precursor (a_manager, a_tool)
		end

	build_interface
			-- Build all the tool's widgets.
		do
			create widget.make (window.menus.context_menu_factory)
			widget.associate_with_window (window)
		end

	build_mini_toolbar
			-- Build associated tool bar
		local
			sep: SD_TOOL_BAR_SEPARATOR
			but: SD_TOOL_BAR_BUTTON
		do
			create show_current_class_cluster_cmd.make
			show_current_class_cluster_cmd.set_tooltip (Interface_names.e_Show_class_cluster)
			show_current_class_cluster_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_search_icon)
			show_current_class_cluster_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_search_icon_buffer)
			show_current_class_cluster_cmd.set_name ("Show_class_cluster")
			show_current_class_cluster_cmd.add_agent (agent show_current_class_cluster)
			show_current_class_cluster_cmd.set_menu_name (Interface_names.m_Show_class_cluster)

			create mini_toolbar.make
			mini_toolbar.extend (window.commands.new_cluster_cmd.new_mini_sd_toolbar_item)
			mini_toolbar.extend (window.commands.new_library_cmd.new_mini_sd_toolbar_item)
			if eiffel_layout.default_il_environment.is_dotnet_installed then
				mini_toolbar.extend (window.commands.new_assembly_cmd.new_mini_sd_toolbar_item)
			end
			mini_toolbar.extend (window.commands.new_class_cmd.new_mini_sd_toolbar_item)
			mini_toolbar.extend (window.commands.delete_class_cluster_cmd.new_mini_sd_toolbar_item)
			create sep.make
			mini_toolbar.extend (sep)
			but := show_current_class_cluster_cmd.new_mini_sd_toolbar_item
			but.drop_actions.extend (agent show_class)
			but.drop_actions.extend (agent show_group)
			mini_toolbar.extend (but)

			mini_toolbar.compute_minimum_size

			widget.refresh
			if not widget.is_empty and Workbench.is_already_compiled then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		ensure then
			toolbar_exists: mini_toolbar /= Void
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER)
		do
			Precursor {EB_TOOL} (a_docking_manager)
			check content_not_void : content /= Void end
			content.drop_actions.extend (agent show_class)
			content.drop_actions.extend (agent show_group)
		end

feature -- Access

	mini_toolbar: SD_TOOL_BAR
			-- Bar containing a button for a new cluster and class.

	widget: EB_CLASSES_TREE
			-- tree representing clusters and classes in the system.

	window: EB_DEVELOPMENT_WINDOW
			-- development window `Current' is in.

	show_current_class_cluster_cmd: EB_STANDARD_CMD
			-- Command that highlights currently edited object in the cluster tree.

feature -- Command

	show
			-- Show tool.
		do
			Precursor {EB_TOOL}
			if widget.is_displayed then
				widget.set_focus
			end
		end

feature -- Status setting

	set_stone (st: STONE)
			-- A stone was dropped in `Current's parent.
			-- Maybe we should enable `show_current_class_cluster_cmd'.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	synchronize
			-- The system was recompiled, update `Current'.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	on_project_loaded
			-- A project has been created or loaded. Enable the locate command if necessary.
		do
			if Workbench.is_already_compiled and not widget.is_empty then
				show_current_class_cluster_cmd.enable_sensitive
			else
				show_current_class_cluster_cmd.disable_sensitive
			end
		end

	on_project_unloaded
			-- The current project has been unloaded. Disable the locate command if necessary.
		do
			show_current_class_cluster_cmd.disable_sensitive
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			show_current_class_cluster_cmd.recycle
			show_current_class_cluster_cmd := Void
			widget.recycle
			widget := Void
			window := Void
			Precursor {EB_TOOL}
		end

feature -- Implementation

	show_class (st: CLASSI_STONE)
			-- Display the class relative to `st' in the cluster tree.
		do
			widget.show_class (st.class_i)
			if content /= Void and then content.is_visible then
				content.set_focus
			end
		end

	show_group (st: CLUSTER_STONE)
			-- Display the class relative to `st' in the cluster tree.
		do
			widget.show_subfolder (st.group, st.path)
			if content /= Void and then content.is_visible then
				content.set_focus
			end
		end

feature {NONE} -- Implementation

	show_current_class_cluster
			-- Highlight currently edited object in the cluster tree.
		local
			conv_class: CLASSI_STONE
			conv_cluster: CLUSTER_STONE
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
						prompts.show_warning_prompt (Warning_messages.w_Choose_class_or_cluster, window.window, Void)
					end
				end
			else
				if window.stone /= Void then
					prompts.show_error_prompt (Warning_messages.w_Could_not_locate (window.stone.stone_signature), window.window, Void)
				end
			end
		rescue
			retried := True
			retry
		end

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

end -- class EB_CLUSTER_TOOL
