note
	description: "Summary description for {HTML_SAFE_REDIRECTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_SAFE_REDIRECTION

inherit
	HTML_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make, make_safe

feature {NONE} --Initialization

	make (a_path: PATH; a_safe_download_page_url: READABLE_STRING_8; a_download_location: READABLE_STRING_8; a_user, a_pwd: READABLE_STRING_8; a_new_download_location: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			download_location := a_download_location
			username := a_user
			password := a_pwd
			new_download_location := a_new_download_location
			safe_download_page_url := a_safe_download_page_url

			set_template_folder (a_path)
			set_template_file_name ("html_safe_redirection.tpl")

			template.add_value (a_safe_download_page_url, "safe_download_page_url")
			template.add_value (a_download_location, "download_location")
			template.add_value (a_user, "username")
			template.add_value (a_pwd, "password")
			template.add_value (a_new_download_location, "new_download_location")
			process
		end

	make_safe (a_path: PATH; a_download_location: READABLE_STRING_8; a_user, a_pwd: READABLE_STRING_8; a_new_download_location: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			download_location := a_download_location
			username := a_user
			password := a_pwd
			new_download_location := a_new_download_location

			set_template_folder (a_path)
			set_template_file_name ("html_safe_redirection_confirmation.tpl")

			template.add_value (a_download_location, "download_location")
			template.add_value (a_user, "username")
			template.add_value (a_pwd, "password")
			template.add_value (a_new_download_location, "new_download_location")
			process
		end

feature -- Access		

	safe_download_page_url: detachable READABLE_STRING_8

	download_location: IMMUTABLE_STRING_8

	username: IMMUTABLE_STRING_8

	password: IMMUTABLE_STRING_8

	new_download_location: IMMUTABLE_STRING_8

feature -- Access

	to_html: STRING_8
		local
			b: like representation
		do
			b := representation
			if b = Void then
				create b.make (1024)
				b.append ("<div style=%"width: 80%%; margin: 2em auto auto; %">")
				if attached safe_download_page_url as l_safe_download_page_url then
					b.append ("<div style=%"padding: 5px; border: solid 1px blue; background-color: #fff; %">")
					b.append ("<strong>Please download the file using the link</strong>:<ul><li><a href=%"" + download_location + "%">" + download_location + "</a></li></ul>")
					b.append ("</div>")
					b.append ("<div style=%"margin-top: 10px; padding: 5px; border: solid 1px #333; background-color: #ddd;%">")
					b.append ("<strong>Note</strong>: if you have trouble downloading using the previous link,<br/><br/><ul><li>Please <a href=%"" + l_safe_download_page_url + "%">Press here</a></li></ul>")
					b.append ("</div>")
				else
					b.append ("<div style=%"padding: 5px; border: solid 1px blue; background-color: #fff; %">")
					b.append ("<strong>Please download the file using the link</strong>:<ul><li><a href=%"" + new_download_location + "%">" + new_download_location + "</a></li></ul>")
					b.append ("<br/> ")
					b.append ("And when asked, use the values:<ul><li>username: <input type=%"text%" size=%"" + username.count.out + "%" value=%""+ username + "%"></input></li><li>password: <input type=%"text%" size=%"" + password.count.out + "%" value=%""+ password + "%"></input></li></ul>")
					b.append ("</div>")
				end
				b.append ("</div>")
			end
			Result := b
		end

end
