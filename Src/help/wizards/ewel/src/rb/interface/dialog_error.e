indexing
	description: "This dialog appears when a parsing is in progress" ;
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	DIALOG_ERROR

inherit
	WEL_MODELESS_DIALOG
		redefine
			on_ok
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create a Dialog of type 'ERROR'
		require
			a_parent_not_void: a_parent /= Void
		do
			make_by_id (a_parent, Idd_dialog_error)
			!! static_info.make_by_id (Current,Idc_info)
			activate
			hide
		ensure
			exists: exists				
			info_exists: static_info.exists
		end

feature -- Behavior
	
	on_ok is
		do
			hide
		end

feature -- Access

	static_info: WEL_STATIC

end -- class DIALOG_ERROR
