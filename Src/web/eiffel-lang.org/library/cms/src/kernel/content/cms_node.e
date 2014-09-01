note
	description: "Summary description for {WSF_CMS_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE

feature -- Access

	id: INTEGER
			-- Unique identifier of Current.

	title: detachable READABLE_STRING_32
			-- Associated title (optional).
		deferred
		end

	body: detachable READABLE_STRING_8
			-- Body of Current.
		deferred
		end

	format: CMS_FORMAT
			-- Format associated with `body'
		deferred
		end

	content_type_name: STRING
			-- Associated content type name
		deferred
		end

feature -- status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

feature -- Access: status

	author: detachable CMS_USER

	creation_date: DATE_TIME

	modification_date: DATE_TIME

feature -- Change

	set_id (a_id: like id)
		require
			not has_id
		do
			id := a_id
		end

	set_author (u: like author)
		do
			author := u
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		local
			d: STRING
		do
			Result := "<div class=%"node " + content_type_name + "%" id=%"nid-" + id.out + "%">"
			if attached title as l_title then
				Result.append ("<div class=%"title%">" + a_theme.node_link (Current) + "</div>")
			end
			create d.make_empty
			if attached author as u then
				d.append ("by " + a_theme.user_link (u) + " ")
			end
			if attached modification_date as dt then
				d.append ("last modified: " + dt.year.out + "/" + dt.month.out + "/" + dt.day.out + "")
			end
			if not d.is_empty then
				Result.append ("<div class=%"description%">")
				Result.append (d)
				Result.append ("</div>")
			end
			if attached body as b then
				Result.append ("<div class=%"inner%">")
				Result.append (format.to_html (b))
				Result.append ("</div>")
			end
			Result.append ("</div>")
		end

feature {NONE} -- Implementation: helper

	formats: CMS_FORMATS
		once
			create Result
		end

end
