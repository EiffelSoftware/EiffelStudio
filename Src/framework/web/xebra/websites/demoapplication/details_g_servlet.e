note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	DETAILS_G_SERVLET

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
				-- row: 1 column: 1 path: ../../websites/demoapplication/details.xeb
			response.append("[

]")
				-- row: 5 column: 8 path: ../../websites/demoapplication/details.xeb
			response.append("[
<html>
<head>

<title>Xebra Demo Application</title>

]")
				-- row: 5 column: 8 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated then
				-- row: 6 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[

	
]")
				-- row: 6 column: 15 path: ../../websites/demoapplication/details.xeb
			response.set_goto_request ("reservations.xeb")
				-- row: 7 column: 9 path: ../../websites/demoapplication/details.xeb
			response.append("[


]")
			end
				-- row: 38 column: 29 path: ../../websites/demoapplication/details.xeb
			response.append("[


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></meta>


<link href="style.css" rel="stylesheet" type="text/css"></link>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="1100" height="499" border="0" cellpadding="0" cellspacing="0" id="Table_01">
	<tr>
		<td><img src="images/template_01.gif" width="20" height="46" alt=""></img></td>
		<td><img src="images/template_02.gif" width="168" height="46" alt=""></img></td>
		<td><img src="images/template_03.gif" width="30" height="46" alt=""></img></td>
		<td><img src="images/template_04.gif" width="862" height="46" alt=""></img></td>
		<td><img src="images/template_05.gif" width="20" height="46" alt=""></img></td>
	</tr>
	<tr>
		<td><img src="images/template_06.gif" width="20" height="28" alt=""></img></td>
		<td><img src="images/template_07.gif" width="168" height="28" alt=""></img></td>
		<td><img src="images/template_08.gif" width="30" height="28" alt=""></img></td>
		<td background="images/login.gif">
		<div align="right">
]")
				-- row: 38 column: 29 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated then
				-- row: 39 column: 29 path: ../../websites/demoapplication/details.xeb
			response.append("[

       Welcome 
]")
				-- row: 39 column: 29 path: ../../websites/demoapplication/details.xeb
			response.append(controller.username.out)
				-- row: 40 column: 11 path: ../../websites/demoapplication/details.xeb
			response.append("[
, <a href="logout.xeb">Logout</a>
		
]")
			end
				-- row: 40 column: 20 path: ../../websites/demoapplication/details.xeb
			response.append("[

]")
				-- row: 40 column: 20 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated then
				-- row: 42 column: 11 path: ../../websites/demoapplication/details.xeb
			response.append("[

			<a href="login.xeb">Login</a>
		
]")
			end
				-- row: 73 column: 12 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
		</td>
		<td><img src="images/template_10.gif" width="20" height="28" alt=""></img></td>
	</tr>
	<tr>
		<td><img src="images/template_11.gif" width="20" height="244" alt=""></img></td>
		<td><img src="images/template_12.gif" width="168" height="244" alt=""></img></td>
		<td><img src="images/template_13.gif" width="30" height="244" alt=""></img></td>
		<td><img src="images/template_14.gif" width="862" height="244" alt=""></img></td>
		<td><img src="images/template_15.gif" width="20" height="244" alt=""></img></td>
	</tr>
	<tr>
		<td></td>
		<td align="left" valign="top">
		<h2 class="style1">Navigation</h2>
		<ul>
			<li><a href="home.xeb">Home</a></li>
			<li><a href="reservations.xeb">Reservations</a></li>
			<li><a href="contact.xeb">Contact</a></li>
		</ul>
		</td>
		<td background="images/template_18.gif"><img src="images/template_18.gif" width="30" height="113" alt=""></img></td>
		<td align="left" valign="top">
		<h2><span class="style1">Reservation Details</span></h2>
		
]")
				-- row: 73 column: 12 path: ../../websites/demoapplication/details.xeb
			controller.edit
				-- row: 81 column: 30 path: ../../websites/demoapplication/details.xeb
			response.append("[
 
		<form action="details.xeb" method="post" id="form1">
		<table width="100%" border="0" cellpadding="0">
			<tr>
				<th scope="row">
				<div align="left">Id</div>
				</th>
				<td>
				<div align="left">
]")
				-- row: 81 column: 30 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated_admin then
				-- row: 82 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 82 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_id_from_args.out)
				-- row: 83 column: 14 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
			end
				-- row: 84 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 84 column: 13 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 86 column: 38 path: ../../websites/demoapplication/details.xeb
			response.append("[

						<input name="id" type="text" id="id" value="
]")
				-- row: 86 column: 38 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_id_from_args.out)
				-- row: 87 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[
"></input>
						
]")
			end
				-- row: 95 column: 30 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
				<div align="left">Name</div>
				</th>
				<td>
				<div align="left">
]")
				-- row: 95 column: 30 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated_admin then
				-- row: 96 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 96 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_name_from_args.out)
				-- row: 97 column: 14 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
			end
				-- row: 98 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 98 column: 13 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 100 column: 40 path: ../../websites/demoapplication/details.xeb
			response.append("[

						<input name="name" type="text" id="name" value="
]")
				-- row: 100 column: 40 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_name_from_args.out)
				-- row: 101 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[
"></input>
						
]")
			end
				-- row: 109 column: 30 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
				<div align="left">Date</div>
				</th>
				<td>
				<div align="left">
]")
				-- row: 109 column: 30 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated_admin then
				-- row: 110 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 110 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_date_from_args.out)
				-- row: 111 column: 14 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
			end
				-- row: 112 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 112 column: 13 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 114 column: 40 path: ../../websites/demoapplication/details.xeb
			response.append("[

						<input name="date" type="text" id="date" value="
]")
				-- row: 114 column: 40 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_date_from_args.out)
				-- row: 115 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[
"></input>
						
]")
			end
				-- row: 123 column: 30 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
				<div align="left">Persons</div>
				</th>
				<td>
				<div align="left">
]")
				-- row: 123 column: 30 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated_admin then
				-- row: 124 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 124 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_persons_from_args.out)
				-- row: 125 column: 14 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
			end
				-- row: 126 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 126 column: 13 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 128 column: 43 path: ../../websites/demoapplication/details.xeb
			response.append("[

						<input name="persons" type="text" id="persons" value="
]")
				-- row: 128 column: 43 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_persons_from_args.out)
				-- row: 129 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[
"></input>
						
]")
			end
				-- row: 137 column: 30 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
				</td>
			</tr>
			<tr>
				<th scope="row">
				<div align="left">Description</div>
				</th>
				<td>
				<div align="left">
]")
				-- row: 137 column: 30 path: ../../websites/demoapplication/details.xeb
			if controller.not_authenticated_admin then
				-- row: 138 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 138 column: 18 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_description_from_args.out)
				-- row: 139 column: 14 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
			end
				-- row: 140 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

					
]")
				-- row: 140 column: 13 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 142 column: 47 path: ../../websites/demoapplication/details.xeb
			response.append("[

						<input name="description" type="text" id="description" value="
]")
				-- row: 142 column: 47 path: ../../websites/demoapplication/details.xeb
			response.append(controller.get_res_description_from_args.out)
				-- row: 143 column: 15 path: ../../websites/demoapplication/details.xeb
			response.append("[
"></input>
						
]")
			end
				-- row: 146 column: 11 path: ../../websites/demoapplication/details.xeb
			response.append("[
</div>
				</td>
			</tr>
			
]")
				-- row: 146 column: 11 path: ../../websites/demoapplication/details.xeb
			if controller.authenticated_admin then
				-- row: 152 column: 13 path: ../../websites/demoapplication/details.xeb
			response.append("[

				<tr>
					<th scope="row"></th>
					<td><input type="submit" name="Submit" id="Submit" value="Submit"></input> </td>
				</tr>
				
]")
			end
				-- row: 174 column: 8 path: ../../websites/demoapplication/details.xeb
			response.append("[

		</table>
		</form>
		</td>
		<td></td>
	</tr>
	<tr>
		<td><img src="images/template_21.gif" width="20" height="68" alt=""></img></td>
		<td><img src="images/template_22.gif" width="168" height="68" alt=""></img></td>
		<td><img src="images/template_23.gif" width="30" height="68" alt=""></img></td>
		<td><img src="images/template_24.gif" width="862" height="68" alt=""></img></td>
		<td><img src="images/template_25.gif" width="20" height="68" alt=""></img></td>
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
