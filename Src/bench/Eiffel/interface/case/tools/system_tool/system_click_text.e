indexing

	description: 
		"Clickable area for the system window text area.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_CLICK_TEXT

inherit

	CLICKABLE_AREA
		redefine
			hole_command, process_class, process_cluster,
			compatible, process_element
		end

	FOCUS_LINE;

creation
	
	make

feature {NONE} -- Initialization

	make (a_name: STRING; sys: EC_SYSTEM_WINDOW) is
		do
	--		!! range.make ("rangeTextField", form);
	--		range.set_single_line_mode;
	--		range.set_read_only;
	--		range.set_background_color ( Resources.background_color )
--
	--		form.attach_left (Current, 0);
	--		form.attach_top (range, 0);
	--		form.attach_left (range, 0);
	--		form.attach_right (range,0)
	--		form.attach_right ( Current ,0)
	--		form.attach_top_widget (range, Current, 0);
	--		form.attach_bottom (Current, 0);
	--		system_window := sys
		end;

feature -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Is stone dropped compatible with Current hole?
		local
			st_type: INTEGER
		do
		--	st_type := dropped.stone_type;
		--	Result := st_type = Stone_types.class_type or else
		--		st_type = Stone_types.generic_type or else
		--		st_type = Stone_types.comment_type or else
		--		st_type = Stone_types.Description_type or else
		--		st_type = stone_types.cluster_type or else
		--		st_type = Stone_types.index_type
		end;

	system_window : EC_SYSTEM_WINDOW

	range: EV_TEXT;

	--form: FORM;

	hole_command: PROCESS_CLICK_TEXT_STONE
		-- Command associated to Current hole

feature -- Element change

	append_range (a_range: STRING) is
		do
		--	range.append (a_range);
		--	range.set_cursor_position (0);
		end;

feature -- Processing a drop 

	process_class (class_stone: CLASS_STONE) is
	do
	end

	process_element ( elem : ELEMENT_STONE ) is
		do
		--	Windows.namer_window.popup_at_current_position ( elem )	
		end
	
	process_cluster ( cluster_stone : CLUSTER_STONE ) is
	do
	end

feature -- Display

	show_chart_column is
			-- Show column for chart.
		do
			show_column;
		end;

	show_components_column is
			-- Show column for components.
		do
			show_column
		end;

	show_dictionary_column is
			-- Show column for dictionary.
		do
			show_column
		end;

	show_modified_column is
			-- Show column for modified classes
		do
			show_column
		end;

	clear_range is
		do
		--	range.clear;
		end;

	show_column is
			-- Show column.
		do
--			system_window.first_page_b.show
--			system_window.last_page_b.show
--			system_window.next_page_b.show 
--			system_window.previous_page_b.show
		end

	hide_column is 
			-- Hide all columns.
		do
--			system_window.first_page_b.hide
--			system_window.last_page_b.hide
--			system_window.next_page_b.hide  
--			system_window.previous_page_b.hide
		end

feature {NONE} -- Implementation

	focus_label: EV_LABEL is
			-- Label where focus_string is displayed
		do
--			Result := Windows.system_window.focus_label
		end;

end -- class SYSTEM_CLICK_TEXT
