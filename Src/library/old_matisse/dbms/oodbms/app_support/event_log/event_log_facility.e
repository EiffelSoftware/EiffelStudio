indexing
	description: ""
	keywords:    "Event logging facility Interface"
	revision:    "%%A%%"
	source:	     "%%P%%"
	copyright:   "See notice at end of class"


class EVENT_LOG_FACILITY

inherit
    	APP_ENVIRONMENT

creation
        make

feature -- Initialisation
	make is
	    do
			name := app_resource_value("logging", "facility_name")
			type := app_resource_value("logging", "facility_type")
			type.to_lower

			-- decide what type of implementation to used based on resource setting
			if type.is_equal("nt_event_log") then
			    !NT_EVENT_LOG_I!implementation.make(Current)
			elseif type.is_equal("file_event_log") then
			    !FILE_EVENT_LOG_I!implementation.make(Current)
			elseif type.is_equal("console_event_log") then
			    !CONSOLE_EVENT_LOG_I!implementation.make(Current)
			else
			    !CONSOLE_EVENT_LOG_I!implementation.make(Current)
			    append_event(generator, "make", "NO EVENT LOG FACILITY; using CONSOLE as log", Information)
			end

			log_start_event
		end

feature -- Access
	    name:STRING
	    type:STRING

feature -- Modify
	append_event(class_name, op_name, msg:STRING; severity:INTEGER) is
		require
			Valid_severity: is_valid_severity(severity)
			Valid_source: class_name /= Void and op_name /= Void
		local
			source_in_app:STRING
		do
			!!source_in_app.make(0)
			source_in_app.append(class_name) source_in_app.to_upper source_in_app.append(".")
			source_in_app.append(op_name) source_in_app.append(": ")

			implementation.append_event(severity, source_in_app, msg)
		end

feature {NONE} -- Implementation
	log_start_event is
	    local
			msg:STRING
			today:DATE_TIME
	    do
			-- log initial message
			!!today.make_now
			!!msg.make(0)
			msg.append("Started logging on facility ") msg.append(name) msg.append(" at ")
			msg.append(today.out)
			append_event(generator, "make", msg, Information)
	    end

	implementation:EVENT_LOG_FACILITY_I

invariant
	Implementation_exists: implementation /= Void

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
