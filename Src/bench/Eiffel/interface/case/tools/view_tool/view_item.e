indexing
	description: "List Item which describes a system view."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEW_ITEM

inherit
	EV_LIST_ITEM

creation
	make_with_view_info

feature -- Initialization

	make_with_view_info(par: EV_LIST;new_view_info: SYSTEM_VIEW_INFO) is
			-- Initialize
		require
			parent_exists: par /= Void
			view_info_possible: new_view_info /= VOid 
					and then new_view_info.view_name/=Void	
		do
			view_info := new_view_info
			make_with_text(par,view_info.view_name)
		end

feature -- Access

	view_info: SYSTEM_VIEW_INFO

end -- class VIEW_ITEM
