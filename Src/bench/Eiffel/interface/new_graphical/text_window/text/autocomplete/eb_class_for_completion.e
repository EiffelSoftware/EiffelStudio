indexing
	description: "A class to be inserted into the auto-complete list"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EB_CLASS_FOR_COMPLETION

inherit
	EB_NAME_FOR_COMPLETION
		redefine
			icon,
			tooltip_text,
			is_class,
			full_insert_name
		end
			

create
	make

feature {NONE} -- Initialization

	make (a_class: like associated_class) is
			-- Creates and initializes a new class completion item
		require
			a_class_not_void: a_class /= Void
		do
			make_with_name (a_class.name)
			associated_class := a_class
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Access

	is_class: BOOLEAN is
			-- Is completion item a class?
		do
			Result := True
		end
		
	full_insert_name: STRING is
			-- Full name to insert in editor
		do			
			Result := associated_class.name
		end	

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := pixmap_from_class_i (associated_class)
		end		

	tooltip_text: STRING is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			Result := Current.out.twin
		end

feature {NONE} -- Implementation

	associated_class: CLASS_I
			-- Corresponding class
			
end -- class EB_CLASS_FOR_COMPLETION
