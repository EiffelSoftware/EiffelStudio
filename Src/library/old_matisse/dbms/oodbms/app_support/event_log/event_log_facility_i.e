indexing
	description: ""
	keywords:    "Event logging facility Implementation"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"


deferred class EVENT_LOG_FACILITY_I

inherit
    	EVENT_SEVERITY_CONSTANTS

feature -- Initialisation
        make(a_facility_interface:like facility_interface) is
            require
                Args_valid: a_facility_interface /= Void
            do
                facility_interface := a_facility_interface
            ensure
                Facility_interface_exists: facility_interface /= Void
            end

feature -- Access
        facility_interface:EVENT_LOG_FACILITY

feature {NONE} -- Implementation
        Severities:ARRAY[STRING] is
            once
                !!Result.make(Information, Error)
                Result.put("Information",Information)
                Result.put("Warning",Warning)
                Result.put("Error",Error)
            end

feature {EVENT_LOG_FACILITY} -- Modify
        append_event(severity:INTEGER; source,msg:STRING) is
            require
            	is_valid_severity(severity)
            deferred
            end

invariant
	Interface_exists: facility_interface /= Void

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
