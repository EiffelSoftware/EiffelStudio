indexing
	description	: "Box in which the user may choose one from a list of possible text values."
	date		: "$Date$"
	revision	: "$Revision$"

class
	SINGLE_TEXT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			resource,
			display
		end

create
	make

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			populate_combo
		end

feature {NONE} -- Implementation

	update_changes is
			-- Commit the resource.
		local
			new_value: STRING
			l_item: STRING
			l_combo: EV_COMBO_BOX
		do
			check
				resource_exists: resource /= Void
			end
			l_combo ?= change_item_widget
			if l_combo /= Void then
				selected_item := l_combo.selected_item
				from
					create new_value.make_empty
					new_value.append (selected_item.text + ";")
					l_combo.start
				until
					l_combo.after
				loop
					l_item := l_combo.item.text
					if not l_item.is_equal (selected_item.text) then
						new_value.append (l_item + ";")
					end
					l_combo.forth
				end
				resource.set_value (new_value)
				update_resource
				caller.update (resource)
			end
		end	

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			l_dummy: EV_COMBO_BOX
		do
			create l_dummy
			change_item_widget := l_dummy
		end
		
	populate_combo is
			-- Populate the combo with values from resource and select the appropriate value.
		local
			l_cnt: INTEGER
			l_item: STRING
			l_combo: EV_COMBO_BOX
			l_combo_item: EV_LIST_ITEM
		do
			create l_combo
			l_combo.disable_edit
			if combo_values = Void then
				combo_values := resource.actual_value				
			end
			from
				l_cnt := 1
			until
				l_cnt > combo_values.count
			loop
				l_item := combo_values.item (l_cnt)
				create l_combo_item.make_with_text (l_item)
				l_combo.extend (l_combo_item)
				l_cnt := l_cnt + 1
			end
			l_combo.first.enable_select
			l_combo.select_actions.extend (agent update_changes)
			change_item_widget := l_combo
		end

	combo_values: ARRAY [STRING]

	resource: ARRAY_RESOURCE
			-- Resource.

	selected_item: EV_LIST_ITEM
			-- "True" item in the combo box.
	
end -- class BOOLEAN_SELECTION_BOX
