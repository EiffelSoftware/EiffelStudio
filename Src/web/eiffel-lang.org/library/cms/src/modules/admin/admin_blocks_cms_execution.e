note
	description: "Summary description for {ADMIN_BLOCKS_CMS_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADMIN_BLOCKS_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
		do
			set_title ("Blocks")
			-- check Permission !!!
			create b.make_empty
			if has_permission ("administrate blocks") then
				b.append ("<ul id=%"block-list%">")
				across
					blocks as c
				loop
					if attached c.item as b_info then
						if b_info.block.is_enabled then
							b.append ("<li class=%"enabled%">")
						else
							b.append ("<li class=%"disabled%">")
						end
						b.append ("<strong>" + b_info.name + "</strong> (region=" + b_info.region + ")")
						if b_info.block.is_enabled then
							b.append (" [<a href=%"%">disable</a>]")
						else
							b.append (" [<a href=%"%">enable</a>]")
						end
						if attached b_info.block.title as l_title then
							b.append ("<div>title=<em>" + l_title + "</em></div>")
						end
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			else
				b.append ("<div class=%"denied%">Access denied</div>")
			end

			set_main_content (b)
		end

end
