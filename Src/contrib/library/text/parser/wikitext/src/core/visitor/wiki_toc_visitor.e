note
	description: "Visitor used when building TOC = Table of Content."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TOC_VISITOR

inherit
	WIKI_ITERATOR
		redefine
			visit_template,
			visit_magic_word,
			visit_section
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create all_sections.make (0)
			create root_section_node.make (Void)
			last_section_node := root_section_node
		end

feature -- Access

	root_section_node: WIKI_SECTION_NODE

	sections: ARRAYED_LIST [WIKI_SECTION]
		do
			if depth_limit > 0 then
				create Result.make (all_sections.count)
				across
					all_sections as ic
				loop
					if ic.item.level <= depth_limit then
						Result.force (ic.item)
					end
				end
			else
				Result := all_sections
			end
		end

	auto_toc_disabled: BOOLEAN

	has_toc_location: BOOLEAN

	depth_limit: NATURAL_8
			-- Limit the depth of the TOC.
			-- Applied only if > 0.

	style: detachable IMMUTABLE_STRING_8
			-- Optional style.

feature -- Settings

	is_horizontal: BOOLEAN
			-- Is horizontal TOC?
			-- Relevant, only after call to `import_settings_from'.

feature {NONE} -- Settings

	last_section_node: WIKI_SECTION_NODE

	all_sections: ARRAYED_LIST [WIKI_SECTION]

	is_per_toc_settings: BOOLEAN
			-- Is current settings for a specific item?

	initial_depth_limit: NATURAL_8

feature -- Status report

	has_auto_generated_toc: BOOLEAN
			-- Should TOC be automatically generated?
			-- (i.e at least 4 headings, and no __NOTOC__ found.)
		do
			Result := not auto_toc_disabled  	-- No __NOTOC__ found
					and all_sections.count > 3		-- at least 4 headings
					and not has_toc_location	-- no __TOC__ relocating the TOC.
		end

feature -- Element change

	import_settings_from (a_wiki: WIKI_ITEM)
		do
			is_per_toc_settings := True
			a_wiki.process (Current)
		end

	set_depth_limit (n: like depth_limit)
			-- Set `depth_limit' to `n'.
			-- If `n' is 0, no limit.
		do
			depth_limit := n
			initial_depth_limit := n
		end

	reset
		do
			is_per_toc_settings := False
			is_horizontal := False
			all_sections.wipe_out
			auto_toc_disabled := False
			has_toc_location := False
			depth_limit := initial_depth_limit
			create root_section_node.make (Void)
			last_section_node := root_section_node
		end

feature -- Visit

	visit_section (a_section: WIKI_SECTION)
		local
			t: WIKI_SECTION_NODE
		do
			if depth_limit = 0 or else a_section.level <= depth_limit then
				t := last_section_node.item_for_section (a_section)
				if t /= Void then
					last_section_node := t
					t.extend_section (a_section)
				end
				all_sections.force (a_section)
				Precursor (a_section)
			end
		end

	visit_magic_word (a_word: WIKI_MAGIC_WORD)
		do
			Precursor (a_word)
			if a_word.value.is_case_insensitive_equal_general ("NOTOC") then
				auto_toc_disabled := True
			elseif
				a_word.value.is_case_insensitive_equal_general ("TOC")
				or a_word.value.is_case_insensitive_equal_general ("Horizontal TOC")
			then
				has_toc_location := True
			end
		end

	visit_template (a_template: WIKI_TEMPLATE)
		do
			Precursor (a_template)
			if
				a_template.name.is_case_insensitive_equal_general ("TOC")
				or a_template.name.is_case_insensitive_equal_general ("Horizontal TOC")
			then
				has_toc_location := True
				if is_per_toc_settings then
					if
						attached a_template.parameter ("limit") as l_limit and then
						l_limit.is_natural_8
					then
						depth_limit := l_limit.to_natural_8
					end
					if attached a_template.parameter ("style") as l_style then
						create style.make_from_string (l_style)
					end
					is_horizontal := a_template.name.is_case_insensitive_equal_general ("Horizontal TOC")
				end
			elseif
				a_template.name.is_case_insensitive_equal_general ("TOC limit") and then
				attached a_template.parameters_text as l_limit and then
				l_limit.is_natural_8
			then
					-- Settings for auto TOC or __TOC__.
				if not is_per_toc_settings then
					-- Do not change depth limit of per toc settings!
					depth_limit := l_limit.to_natural_8
				end

			end
		end


note
	copyright: "2011-2017, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
