indexing
	description: "Controls used to modify objects of type EV_CONTAINER"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTAINER_CONTROL
	
inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; a_container: EV_CONTAINER; output: EV_TEXT) is
			-- Create controls to manipulate `a_container', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_CONTAINER")
			container := a_container
			create vertical_box
			extend (vertical_box)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_container)
			vertical_box.extend (extend_button)
			create wipe_out_button.make_with_text ("Wipe_out")
			wipe_out_button.select_actions.extend (agent container.wipe_out)
			wipe_out_button.select_actions.extend (agent update_information)
			vertical_box.extend (wipe_out_button)
			
			create full_label
			vertical_box.extend (full_label)
			create is_empty_label
			vertical_box.extend (is_empty_label)
			create extendible_label
			vertical_box.extend (extendible_label)
			create prunable_label
			vertical_box.extend (prunable_label)
			create count_label
			vertical_box.extend (count_label)
			
			update_information
			box.extend (Current)
		end
		
feature {NONE} -- Implementation
		
	extend_container is
			-- extend `new_child' into `container'.
		do
			create new_child.make_with_text ("Item " + container.count.out)
			container.extend (new_child)
			update_information
		end
		
	update_information is
			-- Update queries about container.
		do
			if container.is_empty then
				is_empty_label.set_text ("is_empty: True")
			else
				is_empty_label.set_text ("is_empty: False")
			end
			if container.full then
				full_label.set_text ("full: True")
			else
				full_label.set_text ("full: False")
			end
			if container.extendible then
				extendible_label.set_text ("extendible: True")
				extend_button.enable_sensitive
			else
				extendible_label.set_text ("extendible: False")
				extend_button.disable_sensitive
			end
			if container.prunable then
				prunable_label.set_text ("prunable: True")
				wipe_out_button.enable_sensitive
			else
				prunable_label.set_text ("prunable: False")
				wipe_out_button.disable_sensitive
			end
			count_label.set_text ("count : " + container.count.out)
		end
		
		-- Widgets used to create controls.
	vertical_box: EV_VERTICAL_BOX
	extend_button, wipe_out_button: EV_BUTTON
	new_child: EV_BUTTON
	container: EV_CONTAINER
	horizontal_box: EV_HORIZONTAL_BOX
	full_label: EV_LABEL
	is_empty_label: EV_LABEL
	extendible_label: EV_LABEL
	prunable_label: EV_LABEL
	count_label: EV_LABEL

end -- class GAUGE_CONTROL
