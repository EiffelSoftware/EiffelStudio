note
	description: "[
		Objects that ...
	]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	BUILD_HTML_INDEX

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			ini_location: PATH
			icons_location: PATH
			output_location: PATH
			i,n: INTEGER
			s: READABLE_STRING_GENERAL
		do
			if argument_count >= 3 then
				create ini_location.make_from_string (argument (1))
				ini_location := ini_location.absolute_path.canonical_path

				create icons_location.make_from_string (argument (2))
				icons_location := icons_location.absolute_path.canonical_path

				create output_location.make_from_string (argument (3))
				output_location := output_location.absolute_path.canonical_path

				is_png_mode := False
				is_svg_mode := False
				check is_svg_mode: is_svg_mode end
				if argument_count > 3 then
					from
						i := 4
						n := argument_count
					until
						i > n
					loop
						s := argument (i)
						if s /= Void then
							if s.is_case_insensitive_equal ("--png") then
								is_png_mode := True
							end
							if s.is_case_insensitive_equal ("--svg") then
								is_svg_mode := True
							end
						end
						i := i + 1
					end
					if not is_svg_mode and not is_png_mode  then
						is_svg_mode := True -- Default
					end
				end

				process (ini_location, icons_location, output_location)
			else
				print ("Usage: prog path-to-ini-file icons-directory html-output%N")
				(create {EXCEPTIONS}).die (-1)
			end
		end

feature -- Execution

	process (a_ini_location: PATH; a_icons_location: PATH; a_output_location: PATH)
		local
			ini, output: PLAIN_TEXT_FILE
			i: INTEGER
			rn: detachable IMMUTABLE_STRING_8
			icon_name: IMMUTABLE_STRING_8
			s: STRING_8
			line, index: INTEGER
			fn1, fn2: STRING_32
			l_icons_path: IMMUTABLE_STRING_8
			l_width: INTEGER
			pw,ph:  INTEGER
			fut: FILE_UTILITIES
			cl: detachable STRING_8
			l_missing: BOOLEAN
			l_has_svg, l_has_png: BOOLEAN
		do
			create ini.make_with_path (a_ini_location)
			if ini.exists and then ini.is_access_readable then
				ini.open_read

				fn1 := a_output_location.parent.name
				fn2 := a_icons_location.name
				if fn2.starts_with (fn1) then
					fn2.remove_head (fn1.count + 1)
				end
					--
				if not fn2.is_empty then
					l_icons_path := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn2) + "/"
				else
					l_icons_path := ""
				end

				create output.make_with_path (a_output_location)
				if not output.exists or else output.is_access_writable then
					output.create_read_write
					output.put_string ("[
						<html>
							<head>
								<style>
						]")
						output.put_string ("[
									div.row { 
											display: flex;
											flex-direction: row;
											flex-wrap: wrap;
											border: solid 1px black;
											margin-top: 1rem;
										}
									div.section {
										flex: auto;
										border: solid 1px #ccc;
										padding: 1rem;
									}
									div.section div.icon {									
										margin-top: .5rem;
									}
									div.section div.icon img {
										margin-right: 1rem;
										/* border: solid 1px #000000cc; */
										vertical-align: middle;
									}
									div.section div.icon.missing {
										/* background-color: #ff000033; */
										color: red;
									}									
									div.section div.icon > span.image {
										display: inline-block;
										margin-right: 1rem;
										text-align: center;
									}
									div.section div.icon > span.image.missing {
										background-color: #ffffffcc;
										color: red;
										border: solid 1px red;
									}
									div.section div.icon figcaption {
										display: inline;
									}
									span.debug {
										color: #aaa;
									}
							]")
					if is_svg_mode then
						output.put_string ("[
										div.section div.icon.png:not(.svg) figcaption {
											color: #c00;
										}
								]")

						if not is_png_mode then
							output.put_string ("[
										div.section div.icon.png:not(.svg) figcaption::after {
											content: " [PNG]"
										}
								]")
						end
					elseif not is_svg_mode then
						output.put_string ("[
										div.section div.icon:not(.png) figcaption {
											color: #c00;
										}
									]")
						output.put_string ("[
									div.section div.icon:not(.png) figcaption::after {
										content: " [SVG]"
									}
							]")
					end
					output.put_string ("[
								</style>
								<script>
									function changeBackground(fg,bg) {
							   	   	   document.body.style.background = bg;
							   	   	   document.body.style.color = fg;
									}
								</script>								
							</head>
							<body>
							]")

					if is_svg_mode then
						if is_png_mode then
							output.put_string ("<h2>All SVG and PNG icons</h2>")
						else
							output.put_string ("<h2>All SVG icons (or PNG if missing)</h2>")
						end
					else
						output.put_string ("<h2>All PNG icons (or SVG if missing)</h2>")
					end
					output.put_string ("[
						<div style="background-color: white; color: black; padding: 1rem; margin: 1rem;">
							<strong>Background color:</strong> 
							<a href="#" onclick="changeBackground('black','transparent');">None</a> | 
							<a href="#" onclick="changeBackground('black','red');">Red</a> | 
							<a href="#" onclick="changeBackground('black','green');">Green</a> | 
							<a href="#" onclick="changeBackground('black','white');">White</a> | 
							<a href="#" onclick="changeBackground('white','black');">Black</a> | 
							<a href="#" onclick="changeBackground('black','grey');">Grey</a>
						</div>
						]")
					output.put_string ("<div><div>")
					from
					until
						ini.end_of_file
					loop
						ini.read_line
						s := ini.last_string
						s.adjust
						if s.is_whitespace then
								-- Skip
						elseif s [1] = ';' then
								-- Skip commented line
						elseif s [1] = '[' then
							i := s.index_of (']', 2)
							if i > 0 then
								s := s.substring (2, i - 1)
								s.adjust
								if s.is_empty then
										-- Ignore
								elseif s [1] = '@' then
									s.remove_head (1)
									s.left_adjust
									create rn.make_from_string (s)
									output.put_string ("</div><div class=%"section sub%" data-section-name=%"" + rn + "%">")
								else
									create rn.make_from_string (s)
									line := line + 1
									index := 0
									output.put_string ("</div></div>%N<div class=%"row%">%N")
									output.put_string ("<div class=%"section%" data-section-name=%"" + rn + "%">%N")
								end
							else
									-- Ignore line, as unexpected!
							end
						elseif rn /= Void then
							s := rn + " " + s
							s.replace_substring_all (" ", "_")
							create icon_name.make_from_string (s)
							index := index + 1
							if l_width > 0 and index > l_width then
								index := 1
								line := line + 1
							end
							l_has_svg := fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("svg"))
							l_has_png := fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("png"))
							l_missing := not (l_has_png or l_has_svg)
							cl := ""
							if l_has_svg then
								cl.append (" svg")
							end
							if l_has_png then
								cl.append (" png")
							end
							if l_missing then
								cl.append (" missing")
							end
							output.put_string ("%T<div class=%"icon" + cl + "%">")
							if is_svg_mode then
								if l_has_svg then
									output.put_string ("<img src=%"" + l_icons_path + line.out + "/" + index.out + ".svg%"")
									if pw > 0 then
										output.put_string (" style=%"width: "+ pw.out +"%"")
									end
									output.put_string (" title=%"svg ("+ line.out + "," + index.out + ") %"")
									output.put_string ("/>")
								else
									if l_has_png and not is_png_mode then
										output.put_string ("<img src=%"" + l_icons_path + line.out + "/" + index.out + ".png%"")
										output.put_string (" title=%"png ("+ line.out + "," + index.out + ") %"")
										output.put_string ("/>")
									else
										output.put_string ("<span class=%"image missing%"")
										if pw > 0 then
											output.put_string (" style=%"min-width: "+ pw.out +"; min-height: "+ ph.out +"%"")
										end
										output.put_string (">?</span>")
									end
								end
							end
							if is_png_mode then
								if l_has_png then
									output.put_string ("<img src=%"" + l_icons_path + line.out + "/" + index.out + ".png%"")
									output.put_string (" title=%"png ("+ line.out + "," + index.out + ") %"")
									output.put_string ("/>")
								else
									if l_has_svg and not is_svg_mode then
										output.put_string ("<img src=%"" + l_icons_path + line.out + "/" + index.out + ".svg%"")
										if pw > 0 then
											output.put_string (" style=%"width: "+ pw.out +"%"")
										end
										output.put_string (" title=%"png ("+ line.out + "," + index.out + ") %"")
										output.put_string ("/>")
									else
										output.put_string ("<span class=%"image missing%"")
										if pw > 0 then
											output.put_string (" style=%"min-width: "+ pw.out +"; min-height: "+ ph.out +"%"")
										end
										output.put_string (">?</span>")
									end
								end
							end
							if l_missing and (is_svg_mode xor is_png_mode) then
								output.put_string ("<span class=%"image missing%"")
								if pw > 0 then
									output.put_string (" style=%"min-width: "+ pw.out +"; min-height: "+ ph.out +"%"")
								end
								output.put_string (">?</span>")
							end

							output.put_string ("<figcaption>")
							output.put_string (icon_name)
							output.put_string (" <span class=%"debug%">(" + line.out + "," + index.out + ")</span>")
							output.put_string ("</figcaption>")
							output.put_string ("</div>%N")
						elseif s.starts_with ("width=") then
							s.remove_head (s.index_of ('=', 1))
							l_width := s.to_integer
						elseif s.starts_with ("pixel_width=") then
							s.remove_head (s.index_of ('=', 1))
							pw := s.to_integer
						elseif s.starts_with ("pixel_height=") then
							s.remove_head (s.index_of ('=', 1))
							ph := s.to_integer
						end
					end
					output.put_string ("</div>%N")

					output.put_string ("[
							</body>
						</html>
					]")
					output.close
				else
					io.error.put_string_32 ("ERROR: can not write to file: " + a_output_location.name + "%N")
				end
				ini.close
			else
				io.error.put_string_32 ("ERROR: can not read file: " + a_ini_location.name + "%N")
			end
		end

feature -- Access

	is_svg_mode: BOOLEAN
			-- Use SVG, then PNG
			-- Default: True

	is_png_mode: BOOLEAN
			-- Use PNG, then SVG
			-- Default: False

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
