note
	description: "Describe content to be placed inside Regions."
	date: "$Date$"

deferred class
	CMS_BLOCK

inherit
	CMS_BLOCK_SETUP
		undefine
			is_equal
		end

	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

feature -- Access

	name: READABLE_STRING_8
			-- Name identifying Current block.
		deferred
		end

	html_options: detachable CMS_HTML_OPTIONS
			-- Optional addition html options.

feature -- Status report

	is_empty: BOOLEAN
			-- Is current block empty?
		deferred
		end

	is_enabled: BOOLEAN
			-- Is current block enabled?

	is_raw: BOOLEAN
			-- Is raw?
			-- If True, do not get wrapped it with block specific div			
		deferred
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>.
		do
			Result := weight < other.weight
		end

feature -- Element change

	add_css_class (a_class: READABLE_STRING_8)
			-- Add css class `a_class'.
		local
			opts: like html_options
		do
			opts := html_options
			if opts = Void then
				create opts
				html_options := opts
			end
			opts.add_css_class (a_class)
		end

	remove_css_class (a_class: READABLE_STRING_GENERAL)
			-- Remove css class `a_class'.
		local
			opts: like html_options
		do
			opts := html_options
			if opts = Void then
				create opts
				html_options := opts
			end
			opts.remove_css_class (a_class)
		end

feature -- Conversion

	append_to_html (a_theme: CMS_THEME; a_output: STRING_8)
			-- Append HTML representation of Current block to `a_output'.
		do
			a_output.append (to_html (a_theme))
		end

	to_html (a_theme: CMS_THEME): READABLE_STRING_8
			-- HTML representation of Current block.
		deferred
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string_general ("Block")
			if is_raw then
				Result.append_string_general (" <raw>")
			end
			if not is_enabled then
				Result.append_string_general (" <disabled>")
			end
			Result.append_character (' ')
			Result.append_character ('[')
			Result.append_string_general (name)
			Result.append_character (']')
			if attached title as l_title then
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (l_title)
				Result.append_character ('%"')
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
