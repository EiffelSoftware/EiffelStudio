note
	description: "Summary description for {GTK_SIGNAL_CONNECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_SIGNAL_MARSHAL_CONNECTION

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Intialization

	make (a_c_object: POINTER; a_conn_id: like connection_id)
		do
--			c_object := a_c_object
			c_object := {GDK}.g_object_ref (a_c_object)
			connection_id := a_conn_id
			is_connected := a_conn_id /= 0
		end

feature -- Access

	c_object: POINTER

	connection_id: INTEGER_32

feature -- Basic operation

	close
			-- Close connection `connection_id` for object `c_object`.
		do
			if
				is_connected and then
				not c_object.is_default_pointer
			then
				{GTK2}.signal_disconnect (c_object, connection_id)
				is_connected := False
			end
		end

feature -- Status

	is_connected: BOOLEAN

feature -- Disposal

	dispose
		do
--			close
			if not c_object.is_default_pointer then
				{GDK}.g_object_unref (c_object)
				c_object := default_pointer
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
