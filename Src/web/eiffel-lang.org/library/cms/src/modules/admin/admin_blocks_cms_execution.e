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

	blocks: ARRAYED_LIST [TUPLE [block: CMS_BLOCK; name: READABLE_STRING_8; region: READABLE_STRING_8]]
		do
			create Result.make (10)
			across
				regions as reg_ic
			loop
				across
					reg_ic.item.blocks as ic
				loop
					Result.force ([ic.item, ic.item.name, reg_ic.item.name])
				end
			end
		end

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

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
