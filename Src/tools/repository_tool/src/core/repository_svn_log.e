note
	description: "Summary description for {REPOSITORY_SVN_LOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_SVN_LOG

inherit
	REPOSITORY_LOG
		redefine
			parent
		end

	SVN_DATE_UTILITIES
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_svn: SVN_REVISION_INFO; a_parent: REPOSITORY_DATA)
		local
			d: like gmt_date_time
		do
			svn_revision := a_svn
			id := a_svn.revision.out
			author := a_svn.author
			date := a_svn.date
			if attached svn_date_values (date) as dvals then
				create d.make (dvals.year, dvals.month, dvals.day, dvals.hour, dvals.min, dvals.sec)
				d.fine_second_add (dvals.fsec)
				gmt_date_time := d
			end
			message := a_svn.log_message
			message.right_adjust

			parent := a_parent
		end

feature -- Access

	parent: REPOSITORY_DATA

	svn_revision: SVN_REVISION_INFO

	id: STRING

	date: STRING

	gmt_date_time: detachable DATE_TIME

	author: STRING

	message: STRING

	paths: LIST [TUPLE [path: STRING; kind: NATURAL_8; action: STRING]]
		do
			Result := svn_revision.paths
		end

	common_parent_path: STRING
		do
			Result := svn_revision.common_parent_path
		end

feature -- Status report

	is_less alias "<" (other: like Current): BOOLEAN
		do
			if parent = other.parent then
				Result := svn_revision < other.svn_revision
			else
				Result := date < other.date
			end
		end

end
