indexing

	description: "Manager of figures";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	
	WORLD 

inherit
	
	COMPOSITE_FIG	
		rename
			composite_mark as world_mark,
			composite_return as world_return
		undefine
			is_equal,
			copy
		redefine
			set_origin,
			set_no_origin,
			clip_draw
		end;


	FIXED_LIST [LINKED_LIST[FIGURE]]
		rename
			make as al_make,
			make_filled as al_make_filled,
			put as al_put,
			item as al_item,
			start as al_start,
			finish as al_finish,
			forth as al_forth,
			remove as al_remove,
			has as al_has,
			search as al_search,
			capacity as al_capacity,
			count as al_count,
			extend as al_add,
			append as al_append,
			replace as al_replace,
			wipe_out as al_wipe_out 
		export 	
			{WORLD} all;
			{ANY} off, after, before
		end;

creation

	make, make_with_plane

feature -- Initialization

	make is
			-- Create a world
		local
			ll: LINKED_LIST [FIGURE];
		do
			if max_plane <= 0 then
				max_plane := Default_max_plane;
			end;
			al_make_filled (max_plane);
				-- 0 <= plane < Max_plane
			from
				al_start
			until
				off
			loop
				!! ll.make;
				al_replace (ll);
				al_forth
			end;
			start;
			notify_make;
			!! changes_box.make;
			!! surround_box.make;
			!! origin;
			set_conf_receive;
			set_conf_not_notify;
			conf_notified := Current;
		end;

	make_with_plane (plane_number: INTEGER) is
		do
			max_plane := plane_number;
			make
		end;

feature -- Access

	item: FIGURE is
		do
			Result := al_item.item
		end;

	has (f: FIGURE): BOOLEAN is
				-- Does `Currnt` include `f`
		do
			Result := i_th (f.plane + 1). has (f)
		end;

	search (f: FIGURE) is
				-- Move to first position where f and item are identical
				-- according to '=' rule
		do
			i_th (f.plane+1).search (f);
			if i_th (f.plane+1).off then
				index := max_plane
			end
		end;

	search_equal (f: FIGURE) is
				-- Move to first position where f and item are identical
				-- according to `equal' rule
		do
			i_th (f.plane+1).compare_objects;
			i_th (f.plane+1).search (f);
			i_th (f.plane+1).compare_references;
			if i_th (f.plane+1).off then
				index := max_plane 
			end
		end;

	origin: COORD_XY_FIG;
			-- Origin of the world

feature -- Measurement

	count: INTEGER is
				-- Number of item in `Current'
		do
			world_mark;
			from
				al_start
			until
				off
			loop
				Result := Result + al_item.count;
				al_forth
			end;
			world_return
		end;


feature -- Element change

	set_origin (p: like origin) is
			-- Set `origin' to `p'.
		require else
			p_exists: p /= Void
		do
			origin := p
		ensure then
			origin = p
		end;

	add (v: FIGURE) is
			-- Append `v' 
		do
			v.set_conf_not_notify;
			v.attach_drawing_imp_with_parent (Current, drawing);
			if i_th (v.plane+1).before then
				if i_th (v.plane+1).is_empty then
					i_th (v.plane+1).forth
				else
					i_th (v.plane+1).start
				end
			end;
			i_th (v.plane+1).put_left (v);
			v.set_conf_notify;
			v.conf_recompute;
			set_conf_modified_with (v.surround_box);
		end;

 	merge (other: like Current) is
			-- Merge `other' 
			-- Do not move cursor.
			-- Empty other.
		do
			from
				other.start
			until
				other.off
			loop
				other.item.attach_drawing_imp_with_parent ( Current, drawing);
				other.forth
			end;
			from
				world_mark;
				al_start;
				other.al_start
			until
				off
			loop
				al_item.merge_left (other.al_item);
				al_forth;
				other.al_forth
			end;
			world_return;
			set_conf_modified_with (other.surround_box)
		end;

	put (v: FIGURE) is
			-- Put item `v' at cursor position.
		do
			set_conf_modified_with (item.surround_box);
			v.attach_drawing_imp_with_parent ( Current, drawing);
			al_item.put (v);
			set_conf_modified_with (v.surround_box)
		end;


feature -- Removal

	remove (fig: FIGURE) is
			-- remove `fig`
		do
			world_mark;
			start;
			search (fig);
			if not off then 
				i_th (fig.plane + 1).remove 
			end;
			world_return;
			set_conf_modified_with (fig.surround_box)
		end;

	wipe_out is
			-- remove all figures
		do
			from
				al_start
			until
				off
			loop
				al_item.wipe_out;
				al_forth
			end;
			surround_box.wipe_out;
			changes_box.wipe_out;
			set_conf_modified
		end;

feature -- Cursor movement 

	start is
			-- Move to first position
		do
			from
				al_start
			until
				off or else (not al_item.is_empty)
			loop
				al_forth
			end;
			if not off then
				al_item.start
			end
		end;

	finish is
			-- Move to last position
		do
			al_finish;
			al_item.finish;
			if al_item.is_empty then
				al_forth
			end
		end;

	forth is
			-- Move to next position
		do
			al_item.forth;
			if al_item.after then
				from
					al_forth
				until
					off or else (not al_item.is_empty) 
				loop
					al_forth
				end;
				if not off then
					al_item.start
				end
			end	
		end;

feature -- Output

	clip_draw (clip: CLIP) is
		local
			box: CLOSURE;
			new_clip: CLIP;
			first_drawn_plane: INTEGER;
		do
			!! box.make;
			box.merge_clip (clip);
			new_clip := clip;
			if conf_receive then
				if conf_modified then
					!! box.make;
					box.merge_clip (new_clip);
					box.merge (changes_box);
					new_clip := box.as_clip;
					conf_recompute;
					changes_box.wipe_out
				end
			else
				conf_recompute
			end;
			!! box.make;
			box.merge_clip (new_clip);
			if drawing.is_drawable and surround_box.override (new_clip) then
				world_mark;
				from
					start;
					first_drawn_plane := -1
				until
					off or first_drawn_plane >= 0
				loop
					if item.surround_box.override (new_clip) then
						first_drawn_plane := index;
						item.clip_draw (new_clip)
					end;
					forth
				end;
				from
				until
					off
				loop
					if index > first_drawn_plane or else 
						item.surround_box.override (new_clip) then
						item.clip_draw (new_clip)
					end;
					forth
				end;
				world_return
			end
		end;

feature {WORLD} -- Access

	mark_index: INTEGER;
			-- position in array sequence

	linked_list_cursor: CURSOR ;

feature {WORLD} -- Element change

	set_no_origin is
			-- Erase definition of `origin'.
		do
			origin := Void
		ensure then
			no_origin: origin = Void
		end;

feature {WORLD} -- Cursor

	world_mark is
		do
			mark_index := index;
			if not off then
				linked_list_cursor := al_item.cursor
			end
		end;

	world_return is
		do
			index := mark_index;
			if not off then
				al_item.go_to (linked_list_cursor)
			end
		end;

end --  class WORLD


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

