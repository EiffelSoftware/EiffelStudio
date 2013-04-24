note
	description:
		"EiffelVision vertical box. The children are arranged vertically.%
		% Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I
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

	children_height: INTEGER
			-- Sum height of all children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN)
			-- set `is_homogeneous' to `flag'.
			-- Recompute heights of children.
		do
			is_homogeneous := flag
			notify_change (Nc_minheight, Current, False)
		end

	set_padding (value: INTEGER)
			-- Make `value' the new spacing of `Current'.
		do
			padding := value
			notify_change (Nc_minheight, Current, False)
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
			set_children_height (client_height + 2 * border_width, True)
			Precursor (size_type, a_width, a_height)
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			set_children_height (client_height + 2 * border_width, False)
		end

	set_children_height (a_height: INTEGER; originator: BOOLEAN)
			-- Resize the children to fit the current height.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			expandable: detachable ARRAYED_LIST [INTEGER]
			litem: EV_WIDGET_IMP
			rate, total_rest, mark: INTEGER
			children_size, localint: INTEGER
			cwidth, bwidth, space: INTEGER
			cur: CURSOR
			int1, int2: INTEGER
			next_non_expandable: INTEGER
			l_agents: like reversed_sizing_agents
		do
			if childvisible_nb /= 0 then
				lchild := ev_children
				expandable := non_expandable_children
				cur := lchild.cursor
				cwidth := client_width
				bwidth := border_width
				space := padding
				children_size := a_height - 2 * bwidth - total_spacing

				if is_resized_height_larger then
						-- Reuse the agent to avoid object creation					
					l_agents := reversed_sizing_agents
					if l_agents = Void then
						create l_agents.make (lchild.count)
						reversed_sizing_agents := l_agents
					elseif not l_agents.is_empty then
							-- We are in a recursive call, so we create a temporary agent list
						create l_agents.make (lchild.count)
					end
				end

					-- Homogeneous state : only the visible children are
					-- importante.
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
								l_agents.extend (agent set_item_size (litem, bwidth, mark, litem.minimum_width.max (cwidth), localint, originator))
							else
								set_item_size (litem, bwidth, mark, litem.minimum_width.max (cwidth), localint, originator)
							end
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

					-- Non homogeneous state : we have to be careful to the
					-- non expanded children too.
				else
					int1 := children_size - children_height
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
								localint := litem.minimum_height +
									rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								localint := litem.minimum_height
								if expandable.islast then
									next_non_expandable := - 1
								else
									expandable.forth
									next_non_expandable := expandable.item
								end
							end
							if l_agents /= Void then
								l_agents.extend (agent set_item_size (litem, bwidth, mark, litem.minimum_width.max (cwidth), localint, originator))
							else
								set_item_size (litem, bwidth, mark, litem.minimum_width.max (cwidth), localint, originator)
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
					end -- loop
				end -- is_homogeneous
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
			end -- ev_children.empty
		end

feature {NONE} -- Implementation for automatic size computation.

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
				from
					cur := lchild.cursor
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
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
			end
			childvisible_nb := nb_visi
			compute_childexpand_nb
			ev_set_minimum_width (value + 2 * border_width, a_is_size_forced)
		end

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
							value := value.max (litem.minimum_height)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_height (value * nb_visi +
						total_spacing + 2 * border_width, a_is_size_forced)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							value := value + litem.minimum_height
							nb_visi := nb_visi + 1
						end
						lchild.forth
					end
					children_height := value
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_height
						(value + total_spacing + 2 * border_width, a_is_size_forced)
				end
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
			else
				children_height := 0
				ev_set_minimum_height (2 * border_width, a_is_size_forced)
			end
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute both the minimum_width and the minimum_height
			-- of `Current'.
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
					ev_set_minimum_size (wvalue + 2 * border_width,
						hvalue * nb_visi + total_spacing +
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
							wvalue := wvalue.max (litem.minimum_width)
							hvalue := hvalue + litem.minimum_height
						end
						lchild.forth
					end
					children_height := hvalue
					childvisible_nb := nb_visi
					compute_childexpand_nb
					ev_set_minimum_size (wvalue + 2 * border_width,
						hvalue + total_spacing + 2 * border_width, a_is_size_forced)
				end
				if lchild.valid_cursor (cur) then
					lchild.go_to (cur)
				end
			else
				children_height := 0
				ev_set_minimum_size (2 * border_width, 2 * border_width, a_is_size_forced)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_BOX note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_VERTICAL_BOX_IMP










