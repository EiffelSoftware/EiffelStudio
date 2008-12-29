note
	description: "XML related constants used in customized formatter/tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

inherit
	EB_METRIC_XML_CONSTANTS

feature -- Access

	n_formatters: STRING = "formatters"
	n_formatter: STRING = "formatter"
	n_header: STRING = "header"
	n_temp_header: STRING = "temp_header"
	n_pixmap: STRING = "pixmap"
	n_tooltip: STRING = "tooltip"
	n_viewer: STRING = "viewer"
	n_tools: STRING = "tools"
	n_tool: STRING = "tool"
	n_sorting_order: STRING = "sorting_order"
	n_stone: STRING = "stone"
	n_handlers: STRING = "handlers"
	n_handler: STRING = "handler"
	n_default_tool: STRING = "default_tool"

	t_formatters: INTEGER = 2001
	t_formatter: INTEGER = 2002
	t_tooltip: INTEGER = 2004
	t_header: INTEGER = 2005
	t_temp_header: INTEGER = 2006
	t_tools: INTEGER = 2008
	t_tool: INTEGER = 2011
	t_handlers: INTEGER = 2012
	t_handler: INTEGER = 2013

	at_viewer: INTEGER = 2053
	at_sorting_order: INTEGER = 2054
	at_stone: INTEGER = 2055
	at_default_tool: INTEGER = 2056

feature -- Stone names

	n_feature_stone: STRING = "feature"
	n_uncompiled_class_stone: STRING = "uncompiled class"
	n_compiled_class_stone: STRING = "compiled class"
	n_group_stone: STRING = "group"
	n_target_stone: STRING = "target"

end
