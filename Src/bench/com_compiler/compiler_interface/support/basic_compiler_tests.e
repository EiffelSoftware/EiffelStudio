indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_COMPILER_TESTS
	
inherit
	ANY
		redefine
			default_create
		end
	
create
	default_create

feature -- Initalization

	default_create is
			-- default creation
		local
			pp: PROJECT_PROPERTIES
			out_row, out_col: INTEGER_REF
			out_file_name: CELL [STRING]
		once
			pm.create_eiffel_project ("E:\overloading_eiffel_test\ace.ace", "E:\overloading_eiffel_test")
			pm.compiler.compile (feature {ECOM_EIF_COMPILATION_MODE_ENUM}.Eif_compilation_mode_workbench)
			--pm.retrieve_eiffel_project ("E:\overloading_eiffel_test\overloading_eiffel_test.epr")
			pp ?= pm.project_properties
			if pp /= Void then
				test_find_definition
--				test_target_feature
--				create out_file_name
--				create out_row
--				create out_col
--				pm.completion_information.add_local ("locals", "STRING")
-- 				pm.completion_information.find_definition ("p := locals.make_empty", "make",  "E:\overloading_eiffel_test\application.e", 1, 16, out_file_name, out_row, out_col)	
--				pm.completion_information.find_definition ("%T%Tl_local:STRING", "make",  "E:\overloading_eiffel_test\application.e", out_file_name, out_row, out_col)	
--				pm.completion_information.find_definition ("precursor { APPLICATION%T }", "make",  "E:\overloading_eiffel_test\application.e", out_file_name, out_row, out_col)	
--				pm.completion_information.find_definition ("create { APPLICATION }", "make",  "E:\overloading_eiffel_test\application.e", out_file_name, out_row, out_col)	
--				pm.completion_information.find_definition ("feature { APPLICATION }", "make",  "E:\overloading_eiffel_test\application.e", out_file_name, out_row, out_col)	
			end
		end
		
	test_target_classes is
			-- test `target_classes'
		require
			non_void_pm: pm /= Void 
		local
			ce: CLASS_ENUMERATOR
			ci: COMPLETION_INFORMATION
			item: CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			fetched: INTEGER_REF
		do
			ci ?= pm.completion_information
			ce := ci.target_classes ("STR")
			from
				ce.reset
				create fetched
				fetched.set_item (1)
			until
				fetched < 1
			loop
				create item
				ce.next (item, fetched)
				if fetched > 0 then
					print (item.item.name + "%N")					
				end
			end
		end
		
		
	test_find_definition is
			-- tests on {COMPLETION_INFORMATION}.find_definition
		require
			non_void_pm: pm /= Void
		local
			source_row: INTEGER_REF
			source_file_name: CELL [STRING]
		do
			create source_file_name
			create source_row
			--pm.completion_information.find_definition ("my_feture (i: INTEGER): STRING is%N%T%Tdo%N%T%T%Tcreate {STRING}.make_empty", 
			--		"E:\overloading_eiffel_test\application.e", 3, 20, source_file_name, source_row)
		end
		
		
	test_target_feature is
			-- tests on {COMPLETION_INFOMRATION}.target_feature
		require
			non_void_pm: pm /= Void
		local
			str_out, feat_out: CELL [STRING]
			bool_out: BOOLEAN_REF
			feat: FEATURE_DESCRIPTOR
			regex: RX_PCRE_MATCHER
			bool: BOOLEAN
			str: STRING
			capt_str: STRING
			type: STRING
		do
			create str_out
			create feat_out
			create bool_out
			pm.completion_information.parse_source_for_expr ("my_feture (i: INTEGER): STRING is%N%T%Tdo%N%T%T%Tcreate {STRING}.make_empty", 3, 20, str_out, feat_out, bool_out)
		--	feat ?= pm.completion_information.target_feature (str_out.item, "default_create", "E:\overloading_eiffel_test\application.e", false)
			print (str_out.item)
		end
		

feature -- Implmentation		

	pm: PROJECT_MANAGER is
			-- project manager
		once
			create Result.make
		end
		

end -- class BASIC_COMPILER_TESTS
