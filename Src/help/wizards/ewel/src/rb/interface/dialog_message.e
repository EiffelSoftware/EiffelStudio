indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	DIALOG_MESSAGE

inherit
	WEL_MODELESS_DIALOG

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create a Dialog of type 'Message'
		require
--			a_parent_not_void: a_parent /= Void
		do
--			make_by_id (a_parent, Idd_dialog_message)
--			!! static_info.make_by_id (Current, Idc_info)
--			activate
		ensure
--			exists: exists				
--			info_exists: static_info.exists
		end

feature -- Access

	static_info: WEL_STATIC

end -- class DIALOG_MESSAGE
