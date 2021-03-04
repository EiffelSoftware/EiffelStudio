note
	description: "[
			CMS text with smarty template text content.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SMARTY_TEMPLATE_TEXT

inherit
	ANY

	SHARED_TEMPLATE_CONTEXT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_source: like source)
			-- Create template text from `a_source`.
		do
			source := a_source
			create values.make (0)
		end

feature -- Access

	source: READABLE_STRING_8
			-- Template source.

	values: STRING_TABLE [detachable ANY]
			-- Additional value used during template output processing.

	value (k: READABLE_STRING_GENERAL): detachable ANY assign set_value
		do
			Result := values.item (k)
		end

feature -- Element change

	set_value (v: detachable ANY; k: READABLE_STRING_GENERAL)
			-- Associate value `v' with key `k'.
		do
			values.force (v, k)
		end

	unset_value (k: READABLE_STRING_GENERAL)
			-- Remove value indexed by key `k'.
		do
			values.remove (k)
		end

feature -- Conversion

	string: READABLE_STRING_8
			-- <Precursor>
		local
			tpl: detachable TEMPLATE_TEXT
			l_table_inspector: detachable STRING_TABLE_OF_STRING_INSPECTOR
		do
			template_context.disable_verbose
			debug ("cms")
				template_context.enable_verbose
			end

			create tpl.make_from_text (source)

			across
				values as ic
			loop
				tpl.add_value (ic.item, ic.key)
			end

			create l_table_inspector.register (({detachable STRING_TABLE [STRING_8]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [STRING_32]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [IMMUTABLE_STRING_8]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [IMMUTABLE_STRING_32]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_8]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_32]}).name)
			create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_GENERAL]}).name)
			tpl.get_structure
			tpl.get_output
			l_table_inspector.unregister
--			l_table32_inspector.unregister

			if attached tpl.output as l_output then
				Result := l_output
			else
				Result := source
			end
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
