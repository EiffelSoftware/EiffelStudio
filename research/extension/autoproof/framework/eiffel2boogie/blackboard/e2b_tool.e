note
	description: "Summary description for {E2B_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TOOL

inherit

	EBB_TOOL

feature -- Access

	name: attached STRING = "AutoProof"
			-- <Precursor>

	description: attached STRING = "Translating Eiffel to Boogie."
			-- <Precursor>

	configurations: attached LINKED_LIST [attached EBB_TOOL_CONFIGURATION]
			-- <Precursor>
		once
			create Result.make
			Result.extend (create {EBB_TOOL_CONFIGURATION}.make (Current, "Default"))
		end

	category: INTEGER
			-- <Precursor>
		do
			Result := {EBB_TOOL_CATEGORY}.static_verification
		end

feature -- Basic operations

	create_new_instance (a_execution: attached EBB_TOOL_EXECUTION)
			-- <Precursor>
		do
			create last_instance.make (a_execution)
		end

	last_instance: detachable E2B_TOOL_INSTANCE
			-- <Precursor>

end

