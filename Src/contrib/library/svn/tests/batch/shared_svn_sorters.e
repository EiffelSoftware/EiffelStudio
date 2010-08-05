note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_SVN_SORTERS

feature -- Sorters

--	svn_equality_tester: KL_EQUALITY_TESTER	[SVN_STATUS_INFO]
--		once
--			create Result
--		end

	info_sorter: QUICK_SORTER [SVN_STATUS_INFO]
		local
			comparator: COMPARABLE_COMPARATOR [SVN_STATUS_INFO]
		once
			create comparator
			create Result.make (comparator)
		end

	info_path_sorter: QUICK_SORTER [SVN_STATUS_INFO]
		local
			comparator: SVN_STATUS_INFO_COMPARATOR
		once
			create comparator.make_path
			create Result.make (comparator)
		end

	info_wc_status_sorter: QUICK_SORTER [SVN_STATUS_INFO]
		local
			comparator: SVN_STATUS_INFO_COMPARATOR
		once
			create comparator.make_wc_status
			create Result.make (comparator)
		end

	info_repos_status_sorter: QUICK_SORTER [SVN_STATUS_INFO]
		local
			comparator: SVN_STATUS_INFO_COMPARATOR
		once
			create comparator.make_repos_status
			create Result.make (comparator)
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
