note
	description: "Summary description for {SVN_REPOSITORY_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_REPOSITORY_INFO

create
	make

feature {NONE} -- Initialization

	make (a_localisation: READABLE_STRING_8)
		do
			localisation := a_localisation
		end

feature -- Access

	localisation: STRING_32 assign set_localisation
	url: detachable STRING assign set_url
	repository_root: detachable STRING_32 assign set_repository_root
	repository_uuid: detachable STRING assign set_repository_uuid
	revision: INTEGER assign set_revision
	last_changed_author: detachable STRING_32 assign set_last_changed_author
	last_changed_rev: INTEGER assign set_last_changed_rev
	last_changed_date: detachable STRING assign set_last_changed_date

feature -- Element change

	set_localisation (v: STRING_32)
		do
			localisation := v
		end

	set_url (v: detachable STRING)
		do
			url := v
		end

	set_repository_root (v: detachable STRING_32)
		do
			repository_root := v
		end

	set_repository_uuid (v: detachable STRING)
		do
			repository_uuid := v
		end

	set_revision (v: INTEGER)
		do
			revision := v
		end

	set_last_changed_author (v: detachable STRING_32)
		do
			last_changed_author := v
		end

	set_last_changed_rev (v: INTEGER)
		do
			last_changed_rev := v
		end

	set_last_changed_date (v: detachable STRING)
		do
			last_changed_date := v
		end

;note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
