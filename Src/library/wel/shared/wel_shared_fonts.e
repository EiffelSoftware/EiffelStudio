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
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
		once
			create system_parameter_info
			non_client_metrics := system_parameter_info.get_non_client_metrics
			create Result.make_indirect (non_client_metrics.message_font)
		end

	menu_font: WEL_FONT is
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
		once
			create system_parameter_info
			non_client_metrics := system_parameter_info.get_non_client_metrics
			create Result.make_indirect (non_client_metrics.menu_font)
		end

	status_font: WEL_FONT is
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
		once
			create system_parameter_info
			non_client_metrics := system_parameter_info.get_non_client_metrics
			create Result.make_indirect (non_client_metrics.status_font)
		end

	caption_font: WEL_FONT is
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
		once
			create system_parameter_info
			non_client_metrics := system_parameter_info.get_non_client_metrics
			create Result.make_indirect (non_client_metrics.caption_font)
		end

	small_caption_font: WEL_FONT is
		local
			system_parameter_info: WEL_SYSTEM_PARAMETERS_INFO
			non_client_metrics: WEL_NON_CLIENT_METRICS
		once
			create system_parameter_info
			non_client_metrics := system_parameter_info.get_non_client_metrics
			create Result.make_indirect (non_client_metrics.small_caption_font)
		end

end -- class WEL_SHARED_FONTS
