indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_MIDL_LIBRARY

inherit
	EI_MIDL_COMPONENT
		redefine
			make
		end

create
	make

feature {NONE} -- Intialization

	make (l_name: STRING) is
			-- Initialize object.  Set 'name' to 'l_name'.
		do
			Precursor (l_name)
			name.to_lower
		end

feature -- Access

	coclass: EI_MIDL_COCLASS
			-- Coclass

feature -- Element change

	set_coclass (c_class: EI_MIDL_COCLASS) is
			-- Set 'coclass' to 'c_class'.
		require
			non_void_coclass: c_class /= Void
		do
			coclass := c_class
		ensure
			coclass_set: coclass.is_equal (c_class)
		end

feature -- Output

	code: STRING is
			-- Library code
		local
			guid_str: STRING
		do
			Result := "//%R%N// File : "
			Result.append (name)
			Result.append (".idl")
			Result.append ("%R%N// Description : ")
			Result.append (coclass.description)
			Result.append ("%R%N//%R%N%R%Nimport %"oaidl.idl%";%R%N%R%N")
			

			if not coclass.interfaces.is_empty then
				from
					coclass.interfaces.start
				until
					coclass.interfaces.after
				loop
					Result.append (coclass.interfaces.item.code)
					Result.append ("%R%N%R%N")
					coclass.interfaces.forth
				end
			end

			Result.append ("%R%N%(%R%N%Tuuid (")

			guid_str := guid.to_string.twin
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append ("),%R%N%Thelpstring (%"")
			Result.append (description)
			Result.append ("%"),%R%N%Tversion (")
			Result.append_real (version)
			Result.append (")%R%N%)%R%N")

			Result.append ("library ")
			Result.append (name)
			Result.append ("%R%N{%R%N%Timportlib (%"stdole32.tlb%");%R%N")
			Result.append (coclass.code)
			Result.append ("%R%N}")
		ensure
			code_generated: Result /= Void
		end

end -- class EI_MIDL_LIBRARY
