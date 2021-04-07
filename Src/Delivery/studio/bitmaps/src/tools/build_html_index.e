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
		do
			if argument_count >= 3 then
				create ini_location.make_from_string (argument (1))
				ini_location := ini_location.absolute_path.canonical_path

				create icons_location.make_from_string (argument (2))
				icons_location := icons_location.absolute_path.canonical_path

				create output_location.make_from_string (argument (3))
				output_location := output_location.absolute_path.canonical_path

				is_png_mode := False
				check is_svg_mode: is_svg_mode end
				if argument_count > 3 and then attached argument (4) as l_type then
					if l_type.is_case_insensitive_equal ("--png") then
						is_png_mode := True
					elseif l_type.is_case_insensitive_equal ("--svg") then
						is_png_mode := False
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

				l_icons_path := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (fn2)

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
									div.section div.icon img {
										margin-right: 1rem;
									}
									div.section div.icon.missing {
										background-color: #ff0000cc;
										color: black;
									}
									
									div.section div.icon > span.image {
										display: inline-block;
										margin-right: 1rem;
										text-align: center;
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
										div.section div.icon.png figcaption {
											color: #c00;
										}
										div.section div.icon.png figcaption::after {
											content: " [PNG]"
										}
								]")
					else
						output.put_string ("[
										div.section div.icon.svg figcaption {
											color: #c00;
										}
										div.section div.icon.svg figcaption::after {
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
						output.put_string ("<h2>All SVG icons (or PNG if missing)</h2>")
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
							l_missing := False
							if is_svg_mode then
								if fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("svg")) then
									output.put_string ("%T<div class=%"icon svg%">")
									if pw > 0 then
										output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".svg%" style=%"width: "+ pw.out +"%" />")
									else
										output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".svg%" />")
									end
								elseif fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("png")) then
									output.put_string ("%T<div class=%"icon png%">")
									output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".png%" />")
								else
									l_missing := True
								end
							else
								if fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("png")) then
									output.put_string ("%T<div class=%"icon png%">")
									output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".png%" />")
								elseif fut.file_path_exists (a_icons_location.extended (line.out).extended (index.out).appended_with_extension ("svg")) then
									output.put_string ("%T<div class=%"icon svg%">")
									if pw > 0 then
										output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".svg%" style=%"width: "+ pw.out +"%" />")
									else
										output.put_string ("<img src=%"" + l_icons_path + "/" + line.out + "/" + index.out + ".svg%" />")
									end
								else
									l_missing := True
								end
							end
							if l_missing then
								output.put_string ("%T<div class=%"icon missing%">")

								if pw > 0 then
									output.put_string ("<span class=%"image%" style=%"width: "+ pw.out +"%">?</span>")
								else
									output.put_string ("<span class=%"image%">?</span>")
								end
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
		do
			Result := not is_png_mode
		end
			
	is_png_mode: BOOLEAN
			-- Use PNG, then SVG
			-- Default: False

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
