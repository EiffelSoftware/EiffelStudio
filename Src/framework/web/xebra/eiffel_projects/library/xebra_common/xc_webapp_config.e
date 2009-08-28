note
	description: "[
		Contains configuration info about a webapp.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_CONFIG

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create name.make_empty
			create port.make_empty
			create server_host.make_empty
			create webapp_host.make_empty
			create ecf.make_empty
			create arg_config.make_empty
			create {ARRAYED_LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]} taglibs.make (3)
		ensure then
			arg_config_attached: arg_config /= Void
			name_attached: name /= Void
			ecf_attached: ecf /= Void
			server_host_attached: server_host /= Void
			port_attached: port /= Void
			taglibs_attached: taglibs /= Void
			webapp_host_attached: webapp_host /= Void
		end

feature -- Access

	ecf: SETTABLE_STRING assign set_ecf
		-- The ecf file path of the application.

	name: SETTABLE_STRING assign set_name
		-- The name of the application.

	server_host: SETTABLE_STRING assign set_server_host
		-- The server_host address.

	webapp_host: SETTABLE_STRING assign set_webapp_host
		-- The server_host address, this is only used for unmanaged (remote) webapps.

	port: SETTABLE_INTEGER
		-- The port on which the application listens.

	taglibs: LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]
		-- Specifies the taglibs the webapp is using.

	arg_config: XC_WEBAPP_ARG_CONFIG
			-- The config settings read from the execute arguments.	

	is_interactive: BOOLEAN
			-- Specifies if the webapp is executed in interactive mode. This property is not set by the file but by the execution arguements.			

feature -- Status setting

	set_is_interactive (a_is_interactive: like is_interactive)
			-- Sets name
		require
			a_is_interactive_attached: a_is_interactive /= Void
		do
			is_interactive := a_is_interactive
		ensure
			is_interactive_set: is_interactive = a_is_interactive
		end

	set_ecf (a_ecf: like ecf)
			-- Sets ecf
		require
			a_ecf_attached: a_ecf /= Void
		do
			ecf := a_ecf
		ensure
			ecf_set: ecf = a_ecf
		end

	set_name (a_name: like name)
			-- Sets name
		require
			a_name_attached: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_server_host (a_server_host: like server_host)
			-- Sets server_host
		require
			a_server_host_attached: a_server_host /= Void
		do
			server_host := a_server_host
		ensure
			server_host_set: server_host = a_server_host
		end

	set_webapp_host (a_webapp_host: like webapp_host)
			-- Sets webapp_host
		require
			a_webapp_host_attached: a_webapp_host /= Void
		do
			webapp_host := a_webapp_host
		ensure
			webapp_host_set: webapp_host = a_webapp_host
		end

	set_port  (a_port: INTEGER)
			-- Sets port
		require
			a_port_attached: a_port /= Void
		do
			port  := a_port
		ensure
			port_set: port  = port
		end

	copy_from (a_other: like current)
			-- Copies all fields
		require
			arg_config_attached: a_other.arg_config /= Void
			name_attached: a_other.name /= Void
			ecf_attached: a_other.ecf /= Void
			server_host_attached: a_other.server_host /= Void
			port_attached: a_other.port /= Void
			taglibs_attached: a_other.taglibs /= Void
			webapp_host_attached: a_other.webapp_host /= Void
		do
			name := a_other.name
			port := a_other.port
			server_host := a_other.server_host
			webapp_host := a_other.webapp_host
			ecf := a_other.ecf
			arg_config := a_other.arg_config
			taglibs := a_other.taglibs
		ensure then
			arg_config_attached: arg_config /= Void
			name_attached: name /= Void
			ecf_attached: ecf /= Void
			server_host_attached: server_host /= Void
			port_attached: port /= Void
			taglibs_attached: taglibs /= Void
			webapp_host_attached: webapp_host /= Void
		end

invariant
	arg_config_attached: arg_config /= Void
	name_attached: name /= Void
	server_host_attached: server_host /= Void
	webapp_host_attached: webapp_host /= Void
	port_attached: port /= Void
	ecf_attached: ecf /= Void
	taglibs_attached: taglibs /= Void
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

