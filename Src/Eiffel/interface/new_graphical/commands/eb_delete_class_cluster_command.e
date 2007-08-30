indexing
	description: "Command that allows the user to remove a class or a cluster %
			%from the system (deletion is permanent and a confirmation dialog %
			%is popped up)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DELETE_CLASS_CLUSTER_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			mini_pixel_buffer,
			new_toolbar_item,
			new_mini_toolbar_item,
			new_sd_toolbar_item,
			new_mini_sd_toolbar_item,
			tooltext
		end

	EB_CLUSTER_MANAGER_OBSERVER

	EB_SHARED_WINDOW_MANAGER

	SHARED_DEBUGGER_MANAGER

	EB_RECYCLABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: like window) is
			-- Initialize `Current' and associate it with `a_window'.
		do
			default_create
			enable_sensitive
			window := a_window
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent drop_class)
			Result.drop_actions.extend (agent drop_cluster)
		end

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor
			Result.drop_actions.extend (agent drop_class)
			Result.drop_actions.extend (agent drop_cluster)
		end

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor
			Result.drop_actions.extend (agent drop_class)
			Result.drop_actions.extend (agent drop_cluster)
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create tool bar button for docking.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent drop_class)
			Result.drop_actions.extend (agent drop_cluster)
		end

feature -- Properties

	description: STRING_GENERAL is
			-- Comment about `Current' for customization.
		do
			Result := Interface_names.e_Remove_class_cluster
		end

	menu_name: STRING_GENERAL is
			-- Name of the menu corresponding to `Current'.
		do
			Result := Interface_names.m_Remove_class_cluster
		end

	name: STRING is "Remove_class_cluster"
			-- Internal identifier of `Current'.

	pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' in toolbars.
		once
			Result := pixmaps.icon_pixmaps.general_delete_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_delete_icon_buffer
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing `Current' in toolbars.
		do
			Result := pixmaps.mini_pixmaps.general_delete_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing `Current' in toolbars.
		do
			Result := pixmaps.mini_pixmaps.general_delete_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Text string that appears when focus is given to `Current's buttons.
		once
			Result := description
		end

	tooltext: STRING_GENERAL is
			-- Text that appears on toolbar button
		once
			Result := Interface_names.B_remove_class_cluster
		end

feature -- Events

	drop_class (st: CLASSI_STONE) is
			-- Extract the class that should be removed from `st' and erase it.
		local
			l_editor: EB_SMART_EDITOR
		do
			l_editor := window.editors_manager.editor_with_stone (st)
			class_i := st.class_i
			real_execute
			if not could_not_delete and l_editor /= Void then
				window.editors_manager.close_editor (l_editor)
			end
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Extract the cluster that should be removed from `st' and erase it.
		local
			l_editor: EB_SMART_EDITOR
		do
			l_editor := window.editors_manager.editor_with_stone (st)
			group := st.group
			path := st.path
			real_execute
			if not could_not_delete and l_editor /= Void then
				window.editors_manager.close_editor (l_editor)
			end
		end

feature -- Basic operations

	execute is
			-- Button has been pressed.
		local
			classst: CLASSI_STONE
			clust: CLUSTER_STONE
		do
			classst ?= window.stone
			if classst /= Void then
				drop_class (classst)
			else
				clust ?= window.stone
				if clust /= Void then
					drop_cluster (clust)
					real_execute
				else
					prompts.show_error_prompt (Warning_messages.w_Select_class_cluster_to_remove, window.window, Void)
				end
			end
		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		do
			window := Void
		end

feature {NONE} -- Implementation

	real_execute is
			-- Ask confirmation before removing `class_i' or `group'
			-- from the system and from the disk.
		local
			str: STRING
			l_cluster: CONF_CLUSTER
			l_sort_cl: EB_SORTED_CLUSTER
			l_empty: BOOLEAN
			l_sub_cl: DS_ARRAYED_LIST [CLASS_I]
		do
			could_not_delete := True
			if class_i /= Void then
				if
					not class_i.is_read_only
				then
					str := class_i.name
					if Debugger_manager.application_is_executing then
						prompts.show_warning_prompt_with_cancel (Warning_messages.W_stop_debugger, window.window, agent delete_class, Void)
					else
						prompts.show_question_prompt (Warning_messages.w_Confirm_delete_class (str), window.window, agent delete_class, Void)
					end
					class_i := Void
				else
					prompts.show_error_prompt (Warning_messages.w_cannot_delete_read_only_class (class_i.name), window.window, Void)
					class_i := Void
				end
			elseif group /= Void then
				str := group.name.twin
				str.append (path)
				if
					not group.is_readonly
				then
					if group.is_cluster and not path.is_empty then
							-- create an EB_SORTED_CLUSTER because this allows as to easily access information about subfolders
						create l_sort_cl.make (group)
						l_sort_cl.initialize
						l_sub_cl := l_sort_cl.sub_classes.item (path+"/")
						l_empty := l_sub_cl = Void or else l_sub_cl.is_empty
					else
						if group.is_cluster then
							l_cluster ?= group
							check cluster: l_cluster /= Void end
							l_empty := l_cluster.children = Void or else l_cluster.children.is_empty
						end
						l_empty := l_empty and group.classes = Void or else group.classes.is_empty
					end

					if
						l_empty
					then
						if group.target.system.date_has_changed then
							prompts.show_warning_prompt (Warning_messages.w_cannot_delete_need_recompile, window.window, Void)
						else
							if Debugger_manager.application_is_executing then
								prompts.show_question_prompt (Warning_messages.W_Confirm_delete_cluster_debug (str), window.window, agent delete_cluster, Void)
							else
								prompts.show_question_prompt (Warning_messages.w_Confirm_delete_cluster (str), window.window, agent delete_cluster, Void)
							end
						end
					else
						prompts.show_error_prompt (Warning_messages.w_cannot_delete_none_empty_cluster (str), window.window, Void)
					end
					group := Void
				else
					prompts.show_error_prompt (Warning_messages.w_Cannot_delete_library_cluster (str), window.window, Void)
					group := Void
				end
			end
		end

	delete_class is
			-- Remove `class_i' from the system.
		require
			classi_non_void: class_i /= Void
			could_not_delete_initialized: could_not_delete
		local
			file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				if debugger_manager.application_is_executing then
					debugger_manager.application.kill
				end
				debugger_manager.disable_debug
				create file.make (class_i.file_name)
				if
					file.exists and then
					file.is_writable
				then
					file.delete
					manager.remove_class (class_i)
					could_not_delete := False
				end
				Debugger_manager.resynchronize_breakpoints
				Window_manager.synchronize_all
			end
			if could_not_delete then
					-- We were not able to delete the file.
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (Warning_messages.w_Not_writable (class_i.file_name), window.window, Void)
			end
		rescue
			retried := True
			retry
		end

	delete_cluster is
			-- Remove `group' from the system.
		do
			if Debugger_manager.application_is_executing then
				Debugger_manager.application.kill
			end
			Debugger_manager.disable_debug
			manager.remove_group (group, path)
			Debugger_manager.resynchronize_breakpoints
			Window_manager.synchronize_all
			could_not_delete := False
		end

	class_i: CLASS_I
			-- Class that should be removed.

	group: CONF_GROUP
			-- Cluster that should be removed.

	path: STRING
			-- Subfolder path taht should be removed.

	window: EB_DEVELOPMENT_WINDOW
			-- Default window `Current' communicates with.

	could_not_delete: BOOLEAN;
			-- Was the class/cluster impossible to delete?

invariant
	cluster_i_implies_path: group /= Void implies path /= Void

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

end -- class EB_DELETE_CLASS_CLUSTER_COMMAND
