indexing
	description: "Main window of server"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
	
class
	MAIN_WINDOW

inherit
	AUTOMATION_SERVER_MAIN_WINDOW
		redefine
			class_background,
			class_icon,
			on_paint,
			default_style
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end
		
creation
	make

feature -- Initialization

	make is
			-- Make the main window
		do
			make_top ("Analyzer Server")
			resize (400, 400)
			set_x (350)
			set_y (100)
			!! descriptions.make
			!! values.make
		end

feature -- Access
			
	descriptions: LINKED_LIST [STRING]
			-- Descriptions to be printed out
	
	values: LINKED_LIST [STRING]
			-- Values associated to `descriptions'
			
	default_style: INTEGER is
			-- Creation style
		once
			Result := Ws_overlapped + Ws_ex_clientedge
		end
	
feature -- Element Change

	add_line (description: STRING; value: INTEGER) is
			-- Add line into window's text
		local
			string_value: STRING
		do
			!! string_value.make (10)
			string_value.append_integer (value)
			descriptions.extend (description)
			values.extend (string_value)
			invalidate
		end
		
	paint_window (paint_dc: WEL_PAINT_DC) is
			-- Repaint window
		local
			index: INTEGER
			log_font: WEL_LOG_FONT
			font: WEL_FONT
			space_height: INTEGER
			max_lines: INTEGER
		do
			!! log_font.make (14, "Arial")
			!! font.make_indirect (log_font)
			paint_dc.select_font (font)
			space_height := paint_dc.string_height (" ")
			font.delete
			max_lines := (client_rect.height / space_height).truncated_to_integer - 1
			from
				if descriptions.count - max_lines > 0 then
					descriptions.go_i_th (descriptions.count - max_lines + 1)
					values.go_i_th (values.count - max_lines + 1)
				else
					descriptions.start
					values.start
				end
			until
				descriptions.after
			loop
				paint_dc.text_out (2, index * space_height, descriptions.item)
				paint_dc.text_out (client_rect.width - paint_dc.string_width ("123456789"), index * space_height, values.item)
				index := index + 1
				descriptions.forth
				values.forth
			end
		end
			
feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw text
		do
			paint_window (paint_dc)
		end

	class_background: WEL_WHITE_BRUSH is
			-- White background
		once
			!! Result.make
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (1)
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
