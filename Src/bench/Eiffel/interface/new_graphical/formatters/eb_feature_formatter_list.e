indexing
	description: "Implementation of EB_FORMAT_LIST for the $EiffelGraphicalCompiler$ Feature Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_FORMATTER_LIST

inherit
	EB_FORMATTER_LIST
		redefine
			make, tool
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- initialize the panel list
		local
			f : EB_FORMATTER
		do
			Precursor {EB_FORMATTER_LIST} (a_tool)
			
			create {EB_TEXT_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_FEATURE_FLAT_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_BREAKPOINTS_FORMATTER} stop_points_format.make (tool)
			add_formatter (stop_points_format)

			create {EB_FEATURE_CALLERS_FORMATTER} show_callers_format.make (tool)
			add_formatter (show_callers_format)
			create {EB_FEATURE_HISTORY_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_PAST_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_FUTURE_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_HOMONYMS_FORMATTER} f.make (tool)
			add_formatter (f)

		end

feature -- Constants

	default_format: EB_FORMATTER is
		do
			Result := first
		end

	text_format: EB_FORMATTER is
		do
			Result := first
		end

	stop_points_format: EB_FORMATTER
			-- Format used for debugging

	show_callers_format: EB_FEATURE_CALLERS_FORMATTER
			-- Format used for displaying callers

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
			Result.extend (3)
		end

	tool: EB_FEATURE_TOOL

end -- class EB_FEATURE_FORMATTER_LIST
