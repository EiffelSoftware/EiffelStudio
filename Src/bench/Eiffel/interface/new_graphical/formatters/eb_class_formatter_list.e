indexing
	description: "Implementation of EB_FORMAT_LIST for the $EiffelGraphicalCompiler$ Class Tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_FORMATTER_LIST

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
			
			create {EB_TEXT_FORMATTER} text_format.make (tool)
				-- should be EB_HTML_TEXT_FORMATTER
			add_formatter (text_format)
			create {EB_CLICKABLE_TEXT_FORMATTER} clickable_format.make (tool)
			add_formatter (clickable_format)
			create {EB_FLAT_FORMATTER} flat_format.make (tool)
			add_formatter (flat_format)
			create {EB_SHORT_FORMATTER} short_format.make (tool)
			add_formatter (short_format)
			create {EB_FLAT_SHORT_FORMATTER} f.make (tool)
			add_formatter (f)

		--	create {EB_ANCESTORS_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_DESCENDANTS_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_CLIENTS_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_SUPPLIERS_FORMATTER} f.make (tool)
		--	add_formatter (f)

		--	create {EB_ATTRIBUTES_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_ROUTINES_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_DEFERREDS_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_ONCES_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_EXTERNALS_FORMATTER} f.make (tool)
		--	add_formatter (f)
		--	create {EB_EXPORTED_FORMATTER} f.make (tool)
		--	add_formatter (f)

		end

feature -- Basic Operations

	enable_imp_formats_sensitive is
		do
			text_format.enable_sensitive
			clickable_format.enable_sensitive
			flat_format.enable_sensitive
		end

	disable_imp_formats_sensitive is
		do
			text_format.disable_sensitive
			clickable_format.disable_sensitive
			flat_format.disable_sensitive
		end

feature -- Constants

	text_format: EB_FORMATTER

	clickable_format: EB_FORMATTER

	flat_format: EB_FORMATTER

	short_format: EB_FORMATTER

	default_format: EB_FORMATTER is
		do
			Result := text_format
		end

	precompiled_default_format: EB_FORMATTER is
			-- Default format when implementation
			-- information is not avalible
			-- (by choice or because class is precompiled)
		do
			Result := short_format
		end

	implementation_related (f: EB_FORMATTER): BOOLEAN is
			-- Is `f' giving informations about implementation.
		do
			Result := (f = text_format) or else
				(f = clickable_format) or else
				(f = flat_format)
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
		--	Result.extend (5)
		--	Result.extend (9)
		end

	tool: EB_DEVELOPMENT_TOOL;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_CLASS_FORMATTER_LIST
