indexing
	description: "Tool describing a cluster."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_TOOL

inherit
	EB_MULTIFORMAT_TOOL
		redefine
			set_stone,
			format_list
		end

creation
	make

feature {NONE} -- Initialization

	init_formatters is
			-- Create the list of formats,
			-- initialize default format values.
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

feature -- Access

	format_list: EB_CLUSTER_FORMATTER_LIST
			-- List of all formats, with the data used
			-- to build the associated toolbar.

feature -- Status report

	format_bar_is_used: BOOLEAN is False
			-- Do the tool need an effective format_bar?
			-- (a: No)

feature -- Status setting

	set_stone (s: like stone) is
			-- Make `s' the new value of stone.
		do
			Precursor (s)
--			update_cluster_name (s.cluster_name)
		end

	set_read_only is
			-- Set the class_tool as READ_ONLY
		do
			text_area.set_editable (False)
		end

feature {NONE} -- Implementation Graphical Interface

	build_toolbar (tb: EV_BOX) is
			-- Create edit toolbar items inside `tb'
		do
			create format_bar.make (tb)
		end

feature --

	close_windows is do end
	register is do end
	update is do end
	unregister is do end
	empty_tool_name: STRING is "Cluster tool"

end -- class EB_CLUSTER_TOOL
