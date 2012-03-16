note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE_PROVIDER_THREAD

inherit
	THREAD
		rename
			make as thread_make
		end

	SHARED_SVN_SORTERS

create
	make

feature -- Access

	make (a_mutex: MUTEX; a_provider: SVN_ENGINE_PROVIDER; a_data: like th_data; a_id: INTEGER)
		do
			thread_make
			th_mutex := a_mutex
			th_id := a_id
			th_provider := a_provider
			th_data := a_data
		end

	execute
		local
			lst: LIST [SVN_STATUS_INFO]
		do
			create internal_svn_engine
			lst := internal_svn_engine.statuses (th_data.p, th_data.is_verbose_mode, th_data.is_recursive_mode, th_data.is_remote_mode, void)
			th_mutex.lock
			th_provider.post_result (th_id, lst)
			th_mutex.unlock
		end

	internal_svn_engine: SVN_ENGINE

	th_provider: SVN_ENGINE_PROVIDER
	th_mutex: MUTEX
	th_id: INTEGER
	th_data: TUPLE [p: STRING; is_verbose_mode: BOOLEAN; is_recursive_mode: BOOLEAN; is_remote_mode: BOOLEAN]


end
