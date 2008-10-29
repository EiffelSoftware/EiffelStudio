indexing

	description:
		"An unix socket."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNIX_SOCKET

inherit

	SOCKET
		undefine
			send, put_character, putchar, put_string, putstring,
			put_integer, putint, put_integer_32, put_boolean, putbool,
			put_integer_8, put_integer_16, put_integer_64,
			put_natural_8, put_natural_16, put_natural, put_natural_32, put_natural_64,
			put_real, putreal, put_double, putdouble, put_managed_pointer
		redefine
			address, cleanup, name
		end

feature -- Status Report

	address: UNIX_SOCKET_ADDRESS;
			-- Local address of socket

	cleanup is
			-- Close socket and unlink it from file system.
		do
			close;
			if address /= Void then
				unlink
			end
		end;

	name: STRING is
			-- Socket name
		require else
			valid_address: address /= Void
		do
			create Result.make (10);
			Result.append (address.path)
		end

feature -- Status setting

	unlink is
			-- Remove associate name from file system.
		require else
			name_address: address /= void
		local
			ext: C_STRING
		do
			create ext.make (name)
			c_unlink (ext.item)
		end

feature {NONE} -- Externals

	c_unlink (nam: POINTER) is
			-- External c routine to remove socket file from file
			-- system
		external
			"C"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class UNIX_SOCKET

