indexing
	description: "Implementation of EB_FORMAT_LIST for the EiffelBench Class Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_FORMATTER_LIST

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
			
			create {EB_TEXT_FORMATTER} f.make (tool)
				-- should be EB_HTML_TEXT_FORMATTER
			add_formatter (f)
			create {EB_CLICKABLE_TEXT_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_FLAT_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_SHORT_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_FLAT_SHORT_FORMATTER} f.make (tool)
			add_formatter (f)

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

feature -- Basic Operations

	set_implementation_formats_insensitive (flag: BOOLEAN) is
		do
			start
			item.launch_cmd.set_insensitive (flag)
			forth
			item.launch_cmd.set_insensitive (flag)
			forth
			item.launch_cmd.set_insensitive (flag)
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
			Result.extend (5)
			Result.extend (9)
		end

	tool: EB_CLASS_TOOL

end -- class EB_CLASS_FORMATTER_LIST
