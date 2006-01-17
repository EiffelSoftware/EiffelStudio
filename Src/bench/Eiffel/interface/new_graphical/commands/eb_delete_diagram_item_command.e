indexing
	description: "Command to delete diagram components and to remove corresponding code in system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DELETE_DIAGRAM_ITEM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		rename
			make as make_context_diagram
		undefine
			menu_name
		redefine
			new_toolbar_item,
			description
		select
			name
		end

	EB_DELETE_CLASS_CLUSTER_COMMAND
		rename
			name as dup_name,
			make as dup_make
		export
			{ANY} class_i, could_not_delete
		undefine
			enable_sensitive,
			disable_sensitive,
			new_toolbar_item,
			new_mini_toolbar_item,
			mini_pixmap,
			description,
			tooltip,
			tooltext,
			pixmap
		redefine
			drop_class,
			delete_class,
			delete_cluster,
			execute
		end

create
	make

feature -- Initialization

	make (a_target: like tool; a_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize with `a_target' and `a_window'.
		do
			make_context_diagram (a_target)
			window := a_window
		end

feature -- Access

	execute is
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_delete_item)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor {EB_CONTEXT_DIAGRAM_COMMAND} (display_text, use_gray_icons)
			Result.drop_actions.extend (agent execute_with_inherit_stone)
			Result.drop_actions.extend (agent execute_with_client_stone)
			Result.drop_actions.extend (agent drop_class)
			Result.drop_actions.extend (agent drop_cluster)
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_delete_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_delete
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_delete
		end

	name: STRING is "Delete_item"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {NONE} -- Implementation

	drop_class (st: CLASSI_STONE) is
			-- Extract the class that should be removed from `st' and erase it.
		local
			fs: FEATURE_STONE
			es_class: ES_CLASS
			wd: EV_WARNING_DIALOG
			referenced_classes: STRING
			msg: STRING
			l_ss: LIST [CLASS_C]
			l_item: CLASS_C
		do
			fs ?= st
			if fs = Void then
				es_class := tool.graph.class_from_interface (st.class_i)
				if es_class /= Void then
					if es_class.class_c /= Void then
						create referenced_classes.make_empty
						from
							l_ss := es_class.class_c.syntactical_clients
							l_ss.start
						until
							l_ss.after
						loop
							l_item := l_ss.item
							referenced_classes.append ("%N" + l_item.name_in_upper)
							l_ss.forth
						end
						if referenced_classes.is_empty then
							Precursor {EB_DELETE_CLASS_CLUSTER_COMMAND} (st)
						else
							msg := warning_messages.w_still_referenced (es_class.name, referenced_classes)
							create wd.make_with_text (msg)
							wd.show_modal_to_window (window.window)
						end
					else
						-- there are now clients and now descendants, otherwise it would be compiled
						Precursor {EB_DELETE_CLASS_CLUSTER_COMMAND} (st)
					end
				else
					check
						delete_only_diagram_items: False
					end
				end
			end
		end

	delete_class is
			-- Remove `class_i' from the system.
		local
			file: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
			es_class: ES_CLASS
			l_links: LIST [EG_LINK]
		do
			if not retried then
				if eb_debugger_manager.application_is_executing then
					eb_debugger_manager.application.kill
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
				window_manager.synchronize_all
			end
			if could_not_delete then
					-- We were not able to delete the file.
				create wd.make_with_text (Warning_messages.w_Not_writable (class_i.file_name))
				wd.show_modal_to_window (window.window)
			else
				es_class := tool.graph.class_from_interface (class_i)
				if es_class /= Void then
					from
						l_links := es_class.links
						l_links.start
					until
						l_links.after
					loop
						tool.graph.remove_link (l_links.item)
						l_links.forth
					end
					tool.graph.remove_node (es_class)
				end
				tool.reset_history
			end
		rescue
			retried := True
			retry
		end

	delete_cluster is
			-- Remove `cluster_i' from the system.
		do
			tool.reset_history
			Precursor {EB_DELETE_CLASS_CLUSTER_COMMAND}
		end

	execute_with_inherit_stone (a_stone: INHERIT_STONE) is
			-- Remove `a_stone' from diagram.
		local
			ctm: CLASS_TEXT_MODIFIER
			descendant, ancestor: ES_CLASS
			e_item: ES_INHERITANCE_LINK
			link: EIFFEL_INHERITANCE_FIGURE
		do
			link := a_stone.source
			descendant := link.model.descendant
			ancestor := link.model.ancestor
			if ancestor /= Void and then descendant /= Void then
				ctm := descendant.code_generator

				e_item ?= a_stone.source.model
				check
					e_item_not_void: e_item /= Void
				end
				e_item.disable_needed_on_diagram

				tool.history.do_named_undoable (
					interface_names.t_diagram_delete_inheritance_link_cmd (ancestor.name, descendant.name),
					agent remove_ancestor (ctm, ancestor.name, e_item),
					agent add_ancestor (ctm, ancestor.name, e_item))
			end
		end

	remove_ancestor (a_ctm: CLASS_TEXT_MODIFIER; a_name: STRING; a_link: ES_INHERITANCE_LINK) is
			-- Remove ancestor with `a_name' and hide `a_link' if succesfull.
		do
			a_ctm.remove_ancestor (a_name)
			if not a_ctm.class_modified_outside_diagram then
				a_link.disable_needed_on_diagram
			end
		end

	add_ancestor (a_ctm: CLASS_TEXT_MODIFIER; a_name: STRING; a_link: ES_INHERITANCE_LINK) is
			--Add ancestor with `a_name' and show `a_link' if succesfull.
		do
			a_ctm.add_ancestor (a_name)
			if not a_ctm.class_modified_outside_diagram then
				a_link.enable_needed_on_diagram
			end
		end

	execute_with_client_stone (a_stone: CLIENT_STONE) is
			-- Delete feature in `a_stone'.
		local
			features: LIST [FEATURE_AS]
			selected_features: ARRAYED_LIST [FEATURE_AS]
			cancelled: BOOLEAN
			dial: EB_DELETE_CLIENT_LINK_DIALOG
			names: LIST [STRING]
			l_item: FEATURE_AS
		do
			features := a_stone.source.model.features
			if features.count = 1 then
				delete_features (features.twin, a_stone.source)
			else
				-- Let user select a subset
				dial := delete_client_link_dialog
				dial.set_strings (a_stone.source.feature_names)
				dial.show_modal_to_window (window.window)
				if
					not dial.cancelled and then
					not dial.selected_item.is_empty
				then
					names := dial.selected_items
					from
						names.start
						create selected_features.make (features.count)
					until
						names.after
					loop
						l_item := item_from_name (features, names.item)
						if l_item /= Void then
							selected_features.extend (l_item)
						end
						names.forth
					end
				else
					cancelled := True
				end
				dial.destroy
				if not cancelled then
					delete_features (selected_features, a_stone.source)
				end
			end
		end

	item_from_name (a_list: LIST [FEATURE_AS]; a_name: STRING): FEATURE_AS is
			-- Feature with `a_name' in `a_list' or Void if none.
		require
			a_list_not_void: a_list /= Void
			a_name_not_void: a_name /= Void
		do
			from
				a_list.start
			until
				Result /= Void or else a_list.after
			loop
				if a_name.is_equal (a_list.item.feature_name) then
					Result := a_list.item
				end
				a_list.forth
			end
		end

	delete_features (a_features: LIST [FEATURE_AS]; a_link: EIFFEL_CLIENT_SUPPLIER_FIGURE) is
			-- Delete features in `a_features'.
		require
			a_features_not_void: a_features /= Void
			a_link_not_void: a_link /= Void
		local
			ctm: CLASS_TEXT_MODIFIER
			undo_list: LIST [TUPLE [STRING, INTEGER]]
			l_model: ES_CLIENT_SUPPLIER_LINK
			l_client: ES_CLASS
			fne: FEATURE_NAME_EXTRACTOR
		do
			if not a_features.is_empty then
				ctm := a_link.model.client.code_generator
				ctm.remove_features (a_features)
				if not ctm.class_modified_outside_diagram then
					undo_list := ctm.last_removed_code.twin
					create fne
					l_model := a_link.model
					if a_link.model.features.count = a_features.count then
						l_model.disable_needed_on_diagram

						history.register_named_undoable (
							interface_names.t_diagram_delete_client_link_cmd (fne.feature_name (a_features.first)),
							agent remove_features_and_link (ctm, a_features, l_model),
							agent reinclude_code_and_link (ctm, undo_list, l_model))
					else
						l_client := l_model.client
						l_client.remove_queries (a_features)
						l_model.synchronize

						history.register_named_undoable (
							interface_names.t_diagram_delete_client_link_cmd (fne.feature_name (a_features.first)),
							agent remove_features (ctm, a_features, l_model, l_client),
							agent reinclude_features (ctm, a_features, undo_list, l_model, l_client))
					end
				end
			end
		end

	remove_features (a_ctm: CLASS_TEXT_MODIFIER; a_features: LIST [FEATURE_AS]; a_link: ES_CLIENT_SUPPLIER_LINK; a_client: ES_CLASS) is
			-- Remove `a_features' from `a_ctm' and remove `a_features' from `a_client'.
		do
			a_ctm.remove_features (a_features)
			if not a_ctm.class_modified_outside_diagram then
				a_client.remove_queries (a_features)
				a_link.synchronize
			end
		end

	reinclude_features (a_ctm: CLASS_TEXT_MODIFIER; a_features: LIST [FEATURE_AS]; code: LIST [TUPLE [STRING, INTEGER]]; a_link: ES_CLIENT_SUPPLIER_LINK; a_client: ES_CLASS) is
			-- Reinclude `code' to `a_ctm' and add `a_features' to `a_link'.
		do
			a_ctm.undelete_code (code)
			if not a_ctm.class_modified_outside_diagram then
				a_client.add_queries (a_features)
				a_link.synchronize
			end
		end

	remove_features_and_link (a_ctm: CLASS_TEXT_MODIFIER; a_features: LIST [FEATURE_AS]; a_link: ES_CLIENT_SUPPLIER_LINK) is
			-- Remove `a_features' from `a_ctm' and disable `a_link' in diagram.
		do
			a_ctm.remove_features (a_features)
			if not a_ctm.class_modified_outside_diagram then
				a_link.disable_needed_on_diagram
			end
		end

	reinclude_code_and_link (a_ctm: CLASS_TEXT_MODIFIER; code: LIST [TUPLE [STRING, INTEGER]]; a_link: ES_CLIENT_SUPPLIER_LINK) is
			-- Reinclude `code' to `a_ctm' and enable `a_link' on diagram.
		do
			a_ctm.undelete_code (code)
			if not a_ctm.class_modified_outside_diagram then
				a_link.enable_needed_on_diagram
			end
		end

	delete_client_link_dialog: EB_DELETE_CLIENT_LINK_DIALOG is
			-- Associated widget.
		do
			create Result
		end

	explain_dialog: EB_INFORMATION_DIALOG;
			-- Dialog explaining how to use `Current'.

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

end -- class EB_DELETE_DIAGRAM_ITEM_COMMAND
