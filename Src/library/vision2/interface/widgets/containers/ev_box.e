indexing

	description: 
		"EiffelVision box. Invisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class EV_BOX

inherit

	EV_INVISIBLE_CONTAINER
		redefine
			make,			
			implementation
		end
	
creation
	
	make
	
feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a fixed widget with, `parent' as
                        -- parent
		do
			!EV_BOX_IMP!implementation.make (parent)
			Precursor (parent)
		end
	
	get_expand (box_child: EV_WIDGET): BOOLEAN is
			-- Is the box expanded to fill the area 
			-- allocated to 'box_child'
		do
		end
	
	get_fill (box_child: EV_WIDGET): BOOLEAN is
			-- Is the extra space allocated to 'box_child'. Has 
			-- effect only if get_expand is True.
		do
		end
	
	get_padding (box_child: EV_WIDGET): INTEGER is
			-- The extra space added on each side of 'box_child'
		do
		end
	
	set_child_packing (box_child: EV_WIDGET; expand, fill: BOOLEAN; padding: INTEGER) is
			-- Set expand, fill and padding for 'box_child'
		
		do
		end
	
	-- feature child in this class means the last child
feature {NONE} -- Implementation
	
	implementation: EV_BOX_I
			
end -- class EV_BOX
