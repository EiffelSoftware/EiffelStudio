note
	description: "Shared reference to predefined font object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_FONTS

feature -- Access

	gui_font: WEL_DEFAULT_GUI_FONT
			-- Default screen (WEL) font.
		once
			create Result.make
		ensure
			font_created: Result /= Void
		end

	system_font: WEL_SYSTEM_FONT
			-- Default system font.
		once
			create Result.make
		ensure
			font_created: Result /= Void
		end

	message_font: WEL_FONT
			-- Font used in message boxes
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: detachable WEL_FONT
		do
			loc_font := message_font_cell.item
			if loc_font = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.message_font)
				message_font_cell.put (loc_font)
			end
			Result := loc_font
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	menu_font: WEL_FONT
			-- Font used in menus
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: detachable WEL_FONT
		do
			loc_font := menu_font_cell.item
			if loc_font = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.menu_font)
				menu_font_cell.put (loc_font)
			end
			Result := loc_font
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	status_font: WEL_FONT
			-- Font used in status bars
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: detachable WEL_FONT
		do
			loc_font := status_font_cell.item
			if loc_font = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.status_font)
				status_font_cell.put (loc_font)
			end
			Result := loc_font
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	caption_font: WEL_FONT
			-- Caption font
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: detachable WEL_FONT
		do
			loc_font := caption_font_cell.item
			if loc_font = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.caption_font)
				caption_font_cell.put (loc_font)
			end
			Result := loc_font
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

	small_caption_font: WEL_FONT
			-- Small caption font
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
			loc_font: detachable WEL_FONT
		do
			loc_font := small_caption_font_cell.item
			if loc_font = Void then
				create system_parameter_info
				non_client_metrics := system_parameter_info.get_non_client_metrics
				create loc_font.make_indirect (non_client_metrics.small_caption_font)
				small_caption_font_cell.put (loc_font)
			end
			Result := loc_font
		ensure
			Result_exists: Result /= Void and then Result.exists
		end

feature {WEL_COMPOSITE_WINDOW}

	message_font_cell: CELL [detachable WEL_FONT]
			-- Container for `message_font'
		once
			create Result.put (Void)
		end

	menu_font_cell: CELL [detachable WEL_FONT]
			-- Container for `menu_font'
		once
			create Result.put (Void)
		end

	status_font_cell: CELL [detachable WEL_FONT]
			-- Container for `status_font'
		once
			create Result.put (Void)
		end

	caption_font_cell: CELL [detachable WEL_FONT]
			-- Container for `caption_font'
		once
			create Result.put (Void)
		end

	small_caption_font_cell: CELL [detachable WEL_FONT]
			-- Container for `small_caption_font'
		once
			create Result.put (Void)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SHARED_FONTS

