indexing
	description: "Compiler and Project browser tests"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_TESTER

feature -- Basic Operations

	run_tests (pm: PROJECT_MANAGER) is
			-- Run tests on `pm'.
		do
			test_completion_info (pm.completion_information)
		end

feature {NONE} -- Implementation

	test_completion_info (interface: IEIFFEL_COMPLETION_INFO_INTERFACE) is
			-- Test completion information component.
		local
			entries: IENUM_COMPLETION_ENTRY_INTERFACE
			l_feature: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
		do
			interface.add_local ("s", "STRING")
			entries := interface.target_features ("s.", "make", "C:\Documents and Settings\Remote\My Documents\Visual Studio Projects\blank_project6\root_class.e")
			display_entries (entries)
			interface.add_local ("s", "STRING")
			l_feature := interface.target_feature ("s.append_real", "make", "C:\Documents and Settings\Remote\My Documents\Visual Studio Projects\blank_project6\root_class.e")
			display_feature (l_feature)
		end

	display_entries (entries: IENUM_COMPLETION_ENTRY_INTERFACE) is
			-- Display elements in `entries'.
		local
			i, count: INTEGER
			rgelt: CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE]
		do
			from
				count := entries.count
				create rgelt.put (Void)
				i := 1
			until
				i > count
			loop
				entries.ith_item (i, rgelt)
				io.put_string ("name: " + rgelt.item.name + "%N")
				io.put_string ("signature: " + rgelt.item.signature + "%N%N")
				i := i + 1
			end
		end
	
	display_feature (l_feature: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE) is
			-- Display `l_feature'.
		require
			non_void_feature: l_feature /= Void
		local
			params: IENUM_PARAMETER_INTERFACE
			i, count: INTEGER
			rgelt: CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]
		do
			io.put_string ("feature " + l_feature.name + "%N")
			io.put_string ("signature: " + l_feature.signature + "%N")
			io.put_string ("description: " + l_feature.description + "%N%N")
			params := l_feature.parameters
			count := params.count
			create rgelt.put (Void)
			from
				i := 1
			until
				i > count
			loop
				params.ith_item (i, rgelt)
				io.put_string ("Param " + i.out + " name: " + rgelt.item.name + "%N")
				io.put_string ("Param " + i.out + " display: " + rgelt.item.display + "%N")
				i := i + 1
			end
		end
		
end -- class COMPILER_TESTER
