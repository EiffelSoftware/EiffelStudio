indexing
	description: ""
	keywords:    "NT Event implementation of logging facility"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"


class NT_EVENT_LOG_I

inherit
        EVENT_LOG_FACILITY_I
            rename
                make as facility_make
	    end

creation 
        make

feature -- Initialisation
        make(a_facility_interface:like facility_interface) is
            do
                facility_make(a_facility_interface)

                -- real implementation to be determined 
                -- !!event_log.make

		-- if event_log /= Void then
		--     log_start_event
		-- else
		    -- do something basic
		-- end
	    ensure then
		-- Log_exists: event_log.exists
            end

feature {NONE} -- Implementation
        append_event(severity:INTEGER; source,msg:STRING) is
            do
            end

        event_log:ANY is
            once
            end

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
