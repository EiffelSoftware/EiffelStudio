indexing
	description: "Update the Advanced Color Tool when a Class Stone is dropped";
	date: "$Date$";
	revision: "$Revision$"

class 
	ADD_LIST_DROP
inherit
	EC_COMMAND
		redefine
			stone_type,compatible,process_class,
			process_color,
			process_any
		end
		
creation

	make

feature

	compatible (st: STONE ): BOOLEAN is
		do
			Result := TRUE --(st.stone_type=class_type)
		end

	make ( algo_w : ADVANCED_COLOR_WINDOW) is
	do
		algo_window := algo_w
	end

	algo_window : ADVANCED_COLOR_WINDOW

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			-- do nothing ...	
		end

	stone_type :INTEGER is 
	do
		Result := Stone_types.any_type
	end

	target : EV_WIDGET

	process_class (class_stone: CLASS_STONE ) is
	do
	--	algo_window.text_field3.set_text(class_stone.data.name)
	--	algo_window.deal_with_tfield(2)
	end

	process_color (color_stone: COLOR_STONE ) is
	do
	--	algo_window.color_text.set_text(color_stone.color_name)
	--	algo_window.deal_with_tfield(1)
	end

	process_any (st: STONE ) is
	local
		cl : CLASS_STONE
		col : COLOR_STONE
	do
		cl ?= st
		col ?= st
		if cl /= Void then process_class (cl)
		else if col/= Void then 
				process_color (col)
		     end
		end
	end


end -- class ADD_LIST_DROP
