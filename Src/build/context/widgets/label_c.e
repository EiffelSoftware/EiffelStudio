indexing
	description: "Context that represents a label (EV_LABEL)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class LABEL_C 

inherit
	PRIMITIVE_C
		redefine
			gui_object --, stored_node
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.ev_label_pixmap
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.label_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature -- Default event

-- 	default_event: MOUSE_ENTER_EV is
-- 		do
-- 			Result := mouse_enter_ev
-- 		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Label")
		end

feature -- Code generation

	eiffel_type: STRING is "LABEL"

	full_type_name: STRING is "Label"

-- feature -- Status report
-- 
-- 	text: STRING is
-- 		do
-- 			Result := gui_object.text
-- 		end
--  
-- feature {NONE}
-- 
-- 	forbid_recompute_size is
-- 		do
-- 			widget.forbid_recompute_size
-- 		end
--  
-- 	allow_recompute_size is
-- 		do
-- 			widget.allow_recompute_size
-- 		end
--  
-- 	widget_set_text (s: STRING) is
-- 		do
-- 			widget.set_text (s)
-- 		end
-- 
-- 	widget_set_center_alignment is
-- 		do
-- 			widget.set_center_alignment
-- 		end
-- 
-- 	widget_set_left_alignment is
-- 		do
-- 			widget.set_left_alignment
-- 		end
-- 

feature --  Implementation

	gui_object: EV_LABEL

-- -- ****************
-- -- Storage features
-- -- ****************
-- 	
-- feature 
-- 
-- 	stored_node: S_LABEL is
-- 		do
-- 			!!Result.make (Current)
-- 		end

end -- class LABEL_C

