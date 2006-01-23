indexing
	description: "Print in output the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	PRINT_DISPLAY

inherit
	CACHE
	COLOR_CONSTANT
	FINDER
	TYPE_CACHE

create
	make

feature {NONE} -- Initialization

	make (an_output: EV_PIXMAP) is
			-- Initialiaze attributes with `a_parent_window'.
		require
			non_void_an_output: an_output /= Void
		do
			output := an_output
			--output.set_size (800, 800)
		ensure
			output_set: output = an_output
		end

feature -- Access

	output: EV_PIXMAP
			-- output to print type.

feature -- Basic Operations

	print_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_dotnet_type_name'
			-- Display in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
		do
			load_display_type (assembly_of_dotnet_type, a_dotnet_type_name)
			display
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
				set_factory_display (create {DISPLAY_TYPE_FACTORY}.make (create {SPECIFIC_TYPE}.make (assembly_of_dotnet_type, ct)))
				--set_factory_display (create {DISPLAY_TYPE_FACTORY}.make (create {SPECIFIC_TYPE}.make (assembly_of_type, ct)))
			end
		end

	display is
			-- display in `output' features previouly loaded in `factory_display'.
		require
			non_void_factory_display: factory_display /= Void
		local
			l_line: DISPLAYED_LINE
			l_entity: ENTITY_LINE
			cursor_y_position, cursor_x_position: INTEGER
			l_ico: EV_PIXMAP
		do
			output.clear
			cursor_x_position := 0
			cursor_y_position := 0
			from
				factory_display.lines.start
			until
				factory_display.lines.after
			loop
				l_line := factory_display.lines.item
--				if l_line.selected then
--					output.set_foreground_color (selected_feature_color)
--					output.fill_rectangle (cursor_x_position + horizontal_scroll_bar.value * Nb_pixel_decal_h_scroll, cursor_y_position, output.width, Nb_pixel_line)
--				end

				if not l_line.path_icon.is_empty then
					create l_ico
					l_ico.set_with_named_file (l_line.path_icon)
					output.draw_pixmap (cursor_x_position, cursor_y_position, l_ico)
				end

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
				cursor_x_position := 0
					
				factory_display.lines.forth
			end

			output.flush
		end
	
feature {NONE} -- Implementation

	Nb_pixel_line: INTEGER is
			-- number of pixel for a ligne.
		once
			Result := output.font.height + 4
		end
			
	Nb_pixel_decal_h_scroll: INTEGER is 12
			-- number of pixel for a step of horizontal scroll.

	nb_line_to_display: INTEGER is
			-- number of line in `factory_display' to display.
		do
			Result := (output.height / Nb_pixel_line).truncated_to_integer + 1
		end
		
invariant
	non_void_output: output /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PRINT_DISPLAY

