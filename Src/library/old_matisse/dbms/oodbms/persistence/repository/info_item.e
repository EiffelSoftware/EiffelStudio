indexing
	description:  "Minimum model of a 'business object' in the system:%
		        %must be a COMPOSED_OBJECT; %
		        %must be a REP_ITEM;%
		        %must have a concept of self-validity, and be able to report reason for invalidity; %
		        %must have a timestamp and currency status."
	keywords:     "database, cursor"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

deferred class INFO_ITEM

inherit
	INFO_ITEM_STATUS
		undefine
			is_equal
		end

	REP_ITEM
		redefine
			make_default, arch_unit
		end

feature -- Initialisation
	make_default is
		do
			precursor
			!!last_changed.make_now
			co_mark_for_store
		end

feature -- Status
	is_valid: BOOLEAN is
		deferred
		end

   	last_changed: DATE_TIME
			-- last date at which this info item was changed in database

	status: INTEGER
			-- status of this object, e.g. "current", "old" etc

feature -- Archetype
	description:STRING is
		once
			Result := arch_unit.description
		end

feature -- Modify Content
	set_status(a_status:INTEGER) is
		require
			Valid_status: is_valid_status(a_status)
		do
			status := a_status
			co_mark_for_store
		end

	set_last_changed(a_date:DATE_TIME) is
		require
			Args_valid: a_date /= Void
		do
			last_changed := a_date
			co_mark_for_store
		end

feature -- Editing
	invalid_reason:STRING

	clear is
		deferred
		end

feature {INFO_ITEM} -- Access
	arch_unit:ARCH_INFO_UNIT is
		do
			Result := archetype.info_unit(generator)
		end

invariant
	Valid_status: is_valid_status(status)
	Invalid_reason_always_given: not is_valid implies invalid_reason /= Void and then not invalid_reason.empty
	Timestamp_exists: last_changed /= Void

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+
