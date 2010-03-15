note
	description: "Description of the JavaVMOption structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VM_OPTION

inherit
	MEMORY_STRUCTURE

create
	make

feature -- Access

	option_string: detachable STRING
			-- Associated option string.
			--| FIXME: This is a bad design, since a query should not change an attribute.
		local
			l_internal_option: like internal_option
		do
			l_internal_option := internal_option
			if l_internal_option /= Void then
				Result := l_internal_option.string
			else
				create internal_option.make_by_pointer (c_option_string (item))
			end
		end

feature -- Settings

	set_option_string (an_option: STRING)
			-- Set `an_option' to `option_string'.
		require
			an_option_not_void: an_option /= Void
		local
			l_internal_option: like internal_option
		do
			create l_internal_option.make (an_option)
			internal_option := l_internal_option
			c_set_option_string (item, l_internal_option.item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure being allocated.
		do
			Result := c_structure_size
		end

feature {NONE} -- Implementation

	internal_option: detachable C_STRING
			-- To hold data.

	c_structure_size: INTEGER
			-- Size of `JavaVMOption' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(JavaVMOption)"
		end

	c_option_string (an_item: POINTER): POINTER
			-- Access to `optionString'.
		external
			"C struct JavaVMOption access optionString use %"jni.h%""
		end

	c_extra_info (an_item: POINTER): POINTER
			-- Access to `extraInfo'.
		external
			"C struct JavaVMOption access extraInfo use %"jni.h%""
		end

	c_set_option_string (an_item: POINTER; l_val: POINTER)
			-- Access to `optionString'.
		external
			"C struct JavaVMOption access optionString type char * use %"jni.h%""
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class JAVA_VM_OPTION

