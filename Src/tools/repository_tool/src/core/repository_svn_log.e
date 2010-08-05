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

create
	make

feature {NONE} -- Initialization

	make (a_svn: SVN_REVISION_INFO; a_parent: REPOSITORY_SVN_DATA)
		do
			svn_revision := a_svn
			id := a_svn.revision.out
			author := a_svn.author
			date := a_svn.date
			message := a_svn.log_message
			message.right_adjust

			parent := a_parent
		end

feature -- Access

	parent: REPOSITORY_SVN_DATA

	svn_revision: SVN_REVISION_INFO

	id: STRING

	date: STRING

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
			Result := svn_revision < other.svn_revision
		end

end
