indexing
	description: "Objects that ..."
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
			Precursor (a_tool)
			
			Create {EB_TEXT_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_CLUSTERS_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_CLASS_LIST_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_CLUSTER_HIERARCHY_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_STATISTICS_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_MODIFIED_CLASSES_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_INDEXATION_FORMATTER} f.make (tool)
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
