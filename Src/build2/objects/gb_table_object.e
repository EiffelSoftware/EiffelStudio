indexing
	description: "Objects that represent an EV_TABLE within Build."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TABLE_OBJECT
	
inherit
	GB_CONTAINER_OBJECT
		redefine
			object, add_child_object, is_full
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Initialization

feature -- Access

	object: EV_TABLE
	
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
				-- No need to check y as they will both be 0 or neither.
			Result := first_free_coordinate.x = 0
		end
		
	first_free_coordinate: EV_COORDINATE is
			-- First un occupied coordinate in `object'.
			-- 0, 0 if no coordinate is free.
		local
			columns_counter, rows_counter: INTEGER
			not_full: BOOLEAN
		do
			create Result
			from
				columns_counter := 1
			until
				columns_counter > object.columns or not_full
			loop
				from
					rows_counter := 1
				until
					rows_counter > object.rows or not_full
				loop
					if object.item (columns_counter, rows_counter) = void then
						not_full := True
					else
						rows_counter := rows_counter + 1
					end
				end
				if not not_full then
					columns_counter := columns_counter + 1	
				end
			end
			if not_full then
				Result.set (columns_counter, rows_counter)
			end
		end
		

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position representing `position'
			-- in the layout tree.
		local
			widget: EV_WIDGET
			temp_coordinate: EV_COORDINATE
			table: EV_TABLE
		do
			widget ?= an_object.object
			check
				object_is_a_widget: widget /= Void
			end
			temp_coordinate := first_free_coordinate
			object.add (widget, temp_coordinate.x, temp_coordinate.y, 1, 1)
			
			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			table ?= display_object.child
			check
				child_is_a_table: table /= Void
			end
			table.add (widget, temp_coordinate.x, temp_coordinate.y, 1, 1)
			

			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
		end

end -- class GB_TABLE_OBJECT