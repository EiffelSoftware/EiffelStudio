note
	description: "Event representing that no rule violation event has occurred."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_NO_ISSUES_EVENT

inherit
	EVENT_LIST_ITEM_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			category := {ENVIRONMENT_CATEGORIES}.static_analysis
			priority := {PRIORITY_LEVELS}.normal
		end

feature -- Access

	data: detachable ANY
			-- Is not needed here so will stay Void.

	description: STRING_32 = "No issues."
			-- <Precursor>

	frozen type: NATURAL_8
			-- <Precursor>
		once
			Result := {EVENT_LIST_ITEM_TYPES}.error
		end

	frozen category: NATURAL_8
			-- <Precursor>

	frozen priority: INTEGER_8
			-- <Precursor>

feature -- Status report

	is_invalidated: BOOLEAN
			-- <Precursor>

	is_valid_data (a_data: ANY): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature -- Element change

	set_category (a_category: like category)
			-- <Precursor>
		do
			category := a_category
		end

	set_priority (a_priority: like priority)
			-- <Precursor>
		do
			priority := a_priority
		end

feature -- Basic operations

	invalidate
			-- <Precursor>
		do
			is_invalidated := True
		end

end
