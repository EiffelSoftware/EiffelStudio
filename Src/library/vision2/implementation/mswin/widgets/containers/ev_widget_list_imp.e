note
	description: "Eiffel Vision widget list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			interface_item
		redefine
			interface,
			next_tabstop_widget
		end

	EV_DYNAMIC_LIST_IMP [detachable EV_WIDGET, detachable EV_WIDGET_IMP]
		redefine
			interface,
			insert_i_th,
			remove_i_th
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: detachable EV_WIDGET_IMP
			wel_win: detachable WEL_WINDOW
		do
				-- Should `v' be a pixmap,
				-- promote implementation to EV_WIDGET_IMP.
			v.implementation.on_parented

			v_imp ?= v.implementation

			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			wel_win ?= Current
			check
				wel_win_not_void: wel_win /= Void
			end
			v_imp.wel_set_parent (wel_win)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
			notify_change (Nc_minsize, Current)
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v: detachable EV_WIDGET
			v_imp: detachable EV_WIDGET_IMP
		do
			v := i_th (i)
			check v /= Void end
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			remove_item_actions.call ([v_imp.attached_interface])
			ev_children.go_i_th (i)
			ev_children.remove
			notify_change (Nc_minsize, Current)

				-- Unlink the widget from its parent and
				-- signal it.
			v_imp.set_parent_imp (Void)
			v_imp.on_orphaned
		end

feature {EV_ANY_I} -- WEL Implementation

	is_control_in_window (hwnd_control: POINTER): BOOLEAN
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local
			loc_cursor: CURSOR
			l_item: detachable EV_WIDGET_IMP
		do
			if hwnd_control = wel_item then
				Result := True
			else
				loc_cursor := ev_children.cursor
				from
					ev_children.start
				until
					Result or ev_children.after
				loop
					l_item := ev_children.item
					check l_item /= Void end
					Result := l_item.is_control_in_window (hwnd_control)
					ev_children.forth
				end
				ev_children.go_to (loc_cursor)
			end
		ensure then
			index_not_changed: old ev_children.index = ev_children.index
		end

	index_of_child (child: EV_WIDGET_IMP): INTEGER
			-- `Result' is 1 based index of `child' within `Current'.
		do
			Result := index_of (child.interface, 1)
		end

	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
			-- container must be searched next.
		require else
			valid_search_pos: search_pos >= 0 and search_pos <= count + 1
		local
			w: detachable EV_WIDGET
			w_imp: detachable EV_WIDGET_IMP
			container: detachable EV_CONTAINER
			l_cursor: CURSOR
			l_result: detachable EV_WIDGET_IMP
		do
			l_cursor := cursor
			l_result := return_current_if_next_tabstop_widget (start_widget, search_pos, forwards)
					-- We do not iterate through a container it is not sensitive as no children
					-- should receive the tab stop.
			if l_result = Void and is_sensitive then
					-- Otherwise iterate through children and search each but only if
					-- we are sensitive. In the case of a non-sensitive container, no
					-- children should recieve the tab stop.
				from
					go_i_th (search_pos)
				until
					off or l_result /= Void
				loop
					w := item
					check w /= Void end
					w_imp ?= w.implementation
					check w_imp /= Void end
					if forwards then
						l_result := w_imp.next_tabstop_widget (start_widget, 1, forwards)
					else
						container ?= w_imp.interface
						if container /= Void then
							l_result := w_imp.next_tabstop_widget (start_widget, container.count, forwards)
						else
							l_result := w_imp.next_tabstop_widget (start_widget, 1, forwards)
						end
					end
					if l_result = Void then
						if forwards then
							forth
						else
							back
						end
					end
				end
			end
			if l_result = Void then
				l_result := next_tabstop_widget_from_parent (start_widget, search_pos, forwards)
			end
			go_to (l_cursor)
			check l_result /= Void end
			Result := l_result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WIDGET_LIST_IMP










