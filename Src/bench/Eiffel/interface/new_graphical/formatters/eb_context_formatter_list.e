indexing
	description: "Implementation of EB_FORMATTER_LIST for the $EiffelGraphicalCompiler$ Context Tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_FORMATTER_LIST

inherit
	EB_FORMATTER_LIST
		redefine
			make, tool
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- initialize the panel list
		local
			f : EB_FORMATTER
		do
			Precursor {EB_FORMATTER_LIST} (a_tool)
			
			create {EB_ANCESTORS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_DESCENDANTS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_CLIENTS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_SUPPLIERS_FORMATTER} f.make (tool)
			add_formatter (f)

			create {EB_ATTRIBUTES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_ROUTINES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_DEFERREDS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_ONCES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_EXTERNALS_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_EXPORTED_FORMATTER} f.make (tool)
			add_formatter (f)
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
			Result.extend (4)
		end

	tool: EB_CONTEXT_VIEW

	text_format: EB_FORMATTER

	default_format: EB_FORMATTER is
		do
			Result := first
		end

end -- class EB_CONTEXT_FORMATTER_LIST

