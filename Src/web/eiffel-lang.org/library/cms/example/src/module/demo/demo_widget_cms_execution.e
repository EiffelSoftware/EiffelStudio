note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DEMO_WIDGET_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
		local
			args: like arguments
			l_table: like new_table
			s: STRING
		do
			args := arguments
			if args.is_empty then
				set_title ("Widgets")
				set_main_content ("...")
			else

			end
			l_table := new_table

			create s.make_empty
			l_table.append_to_html (theme, s)
			set_main_content (s)
		end

	new_table: WSF_WIDGET_AGENT_TABLE [READABLE_STRING_8]
		local
			l_table: WSF_WIDGET_AGENT_TABLE [READABLE_STRING_8]
		do
			create l_table.make
			l_table.add_css_style ("width: 85%%; border: solid 1px #999; padding: 2px;")

			l_table.set_column_count (3)
			l_table.column (1).set_title ("First")
			l_table.column (2).set_title ("Second")
			l_table.column (3).set_title ("Third")

			l_table.column (1).add_css_style ("width: 20%%")
			l_table.column (2).add_css_style ("width: 40px")
			l_table.column (3).add_css_style ("width: 40px")

			l_table.set_data (<<"foo", "bar", "foobar">>)
			l_table.set_foot_data (<<"abc", "def">>)
			l_table.set_compute_item_function (agent (d: READABLE_STRING_8): WSF_WIDGET_TABLE_ROW
				local
					i: INTEGER
					w: WSF_WIDGET_TABLE_ITEM
				do
					create Result.make (d.count)
					if d.is_case_insensitive_equal ("bar") then
						Result.add_css_style ("background-color: #ccf;")
					end
					across
						d as c
					loop
						i := i + 1
						create w.make_with_text (c.item.out)
						if i = 1 then
							w.add_css_style ("background-color: #333; color: white; font-weight: bold;")
						elseif i > 3 then
							w.add_css_style ("color: red; border: solid 1px red; padding: 3px;")
						end
						Result.force (w)
					end
				end)

			Result := l_table
		end

	arguments: ARRAY [READABLE_STRING_32]
			-- Path parameters arguments related to {/vars}
		do
			if
				attached {WSF_TABLE} request.path_parameter ("args") as lst and then
				attached lst.as_array_of_string as arr
			then
				Result := arr
			else
				create Result.make_empty
			end

			Result.rebase (1)
		end

end
