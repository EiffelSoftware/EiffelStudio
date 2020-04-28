note
	description: "[
			Representation of a {TEST_SET_BRIDGE} from test target to library/app target.
			]"
	need: "[
		Test classes in a test target will sometimes require access to features
		of a library target that are exported to {NONE}. When this happens, the
		required access features must be exported to some class that only the
		test target is interested in. That is what this class is for.
		]"
	solution: "[
		Steps:
		======
		(1) Find the feature group of the feature needing to be accessed by the
			test in the test target. Add {TEST_SET_BRIDGE} to its list of Clients,
			such as:
			
				feature {TEST_SET_BRIDGE} -- Implementation
				
					my_feature_needing_access do ... end
					
		(2) Ensure the that test class inherits not only from EQA_TEST_SET, but
			also from TEST_SET_BRIDGE. Once the test class inherits from the
			TEST_SET_BRIDGE class, then the compiler will grant access to the test
			class to the require feature (above).
		]"

class
	TEST_SET_BRIDGE

feature -- Operations

	test_folder: PATH
			-- A path targeted at the `test' folder of current project.
		once
			create Result.make_from_string ({OPERATING_ENVIRONMENT}.current_directory_name_representation + {OPERATING_ENVIRONMENT}.directory_separator.out + "test")
		end

end
