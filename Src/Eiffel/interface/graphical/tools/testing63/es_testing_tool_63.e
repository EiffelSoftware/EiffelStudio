indexing
	description: "[
		Shim class for EiffelStudio's testing tool.
	]"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ES_TESTING_TOOL_63

inherit
	ES_STONABLE_TOOL [ES_TESTING_TOOL_PANEL_63]

create {NONE}
	default_create

feature -- Access

	title: STRING_32
			-- <Precursor>
		do
			Result :=  local_formatter.translation (t_title)
		end

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_external_output_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_external_output_icon
		end

feature {NONE} -- Status report

	internal_is_stone_usable (a_stone: !like stone): BOOLEAN
			-- <Precursor>
		do
			Result := {l_class_stone: CLASSC_STONE} a_stone
		end

feature {NONE} -- Factory

	create_tool: ES_TESTING_TOOL_PANEL_63
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_title: STRING = "Testing tool"

end
