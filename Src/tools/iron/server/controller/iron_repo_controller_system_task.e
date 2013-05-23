note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_CONTROLLER_SYSTEM_TASK

inherit
	IRON_REPO_CONTROLLER_TASK
		rename
			set_arguments as make
		end

create
	make

feature -- Access

	name: STRING = "system"

feature -- Execution

	is_available (iron: IRON_REPO): BOOLEAN
		do
			Result := True
		end

	execute (iron: IRON_REPO)
		do
			if attached arguments as args and then not args.is_empty then
				if args[1].is_case_insensitive_equal ("initialize") then
					initialize_database (iron)
					initialize_css_style (iron)
				elseif args[1].is_case_insensitive_equal ("init-db") then
					initialize_database (iron)
				elseif args[1].is_case_insensitive_equal ("dump") then
					if args.valid_index (2) then
						dump (iron.database, args[2])
					else
						io.error.put_string ("Error: 'dump' is missing argument%N")
					end
				elseif args[1].is_case_insensitive_equal ("load") then
					if args.valid_index (2) then
						load (iron.database, args[2])
					else
						io.error.put_string ("Error: 'load' is missing argument%N")
					end
				else
					io.error.put_string ("Error: '" + args[1]  + "' is not supported%N")
					display_help (iron)
				end
			else
					-- Display info
				print (iron.database.generating_type)
				display_help (iron)
			end
		end

	display_help (iron: IRON_REPO)
		do
			io.put_string ("Help for 'database' command:%N")
			io.put_string ("    initialize: Initialize repository%N")
			io.put_string ("    init-db: Initialize database%N")
			io.put_string ("    dump <output_folder>: dump db into folder%N")
			io.put_string ("    load <output_folder>: load db from folder%N")
		end

	dump (db: IRON_REPO_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'dump' not yet implemented%N")
		end

	load (db: IRON_REPO_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'load' not yet implemented%N")
		end

	initialize_database (a_iron: IRON_REPO)
		do
			if not a_iron.database.is_available then
				a_iron.database.initialize
			end
		end

	initialize_css_style (a_iron: IRON_REPO)
		local
			css: CSS_TEXT
			css_style: CSS_STYLE
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
		do
			if attached a_iron.basedir as p then
				-- Ensure folder exists
				create d.make_with_path (p.extended ("html"))
				if not d.exists then
					d.recursive_create_dir
				end
				create f.make_with_path (d.path.extended ("style.css"))
				if not f.exists then
					create css.make
					create css_style.make_with_string ("margin: 5px 0 5px 0")
					css_style.put_background_color ("#ddddff")
					css.add_selector_style ("body", css_style)

					create css_style.make
					css_style.put_key_value ("margin", "auto")
					css_style.put_width ("800px")
					css_style.put_height ("auto")
					css_style.put_border ("left", "solid", "1px", "#ccf")
					css_style.put_border ("right", "solid", "1px", "#ccf")
					css_style.put_background_color ("#fff")
					css.add_selector_style ("div#page", css_style)

					create css_style.make
					css_style.put_padding ("5px", "5px", "5px", "15px")
		--			css_style.put_border ("right", "solid", "1px", "#ccf")
					css.add_selector_style ("div#main", css_style)

					create css_style.make
		--			css_style.put_border ("right", "solid", "1px", "#ccf")
					css.add_selector_style ("#menu", css_style)


					create css_style.make
					css_style.put_text_decoration_none
					css_style.put_font_bold
					css_style.put_color ("#009")
					css.add_selector_style ("a", css_style)

					create css_style.make
					css_style.put_text_decoration_underline
					css.add_selector_style ("a:hover", css_style)

					create css_style.make_with_string ("[
									-webkit-border-radius: 20px;
									-webkit-border-top-left-radius: 0;
									-webkit-border-bottom-right-radius: 0;
									-moz-border-radius: 20px;
									-moz-border-radius-topleft: 0;
									-moz-border-radius-bottomright: 0;
									border-radius: 20px;
									border-top-left-radius: 0;
									border-bottom-right-radius: 0;
								]")
					css_style.append ("margin-bottom: 20px; padding: 20px; font-size: 140%%; border: solid 1px #00f; color: #fff; background-color: #009; text-align: center;")
					css_style.put_key_value ("position", "relative")
					css_style.put_margin_top ("30px")
					css_style.put_key_value ("top", "-20px")

					css.add_selector_style ("div#header", css_style)

					create css_style.make_with_string ("[
									-webkit-border-radius: 20px;
									-webkit-border-top-left-radius: 0;
									-webkit-border-top-right-radius: 0;
									-moz-border-radius: 20px;
									-moz-border-radius-topleft: 0;
									-moz-border-radius-topright: 0;
									border-radius: 20px;
									border-top-left-radius: 0;
									border-top-right-radius: 0;
								]")
					css_style.append ("border-top: dotted 1px #00f; background-color: #cfcfdf; text-align: center; min-height: 40px; padding: 5px;")
					css_style.put_key_value ("position", "relative")
			--			css_style.put_margin_top ("30px")
					css_style.put_key_value ("bottom", "-20px")

					css.add_selector_style ("div#footer", css_style)

					create css_style.make
					css_style.put_padding_left ("30px")
					css.add_selector_style ("ul", css_style)

					create css_style.make
					css_style.put_list_style ("none")
					css_style.put_border ("top", "solid", "1px", "#dedede")
					css_style.put_border ("left", "solid", "1px", "#dedede")
					css_style.put_padding ("4px", "5px", "5px", "4px")
					css_style.put_margin_bottom ("5px")
					css.add_selector_style ("ul li.package", css_style)

					create css_style.make
					css_style.put_padding ("3px", "3px", "3px", "3px")
					css_style.put_border (Void, "solid", "2px", "#00f")
					css.add_selector_style ("ul li.package:hover", css_style)

					create css_style.make_with_string ("padding-left: 25px")
					css.add_selector_style ("ul li.package div.description", css_style)
					css.add_selector_style ("ul li.package div.archive", css_style)

					css.add_selector_style (".error", "background-color: red")
					css.add_selector_style (".warning", "background-color: orange")
					css.add_selector_style (".dialog.message", "border: solid 1px #aa6; margin: 5px auto 5px auto; padding: 10px; width: 80%%; background-color: #ffc;")

					css.add_selector_style ("span.packageid", "float: right; font-style: italic; color: #ccc;")
					create css_style.make
					css_style.put_padding ("20px", "20px", "20px", "20px")
					css.add_selector_style ("div.description", css_style)

					css.add_selector_style ("ul.menu", "list-style-type: none")
					css.add_selector_style ("ul.menu li", "display: inline; border: solid 1px #900; padding: 2px 5px 2px 5px;")
					css.add_selector_style ("ul.menu li:hover", "background-color: #FF9")

					f.open_write
					f.put_string (css.string)
					f.close
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
