class 
	EV_ENTRY_WITH_LABEL
	
inherit 
	EV_ENTRY
		redefine
			make
		end
	
	
creation
	
	make,
	make_with_label 
	
feature -- Initialization
	
	make (par: EV_CONTAINER) is
                        -- Create an entry with, `par' as
                        -- parent
		do
			!!box.make (par)
			box.set_homogeneous (False)
			!!label.make (box)
			Precursor (box)
			set_minimum_width (40)
			label.set_width (50)
		end
	
	make_with_label (par: EV_CONTAINER; name: STRING) is
			-- create an entry with name
		do
			make (par)
			label.set_text (name)
		end
	
	
feature -- Access
	
	label: EV_LABEL
	box: EV_HORIZONTAL_BOX
	
end
	
