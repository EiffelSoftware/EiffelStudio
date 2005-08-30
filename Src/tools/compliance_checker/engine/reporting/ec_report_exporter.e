indexing
	description: "[
		Exports a generated report to a text file.	
	]"
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
			l_file: like open_file
		do
			last_error := Void
			l_file := open_file (a_file_name)
			if export_successful then
				process_report (l_file, report)
				l_file.flush
				l_file.close
			end
		end

feature {NONE} -- Processing

	process_report (a_file: FILE; a_report: like report) is
			-- Process `a_report'
		require
			a_file_not_void: a_file /= Void
			a_file_writable: a_file.is_open_write
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		local
			l_types: LIST [EC_REPORT_TYPE]
		do
			write_header (a_file, a_report)
			l_types := a_report.types
			from
				l_types.start	
			until
				l_types.after
			loop
				process_type (a_file, l_types.item)
				process_members (a_file, l_types.item)
				l_types.forth
			end
		end
		
	process_type (a_file: FILE; a_report: EC_REPORT_TYPE) is
			-- 
		require
			a_file_not_void: a_file /= Void
			a_file_writable: a_file.is_open_write
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
				a_file.new_line
				
				a_file.put_string ("Type%T")
				a_file.put_string (l_checked_type.type.full_name)
				a_file.put_string ("%T")
				
				l_checked_ab_type ?= l_checked_type
				
				if l_checked_type.is_eiffel_compliant then
					if l_checked_ab_type = Void or else l_checked_ab_type.is_eiffel_compliant_interface then
						a_file.put_string (non_compliant_string)
					else
						a_file.put_string (illegaly_cls_compliant_string)
					end
				else
					a_file.put_string (compliant_string)
				end
				a_file.put_string ("%T")
				
				if l_checked_type.is_compliant then
					if l_checked_ab_type = Void or else l_checked_ab_type.is_compliant_interface then
						a_file.put_string (non_compliant_string)
					else
						a_file.put_string (illegaly_cls_compliant_string)
					end
				else
					a_file.put_string (compliant_string)
				end
				a_file.put_string ("%T")
				
				if l_checked_type.is_marked then
					a_file.put_string (compliant_string)	
				else
					a_file.put_string (non_compliant_string)
				end
			end
		end
		
	process_members (a_file: FILE; a_report: EC_REPORT_TYPE) is
			-- 
		require
			a_file_not_void: a_file /= Void
			a_file_writable: a_file.is_open_write
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
					a_file.new_line
					
					a_file.put_string ("Member%T")
					a_file.put_string (report_formatter.format_member (l_checked_member.member, True))
					a_file.put_string ("%T")
					
					if l_checked_member.is_eiffel_compliant then
						a_file.put_string (compliant_string)	
					else
						a_file.put_string (non_compliant_string)
					end
					a_file.put_string ("%T")
					
					if l_checked_member.is_compliant then
						a_file.put_string (compliant_string)	
					else
						a_file.put_string (non_compliant_string)
					end
					a_file.put_string ("%T")
					
					if l_checked_member.is_marked then
						a_file.put_string (compliant_string)	
					else
						a_file.put_string (non_compliant_string)
					end
				end
				l_sorted_members.forth
			end
		end
		
feature {NONE} -- Output

	write_header (a_file: FILE; a_report: like report) is
			-- Writes header to `a_file' for report `a_report'.
		require
			a_file_not_void: a_file /= Void
			a_file_writable: a_file.is_open_write
			a_report_not_void: a_report /= Void
			a_report_built: not a_report.is_being_built
		do
			a_file.put_string ("Report generated for assembly: ")
			a_file.put_string (report.assembly.get_name.to_string)
			a_file.new_line
			a_file.new_line
			a_file.put_string ("Type/Feature%TName%TEiffel-Compliant%TCLS-Compliant%TMarked with ClsComplaintAttribute")	
		end
		
feature {NONE} -- Implementation

	open_file (a_file_name: STRING): PLAIN_TEXT_FILE is
			-- Opens `a_file_name' for exporting `report'
		require
			a_file_name_not_void: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			retried: BOOLEAN
		do
			if not retried then
				create Result.make_open_write (a_file_name)
			else
				last_error := string_formatter.format ("File '{1}'%NCould not be written to.%N%NPlease ensure the file is not locked and you have%Nthe correct permission to write to it.", [a_file_name])
			end
		ensure
			result_not_void: export_successful implies Result /= Void
			result_writable: export_successful implies Result.is_open_write
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
		
	illegaly_cls_compliant_string: STRING is "!!!Illegally Compliant!!!"
	compliant_string: STRING is "Yes"
	non_compliant_string: STRING is "No"
		
invariant
	report_not_void: report /= Void

end -- class EC_REPORT_EXPORTER
