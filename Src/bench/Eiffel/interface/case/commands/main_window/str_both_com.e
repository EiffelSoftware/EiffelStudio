indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STR_BOTH_COM

inherit
	
	STR_LINK_COM

creation
	make

feature
	-- creation

	make (t1: like str_both; t2: like str_client; t3: like str_inh) is
	do
		str_both := t1
		str_client := t2
		str_inh := t3
	end

feature
	-- Properties

	str_both: EV_CHECK_MENU_ITEM
	str_client: EV_CHECK_MENU_ITEM
	str_inh: EV_CHECK_MENU_ITEM

feature
	-- Updating

	update is
	do
		if str_client.is_selected and str_inh.is_selected then
			str_both.set_selected (true)
			system.set_str_both (true)
		else
			str_both.set_selected (false)
			system.set_str_both (false)
		end
	end

feature --

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	do
		System.modify_str_both	
		if system.str_both then
			str_client.set_selected (true)
			str_inh.set_selected (true)
		else
			str_client.set_selected (false)
			str_inh.set_selected (false)
		end

	end

end -- class STR_BOTH_COM
