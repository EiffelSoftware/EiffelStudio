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
			new_toolbar_item,
			new_mini_toolbar_item,
			tooltext
		end

	EB_CLUSTER_MANAGER_OBSERVER

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_DEBUG_TOOLS

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

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			Result := Precursor (display_text, use_gray_icons)
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

feature -- Properties

	description: STRING is
			-- Comment about `Current' for customization.
		do
			Result := Interface_names.e_Remove_class_cluster
		end

	menu_name: STRING is
			-- Name of the menu corresponding to `Current'.
		do
			Result := Interface_names.m_Remove_class_cluster
		end

	name: STRING is "Remove_class_cluster"
			-- Internal identifier of `Current'.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing `Current' in toolbars.
		once
			Result := Pixmaps.Icon_delete_small
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing `Current' in toolbars.
		do
			Result := pixmaps.small_pixmaps.icon_delete
		end

	tooltip: STRING is
			-- Text string that appears when focus is given to `Current's buttons.
		once
			Result := description
		end

	tooltext: STRING is
			-- Text that appears on toolbar button
		once
			Result := Interface_names.B_remove_class_cluster
		end

feature -- Events

	drop_class (st: CLASSI_STONE) is
			-- Extract the class that should be removed from `st' and erase it.
		do
			class_i := st.class_i
			real_execute
		end

	drop_cluster (st: CLUSTER_STONE) is
			-- Extract the cluster that should be removed from `st' and erase it.
		do
			cluster_i := st.cluster_i
			real_execute
		end

feature -- Basic operations

	execute is
			-- Button has been pressed.
		local
			classst: CLASSI_STONE
			clust: CLUSTER_STONE
			wd: EV_WARNING_DIALOG
		do
			classst ?= window.stone
			if classst /= Void then
				class_i := classst.class_i
				real_execute
				if not could_not_delete then
					window.set_stone (Void)
				end
			else
				clust ?= window.stone
				if clust /= Void then
					cluster_i := clust.cluster_i
					real_execute
					if not could_not_delete then
						window.set_stone (Void)
					end
				else
					create wd.make_with_text (Warning_messages.w_Select_class_cluster_to_remove)
					wd.show_modal_to_window (window.window)
				end
			end
		end

feature {NONE} -- Implementation

	real_execute is
			-- Ask confirmation before removing `class_i' or `cluster_i'
			-- from the system and from the disk.
		local
			cd: EV_CONFIRMATION_DIALOG
			wd: EV_WARNING_DIALOG
			str: STRING
		do
			could_not_delete := True
			if class_i /= Void then
				if
					not class_i.is_read_only and then
					not class_i.cluster.is_precompiled
				then
					str := class_i.name_in_upper
					if eb_debugger_manager.application_is_executing then
						create cd.make_with_text_and_actions (Warning_messages.W_stop_debugger,	<<agent delete_class>>)
						cd.show_modal_to_window (window.window)
					else
						create cd.make_with_text_and_actions (Warning_messages.w_Confirm_delete_class (str),
												<<agent delete_class>>)
						cd.show_modal_to_window (window.window)
					end
					class_i := Void
				else
					create wd.make_with_text (Warning_messages.w_cannot_delete_read_only_class (class_i.name_in_upper))
					wd.show_modal_to_window (window.window)
					class_i := Void
				end
			elseif cluster_i /= Void then
				if
					not cluster_i.is_library and
					not cluster_i.is_precompiled
				then
					if cluster_i.classes.is_empty and then cluster_i.sub_clusters.is_empty then
						str := cluster_i.cluster_name.twin
						if eb_debugger_manager.application_is_executing then
							create cd.make_with_text_and_actions (Warning_messages.W_stop_debugger,	<<agent delete_cluster>>)
							cd.show_modal_to_window (window.window)
						else
							create cd.make_with_text_and_actions (Warning_messages.w_Confirm_delete_cluster (str),
														<<agent delete_cluster>>)
							cd.show_modal_to_window (window.window)
						end
					else
						create wd.make_with_text (Warning_messages.w_cannot_delete_none_empty_cluster (cluster_i.cluster_name))
						wd.show_modal_to_window (window.window)
					end
					cluster_i := Void
				else
					create wd.make_with_text (Warning_messages.w_Cannot_delete_library_cluster (cluster_i.cluster_name))
					wd.show_modal_to_window (window.window)
					cluster_i := Void
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
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				if eb_debugger_manager.application_is_executing then
					eb_debugger_manager.Application.kill
				end
				Eb_debugger_manager.disable_debug
				create file.make (class_i.file_name)
				if
					file.exists and then
					file.is_writable
				then
					file.delete
					manager.remove_class (class_i)
					could_not_delete := False
				end
				Eb_debugger_manager.resynchronize_breakpoints
				Window_manager.synchronize_all
			end
			if could_not_delete then
					-- We were not able to delete the file.
				create wd.make_with_text (Warning_messages.w_Not_writable (class_i.file_name))
				wd.show_modal_to_window (window.window)
			end
		rescue
			retried := True
			retry
		end

	delete_cluster is
			-- Remove `cluster_i' from the system.
		do
			if eb_debugger_manager.application_is_executing then
				eb_debugger_manager.application.kill
			end
			Eb_debugger_manager.disable_debug
			manager.remove_cluster_i (cluster_i)
			Eb_debugger_manager.resynchronize_breakpoints
			Window_manager.synchronize_all
			could_not_delete := False
		end

	class_i: CLASS_I
			-- Class that should be removed.

	cluster_i: CLUSTER_I
			-- Cluster that should be removed.

	window: EB_DEVELOPMENT_WINDOW
			-- Default window `Current' communicates with.

	could_not_delete: BOOLEAN;
			-- Was the class/cluster impossible to delete?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
