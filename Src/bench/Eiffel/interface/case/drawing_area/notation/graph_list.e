indexing

	description: 
		"Graphic management for list of graphical figures.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_LIST [T->GRAPH_FORM] 

inherit

	SORTED_TWO_WAY_LIST [T]
		rename
			duplicate as list_duplicate
		export
			{ANY} extend
		end;
	ONCES
		undefine
			copy, setup
		end

creation

	make

feature -- Properties

	data_type: DATA is do end;
			-- Just to have the item.data's type

	datas: LINKED_SET [like data_type] is
			-- Set of datas
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor;
			!! Result.make;
			from
				start
			until
				after
			loop
				Result.extend (item.data);
				forth
			end;
			go_to (old_cursor)
		ensure
			Result /= void;
			Result.count = count
		end 

feature -- Element change

	add_form (graph_form: like item) is
			-- Add `graph_form' to the end of the list.
		require
			not_have_graph_form: not has (graph_form)
		do
			finish;
			put_right (graph_form);
		ensure
			is_in_current: has (graph_form);
			is_last: last = graph_form
		end;

	intersect (other: like Current) is
			-- Remove all items not in 'other'
		require
			has_other: other /= Void
		do
			if not other.empty then
				from
					start;
					other.start
				until
					after
				loop
					if other.has (item) then
						forth
					else
						remove
					end
				end
			else
				wipe_out
			end
		end; 

	merge_closure (closure: EC_CLOSURE) is
			-- Merge figures closure into `closure'.
		require
			valid_closure: closure /= Void
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				after
			loop
				if not closure.includes (item.closure) then
					closure.merge (item.closure)
				end
				forth
			end
			go_to (old_cursor)
		end; 

feature -- Access

	figures_in (closure: EC_CLOSURE): LINKED_LIST [T] is
			-- Figures in `closure'
		require
			valid_closure: closure /= Void
		local
			old_cursor: CURSOR
		do
			!!Result.make;
			old_cursor := cursor;
			from
				start
			until
				after
			loop
				if closure.includes (item.closure) then
					Result.put_front (item)
				end;
				forth
			end;
			go_to (old_cursor)
		end; -- figures_in

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor;
			from
				start
			until
				after or not (Result = Void)
			loop
				Result := item.figure_at (x_coord, y_coord);
				forth
			end;
			go_to (old_cursor)
		end; -- figure_at

	find (data: DATA): T is
			-- Find a GRAPH_FORM whose entity is `data'
		require
			not (data = Void)
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor;
			from
				start
			until
				after or not (Result = Void)
			loop
				if item.data = data then
					Result := item
				end;
				forth
			end;
			go_to (old_cursor)
		end -- find

feature -- Removal

	remove_form (graph_form: like item) is
		do
			start;
			prune (graph_form);
		ensure
			not_in_current: not has (graph_form)			
		end;

	destroy_without_clip_update is
			-- Destroy figures.
		do
			from
				start
			until
				after
			loop
				item.destroy_without_clip_update;
				forth
			end
		end; 

	destroy is
			-- Destroy figures.
		do
			from
				start
			until
				after
			loop
				item.destroy;
				forth
			end
		end; -- destroy

feature -- Duplication

	duplicate: like Current is
			-- Exact copy of this list
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor;
			!! Result.make;
			from
				start;
			until
				after
			loop
				Result.put_right (item);
				Result.forth;
				forth;
			end;
			go_to (old_cursor)
		ensure
			Result /= void;
			Result.count = count
		end; 

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure
		require
			a_workarea_exists: not (a_workarea = Void)
		do
			from
				start
			until
				after
			loop
				item.attach_workarea (a_workarea);
				forth
			end
		end; -- attach_workarea

	build is
			-- Build figures.
		do
			from
				start
			until
				after
			loop
				item.build;
				forth
			end
		end; -- Build

feature -- Output

	draw_in (clip_closure: EC_CLOSURE) is
			-- Draw figures if in clip area `clip'.
		do
			if count>0 then
				from
					start
				until
					after
				loop
					item.draw_in (clip_closure);
					forth
				end
			end

		end; -- draw


	invert_skeleton (painter: PATCH_PAINTER; origin_x, origin_y: INTEGER) is
			-- Invert the class's skeleton.
			-- Draw on `painter' as if the origin is at
			-- (`origin_x', `origin_y').
		do
			from
				start
			until
				after
			loop
				item.invert_skeleton (painter, origin_x, origin_y);
				forth
			end
		end -- invert_skeleton

feature -- Update

	update is
			-- Call update_form and draw on items
		do
			from
				start
			until
				after
			loop
				item.update;
				forth
			end
		end; 

feature {GRAPH_CLUSTER} -- Implementation

	erase_if_not_in (closure: EC_CLOSURE) is
			-- Erase figure if not in closure `closure'.
		require
			valid_closure: closure /= Void
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				after
			loop
				--check
				--	intersects: closure.intersects (item.closure)
				--end;
				if not closure.includes (item.closure) then
					item.erase
				end
				forth
			end;
			go_to (old_cursor)
		end; 

feature -- Debug

	trace is
			-- Call update_form and draw on items
		do
			from
				start
			until
				after
			loop
				item.data.trace;
				io.error.new_line;
				forth
			end
		end

end -- class GRAPH_LIST
