indexing
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

feature -- Command

	recover_normal_size_from_minimize is
			-- Recover to normal zone size from minimized state.
		local
			l_parent: SD_MIDDLE_CONTAINER
			l_parent_parent: EV_CONTAINER
			l_other: EV_WIDGET
			l_new_parent: EV_SPLIT_AREA
			l_box: EV_BOX
			l_first: BOOLEAN
		do
			internal_docking_manager.command.lock_update (Current, True)
			if is_minimized then
				l_parent ?= parent
				if l_parent /= Void then
					check is_minimized: l_parent.is_minimized end

					l_box ?= l_parent
					-- If l_box is void here (is a split area), that means, SD_MUTLI_DOCK_AREA.update_middle_container have not been call when it should been called before.					
					if l_box /= Void then
						if not l_box.is_item_expanded (l_parent.first) and not l_box.is_item_expanded (l_parent.second) then
							-- We only need to expand ourself
							l_box.enable_item_expand (Current)
						else
							-- Only Current is minimized, we need to change parent
							l_parent_parent := l_parent.parent
							save_parent_split_position (l_parent_parent)
							if l_parent.first /= Current then
								l_other := l_parent.first
								l_first := False
							else
								l_other := l_parent.second
								l_first := True
							end
							internal_docking_manager.query.inner_container (Current).save_spliter_position (l_other)

							l_parent_parent.prune (l_parent)
							l_parent.wipe_out
							l_new_parent := normal_container (l_parent)
							l_parent_parent.extend (l_new_parent)
							if l_first then
								l_new_parent.extend (Current)
								l_new_parent.extend (l_other)
							else
								l_new_parent.extend (l_other)
								l_new_parent.extend (Current)
							end
							internal_docking_manager.command.resize (True)

							restore_parent_split_position (l_parent_parent)
							if l_parent.split_position >= l_new_parent.minimum_split_position and l_parent.split_position <= l_new_parent.maximum_split_position then
								l_new_parent.set_split_position (l_parent.split_position)
							end

							if l_other /= Void then
								internal_docking_manager.query.inner_container (Current).restore_spliter_position (l_other)
							end
						end
					end
				end

				is_minimized := False
				show_notebook_contents (True)
				internal_notebook.set_show_minimized (is_minimized)
				internal_docking_manager.query.inner_container (Current).update_middle_container
			end
			internal_docking_manager.command.unlock_update
		ensure
			recovered: not is_minimized
		end

	expand_parent_spliter (a_spliter: EV_SPLIT_AREA; a_size_to_expand: INTEGER)  is
			-- Try to expand `a_size_to_expand'
			-- Stop when no parent available or has already expanded `a_size_to_expand'
		require
			not_void: a_spliter /= Void
		local
			l_upper_spliter: EV_SPLIT_AREA
			l_container: EV_CONTAINER
			l_expanded: INTEGER

		do
			if a_size_to_expand > 0 then
				l_upper_spliter := spliter_upper (a_spliter)
				if l_upper_spliter /= Void then
					create expand_stack.make (5)
					l_container ?= l_upper_spliter.first
					if l_upper_spliter.first = Current or (l_container /= Void and then l_container.has_recursive (Current)) then
						-- Current from first, we expand
						if l_upper_spliter.split_position + a_size_to_expand <= l_upper_spliter.maximum_split_position then
							l_upper_spliter.set_split_position (l_upper_spliter.split_position + a_size_to_expand)
						else
							l_expanded := l_upper_spliter.maximum_split_position - l_upper_spliter.split_position
							l_upper_spliter.set_split_position (l_upper_spliter.maximum_split_position)
							-- Go on recursion
							expand_parent_spliter (l_upper_spliter, a_size_to_expand - l_expanded)
							expand_stack.extend ([a_spliter, True])
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
							expand_stack.extend ([a_spliter, False])
						end
					end
				end
			end
		end

	expand_finish is
			-- Do things after finish expand.
		local
			l_target: EV_SPLIT_AREA
		do
			from
			until
				expand_stack.is_empty
			loop
				l_target := expand_stack.item.spliter
				if expand_stack.item.is_set_maximum then
					l_target.set_split_position (l_target.maximum_split_position)
				else
					l_target.set_split_position (l_target.minimum_split_position)
				end
				expand_stack.remove
			end
		end

	restore_from_maximized is
			-- Restore to normal size if current maximized
		deferred
		end

	on_minimize is
			-- Handle minimize actions.
		local
			l_parent: SD_MIDDLE_CONTAINER
			l_parent_parent: EV_CONTAINER
			l_other: EV_WIDGET
			l_box: SD_MIDDLE_CONTAINER
			l_last_normal_size: INTEGER
		do
			restore_from_maximized

			if is_minimized then
				recover_normal_size_from_minimize
			else
				internal_docking_manager.command.lock_update (Current, True)
				l_parent ?= parent
				if l_parent /= Void then
					if not l_parent.is_minimized then
						l_parent_parent := l_parent.parent
						save_parent_split_position (l_parent_parent)
						l_last_normal_size := l_parent.split_position
						l_parent_parent.prune (l_parent)

						if l_parent.first = Current then

							l_other := l_parent.second
							internal_docking_manager.query.inner_container (Current).save_spliter_position (l_other)
							l_parent.wipe_out
							l_box := minimized_container (l_parent)

							l_parent_parent.extend (l_box)
							l_box.extend (Current)
							l_box.disable_item_expand (Current)
							l_box.extend (l_other)
						else
							l_other := l_parent.first
							internal_docking_manager.query.inner_container (Current).save_spliter_position (l_other)
							l_parent.wipe_out
							l_box := minimized_container (l_parent)
							l_parent_parent.extend (l_box)
							l_box.extend (l_other)
							l_box.extend (Current)
							l_box.disable_item_expand (Current)
						end
						l_box.set_split_position (l_last_normal_size)
						restore_parent_split_position (l_parent_parent)

					else
						l_box ?= l_parent
						check not_void: l_box /= Void end
						l_box.disable_item_expand (Current)
					end

					is_minimized := True
					show_notebook_contents (False)
					internal_notebook.set_show_minimized (is_minimized)

					internal_docking_manager.query.inner_container (Current).update_middle_container

				else
					-- Current is in top level
				end
				internal_docking_manager.command.resize (True)
				if l_other /= Void then
					internal_docking_manager.query.inner_container (Current).restore_spliter_position (l_other)
				end
				internal_docking_manager.command.unlock_update
			end
		end

	minimize_for_restore is
			-- Minimize operations for restore docking layout.
		do
			is_minimized := True
			show_notebook_contents (False)
			internal_notebook.set_show_minimized (is_minimized)
		end

feature -- Query

	spliter_size (a_spliter: EV_SPLIT_AREA; a_zone_size: INTEGER): INTEGER is
			-- Spliter size.
		require
			not_void: a_spliter /= Void
		local
			l_container: EV_CONTAINER
		do
			l_container ?= a_spliter.first
			if a_spliter.first = Current or (l_container /= Void and then l_container.has_recursive (Current)) then
				Result := a_zone_size
			else
				Result := a_spliter.maximum_split_position - a_zone_size
			end
		end

	spliter_upper (a_parent: EV_CONTAINER): EV_SPLIT_AREA is
			-- Upper level spliter of `a_spliter'
			-- Void if not exists.
		require
			not_void: a_parent /= Void
		local
			l_parent: EV_CONTAINER
		do
			l_parent := a_parent.parent
			Result ?= l_parent
			if Result = Void and l_parent /= Void then
				Result := spliter_upper (l_parent)
			end
		end

	is_minimized: BOOLEAN
			-- If Current is minimized?

	is_ignore_restore_area: BOOLEAN is
			-- If pointer in tab close button or normal/maximize button area?
		do
			Result := internal_notebook.is_in_close_area
			if not Result then
				Result := internal_notebook.in_normal_maximize_area
			end
		end

feature {NONE} -- Implementation

	show_notebook_contents (a_is_show: BOOLEAN) is
			-- Show all notebook contents if `a_is_show'
			-- Otherwise hide all notebook contents.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_notebook.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				if a_is_show then
					l_contents.item.user_widget.show
				else
					l_contents.item.user_widget.hide
				end
				l_contents.forth
			end
		end

	expand_stack: ARRAYED_STACK [TUPLE [spliter: EV_SPLIT_AREA; is_set_maximum: BOOLEAN]]
			-- Stack remembered when expand.

	internal_notebook: SD_NOTEBOOK_UPPER is
			-- Upper zone's notebook
		deferred
		end

	internal_docking_manager: SD_DOCKING_MANAGER is
			-- Docking manager
		deferred
		end

	normal_container (a_container: SD_MIDDLE_CONTAINER): EV_SPLIT_AREA is
			-- Normal container for `a_container' which is fake split area.
		require
			not_void: a_container /= Void
		local
			l_h_box: EV_HORIZONTAL_BOX
			l_v_box: EV_VERTICAL_BOX
		do
			l_h_box ?= a_container
			l_v_box ?= a_container
			if l_h_box /= Void then
				create {SD_HORIZONTAL_SPLIT_AREA} Result
			elseif l_v_box /= Void then
				create {SD_VERTICAL_SPLIT_AREA} Result
			else
				check not_possible: False end
			end
		ensure
			not_void: Result /= Void
		end

	minimized_container (a_old_one: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER is
			-- Create middle container correspond to `a_old_one'.
		require
			not_void: a_old_one /= Void
		local
			l_horizontal_spliter: EV_HORIZONTAL_SPLIT_AREA
			l_vertical_spliter: EV_VERTICAL_SPLIT_AREA
		do
			l_horizontal_spliter ?= a_old_one
			l_vertical_spliter ?= a_old_one
			if l_horizontal_spliter /= Void then
				create {SD_HORIZONTAL_BOX} Result
			elseif l_vertical_spliter /= Void then
				create {SD_VERTICAL_BOX} Result
			else
				check not_possible: False end
			end
		ensure
			not_void: Result /= Void
			minimized: Result.is_minimized
		end

	save_parent_split_position (a_container: EV_CONTAINER) is
			-- Save `a_container' split position.
		local
			l_split: EV_SPLIT_AREA
		do
			l_split ?= a_container
			if l_split /= Void then
				last_split_position := l_split.split_position
			end
		end

	last_split_position: INTEGER
			-- Split position setted by `save_parent_split_position'.

	restore_parent_split_position (a_container: EV_CONTAINER) is
			-- Restpre `a_container' split position.
		local
			l_split: EV_SPLIT_AREA
		do
			l_split ?= a_container
			if l_split /= Void and then l_split.minimum_split_position <= last_split_position and last_split_position <= l_split.maximum_split_position then
				l_split.set_split_position (last_split_position)
			end
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end
