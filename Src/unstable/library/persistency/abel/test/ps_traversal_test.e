note
	description: "Summary description for {PS_TRAVERSAL_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRAVERSAL_TEST

inherit
	EQA_TEST_SET
		redefine on_prepare end

feature {NONE} -- Implementation

	on_prepare
		do
			create test_data.make
			create traversal.make (create {ANY}, create {PS_METADATA_FACTORY}.make)
		end

	test_data: PS_TEST_DATA

	traversal: PS_OBJECT_GRAPH_TRAVERSAL


feature

	test_reference_cycle
		do
			traversal.set_root_object (test_data.reference_cycle)
			traversal.traverse

			print (traversal.traversed_objects_as_string)
		end

	test_evil_object
		do
			traversal.set_root_object (test_data.evil_object)
			traversal.traverse
			print (traversal.traversed_objects_as_string)
			io.error.put_string (traversal.traversed_objects_as_string)
		end

end
