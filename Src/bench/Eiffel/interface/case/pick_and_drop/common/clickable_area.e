indexing

	description: 
		"Scrolled text area that have clickable elements that %
		%can be dragged and dropped.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	CLICKABLE_AREA

inherit

	--SCROLLED_T
	--	rename
	--		make as text_create
	--	end;
	TEXT_AREA
		rename
			generate_class_feature_names  as actual_generate_class_feature_names,
			generate_feature_clause as actual_generate_feature_clause,
			generate_feature_names as actual_generate_feature_names,
			generate_modified_feature_names as actual_generate_modified_feature_names,
			generate_feature_clause_list as actual_generate_feature_clause_list
		redefine
			start_body, end_body,
			start_comment, end_comment
		end;
	TEXT_AREA
		redefine
			start_body, end_body,
			start_comment, end_comment,
			generate_class_feature_names,
			generate_feature_clause,
			generate_feature_clause_list,
			generate_feature_names,
			generate_modified_feature_names
		select
			generate_class_feature_names,
			generate_feature_clause,
			generate_feature_clause_list,
			generate_feature_names,
			generate_modified_feature_names
		end;
	DRAG_SOURCE
		redefine
			initial_x, initial_y--, update_before_transport,
			--update_after_transport 
		end;
	EC_COMMAND
				--%%% should be a client, not an heir...
		rename
			compatible as unused_compatible,
			stone as unused_stone,
			stone_type as unused_stone_type
		redefine
		--	context_data_useful
		end;
	ONCES;

	HOLE
		rename
			command as hole_command
		redefine
			hole_command
		end

feature -- Initialization 

	--init (a_parent: COMPOSITE; n: INTEGER) is
	--		-- Create current with parent `a_parent' with
	--		-- initial click structure number of `n'.
	--	do
	--		!! hole_command.make (Current)
	--		text_create (Widget_names.text, a_parent);
	--		set_text ("");
	--		set_read_only;
	--		!! click_struct.make (1, n);
	--		initialize_transport;
	--		set_action ("!Ctrl<Btn3Down>", Current, new_tooler);
	--		set_action ("!Ctrl<Btn1Down>", Current, control_select);
	--		set_action ("!Shift<Btn3Down>", Current, namer);
	--	--	set_action ("<Btn1Down>(2+)", Current, namer ) -- pascalf
	--		!! data_zones.make
	--	end;

feature -- Properties

	feature_clause_at_position (pos: INTEGER): FEATURE_CLAUSE_DATA is
			-- Feature clause to which position `pos' belongs
			--| Void if `position' is not in a feature clause
		do
			Result := data_zones.feature_clause_at_position (pos)
		end

	hole_command: PROCESS_CLICKABLE_AREA_STONE
			-- Command associated to Current hole

	initial_x: INTEGER is
			-- Initial x coordinate for drag
		do
		--	Result := x_coordinate (focus_start) + real_x;
		end;

	initial_y: INTEGER is
			-- Initial y coordinate for drag
		do
		--	Result := y_coordinate (focus_start) + real_y;
		end;

	i_th_feature_clause (i: INTEGER): like feature_clause_at_position is
			-- I_th feature clause in Current page
			-- Void if less than `i' feature clauses
		require
			positive_i: i > 0
		do
			Result := data_zones.i_th_feature_clause (i)
		end

	source: EV_WIDGET is
			-- Source widget for drag
		do
		--	Result := Current
		end;

	stone: STONE;
			--%%% should be in the command
			-- Stone found after search

	special_string (str: STRING): STRING is
			-- Special string representation of additional symbols 
			-- contained by `str'.
			--| For Current, simply returns `str' as is. 
		do
			Result := str
		end

	target: EV_WIDGET is
			-- Target widget for stone to be dropped on
		do
		--	Result := Current
		end;

	text_position: INTEGER;
			-- Current position in the structured document text

feature -- Element change

	append_character (c: CHARACTER) is
			-- Add `c' to the text imaage
		do
			append_tabs;
			image.extend (c);
			text_position := text_position + 1;
		end;

	append_clickable_string (a_stone: STONE; a_string: STRING) is
			-- Add `stone_string' to the text image and record `a_stone' as clickable.
		local
			p: CLICK_STONE;
			length: INTEGER;
		do
		--	append_tabs;
		--	image.append (a_string);
		--	length := a_string.count;
		--	!! p.make (a_stone, text_position, text_position + length);
		--	click_struct.put_right (p);
		--	text_position := text_position + length;
		end;

	append_space is
			-- Append space.
		do
			append_tabs;
			image.extend (space_character);
			text_position := text_position + 1;
		end;

	append_keyword, append_string, append_comment_string (s: STRING) is
			-- Add `s' to the text image, don't record it in internal structure.
		do
			append_tabs;
			image.append (s);
			text_position := text_position + s.count;
		end;

	end_body (a_stone: STONE) is
			-- Create clickable stone for routine body
		local
			s: CLICK_STONE;
			length: INTEGER;
		do
		--	!! s.make (a_stone, start_body_position, text_position);
		--	click_struct.put_right (s);
		end;

	end_comment (a_stone: STONE) is
			-- Create clickable stone for comment
		local
			p: CLICK_STONE;
			length: INTEGER;
		do
		--	!! p.make (a_stone, start_comment_position, text_position);
		--	click_struct.put_right (p);
		end;

	generate_class_feature_names (class_data: CLASS_DATA) is
			-- Generate names of the features of `class_data'
		do
			reset_data_zones
			actual_generate_class_feature_names (class_data)
		end

	generate_feature_clause (fc: FEATURE_CLAUSE_DATA; is_spec: BOOLEAN ) is
			-- Generate feature clause `fc' of `class_data'
		local
			start_position, end_position: INTEGER
		do
		--	start_position := text_position
		--	actual_generate_feature_clause (fc, is_spec )
		--	end_position := text_position
		--	record_data_zone (fc, start_position, end_position)
		end

	generate_feature_clause_list (fcl: FEATURE_CLAUSE_LIST; is_spec: BOOLEAN ) is
			-- Generate the feature clause list `fcl' of `class_data'
		do
			reset_data_zones
			actual_generate_feature_clause_list (fcl, is_spec )
		end

	generate_feature_names (fc: FEATURE_CLAUSE_DATA) is
			-- Generate names of the features in feature clause `fc'
		local
			start_position, end_position: INTEGER
		do
		--	start_position := text_position
		--	actual_generate_feature_names (fc)
		--	end_position := text_position
		--	record_data_zone (fc, start_position, end_position)
		end

	generate_modified_feature_names (fc: FEATURE_CLAUSE_DATA) is
			-- Generate the names of midified features of feature clause `fc'
		local
			start_position, end_position: INTEGER
		do
	--		start_position := text_position
	--		actual_generate_modified_feature_names (fc)
	--		end_position := text_position
	--		record_data_zone (fc, start_position, end_position)
		end

	new_line is
			-- Append new_line to stream.
		do
			image.extend ('%N');
			text_position := text_position + 1;
			emitted_tabs := False;
		end;

	--record_data_zone (data: DATA; sp, ep: like cursor_position) is
	--		-- Record `data' and its start position `sp' and
	--		-- end position `ep'
	--	local
	--		zone: DATA_TEXT_ZONE
	--	do
	--		!! zone.make (data, sp, ep)
	--		data_zones.add (zone)
	--	end

	reset_cursor_position is
			-- Reset the cursor position to zero.
		do
	--		set_cursor_position (0);
	--	ensure
	--		cursor_pos_is_zero: cursor_position = 0
		end;

	reset_data_zones is
			-- Remove all data zones previously recorded
		do
			data_zones.wipe_out
			check
				zones_reset: data_zones.empty
			end
		end

	start_body is
			-- Start routine body and mark position.
		do
			start_body_position := text_position;
		ensure then
			start_body_position_marked: start_body_position = text_position
		end;

	start_comment is
			-- Start comment and mark position.
		do
			start_comment_position := text_position;
		ensure then
			start_comment_position_marked: start_comment_position = text_position
		end;

feature -- Removal

	wipe_out is
			-- Wipe out the clickable structs.
		do
			tabs := 0;
			image.wipe_out;
			click_struct.clear;
			text_position := 0;
			stone := Void;
		ensure
			structures_resetted: tabs = 0 and then
							image.empty and then
							text_position = 0 and then
							stone = Void
		end;

feature -- Output

	image: STRING is
			-- Textual image generated by `build_image'
		once
			!! Result.make (0)
		end; -- image

	space_character: CHARACTER is ' ';
			-- Space character

	tab_string: STRING is
			-- Tab string
		once
			!! Result.make (Resources.tab_length)
			Result.fill_blank;
		ensure
			valid_result: Result /= Void;
			Result_count_same_tab_length: Result.count = Resources.tab_length
		end;

feature -- Update

	update_text is
			-- Update the text in scrolled text.
		local
			pos: INTEGER
		do
-- 			set_editable;
-- 			if text.empty then
-- 				set_text (image);
-- 			elseif text.count /= image.count or else
-- 				not text.is_equal (image) 
-- 			then
-- 				pos := top_character_position;
-- 				replace (0, text.count, image);
-- 				if pos > text.count then
-- 					pos := text.count
-- 				end;
-- 				set_top_character_position (pos);
-- 			end;
-- 			set_read_only;
-- 		ensure
-- 			read_only: is_read_only
		end;

--	update_before_transport (bt_data: BUTTON_DATA) is
--			-- Update before transport.
--		require else
--			bt_data_exists: bt_data /= Void
--		local
--			cur_pos: INTEGER
--		do
--			cur_pos := character_position (bt_data.absolute_x - real_x,
--										bt_data.absolute_y - real_y);
--			update_focus (cur_pos);
--			if stone /= Void then
--				highlight_focus;
--			end
--		end;
--
--	update_after_transport (bt_data: BUTTON_DATA) is
--			-- Deselect data (if it is not Void).
--		do
--			deselect_all;
--			if focus_label /= Void then
--				focus_label.set_text ("");
--			end
--			stone := Void;
--		end;

feature -- Execution

	context_data_useful: BOOLEAN is True;

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
		--	c_stone: CLICK_STONE;
		--	bt_data: BUTTON_DATA;
		--	cur_pos: INTEGER;
		--	create_window: CREATE_EDITOR_WINDOW_COM;
		--	namable: NAMABLE;
		--	mod_data: MODIFY_DATA
		do
--			bt_data ?= context_data;
--			if arg = control_select then
--				c_stone := click_stone_at (bt_data);
--				if c_stone /= Void then
--					process_selected_stone (c_stone.stone);
--				else
--					deselect_all;
--					stone := Void;
--				end
--			elseif arg = namer then
--				c_stone := click_stone_at (bt_data);
--				if c_stone /= Void then
--					namable ?= c_stone.stone;
--					if namable /= Void then
--						update_before_transport (bt_data);
--						Windows.namer_window.popup_at_current_position (namable);
--						deselect_all;
--						stone := Void;
--					end;
--				end;
--			elseif arg = new_tooler then
--				update_before_transport (bt_data);
--				if stone /= Void then
--				--	!! create_window;
--					create_window.execute (stone.data);
--					deselect_all;
--					stone := Void;
--				end
--			end
		end;

feature {NONE} -- Implementation Properties

	click_struct: CLICK_STRUCT;
			-- Click structure holding clickable elements

	control_select, new_tooler, namer: ANY is
		once
			!! Result
		end;

 	data_zones: DATA_TEXT_ZONES
 			-- Zones in the text where data are displayed

	emitted_tabs: BOOLEAN;
			-- Has tabs been emitted

	focus_label: EV_LABEL is
			-- Focus label
		deferred
		end;

	focus_start, focus_end: INTEGER;
			-- Bounds of focus in the structured text

	start_body_position: INTEGER;
			-- Position at beginning of routine body

	start_comment_position: INTEGER;
			-- Position at start of comment

feature {PROCESS_CLICKABLE_AREA_STONE} -- Implementation

	--click_stone_at (bt_data: BUTTON_DATA): CLICK_STONE is
	--	require
	--		valid_bt_data: bt_data /= Void
	--	local
	--		cur_pos: INTEGER;
	--	do
	--		cur_pos := character_position (bt_data.absolute_x - real_x,
	--						bt_data.absolute_y - real_y);
	--		Result := click_struct.click_stone_at (cur_pos);
	--	end;

feature {NONE} -- Implementation

	append_tabs is
		local
			i: INTEGER;
			tab: like tab_string
		do
			if not emitted_tabs then
				tab := tab_string;
				from
					i := 1
				until
					i > tabs
				loop
					image.append (tab);
					text_position := text_position + tab.count;
					i := i + 1
				end
				emitted_tabs := True
			end;
		end;

	deselect_all is
		do
		--	if is_selection_active then
		--		clear_selection
		--	end
		end;

	process_selected_stone (st: STONE) is
		do
		end;

	update_focus (i: INTEGER) is
			-- Select the stone corresponding to text position `i'.
		local
			item: CLICK_STONE
		do
			--if click_struct.clickable_count /= 0 then
			--	click_struct.search_by_index (i);
			--	item := click_struct.current_item;
			--	stone := item.stone;
			--	set_bounds (item.start_position, item.end_position)
			--	--focus_label.set_text (data.focus);
			--else
			--	stone := void;
			--	--focus_label.set_text ("");
			--end
		end;

	highlight_focus is
		do
		--	deselect_all;
		--	set_selection (focus_start, focus_end);
		--	set_cursor_position (focus_start);
		end;

	set_bounds (a, b: INTEGER) is
			-- Set the bounds of current focus.
		do
			focus_start := a;
			focus_end := b
		end;

end -- class CLICKABLE_AREA

