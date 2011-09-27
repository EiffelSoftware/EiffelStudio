note
	description: "Summary description for {ECF_BUILDER_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_BUILDER_VISITOR

inherit
	ECF_VISITOR

create
	make

feature {NONE} -- Initialization

	make (buf: like buffer)
		do
			buffer := buf
		end

	buffer: STRING

feature -- Visitor

	process_ecf (v: ECF)
		do
		end

	process_testing_ecf (v: TESTING_ECF)
		do
			process_application_ecf (v)
		end

	process_application_ecf (v: APPLICATION_ECF)
		do
			buffer.append_string ("<?xml version=%"1.0%" encoding=%"ISO-8859-1%"?>%N")
			buffer.append_string ("<system xmlns=%"http://www.eiffel.com/developers/xml/configuration-1-8-0%" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%" xsi:schemaLocation=%"http://www.eiffel.com/developers/xml/configuration-1-8-0 http://www.eiffel.com/developers/xml/configuration-1-8-0.xsd%" ")
			buffer.append_string ("name=%"" + v.name + "%" uuid=%""+ v.uuid +"%">%N")
			buffer.append_string ("%T<target name=%""+ v.name +"%">%N")
			buffer.append_string ("%T%T<root ")
			if attached v.root_cluster as rtcl then
				buffer.append_string ("cluster=%""+ rtcl +"%" ")
			end
			buffer.append_string ("class=%""+ v.root_class +"%" feature=%""+ v.root_feature +"%"/>%N")
			buffer.append_string ("%T%T<file_rule>%N")
			buffer.append_string ("%T%T%T<exclude>/.git$</exclude>%N")
			buffer.append_string ("%T%T%T<exclude>/EIFGENs$</exclude>%N")
			buffer.append_string ("%T%T%T<exclude>/.svn$</exclude>%N")
			buffer.append_string ("%T%T</file_rule>%N")
			buffer.append_string ("%T%T<option warning=%"true%" full_class_checking=%"true%"")
			if v.is_voidsafe then
				buffer.append_string (" is_attached_by_default=%"true%" void_safety=%"all%"")
			else
				buffer.append_string (" void_safety=%"none%"")
			end
			buffer.append_string (" syntax=%"" + v.syntax + "%">%N")
			buffer.append_string ("%T%T</option>%N")
			if v.is_console_application then
				check v.generating_type = {APPLICATION_ECF} end
				buffer.append_string ("%T%T<setting name=%"console_application%" value=%"true%"/>%N")
			end
			if attached v.executable_name as s then
				check v.generating_type = {APPLICATION_ECF} end
				buffer.append_string ("%T%T<setting name=%"executable_name%" value=%"" + s + "%"/>%N")
			end
			if attached v.concurrency as s then
				buffer.append_string ("%T%T<setting name=%"concurrency%" value=%"" + s + "%"/>%N")
			end

			process_libraries_from (v)
			process_clusters_from (v)
			process_tests_clusters_from (v)

			buffer.append_string ("%T</target>%N")
			buffer.append_string ("</system>%N")
		end

	process_library_ecf (v: LIBRARY_ECF)
		do
			buffer.append_string ("<?xml version=%"1.0%" encoding=%"ISO-8859-1%"?>%N")
			buffer.append_string ("<system xmlns=%"http://www.eiffel.com/developers/xml/configuration-1-8-0%" xmlns:xsi=%"http://www.w3.org/2001/XMLSchema-instance%" xsi:schemaLocation=%"http://www.eiffel.com/developers/xml/configuration-1-8-0 http://www.eiffel.com/developers/xml/configuration-1-8-0.xsd%" ")
			buffer.append_string ("name=%"" + v.name + "%" uuid=%""+ v.uuid +"%" library_target=%"" + v.name + "%">%N")
			buffer.append_string ("%T<target name=%""+ v.name +"%">%N")
			buffer.append_string ("%T%T<root all_classes=%"true%"/>%N")
			buffer.append_string ("%T%T<file_rule>%N")
			buffer.append_string ("%T%T%T<exclude>/.git$</exclude>%N")
			buffer.append_string ("%T%T%T<exclude>/EIFGENs$</exclude>%N")
			buffer.append_string ("%T%T%T<exclude>/.svn$</exclude>%N")
			buffer.append_string ("%T%T</file_rule>%N")
			buffer.append_string ("%T%T<option warning=%"true%" full_class_checking=%"true%"")
			if v.is_voidsafe then
				buffer.append_string (" is_attached_by_default=%"true%" void_safety=%"all%"")
			else
				buffer.append_string (" void_safety=%"none%"")
			end
			buffer.append_string (" syntax=%"" + v.syntax + "%">%N")
			buffer.append_string ("%T%T</option>%N")

			process_libraries_from (v)
			process_clusters_from (v)
			process_tests_clusters_from (v)

			buffer.append_string ("%T</target>%N")
			buffer.append_string ("</system>%N")
		end

feature {NONE} -- Implementation

	process_libraries_from (v: ECF)
		do
			across
				v.libraries as libs
			loop
				if attached library_info (libs.item) as lib_info then
					if v.is_voidsafe then
						buffer.append_string ("%T%T<library name=%""+ lib_info.name +"%" location=%"" + lib_info.ecf_path + "-safe.ecf%"/>%N")
					else
						buffer.append_string ("%T%T<library name=%""+ lib_info.name +"%" location=%"" + lib_info.ecf_path + ".ecf%"/>%N")
					end
				end
			end
		end

	process_clusters_from (v: ECF)
		do
			across
				v.clusters as clu
			loop
				if attached clu.item as l_cluster then
					if l_cluster.same_string (".") then
						buffer.append_string ("%T%T<cluster name=%""+ "src" +"%" location=%".%" recursive=%"true%"/>%N")
					else
						buffer.append_string ("%T%T<cluster name=%""+ l_cluster +"%" location=%"./" + l_cluster + "%" recursive=%"true%"/>%N")
					end
				end
			end
		end

	process_tests_clusters_from (v: ECF)
		do
			across
				v.tests_clusters as clu
			loop
				if attached clu.item as l_cluster then
					if l_cluster.same_string (".") then
						buffer.append_string ("%T%T<tests name=%""+ "src" +"%" location=%".%" recursive=%"true%"/>%N")
					else
						buffer.append_string ("%T%T<tests name=%""+ l_cluster +"%" location=%"./" + l_cluster + "%" recursive=%"true%"/>%N")
					end
				end
			end
		end

	library_info (s: STRING): detachable TUPLE [name: STRING; ecf_path: STRING]
		local
			lib: STRING
			p: INTEGER
		do
			if s.has ('/') or s.has ('\') then
				p := s.last_index_of ('/', s.count).max (s.last_index_of ('\', s.count))
				if s.substring (s.count - 3, s.count).is_case_insensitive_equal (".ecf") then
					Result := [s.substring (p + 1, s.count - 4).as_lower, s.substring (1, s.count - 4)]
				else
					Result := [s.substring (p + 1, s.count).as_lower, s]
				end
			else
				lib := s.as_lower
				Result := [lib, "$ISE_LIBRARY/library/" + s + "/" + s]
			end
		end

end
