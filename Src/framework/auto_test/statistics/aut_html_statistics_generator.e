indexing

	description:

		"Generates HTML pages describing test statistics"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_HTML_STATISTICS_GENERATOR

inherit

	AUT_STATISTICS_GENERATOR
		redefine
			make
		end

	AUT_SHARED_PATHNAMES
		export {NONE} all end

	AUT_SHARED_FILE_SYSTEM_ROUTINES
		export {NONE} all end

	UT_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	KL_SHARED_STREAMS
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	REFACTORING_HELPER

create

	make

feature {NONE} -- Initialization

	make (an_output_dirname: like output_dirname; a_system: like system; a_classes_under_test: like classes_under_test) is
			-- Create new html generator.
		do
			Precursor (an_output_dirname, a_system, a_classes_under_test)
			create test_case_printer.make_null (system)
		end

feature -- Access

	absolute_index_filename: STRING is
			-- Absolute filename of main entry page
		do
			Result := file_system.pathname (output_dirname, "index.html")
		end

feature -- HTML generation

	generate (a_repository: AUT_TEST_CASE_RESULT_REPOSITORY) is
			-- Generate HTML pages describing the results from `a_repository'.
		local
			cs: DS_LINEAR_CURSOR [CLASS_C]
			i: INTEGER
			is_first: BOOLEAN
		do
			current_id := 0
			file_system.recursive_create_directory (output_dirname)
			file_system.recursive_create_directory (file_system.pathname (output_dirname, "image"))
			copy_static_files
			create tree_content_file.make (file_system.pathname (output_dirname, "treeContent.js"))
			tree_content_file.open_write
			generate_tree_content_file_header
			generate_summary_page (a_repository)
			generate_header_page
			if not tree_content_file.is_open_write then
				has_fatal_error := True
			else
				from
					cs := a_repository.classes.new_cursor
					cs.start
				until
					cs.off
				loop
					generate_class (cs.item, a_repository)
					cs.forth
				end
				tree_content_file.put_string ("ClassesInScope.addChildren([")
				from
					cs := a_repository.classes.new_cursor
					cs.start
					i := 1
					is_first := True
				until
					cs.off
				loop
					if is_class_in_test_scope (cs.item) then
						if is_first then
							is_first := False
						else
							tree_content_file.put_string (", ")
						end
						tree_content_file.put_string ("class_")
						tree_content_file.put_string (cs.item.name_in_upper)
					end
					cs.forth
					i := i + 1
				end
				tree_content_file.put_line ("])")
				tree_content_file.put_string ("ManualTests.addChildren([")
				from
					cs := a_repository.classes.new_cursor
					cs.start
					i := 1
					is_first := True
				until
					cs.off
				loop
					if is_manual_test_class (cs.item) then
						if is_first then
							is_first := False
						else
							tree_content_file.put_string (", ")
						end
						tree_content_file.put_string ("class_")
						tree_content_file.put_string (cs.item.name_in_upper)
					end
					cs.forth
					i := i + 1
				end
				tree_content_file.put_line ("])")
				tree_content_file.put_string ("Others.addChildren([")
				from
					cs := a_repository.classes.new_cursor
					cs.start
					i := 1
					is_first := True
				until
					cs.off
				loop
					if not is_class_in_test_scope (cs.item) and not is_manual_test_class (cs.item) then
						if is_first then
							is_first := False
						else
							tree_content_file.put_string (", ")
						end
						tree_content_file.put_string ("class_")
						tree_content_file.put_string (cs.item.name_in_upper)
					end
					cs.forth
					i := i + 1
				end
				tree_content_file.put_line ("])")
			end
			generate_tree_content_file_footer
			tree_content_file.close
		end

feature {NONE} -- HTML Generation

	copy_static_files is
			-- Copy static files from test studio directory to html directory.
		do
			file_system_routines.copy_recursive (pathnames.image_dirname, file_system.pathname (output_dirname, "image"))
			file_system_routines.copy_recursive (pathnames.misc_html_dirname, output_dirname)
		end

	generate_summary_page (a_repository: AUT_TEST_CASE_RESULT_REPOSITORY) is
			-- Generate main summary page.
		require
			a_repository_not_void: a_repository /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			set: AUT_TEST_CASE_RESULT_SET
		do
			create file.make (file_system.pathname (output_dirname, "summary.html"))
			file.open_write
			if file.is_open_write then
				set := a_repository.results
				file.put_string (template_expander.expand_from_array (summary_page_header_template, <<system.name>>))
				generate_summary (set, file)
				file.put_string (summary_page_footer_template)
				file.close
			else
				has_fatal_error := True
			end
		end

	generate_header_page is
			-- Generate header page.
		local
			file: KL_TEXT_OUTPUT_FILE
		do
			create file.make (file_system.pathname (output_dirname, "header.html"))
			file.open_write
			if file.is_open_write then
				file.put_string (template_expander.expand_from_array (header_page_template, <<system.name>>))
				file.close
			else
				has_fatal_error := True
			end
		end

	generate_class (a_class: CLASS_C; a_repository: AUT_TEST_CASE_RESULT_REPOSITORY) is
			-- Generate HTML pages describing the results from `a_repository' of class `a_class'.
		require
			a_repository_not_void: a_repository /= Void
			a_class_not_void: a_class /= Void
			tree_content_file_not_void: tree_content_file /= Void
			tree_content_file_open_write: tree_content_file.is_open_write
		local
			file: KL_TEXT_OUTPUT_FILE
			absolute_filename: STRING
			filename: STRING
			set: AUT_TEST_CASE_RESULT_SET
			image_filename: STRING
			child_id_list: DS_ARRAYED_LIST [INTEGER]
			cs: DS_ARRAYED_LIST_CURSOR [INTEGER]
			l_feat_table: FEATURE_TABLE
			feature_i: FEATURE_I
		do
			filename := class_summary_file_name (a_class)
			absolute_filename := file_system.pathname (output_dirname, filename)
			set := a_repository.results_by_class (a_class)

			create image_filename.make (100)
			image_filename.append_string ("image/class_")
			if set.is_bad_response then
				image_filename.append_string ("bad_response")
			elseif set.is_fail then
				image_filename.append_string ("fail")
			elseif set.is_invalid then
				image_filename.append_string ("invalid")
			elseif set.is_pass then
				image_filename.append_string ("pass")
			elseif set.is_untested then
				image_filename.append_string ("untested")
			else
				check
					dead_end: False
				end
			end
			image_filename.append_string (".gif")

			tree_content_file.put_string ("class_")
			tree_content_file.put_string (a_class.name)
			tree_content_file.put_string (" = gFld (%"")
			tree_content_file.put_string (a_class.name)
			tree_content_file.put_string ("%", %"")
			tree_content_file.put_string (filename)
			tree_content_file.put_line ("%")")
			tree_content_file.put_string ("class_")
			tree_content_file.put_string (a_class.name)
			tree_content_file.put_string (".iconSrc = %"")
			tree_content_file.put_string (image_filename)
			tree_content_file.put_character ('"')
			tree_content_file.put_new_line
			tree_content_file.put_string ("class_")
			tree_content_file.put_string (a_class.name)
			tree_content_file.put_string (".iconSrcClosed = %"")
			tree_content_file.put_string (image_filename)
			tree_content_file.put_character ('"')
			tree_content_file.put_new_line

			create file.make (absolute_filename)
			file.open_write
			if file.is_open_write then
				file.put_string (template_expander.expand_from_array (class_summary_header_template, <<a_class.name>>))
				generate_summary (set, file)
				file.put_string (class_summary_footer_template)
				file.close
				create child_id_list.make (a_class.feature_table.count)
				l_feat_table := a_class.feature_table
				if not is_manual_test_class (a_class) then
					from
						l_feat_table.start
					until
						l_feat_table.after
					loop
						feature_i := l_feat_table.item_for_iteration
						if feature_i /= Void and then (feature_i.is_attribute or feature_i.is_function) and then not feature_i.is_prefix and then not feature_i.is_infix then
							generate_feature (a_class, feature_i, a_repository, child_id_list)
						end
						l_feat_table.forth
					end
				end

				from
					l_feat_table.start
				until
					l_feat_table.after
				loop
					feature_i := l_feat_table.item_for_iteration
					if feature_i /= Void and then not (feature_i.is_attribute or feature_i.is_function) and then not feature_i.is_prefix and then not feature_i.is_infix then
						generate_feature (a_class, feature_i, a_repository, child_id_list)
					end
					l_feat_table.forth
				end

				tree_content_file.put_string ("class_")
				tree_content_file.put_string (a_class.name)
				tree_content_file.put_string (".addChildren ([")
				from
					cs := child_id_list.new_cursor
					cs.start
				until
					cs.off
				loop
					tree_content_file.put_string ("id_")
					tree_content_file.put_integer (cs.item)
					if not cs.is_last then
						tree_content_file.put_string (", ")
					end
					cs.forth
				end
				tree_content_file.put_line ("])")
			else
				has_fatal_error := True
			end
		end

	generate_feature (a_class: CLASS_C; a_feature: FEATURE_I; a_repository: AUT_TEST_CASE_RESULT_REPOSITORY; a_id_list: DS_ARRAYED_LIST [INTEGER]) is
			-- Generate HTML pages describing the results from `a_repository' of class `a_class'.
			-- This routine also generates the corresponding tree node entry and puts the id for the node into `a_id_list'.
		require
			a_repository_not_void: a_repository /= Void
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
			a_feature_not_prefix_and_not_infix: not a_feature.is_prefix and not a_feature.is_prefix
			tree_content_file_not_void: tree_content_file /= Void
			tree_content_file_open_write: tree_content_file.is_open_write
			a_id_list_not_void: a_id_list /= Void
		local
			file: KL_TEXT_OUTPUT_FILE
			set: AUT_TEST_CASE_RESULT_SET
			absolute_filename: STRING
			filename: STRING
			cs: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
			image_filename: STRING
		do
			set := a_repository.results_by_feature_and_class (a_feature, a_class)
			if
				a_feature.written_class.name.is_case_insensitive_equal ("ANY") and then (set.is_pass or set.is_untested)
			then
				-- Ignore features from ANY that don't show any interesting results
			else
				filename := feature_summary_file_name (a_class, a_feature)
				absolute_filename := file_system.pathname (output_dirname, filename)
				test_case_result_sorter.sort (set.list)

				create image_filename.make (20)
				image_filename.append_string ("image/feature_")
				if set.is_bad_response then
					image_filename.append_string ("bad_response")
				elseif set.is_fail then
					image_filename.append_string ("fail")
				elseif set.is_invalid then
					image_filename.append_string ("invalid")
				elseif set.is_pass then
					image_filename.append_string ("pass")
				elseif set.is_untested then
					image_filename.append_string ("untested")
				else
					check
						dead_end: False
					end
				end
				image_filename.append_string (".gif');")
				a_id_list.force_last (current_id)
				tree_content_file.put_string ("id_")
				tree_content_file.put_integer (current_id)
				tree_content_file.put_string (" = gFld (%"")
				tree_content_file.put_string (a_feature.feature_name)
				tree_content_file.put_string ("%", %"")
				tree_content_file.put_string (filename)
				tree_content_file.put_line ("%")")
				tree_content_file.put_string ("id_")
				tree_content_file.put_integer (current_id)
				tree_content_file.put_string (".iconSrc = %"")
				tree_content_file.put_string (image_filename)
				tree_content_file.put_character ('"')
				tree_content_file.put_new_line
				tree_content_file.put_string ("id_")
				tree_content_file.put_integer (current_id)
				tree_content_file.put_string (".iconSrcClosed = %"")
				tree_content_file.put_string (image_filename)
				tree_content_file.put_character ('"')
				tree_content_file.put_new_line


				create file.make (absolute_filename)
				file.open_write
				test_case_printer.set_output_stream (file)
				if file.is_open_write then
					file.put_string (template_expander.expand_from_array (feature_summary_header_template,
																			<<a_class.name_in_upper,
																			a_feature.feature_name>>))
					generate_summary (set, file)
					file.put_line ("<h1>Failed Test Cases:</h1>")
					from

						cs := set.list.new_cursor
						cs.start
					until
						cs.off
					loop
						if cs.item.is_fail then
							generate_test_case_result (cs.item, file)
						end
						cs.forth
					end
					file.put_line ("<h1>Bad response Test Cases:</h1>")
					from

						cs := set.list.new_cursor
						cs.start
					until
						cs.off
					loop
						if cs.item.is_bad_response then
							generate_test_case_result (cs.item, file)
						end
						cs.forth
					end
					file.put_line ("<h1>Passed Test Cases:</h1>")
					from

						cs := set.list.new_cursor
						cs.start
					until
						cs.off
					loop
						if cs.item.is_pass then
							generate_test_case_result (cs.item, file)
						end
						cs.forth
					end
					file.put_line ("<h1>Invalid Test Cases:</h1>")
					from

						cs := set.list.new_cursor
						cs.start
					until
						cs.off
					loop
						if cs.item.is_invalid then
							generate_test_case_result (cs.item, file)
						end
						cs.forth
					end
					file.put_string (feature_summary_footer_template)
					test_case_printer.set_output_stream (null_output_stream)
					file.close
					consume_id
				else
					has_fatal_error := True
				end
			end
		end

	generate_test_case_result (a_result: AUT_TEST_CASE_RESULT; a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Print test case results in `a_set' to `a_stream'.
		require
			a_result_not_void: a_result /= Void
			a_stream_not_void: a_stream /= Void
			a_stream_open_write: a_stream.is_open_write
		local
			explain_link: STRING
			status: STRING
			response_printer: AUT_RESPONSE_LOG_PRINTER
		do
			a_stream.put_string ("<h2>Test Case:")
			if a_result.is_pass then
				explain_link := "test_case_pass.html"
				status := "pass"
			elseif a_result.is_fail then
				explain_link := "test_case_fail.html"
				status := "fail"
			elseif a_result.is_invalid then
				explain_link := "test_case_invalid.html"
				status := "invalid"
			elseif a_result.is_bad_response then
				explain_link := "test_case_bad_response.html"
				status := "bad response"
			else
				check
					dead_end: False
				end
			end
			a_stream.put_line (template_expander.expand_from_array (explain_link_template, <<explain_link, status>>))
			a_stream.put_line ("</h2>")
			a_stream.put_line ("<br/>Witness:<br/>")
			a_stream.put_line ("<pre class='witness'>")
			test_case_printer.print_test_case (a_result.witness.request_list, a_result.witness.used_vars)
			a_stream.put_line ("</pre>")
			a_stream.put_line ("Result:<br/>")
			a_stream.put_line ("<pre class='witness'>")
			create response_printer.make (a_stream)
			a_result.witness.item (a_result.witness.count).response.process (response_printer)
			a_stream.put_line ("</pre>")
			a_stream.put_line ("<br/>")
		end

	generate_summary (a_set: AUT_TEST_CASE_RESULT_SET; a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Generate summary for set `a_set' into `a_stream'.
		require
			a_set_not_void: a_set /= Void
			a_stream_not_void: a_stream /= Void
			a_stream_open_write: a_stream.is_open_write
		local
			explain_link: STRING
			status: STRING
		do
				a_stream.put_string ("<h2>Status: <b>")
				if a_set.is_bad_response then
					explain_link := "test_case_set_bad_response.html"
					status := "bad response"
				elseif a_set.is_fail then
					explain_link := "test_case_set_fail.html"
					status := "fail"
				elseif a_set.is_invalid then
					explain_link := "test_case_set_invalid.html"
					status := "invalid"
				elseif a_set.is_pass then
					explain_link := "test_case_set_pass.html"
					status := "pass"
				elseif a_set.is_untested then
					explain_link := "test_case_set_untested.html"
					status := "untested"
				else
					check
						dead_end: False
					end
				end
				a_stream.put_line (template_expander.expand_from_array (explain_link_template, <<explain_link, status>>))
				a_stream.put_line ("</b></h2>")
				a_stream.put_string (template_expander.expand_from_array (summary_table_template,
					<<a_set.total_count.out,
						a_set.unique_fail_count.out,
						a_set.bad_response_count.out,
						a_set.fail_count.out,
						a_set.invalid_count.out,
						a_set.pass_count.out
						>>))
		end

	generate_tree_content_file_header is
			-- Generate header for `tree_file'.
		require
			tree_content_file_not_void: tree_content_file /= Void
			tree_content_file_open_write: tree_content_file.is_open_write
		do

			tree_content_file.put_line ("USETEXTLINKS = 1")
			tree_content_file.put_line ("STARTALLOPEN = 0")
			tree_content_file.put_line ("HIGHLIGHT = 1")
			tree_content_file.put_line ("PRESERVESTATE = 1")
			tree_content_file.put_line ("GLOBALTARGET=%"R%"")
			tree_content_file.put_line ("ICONPATH=%"image/%"")
			tree_content_file.put_line ("foldersTree = gFld(%"" + system.name + "%", %"summary.html%")")
			tree_content_file.put_line ("foldersTree.iconSrc = %"image/folderopen.gif%"")
			tree_content_file.put_line ("foldersTree.iconSrcClosed = %"image/folder.gif%"")
			tree_content_file.put_line ("ClassesInScope = gFld(%"Classes in Scope%", %"summary.html%")")
			tree_content_file.put_line ("ClassesInScope.iconSrc = %"image/folderopen.gif%"")
			tree_content_file.put_line ("ClassesInScope.iconSrcClosed = %"image/folder.gif%"")
			tree_content_file.put_line ("ManualTests = gFld(%"Manual unit tests%", %"summary.html%")")
			tree_content_file.put_line ("ManualTests.iconSrc = %"image/folderopen.gif%"")
			tree_content_file.put_line ("ManualTests.iconSrcClosed = %"image/folder.gif%"")
			tree_content_file.put_line ("Others = gFld(%"Other classes%", %"summary.html%")")
			tree_content_file.put_line ("Others.iconSrc = %"image/folderopen.gif%"")
			tree_content_file.put_line ("Others.iconSrcClosed = %"image/folder.gif%"")
		end

	generate_tree_content_file_footer is
			-- Generate header for `tree_file'.
		require
			tree_content_file_not_void: tree_content_file /= Void
			tree_content_file_open_write: tree_content_file.is_open_write
		do
			tree_content_file.put_line ("foldersTree.addChildren([ClassesInScope, ManualTests, Others])")
		end

feature {NONE} -- File handles

	tree_content_file: KL_TEXT_OUTPUT_FILE
			-- File that contains script to build Javascript tree

feature {NONE} -- Implementation

	class_summary_file_name (a_class: CLASS_C): STRING is
				-- File name for class sumamry file for class `a_class'
			require
				a_class_not_void: a_class /= Void
			do
				create Result.make (a_class.name.count + class_summary_file_postfix.count)
				Result.append_string (a_class.name)
				Result.to_lower
				Result.append_string (class_summary_file_postfix)
			ensure
				name_not_void: Result /= Void
				name_not_empty: Result.count > 0
			end

	feature_summary_file_name (a_class: CLASS_C; a_feature: FEATURE_I): STRING is
				-- File name for feature sumamry file for feature `a_feature' of class `a_class'
			require
				a_class_not_void: a_class /= Void
				a_feature_not_void: a_feature /= Void
			do
				create Result.make (a_class.name.count + 1 + a_feature.feature_name.count + feature_summary_file_postfix.count)
				Result.append_string (a_class.name)
				Result.to_lower
				Result.append_character ('-')
				Result.append_string (a_feature.feature_name)
				Result.append_string (feature_summary_file_postfix)
			ensure
				name_not_void: Result /= Void
				name_not_empty: Result.count > 0
			end

	consume_id is
			-- Mark the id stored in `current_id' as used and provide a new one.
		do
			current_id := current_id + 1
		end

	current_id: INTEGER
		-- Next id to use

	test_case_printer: AUT_TEST_CASE_PRINTER
			-- Test case printer

feature {NONE} -- Implementation constants

	class_summary_file_postfix: STRING is "_class_summary.html"

	feature_summary_file_postfix: STRING is "_feature_summary.html"

	class_summary_header_template: STRING is "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<title>Class Summary</title>
		<link rel="stylesheet" href="stylesheet.css" type="text/css"/>
		<script type="text/javascript" src="explain.js"></script>
	</head>
	<body>
		<div id="content">
			<h1>${1}</h2>
]"

	class_summary_footer_template: STRING is "[
		</div>
	</body>
</html>
]"
	feature_summary_header_template: STRING is "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<title>Feature Summary</title>
		<link rel="stylesheet" href="stylesheet.css" type="text/css"/>
		<script type="text/javascript" src="explain.js"></script>
	</head>
	<body>
		<div id="content">
			<h1>${1}.${2}</h2>
			<p>
				Below you will find all executed test cases. Note that AutoTest tries, for those test cases that prove the
				existance of a bug, to add a minimized version too.
			</p>
]"

	feature_summary_footer_template: STRING is "[
		</div>
	</body>
</html>
]"

	summary_page_header_template: STRING is "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<title>Summary Page</title>
		<link rel="stylesheet" href="stylesheet.css" type="text/css"/>
		<script type="text/javascript" src="explain.js"></script>
	</head>
	<body>
		<div id="content">
		<h1>System '${1}'</h1>
]"

	summary_page_footer_template: STRING is "[
		</div>
	</body>
</html>
]"
	summary_table_template: STRING is "[
			<h1>Test Case Summary</h1>
			<table>
				<tr>
					<td>Total:</td>
					<td>${1}</td>
				</tr>
				<tr>
					<td>Unique:</td>
					<td>${2}</td>
				</tr>
				<tr>
					<td>Bad Response:</td>
					<td>${3}</td>
				</tr>
				<tr>
					<td>Fail:</td>
					<td>${4}</td>
				</tr>
				<tr>
					<td>Invalid:</td>
					<td>${5}</td>
				</tr>
				<tr>
					<td>Pass:</td>
					<td>${6}</td>
				</tr>
			</table>
]"

	header_page_template: STRING is "[
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<title>AutoTest statistics for system '${1}'</title>
		<link rel="stylesheet" href="stylesheet.css" type="text/css"/>
	</head>
	<body>
		<table class="header" width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<td width="55" height="55" class="tableHeader">
				<img src="image/o_logo.png" width="47" height="48" border="0" alt="se logo">
			</td>
			<td>
				<h1 class="title">
					AutoTest statistics for system '${1}'
				</h1>
				<h2 class="title">
					We Kick Bugs!
				</h2>
			</td>
		  </tr>
		  <tr>
			<td><img src="image/spacer.png" width="1" height="10" alt=""/></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		</table>
	</body>
</html>
]"

	class_has_error_template: STRING is "[
<ul><li>The class has syntax or type errors.</li></ul>
]"

	explain_link_template: STRING is "[
<a href="JavaScript: explain ('${1}')">${2}</a>
]"

invariant

	test_case_printer_not_void: test_case_printer /= Void

end
