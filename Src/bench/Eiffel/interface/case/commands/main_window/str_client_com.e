indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STR_CLIENT_COM

inherit
	
	STR_LINK_COM

creation

make

feature -- init

make ( wid : like widget ) is
	do
		widget := wid
	end


feature -- for the execution

	widget : EV_CHECK_MENU_ITEM
	str_both_com: STR_BOTH_COM

feature
	-- Settings

	set_str_both_com (s: STR_BOTH_COM) is
	do
		str_both_com := s
	end

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	do
		System.modify_str_client(widget.is_selected)	
		str_both_com.update
	end

	

end -- class STR_CLIENT_COM
