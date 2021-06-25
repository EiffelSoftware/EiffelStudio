note
	description: "Zone which tab at top common features."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_UPPER_ZONE

inherit
	EV_CONTAINER
		rename
			extend as extend_widget,
			prune as prune_widget,
			has as has_widget,
			implementation as implementation_upper_zone
		undefine
			extend_widget,
			copy,
			is_equal,
			put,
			item,
			prune_all,
			replace,
			is_in_default_state,
			cl_extend,
			cl_put,
			fill
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_DOCKING_MANAGER_HOLDER
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	init
			-- Initialization
		require
			set: is_notebook_set
		do
			if attached internal_notebook as l_notebook then
				l_notebook.tab_bar_right_blank_area_double_click_actions.extend (agent on_tab_bar_right_blank_area_double_click)
			end
		end

feature -- Command

	recover_normal_size_from_minimize
			-- Recover to normal zone size from minimized state
		require
			set: is_notebook_set
		local
			l_parent_parent: detachable EV_CONTAINER
			l_other: detachable EV_WIDGET
			l_new_parent: EV_SPLIT_AREA
			l_first: BOOLEAN
		do
			docking_manager.command.lock_update (Current, True)
			if is_minimized then
				if attached {SD_MIDDLE_CONTAINER} parent as l_parent then
						-- If l_parent is not a EV_BOX here (is a split area), that means
						-- , SD_MUTLI_DOCK_AREA.update_middle_container have not been call when it should been called before.
					if attached {EV_BOX} l_parent as l_box then
						if
							(attached l_parent.first as l_parent_first and attached l_parent.second as l_parent_second) and then
							(not l_box.is_item_expanded (l_parent_first) and not l_box.is_item_expanded (l_parent_second))
						then
								-- We only need to expand ourself
							l_box.enable_item_expand (Current)
						else
								-- Only Current is minimized, we need to change parent
							l_parent_parent := l_parent.parent
							if l_parent_parent = Void then
								check l_parent_parent_attached: False end
							else
									-- Implied by `l_parent' is existing in main development
								save_parent_split_position (l_parent_parent)
								if l_parent.first /= Current then
									l_other := l_parent.first
									l_first := False
								else
									l_other := l_parent.second
									l_first := True
								end
								if attached {SD_ZONE} Current as lt_zone and l_other /= Void then
									docking_manager.query.inner_container (lt_zone).save_spliter_position (l_other, generating_type.name_32 + {STRING_32} ".recover_normal_size_from_minimize")
								else
									check not_possible: False end
								end

								l_parent_parent.prune (l_parent)
								l_parent.wipe_out
								l_new_parent := normal_container (l_parent)
								l_parent_parent.extend (l_new_parent)
								if l_other /= Void then
									if l_first then
										l_new_parent.extend (Current)
										l_new_parent.extend (l_other)
									else
										l_new_parent.extend (l_other)
										l_new_parent.extend (Current)
									end
								end

								docking_manager.command.resize (True)

								restore_parent_split_position (l_parent_parent)

								if l_parent.split_position >= l_new_parent.minimum_split_position and l_parent.split_position <= l_new_parent.maximum_split_position then
									l_new_parent.set_split_position (l_parent.split_position)
								end

								if l_other /= Void then
									if attached {SD_ZONE} Current as lt_zone_2 then
										docking_manager.query.inner_container (lt_zone_2).restore_spliter_position (l_other, generating_type.name_32 + {STRING_32} ".recover_normal_size_from_minimize")
									else
										check not_possible: False end
									end
								end
							end
						end
					end
				end

				is_minimized := False
				show_notebook_contents (True)
				if attached internal_notebook as l_notebook then
					l_notebook.set_show_minimized (is_minimized)
				else
					check from_precondition_set: False end
				end
				if attached {SD_ZONE} Current as lt_zone_3 then
					docking_manager.query.inner_container (lt_zone_3).update_middle_container
				else
					check not_possible: False end
				end
			end
			docking_manager.command.unlock_update
		ensure
			recovered: not is_minimized
		end

	expand_parent_spliter (a_spliter: EV_SPLIT_AREA; a_size_to_expand: INTEGER)
			-- Try to expand `a_size_to_expand'
			-- Stop when no parent available or has already expanded `a_size_to_expand'
		require
			not_void: a_spliter /= Void
		local
			l_upper_spliter: detachable EV_SPLIT_AREA
			l_expanded: INTEGER
			l_expand_stack: like expand_stack
		do
			if a_size_to_expand > 0 then
				l_upper_spliter := spliter_upper (a_spliter)
				if l_upper_spliter /= Void then
					create l_expand_stack.make (5)
					expand_stack := l_expand_stack
					if
						l_upper_spliter.first = Current
						or (attached {EV_CONTAINER} l_upper_spliter.first as l_container and then l_container.has_recursive (Current))
					then
							-- Current from first, we expand
						if l_upper_spliter.split_position + a_size_to_expand <= l_upper_spliter.maximum_split_position then
							l_upper_spliter.set_split_position (l_upper_spliter.split_position + a_size_to_expand)
						else
							l_expanded := l_upper_spliter.maximum_split_position - l_upper_spliter.split_position
							l_upper_spliter.set_split_position (l_upper_spliter.maximum_split_position)
								-- Go on recursion
							expand_parent_spliter (l_upper_spliter, a_size_to_expand - l_expanded)
							l_expand_stack.extend ([a_spliter, True])
						end
					else
							-- Current from second, we shrink, as a result actually we expand for Current
						if l_upper_spliter.split_position - a_size_to_expand >= l_upper_spliter.minimum_split_position then
							l_upper_spliter.set_split_position (l_upper_spliter.split_position - a_size_to_expand)
						else
							l_expanded := l_upper_spliter.split_position - l_upper_spliter.minimum_split_position
							l_upper_spliter.set_split_position (l_upper_spliter.minimum_split_position)
								-- Go on recursion
							expand_parent_spliter (l_upper_spliter, a_size_to_expand - l_expanded)
							l_expand_stack.extend ([a_spliter, False])
						end
					end
				end
			end
		end

	expand_finish
			-- Do things after finish expand
		require
			not_void: is_expand_stack_set
		local
			l_target: EV_SPLIT_AREA
		do
			if attached expand_stack as l_expand_stack then
				from
				until
					l_expand_stack.is_empty
				loop
					l_target := l_expand_stack.item.spliter
					if l_expand_stack.item.is_set_maximum then
						l_target.set_split_position (l_target.maximum_split_position)
					else
						l_target.set_split_position (l_target.minimum_split_position)
					end
					l_expand_stack.remove
				end
			else
				check from_precondition_not_void: False end
			end
		end

	restore_from_maximized
			-- Restore to normal size if current maximized
		deferred
		end

	on_minimize
			-- Handle minimize actions
		do
			restore_from_maximized

			if is_minimized then
				recover_normal_size_from_minimize
			else
				minimize
			end
		end

	minimize
			-- Minimize current
		require
			set: is_notebook_set
		local
			l_parent_parent: detachable EV_CONTAINER
			l_other: detachable EV_WIDGET
			l_box: detachable SD_MIDDLE_CONTAINER
			l_last_normal_size: INTEGER
			l_notebook: like internal_notebook
		do
			docking_manager.command.lock_update (Current, True)
			if attached {SD_MIDDLE_CONTAINER} parent as l_parent then
				if not l_parent.is_minimized then
					l_parent_parent := l_parent.parent
					if l_parent_parent = Void then
						check l_parent_parent_attached: False end
					else
							-- Implied by Current is displaying in main window
						save_parent_split_position (l_parent_parent)
						l_last_normal_size := l_parent.split_position
						l_parent_parent.prune (l_parent)
						if attached {SD_ZONE} Current as lt_zone then
							if l_parent.first = Current then
								l_other := l_parent.second
								if attached l_other then
									docking_manager.query.inner_container (lt_zone).save_spliter_position (l_other, generating_type.name_32 + {STRING_32} ".minimize")
								end
								l_parent.wipe_out
								l_box := minimized_container (l_parent)

								l_parent_parent.extend (l_box)
								l_box.extend (Current)
								if attached l_other then
									l_box.extend (l_other)
								end
								l_box.disable_item_expand (Current)
							else
								l_other := l_parent.first
								if attached l_other then
									docking_manager.query.inner_container (lt_zone).save_spliter_position (l_other, generating_type.name_32 + {STRING_32} ".minimize")
								end
								l_parent.wipe_out
								l_box := minimized_container (l_parent)
								l_parent_parent.extend (l_box)
								if attached l_other then
									l_box.extend (l_other)
								end
								l_box.extend (Current)
								l_box.disable_item_expand (Current)
							end
							l_box.set_split_position (l_last_normal_size)
						else
							check not_possible: False end
						end
						restore_parent_split_position (l_parent_parent)
					end
				else
					if attached {EV_BOX} l_parent as b then
						b.disable_item_expand (Current)
					else
						check l_parent_is_box: False end
					end
				end

				is_minimized := True
				show_notebook_contents (False)
				l_notebook := internal_notebook
				if l_notebook /= Void then
						-- Implied by precondition `set'
					l_notebook.set_show_minimized (is_minimized)
				else
					check internal_notebook_attached: False end
				end
				if attached {SD_ZONE} Current as lt_zone_2 then
					docking_manager.query.inner_container (lt_zone_2).update_middle_container
				else
					check not_possible: False end
				end
			else
					-- Current is in top level
			end
			docking_manager.command.resize (True)
			if l_other /= Void then
				if attached {SD_ZONE} Current as lt_zone_3 then
					docking_manager.query.inner_container (lt_zone_3).restore_spliter_position (l_other, generating_type.name_32 + {STRING_32} ".minimize")
				else
					check not_possible: False end
				end
			end
			docking_manager.command.unlock_update
		end

	minimize_for_restore
			-- Minimize operations for restore docking layout
		require
			set: is_notebook_set
		do
			is_minimized := True
			show_notebook_contents (False)
			if attached internal_notebook as l_notebook then
				l_notebook.set_show_minimized (is_minimized)
			else
				check from_precondition_set: False end
			end
		end

	enable_maximize_minimize_buttons
			-- Enable maximize and minimize buttons in notebook
		do
			if attached {SD_NOTEBOOK_UPPER} internal_notebook as l_notebook then
				l_notebook.enable_maximize_minimize_buttons
			end
		end

	disable_maximize_minimize_buttons
			-- Disable maximize and minimize buttons in notebook
		do
			if attached {SD_NOTEBOOK_UPPER} internal_notebook as l_notebook then
				l_notebook.disable_maximize_minimize_buttons
			end
		end

feature -- Query

	spliter_size (a_spliter: EV_SPLIT_AREA; a_zone_size: INTEGER): INTEGER
			-- Spliter size
		require
			not_void: a_spliter /= Void
		do
			if a_spliter.first = Current or (attached {EV_CONTAINER} a_spliter.first as l_container and then l_container.has_recursive (Current)) then
				Result := a_zone_size
			else
				Result := a_spliter.maximum_split_position - a_zone_size
			end
		end

	spliter_upper (a_parent: EV_CONTAINER): detachable EV_SPLIT_AREA
			-- Upper level spliter of `a_spliter'
			-- Void if not exists.
		require
			not_void: a_parent /= Void
		local
			l_parent: detachable EV_CONTAINER
		do
			l_parent := a_parent.parent
			if attached {like spliter_upper} l_parent as sp then
				Result := sp
			elseif l_parent /= Void then
				Result := spliter_upper (l_parent)
			end
		end

	is_minimized: BOOLEAN
			-- If Current is minimized?

	is_ignore_restore_area: BOOLEAN
			-- If pointer in tab close button or normal/maximize button area?
		do
			if attached internal_notebook as l_notebook then
				Result := l_notebook.is_in_close_area
				if not Result then
					Result := l_notebook.in_normal_maximize_area
				end
			end
		end

	is_expand_stack_set: BOOLEAN
			-- If `expand_stack' attached?
		do
			Result := attached expand_stack
		end

	is_notebook_set: BOOLEAN
			-- If `internal_notebook' attached?
		do
			Result := attached internal_notebook
		end

feature {NONE} -- Implementation

	show_notebook_contents (a_is_show: BOOLEAN)
			-- Show all notebook contents if `a_is_show'
			-- Otherwise hide all notebook contents
		require
			set: is_notebook_set
		do
			if attached internal_notebook as l_notebook then
				across
					l_notebook.contents as c
				loop
					if a_is_show then
						c.user_widget.show
					else
						c.user_widget.hide
					end
				end
			else
				check from_precondition_set: False end
			end
		end

	expand_stack: detachable ARRAYED_STACK [TUPLE [spliter: EV_SPLIT_AREA; is_set_maximum: BOOLEAN]]
			-- Stack remembered when expand

	internal_notebook: detachable SD_NOTEBOOK_UPPER
			-- Upper zone's notebook
		deferred
		end

	normal_container (a_container: SD_MIDDLE_CONTAINER): EV_SPLIT_AREA
			-- Normal container for `a_container' which is fake split area
		require
			not_void: a_container /= Void
		do
			if attached {EV_HORIZONTAL_BOX} a_container then
				create {SD_HORIZONTAL_SPLIT_AREA} Result
			else
				check is_vertical_box: attached {EV_VERTICAL_BOX} a_container end
				create {SD_VERTICAL_SPLIT_AREA} Result
			end
		ensure
			not_void: Result /= Void
		end

	minimized_container (a_old_one: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER
			-- Create middle container correspond to `a_old_one'
		require
			not_void: a_old_one /= Void
		do
			if attached {EV_HORIZONTAL_SPLIT_AREA} a_old_one then
				create {SD_HORIZONTAL_BOX} Result.make
			else
				check is_vertical_split_area: attached {EV_VERTICAL_SPLIT_AREA} a_old_one end
				create {SD_VERTICAL_BOX} Result.make
			end
		ensure
			not_void: Result /= Void
			minimized: Result.is_minimized
		end

	save_parent_split_position (a_container: EV_CONTAINER)
			-- Save `a_container' split position
		do
			if attached {EV_SPLIT_AREA} a_container as l_split then
				last_split_position := l_split.split_position
			end
		end

	last_split_position: INTEGER
			-- Split position setted by `save_parent_split_position'

	restore_parent_split_position (a_container: EV_CONTAINER)
			-- Restpre `a_container' split position
		do
			if attached {EV_SPLIT_AREA} a_container as l_split
				and then (l_split.minimum_split_position <= last_split_position and last_split_position <= l_split.maximum_split_position) then
				l_split.set_split_position (last_split_position)
			end
		end

	on_tab_bar_right_blank_area_double_click
			-- Handle `tab_bar_right_blank_area_double_click_actions' of `internal_notebook'
		do
			if attached internal_notebook as l_notebook then
				if attached l_notebook.contents.last as l_content then
					l_content.tab_bar_right_blank_area_double_click_actions.call (Void)
				end
			end
		end

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
