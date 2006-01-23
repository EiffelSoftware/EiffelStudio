indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 
	EV_TEXT_FIELD_WITH_LABEL
	
inherit 
	EV_TEXT_FIELD
		redefine
			make
		end
	
	
create
	
	make,
	make_with_label 
	
feature -- Initialization
	
	make (par: EV_CONTAINER) is
                        -- Create a text field with, `par' as
                        -- parent
		do
			create box.make (par)
			box.set_homogeneous (False)
			create label.make (box)
			Precursor {EV_TEXT_FIELD} (box)
			set_text ("0")
			set_minimum_width (50)
		end
	
	make_with_label (par: EV_CONTAINER; name: STRING) is
			-- create a text field with name
		do
			make (par)
			label.set_text (name)
		end
	
	
feature -- Access
	
	label: EV_LABEL
	box: EV_HORIZONTAL_BOX;
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
	

