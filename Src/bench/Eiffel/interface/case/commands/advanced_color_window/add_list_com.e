indexing
	description: "Send the Indice of the Current Element to the Advanced Color Window";
	date: "$Date$";
	revision: "$Revision$"

class 
	ADD_LIST_COM
inherit
	--EC_COMMAND
	--	redefine
	--		stone_type
	--	end

	EV_COMMAND

	EC_STONE_TYPES
		
creation

	make

feature

	make ( algo_w : like algo_window; ind : INTEGER ) is
	do
		algo_window := algo_w
		indice := ind
	end

	indice : INTEGER
		-- # toggle pressed

	algo_window : ADVANCED_COLOR_WINDOW

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
		--	algo_window.deal_with_tfield (indice)
		end

	stone_type :INTEGER is 
	do
		Result := add_class_list
	end

	target : EV_WIDGET


end -- class ADD_LIST_COM
