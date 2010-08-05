note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_STATUS_INFO_COMPARATOR

inherit

	COMPARATOR [SVN_STATUS_INFO]

create
	make_path,
	make_wc_status,
	make_repos_status

feature

	make_path
		do
			comparator_id := id_path
		end

	make_wc_status
		do
			comparator_id := id_wc_status
		end

	make_repos_status
		do
			comparator_id := id_repos_status
		end

feature

	id_path: INTEGER = 1
	id_wc_status: INTEGER = 2
	id_repos_status: INTEGER = 3

	comparator_id: INTEGER

	less_than (u, v: SVN_STATUS_INFO): BOOLEAN
		do
			inspect
				comparator_id
			when id_path then
				Result := u.display_path < v.display_path
			when id_wc_status then
				Result := u.wc_status < v.wc_status
			when id_repos_status then
				Result := (u = Void) or else (v.repos_status /= Void and then u.repos_status < v.repos_status)
				Result := u.repos_status < v.repos_status
			else
				check False end
			end
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
