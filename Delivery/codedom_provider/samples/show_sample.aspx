<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<%@ page language="Eiffel"%>

<html>
	<head>
		<title>Eiffel for ASP.NET Sample Viewer</title>
		<link rel="stylesheet" type="text/css" href="default.css" />
		<script src="scripts/load_content.js"></script>
		<script src="scripts/collapse_box.js"></script>

		<script runat="server">
			indexing
				description: "This page shows Eiffel for ASP.NET samples together with their source code"
				precompile_definition_file: "$ISE_CODEDOM\Samples\code_behind\ace.ace"
		</script>

		<script runat="server">
			inherit
				WEB_PAGE
					redefine
						on_load
					end
		</script>

		<script runat="server">
			on_load (e: EVENT_ARGS) is
					-- Initialize values used for data binding.
				do
					-- Only build link bar once since content won't change between postbacks
					if not is_post_back then
						build_link_list
					end
					if request.query_string.item ("path") /= Void then
						load_sample (request.query_string.item ("path"))
					end
				end
			
			build_link_list is
					-- Browse current directory for sample files.
					-- Add corresponding links to link bar.
				local
					l_dir: DIRECTORY
					l_files, l_links: ARRAYED_LIST [STRING]
					l_text, l_file, l_ss_file, l_path: STRING
					l_count: INTEGER
				do
					l_path := request.physical_application_path

					l_path.keep_head (l_path.count - 1)
						--  Remove the trailing '\'

					create l_dir.make (l_path)
					if l_dir.exists then
						l_files := l_dir.linear_representation
						from
							l_files.start
							create l_links.make (l_files.count)
						until
							l_files.after
						loop
							l_file := l_files.item
							if l_file.count > 5 and then 
								l_file.substring (l_file.count - 4, l_file.count).is_equal (".aspx") then
									-- This file is a sample file, add it to the link bar
								l_links.extend (l_file)
							end
							l_files.forth
						end
						l_ss_file := request.physical_path
						l_count := l_ss_file.count
						l_ss_file.keep_tail (l_count - l_ss_file.last_index_of ('\', l_count))
							-- `l_ss_file' contains the file name of the show sample ASP.NET page
						create l_text.make (512)
						l_text.append ("<ul>")
						from
							l_links.start
						until
							l_links.after
						loop
							l_text.append ("<li>")
							l_text.append (link_item (l_ss_file, l_links.item))
							l_text.append ("</li>")
							l_links.forth
						end
						l_text.append ("</ul>")
						link_list_label.set_text (l_text)
					end
				end

			link_item (a_show_sample_path, a_path: STRING): STRING is
					-- HTML for link bar item poiting to `a_path'
				require
					attached_path: a_path /= Void
				local
					l_info: TUPLE [STRING, STRING]
					l_path: STRING
				do
					l_path := request.physical_application_path
					l_path.append (a_path)
					analyze_page (l_path)
					create Result.make (256)
					Result.append ("<a href=%"")
					Result.append (a_show_sample_path)
					Result.append ("?path=")
					Result.append (a_path)
					Result.append ("%">")
					Result.append (page_title)
					Result.append ("</a>: ")
					Result.append (page_description)
				ensure
					attached_item: Result /= Void
				end
	
			analyze_page (a_path: STRING) is
					-- Extract title and description from page located at `a_path'.
				require
					attached_path: a_path /= Void
				local
					l_content: STRING
					l_file: PLAIN_TEXT_FILE
					l_index, l_index_2: INTEGER
				do
					page_title := ""
					page_description := ""
					create l_file.make (a_path)
					if l_file.exists then
						l_file.open_read
						l_file.read_stream (l_file.count)
						l_content := l_file.last_string
						l_file.close
						l_index := l_content.substring_index ("<title>", 1)
						if l_index > 0 then
							l_index := l_index + 7
							l_index_2 := l_content.substring_index ("</title>", l_index)
							if l_index_2 > 0 then
								page_title := l_content.substring (l_index, l_index_2 - 1)
							end
						end
						l_index := l_content.substring_index ("description: %"", 1)
						if l_index > 0 then
							l_index := l_index + 14
							l_index_2 := l_content.index_of ('"', l_index)
							if l_index_2 > 0 then
								page_description := l_content.substring (l_index, l_index_2 - 1)
							end
						end
					end
				ensure
					attached_page_title: page_title /= Void
					attached_page_description: page_description /= Void
				end
	
			page_title: STRING
					-- Page title retrieved with `analyze_page'
			
			page_description: STRING
					-- Page description retrieved with `analyze_page'
	
			load_sample (a_path: STRING) is
					-- Load sample `a_path'.
				require
					attached_path: a_path /= Void
				local
					l_path, l_source, l_link: STRING
					l_parser: EFA_PARSER
				do
					l_path := request.physical_application_path
					l_path.append (a_path)
					create l_parser
					l_parser.parse (l_path)
					if l_parser.parse_successful then
						source_label.set_text (l_parser.formatted_html)
						create l_link.make (100)
						l_link.append ("javascript:load_content('")
						l_link.append (a_path)
						l_link.append ("', 'Result', 'Link', 'Message');")
						load_page_link.set_navigate_url (l_link)
						load_page_link.set_text ("Run sample")
						title_label.set_text (l_parser.page_title)
						header_label.set_text (l_parser.page_description)
						header_label.set_fore_color ({drawing_color}.black)
						samples_div.set_visible (True)						
					else
						header_label.set_text ("Invalid sample path!")
						header_label.set_fore_color ({DRAWING_COLOR}.red)
					end
				end

		</script>
	</head>
	<body>
		<div class="title">
			<h1>Eiffel for ASP.NET Samples</h1>
		</div>
		<div class="description">
			<p>
				<span class="up">J</span>ump start into Eiffel for ASP.NET with the following samples. <br />
				Click on a sample to view its source. <br />
				Click on the <b>Run sample</b> link below the source for a live demo.
			</p>
			<asp:Label runat="server" id="link_list_label" />
		</div>

		<div runat="server" class="sample" visible="false" ID="samples_div">
			<form runat="server" id="main_form">
				<h1><asp:Label runat="server" id="title_label"/></h1>

				<p>
					<asp:Label runat="server" id="header_label"/>
				</p>

				<script language="javascript">
					startBlock ("<b>Source Code</b>", "SourceCodeBlock", "", "images/", true, "800px");
				</script>
				<br />
				<asp:Label runat="server"
					CssClass="code"
					id="source_label"
				/>
				<script language="javascript">
					endBlock("images/");
				</script>
			</form>

			<script language="javascript">
				startBlock ("<b>Live Demo</b>", "LiveDemoBlock", "", "images/", true, "800px");
			</script>
				<br />
				<div id="Link" class="link">
					<asp:Hyperlink runat="server" id="load_page_link"/>
				</div>
				<div id="Message"></div>
				<div id="Result"></div>
			<script language="javascript">
				endBlock("images/");
			</script>
		</div>
	</body>
</html>

<!--
--+--------------------------------------------------------------------
--| Eiffel for ASP.NET 5.6
--| Copyright (c) 2005-2006 Eiffel Software
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
-->
