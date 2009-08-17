note
	description: "[
		Constants for all xebra classes.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_CONSTANTS

feature -- Xebra

	Version: STRING = "Pre-Release"

feature -- Files

	Webapp_config_file: STRING = "config.wapp"
	Taglib_config_file: STRING = "config.taglib"
	Extension_melted: STRING = ".melted"
	Extension_win_exe: STRING = ".exe"
	Extension_ecf: STRING = ".ecf"
	Extension_xeb: STRING = ".xeb"
	Extension_xrpc: STRING = ".xrpc"
	Dir_svn: STRING = ".svn"
	Dir_eifgen: STRING = "EIFGENs"
	Dir_w_code: STRING = "W_code"
	Dir_f_code: STRING = "F_code"


feature -- Server

	Cmd_server_port: INTEGER = 55002
	Http_server_port: INTEGER = 55001
	Max_tcp_clients: INTEGER = 100

feature -- Debugging

	Translator_debug_name: STRING = "XT"

feature -- Completion messages

	Successful_translation: STRING = "System translated."
	Servlet_generation_completed: STRING = "System generated."

feature -- Special Tags

	Render_attribute_name: STRING = "render"
	Css_class_attribute_name: STRING = "css_class"
	Class_attribute_name: STRING = "class"

feature -- Env vars

	Xebra_root_env: STRING = "XEBRA_DEV"
	Xebra_library_env: STRING = "XEBRA_LIBRARY"

feature -- Filenames

	Webapp_voidsafe_postfix: STRING = "-safe"
	Servlet_gen_executed_file: STRING = "sg_executed_at_time"
	Translator_executed_file: STRING = "t_executed_at_time"
	Servlet_gen_name: STRING = "servlet_gen"
	Generated_folder_name: STRING = ".generated"
	Servlet_gen_ecf: STRING = "servlet_gen.ecf"

feature -- Response

	Response_ct_html: STRING = "text/html;charset=ascii"
	Response_ct_xml: STRING = "text/xml"
	Response_Html_start: STRING = "#H#"
	Response_content_type_start: STRING = "#CT#"

feature -- Request Message

	Request_file_upload_iis: STRING = "#FUPI#"
	Request_file_upload_apache: STRING = "#FUPA#"
	Request_file_upload_filename: STRING = "#FN#"
	Request_method_get: STRING = "GET"
	Request_method_post: STRING = "POST"
	Request_http: STRING = "HTTP/"
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
	Request_post_too_big: STRING = "#PTB#"

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

feature -- Time

	Two_seconds_in_nanoseconds: NATURAL = 2000000000

feature -- Translator

	Folder_replacement_string: STRING = "___"



end
