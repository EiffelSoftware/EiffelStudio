indexing
	description:  ""
	keywords:     "Console implementation of Event logging facility"
	revision:     "%%A%%"
	source:	      "%%P%%"
	copyright:   "See notice at end of class"


class CONSOLE_EVENT_LOG_I

inherit
        EVENT_LOG_FACILITY_I

creation 
        make

feature -- Modify
        append_event(severity:INTEGER; source,msg:STRING) is
            local
                str:STRING
            do
                !!str.make(0)
                str.append(Severities.item(severity)) str.append("    ")
                str.append(facility_interface.app_name) str.append("    ")
                str.append(source) str.append("    ")
                str.append(msg) str.append("%N")

                io.put_string(str)
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
