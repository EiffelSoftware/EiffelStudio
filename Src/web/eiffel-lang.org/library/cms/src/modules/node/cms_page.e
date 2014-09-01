note
	description: "Summary description for {CMS_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE

inherit
	CMS_NODE

create
	make_new,
	make

feature {NONE} -- Initialization

	make (a_id: like id; a_title: like title; dt: like creation_date)
		require
			a_id > 0
		do
			set_id (a_id)
			creation_date := dt
			modification_date := dt
			title := a_title
			initialize
		end

	make_new (a_title: like title)
		do
			title := a_title
			create creation_date.make_now_utc
			modification_date := creation_date
			initialize
		end

	initialize
		do
			format := formats.default_format
		end

feature -- Access

	title: detachable READABLE_STRING_32

	body: detachable READABLE_STRING_8

	format: CMS_FORMAT

	content_type_name: STRING = "page"

feature -- Change

	set_title (a_title: like title)
			-- Set `title' to `a_title'
		do
			title := a_title
		end

	set_body (a_body: like body; a_format: like format)
			-- Set `body' and associated `format'
		do
			body := a_body
			format := a_format
		end

feature -- Conversion

--	to_html (a_theme: CMS_THEME): STRING_8
--		do
--			Result := Precursor (a_theme)
--		end

end
