indexing
	description: "Dialog to choose a cluster in current system"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CHOOSE_CLUSTER_DIALOG

inherit
	EB_CHOOSE_CLASS_DIALOG
		rename
			selected_class_name as selected_cluster_name,
			class_name_entry as cluster_name_entry
		redefine
			prepare,
			on_ok,
			title,
			icon
		end

create
	make

feature -- Query

	selected_cluster_and_path: STRING is
			-- Selected cluster name and path
			-- This value set by `On_ok'
		do
			Result := ui_builder.selected_cluster_and_path
		end

	cluster_id: STRING is
			-- Cluster ID
			-- Maybe void if end user not pressed any cluster tree node.
		do
			Result := ui_builder.cluster_id
		end

	 cluster_sub_path: STRING is
			-- Cluster sub path.
			-- Maybe void if end user not pressed any cluster tree node.
		do
			Result := ui_builder.cluster_sub_path
		end

feature {NONE} -- Redefine

	icon: EV_PIXEL_BUFFER is
			-- <Precursor>
		do
			Result := stock_pixmaps.folder_cluster_icon_buffer
		end

	prepare (a_context_menu_factory: EB_CONTEXT_MENU_FACTORY; a_container: EV_VERTICAL_BOX) is
			-- <Precursor>
		local
			controls_box: EV_VERTICAL_BOX
			l_layouts: EV_LAYOUT_CONSTANTS
		do
			ui_builder.prepare (a_context_menu_factory, a_container)
			cluster_name_entry := ui_builder.cluster_name_entry
			classes_tree := ui_builder.classes_tree

			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_ok)
			set_button_action ({ES_DIALOG_BUTTONS}.cancel_button, agent on_cancel)
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := Interface_names.t_choose_cluster
		end

	on_ok is
			-- <Precursor>
		do
			if not ui_builder.on_ok then
				veto_close
			end
		end

feature {NONE} -- Implementation

	ui_builder: !ES_CHOOSE_CLUSTER_UI_BUILDER is
			-- UI builder
		once
			create Result
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
