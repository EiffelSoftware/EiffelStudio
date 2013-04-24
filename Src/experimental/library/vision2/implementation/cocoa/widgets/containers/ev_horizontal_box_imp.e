note
	description: "EiffelVision horizontal box. Cocoa implementation."
	author: "Daniel Furrer"

class
	EV_HORIZONTAL_BOX_IMP

inherit
	EV_HORIZONTAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			ev_apply_new_size
		end

create
	make

feature -- Access

	children_width: INTEGER
			-- Sum of the width of all the children.

feature {NONE} -- Basic operation

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			set_children_width (client_width, False)
		end

	set_children_width (a_width: INTEGER; originator: BOOLEAN)
			-- Move and resize the children to have them adapted to the
			-- current width.
		local
			litem: EV_WIDGET_IMP
			rate, total_rest, x: INTEGER
			children_size, item_width: INTEGER
			item_height: INTEGER
			cur: CURSOR
			int1, int2: INTEGER
		do
			if childvisible_nb /= 0 then
				cur := ev_children.cursor
				item_height := client_height
				children_size := a_width - 2 * border_width - total_spacing

					-- Homogeneous state : only the visible children are
					-- important.
				if is_homogeneous then
					rate := children_size // childvisible_nb
					total_rest := children_size \\ childvisible_nb
					from
						x := border_width
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							item_width := rate + rest (total_rest)
							total_rest := (total_rest - 1).max (0)
							if originator then
								litem.ev_move_and_resize (x, border_width, item_width, item_height, True)
							else
								litem.ev_apply_new_size (x, border_width, item_width, item_height, True)
							end
							x := x + padding + item_width
						end
						ev_children.forth
					end

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
						x := border_width
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							if litem.is_expandable then
								item_width := litem.minimum_width + rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								item_width := litem.minimum_width
							end
							if originator then
								litem.ev_move_and_resize (x, border_width, item_width, item_height, True)
							else
								litem.ev_apply_new_size	(x, border_width, item_width, item_height, True)
							end
							x := x + padding + item_width
						end
						ev_children.forth
					end -- loop.
				end -- is_homogeneous.
				if ev_children.valid_cursor (cur) then
					ev_children.go_to (cur)
				end
			end
		end

feature {NONE} -- Implementation for automatic size compute

	compute_minimum_height
			-- Recompute the minimum_height of `Current'.
		local
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				from
					cur := ev_children.cursor
					ev_children.start
				until
					ev_children.after
				loop
					litem := ev_children.item
					if litem.is_show_requested then
						nb_visi := nb_visi + 1
						value := value.max (litem.minimum_height)
					end
					ev_children.forth
				end
				if ev_children.valid_cursor (cur) then
					ev_children.go_to (cur)
				end
				childvisible_nb := nb_visi
				compute_childexpand_nb
			end
			internal_set_minimum_height (value + 2 * border_width)
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				cur := ev_children.cursor
				if is_homogeneous then
					from
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value.max (litem.minimum_width)
						end
						ev_children.forth
					end
					childvisible_nb := nb_visi
					compute_childexpand_nb
					internal_set_minimum_width (value * nb_visi + total_spacing + 2 * border_width)
				else
					from
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value + litem.minimum_width
						end
						ev_children.forth
					end
					children_width := value
					childvisible_nb := nb_visi
					compute_childexpand_nb
					internal_set_minimum_width (value + total_spacing + 2 * border_width)
				end
				if ev_children.valid_cursor (cur) then
					ev_children.go_to (cur)
				end
			else
				children_width := 0
				internal_set_minimum_width (2 * border_width)
			end
		end

	compute_minimum_size
			-- Recompute both the minimum_width and the minimum_height of
			-- `Current'.
		local
			litem: EV_WIDGET_IMP
			cur: CURSOR
			hvalue, wvalue, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				cur := ev_children.cursor
				if is_homogeneous then
					from
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue.max (litem.minimum_width)
							hvalue := hvalue.max (litem.minimum_height)
						end
						ev_children.forth
					end
					childvisible_nb := nb_visi
					compute_childexpand_nb
					internal_set_minimum_size (wvalue * nb_visi + total_spacing + 2 * border_width, hvalue + 2 * border_width)
				else
					from
						ev_children.start
					until
						ev_children.after
					loop
						litem := ev_children.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue + litem.minimum_width
							hvalue := hvalue.max (litem.minimum_height)
						end
						ev_children.forth
					end
					children_width := wvalue
					childvisible_nb := nb_visi
					compute_childexpand_nb
					internal_set_minimum_size (wvalue + total_spacing + 2 * border_width, hvalue + 2 * border_width)
				end
				if ev_children.valid_cursor (cur) then
					ev_children.go_to (cur)
				end
			else
				children_width := 0
				internal_set_minimum_size (2 * border_width, 2 * border_width)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HORIZONTAL_BOX note option: stable attribute end;

end -- class EV_HORIZONTAL_BOX_IMP
