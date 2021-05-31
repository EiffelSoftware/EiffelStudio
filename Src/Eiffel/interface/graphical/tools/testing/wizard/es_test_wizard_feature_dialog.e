note
	description: "Dialog showing a selectable class and feature tree."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_FEATURE_DIALOG

inherit
	ES_DIALOG
		redefine
			internal_recycle,
			on_after_initialized
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	EB_CONSTANTS
		rename
			interface_names as eb_interface_names,
			interface_messages as eb_interface_messages
		export
			{NONE} all
		end

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

create
	make_with_window

feature {NONE} -- Initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_hbox: EV_HORIZONTAL_BOX
		do
			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)

			create class_tree.make_with_options (development_window.menus.context_menu_factory, False, True)
			class_tree.set_minimum_size (250, 300)
			class_tree.select_actions.extend (agent on_select_class)
			l_hbox.extend (class_tree)

			create feature_tree
			feature_tree.set_minimum_size (250, 300)
			feature_tree.select_actions.extend (agent on_select_feature)
			l_hbox.extend (feature_tree)

			a_container.extend (l_hbox)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

			class_tree.refresh
		end

feature -- Access

	title: STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation ("Choose a class and routine")
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.feature_routine_icon_buffer
		end

	selected_class: detachable CLASS_I
			-- Class last selected by user

	selected_feature: detachable E_FEATURE
			-- Feature last selected by user

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			create {DS_HASH_SET [INTEGER]} Result.make (2)
			Result.force ({ES_DIALOG_BUTTONS}.ok_button)
			Result.force ({ES_DIALOG_BUTTONS}.cancel_button)
		end

	default_button: INTEGER
			-- <Precursor>
		do
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := {ES_DIALOG_BUTTONS}.cancel_button
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

feature {NONE} -- Access

	class_tree: detachable EB_CLASSES_TREE
			-- Tree showing all classes in the system
			--
			-- Note: must be detachable for recycling

	feature_tree: EV_TREE
			-- Tree displaying features of the selected class in `class_tree'

feature {NONE} -- Events

	on_select_feature
			-- Called when item is selected in `feature_tree'.
		do
			selected_feature := Void
			if
				attached feature_tree.selected_item as i and then
				attached {like selected_feature} i.data as l_feat
			then
				selected_feature := l_feat
			end
		end

	on_select_class
			-- Called when item is selected in `class_tree'
		local
			l_classi: CLASS_I
			l_tree_item: EV_TREE_ITEM
			l_ok_button: EV_BUTTON
		do
			feature_tree.wipe_out
			selected_class := Void
			selected_feature := Void
			if attached {EB_CLASSES_TREE_CLASS_ITEM} class_tree.selected_item as l_item then
				l_classi := l_item.data
				selected_class := l_classi
				if l_classi.is_compiled then
					build_tree (l_classi.compiled_class)
				else
					create l_tree_item.make_with_text ("Class not compiled...")
					feature_tree.extend (l_tree_item)
				end
			end
			l_ok_button := dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button)
			if selected_class /= Void then
				if not l_ok_button.is_sensitive then
					l_ok_button.enable_sensitive
				end
			else
				if l_ok_button.is_sensitive then
					l_ok_button.disable_sensitive
				end
			end
		end

feature {NONE} -- Implementation: feature tree

	internal_recycle
			-- <Precursor>
		do
			class_tree.recycle
			feature_tree.destroy
			Precursor
		end

	build_tree (a_class_c: CLASS_C)
			-- Build tree base on `a_class_c'
			-- Modified from {ES_FEATURES_TOOL_PANEL}.on_stone_changed
		require
			not_void: a_class_c /= Void and then a_class_c.already_compiled
		local
			l_container: EV_CONTAINER
			l_tree: like feature_tree
			l_class_ast: CLASS_AS
			l_clauses: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do

			l_tree := feature_tree
			-- Removes the tree from the parent to perform off-screen drawing.
			l_container := l_tree.parent
			l_container.prune (l_tree)

			l_tree.wipe_out
			if not a_class_c.is_external and then a_class_c.has_ast then

				if a_class_c.is_precompiled then
					l_class_ast := a_class_c.ast
				elseif a_class_c.eiffel_class_c.file_is_readable then
					l_class_ast := a_class_c.eiffel_class_c.parsed_ast (False)
						-- Clear error handler, as per-note in parsed_ast
					error_handler.wipe_out
				end

				if l_class_ast /= Void then
					if l_tree.selected_item /= Void then
						l_tree.selected_item.disable_select
					end

					l_clauses := l_class_ast.features
					if l_clauses /= Void then
							-- Build tree from AST nodes
						build_tree_imp (l_clauses, a_class_c)
					else
							-- No items
						l_tree.extend (create {EV_TREE_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
					end
				end
			elseif attached {EXTERNAL_CLASS_C} a_class_c as l_external_classc then
				-- Special processing for a .NET type since has no 'ast' in the normal
				-- sense.

				if l_tree.selected_item /= Void then
					l_tree.selected_item.disable_select
				end
				l_tree.wipe_out
				build_tree_for_external (l_external_classc)
			end

				-- Add tree back to the container
			l_container.extend (l_tree)

			if not l_tree.is_empty and then l_tree.is_displayed then
				l_tree.ensure_item_visible (l_tree.first)
			end
		end

	build_tree_for_external (a_class: EXTERNAL_CLASS_C)
			-- Build tree for .Net classes
		do
			-- FIXIT: Don't support .Net classes for the moment
			feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
		end

	build_tree_imp (a_fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]; a_class: CLASS_C)
			-- Build feature tree
			-- Modified base on {EB_FEATURES_TREE}.build_tree
		require
			not_void: feature_tree /= Void
			not_void: a_fcl /= Void
			not_void: a_class /= Void
		local
			l_tree_item: EV_TREE_ITEM
			l_match_list: LEAF_AS_LIST
			l_features: EIFFEL_LIST [FEATURE_AS]
			l_export_status: EXPORT_I
			l_name: STRING_32
			l_retried: BOOLEAN
			l_comments: EIFFEL_COMMENTS
		do
			if not l_retried then
				l_match_list := match_list_server.item (a_class.class_id)
				across
					a_fcl as c
				loop
					if c.item = Void then
						feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_short_internal_error ("Void feature clause")))
					else
						l_features := c.item.features
						l_comments := c.item.comment (l_match_list)
						if l_comments = Void or else l_comments.is_empty then
							l_name := ""
						else
							l_name := l_comments.first.content_32
						end
						l_name.right_adjust
					end

					l_tree_item := build_tree_folder (l_name, l_features, a_class)

					l_export_status := export_status_generator.feature_clause_export_status (system, a_class, c.item)
					if l_export_status.is_none then
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_none_icon)
					elseif l_export_status.is_set then
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_some_icon)
					else
						l_tree_item.set_pixmap (pixmaps.icon_pixmaps.folder_features_all_icon)
					end

					l_tree_item.set_data (c.item)
					-- l_tree_item.set_configurable_target_menu_mode
					-- l_tree_item.set_configurable_target_menu_handler (agent context_menu_factory.feature_clause_item_menu (?, ?, ?, ?, c.item))

					feature_tree.extend (l_tree_item)
					if l_tree_item.is_expandable then
						l_tree_item.expand
					end
				end

				-- Expand tree codes here

				if a_fcl.is_empty then
						-- Display a message not to confuse the user.
					feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (Warning_messages.w_no_feature_to_display))
				end
			else
				feature_tree.extend (create {EV_TREE_ITEM}.make_with_text (
					Warning_messages.w_short_internal_error ("Crash in build_tree")))
			end
		rescue
			l_retried := True
			retry
		end

	build_tree_folder (n: READABLE_STRING_32; fl: EIFFEL_LIST [FEATURE_AS]; a_class: CLASS_C): EV_TREE_ITEM
			-- Build the tree node corresponding to feature clause named `n'.
			-- Modified from {EB_FEATURES_TREE}, now the class replaced by {ES}
		require
			fl_not_void: fl /= Void
			a_class_not_void: a_class /= Void
		local
			l_tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
			fa: FEATURE_AS
			f_item_name: STRING_32
			l_first_item_name: STRING_32
			l_external: BOOLEAN
		do
			create Result
			l_external := a_class.is_external
			Result.set_text
				(if attached n and then not n.is_empty then n else Interface_names.l_no_feature_group_clause end)
			across
				fl as f
			loop
				fa := f.item
				if fa = Void then
					Result.extend (create {EV_TREE_ITEM}.make_with_text (
						warning_messages.w_short_internal_error ("Void feature")))
				else
					l_first_item_name := Void
					across
						fa.feature_names as fn
					loop
						f_item_name := fn.item.internal_name.name_32
						if l_first_item_name = Void then
							l_first_item_name := f_item_name
						end
						if a_class.has_feature_table then
							ef := a_class.feature_with_name_id (fn.item.internal_name.name_id)
							if ef /= Void and then ef.written_in /= a_class.class_id then
								ef := Void
							end
						end
						create l_tree_item
						if ef = Void then
							l_tree_item.set_text (f_item_name)
							l_tree_item.set_data (f_item_name)
							l_tree_item.set_pixmap (pixmap_factory.pixmap_from_feature_ast (l_external, fa, fn.target_index))
						else
							l_tree_item.set_data (ef)
							-- if is_clickable then
							-- l_tree_item.pointer_button_press_actions.extend (
							-- agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))
							-- l_tree_item.set_configurable_target_menu_mode
							-- l_tree_item.set_configurable_target_menu_handler (agent feature_item_handler (?, ?, ?, ?, True, Void))
							-- end
							l_tree_item.set_text (feature_name (ef))
							l_tree_item.set_pixmap (pixmap_factory.pixmap_from_feature_ast (l_external, fa, fn.target_index))
							create st.make (ef)
							l_tree_item.set_pebble (st)
							l_tree_item.set_accept_cursor (st.stone_cursor)
							l_tree_item.set_deny_cursor (st.X_stone_cursor)
						end
						Result.extend (l_tree_item)
					end
				end
			end
		end

	feature_name (a_ef: E_FEATURE): STRING_32
			-- Feature name of `a_ef' depending of the signature displayed or not.
		require
			a_ef_not_void: a_ef /= Void
		do
			Result := a_ef.name_32.twin
		end

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
