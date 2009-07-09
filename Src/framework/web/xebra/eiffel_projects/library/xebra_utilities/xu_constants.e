note
	description: "Summary description for {XU_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XU_CONSTANTS

feature -- Filenames

	Servlet_gen_executed_file: STRING = "executed_at_time"
	Servlet_gen_name: STRING = "servlet_gen"
	Generated_folder_name: STRING = ".generated"

feature -- Response

	Response_ct_html: STRING = "text/html;charset=ascii"
	Response_ct_xml: STRING = "text/xml"
	Response_Html_start: STRING = "#H#"
	Response_content_type_start: STRING = "#CT#"


feature -- Request Message

	Request_method_get: STRING = "GET"
	Request_method_post: STRING = "POST"
	Request_http11: STRING = "HTTP/1.1"
	Request_http10: STRING = "HTTP/1.0"
	Request_space: STRING = " "
	Request_hi: STRING = "#HI#"
	Request_ho: STRING = "#HO#"
	Request_end: STRING = "#E#"
	Request_se: STRING = "#SE#"
	Request_t_name: STRING = "#$#"
	Request_t_value: STRING = "#%%#"
	Request_arg: STRING = "#A#"
	Request_content_type: STRING = "Content-Type"
	Request_ct_form: STRING = "application/x-www-form-urlencoded"

feature -- Cookie Order

	Cookie_start: STRING = "#C#"
	Cookie_end: STRING = "#CE#"
	Cookie_eq: STRING = "="
	Cookie_sqp: STRING = "; "
	Cookie_sq: STRING = ";"
	Cookie_max_age: STRING = "Max-Age="
	Cookie_path: STRING = "Path="
	Cookie_version: STRING = "Version="
	Cookie_domain: STRING = "Domain="
	Cookie_secure: STRING = "Secure"
	Cookie_comment: STRING = "Comment="


end
