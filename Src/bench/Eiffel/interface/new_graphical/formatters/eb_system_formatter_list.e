indexing
	description:
		"Implementation of EB_FORMAT_LIST for %
			%the $EiffelGraphicalCompiler$ System Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_FORMATTER_LIST

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
			create {EB_CLUSTERS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_CLASS_LIST_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_CLUSTER_HIERARCHY_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_STATISTICS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_MODIFIED_CLASSES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_INDEXATION_FORMATTER} f.make (tool)
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

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
		end

	tool: EB_SYSTEM_TOOL

end -- class EB_SYSTEM_FORMATTER_LIST
