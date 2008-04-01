indexing
	description: "[
					Encoder parameters list used by 
					{WEL_GDIP_IMAGE_ENCODER_PARAMETERS}.save_image_to_file_with_encoder_and_parameters
																										]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_ENCODER_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER) is
			-- Creation method
		require
			valid: a_count > 0
		do
			create parameters.make (a_count)
		end

feature -- Query

	parameters: !ARRAYED_LIST [WEL_GDIP_IMAGE_ENCODER_PARAMETER]
			-- All parameters current managed.

	item: !MANAGED_POINTER is
			-- Convert Current to C memory
		local
			l_paras: like parameters
			l_count: INTEGER_32
		do
			l_paras := parameters
			create Result.make (4) -- INTEGER_32 is 4 bytes
			l_count := l_paras.count
			Result.put_integer_32 (l_count, 0)
			from
				l_paras.start
			until
				l_paras.after
			loop
				Result.append (l_paras.item.item)
				l_paras.forth
			end
		end

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


end

