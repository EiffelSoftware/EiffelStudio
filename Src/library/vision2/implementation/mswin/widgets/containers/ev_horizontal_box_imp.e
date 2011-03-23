note
	description: "[
		EiffelVision horizontal box. The children stand
		one beside an other. Mswindows implementation.

		Note: The attribute `child' represent here the child with the			
			largest width of the box.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_BOX_IMP

inherit
	EV_HORIZONTAL_BOX_I
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			on_size
		end

create
	make

feature -- Access

	children_width: INTEGER
			-- Sum of the width of all the children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN)
			-- set `is_homogeneous' to `flag'.
			-- Recompute widths of children.
		do
			is_homogeneous := flag
			notify_change (Nc_minwidth, Current, False)
		end

	set_padding (value: INTEGER)
			-- Make `value' the new spacing of `Current'.
		do
			padding := value
			notify_change (Nc_minwidth, Current, False)
		end

	set_border_width (value: INTEGER)
			-- Make `value' the new border width of `Current'.
		do
			border_width := value
			notify_change (Nc_minsize, Current, False)
		end

feature {NONE} -- Basic operation

	on_size (size_type, a_width, a_height: INTEGER)
		do
			Precursor {EV_BOX_IMP} (size_type, a_width, a_height)
			set_children_width (client_width + 2 * border_width, True)
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			set_children_width (client_width + 2 * border_width, False)
		end

	set_children_width (a_width: INTEGER; originator: BOOLEAN)
			-- Move and resize the children to have them adapted to the
			-- current width.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			expandable: detachable ARRAYED_LIST [INTEGER]
			litem: EV_WIDGET_IMP
			rate, total_rest, mark: INTEGER
			children_size, localint: INTEGER
			cheight, bwidth, space: INTEGER
			cur: CURSOR
			int1, int2: INTEGER
			next_non_expandable: INTEGER
			l_agents: like reversed_sizing_agents
		do
			if childvisible_nb /= 0 then
				lchild := ev_children
				expandable := non_expandable_children
				cur := lchild.cursor
				cheight := client_height
				bwidth := border_width
				space := padding
				children_size := a_width - 2 * bwidth - total_spacing

				if is_resized_width_larger then
						-- Reuse the agent to avoid object creation
					l_agents := reversed_sizing_agents
					if l_agents = Void then
						create l_agents.make (lchild.count)
						reversed_sizing_agents := l_agents
					end
				end

					-- Homogeneous state : only the visible children are
					-- important.
				if is_homogeneous then
					rate := children_size // childvisible_nb
					total_rest := children_size \\ childvisible_nb
					from
						mark := bwidth
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							localint := rate + rest (total_rest)
							total_rest := (total_rest - 1).max (0)
							if l_agents /= Void then
								l_agents.extend (agent set_item_size (litem, mark, bwidth, localint, cheight, originator))
							else
								set_item_size (litem, mark, bwidth, localint, cheight, originator)
							end
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

					-- Non homogeneous state : we have to be carefull to the non
					-- expanded children too.
				else
					int1 := children_size - children_width
					int2 := childexpand_nb.max (1)
						-- It is possible that int1 < 0.
						-- This occurs when `Current' has a minimum width and
						-- the children are larger. Because of the minimum
						-- width, `Current' does not expand.
					if int1 >= 0 then
						rate := int1 // int2
						total_rest := int1 \\ int2
					else
						rate := 0
						total_rest := 0
					end

						-- Then, we ask the children to move and resize.
						-- Be carefull to the expanded child.
					from
						mark := bwidth
						lchild.start
						if expandable = Void then
							next_non_expandable := -1
							create expandable.make (0)
						else
							expandable.start
							next_non_expandable := expandable.item
						end
						check expandable /= Void end
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							if lchild.index /= next_non_expandable then
								localint := litem.minimum_width +
									rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								localint := litem.minimum_width
								if expandable.islast then
									next_non_expandable := - 1
								else
									expandable.forth
									next_non_expandable := expandable.item
								end
							end
							if l_agents /= Void then
								l_agents.extend (agent set_item_size (litem, mark, bwidth, localint, cheight, originator))
							else
								set_item_size (litem, mark, bwidth, localint, cheight, originator)
							end
							mark := mark + space + localint
						elseif lchild.index = next_non_expandable then
							if expandable.islast then
								next_non_expandable := - 1
							else
								expandable.forth
								next_non_expandable := expandable.item
							end
						end
					lchild.forth
					end -- loop.
				end -- is_homogeneous.
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end

					-- If reversed resizing is required, process the agents
				if l_agents /= Void then
					from
						l_agents.finish
					until
						l_agents.before
					loop
						l_agents.item.call (Void)
						l_agents.back
					end
					l_agents.wipe_out
				end
			end
		end

feature {NONE} -- Implementation for automatic size compute

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_height of `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				from
					cur := lchild.cursor
					lchild.start
				until
					lchild.after
				loop
					litem := lchild.item
					if litem.is_show_requested then
						nb_visi := nb_visi + 1
						value := value.max (litem.minimum_height)
					end
					lchild.forth
				end
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
				childvisible_nb := nb_visi
				compute_childexpand_nb
			end
			ev_set_minimum_height (value + 2 * border_width, a_is_size_forced)
		end

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_width of `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				cur := lchild.cursor
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value.max (litem.minimum_width)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_width (value * nb_visi +
						total_spacing + 2 * border_width, a_is_size_forced)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value + litem.minimum_width
						end
						lchild.forth
					end
					children_width := value
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_width
						(value + total_spacing + 2 * border_width, a_is_size_forced)
				end
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
			else
				children_width := 0
				ev_set_minimum_width (2 * border_width, a_is_size_forced)
			end
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute both the minimum_width and the minimum_height of
			-- `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			hvalue, wvalue, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				cur := lchild.cursor
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue.max (litem.minimum_width)
							hvalue := hvalue.max (litem.minimum_height)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_size (wvalue * nb_visi +
						total_spacing + 2 * border_width, hvalue +
						2 * border_width, a_is_size_forced)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue + litem.minimum_width
							hvalue := hvalue.max (litem.minimum_height)
						end
						lchild.forth
					end
					children_width := wvalue
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_size (wvalue + total_spacing +
						2 * border_width, hvalue + 2 * border_width, a_is_size_forced)
				end
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
			else
				children_width := 0
				ev_set_minimum_size (2 * border_width, 2 * border_width, a_is_size_forced)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_BOX note option: stable attribute end;

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




end -- class EV_HORIZONTAL_BOX_IMP










