indexing
	description: "[
		Exports a generated report to a text file.	
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_REPORT_EXPORTER

create
	make
	
feature {NONE} -- Initialization

	make (a_report: like report; a_report_non_cls: like report_non_cls; a_report_all: like report_all) is
			-- Create and initialize new report exporter.
		require
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		do
			report := a_report
			report_non_cls := a_report_non_cls
			report_all := a_report_all
		ensure
			report_set: report = a_report
			report_non_cls_set: report_non_cls = a_report_non_cls
			report_all_set: report_all = a_report_all
		end

feature -- Access

	report_non_cls: BOOLEAN
			-- Should exported report show non-CLS-compliant types and members?

	report_all: BOOLEAN
			-- Should exported report show all types and membes?

	report: EC_REPORT
			-- Report to export

	last_error: STRING
			-- Last error message, if any

	export_successful: BOOLEAN is
			-- Was export successful?
		do
			Result := last_error = Void
		ensure
			last_error_not_set: Result = (last_error = Void)
		end

feature -- Basic Operations

	export_report (a_file_name: STRING) is
			-- Export report to `a_file_name'
		require
			a_file_name_not_void: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_writer: like open_writer
		do
			last_error := Void
			l_writer := open_writer (a_file_name)
			if export_successful then
				process_report (l_writer, report)
				l_writer.flush
				l_writer.close
			end
		end

feature {NONE} -- Processing

	process_report (a_writer: XML_XML_TEXT_WRITER; a_report: like report) is
			-- Process `a_report'
		require
			a_writer_not_void: a_writer /= Void
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		local
			l_types: LIST [EC_REPORT_TYPE]
		do
			write_header (a_writer, a_report)
			l_types := a_report.types
			from
				l_types.start	
			until
				l_types.after
			loop
				process_type (a_writer, l_types.item)
				l_types.forth
			end
			write_footer (a_writer, a_report)
		end
		
	process_type (a_writer: XML_XML_TEXT_WRITER; a_report: EC_REPORT_TYPE) is
			-- 
		require
			a_writer_not_void: a_writer /= Void
			a_report_not_void: a_report /= Void
		local
			l_checked_type: EC_CHECKED_TYPE
			l_checked_ab_type: EC_CHECKED_ABSTRACT_TYPE
			l_show_cls: BOOLEAN
			l_add: BOOLEAN
			l_members: LIST [EC_REPORT_MEMBER]
			l_member: EC_CHECKED_MEMBER
			l_cursor: CURSOR
		do
			l_checked_type := a_report.type
			l_show_cls := report_non_cls
			if report_all then
				l_add := True
			end
			if not l_add then
				if l_show_cls then
					l_add := not l_checked_type.is_compliant or not l_checked_type.is_eiffel_compliant
					if not l_add then
						l_checked_ab_type ?= l_checked_type
						if l_checked_ab_type /= Void then
							l_add := not l_checked_ab_type.is_compliant_interface or not l_checked_ab_type.is_eiffel_compliant_interface
						end
					end
				else
					l_add := not l_checked_type.is_eiffel_compliant
					if not l_add then
						l_checked_ab_type ?= l_checked_type
						if l_checked_ab_type /= Void then
							l_add := not l_checked_ab_type.is_eiffel_compliant_interface
						end
					end
				end				
			end
			if not l_add then
					-- Check members
				l_members := a_report.members
				l_cursor := l_members.cursor
				from
					l_members.start
				until
					l_members.after or l_add
				loop
					l_member := l_members.item.member
					if l_show_cls then
						l_add := not l_member.is_compliant or not l_member.is_eiffel_compliant
					else
						l_add := not l_member.is_eiffel_compliant
					end	
					l_members.forth
				end
				l_members.go_to (l_cursor)
			end

			if l_add then
				write_type_start (a_writer, a_report)
				process_members (a_writer, a_report)
				write_type_end (a_writer, a_report)
			end
		end
		
	process_members (a_writer: XML_XML_TEXT_WRITER; a_report: EC_REPORT_TYPE) is
			-- 
		require
			a_writer_not_void: a_writer /= Void
			a_report_not_void: a_report /= Void
		local
			l_show_all: BOOLEAN
			l_show_cls: BOOLEAN
			l_add: BOOLEAN
			l_sorted_members: SORTED_TWO_WAY_LIST [EC_REPORT_MEMBER]
			l_member: EC_REPORT_MEMBER
			l_checked_member: EC_CHECKED_MEMBER
		do
			l_show_all := report_all
			if not l_show_all then
				l_show_cls := report_non_cls
			end
			
			create l_sorted_members.make
			l_sorted_members.append (a_report.members)
			l_sorted_members.sort
			from
				l_sorted_members.start
			until
				l_sorted_members.after
			loop
				l_member := l_sorted_members.item
				l_checked_member := l_member.member
				l_add := l_show_all
				if not l_add then
					if l_show_cls then
						l_add := not l_checked_member.is_compliant or not l_checked_member.is_eiffel_compliant
					else
						l_add := not l_checked_member.is_eiffel_compliant
					end				
				end
				if l_add then
					write_member_start (a_writer, l_member)
					write_member_end (a_writer, l_member)
				end
				l_sorted_members.forth
			end
		end
		
feature {NONE} -- Output

	write_header (a_writer: XML_XML_TEXT_WRITER; a_report: like report) is
			-- Writes header to `a_writer' for report `a_report'.
		require
			a_writer_not_void: a_writer /= Void
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		do
			a_writer.write_start_document
			a_writer.write_start_element (report_elm)
			a_writer.write_attribute_string (assembly_attr, a_report.assembly.full_name)
		end
		
	write_type_start (a_writer: XML_XML_TEXT_WRITER; a_type: EC_REPORT_TYPE) is
			-- Writes start of type `a_type' to `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_type_not_void: a_type /= Void
		local
			l_type: EC_CHECKED_TYPE
			l_ab_type: EC_CHECKED_ABSTRACT_TYPE
			l_compliant: BOOLEAN
			l_value: STRING
		do
			l_type := a_type.type
			l_ab_type ?= l_type
			
			a_writer.write_start_element (type_elm)
			a_writer.write_attribute_string (name_attr, report_formatter.format_type (a_type.type.type, True))
			
			l_compliant := l_type.is_eiffel_compliant
			if l_compliant then
				if l_ab_type /= Void then
					l_compliant := l_ab_type.is_eiffel_compliant_interface
					if not l_compliant then
						l_value := l_ab_type.non_eiffel_compliant_interface_reason
					end
				end
			else
				l_value := l_type.non_eiffel_compliant_reason
			end	
			a_writer.write_attribute_string (eiffel_compliant_attr, l_compliant.out.as_lower)
			if not l_compliant then
				a_writer.write_attribute_string (non_eiffel_compliant_reason_attr, l_value)	
			end

			l_compliant := l_type.is_compliant
			if l_compliant then
				if l_ab_type /= Void then
					l_compliant := l_ab_type.is_compliant_interface
					if not l_compliant then
						l_value := l_ab_type.non_compliant_interface_reason
					end
				end
			else
				l_value := l_type.non_compliant_reason
			end	
			a_writer.write_attribute_string (cls_compliant_attr, l_compliant.out.as_lower)
			if not l_compliant then
				a_writer.write_attribute_string (non_cls_compliant_reason_attr, l_value)	
			end
			
			a_writer.write_attribute_string (marked_attr, l_type.is_marked.out.as_lower)
		end
		
	write_type_end (a_writer: XML_XML_TEXT_WRITER; a_type: EC_REPORT_TYPE) is
			-- Writes end of type `a_type' to `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_type_not_void: a_type /= Void
		do
			a_writer.write_end_element
		end
		
	write_member_start (a_writer: XML_XML_TEXT_WRITER; a_member: EC_REPORT_MEMBER) is
			-- Writes start of member `a_type' to `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_member_not_void: a_member /= Void
		local
			l_member: EC_CHECKED_MEMBER
			l_compliant: BOOLEAN
		do
			l_member := a_member.member
			
			a_writer.write_start_element (member_elm)
			a_writer.write_attribute_string (name_attr, report_formatter.format_member (a_member.member.member, False))
					
			l_compliant := l_member.is_eiffel_compliant
			a_writer.write_attribute_string (eiffel_compliant_attr, l_compliant.out.as_lower)
			if not l_compliant then
				a_writer.write_attribute_string (non_eiffel_compliant_reason_attr, l_member.non_eiffel_compliant_reason)
			end
			
			l_compliant := l_member.is_compliant
			a_writer.write_attribute_string (cls_compliant_attr, l_compliant.out.as_lower)
			if not l_compliant then
				a_writer.write_attribute_string (non_cls_compliant_reason_attr, l_member.non_compliant_reason)
			end
			
			a_writer.write_attribute_string (marked_attr, l_member.is_marked.out.as_lower)
		end
		
	write_member_end (a_writer: XML_XML_TEXT_WRITER; a_member: EC_REPORT_MEMBER) is
			-- Writes end of member `a_member' to `a_writer'.
		require
			a_writer_not_void: a_writer /= Void
			a_member_not_void: a_member /= Void
		do
			a_writer.write_end_element
		end
		
	write_footer (a_writer: XML_XML_TEXT_WRITER; a_report: like report) is
			-- Writes footer to `a_writer' for report `a_report'.
		require
			a_writer_not_void: a_writer /= Void
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		do
			a_writer.write_end_element
			a_writer.write_end_document
		end
		
feature {NONE} -- Implementation

	open_writer (a_file_name: STRING): XML_XML_TEXT_WRITER is
			-- Opens `a_file_name' for exporting `report'
		require
			a_file_name_not_void: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_from_filename_and_encoding (a_file_name, {ENCODING}.utf8)
				Result.set_formatting ({XML_FORMATTING}.indented)
			else
				last_error := string_formatter.format ("File '{1}'%NCould not be written to.%N%NPlease ensure the file is not locked and you have%Nthe correct permission to write to it.", [a_file_name])
			end
		ensure
			result_not_void: export_successful implies Result /= Void
		rescue
			retried := True
			retry
		end
		
	string_formatter: EC_STRING_FORMATTER is
			-- STRING formatter
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
	report_formatter: EC_CHECK_REPORT_FORMATTER is
			-- Report item formatter
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
	
	report_elm: SYSTEM_STRING is "CompliantReport"
	assembly_attr: SYSTEM_STRING is "Assembly"
	type_elm: SYSTEM_STRING is "Type"
	member_elm: SYSTEM_STRING is "Member"
	name_attr: SYSTEM_STRING is "Name"
	eiffel_compliant_attr: SYSTEM_STRING is "EiffelCompliant"
	non_eiffel_compliant_reason_attr: SYSTEM_STRING is "NonEiffelCompliantReason"
	cls_compliant_attr: SYSTEM_STRING is "ClsCompliant"
	non_cls_compliant_reason_attr: SYSTEM_STRING is "NonClsCompliantReason"
	marked_attr: SYSTEM_STRING is "MarkedWithAttribute"
		
invariant
	report_not_void: report /= Void

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
end -- class EC_REPORT_EXPORTER
