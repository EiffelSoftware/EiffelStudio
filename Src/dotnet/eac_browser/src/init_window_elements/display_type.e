indexing
	description: "Print in output the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_TYPE

inherit
	CACHE
	COLOR_CONSTANT
	FINDER
	TYPE_CACHE

create
	make

feature {NONE} -- Initialization

	make (a_parent_window: MAIN_WINDOW_IMP) is
			-- Initialiaze attributes with `a_parent_window'.
		require
			non_void_a_parent_window: a_parent_window /= Void
		do
			parent_window := a_parent_window
			output := a_parent_window.color_edit_area
			vertical_scroll_bar := a_parent_window.l_vertical_scroll_bar_1
			horizontal_scroll_bar := a_parent_window.l_horizontal_scroll_bar_1
			create feature_selected.make_empty
		ensure
			parent_window_set: parent_window = a_parent_window
			output_set: output = a_parent_window.color_edit_area
			vertical_scroll_bar_set: vertical_scroll_bar = a_parent_window.l_vertical_scroll_bar_1
			horizontal_scroll_bar_set: horizontal_scroll_bar = a_parent_window.l_horizontal_scroll_bar_1
			non_void_feature_selected: feature_selected /= Void
		end

feature -- Access

	parent_window: MAIN_WINDOW_IMP
			-- parent window.

	output: EV_PIXMAP
			-- output to print type.
			
	vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
			-- vertical scroll bar.

	horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
			-- horizontal scroll bar.

	assembly_of_type: CONSUMED_ASSEMBLY
			-- assembly where is located `dotnet_type_name'.
			
	feature_selected: STRING
			-- feature selected. Empty if no feature selected.

	refresh_allowed: BOOLEAN
			-- Is there any type to refresh?

feature -- Basic Operations

	print_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
		do
--			if assembly_of_dotnet_type = assembly_of_type and then a_dotnet_type_name.is_equal (dotnet_type_name) then
--			else
				assembly_of_type := assembly_of_dotnet_type
--				dotnet_type_name := a_dotnet_type_name
				load_display_type (assembly_of_dotnet_type, a_dotnet_type_name)
--			end
			set_scroll_bares
			display
			refresh_allowed := True
		ensure
			assembly_of_type_set: assembly_of_type /= void
--			dotnet_type_name_set: dotnet_type_name /= void
			feature_selected_set: feature_selected /= void and feature_selected.is_empty
		end

	refresh is
			-- Display in `output' the dotnet_type corresponding to `factory_display'.
		require
		do
			if refresh_allowed then
				display
			end
		end

feature -- Status Setting

	set_feature_selected (an_eiffel_feature_name: STRING) is
			-- Set `feature_selected' with `an_eiffel_feature_name'.
		require
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
		do
			feature_selected := an_eiffel_feature_name
		ensure
			feature_selected_set: feature_selected = an_eiffel_feature_name
		end
		
	
feature {NONE} -- Implementation

	load_display_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- Print in `output' features corresponding to `dotnet_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
		local
			ct: CONSUMED_TYPE
			nt: CONSUMED_NESTED_TYPE
			eac: EAC_BROWSER
		do
			create eac
			ct := eac.consumed_type (assembly_of_dotnet_type, a_dotnet_type_name)
			if ct /= Void then
				set_factory_display (create {DISPLAY_TYPE_FACTORY}.make_with_selected_feature (create {SPECIFIC_TYPE}.make (assembly_of_dotnet_type, ct), feature_selected))
				--set_factory_display (create {DISPLAY_TYPE_FACTORY}.make (create {SPECIFIC_TYPE}.make (assembly_of_type, ct)))
			end
		end

	display is
			-- display in `output' features previouly loaded in `factory_display'.
		require
			non_void_factory_display: factory_display /= Void
		local
			i: INTEGER
			l_line: DISPLAYED_LINE
			l_entity: ENTITY_LINE
			cursor_y_position, cursor_x_position: INTEGER
		do
			output.clear
			
			cursor_y_position := 0
			cursor_x_position := - horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll

			from
				i := first_line_to_display
				factory_display.lines.go_i_th (first_line_to_display)
			until
				i > first_line_to_display + nb_line_to_display
				or i > factory_display.lines.count
			loop
				l_line := factory_display.lines.item
				if l_line.selected then
					output.set_foreground_color (selected_feature_color)
					output.fill_rectangle (cursor_x_position + horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll, cursor_y_position, output.width, Nb_pixel_line)
				end

--				if not l_line.path_icon.is_empty then
--					output.draw_text_top_left (cursor_x_position, cursor_y_position, l_line.path_icon)
--					cursor_x_position := cursor_x_position + (create {EV_FONT}).string_width (l_line.path_icon)
--				end

				from
					l_line.entities.start
				until
					l_line.entities.after
				loop
					l_entity := l_line.entities.item
					if l_entity /= Void then
						output.set_foreground_color (l_entity.foreground_color)
						output.set_font (l_entity.font)
						output.draw_text_top_left (cursor_x_position, cursor_y_position, l_entity.image)
						cursor_x_position := cursor_x_position + l_entity.font.string_width (l_entity.image)
					end
					l_line.entities.forth
				end
					--new_line
				cursor_y_position := cursor_y_position + nb_pixel_line
				cursor_x_position := - horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll
					
				factory_display.lines.forth
				i := i + 1
			end

				-- pick and drop actions.
			output.set_pebble_function (agent pick_action (?, ?))
			output.pick_ended_actions.wipe_out
			output.pick_ended_actions.force_extend (agent refresh)
			output.drop_actions.wipe_out
			output.drop_actions.extend (agent drop_action (?))
			
				-- mousse click actions.
--			output.pointer_button_press_actions.wipe_out
--			output.pointer_button_press_actions.force_extend (agent select_line_action (?, ?, ?, ?, ?, ?, ?, ?))
--			output.pointer_button_release_actions.wipe_out
--			output.pointer_button_release_actions.force_extend (agent select_line_action (?, ?, ?, ?, ?, ?, ?, ?))
			output.pointer_double_press_actions.wipe_out
			output.pointer_double_press_actions.force_extend (agent edit_action (?, ?, ?, ?, ?, ?, ?, ?))
			
			output.flush
		end

feature {NONE} -- Scroolbar Setting
	
	pick_action (a_x, a_y: INTEGER): SPECIFIC_TYPE is
			-- action performed for a pick action in `output'.
		local
			current_x_position, current_y_position: INTEGER
			i: INTEGER
			l_line: DISPLAYED_LINE
			l_entity: ENTITY_LINE
			l_data: CONSUMED_REFERENCED_TYPE
			eac: EAC_BROWSER
		do
			from
				i := first_line_to_display
				factory_display.lines.go_i_th (first_line_to_display)
				current_y_position := 0
			until
				i > first_line_to_display + nb_line_to_display
				or i > factory_display.lines.count
				or Result /= Void
			loop
				l_line := factory_display.lines.item
				from
					l_line.entities.start
					current_x_position := horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll
				until
					l_line.entities.after or Result /= Void
				loop
					l_entity := l_line.entities.item
					if l_entity /= Void then
						if current_y_position <= a_y and current_y_position + Nb_pixel_line >= a_y and
						   current_x_position <= a_x and current_x_position + l_entity.font.string_width (l_entity.image) >= a_x then
							l_data ?= l_entity.data
							if l_data /= Void then
								create eac
								Result := eac.find_consumed_type (assembly_of_type, l_data)
								output.set_foreground_color (Selected_feature_color)
								output.fill_rectangle (current_x_position, current_y_position, l_entity.font.string_width (l_entity.image), Nb_pixel_line)
								output.set_foreground_color (Text_color)
								output.draw_text_top_left (current_x_position, current_y_position, eiffel_type_name (assembly_of_type, l_data.name))
							end
						end
						current_x_position := current_x_position + l_entity.font.string_width (l_entity.image)
					end
					l_line.entities.forth
				end
					--new_line
				current_y_position := current_y_position + Nb_pixel_line
				factory_display.lines.forth
				i := i + 1
			end
		end

	drop_action (a_type: SPECIFIC_TYPE) is
			-- action performed when object is droped in output.
		local
			tree: TREE_FACTORY
		do
			vertical_scroll_bar.set_value (0)
			horizontal_scroll_bar.set_value (0)
			print_type (a_type.assembly, a_type.type.dotnet_name)

			create tree.make (parent_window)
			tree.expand_type (a_type.assembly, a_type.type)
		end

	edit_action (a_x, a_y, c: INTEGER; d, e, f: DOUBLE; g, h: INTEGER) is 
			-- action performed when double clicking.
		local
			current_x_position, current_y_position: INTEGER
			i: INTEGER
			l_line: DISPLAYED_LINE
			l_entity: ENTITY_LINE
			l_data: CONSUMED_MEMBER
			l_constructor_data: CONSUMED_CONSTRUCTOR
			stop: BOOLEAN
			edit_box: EDIT_FEATURE_BOX
		do
			from
				i := first_line_to_display
				factory_display.lines.go_i_th (first_line_to_display)
				current_y_position := 0
			until
				i > first_line_to_display + nb_line_to_display
				or i > factory_display.lines.count
				or stop
			loop
				l_line := factory_display.lines.item
				from
					l_line.entities.start
					current_x_position := horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll
				until
					l_line.entities.after or stop
				loop
					l_entity := l_line.entities.item
					if l_entity /= Void then
						if current_y_position <= a_y and current_y_position + Nb_pixel_line >= a_y and
						   current_x_position <= a_x and current_x_position + l_entity.font.string_width (l_entity.image) >= a_x then
							l_data ?= l_entity.data
							l_constructor_data ?= l_entity.data
							if l_data /= Void or l_constructor_data /= Void then
								create edit_box
--								edit_box.set_x_position (g - (a_x - current_x_position))
--								edit_box.set_y_position (h - (a_y - current_y_position))
								edit_box.set_x_position (g - (a_x - current_x_position) - 5)
								edit_box.set_y_position (h - (a_y - current_y_position) - 3)
								edit_box.set_width (l_entity.font.string_width (l_entity.image) + 10)
								edit_box.set_height (Nb_pixel_line - 8)
								edit_box.set_feature (l_entity.image)
								edit_box.show
								--edit_box.show_relative_to_window (parent_window)
								--edit_box.show_modal_to_window (parent_window)

								stop := True
							end
						end
						current_x_position := current_x_position + l_entity.font.string_width (l_entity.image)
					end
					l_line.entities.forth
				end
					--new_line
				current_y_position := current_y_position + Nb_pixel_line
				factory_display.lines.forth
				i := i + 1
			end
		end

	select_line_action (a_x, a_y, c: INTEGER; d, e, f: DOUBLE; g, h: INTEGER) is 
			-- action performed when double clicking.
			-- | loop on all lines and set selected to False except for the selected line.
		local
			current_y_position: INTEGER
			i: INTEGER
			l_line: DISPLAYED_LINE
			initial_cursor: CURSOR
		do
			initial_cursor := factory_display.lines.cursor
			
				-- lines above the displayed lines.
			from
				i := 1
				factory_display.lines.start
			until
				i = first_line_to_display
			loop
				factory_display.lines.item.set_selected (False)
				factory_display.lines.forth
				i := i + 1
			end
			
				-- displayed lines.
			from
				--i := first_line_to_display
				--factory_display.lines.go_i_th (first_line_to_display)
				current_y_position := 0
			until
				i > first_line_to_display + nb_line_to_display
				or factory_display.lines.after
			loop
				l_line := factory_display.lines.item
				if current_y_position <= a_y and current_y_position + Nb_pixel_line >= a_y then
					l_line.set_selected (True)
				else
					l_line.set_selected (False)
				end
					--new_line
				current_y_position := current_y_position + Nb_pixel_line
				factory_display.lines.forth
				i := i + 1
			end

				-- lines under the displayed lines.
			from
			until
				factory_display.lines.after
			loop
				factory_display.lines.item.set_selected (False)
				factory_display.lines.forth
				i := i + 1
			end
			factory_display.lines.go_to (initial_cursor)

			refresh
		end


	set_scroll_bares is
			-- set scroll bares.
		local
			nb_line, max_index_range: INTEGER
		do
			nb_line := factory_display.lines.count + (output.height / 2 / Nb_pixel_line).truncated_to_integer
			max_index_range := (((nb_line * Nb_pixel_line) - output.height) / Nb_pixel_line).truncated_to_integer
			vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, max_index_range))

----			max_index_range := ((nb_line * Nb_pixel_line) / output.height).truncated_to_integer
--			max_index_range := (((nb_line * Nb_pixel_line) - output.height) / Nb_pixel_line).truncated_to_integer
--			vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, max_index_range))
--			vertical_scroll_bar.set_leap (output.height)
----			vertical_scroll_bar.set_proportion (output.height / (nb_line * Nb_pixel_line))
--			vertical_scroll_bar.set_step (output.height)
		end		
		
feature {NONE} -- Implementation

	Nb_pixel_line: INTEGER is
			-- number of pixel for a ligne.
		once
			Result := output.font.height + 4
		end
			
	Nb_pixel_decal_h_scroll: INTEGER is 12
			-- number of pixel for a step of horizontal scroll.

	first_line_to_display: INTEGER is
			-- first line in `factory_display' to display.
		do
			if vertical_scroll_bar.value_range.upper = 0 then
				Result := 1
			else
				Result := vertical_scroll_bar.value + 1
			end
		end

	nb_line_to_display: INTEGER is
			-- number of line in `factory_display' to display.
		do
			Result := (output.height / Nb_pixel_line).truncated_to_integer + 1
		end
		
invariant
	non_void_parent_window: parent_window /= Void
	non_void_output: output /= Void
	non_void_feature_selected: feature_selected /= Void
	non_void_a_vertical_scroll_bar: vertical_scroll_bar /= Void
	non_void_a_horizontal_scroll_bar: horizontal_scroll_bar /= Void

end -- class DISPLAY_TYPE

