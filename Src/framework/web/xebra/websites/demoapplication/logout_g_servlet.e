note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGOUT_G_SERVLET

inherit
	XWA_STATELESS_SERVLET

create
	make

feature-- Access

	controller: DEMOAPPLICATION_CONTROLLER

feature-- Implementation

	make
		do
			base_make
			create controller.make
		end

	internal_controller: XWA_CONTROLLER
		do
			Result := controller
		end

	handle_request (request: XH_REQUEST; response: XH_RESPONSE)
		do
				-- row: 1 column: 1 path: ../../websites/demoapplication/logout.xeb
			response.append("[

]")
				-- row: 34 column: 16 path: ../../websites/demoapplication/logout.xeb
			response.append("[
<html>
<head>

<title>Xebra Demo Application</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></meta>

<link href="style.css" rel="stylesheet" type="text/css"></link>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="1100" height="499" border="0" cellpadding="0" cellspacing="0" id="Table_01">
<tr>
		<td>
			<img src="images/template_01.gif" width="20" height="46" alt=""></img></td>
		<td>
			<img src="images/template_02.gif" width="168" height="46" alt=""></img></td>
		<td>
			<img src="images/template_03.gif" width="30" height="46" alt=""></img></td>
		<td>
			<img src="images/template_04.gif" width="862" height="46" alt=""></img></td>
		<td>
			<img src="images/template_05.gif" width="20" height="46" alt=""></img></td>
  </tr>
	<tr>
		<td>
			<img src="images/template_06.gif" width="20" height="28" alt=""></img></td>
		<td>
			<img src="images/template_07.gif" width="168" height="28" alt=""></img></td>
		<td>
			<img src="images/template_08.gif" width="30" height="28" alt=""></img></td>
		<td background="images/login.gif"><div align="right">
        
        
]")
				-- row: 34 column: 16 path: ../../websites/demoapplication/logout.xeb
			if controller.authenticated then
				-- row: 35 column: 29 path: ../../websites/demoapplication/logout.xeb
			response.append("[

       Welcome 
]")
				-- row: 35 column: 29 path: ../../websites/demoapplication/logout.xeb
			response.append(controller.username.out)
				-- row: 36 column: 17 path: ../../websites/demoapplication/logout.xeb
			response.append("[
, <a href="logout.xeb">Logout</a>
        
]")
			end
				-- row: 37 column: 16 path: ../../websites/demoapplication/logout.xeb
			response.append("[

        
]")
				-- row: 37 column: 16 path: ../../websites/demoapplication/logout.xeb
			if controller.not_authenticated then
				-- row: 39 column: 17 path: ../../websites/demoapplication/logout.xeb
			response.append("[

       <a href="login.xeb">Login</a>
       
]")
			end
				-- row: 66 column: 18 path: ../../websites/demoapplication/logout.xeb
			response.append("[
</div></td>
<td>
			<img src="images/template_10.gif" width="20" height="28" alt=""></img></td>
	</tr>
	<tr>
		<td>
			<img src="images/template_11.gif" width="20" height="244" alt=""></img></td>
		<td>
			<img src="images/template_12.gif" width="168" height="244" alt=""></img></td>
		<td>
			<img src="images/template_13.gif" width="30" height="244" alt=""></img></td>
		<td>
			<img src="images/template_14.gif" width="862" height="244" alt=""></img></td>
		<td>
			<img src="images/template_15.gif" width="20" height="244" alt=""></img></td>
	</tr>
	<tr>
		<td></td>
		<td align="left" valign="top"><h2 class="style1">Navigation</h2>
		  <ul><li><a href="home.xeb">Home</a></li>
		  <li><a href="reservations.xeb">Reservations</a></li>
		  <li><a href="contact.xeb">Contact</a></li>
	    </ul></td>
  <td background="images/template_18.gif">
			<img src="images/template_18.gif" width="30" height="113" alt=""></img></td>
		<td align="left" valign="top">
        
        
]")
				-- row: 66 column: 18 path: ../../websites/demoapplication/logout.xeb
			controller.logout
				-- row: 88 column: 28 path: ../../websites/demoapplication/logout.xeb
			response.append("[

        You have successfully been logged out.
		
		
		</td>
  <td></td>
  </tr>
	<tr>
		<td>
			<img src="images/template_21.gif" width="20" height="68" alt=""></img></td>
		<td>
			<img src="images/template_22.gif" width="168" height="68" alt=""></img></td>
		<td>
			<img src="images/template_23.gif" width="30" height="68" alt=""></img></td>
		<td>
			<img src="images/template_24.gif" width="862" height="68" alt=""></img></td>
		<td>
			<img src="images/template_25.gif" width="20" height="68" alt=""></img></td>
	</tr>
</table>

</body>
</html>
]")
		end

	prehandle_post_request (request: XH_REQUEST; response: XH_RESPONSE)
		do
		end

	prehandle_get_request (request: XH_REQUEST; response: XH_RESPONSE)
		do
		end

	afterhandle_request (request: XH_REQUEST; response: XH_RESPONSE)
		do
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
		]"end
