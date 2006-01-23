indexing

	description:
		"Key used to hash callbacks on"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MEL_CALLBACK_KEY

inherit

	HASHABLE
		redefine
			is_equal
		end

create
	make_motif, 
	make_xt_event, 
	make_wm_protocol

feature {NONE} -- Initialization

	make_motif (a_resource: POINTER) is
			-- Create a motif callback key with
			-- hash code from `a_resource'
		require
			valid_resource: a_resource /= default_pointer
		do
			type := motif_type;
			hash_code := a_resource.hash_code
		end;

	make_xt_event (a_mask: like hash_code) is
			-- Create an xt event callback key with
			-- hash code `a_mask'
		do
			type := xt_event_type;
			hash_code := a_mask
		end;

	make_wm_protocol (an_atom: POINTER) is
			-- Create a wm protocol callback key with
			-- hash code from `an_atom'
		do
			type := wm_protocol_type;
			hash_code := an_atom.hash_code
		end;

feature -- Access

	hash_code: INTEGER;
			-- Hash code of key

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' key equal to Current.
		do
			Result := type = other.type and then
				hash_code = other.hash_code
		end;

feature {MEL_CALLBACK_KEY} -- Implementation

	type: INTEGER
			-- Type of key

	valid_type: BOOLEAN is
			-- Is the type valid?
		do
			Result := type >= motif_type and then type <= wm_protocol_type
		end

feature {NONE} -- Implementation

	motif_type: INTEGER is unique;
	xt_event_type: INTEGER is unique;
	wm_protocol_type: INTEGER is unique;
	translation_type: INTEGER is unique;

invariant

	valid_type: type >= motif_type and then type <= translation_type

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




end -- class MEL_CALLBACK_TABLE


