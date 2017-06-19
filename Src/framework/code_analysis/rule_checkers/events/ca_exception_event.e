note
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EXCEPTION_EVENT

inherit
	EVENT_LIST_ITEM_I

create
	make

feature {NONE} -- Initialization

	make (a_exception: TUPLE [detachable EXCEPTION, CLASS_C])
			-- Initialization for `Current'. Sets the data to
			-- `a_exception'.
		do
			category := {ENVIRONMENT_CATEGORIES}.static_analysis
			priority := {PRIORITY_LEVELS}.normal
			data := a_exception
		end

feature -- Access

	data: TUPLE [ex: detachable EXCEPTION; cl: CLASS_C]
			-- The class that the exception occurred with.

	description: STRING_32 = "Error analyzing class."
			-- <Precursor>

	frozen type: NATURAL_8
			-- <Precursor>
		do
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
