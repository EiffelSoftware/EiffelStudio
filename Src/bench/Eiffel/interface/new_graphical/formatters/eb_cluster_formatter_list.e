indexing
	description:
		"Implementation of EB_FORMAT_LIST for %
			%the $EiffelGraphicalCompiler$ Cluster Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLUSTER_FORMATTER_LIST

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
			
			create {EB_CLASS_FILES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_CLUSTER_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_CLUSTER_INDEXATION_FORMATTER} f.make (tool)
			add_formatter (f)
		end

feature -- Constants

	default_format: EB_FORMATTER is
		do
			Result := first
		end

	text_format: EB_FORMATTER is
			-- No text format for the cluster tool
		do
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
		end

	tool: EB_CLUSTER_TOOL

end -- class EB_CLUSTER_FORMATTER_LIST
