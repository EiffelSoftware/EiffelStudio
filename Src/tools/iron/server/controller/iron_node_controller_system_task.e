note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_CONTROLLER_SYSTEM_TASK

inherit

	IRON_NODE_CONTROLLER_TASK
		rename
			set_arguments as make_with_arguments
		end

create
	make_with_arguments

feature -- Access

	name: STRING = "system"

feature -- Execution

	is_available (iron: IRON_NODE): BOOLEAN
		do
			Result := True
		end

	execute (iron: IRON_NODE)
		do
			if attached arguments as args and then args.valid_index (1) then
				if args [1].is_case_insensitive_equal ("initialize") then
					initialize_database (iron)
					initialize_css_style (iron)
					initialize_js (iron)
					initialize_folders (iron)
				elseif args [1].is_case_insensitive_equal ("init-db") then
					initialize_database (iron)
				elseif args [1].is_case_insensitive_equal ("status") then
					display_status (iron)
				elseif args [1].is_case_insensitive_equal ("dump") then
					if args.valid_index (2) then
						dump (iron.database, args [2])
					else
						io.error.put_string ("Error: 'dump' is missing argument%N")
					end
				elseif args [1].is_case_insensitive_equal ("load") then
					if args.valid_index (2) then
						load (iron.database, args [2])
					else
						io.error.put_string ("Error: 'load' is missing argument%N")
					end
				else
					io.error.put_string_32 ({STRING_32} "Error: '" + args [1] + "' is not supported%N")
					display_help (iron)
				end
			else
					-- Display info
--				print (iron.database.generating_type)
				display_help (iron)
			end
		end

	display_help (iron: IRON_NODE)
		do
			io.put_string ("Help for 'database' command:%N")
			io.put_string ("    status: reports status%N")
			io.put_string ("    initialize: Initialize repository%N")
			io.put_string ("    init-db: Initialize database%N")
			io.put_string ("    dump <output_folder>: dump db into folder%N")
			io.put_string ("    load <output_folder>: load db from folder%N")
		end

	display_status (iron: IRON_NODE)
			-- Display status on iron installation
		local
			l_statuses: ARRAYED_LIST [like folder_status]
			l_title_len: INTEGER
			s: STRING
		do
			create l_statuses.make (10)
			l_statuses.force (["is_available", iron.is_available.out, Void])
			l_statuses.force (["is_documentation_available", iron.is_documentation_available.out, Void])
			l_statuses.force (folder_status ("folder root", iron.layout.path, True, iron))
			l_statuses.force (folder_status ("folder repo", iron.layout.repo_path, True, iron))
			l_statuses.force (folder_status ("folder tmp", iron.layout.tmp_path, True, iron))
			l_statuses.force (folder_status ("folder www", iron.layout.www_path, True, iron))
			l_statuses.force (folder_status ("folder bin", iron.layout.binaries_path, True, iron))
			l_statuses.force (folder_status ("folder doc", iron.layout.documentation_path, False, iron))

			l_title_len := 0
			across
				l_statuses as ic
			loop
				l_title_len := l_title_len.max (ic.item.title.count)
			end

			create s.make_empty
			across
				l_statuses as ic
			loop
				if attached ic.item as e then
					io.put_string (e.title)
					s.wipe_out
					s.make_filled (' ', l_title_len - e.title.count)
					io.put_string (s)
					io.put_string (" = ")
					io.put_string (e.value)
					if attached e.error as err then
						io.put_string (" [error:")
						io.put_string_32 (err)
						io.put_string (" ]")
					end
					io.put_new_line
				end
			end
		end

	folder_status (a_title: READABLE_STRING_8; p: PATH; is_required_flag: BOOLEAN; iron: IRON_NODE): TUPLE [title: READABLE_STRING_8; value: READABLE_STRING_8; error: detachable READABLE_STRING_32]
		local
			ut: FILE_UTILITIES
			v: STRING
			err: detachable STRING_32
		do
			create v.make_empty
			if ut.directory_path_exists (p) then
				if is_required_flag then
					v.append ("OK ")
				end
				v.append ("exists")
			else
				if is_required_flag then
					v.append ("ERROR ")
					create err.make_from_string ({STRING_32} "Path %""+ p.name + {STRING_32} "%" is missing")
				end
				v.append ("missing")
			end
			Result := [a_title, v, err]
		end

	dump (db: IRON_NODE_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'dump' not yet implemented%N")
		end

	load (db: IRON_NODE_DATABASE; fn: IMMUTABLE_STRING_32)
		do
			io.error.put_string ("Error: 'load' not yet implemented%N")
		end

	initialize_database (a_iron: IRON_NODE)
		do
			if not a_iron.database.is_available then
				a_iron.database.initialize
			end
		end

	initialize_folders (a_iron: IRON_NODE)
		local
			d: DIRECTORY
		do
			create d.make_with_path (a_iron.layout.tmp_path)
			if not d.exists then
				d.recursive_create_dir
			end
		end

	initialize_css_style (a_iron: IRON_NODE)
		local
			css: CSS_TEXT
			css_style: CSS_STYLE
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
		do
				-- Ensure folder exists
			create d.make_with_path (a_iron.layout.www_path)
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
					--					css_style.put_margin_top ("30px")
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
				create css_style.make
				css_style.put_border (Void, "solid", "1px", "#ddd")
				css_style.put_padding ("2px", "2px", "2px", "15px")
				css.add_selector_style (".package-index li", css_style)
				css.add_selector_style (".package-index li .packageid", "display: none")
				create css_style.make
				css_style.put_border ("left", "solid", "10px", "#ddf")
				css_style.put_padding ("2px", "2px", "2px", "5px")
				css_style.put_background_color ("#fafaff")
				css.add_selector_style (".package-index li.package-folder-inline", css_style)
				css.add_selector_style (".package-index li.package-folder-inline:after", "content: %" ...%"")
				f.open_write
				f.put_string (css.string)
				f.close
			end
		end

	initialize_js (a_iron: IRON_NODE)
		local
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
		do
				-- Ensure folder exists
			create d.make_with_path (a_iron.layout.www_path)
			if not d.exists then
				d.recursive_create_dir
			end
			create f.make_with_path (d.path.extended ("iron.js"))
			if not f.exists then
				f.open_write
				f.put_string ("[
						/* IRON javascript */
					]")
				f.close
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
