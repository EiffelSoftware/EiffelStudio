indexing
	description: "XSL transformation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XSL_TRANSFORM
	
inherit	
	SHARED_OBJECTS
		
	EXECUTION_ENVIRONMENT

	UTILITY_FUNCTIONS
	
	XML_ROUTINES
		rename
			is_valid_xml as is_valid_xml_text
		end

create
	make_from_xsl_file

feature	--Creation

	make_from_xsl_file (a_filename: STRING) is
			-- Make from existing `xsl' file
		require
			name_not_void: a_filename /= Void
			file_exists: (create {PLAIN_TEXT_FILE}.make (a_filename)).exists
		local
			retried: BOOLEAN
			xpath_exception: XML_XPATH_EXCEPTION
			xslt_compile_exception: XML_XSLT_COMPILE_EXCEPTION
			xslt_exception: XML_XSLT_EXCEPTION
		do
			name := a_filename
			document := deserialize_document (name)
			create internal_xsl.make
			if not retried then
				internal_xsl.load (a_filename)
				Shared_document_manager.set_xsl (Current)
				create arguments.make
				is_valid_xsl := True
			else
				xpath_exception ?= feature {EXCEPTION_MANAGER}.last_exception
				xslt_compile_exception ?= feature {EXCEPTION_MANAGER}.last_exception
				xslt_exception ?= feature {EXCEPTION_MANAGER}.last_exception
				if xpath_exception /= Void then
					create load_error_message.make_from_cil (xpath_exception.message)
				end
				if xslt_compile_exception /= Void then
					create load_error_message.make_from_cil (xslt_compile_exception.message)
				end
				if xslt_exception /= Void then
					create load_error_message.make_from_cil (xslt_exception.message)
				end
				is_valid_xsl := False
			end	
		rescue
			retried := True
			retry
		end
	
feature -- Commands

	transform_xml_text (xml_text: STRING) is
			-- Transform `xml_text' according to selected filter
		require
			xml_not_void: xml_text /= Void
			xml_not_empty: not xml_text.is_empty
		do
			transform (xml_text)
		end

feature -- Access
	
	name: STRING
			-- Name
			
	document: XM_DOCUMENT
			-- XML structure
			
	text: STRING is
			-- Text of `document'
		do
			Result := document_text (document)	
		end		
	
	stylesheet: STRING
			-- File where stylesheet resides for formatting output

	load_error_message: STRING
			-- Error message for loading .xsl file

feature -- Status setting

	set_stylesheet (a_filename: STRING) is
			-- Set stylesheet from `a_filename'
		require
			stylesheet_not_void: a_filename /= Void
		do
			stylesheet := a_filename
		end
		
	set_stylesheet_relative (a_flag: BOOLEAN) is
			-- Set `use_stylesheet_relative'
		do
			use_stylesheet_relative := a_flag	
		end
		
	set_stylesheet_parents (no_parents: INTEGER) is
			-- Set number of parent to use for `stylesheet' relative path
		require
			using_relative: use_stylesheet_relative
			no_parent_valid: not (no_parents < 0)
		do
			stylesheet_relative_parents := no_parents	
		end		
		
feature -- Query

	is_valid_xml: BOOLEAN is
			-- Is Current valid xml?
		do
			Result := document /= Void
		end		

	is_valid_xsl: BOOLEAN
			-- Is Current a valid Xslt file

	has_stylesheet: BOOLEAN is
			-- Does current have stylesheet?
		do
			Result := stylesheet /= Void
		end

	use_stylesheet_relative: BOOLEAN
			-- Should a relative path be used for `stylesheet' location?

	stylesheet_relative_parents: INTEGER
			-- Number of parents to use for `stylesheet' when using `use_stylesheet_relative'

	transformed_text: STRING
			-- Text last transformed
		
feature {NONE} -- Implementation

	internal_xsl: XML_XSL_TRANSFORM
			-- Internal xsl stylesheet object
	
	arguments: XML_XSLT_ARGUMENT_LIST
			-- List of xslt arguments to be processed by `internal_xsl'
			-- at transform time	

	transform (xml: STRING) is
			-- Apply transform for `xml' and put resulting transformation in 
			-- `transformed_text'
		require
			xml_not_void: xml /= Void
			xml_not_empty: not xml.is_empty
		local
			temp_in_xml,
			temp_out_html: PLAIN_TEXT_FILE
			in_file: XML_XPATH_DOCUMENT
			out_file: XML_XML_TEXT_WRITER
			reader: XML_XML_TEXT_READER
			out_xml: XML_XML_DOCUMENT
			l_custom_xml: CUSTOM_XML
			l_xml: STRING
		do
			l_xml := xml
			create temp_in_xml.make_create_read_write (Shared_constants.Transformation_constants.temp_xsl_in_filename)
			create temp_out_html.make_create_read_write (Shared_constants.Transformation_constants.temp_xsl_out_filename)
			xml.replace_substring_all ("%T", "")
			xml.replace_substring_all ("%N", "")
			if Shared_constants.Transformation_constants.add_custom_text then
				create l_custom_xml.make_from_xml (l_xml)
--				l_xml := l_custom_xml.text
			end

			temp_in_xml.put_string (l_xml)
			temp_in_xml.close
			temp_out_html.close
			
			create in_file.make_from_uri ((Shared_constants.Transformation_constants.Temp_xsl_in_filename).to_cil)
			create out_file.make_from_filename_and_encoding ((Shared_constants.Transformation_constants.temp_xsl_out_filename).to_cil, Void)
			build_arguments
			internal_xsl.transform_ixpath_navigable_xslt_argument_list_xml_writer (in_file, arguments, out_file)
			out_file.close
--			Shared_web_browser.navigate_url (current_working_directory + "\" + Temp_xsl_out_filename)
			temp_in_xml.delete
			temp_out_html.open_read
			temp_out_html.readstream (temp_out_html.count)
			transformed_text := temp_out_html.last_string
			temp_out_html.close
		end
	
	build_arguments is
			-- Build xsl arguments for next transform
		local
			retried: BOOLEAN
			l_xml_exception: XML_XML_EXCEPTION
			error_report: ERROR_REPORT
			l_filter_name: STRING
		do
			if not retried then
				arguments.clear
				l_filter_name := Shared_project.filter_manager.filter.description
				if l_filter_name.is_equal ("EiffelStudio") then
					arguments.add_param ("generation_output", "", "studio")
				elseif l_filter_name.is_equal ("ENViSioN!") then
					arguments.add_param ("generation_output", "", "envision")
				end
				if stylesheet /= Void then
					if use_stylesheet_relative then
						arguments.add_param ("stylesheet", ("").to_cil, stylesheet_relative.to_cil)
					else
						arguments.add_param ("stylesheet", "", stylesheet)
					end
				end
			else
				l_xml_exception ?= feature {EXCEPTION_MANAGER}.last_exception
				if l_xml_exception /= Void then
					if error_report /= Void then
						error_report.append_error (l_xml_exception.message, l_xml_exception.line_number, l_xml_exception.line_position)	
					else
						create error_report.make ("Invalid XML", l_xml_exception.message,
							l_xml_exception.line_number, l_xml_exception.line_position)
					end
				end
			end
		rescue
			retried := True
			retry
		end
		
	stylesheet_relative: STRING is
			-- Value of `stylesheet' when `use_stylesheet_relative' is True
			require
				using_relative: use_stylesheet_relative
				number_of_parents_valid: not (stylesheet_relative_parents < 0)
			local
				l_cnt: INTEGER
			do
				from
					l_cnt := 1
					create Result.make_empty
				until
					l_cnt = stylesheet_relative_parents
				loop
					Result.append ("../")
					l_cnt := l_cnt + 1
				end
				Result.append (short_name (stylesheet))
			end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class XSL_TRANSFORM
