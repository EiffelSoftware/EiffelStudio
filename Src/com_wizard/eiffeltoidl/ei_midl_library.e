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
			Result := "//%N// File : "
			Result.append (name)
			Result.append (".idl")
			Result.append ("%N// Description : ")
			Result.append (coclass.description)
			Result.append ("%N//%N%Nimport %"oaidl.idl%";%N%N")
			

			if not coclass.interfaces.is_empty then
				from
					coclass.interfaces.start
				until
					coclass.interfaces.after
				loop
					Result.append (coclass.interfaces.item.code)
					Result.append ("%N%N")
					coclass.interfaces.forth
				end
			end

			Result.append ("%N%(%N%Tuuid (")

			guid_str := clone (guid.to_string)
			guid_str.remove (1)
			guid_str.remove (guid_str.count)

			Result.append (guid_str)
			Result.append ("),%N%Thelpstring (%"")
			Result.append (description)
			Result.append ("%"),%N%Tversion (")
			Result.append_real (version)
			Result.append (")%N%)%N")

			Result.append ("library ")
			Result.append (name)
			Result.append ("%N{%N%Timportlib (%"stdole32.tlb%");%N")
			Result.append (coclass.code)
			Result.append ("%N}")
		ensure
			code_generated: Result /= Void
		end

end -- class EI_MIDL_LIBRARY
