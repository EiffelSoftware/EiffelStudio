indexing
	description:
		"Implementation of EB_FORMAT_LIST for %
			%the EiffelBench Cluster Tool"
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
			Precursor (a_tool)
			
			create {EB_CLUSTERS_FORMATTER} f.make (tool)
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
