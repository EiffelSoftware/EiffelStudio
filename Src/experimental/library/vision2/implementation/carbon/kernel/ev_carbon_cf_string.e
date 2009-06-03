note
	description: "Objects that wraps a Carbon CFString. CFStrings are ofteh used for putting text on controls in Carbon."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CARBON_CF_STRING

inherit
	DISPOSABLE

	CFSTRING_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CFBASE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make_unshared_with_eiffel_string,
	make_shared,
	make_unshared

convert
	make_unshared_with_eiffel_string ({STRING_GENERAL, STRING, STRING_32})

feature {NONE} -- Initialization

	make_unshared (a_ptr: POINTER)
			-- Set `item' to `a_ptr'
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- CFRelease will be called
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			encoding := {CFSTRING_BUILT_IN_ENCODINGS_ENUM_EXTERNAL}.kCFStringEncodingASCII
			item := a_ptr
			is_shared := false
		ensure
			item_set : item = a_ptr
		end

	make_shared (a_ptr: POINTER)
			-- Set `item' to  `a_ptr'.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- CFRelease will not be called
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			encoding := {CFSTRING_BUILT_IN_ENCODINGS_ENUM_EXTERNAL}.kCFStringEncodingASCII
			item := a_ptr
			is_shared := true
		ensure
			item_set : item = a_ptr
		end

	make_unshared_with_eiffel_string (a_string: STRING_GENERAL)
			-- Create `item' and retain ownership.
		require
			a_string_not_void: a_string /= Void
		local
			c_string : C_STRING
		do
			encoding := {CFSTRING_BUILT_IN_ENCODINGS_ENUM_EXTERNAL}.kCFStringEncodingASCII
			create c_string.make ( a_string )
			item := cfstring_create_with_cstring_external ( default_pointer, c_string.item, encoding )
			is_shared := false
		ensure
			string_set: string.is_equal (a_string)
		end

feature -- Access

	item: POINTER
			-- Pointer to the CFString

	string : STRING_32
			-- Return the wrapped CFString as `STRING_32'
		local
			string_ptr : POINTER
			c_string : C_STRING
			managed_data : MANAGED_POINTER
			max_bytes : INTEGER
			err : INTEGER
		do
			string_ptr := cfstring_get_cstring_ptr_external ( item, encoding )
			if string_ptr /= default_pointer then
				Result := create {STRING_32}.make_from_c ( string_ptr )
			else
				max_bytes := cfstring_get_maximum_size_for_encoding_external ( length, encoding )
				create managed_data.make ( max_bytes + 1 )
				err := cfstring_get_cstring_external ( item, managed_data.item, managed_data.count, encoding )
				check
					conversion_ok : err.to_boolean = true
				end
				Result := create {STRING_32}.make_from_c ( managed_data.item )
			end
		end


	length: INTEGER
			-- Length of the CFString
		do
			Result := cfstring_get_length_external ( item )
		end

	is_shared : BOOLEAN

	encoding : INTEGER

feature {NONE} -- Implementation

	dispose
			-- Dispose `Current'.
		do
			if not is_shared  then
				cfrelease_external ( item )
			end
		end

invariant
	item_not_null : item /= default_pointer

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_GTK_C_STRING

