note
	description: "Description of the JavaVMInitArgs structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VM_INIT_ARGS

inherit
	MEMORY_STRUCTURE

create
	make

feature -- Constants

	Jni_version_1_1: INTEGER = 0x00010001
	Jni_version_1_2: INTEGER = 0x00010002
	Jni_version_1_4: INTEGER = 0x00010004
			-- Possible version numbers for `version'.

feature -- Access

	version: INTEGER
			-- Version of JNI.
		do
			Result := c_version (item)
		end

	number_of_option: INTEGER
			-- Number of version in Current.
		do
			Result := c_n_options (item)
		end

	options: ARRAY [JAVA_VM_OPTION]
			-- List all options.
		require
			options_set: options_set
		local
			l_result: ?like internal_options
		do
			l_result := internal_options
			check l_result_not_void: l_result /= Void end -- Implied from the precondition
			Result := l_result
		ensure
			options_count_valid: number_of_option = options.count
		end

feature -- Status report

	is_valid_version (a_version: INTEGER): BOOLEAN
		do
			Result :=
				a_version = Jni_version_1_1 or
				a_version = Jni_version_1_2 or
				a_version = Jni_version_1_4
		end

	options_set: BOOLEAN
			-- Has `options' been set?
		do
			Result := internal_options /= Void
		end

feature -- Settings

	set_version (a_version: INTEGER)
			-- Set `version' with `a_version'.
		require
			is_valid_version: is_valid_version (a_version)
		do
			c_set_version (item, a_version)
		ensure
			version_set: version = a_version
		end

	set_options (a_options: ARRAY [JAVA_VM_OPTION])
			-- Set `options' with `a_options'.
		require
			a_options_not_void: a_options /= Void
		local
			i, j, nb: INTEGER
			l_option: JAVA_VM_OPTION
			l_internal_options: like internal_options
			l_options_area: MANAGED_POINTER
		do
			from
				i := a_options.lower
				nb := a_options.upper
				create l_option.make
				create l_options_area.make (nb * l_option.structure_size)
				c_set_options (item, l_options_area.item)
				c_set_n_options (item, a_options.count)
				create l_internal_options.make (1, a_options.count)
				internal_options := l_internal_options
				j := 1
			until
				i > nb
			loop
				l_internal_options.put (a_options.item (i), j)
				(l_options_area.item + (j - 1) * l_option.structure_size).memory_copy (
					l_internal_options.item (j).item, l_option.structure_size)
				i := i + 1
				j := j + 1
			end
		ensure

		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure being allocated.
		do
			Result := c_structure_size
		end

feature {NONE} -- Implementation

	internal_options: ?ARRAY [JAVA_VM_OPTION]
			-- Hold all C string values.

	c_structure_size: INTEGER
			-- Size of `JavaVMOption' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(JavaVMInitArgs)"
		end

	c_version (an_item: POINTER): INTEGER
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access version use %"jni.h%""
		end

	c_n_options (an_item: POINTER): INTEGER
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access nOptions use %"jni.h%""
		end

	c_set_version (an_item: POINTER; a_version: INTEGER)
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access version type jint use %"jni.h%""
		end

	c_set_n_options (an_item: POINTER; a_nb: INTEGER)
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access nOptions type jint use %"jni.h%""
		end

	c_set_options (an_item: POINTER; a_ptr: POINTER)
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access options type JavaVMOption * use %"jni.h%""
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




end -- class JAVA_VM_INIT_ARGS

