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

feature -- Command

	recover_normal_size_from_minimize is
			-- Recover to normal zone size from minimized state.
		local
			l_parent: EV_SPLIT_AREA
			l_temp_split_position: INTEGER
		do
			if is_minimized then
				l_parent ?= parent
				if l_parent /= Void then
					if spliter_size (l_parent, last_normal_size) >= l_parent.minimum_split_position and spliter_size (l_parent, last_normal_size) <= l_parent.maximum_split_position  then

						l_parent.set_split_position (spliter_size (l_parent, last_normal_size))
					elseif spliter_size (l_parent, last_normal_size) < l_parent.minimum_split_position then
						-- Try to find parent split area to shrink it
						-- We must store it first, othewise it'll change.
						l_temp_split_position := spliter_size (l_parent, last_normal_size)
						check positive: l_parent.minimum_split_position - l_temp_split_position > 0 end
						expand_parent_spliter (l_parent, l_parent.minimum_split_position - l_temp_split_position)

						expand_finish
						if l_parent.second = Current then
							l_parent.set_split_position (l_parent.maximum_split_position - last_normal_size)
						else
							l_parent.set_split_position (last_normal_size)
						end

					else
						-- Try to find parent split area to expand it
						print ("%N SD_UPPER_ZONE Try to find parent split area to expand it last_spliter_position: " + last_normal_size.out)

						expand_parent_spliter (l_parent, spliter_size (l_parent, spliter_size (l_parent, last_normal_size)) - l_parent.maximum_split_position)

						expand_finish
						if l_parent.second = Current then
							l_parent.set_split_position (l_parent.maximum_split_position - last_normal_size)
						else
							l_parent.set_split_position (last_normal_size)
						end
					end
				end
				is_minimized := False
				show_notebook_contents (True)
				internal_notebook.set_show_minimized (is_minimized)
			end
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

	record_zone_size is
			-- Record current split area size
		local
			l_parent: EV_SPLIT_AREA
		do
			l_parent ?= parent
			if l_parent /= Void then
				if l_parent.first = Current then
					last_normal_size := l_parent.split_position
				else
					last_normal_size := l_parent.maximum_split_position - l_parent.split_position
				end

			end
		end

	on_minimize is
			-- Handle minimize actions.
		local
			l_parent: EV_SPLIT_AREA
		do
			if is_minimized then
				recover_normal_size_from_minimize
			else
				l_parent ?= parent
				if l_parent /= Void then
					if l_parent.first = Current then
						last_normal_size := l_parent.split_position
						l_parent.set_split_position (l_parent.minimum_split_position)
					else
						last_normal_size := l_parent.maximum_split_position - l_parent.split_position
						l_parent.set_split_position (l_parent.maximum_split_position)
					end
					is_minimized := True
					show_notebook_contents (False)
					internal_notebook.set_show_minimized (is_minimized)
				else
					-- Current is in top level
				end
			end
		end

	parent_spliter_position: ARRAYED_LIST [INTEGER]
			-- Parent spliter position.

feature -- Query

	is_minimized: BOOLEAN
			-- If Current is minimized?

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

	last_normal_size: INTEGER;
			-- Last spliter position if `is_minimized'.
			-- It's always calculated as if we are in the first spliter item position.

feature -- Minimize all implementation

	on_minimize_all is
			-- Handle minimize all eidtors actions
		do
			if not is_all_zone_minimized then
				is_all_zone_minimized := True
			else
				is_all_zone_minimized := False
			end

			minimize_all_imp (is_all_zone_minimized)
			set_all_zone_icons (not is_all_zone_minimized)
		end

	is_all_zone_minimized: BOOLEAN
			-- If all zone minimized?

	set_all_zone_icons (a_is_minimize: BOOLEAN) is
			-- Update all zones minimize icons.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_upper_zone: SD_DOCKING_ZONE_UPPER
		do
			l_zones := internal_docking_manager.query.inner_container_main.all_editors
			from
				l_zones.start
			until
				l_zones.after
			loop
				l_upper_zone ?= l_zones.item
				if l_upper_zone /= Void then
					l_upper_zone.set_minimize_all_pixmap (a_is_minimize)
				end
				l_zones.forth
			end
		end

	minimize_all_imp (a_is_minimize: BOOLEAN) is
			-- Minimize all implementation.
		local
			l_editors: ARRAYED_LIST [SD_ZONE]
			l_upper_zone: SD_UPPER_ZONE
		do
			l_editors := internal_docking_manager.query.inner_container_main.all_editors
			from
				l_editors.start
			until
				l_editors.after
			loop
				l_upper_zone ?= l_editors.item
				check not_void: l_upper_zone /= Void end
				l_upper_zone.on_minimize
				l_editors.forth
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
