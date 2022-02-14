note
	description: "Summary description for {ES_CLOUD_USER_PROFILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_USER_PROFILE

create
	make

feature {NONE} -- Initialization

	make (a_user: CMS_USER)
		do
			cms_user := a_user
		end

feature -- Access

	cms_user: CMS_USER

	about_wikitext: detachable IMMUTABLE_STRING_32

feature -- Status report

	is_empty: BOOLEAN
			-- Is profile empty ?
		do
			Result := about_wikitext = Void
		end

feature -- Element change

	set_about_wikitext (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				about_wikitext := Void
			else
				create about_wikitext.make_from_string_general (t)
			end
		end

end
