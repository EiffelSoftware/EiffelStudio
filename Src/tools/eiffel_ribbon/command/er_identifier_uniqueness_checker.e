note
	description: "Summary description for {ER_IDENTIFIER_UNIQUENESS_CHECKER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_IDENTIFIER_UNIQUENESS_CHECKER

feature -- Command

	on_identifier_name_change (a_text: EV_TEXT_FIELD; a_tree_data: detachable ER_TREE_NODE_DATA)
			--
		require
			not_void: a_text /= Void
		local
			l_list: ARRAYED_LIST [EV_TREE_NODE]
			l_warning: EV_WARNING_DIALOG
		do
			if attached a_tree_data as l_data then
				if attached a_text.text as l_text
					and then not l_text.is_empty then

					l_list := all_items_with_identifier (l_text)
					if l_list.count = 0 then
						-- no conflict
						l_data.set_command_name (a_text.text)
					else
						-- name conflict
						if attached parent_window_of_widget (a_text) as l_win then
							create l_warning.make_with_text ("Identifier name is not unique.")
							l_warning.show_modal_to_window (l_win)
						end

						a_text.change_actions.block
						-- Restore to previous name
						if attached l_data.command_name as l_command_name then
							a_text.set_text (l_command_name)
						else
							a_text.remove_text
						end
						a_text.change_actions.resume
					end
				else
					l_data.set_command_name (void)
				end

			end
		end

feature -- Query

	all_items_with_identifier (a_identifier: STRING): ARRAYED_LIST [EV_TREE_NODE]
			--
		require
			not_void: a_identifier /= Void
			not_empty: not a_identifier.is_empty
		local
			l_shared: ER_SHARED_SINGLETON
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
		do
			from
				create Result.make (10)
				create l_shared
				l_list := l_shared.layout_constructor_list
				l_list.start
			until
				l_list.after
			loop

				Result.merge_right (all_item_with_identifier_in_layout_constructor (l_list.item, a_identifier))
				l_list.forth
			end

		end

feature {NONE} -- Implementation

	parent_window_of_widget (a_widget: EV_WIDGET): detachable EV_WINDOW
			--
		require
			not_void: a_widget /= Void
		do
			if attached a_widget.parent as l_parent then
				if attached {EV_WINDOW} l_parent as l_window then
					Result := l_window
				else
					Result := parent_window_of_widget (l_parent)
				end
			end
		end

	all_item_with_identifier_in_layout_constructor (a_layout_constructor: ER_LAYOUT_CONSTRUCTOR; a_identifier_name: STRING): ARRAYED_LIST [EV_TREE_NODE]
			-- FIXME: need visitor pattern? ER_LAYOUT_CONSTRUCTOR.all_items_with
		require
			not_void: a_layout_constructor /= Void
			not_void: a_identifier_name /= Void and then not a_identifier_name.is_empty
		local
			l_tree: EV_TREE
		do
			from
				create Result.make (10)
				l_tree := a_layout_constructor.widget
				l_tree.start
			until
				l_tree.after
			loop
				all_item_with_identifier_recrusive (l_tree.item, a_identifier_name, Result)
				l_tree.forth
			end
		end

	all_item_with_identifier_recrusive (a_item: EV_TREE_NODE; a_identifier_name: STRING; a_list: ARRAYED_LIST [EV_TREE_NODE])
			--
		require
			not_void: a_item /= Void
			not_void: a_identifier_name /= Void and then not a_identifier_name.is_empty
			not_void: a_list /= Void
		do
			if attached {ER_TREE_NODE_DATA} a_item.data as l_data then
				if attached l_data.command_name as l_identifier_name then
					if l_identifier_name.same_string (a_identifier_name) then
						a_list.extend (a_item)
					end
				end
			end
			from
				a_item.start
			until
				a_item.after
			loop
				all_item_with_identifier_recrusive (a_item.item, a_identifier_name, a_list)
				a_item.forth
			end
		end

end
