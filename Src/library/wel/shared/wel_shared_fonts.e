indexing
	description: "Shared reference to predefined font object."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_FONTS

feature -- Access

	gui_font: WEL_DEFAULT_GUI_FONT is
			-- Default screen (WEL) font.
		once
			create Result.make
		ensure
			font_created: Result /= Void
		end

	system_font: WEL_SYSTEM_FONT is
			-- Default system font.
		once
			create Result.make
		ensure
			font_created: Result /= Void
		end

	message_font: WEL_FONT is
			-- Font used in message boxes
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: WEL_FONT
		do
			if message_font_cell.item = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.message_font)
				message_font_cell.put (loc_font)
			end
			Result := message_font_cell.item
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	menu_font: WEL_FONT is
			-- Font used in menus
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: WEL_FONT
		do
			if menu_font_cell.item = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.menu_font)
				menu_font_cell.put (loc_font)
			end
			Result := menu_font_cell.item
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	status_font: WEL_FONT is
			-- Font used in status bars
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: WEL_FONT
		do
			if status_font_cell.item = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.status_font)
				status_font_cell.put (loc_font)
			end
			Result := status_font_cell.item
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	caption_font: WEL_FONT is
			-- Caption font
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: WEL_FONT
		do
			if caption_font_cell.item = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create Result.make_indirect (non_client_metrics.caption_font)
				caption_font_cell.put (loc_font)
			end
			Result := caption_font_cell.item
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	small_caption_font: WEL_FONT is
			-- Small caption font
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: WEL_FONT
		do
			if small_caption_font_cell.item = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create Result.make_indirect (non_client_metrics.small_caption_font)
				small_caption_font_cell.put (loc_font)
			end
			Result := small_caption_font_cell.item
		ensure
			Result_exists: Result /= Void and then Result.exists
		end
		
feature {WEL_COMPOSITE_WINDOW}

	message_font_cell: CELL [WEL_FONT] is
			-- Container for `message_font'
		once
			create Result.put (Void)
		end

	menu_font_cell: CELL [WEL_FONT] is
			-- Container for `menu_font'
		once
			create Result.put (Void)
		end

	status_font_cell: CELL [WEL_FONT] is
			-- Container for `status_font'
		once
			create Result.put (Void)
		end

	caption_font_cell: CELL [WEL_FONT] is
			-- Container for `caption_font'
		once
			create Result.put (Void)
		end

	small_caption_font_cell: CELL [WEL_FONT] is
			-- Container for `small_caption_font'
		once
			create Result.put (Void)
		end

end -- class WEL_SHARED_FONTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

