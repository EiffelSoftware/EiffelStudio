indexing
	description: "Objects that represent stones carrying a GB_OBJECT representing a clipboard object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD_OBJECT_STONE
	
inherit
	GB_OBJECT_STONE
		redefine
			object
		end
		
	GB_SHARED_CLIPBOAD
		export
			{NONE} all
		end

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
			-- Warning this builds new objects, so do not call
			-- from a veto pebble function, only on the drop.
		do
			Result := clipboard.object
		end
		
	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		do
			Result := clipboard.object_type
		end

end -- class GB_CLIPBOARD_OBJECT_STONE
