note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_SUPPORT_SERVER_CONN_HANDLER

inherit
	XWA_SERVER_CONN_HANDLER

create
	make

feature-- Access

feature-- Implementation

	add_servlets
			--<Precursor>
		do
			stateless_servlets.put (create {G_PROTECTED___DOWNLOAD_DESCRIPTION_SERVLET}.make, "/support/protected/download_description.xeb")
			stateless_servlets.put (create {G_PROTECTED___DOWNLOAD_TO_REPRODUCE_SERVLET}.make, "/support/protected/download_to_reproduce.xeb")
			stateless_servlets.put (create {G_PROTECTED___SUBMITTED_SERVLET}.make, "/support/protected/submitted.xeb")
			stateless_servlets.put (create {G_PROTECTED___RESPONSIBLES___SUBSCRIBERS_SERVLET}.make, "/support/protected/responsibles/subscribers.xeb")
			stateless_servlets.put (create {G_PROTECTED___RESPONSIBLES___REGISTER_SERVLET}.make, "/support/protected/responsibles/register.xeb")
			stateless_servlets.put (create {G_PROTECTED___RESPONSIBLES___DEFAULT_SERVLET}.make, "/support/protected/responsibles/default.xeb")
			stateless_servlets.put (create {G_PROTECTED___DOWNLOAD_ATTACHMENT_SERVLET}.make, "/support/protected/download_attachment.xeb")
			stateless_servlets.put (create {G_PROTECTED___ADD_INTERACTION_SERVLET}.make, "/support/protected/add_interaction.xeb")
			stateless_servlets.put (create {G_PROTECTED___DEFAULT_SERVLET}.make, "/support/protected/default.xeb")
			stateless_servlets.put (create {G_PROTECTED___PROBLEM_REPORT_FORM_SERVLET}.make, "/support/protected/problem_report_form.xeb")
			stateless_servlets.put (create {G_PROTECTED___REPORT_SERVLET}.make, "/support/protected/report.xeb")
			stateless_servlets.put (create {G_PROTECTED___DOWNLOAD_INTERACTION_SERVLET}.make, "/support/protected/download_interaction.xeb")
			stateless_servlets.put (create {G_PROTECTED___SUBMITTED_INTERACTION_SERVLET}.make, "/support/protected/submitted_interaction.xeb")
			stateless_servlets.put (create {G_HOWTO_SERVLET}.make, "/support/howto.xeb")
			stateless_servlets.put (create {G_DEFAULT_SERVLET}.make, "/support/default.xeb")
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
