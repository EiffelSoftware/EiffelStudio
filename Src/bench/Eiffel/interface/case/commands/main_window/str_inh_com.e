indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STR_INH_COM

inherit
	
	STR_LINK_COM
creation

make

feature -- init

make ( t : like str_inh) is
	do
		str_inh := t
	end

feature
	-- Settings

	set_str_both_com (s: STR_BOTH_COM) is
	do
		str_both_com := s
	end

feature -- for the execution

	str_inh : EV_CHECK_MENU_ITEM
	str_both_com : STR_BOTH_COM

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	do
		System.modify_str_inh(str_inh.is_selected)
		str_both_com.update
	end

end -- class STR_INH_COM
