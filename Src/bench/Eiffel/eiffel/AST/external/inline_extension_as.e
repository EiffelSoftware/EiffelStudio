indexing
	description: "Encapsulation of a inline external extension."
	date: "$Date$"
	revision: "$Revision$"

class INLINE_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS

create
	initialize

feature  -- Initialization

	initialize (is_cpp_inline: like is_cpp; use_list: USE_LIST_AS) is
			-- Create INLINE_EXTENSION_AS node.
		do
			is_cpp := is_cpp_inline
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		ensure
			is_cpp_set: is_cpp = is_cpp_inline
		end

feature -- Properties

	is_cpp: BOOLEAN
			-- Is Current inlining a C++ one?

feature -- Get inline extension

	extension_i: INLINE_EXTENSION_I is
			-- INLINE_EXTENSION_I corresponding to current extension
		do
			create Result.make (is_cpp)
			init_extension_i (Result)
		end

end -- class INLINE_EXTENSION_AS
