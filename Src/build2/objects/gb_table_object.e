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
			object, add_child_object
		end
		
	DOUBLE_MATH

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_TABLE

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
			object.extend (widget)
			
			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			table ?= display_object.child
			check
				child_is_a_table: table /= Void
			end
			table.extend (widget)

			if not layout_item.has (an_object.layout_item) then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)			
			end
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation
		
	resize_to_accomodate (children_count: INTEGER) is
			-- Resize `display_object' and `object' of `object' to
			-- smallest square dimensions that will accomodate `children_count'
			-- children.
		local
			temp_table: EV_TABLE
			new_dimension: INTEGER
			double: DOUBLE
		do
			double := children_count
			new_dimension := (sqrt (double)).ceiling
			object.resize (new_dimension, new_dimension)
			temp_table ?= display_object.child
			check
				temp_table /= Void
			end
			temp_table.resize (new_dimension, new_dimension)
		ensure
			may_accomodate_children: object.rows * object.columns >= children_count
			-- and display_object.rows * display_object.columns >= children_count
			-- Not possible to check this right now.
		end

end -- class GB_TABLE_OBJECT