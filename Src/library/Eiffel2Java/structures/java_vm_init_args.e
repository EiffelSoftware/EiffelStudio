indexing
	description: "Description of the JavaVMInitArgs structure."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VM_INIT_ARGS

inherit
	MEMORY_STRUCTURE

create
	make

feature -- Constants

	Jni_version_1_1: INTEGER is 0x00010001
	Jni_version_1_2: INTEGER is 0x00010002
	Jni_version_1_4: INTEGER is 0x00010004
			-- Possible version numbers for `version'.

feature -- Access

	version: INTEGER is
			-- Version of JNI.
		do
			Result := c_version (item)
		end

	number_of_option: INTEGER is
			-- Number of version in Current.
		do
			Result := c_n_options (item)
		end
		
	options: ARRAY [JAVA_VM_OPTION] is
			-- List all options.
		require
			options_set: options_set
		local
			i, nb: INTEGER
		do
			Result := internal_options
		ensure
			options_count_valid: number_of_option = options.count
		end
		
feature -- Status report

	is_valid_version (a_version: INTEGER): BOOLEAN is
		do
			Result :=
				a_version = Jni_version_1_1 or
				a_version = Jni_version_1_2 or
				a_version = Jni_version_1_4
		end
		
	options_set: BOOLEAN is
			-- Has `options' been set?
		do
			Result := internal_options /= Void
		end
		
feature -- Settings

	set_version (a_version: INTEGER) is
			-- Set `version' with `a_version'.
		require
			is_valid_version: is_valid_version (a_version)
		do
			c_set_version (item, a_version)
		ensure
			version_set: version = a_version
		end

	set_options (a_options: ARRAY [JAVA_VM_OPTION]) is
			-- Set `options' with `a_options'.
		require
			a_options_not_void: a_options /= Void
		local
			i, j, nb: INTEGER
			l_option: JAVA_VM_OPTION
		do
			from
				i := a_options.lower
				nb := a_options.upper
				create l_option.make
				create internal_options_area.make (nb * l_option.structure_size)
				c_set_options (item, internal_options_area.item)
				c_set_n_options (item, a_options.count)
				create internal_options.make (1, a_options.count)
				j := 1
			until
				i > nb
			loop
				internal_options.put (a_options.item (i), j)
				(internal_options_area.item + (j - 1) * l_option.structure_size).memory_copy (
					internal_options.item (j).item, l_option.structure_size)
				i := i + 1
				j := j + 1
			end
		ensure
			
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure being allocated.
		do
			Result := c_structure_size
		end
		
feature {NONE} -- Implementation

	internal_options: ARRAY [JAVA_VM_OPTION]
			-- Hold all C string values.
	
	internal_options_area: MANAGED_POINTER
			-- Hold area where value of `internal_options' are stored.

	c_structure_size: INTEGER is
			-- Size of `JavaVMOption' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(JavaVMInitArgs)"
		end
		
	c_version (an_item: POINTER): INTEGER is
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access version use %"jni.h%""
		end

	c_n_options (an_item: POINTER): INTEGER is
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access nOptions use %"jni.h%""
		end

	c_set_version (an_item: POINTER; a_version: INTEGER) is
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access version type jint use %"jni.h%""
		end

	c_set_n_options (an_item: POINTER; a_nb: INTEGER) is
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access nOptions type jint use %"jni.h%""
		end

	c_set_options (an_item: POINTER; a_ptr: POINTER) is
			-- Access to `version'.
		external
			"C struct JavaVMInitArgs access options type JavaVMOption * use %"jni.h%""
		end
		
end -- class JAVA_VM_INIT_ARGS
