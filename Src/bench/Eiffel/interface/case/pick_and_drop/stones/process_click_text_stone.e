indexing
						
	description: 
		"Command that processes the stones dropped in a %
		%click text area, according to their type.";
	date: "$Date$";
	revision: "$Revision $"

class 
	PROCESS_CLICK_TEXT_STONE

inherit
	PROCESS_CLICKABLE_AREA_STONE
		redefine
			compatible, process_element, process_cluster,
			process_class
		end

creation

	make

feature -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Is stone dropped compatible with Current hole?
		local
			st_type: INTEGER
		do
		--	st_type := dropped.stone_type;
		--	Result := st_type = Stone_types.generic_type or else
		--				st_type = Stone_types.description_type or else
		--				st_type = Stone_types.comment_type or else
		--				st_type = Stone_types.class_type or else
		--				st_type = Stone_types.cluster_type or else
		--				st_type = Stone_types.index_type
		end

	process_class (class_stone: CLASS_STONE) is
		local
			c_stone: CLICK_STONE;
			target_stone: STONE 
			new_result_data, result_data: RESULT_DATA;
			new_arg_data, arg_data: ARGUMENT_DATA;
			new_gen_data, gen_data: GENERIC_DATA;
			new_type_data, type_data: TYPE_DECLARATION;
			replace_command: REPLACE_DATA_U;
			element_stone: ELEMENT_STONE;
			type_stone: TYPE_DEC_STONE
			cl : CLASS_STONE
		do
--				--| not target until the contrary is proven:
--			no_correct_target := true
--			c_stone := clickable_area.click_stone_at (clickable_area.button_data);
--			if c_stone /= Void then
--				target_stone := c_stone.stone;
--				type_stone ?= target_stone;
--				if type_stone /= Void then
--					no_correct_target := false
--					type_data := type_stone.type_dec;
--					new_type_data := clone (type_data);
--					new_type_data.update_type (class_stone.data)
--					!! replace_command.make (type_stone.data_container, type_data, new_type_data);
--				else
--					-- we assume that it is a class
--					if class_stone.data/= Void then
--						Windows.create_class_window ( class_stone.data )
--					end
--				end
--			end --| if c_stone
	end

	process_element ( elem : ELEMENT_STONE ) is
		do
--			Windows.namer_window.popup_at_current_position ( elem )	
		end
	
	process_cluster ( cluster_stone : CLUSTER_STONE ) is
	do
--			Windows.namer_window.popup_at_current_position ( cluster_stone)	
	end


end -- class PROCESS_CLICK_TEXT_STONE




