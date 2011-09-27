note
	description: "Summary description for {ECF_PRINT_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_PRINT_VISITOR

inherit
	ECF_VISITOR

feature -- Visitor

	process_ecf (v: ECF)
		do
			print ("Name: %"" + v.name + "%"%N")
			print ("Syntax: " + v.syntax + "%N")
			if attached v.clusters as l_cluster then
				print ("Clusters:%N")
				across
					l_cluster as cl
				loop
					print ("  - " + cl.item + "%N")
				end
			end
			if attached v.tests_clusters as l_cluster then
				print ("Tests Clusters:%N")
				across
					l_cluster as cl
				loop
					print ("  - " + cl.item + "%N")
				end
			end
			if attached v.libraries as l_libraries then
				print ("Libraries:%N")
				across
					l_libraries as libs
				loop
					print ("  - " + libs.item + "%N")
				end
			end
		end

	process_application_ecf (v: APPLICATION_ECF)
		do
			print ("-- Application --%N")
			process_ecf (v)
			if attached v.executable_name as s then
				print ("Executable name: %""+s+"%"%N")
			end
			if attached v.root_info as tu then
				print ("Root: ")
				if attached tu.cluster as l_root_cluster then
					print ("cluster=%"" + l_root_cluster + "%" ")
				end
				print ("class=%"" + tu.class_name + "%" feature=%"" + tu.feature_name + "%"%N")
			end
			if v.is_console_application then
				print ("Console application: True%N")
			end
			if attached v.concurrency as l_concurrency then
				print ("Concurrency: ")
				print ("%"" + l_concurrency + "%"%N")
			end
		end

	process_testing_ecf (v: TESTING_ECF)
		do
			print ("-- Testing --%N")
			process_ecf (v)
			if attached v.concurrency as l_concurrency then
				print ("Concurrency: ")
				print ("%"" + l_concurrency + "%"%N")
			end
		end

	process_library_ecf (v: LIBRARY_ECF)
		do
			print ("-- Library --%N")
			process_ecf (v)
		end

end
