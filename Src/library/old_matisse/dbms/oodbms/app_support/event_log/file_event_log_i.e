indexing
	description: ""
	keywords:    "File-based Event logging facility implementation"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"


class FILE_EVENT_LOG_I

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

                !!event_log.make_open_read_append(facility_interface.name)

	    ensure then
		Log_exists: event_log.exists
            end

feature -- Modify
        append_event(severity:INTEGER; source,msg:STRING) is
            local
                str:STRING
            do
                !!str.make(0)
                str.append(Severities.item(severity)) str.append("    ")
                str.append(facility_interface.app_name) str.append("    ")
                str.append(source) str.append("    ")
                str.append(msg) str.append_character('%R') str.append_character('%N')

                event_log.put_string(str)
            end

        event_log:RAW_FILE

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
