indexing
	description: "XML related constants used in customized formatter/tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

inherit
	EB_METRIC_XML_CONSTANTS

feature -- Access

	n_formatters: STRING is "formatters"
	n_formatter: STRING is "formatter"
	n_header: STRING is "header"
	n_temp_header: STRING is "temp_header"
	n_pixmap: STRING is "pixmap"
	n_tooltip: STRING is "tooltip"
	n_viewer: STRING is "viewer"
	n_tools: STRING is "tools"
	n_tool: STRING is "tool"
	n_sorting_order: STRING is "sorting_order"
	n_stone: STRING is "stone"
	n_handlers: STRING is "handlers"
	n_handler: STRING is "handler"
	n_default_tool: STRING is "default_tool"

	t_formatters: INTEGER is 2001
	t_formatter: INTEGER is 2002
	t_tooltip: INTEGER is 2004
	t_header: INTEGER is 2005
	t_temp_header: INTEGER is 2006
	t_tools: INTEGER is 2008
	t_viewer: INTEGER is 2010
	t_tool: INTEGER is 2011
	t_handlers: INTEGER is 2012
	t_handler: INTEGER is 2013

	at_viewer: INTEGER is 2053
	at_sorting_order: INTEGER is 2054
	at_stone: INTEGER is 2055
	at_default_tool: INTEGER is 2056

feature -- Stone names

	n_feature_stone: STRING is "feature"
	n_uncompiled_class_stone: STRING is "uncompiled class"
	n_compiled_class_stone: STRING is "compiled class"
	n_group_stone: STRING is "group"
	n_target_stone: STRING is "target"

end
