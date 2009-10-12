note
	description: "EV_MODEL_WORLD with ability to select and deselect figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_SELECTION_WORLD

inherit
	EV_MODEL_WORLD
		redefine
			default_create
		end

	EV_SHARED_APPLICATION
		undefine
			default_create
		end

create
	default_create

create {MULTI_SELECTION_WORLD}
	make_filled, list_make

feature {NONE} -- Initialization

	default_create
			-- Create an empty MULTI_SELECTION_WORLD
		do
			Precursor {EV_MODEL_WORLD}
			create selected_figures.make (10)
			is_selection_enabled := True
			pointer_button_press_actions.extend (agent on_pointer_pressed)
		end

feature -- Status report

	is_selection_enabled: BOOLEAN
			-- Is selection enabled?
			-- If False, selection is still posible but only with a ctrl-click.

feature -- Access

	selected_figures: ARRAYED_LIST [EV_MODEL]
			-- Figures currently selected.

feature -- Status Settings

	enable_selection
			-- Set `is_selection_enabled' to True.
		do
			is_selection_enabled := True
		ensure
			set: is_selection_enabled
		end

	disable_selection
			-- Set `is_selection_enabled' to False.
		do
			is_selection_enabled := False
		ensure
			set: not is_selection_enabled
		end


feature -- Element change

	select_figure (figure: EV_MODEL)
			-- Add `figure' to `selected_figures'
		require
			figure_exists: figure /= Void
			figure_not_selected: not selected_figures.has (figure)
		local
			select_group: SELECTION_GROUP
		do
			select_group := new_selection_group
			select_group.set_selected_item (figure)

			force (select_group)
			selected_figures.extend (figure)
		ensure
			added: old selected_figures.count + 1 = selected_figures.count
		end

	deselect_figure (figure: EV_MODEL)
			-- Remove `figure' from `selected_figures'.
		require
			figure_exists: figure /= Void
			figure_selected: selected_figures.has (figure)
		local
			sg: detachable SELECTION_GROUP
			l_item: detachable EV_MODEL
		do
			sg ?= figure.group
			check sg /= Void end
			prune_all (sg)

			l_item := sg.selected_item
			check l_item /= Void end
			extend (l_item)
			selected_figures.prune_all (figure)
		ensure
			removed: old selected_figures.count - 1 = selected_figures.count
		end


	select_all
			-- Select all figures.
		local
			figures_to_select: ARRAYED_LIST [EV_MODEL]
		do
			from
				create figures_to_select.make (count)
				start
			until
				after
			loop
				if attached {EV_MODEL} item as figure and then not selected_figures.has (figure) then
					figures_to_select.extend (figure)
				end
				forth
			end
			from
				figures_to_select.start
			until
				figures_to_select.after
			loop
				select_figure (figures_to_select.item)
				figures_to_select.forth
			end
		end

	deselect_all
			-- Deselect all figures.
		do
			from
				start
			until
				after
			loop
				if attached {SELECTION_GROUP} item as sg and then attached sg.selected_item as l_item then
					replace (l_item)
				end
				forth
			end
			selected_figures.wipe_out
		end

	delete_selected
			-- Delete all selected figures.
		do
			from
				start
			until
				after
			loop
				if attached {SELECTION_GROUP} item then
					remove
				else
					forth
				end
			end
			selected_figures.wipe_out
		end

	invert_selection
			-- Invert the selection.
		local
			figures_to_select: ARRAYED_LIST [EV_MODEL]
			figure: EV_MODEL
			sg: detachable SELECTION_GROUP
		do
			from
				start
				create figures_to_select.make (5)
			until
				after
			loop
				figure := item
				sg ?= figure
				if sg = Void and then not selected_figures.has (figure) then
					figures_to_select.extend (figure)
				end
				forth
			end
			deselect_all
			from
				figures_to_select.start
			until
				figures_to_select.after
			loop
				select_figure (figures_to_select.item)
				figures_to_select.forth
			end
		end

	group_selection
			-- Group selected figures.
		require
			more_then_one: selected_figures.count > 1
		local
			new_group: EV_MODEL_GROUP
			l_group: detachable EV_MODEL_GROUP
		do
			create new_group
			from
				selected_figures.start
			until
				selected_figures.after
			loop
				start
				l_group := selected_figures.item.group
				check l_group /= Void end
				search (l_group)
				remove
				new_group.extend (selected_figures.item)
				selected_figures.forth
			end
			selected_figures.wipe_out
			select_figure (new_group)
		end

	ungroup_selection
			-- Ungroup selected figures.
		require
			one_selected: selected_figures.count = 1
		local
			selected_figure: EV_MODEL
		do
			selected_figure := selected_figures.first
			if attached {EV_MODEL_GROUP} selected_figure.group as group_to_ungroup then
				start
				search (group_to_ungroup)
				remove
				selected_figures.wipe_out
				from
					group_to_ungroup.start
				until
					group_to_ungroup.is_empty
				loop
					select_figure (group_to_ungroup.first)
				end
			end
		end

feature {NONE} -- Implementation

	new_selection_group: SELECTION_GROUP
			-- Return instance of a SELECTION_GROUP, redefine if you
			-- need your on selection group.
		do
			create Result
		end

	on_pointer_pressed (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- User pressed on `world'.
		do
			if button = 1 then
				if attached top_figure_at (ax, ay, Current) as top_fig then
					on_select_figure (top_fig, ax, ay)
				end
			elseif button = 3 then
				deselect_all
			end
		end

	top_figure_at (ax, ay: INTEGER; a_group: EV_MODEL_GROUP): detachable EV_MODEL
			-- Return top figure at (`ax', `ay') in `a_group' if any.
		do
			from
				a_group.start
			until
				a_group.after or else Result /= Void
			loop
				if attached {EV_MODEL_GROUP} a_group.item as l_child then
					Result := top_figure_at (ax, ay, l_child)
				elseif a_group.item.position_on_figure (ax, ay) then
					Result := a_group.item
				end
				a_group.forth
			end
			if Result = Void then
				if a_group.position_on_figure (ax, ay) then
					Result := a_group
				end
			end
		end

	on_select_figure (figure: EV_MODEL; ax, ay: INTEGER)
			-- User pressed on `figure'.
		require
			a_figure_exist: figure /= Void
		local
			l_selected_figure: detachable EV_MODEL
		do
			if
				capture_figure = Void and then
				(ev_application.ctrl_pressed or else is_selection_enabled)
			then
				l_selected_figure ?= root_figure (figure)
				check l_selected_figure /= Void end
				if attached {SELECTION_GROUP} l_selected_figure as sg and then attached sg.selected_item as l_item then
					check
						selected_figures.has (l_item)
					end
					deselect_figure (l_item)
				else
					check
						not selected_figures.has (l_selected_figure)
					end
					select_figure (l_selected_figure)
				end
			end
		end

	root_figure (a_figure: EV_MODEL): EV_MODEL
			-- Root group containing `a_figure' but not `Current'.
		do
			if attached a_figure.group as l_group and then l_group /= Current then
				Result := root_figure (l_group)
			else
				Result := a_figure
			end
		end

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


end -- class MULTI_SELECTION_WORLD
