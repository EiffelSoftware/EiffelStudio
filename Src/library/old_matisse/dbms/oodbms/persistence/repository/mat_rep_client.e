indexing
	description:  "MATISSE repository common."
	keywords:     "database, matisse"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

deferred class MAT_REP_CLIENT

inherit
	MATISSE_CONST
	    export
			{NONE} all
	    end

	DB_REP_CLIENT
	    rename
			make as db_client_make
	    end

	HANDLE_USE_MAT
		export
			{NONE} all
		end		

feature -- Initialisation
	make  is
			-- local initialisation
	    do
			-- make indexing criteria lists of 1 item only
			!!index_start_criteria.make(1,1)
			!!index_end_criteria.make(1,1)

			-- make db client
			db_client_make
	    end

feature -- Indexing
	index_names:ARRAYED_LIST [STRING] is
			-- list of index names for this class.
			-- FIXME: note - currently hardwired; see outstanding PR to MAtisse
		local
			this_class:MT_CLASS
		do
			start_version_access("index_names")
			!!this_class.make(name)
			Result := this_class.all_index_names

			Result.compare_objects
		end

feature {NONE} -- Session Management
	start_version_access(caller:STRING) is
			-- do a Matisse version access, using latest version
		do
			clear_fail_reason
			set_current_db_name(rep_name)
			rep_session.begin_version_access_latest
			if not rep_session.is_ok then
				build_fail_reason(caller, "start_version_access", rep_session.error_message, rep_session.error_code)
			end
		end

	end_version_access(caller:STRING) is
		do
			rep_session.end_version_access
			if not rep_session.is_ok then
				build_fail_reason(caller, "end_version_access", rep_session.error_message, rep_session.error_code)
			end
		end

feature {NONE} -- Transaction Management
	start_query(dir_forward:BOOLEAN)  is
			-- initialise an index stream & selection query
	    do
			-- make an MT_CLASS for the class of this REP_CLIENT
			!!rep_class.make(name)

			-- setup a query object, using index method of access (to ensure sorted order)
			!!selection.make
			selection.set_map_name(rep_class, Class_map)		-- set class name
			selection.set_map_name(index_start_criteria, Index_crit_start_map)	-- forward in idx
			selection.set_map_name(index_end_criteria, Index_crit_end_map)	-- forward in idx
			selection.set_map_name(index_name, Name_map)
			if dir_forward then
				selection.set_map_name(Mtdirect, Direction_map)
			else
				selection.set_map_name(Mtreverse, Direction_map)
			end

			!!stream.make(Ois)	-- index stream
	    ensure
			Stream_exists: stream /= Void
			Selection_exists: selection /= Void
	    end

feature {NONE} -- Implementation
	selection:DB_SELECTION
	stream:DB_PROC
	rep_class:MT_CLASS
	index_start_criteria, index_end_criteria:ARRAY[STRING]
	stream_result:LINKED_LIST[DB_RESULT]

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
