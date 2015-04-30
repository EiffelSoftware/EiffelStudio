note
	description: "Describe content to be placed inside Regions."
	date: "$Date$"

deferred class
	CMS_BLOCK

inherit
	DEBUG_OUTPUT

feature -- Access

	name: READABLE_STRING_8
			-- Name identifying Current block.
		deferred
		end

	title: detachable READABLE_STRING_32
			-- Optional title.
		deferred
		end

	html_options: detachable CMS_HTML_OPTIONS
			-- Optional addition html options.

feature -- status report

	is_enabled: BOOLEAN
			-- Is current block enabled?

	is_raw: BOOLEAN
			-- Is raw?
			-- If True, do not get wrapped it with block specific div			
		deferred
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

	to_html (a_theme: CMS_THEME): STRING_8
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

end
