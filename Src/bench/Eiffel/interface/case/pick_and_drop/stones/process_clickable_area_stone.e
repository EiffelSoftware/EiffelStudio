indexing
						
	description: 
		"Command that processes the stones dropped in a %
		%clickable area, according to their type.";
	date: "$Date$";
	revision: "$Revision $"

class 
	PROCESS_CLICKABLE_AREA_STONE

inherit
	EC_COMMAND
		redefine
		--	context_data_useful,
			process_class, process_element,	process_feature, stone_type
		end

creation

	make

feature {NONE} -- Initialization

	make (ca: like clickable_area) is
			-- Create Current command and associate it to clickable_area `wa'
		require
			ca_exists: ca /= Void
		do
			clickable_area := ca
		ensure
			clickable_area_set: clickable_area /= Void
		end


feature -- Status report

	clickable_area: CLICKABLE_AREA 
				-- Clickable area to which Current command is associated.
				--| Hole for which Current command performs actions.

	context_data_useful: BOOLEAN is True;
	
	stone_type: INTEGER is
			-- Stone type of hole associated to Current command.
		do
			Result := Stone_types.void_type
		end;

feature -- Execution

	process_class (class_stone: CLASS_STONE) is
			--
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
				--| not target until the contrary is proven:
		--	no_correct_target := true
		--	c_stone := clickable_area.click_stone_at (clickable_area.button_data);
		--	if c_stone /= Void then
			--	target_stone := c_stone.stone;
		--		type_stone ?= target_stone;
		--		if type_stone /= Void then
		--			no_correct_target := false
		--			type_data := type_stone.type_dec;
		--			new_type_data := clone (type_data);
		--			new_type_data.update_type (class_stone.data)
		--			!! replace_command.make (type_stone.data_container, type_data, new_type_data);
		--		else
		--			element_stone ?= target_stone;
		--			if element_stone /= Void then
		--				gen_data ?= element_stone.data;
		--				if gen_data /= Void then
		--					no_correct_target := false
		--					new_gen_data := clone (gen_data);
		--					new_gen_data.update_type (class_stone.data)
		--					!! replace_command.make (element_stone.data_container, gen_data, new_gen_data);
		--				else
		--					arg_data ?= element_stone.data;
		--					if arg_data /= Void then
		--						no_correct_target := false
		--						new_arg_data := clone (arg_data);
		--						new_arg_data.update_type (class_stone.data)
		--						!! replace_command.make (element_stone.data_container, arg_data, new_arg_data);
		--					else
		--						result_data ?= element_stone.data;
		--						if result_data /= Void then
		--							no_correct_target := false
		--							new_result_data := clone (result_data);
		--							new_result_data.update_type (class_stone.data)
		--							!! replace_command.make (element_stone.data_container, result_data, new_result_data);
		--						end
		--					end --| if arg_data
		--				end
		--			end; --| if element_stone
		--		end
		--	end --| if c_stone
		end

	process_element (element_stone: ELEMENT_STONE) is
			-- Process dropped stone `element_stone'.			
		local
			c_stone: CLICK_STONE;
			cur_pos: INTEGER;
			el_stone: ELEMENT_STONE;
			gen_data: GENERIC_DATA;
			new_type_dec, type_dec: TYPE_DECLARATION;
			replace_command: REPLACE_DATA_U;
			type_stone: TYPE_DEC_STONE
			target_stone: STONE 
				--| local to speed up access:
			ca: like clickable_area
		do
-- 		--	ca := clickable_area
-- 		--	c_stone := ca.click_stone_at (ca.button_data);
-- 		--	if c_stone /= Void then
-- 			--	target_stone := c_stone.stone;
-- 		--		el_stone ?= target_stone;
-- 		--		if el_stone = Void then
-- 		--			type_stone ?= target_stone;
-- 		--			if type_stone /= Void then
-- 		--				gen_data ?= element_stone.data;
-- 		--				if gen_data /= Void then
-- 		--					type_dec := type_stone.type_dec;
-- 		--					new_type_dec := clone (type_dec);
-- 		--					new_type_dec.update_formal_from (gen_data)
-- 		--					!! replace_command.make (element_stone.data_container, type_dec, new_type_dec);
-- 		--				end
-- 		--			end
-- 		--		elseif element_stone.stone_type = el_stone.stone_type then
-- 		--			if ca.stone /= Void then
-- 		--					-- Stone comes from same text area
-- 		--				element_stone.insert_before (el_stone)
-- 		--			else
-- 		--				el_stone.copy_data (element_stone)
-- 		--			end;
-- 		--		end --| if el_stone = Void
-- 		--	end;
-- 			ca := clickable_area
-- 		--	c_stone := ca.click_stone_at (ca.button_data);
-- 			if c_stone /= Void then
-- 				target_stone := c_stone.stone;
-- 				el_stone ?= target_stone;
-- 				if el_stone = Void then
-- 					type_stone ?= target_stone;
-- 					if type_stone /= Void then
-- 						gen_data ?= element_stone.data;
-- 						if gen_data /= Void then
-- 							type_dec := type_stone.type_dec;
-- 							new_type_dec := clone (type_dec);
-- 							new_type_dec.update_formal_from (gen_data)
-- 							!! replace_command.make (element_stone.data_container, type_dec, new_type_dec);
-- 						end
-- 					end
-- 				elseif element_stone.stone_type = el_stone.stone_type then
-- 					if ca.stone /= Void then
-- 							-- Stone comes from same text area
-- 						element_stone.insert_before (el_stone)
-- 					else
-- 						el_stone.copy_data (element_stone)
-- 					end;
-- 				end --| if el_stone = Void
-- 			end;
		end;

	process_feature (feature_stone: FEATURE_STONE) is
			--
		local
			c_stone: CLICK_STONE;
			f_stone: FEATURE_STONE;
			rename_data: RENAME_DATA;
			new_rename_data: RENAME_DATA;
			feature_element: ELEMENT_STONE;
			replace_command: REPLACE_DATA_U;
			target_stone: STONE 
		do
				--| not target until the contrary is proven:
		--	no_correct_target := true
		--	c_stone := clickable_area.click_stone_at (clickable_area.button_data);
		--	if c_stone /= Void then
		--	--	target_stone := c_stone.stone;
		--		f_stone ?= target_stone;
		--		if f_stone /= Void then
		--			no_correct_target := false
		--			if stone /= Void then
		--					-- Stone comes from same text area
		--				feature_stone.insert_before (f_stone)
		--			else
		--				feature_stone.copy_data (f_stone)
		--			end;
		--		else
		--		--	rename_data ?= c_stone.stone.data;
		--			if rename_data /= Void then
		--				no_correct_target := false
		--			--	feature_element ?= c_stone.stone;
		--				check
		--					feature_element_exists: feature_element /= Void
		--				end;
		--				new_rename_data := clone (rename_data);
		--				new_rename_data.set_origin_feature (feature_stone.data)
		--				!! replace_command.make (feature_element.data_container, rename_data, new_rename_data);
		--			end;
		--		end; 
		--	end; --| if cstone /= Void
		end;

feature {NONE} -- Implementation

	no_correct_target: BOOLEAN
			-- Is it still necessary to `set_entity' after the stone 
			-- processing that just occurred?
			--| Used only by `process_class' and `process_feature'.

feature {NONE} -- Inapplicable

    execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
        do
        end

invariant
	clickable_area_exists: clickable_area /= void

end -- class PROCESS_CLIKABLE_AREA
