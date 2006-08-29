indexing
	description: "Dialog to select scopes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SELECT_SCOPE_DIALOG

inherit
	EB_METRIC_INTERFACE_PROVIDER

create
	make

feature{NONE} -- Implementation

	make (a_add_scope_action: like add_scope_action) is
			-- Initialize `add_scope_action' with `a_add_scope_action'.
		require
			a_add_scope_action_attached: a_add_scope_action /= Void
		do
			set_add_scope_action (a_add_scope_action)
			create class_dialog.make
			class_dialog.set_title (metric_names.t_select_domain_scope)
			class_dialog.set_cluster_add_action (agent on_add_cluster)
			class_dialog.set_class_add_action (agent on_add_class)
			class_dialog.set_folder_add_action (agent on_add_folder)
		ensure
			add_scope_action_set: add_scope_action = a_add_scope_action
		end

feature -- Dialog display

	show (a_window: EV_WINDOW) is
			-- Show dialog.
			-- If `a_window' is attached, show dialog relative to `a_window'.
		do
			if not class_dialog.is_destroyed and then not class_dialog.is_displayed then
				if a_window /= Void then
					class_dialog.show_relative_to_window (a_window)
				else
					class_dialog.show
				end
			end
		end

	hide is
			-- Hide dialog.
		do
			if not class_dialog.is_destroyed and then class_dialog.is_displayed then
				class_dialog.hide
			end
		end

feature -- Status report

	is_displayed: BOOLEAN is
			-- Is dialog displayed?
		do
			Result := class_dialog.is_displayed
		ensure
			good_result: Result = class_dialog.is_displayed
		end

	is_destroyed: BOOLEAN is
			-- Is dialog destroyed?
		do
			Result := class_dialog.is_destroyed
		ensure
			good_result: Result = class_dialog.is_destroyed
		end

feature -- Setting

	set_add_scope_action (a_action: like add_scope_action) is
			-- Set `add_scope_action' with `a_action'.
		require
			a_action_attached: a_action /= Void
		do
			add_scope_action := a_action
		ensure
			add_scope_action_set: add_scope_action = a_action
		end

feature -- Actions

	add_scope_action: PROCEDURE [ANY, TUPLE[ANY]]
			-- Action to be peformed when a scope is added from dialog.

feature{NONE} -- Implementation

	class_dialog: EB_CHOOSE_MULTI_CLUSTER_N_CLASS_DIALOG
			-- Class tree dialog

	on_add_class (a_class_i: CLASS_I) is
			-- Action to be performed when a class is added.
		require
			a_class_i_attached: a_class_i /= Void
		do
			add_scope_action.call ([create{CLASSI_STONE}.make (a_class_i)])
		end

	on_add_cluster (a_group: CONF_GROUP) is
			-- Action to be performed when a group is added.
		require
			a_group_attached: a_group /= Void
		do
			add_scope_action.call ([create{CLUSTER_STONE}.make (a_group)])
		end

	on_add_folder (a_folder: EB_FOLDER) is
			-- Action to be performed when a folder is added.
		require
			a_folder_attached: a_folder /= Void
		do
			add_scope_action.call ([create{CLUSTER_STONE}.make_subfolder (a_folder.cluster, a_folder.path, a_folder.name)])
		end

invariant
	add_scope_action_attached: add_scope_action /= Void
	class_dialog_attached: class_dialog /= Void

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


end
