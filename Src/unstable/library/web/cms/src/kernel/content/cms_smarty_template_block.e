note
	description: "[
			CMS block with smarty template file content.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SMARTY_TEMPLATE_BLOCK

inherit
	CMS_BLOCK
		redefine
			out
		select
			out
		end

	SHARED_TEMPLATE_CONTEXT
		rename
			out as tpl_out
		undefine
			is_equal
		end

create
	make,
	make_raw

feature {NONE} -- Initialization

	make (a_name: like name; a_title: like title; a_template_root_path: PATH; a_template_location: PATH)
			-- Create Current with `a_name', `a_title', `a_template_location'
			-- inside root directory `a_template_root_path' for the templates.
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			is_enabled := True
			name := a_name
			title := a_title
			location := a_template_location
			template_root_path := a_template_root_path
			create values.make (0)
		end

	make_raw (a_name: like name; a_title: like title; a_template_root_path: PATH; a_template_location: PATH)
			-- Create Current with `a_name', `a_title', `a_template_location'
			-- inside root directory `a_template_root_path' for the templates.
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			make (a_name, a_title, a_template_root_path, a_template_location)
			set_is_raw (True)
		end

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>

	location: PATH
			-- Location of template file.

	template_root_path: PATH
			-- Root location for templates universe.

	values: STRING_TABLE [detachable ANY]
			-- Additional value used during template output processing.

feature -- Status report

	is_empty: BOOLEAN = False
			-- Is current block empty?

	is_raw: BOOLEAN
			-- Is raw?
			-- If True, do not get wrapped it with block specific div	

feature -- Element change

	set_is_raw (b: BOOLEAN)
		do
			is_raw := b
		end

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

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

	informations: detachable TUPLE [location: PATH; utf_8_code: STRING_8; is_writable: BOOLEAN]
		local
			p: like location
			s: STRING_8
			f: PLAIN_TEXT_FILE
			l_is_writabe: BOOLEAN
		do
				-- Process html generation
			p := template_root_path.extended_path (location)
			create f.make_with_path (p)
			if f.exists then
				l_is_writabe := f.is_access_writable
				create s.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1024)
					s.append (f.last_string)
				end
				f.close
				Result := [p, s, l_is_writabe]
			end
		end

	to_html (a_theme: CMS_THEME): STRING_8
			-- <Precursor>
		local
			p: detachable PATH
			tpl: detachable TEMPLATE_FILE
			ut: FILE_UTILITIES
			n: STRING_32
			l_table_inspector: detachable STRING_TABLE_OF_STRING_INSPECTOR
		do
				-- Process html generation
			p := location
			if ut.file_path_exists (template_root_path.extended_path (p)) then
				n := p.name
				template_context.set_template_folder (template_root_path)
				template_context.disable_verbose
				debug ("cms")
					template_context.enable_verbose
				end

				create tpl.make_from_file (n)

				across
					values as ic
				loop
					tpl.add_value (ic.item, ic.key)
				end


				create l_table_inspector.register (({detachable STRING_TABLE [STRING_8]}).name)
				create l_table_inspector.register (({detachable STRING_TABLE [STRING_32]}).name)
				create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_8]}).name)
				create l_table_inspector.register (({detachable STRING_TABLE [READABLE_STRING_32]}).name)
				tpl.analyze
				tpl.get_output
				l_table_inspector.unregister
--				l_table32_inspector.unregister

				if attached tpl.output as l_output then
					Result := l_output
				else
					Result := ""
					debug ("cms")
						Result := "Template block #" + name
					end
				end
			else
				Result := ""
				debug ("cms")
					Result := "Template block #" + name
				end
			end
		end

feature -- Debug

	out: STRING
		local
			utf: UTF_CONVERTER
		do
			create Result.make_from_string (generator)
			Result.append ("%Nname:")
			Result.append (name)
			if attached title as l_title then
				Result.append ("%N%Ttitle:")
				Result.append (utf.string_32_to_utf_8_string_8 (l_title))
			end
			Result.append ("%Nlocation:")
			Result.append (location.out)
			Result.append ("%Ntemplate_root_path:")
			Result.append (template_root_path.out)
			Result.append ("%NValues: {")
			from
				values.start
			until
				values.after
			loop
				Result.append ("%NKey:")
				Result.append (utf.string_32_to_utf_8_string_8 (values.key_for_iteration))
				Result.append (" - Value:")
				if attached values.item_for_iteration as l_item then
					Result.append (l_item.out)
				end
				values.forth
			end
			Result.append ("%N}")
		end
note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
