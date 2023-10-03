note
	description: "Summary description for {DOWNLOAD_PRODUCT_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PRODUCT_OPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_product: DOWNLOAD_PRODUCT; a_platform: like platform; a_filename: like filename)
		do
			associated_product := a_product
			filename := a_filename
			platform := a_platform
		end

feature -- Access

	associated_product: DOWNLOAD_PRODUCT

	filename: READABLE_STRING_32
			-- Product filename.

	platform: READABLE_STRING_32
			-- Product platform.

	key: detachable READABLE_STRING_32
			-- Associated key

	hash: detachable READABLE_STRING_32
			-- Associated hash.

	size: INTEGER_64
			-- Product size.

	link: detachable READABLE_STRING_8

	hidden: BOOLEAN assign set_hidden
			-- Is product hidden?

feature -- Link

	get_link
		local
			s32: STRING_32
			i,j,n: INTEGER
			k, v: READABLE_STRING_32
		do
			if link /= Void then
					-- Keep it
			elseif attached associated_product.download_link_pattern as p then
				create s32.make_from_string_general (p)
				from
					i := 1
					n := s32.count
				until
					i > n
				loop
					j := s32.substring_index ("${", i)
					if j >= i then
						i := j
						j := s32.index_of ('}', i)
						if j > i then
							k := s32.substring (i + 2, j - 1).as_lower
							if k.same_string_general ("mirror") then
								if attached associated_product.mirror as m then
									v := m.to_string_32
								else
									v := Void
								end
							elseif k.same_string_general ("name") then
								v := associated_product.name
							elseif k.same_string_general ("id") then
								v := associated_product.id
							elseif k.same_string_general ("number") then
								v := associated_product.number
							elseif k.same_string_general ("version") then
								v := associated_product.version
							elseif k.same_string_general ("build") then
								v := associated_product.build
							elseif k.same_string_general ("filename") then
								v := filename
							elseif k.same_string_general ("platform") then
								v := platform
							else
								v := Void
							end
							if v = Void then
								v := ""
							end
							s32.replace_substring_all (s32.substring (i, j), v)
							i := i + v.count
							n := s32.count
						else
							i := i + 1
						end
					else
						i := n + 1
					end
				end
				if s32.is_valid_as_string_8 then
					link := s32.to_string_8
				end
			end
		end

feature -- Element change

	set_key (a_key: like key)
			-- Assign `key' with `a_key'.
		do
			key := a_key
		ensure
			key_assigned: key = a_key
		end

	set_hash (a_hash: like hash)
			-- Assign `hash' with `a_hash'.
		do
			hash := a_hash
		ensure
			hash_assigned: hash = a_hash
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_filename (a_filename: like filename)
			-- Assign `filename' with `a_filename'.
		do
			filename := a_filename
		ensure
			filename_assigned: filename = a_filename
		end

	set_platform (a_platform: like platform)
			-- Assign `platform' with `a_platform'.
		do
			platform := a_platform
		ensure
			platform_assigned: platform = a_platform
		end

	set_link (a_link: like link)
			-- Assign `link' with `a_link'.	
		do
			link := a_link
		end

	set_hidden (b: like hidden)
		do
			hidden := b
		end

end
