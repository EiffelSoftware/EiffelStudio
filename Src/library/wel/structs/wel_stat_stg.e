note
	description: "[
					The STATSTG structure contains statistical data about an open storage, stream, 
					or byte-array object. This structure is used in the IEnumSTATSTG, ILockBytes, 
					IStorage, and IStream interfaces.
																										]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STAT_STG

create
	make_empty,
	share_with_pointer

feature {NONE} -- Initialization

	make_empty
			-- Creation method
		do
			create item.make (c_size)
		end

	share_with_pointer (a_poitner: POINTER)
			-- Creation method
		do
			create item.share_from_pointer (a_poitner, c_size)
		end

feature -- Query

	cb_size: NATURAL_64
			-- Specifies the size, in bytes, of the stream or byte array.
		do
			if item.item /= default_pointer then
				Result := c_cb_size (item.item)
			end
		end

	item: MANAGED_POINTER
			--

feature {NONE} -- Externals

	c_size: INTEGER
			--
		external
			"C inline use <Objidl.h>"
		alias
			"[
			{
				return sizeof (STATSTG);
			}
			]"
		end

	c_cb_size (a_item: POINTER): NATURAL_64
			--
		external
			"C inline use <Objidl.h>"
		alias
			"[
			{
				STATSTG *l_item = (STATSTG *)$a_item;

				ULARGE_INTEGER l_cbsize;
				l_cbsize = l_item->cbSize;
				return (EIF_NATURAL_64) l_cbsize.QuadPart;
			}
			]"
		end

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
