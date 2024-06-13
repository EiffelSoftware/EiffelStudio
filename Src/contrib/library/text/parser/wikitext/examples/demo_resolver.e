note
	description: "[
			A custom resolver for many resources
			- Templates
				custom `{WIKI_TEMPLATE_RESOLVER}` to resolve {{template.name|parameters...}} wikitext templates
				such as
					{{rule| name=RuleName | text=Message}}
					{{SeeAlso | message ...}}
				See also: `{WIKI_XHTML_GENERATOR}.visit_template` for builtin TOC template. (Table Of Content)
			- Links
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO_RESOLVER

inherit
	WIKI_TEMPLATE_RESOLVER
		rename
			content as template_content
		end

	WIKI_LINK_RESOLVER
		rename
			wiki_url as wiki_link_url,
			missing_wiki_url as missing_wiki_link_url
		end

	WIKI_IMAGE_RESOLVER
		rename
			wiki_url as wiki_image_url,
			url as image_url
		end

	WIKI_FILE_RESOLVER

feature -- Links

	wiki_link_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the wiki link `a_link' in the context of `a_page'.
		do
			Result := "wiki/" + a_link.name
		end

feature -- Files

	file_to_url (a_file: WIKI_FILE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file `a_file' in the context of `a_page'.
		do
			if a_file.is_image then
				Result := "assets/" + a_file.name
			else
				Result := "files/" + a_file.name
			end
		end

feature -- Images

	wiki_image_url (a_image: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the wiki image `a_image' in the context of `a_page'.
		do
				-- When the image is clicked ... have a specific page to view/edit the image
			Result := "wiki-assets/" + a_image.name
		end

	image_url (a_image: WIKI_IMAGE_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the file associated with the wiki image `a_image', in the context of `a_page'.
		local
			n: STRING
		do
				-- For instance, the local images may be stored locally with lowercase name, without spaces replaced by '-',
				-- and as PNG image.
			n := a_image.name.as_lower
			n.replace_substring_all (" ", "-")
			n.append (".png")
			Result := "assets/" + n
		end

feature -- Templates

	template_content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Template content for `a_template' in the context of `a_page' if any.
		do
			if a_template.is_named ("rule") then
				Result := "%N%N'''Rule #{{{name}}}''': {{{text}}}%N"

			elseif a_template.is_named ("SeeAlso") then
				Result := "<div>'''SeeAlso''':%N{{{1}}}</div>%N"

			elseif a_template.is_named ("unknown") then
					-- Unknown template case.
					-- Ignore this one

			elseif a_template.is_named ("TOC") then
					-- Built-in template from WIKI_XHTML_GENERATOR
					-- returns Void.
			else
					-- Unknown templates
					-- Output the following default content (mostly for debugging purpose)
				Result := "Template#" + a_template.name + "%N1={{{1}}} %N2={{{2}}} %N3={{{3}}}%N"
			end
		end


end
