indexing
	description: "Remove an Element from the List"
	author: "kolli"
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_COM

inherit
	--EC_COMMAND

	EV_COMMAND

creation
	make

feature -- Initialization

	make (a: like algo_window) is
			-- Initialize
		do
			algo_window := a
		end

feature
		-- Properties
	algo_window: ADVANCED_COLOR_WINDOW

feature
	-- EC_COMMAND Implementation

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
	--	scroll_list: EC_SCROLLABLE_LIST
	--	scroll_element: ELEMENT_SCROLL_FOR_ALGO
	do
	--	scroll_list := algo_window.scroll_list2
	--	scroll_element ?= scroll_list.selected_item
	--	if scroll_element /= Void then
	--		scroll_list.prune_all (scroll_element)
	--	end
	--	if scroll_list.count>0 then
	--		scroll_list.go_i_th(1)
	--		scroll_list.select_item
	--	end
	end

end -- class REMOVE_COM
