indexing
	description:
		"Command to make all elements in a dynamic_lib file clickable %
			%and to display the result in the dynamic_lib text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DYNAMIC_CLICKABLE_FORMATTER

inherit
	EB_FILTERABLE
		rename
			create_structured_text as clickable_context_text
		redefine
			tool, format, display_temp_header, display_header, post_fix 
		end
	EB_SHARED_FORMAT_TABLES

create

	make
	
feature -- Properties

	symbol: EV_PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Clickable 
		end
 
	tool: EB_DYNAMIC_LIB_TOOL
			-- Tool of edited dynamic_lib file

feature -- Formatting

	format is
			-- Show special format of tool stone in class text `text_area',
			-- if it's clickable do nothing otherwise.
		local
--			cur: CURSOR
			cur: INTEGER
			retried: BOOLEAN
--			mp: MOUSE_PTR
			d_stone: DYNAMIC_LIB_STONE
			wd: EV_WARNING_DIALOG
		do
			d_stone ?= tool.stone
			if d_stone /= Void then
				if not retried then
--					tool.close_search_dialog
					display_temp_header (d_stone)
--					create mp.set_watch_cursor
					cur := tool.text_area.position
	
--					if cur /= Void then
						tool.text_area.go_to (cur)
--					end
					tool.set_clickable (True)
					tool.display_clickable_dynamic_lib_exports (True)
					tool.set_last_format (Current)
	
					display_header (d_stone)
--					mp.restore
				else
--					if mp /= Void then
--						mp.restore
--					end
					create wd.make_with_text (Warning_messages.w_Cannot_retrieve_info)
					wd.show_modal
				end
			end
		rescue
--			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true
				retry
--			end
		end

feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Showclick
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showclick
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	title_part: STRING is
		do
			Result := Interface_names.t_Click_form_of
		end

	post_fix: STRING is "clk"

feature {NONE} -- Implementation

	display_header (stone: STONE) is
			-- Show header for 'stone'.
		local
			new_title: STRING
		do
			create new_title.make (50)
			new_title.append ("Clickable form ")
			new_title.append (stone.stone_signature)
			tool.set_title (new_title)
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			if tool.last_format = Current then
				tool.set_title ("Producing clickable format...")
			else
				tool.set_title ("Switching to clickable format...")
			end
		end

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

end -- class EB_DYNAMIC_CLICKABLE_FORMATTER
