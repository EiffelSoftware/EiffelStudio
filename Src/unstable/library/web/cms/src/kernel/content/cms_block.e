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

	conditions: detachable LIST [CMS_BLOCK_CONDITION]
			-- Optional block condition to be enabled.

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

	add_condition (a_condition: CMS_BLOCK_CONDITION)
			-- Add condition `a_condition'.
		local
			l_conditions: like conditions
		do
			l_conditions := conditions
			if l_conditions = Void then
				create {ARRAYED_LIST [CMS_BLOCK_CONDITION]} l_conditions.make (1)
				conditions := l_conditions
			end
			l_conditions.force (a_condition)
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

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
