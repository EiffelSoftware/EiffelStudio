indexing
	description: "Encapsulation of a C external extension.";
	date: "$Date$";
	revision: "$Revision$"

class IL_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS

	SHARED_IL_CONSTANTS

feature -- Initialization

	initialize (a_language_type, a_type: INTEGER; a_sig: SIGNATURE_AS; a_class: ID_AS) is
			-- Create IL_EXTENSION_AS node.
		require
			a_type: valid_type (a_type)
			a_class_not_void: a_class /= Void
		do
			type := a_type
			sig := a_sig
			base_class := a_class
		ensure
			type_set: type = a_type
			base_class_set: base_class = a_class
		end

feature -- Properties

	type: INTEGER
			-- Type of IL external.
			--| See SHARED_IL_CONSTANTS for all types constants.

	sig: SIGNATURE_AS
			-- Associated signature of IL external

	base_class: STRING
			-- Name of IL class where feature is defined

feature -- Get the C extension

	extension_i: IL_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
			Result.set_type (type)
			Result.set_base_class (base_class)
			if sig /= Void then
				Result.set_argument_types (sig.arguments_id_array)
				if (sig.return_type_id = 0) then
					Result.set_return_type (Names_heap.void_name_id)
				else
					Result.set_return_type (sig.return_type_id)
				end
			end
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is False
			-- Does a IL external need an encapsulation?

feature -- Byte code

	byte_node: IL_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			create Result
			init_byte_node (Result)
		end

end -- class IL_EXTENSION_AS

