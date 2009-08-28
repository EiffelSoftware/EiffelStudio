note
	description: "[
		Provides basic deferred features to generate a nice response that is sent back to the http server
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	X_RESPONSE

feature -- Initialization

	make (a_arg: STRING)
			-- Initialization for Current
			-- a_arg can be empty
		do
			arg := a_arg
		ensure
			arg_set: arg = a_arg
		end

feature -- Access

	arg: STRING
		-- Can be used to pass an argument to the message

	message: STRING
			-- The message
		deferred
		ensure
			result_attached: Result /= Void
		end

	producer: STRING
			-- The producer of this error message
		deferred
		ensure
			result_attached: Result /= Void
		end

	has_refresh: BOOLEAN
			-- Redefine to true to autoamtically refresh the page
		do
			Result := False
		ensure
			result_attached: Result /= Void
		end


feature -- Status report

	render_to_response: XH_RESPONSE
			-- Converts current into a response
		do
			create Result.make_empty
			Result.append (html)
		ensure
			result_attached: Result /= Void
		end

	render_to_command_response: XCCR_HTTP_REQUEST
			-- Converts current into a response
		do
			create Result.make (render_to_response)
		ensure
			result_attached: Result /= Void
		end


feature -- Html code generation

	head: STRING
			-- Use this to add items to the head
		do
			Result := ""
			if has_refresh then
				Result.append ("<meta http-equiv=%"refresh%" content=%"100%">")
			end
		ensure
			result_attached: Result /= Void
		end

	title: STRING
			-- The type (title) of the Response
		deferred
		ensure
			result_attached: Result /= Void
		end

	deco_color: STRING
			-- The color of the decoration
		deferred
		ensure
			result_attached: Result /= Void
		end

	img: STRING
			-- The image place holder
		deferred
		ensure
			result_attached: Result /= Void
		end

	html: STRING
				-- HTML code for the message
		do
			Result := "[
			<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
			<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
			]" + head +	"[
			<title>
			]" + producer +	"[
			- 
			]" + title + "[
			</title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<style type="text/css">
			<!--
			body, td, th {
				font-family: Geneva, Arial, Helvetica, sans-serif;
				font-size: 12px;
			}
			h1 {
				font-size: 18px;
				background-color:
			]" + deco_color + "[
			;
				color: #FFFFFF;
			}
			h3 {
				font-size: 14px;
				background-color:
			]" + deco_color + "[
			;
				color: #FFFFFF;
			}
			.em {
				font-size: 14px;
				background-color:
			]" + deco_color + "[
			;
				color: #FFFFFF;
				margin-right: 10px;
				font-weight: bold;
			}
			-->
			</style>
			</head>
			<body>
			<h1>
			]" + producer + "[
			]" + title + "[
			</h1>
			<hr/>
			<p><span class="em">Message:</span>
			]" + message + "[
			</p>
			<p>
			]" + img + "[
			</p>
			<hr/>
			<h3>
			]" + producer +	 {XU_CONSTANTS}.Version + "[
			</h3>
			</body>
			</html>
			]"
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

