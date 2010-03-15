note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class FILE2DBMS

inherit

	CONVERTER
		rename
			make as converter_make
		export
			{NONE} container, container_size
		redefine
			store_object
		end

create -- Creation procedures

	make

feature -- Initialization

	make
		do
			converter_make;
			create store.make;
			create control.make
		end;

feature -- Status setting

	set_repository (new_repository: DB_REPOSITORY)
			-- Set storage repository with `new_repository'.
		require
			repository_not_void: new_repository /= Void
		do
			store.set_repository(new_repository)
		ensure
			owns_repository: owns_repository
		end;

feature  -- Status report

	owns_repository: BOOLEAN
			-- Is Current attached to a repository?
		do
			Result := store.owns_repository
		end;

feature {NONE} -- Status report

	store: DB_STORE

	control: DB_CONTROL

feature {NONE} -- Basic operations

	store_object
			-- Insert each retrieved object from external file into database.
		local
			l_conv_message: like conv_message
			l_reference: detachable ANY
		do
			l_reference := parse.ecp_reference
			check l_reference /= Void end -- implied by precursor's precondition and `parse''s invariant `ecp_reference_not_void'
			store.put(l_reference);
			if not control.is_ok then
				conv_error := true;
				conv_message := control.error_message
				l_conv_message := conv_message
				if l_conv_message /= Void then
					conv_message := l_conv_message.twin
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FILE2DBMS




