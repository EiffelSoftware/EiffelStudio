indexing
	description: "Print in output the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_TYPE_PRINTER

inherit
	CACHE_PATH
	CACHE

create
	make

feature {NONE} -- Initialization

	make (an_output: EV_PIXMAP; a_vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR; a_horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR) is
			-- Initialiaze `output' with `an_output'.
		require
			non_void_an_output: an_output /= Void
			non_void_a_vertical_scroll_bar: a_vertical_scroll_bar /= Void
			non_void_a_horizontal_scroll_bar: a_horizontal_scroll_bar /= Void
		do
			output := an_output
			vertical_scroll_bar := a_vertical_scroll_bar
			horizontal_scroll_bar := a_horizontal_scroll_bar
			create feature_selected.make_empty
		ensure
			output_set: output = an_output
			vertical_scroll_bar_set: vertical_scroll_bar = a_vertical_scroll_bar
			horizontal_scroll_bar_set: a_horizontal_scroll_bar = a_horizontal_scroll_bar
			non_void_feature_selected: feature_selected /= Void
		end

feature -- Access

	output: EV_PIXMAP
			-- output to print type.
			
	vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
			-- vertical scroll bar.

	horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
			-- horizontal scroll bar.

	assembly_of_type: CONSUMED_ASSEMBLY
			-- assembly where is located `dotnet_type_name'.
			
	dotnet_type_name: STRING
			-- dotnet type name to print.
			
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
			assembly_of_type := assembly_of_dotnet_type
			dotnet_type_name := a_dotnet_type_name
			feature_selected := ""
			internal_print_type
			refresh_allowed := True
		ensure
			assembly_of_type_set: assembly_of_type /= void
			dotnet_type_name_set: dotnet_type_name /= void
			feature_selected_set: feature_selected /= void and feature_selected.is_empty
		end

	print_type_with_feature_selected (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING; an_eiffel_feature_name: STRING) is
			-- set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- set `dotnet_type_name' with `a_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= void
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= void
			not_empty_an_eiffel_feature_name: not an_eiffel_feature_name.is_empty
		do
			assembly_of_type := assembly_of_dotnet_type
			dotnet_type_name := a_dotnet_type_name
			feature_selected := an_eiffel_feature_name
			internal_print_type
			refresh_allowed := True
		ensure
			assembly_of_type_set: assembly_of_type = assembly_of_dotnet_type
			dotnet_type_name_set: dotnet_type_name = a_dotnet_type_name
			feature_selected_set: feature_selected = an_eiffel_feature_name implies feature_selected.is_empty
		end

	refresh is
			-- Display in `output' the dotnet_type corresponding to `dotnet_type_name'.
		require
		do
			if refresh_allowed then
				internal_print_type
			end
		end
	
feature {NONE} -- Implementation

	internal_print_type is
			-- Print in `output' features corresponding to `dotnet_type_name'.
		local
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			a_file_name: STRING
		do
			output.clear
			create eac
			a_file_name := absolute_type_path (relative_assembly_path (assembly_of_type), dotnet_type_name)
			ct := eac.consumed_type (a_file_name)
			set_vertical_scrool_bar (ct)
			if ct /= Void then
				output.draw_text_top_left (current_character, current_line, ct.eiffel_name)
				new_line; new_line
				print_constructors (ct.constructors)
				print_attributes (ct.fields)
				print_procedures (ct.procedures)
				print_functions (ct.functions)
			end

		end

	print_procedures (array: ARRAY [CONSUMED_PROCEDURE]) is
			-- Return all signatures procedures contained in `array'.
		local
			i: INTEGER
			procedures: SORTABLE_ARRAY [COMPARABLE_CONSUMED_PROCEDURE]
		do
			output.set_foreground_color (title_color)
			output.draw_text_top_left (current_character, current_line, "Procedure(s) :")
			new_line
			from
				i := 1
				create procedures.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				procedures.put (create {COMPARABLE_CONSUMED_PROCEDURE}.make_with_consumed_procedure (array.item (i)), i)

				i := i + 1
			end
			
			from
				i := 1
				procedures.sort
			until
				i > procedures.count
			loop
				print_feature (procedures.item (i))
				new_line
				i := i + 1
			end
			new_line
		end

	print_feature (a_feature: CONSUMED_MEMBER) is
			-- Return feature's siganture without its returned_type contained in `a_feature'.
		require
			non_void_feature: a_feature /= Void
		local
			i: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
			font: EV_FONT
			output_string: STRING
		do
			font := output.font
			
			if a_feature.eiffel_name.is_equal (feature_selected) then
				output.draw_text_top_left (current_character, current_line, "=>  ")
				output.set_foreground_color (selected_feature_color)
				output.fill_rectangle (0, current_line, output.width, Nb_pixel_line)
			else
				output.draw_text_top_left (current_character, current_line, Tabulation)
			end
			current_character := current_character + font.string_width (Tabulation)

			output.set_foreground_color (dotnet_feature_color)
			output.draw_text_top_left (current_character, current_line, a_feature.dotnet_name)
			current_character := current_character + font.string_width (a_feature.dotnet_name)

			output.set_foreground_color (text_color)
			output.draw_text_top_left (current_character, current_line, " : ")
			current_character := current_character + font.string_width (" : ")

--			if current_character < Eiffel_name_tabulation then
--				current_character := Eiffel_name_tabulation
--			end
			
			output.set_foreground_color (eiffel_feature_color)
			output.draw_text_top_left (current_character, current_line, a_feature.eiffel_name)
			current_character := current_character + font.string_width (a_feature.eiffel_name)

			from
				i := 1
			until
				a_feature.arguments = Void
				or else i > a_feature.arguments.count 
			loop
				output.set_foreground_color (text_color)
				if i = 1 then
					output.draw_text_top_left (current_character, current_line, " (")
					current_character := current_character + font.string_width (" (")
				else
					output.draw_text_top_left (current_character, current_line, ", ")
					current_character := current_character + font.string_width (", ")
				end
	
				output.set_foreground_color (argument_color)
				output_string := a_feature.arguments.item (i).eiffel_name
				output.draw_text_top_left (current_character, current_line, output_string)
				current_character := current_character + font.string_width (output_string)

				output.set_foreground_color (text_color)
				output.draw_text_top_left (current_character, current_line, ": ")
				current_character := current_character + font.string_width (": ")

				l_argument := a_feature.arguments.item (i).type
				l_array_argument := Void
				l_array_argument ?= l_argument
					-- Is type argument NATIVE_ARRAY?
				if l_array_argument /= Void then
					output.set_foreground_color (type_color)
					output.draw_text_top_left (current_character, current_line, "NATIVE_ARRAY")
					current_character := current_character + font.string_width ("NATIVE_ARRAY")

					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, " [")
					current_character := current_character + font.string_width (" [")
					
					output.set_foreground_color (type_color)
					output_string := eiffel_type_name (l_array_argument.element_type.name)
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + font.string_width (output_string)

					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, "]")
					current_character := current_character + font.string_width ("]")
				else
					output.set_foreground_color (type_color)
					output_string := eiffel_type_name (l_argument.name)
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + font.string_width (output_string)
				end
				i := i + 1
			end
			if i /= 1 then
				output.set_foreground_color (text_color)
				output.draw_text_top_left (current_character, current_line, ")")
				current_character := current_character + font.string_width (")")
			end

--				-- Re-initilize background color to white
--			if a_feature.eiffel_name.is_equal (feature_selected) then
--				output.set_background_color (non_selected_feature_color)
--			end
		end
		
	print_constructors (array: ARRAY [CONSUMED_CONSTRUCTOR]) is
			-- Return all signatures constructors contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
			font: EV_FONT
			output_string: STRING
		do
			font := output.font
			
			output.set_foreground_color (Title_color)
			output.draw_text_top_left (current_character, current_line, "Creation routine(s) :")
			new_line
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				if feature_selected.is_equal (array.item (i).eiffel_name) then
					output.draw_text_top_left (current_character, current_line, "=>  ")
					output.set_foreground_color (selected_feature_color)
					output.fill_rectangle (0, current_line, output.width, Nb_pixel_line)
				else
					output.draw_text_top_left (current_character, current_line, Tabulation)
				end
				current_character := current_character + font.string_width (Tabulation)

				output.set_foreground_color (eiffel_feature_color)
				output_string := array.item (i).eiffel_name
				output.draw_text_top_left (current_character, current_line, output_string)
				current_character := current_character + font.string_width (output_string)
				from
					j := 1
				until
					array.item (i).arguments = Void
					or else j > array.item (i).arguments.count 
				loop
					output.set_foreground_color (text_color)
					if j = 1 then
						output.draw_text_top_left (current_character, current_line, " (")
						current_character := current_character + font.string_width (" (")
					else
						output.draw_text_top_left (current_character, current_line, ", ")
						current_character := current_character + font.string_width (", ")
					end
					output.set_foreground_color (argument_color)
					output_string := array.item (i).arguments.item (j).eiffel_name
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + font.string_width (output_string)

					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, ": ")
					current_character := current_character + font.string_width (": ")

					l_argument := array.item (i).arguments.item (j).type
					l_array_argument := Void
					l_array_argument ?= l_argument
						-- Is type argument NATIVE_ARRAY?
					if l_array_argument /= Void then
						output.set_foreground_color (type_color)
						output.draw_text_top_left (current_character, current_line, "NATIVE_ARRAY")
						current_character := current_character + font.string_width ("NATIVE_ARRAY")
						
						output.set_foreground_color (text_color)
						output.draw_text_top_left (current_character, current_line, " [")
						current_character := current_character + font.string_width (" [")
						
						output.set_foreground_color (type_color)
						output_string := eiffel_type_name (l_array_argument.element_type.name)
						output.draw_text_top_left (current_character, current_line, output_string)
						current_character := current_character + font.string_width (output_string)
						
						output.set_foreground_color (text_color)
						output.draw_text_top_left (current_character, current_line, "]")
						current_character := current_character + font.string_width ("]")
					else
						output.set_foreground_color (type_color)
						output_string := eiffel_type_name (l_argument.name)
						output.draw_text_top_left (current_character, current_line, output_string)
						current_character := current_character + font.string_width (output_string)
					end
					j := j + 1
				end
				if j /= 1 then
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, ")")
				end
				new_line
				
--					-- Re-initilize background color to white
--				if feature_selected.is_equal (array.item (i).eiffel_name) then
--					--output.flush
--					output.set_background_color (non_selected_feature_color)
--				end
				i := i + 1
			end
			new_line
		end

	print_functions (array: ARRAY [CONSUMED_FUNCTION]) is
			-- Return all signatures functions contained in `array'.
		local
			i: INTEGER
			signature_function: STRING
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
			functions: SORTABLE_ARRAY [COMPARABLE_CONSUMED_PROCEDURE]
			output_string: STRING
		do
			output.set_foreground_color (title_color)
			output.draw_text_top_left (current_character, current_line, "Function(s) :")
			new_line
			from
				i := 1
				create functions.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				functions.put (create {COMPARABLE_CONSUMED_PROCEDURE}.make_with_consumed_procedure (array.item (i)), i)

				i := i + 1
			end
			
			from
				i := 1
				functions.sort
			until
				i > functions.count
			loop
				print_feature (functions.item (i))
				
--				if feature_selected.is_equal (functions.item (i).eiffel_name) then
--					output.set_background_color (selected_feature_color)
--				end

				l_returned_type := functions.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					output.set_foreground_color (type_color)
					output.draw_text_top_left (current_character, current_line, ": NATIVE_ARRAY")
					current_character := current_character + output.font.string_width (": NATIVE_ARRAY")

					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, " [")
					current_character := current_character + output.font.string_width (" [")

					output.set_foreground_color (type_color)
					output_string := eiffel_type_name (l_array_returned_type.element_type.name)
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + output.font.string_width (output_string)

					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, "]")
					--current_character := current_character + output.font.string_width ("]")
				else
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, ": ")
					current_character := current_character + output.font.string_width (": ")

					output.set_foreground_color (type_color)
					output.draw_text_top_left (current_character, current_line, eiffel_type_name (l_returned_type.name))
					--current_character := current_character + output.font.string_width (eiffel_type_name (l_returned_type.name))
				end

--					-- Re-initialize background color to white.
--				if feature_selected.is_equal (functions.item (i).eiffel_name) then
--					output.set_background_color (non_selected_feature_color)
--				end
				new_line
				i := i + 1
			end
			
			new_line
		end

	print_attributes (array: ARRAY [CONSUMED_FIELD]) is
			-- Return all signatures attributes contained in `array'.
		local
			i: INTEGER
			signature_field: STRING
			attributes: SORTABLE_ARRAY [COMPARABLE_CONSUMED_FIELD]
			l_field: CONSUMED_FIELD
			l_constante_field: CONSUMED_LITERAL_FIELD
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
			output_string: STRING
		do
			output.set_foreground_color (title_color)
			output.draw_text_top_left (current_character, current_line, "Attribute(s) :")
			new_line
			from
				i := 1
				create attributes.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				attributes.put (create {COMPARABLE_CONSUMED_FIELD}.make_with_consumed_field (array.item (i)), i)

				i := i + 1
			end

			from
				i := 1
				attributes.sort
			until
				i > attributes.count
			loop
				if feature_selected.is_equal (attributes.item (i).eiffel_name) then
					output.draw_text_top_left (current_character, current_line, "=>  ")
					output.set_foreground_color (selected_feature_color)
					output.fill_rectangle (0, current_line, output.width, Nb_pixel_line)
				else
					output.draw_text_top_left (current_character, current_line, Tabulation)
				end
				current_character := current_character + output.font.string_width (Tabulation)

				output.set_foreground_color (dotnet_feature_color)
				output.draw_text_top_left (current_character, current_line, attributes.item (i).dotnet_name)
				current_character := current_character + output.font.string_width (attributes.item (i).dotnet_name)

				output.set_foreground_color (text_color)
				output.draw_text_top_left (current_character, current_line, ": ")
				current_character := current_character + output.font.string_width (": ")

				output.set_foreground_color (eiffel_feature_color)
				output.draw_text_top_left (current_character, current_line, attributes.item (i).eiffel_name)
				current_character := current_character + output.font.string_width (attributes.item (i).eiffel_name)
				
				l_returned_type := attributes.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					output.set_foreground_color (type_color)
					output.draw_text_top_left (current_character, current_line, ": NATIVE_ARRAY")
					current_character := current_character + output.font.string_width (": NATIVE_ARRAY")
					
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, " [")
					current_character := current_character + output.font.string_width (" [")
					
					output.set_foreground_color (type_color)
					output_string := eiffel_type_name (l_array_returned_type.element_type.name)
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + output.font.string_width (output_string)
					
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, "]")
					current_character := current_character + output.font.string_width ("]")
				else
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, ": ")
					current_character := current_character + output.font.string_width (": ")
					
					output.set_foreground_color (type_color)
					output_string := eiffel_type_name (l_returned_type.name)
					output.draw_text_top_left (current_character, current_line, output_string)
					current_character := current_character + output.font.string_width (output_string)
				end

				l_constante_field ?= l_field
					-- Is it a constante?
				if l_constante_field /= Void then
					output.set_foreground_color (text_color)
					output.draw_text_top_left (current_character, current_line, " is ")
					current_character := current_character + output.font.string_width ("is")
					
					output.set_foreground_color (constant_color)
					output.draw_text_top_left (current_character, current_line, l_constante_field.value)
					--current_character := current_character + output.font.string_width (l_constante_field.value)
				end
				
--					-- Re-initialize back_ground colr to white.
--				if feature_selected.is_equal (attributes.item (i).eiffel_name) then
--					output.set_background_color (non_selected_feature_color)
--				end
				new_line
				i := i + 1
			end
			
			new_line
		end

	eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		do
			if types.has (a_dotnet_type_name) then
				Result := types.item (a_dotnet_type_name)
			else
				Result := search_eiffel_type_name (a_dotnet_type_name)
			end
		ensure
			non_void_result: Result /= Void
		end
	
	search_eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			i, j: INTEGER
			eac: EAC_BROWSER
			l_file_name: STRING
			l_assembly_file_name: STRING
			referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			cat: CONSUMED_ASSEMBLY_TYPES
			l_dotnet_type_name: STRING
--			des_dlg: DESERIALIZATION_DLG
		do
			create eac
			l_file_name := absolute_referenced_assemblies_path (assembly_of_type)
			referenced_assemblies := eac.referenced_assemblies (l_file_name)

--			create des_dlg
--			des_dlg.show_modal_to_window (Current);
			(create {EV_ENVIRONMENT}).application.process_events
			from
				i := 1
			until
				referenced_assemblies = Void
				or else
				i > referenced_assemblies.assemblies.count --or Result /= Void
			loop
--				des_dlg.set_progress_bar ((i * 100 / referenced_assemblies.assemblies.count).rounded)
				
				l_assembly_file_name := absolute_info_assembly_path (referenced_assemblies.assemblies.item (i)) 
				cat := eac.consumed_assembly (l_assembly_file_name)
				from
					j := 1
				until
					cat = Void
					or else
					j > cat.dotnet_names.count --or Result /= Void
				loop
					l_dotnet_type_name := cat.dotnet_names.item (j)
					if l_dotnet_type_name /= Void and then l_dotnet_type_name.is_equal (a_dotnet_type_name) then
						Result := cat.eiffel_names.item (j)
					end
						-- Put in cache all type found
					if not types.has (l_dotnet_type_name) and then l_dotnet_type_name /= Void and then cat.eiffel_names.item (j) /= Void then
						types.extend (cat.eiffel_names.item (j), l_dotnet_type_name)
					end
					j := j + 1
				end
				i := i + 1
			end
--			des_dlg.destroy

			if Result = Void then
				Result := a_dotnet_type_name
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Scroolbar Setting

	set_vertical_scrool_bar (ct: CONSUMED_TYPE) is
			-- set vertical_bar.
		require
			non_void_consumed_type: ct /= Void
		local
			nb_line: INTEGER
			max_index_range: INTEGER
		do
			nb_line := ct.constructors.count + ct.fields.count + ct.procedures.count + ct.functions.count + 15
			max_index_range := (((nb_line * Nb_pixel_line) - output.height) / Nb_pixel_line).truncated_to_integer
			vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, max_index_range))

			if max_index_range <= 0 then
				current_line := 0
			else
				current_line := - vertical_scroll_bar.value * Nb_pixel_line
			end

			current_character := - horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll
--			vertical_scroll_bar.change_actions.force_extend (agent refresh)
		end
		
feature {NONE} -- Implementation

	title_color: EV_COLOR is
			-- foreground color of titles (attributes, procedures, creation routines, functions).
		once
			create Result.make_with_8_bit_rgb (0, 0, 255) 
		ensure
			result_set: Result /= Void
		end

	type_color: EV_COLOR is
			-- foreground color of types.
		once
			create Result.make_with_8_bit_rgb (125, 125, 0) 
		ensure
			result_set: Result /= Void
		end

	eiffel_feature_color: EV_COLOR is
			-- foreground color of eiffel features name.
		once
			create Result.make_with_8_bit_rgb (0, 125, 0) 
		ensure
			result_set: Result /= Void
		end
		
	dotnet_feature_color: EV_COLOR is
			-- foreground color of dotnet features name.
		once
			create Result.make_with_8_bit_rgb (170, 0, 0) 
		ensure
			result_set: Result /= Void
		end

	argument_color: EV_COLOR is
			-- foreground color of arguments.
		once
			create Result.make_with_8_bit_rgb (0, 125, 0) 
		ensure
			result_set: Result /= Void
		end

	text_color: EV_COLOR is
			-- foreground color of text.
		once
			create Result.make_with_8_bit_rgb (0, 0, 0) 
		ensure
			result_set: Result /= Void
		end

	constant_color: EV_COLOR is
			-- foreground color of constants.
		once
			create Result.make_with_8_bit_rgb (110, 0, 100) 
		ensure
			result_set: Result /= Void
		end

	selected_feature_color: EV_COLOR is
			-- background color of the selected feature.
		once
			create Result.make_with_8_bit_rgb (195, 195, 195) 
		ensure
			result_set: Result /= Void
		end
		
	non_selected_feature_color: EV_COLOR is
			-- background color of non selected features.
		once
			create Result.make_with_8_bit_rgb (255, 255, 255) 
		ensure
			result_set: Result /= Void
		end
		
feature {NONE} -- Implementation

--	Nb_pixel_police: INTEGER is
--			-- number of pixel for a ligne.
--		once
--			Result := output.font.height
--		end

	Nb_pixel_line: INTEGER is
			-- number of pixel for a ligne.
		once
			Result := output.font.height + 4
		end
			
	Nb_pixel_decal_h_scroll: INTEGER is 12
			-- number of pixel for a step of horizontal scroll.

	current_line: INTEGER
			-- current line.
	
	current_character: INTEGER
			-- current character.
			
	new_line is
			-- increment `current_ligne' with `nb_pixel_police'.
		do
			current_line := current_line + nb_pixel_line
			--current_character := 0
			current_character := - horizontal_scroll_bar.value * Nb_pixel_line
		ensure
			current_line_set: current_line = Old current_line + nb_pixel_line
		end
		
	Tabulation: STRING is "      "
			-- representation of a tabulation in spaces.
	
	Eiffel_name_tabulation: INTEGER is 120
			-- space in pixel where appear eiffel_name.
			
	titi: DISPLAY_TYPE_FACTORY
	
invariant
	non_void_output: output /= Void
	non_void_feature_selected: feature_selected /= Void
--	non_void_a_vertical_scroll_bar: vertical_scroll_bar /= Void
--	non_void_a_horizontal_scroll_bar: horizontal_scroll_bar /= Void

end -- class COLOR_TYPE_PRINTER

