note
	description: "Summary description for {NS_DATA_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATA_API

feature -- Creating Data Objects

	frozen data : POINTER
			-- + (id)data
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData data];"
		end

	frozen data_with_bytes_length (a_bytes: POINTER; a_length: INTEGER): POINTER
			-- + (id)dataWithBytes: (const void *) bytes length: (const void *) length
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithBytes: $a_bytes length: $a_length];"
		end

	frozen data_with_bytes_no_copy_length (a_bytes: POINTER; a_length: INTEGER): POINTER
			-- + (id)dataWithBytesNoCopy: (void *) bytes length: (void *) length
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithBytesNoCopy: $a_bytes length: $a_length];"
		end

	frozen data_with_bytes_no_copy_length_free_when_done (a_bytes: POINTER; a_length: INTEGER; a_b: BOOLEAN): POINTER
			-- + (id)dataWithBytesNoCopy: (void *) bytes length: (void *) length freeWhenDone: (void *) b
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithBytesNoCopy: $a_bytes length: $a_length freeWhenDone: $a_b];"
		end

	frozen data_with_contents_of_file_options_error (a_path: POINTER; a_read_options_mask: INTEGER; a_error_ptr: POINTER): POINTER
			-- + (id)dataWithContentsOfFile: (NSString *) path options: (NSString *) readOptionsMask error: (NSString *) errorPtr
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithContentsOfFile: $a_path options: $a_read_options_mask error: $a_error_ptr];"
		end

	frozen data_with_contents_of_url_options_error (a_url: POINTER; a_read_options_mask: INTEGER; a_error_ptr: POINTER): POINTER
			-- + (id)dataWithContentsOfURL: (NSURL *) url options: (NSURL *) readOptionsMask error: (NSURL *) errorPtr
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithContentsOfURL: $a_url options: $a_read_options_mask error: $a_error_ptr];"
		end

	frozen data_with_contents_of_file (a_path: POINTER): POINTER
			-- + (id)dataWithContentsOfFile: (NSString *) path
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithContentsOfFile: $a_path];"
		end

	frozen data_with_contents_of_url (a_url: POINTER): POINTER
			-- + (id)dataWithContentsOfURL: (NSURL *) url
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithContentsOfURL: $a_url];"
		end

	frozen data_with_contents_of_mapped_file (a_path: POINTER): POINTER
			-- + (id)dataWithContentsOfMappedFile: (NSString *) path
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithContentsOfMappedFile: $a_path];"
		end

	frozen data_with_data (a_data: POINTER): POINTER
			-- + (id)dataWithData: (NSData *) data
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [NSData dataWithData: $a_data];"
		end

feature --

--	frozen init_with_bytes_length (a_ns_data: POINTER; a_bytes: POINTER; a_length: INTEGER): POINTER
--			-- - (id)initWithBytes: (const void *) bytes length: (const void *) length
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithBytes: $a_bytes length: $a_length];"
--		end

--	frozen init_with_bytes_no_copy_length (a_ns_data: POINTER; a_bytes: POINTER; a_length: INTEGER): POINTER
--			-- - (id)initWithBytesNoCopy: (void *) bytes length: (void *) length
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithBytesNoCopy: $a_bytes length: $a_length];"
--		end

--	frozen init_with_bytes_no_copy_length_free_when_done (a_ns_data: POINTER; a_bytes: POINTER; a_length: INTEGER; a_b: BOOLEAN): POINTER
--			-- - (id)initWithBytesNoCopy: (void *) bytes length: (void *) length freeWhenDone: (void *) b
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithBytesNoCopy: $a_bytes length: $a_length freeWhenDone: $a_b];"
--		end

--	frozen init_with_contents_of_file_options_error (a_ns_data: POINTER; a_path: POINTER; a_read_options_mask: INTEGER; a_error_ptr: POINTER): POINTER
--			-- - (id)initWithContentsOfFile: (NSString *) path options: (NSString *) readOptionsMask error: (NSString *) errorPtr
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithContentsOfFile: $a_path options: $a_read_options_mask error: $a_error_ptr];"
--		end

--	frozen init_with_contents_of_url_options_error (a_ns_data: POINTER; a_url: POINTER; a_read_options_mask: INTEGER; a_error_ptr: POINTER): POINTER
--			-- - (id)initWithContentsOfURL: (NSURL *) url options: (NSURL *) readOptionsMask error: (NSURL *) errorPtr
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithContentsOfURL: $a_url options: $a_read_options_mask error: $a_error_ptr];"
--		end

--	frozen init_with_contents_of_file (a_ns_data: POINTER; a_path: POINTER): POINTER
--			-- - (id)initWithContentsOfFile: (NSString *) path
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithContentsOfFile: $a_path];"
--		end

--	frozen init_with_contents_of_url (a_ns_data: POINTER; a_url: POINTER): POINTER
--			-- - (id)initWithContentsOfURL: (NSURL *) url
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithContentsOfURL: $a_url];"
--		end

--	frozen init_with_contents_of_mapped_file (a_ns_data: POINTER; a_path: POINTER): POINTER
--			-- - (id)initWithContentsOfMappedFile: (NSString *) path
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithContentsOfMappedFile: $a_path];"
--		end

--	frozen init_with_data (a_ns_data: POINTER; a_data: POINTER): POINTER
--			-- - (id)initWithData: (NSData *) data
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithData: $a_data];"
--		end

feature -- Accessing Data

	frozen bytes (a_ns_data: POINTER): POINTER
			-- - (const void *)bytes
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return (EIF_POINTER)[(NSData*)$a_ns_data bytes];"
		end

	frozen description (a_ns_data: POINTER): POINTER
			-- - (NSString *)description
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return (EIF_POINTER)[(NSData*)$a_ns_data description];"
		end

	frozen get_bytes (a_ns_data: POINTER; a_buffer: POINTER)
			-- - (void)getBytes: (void *) buffer
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[(NSData*)$a_ns_data getBytes: $a_buffer];"
		end

	frozen get_bytes_length (a_ns_data: POINTER; a_buffer: POINTER; a_length: INTEGER)
			-- - (void)getBytes: (void *) buffer length: (void *) length
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[(NSData*)$a_ns_data getBytes: $a_buffer length: $a_length];"
		end

	frozen get_bytes_range (a_ns_data: POINTER; a_buffer: POINTER; a_range: POINTER)
			-- - (void)getBytes: (void *) buffer range: (void *) range
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[(NSData*)$a_ns_data getBytes: $a_buffer range: *(NSRange*)$a_range];"
		end

	frozen subdata_with_range (a_ns_data: POINTER; a_range: POINTER): POINTER
			-- - (NSData *)subdataWithRange: (NSRange) range
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [(NSData*)$a_ns_data subdataWithRange: *(NSRange*)$a_range];"
		end

feature -- Testing Data

	frozen length (a_ns_data: POINTER): INTEGER
			-- - (NSUInteger)length
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [(NSData*)$a_ns_data length];"
		end

	frozen is_equal_to_data (a_ns_data: POINTER; a_other: POINTER): BOOLEAN
			-- - (BOOL)isEqualToData: (NSData *) other
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [(NSData*)$a_ns_data isEqualToData: $a_other];"
		end

feature -- Storing Data

	frozen write_to_file_atomically (a_ns_data: POINTER; a_path: POINTER; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- - (BOOL)writeToFile: (NSString *) path atomically: (NSString *) useAuxiliaryFile
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"return [(NSData*)$a_ns_data writeToFile: $a_path atomically: $a_use_auxiliary_file];"
		end

--	frozen write_to_url_atomically (a_ns_data: POINTER; a_url: POINTER; a_atomically: BOOLEAN): BOOLEAN
--			-- - (BOOL)writeToURL: (NSURL *) url atomically: (NSURL *) atomically
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data writeToURL: $a_url atomically: $a_atomically];"
--		end

--	frozen write_to_file_options_error (a_ns_data: POINTER; a_path: POINTER; a_write_options_mask: INTEGER; a_error_ptr: POINTER): BOOLEAN
--			-- - (BOOL)writeToFile: (NSString *) path options: (NSString *) writeOptionsMask error: (NSString *) errorPtr
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data writeToFile: $a_path options: $a_write_options_mask error: $a_error_ptr];"
--		end

--	frozen write_to_url_options_error (a_ns_data: POINTER; a_url: POINTER; a_write_options_mask: INTEGER; a_error_ptr: POINTER): BOOLEAN
--			-- - (BOOL)writeToURL: (NSURL *) url options: (NSURL *) writeOptionsMask error: (NSURL *) errorPtr
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data writeToURL: $a_url options: $a_write_options_mask error: $a_error_ptr];"
--		end


--	frozen mutable_bytes (a_ns_data: POINTER): POINTER
--			-- - (void *)mutableBytes
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data mutableBytes];"
--		end

--	frozen set_length (a_ns_data: POINTER; a_length: INTEGER)
--			-- - (void)setLength: (NSUInteger) length
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data setLength: $a_length];"
--		end

--	frozen append_bytes_length (a_ns_data: POINTER; a_bytes: POINTER; a_length: INTEGER)
--			-- - (void)appendBytes: (const void *) bytes length: (const void *) length
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data appendBytes: $a_bytes length: $a_length];"
--		end

--	frozen append_data (a_ns_data: POINTER; a_other: POINTER)
--			-- - (void)appendData: (NSData *) other
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data appendData: $a_other];"
--		end

--	frozen increase_length_by (a_ns_data: POINTER; a_extra_length: INTEGER)
--			-- - (void)increaseLengthBy: (NSUInteger) extraLength
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data increaseLengthBy: $a_extra_length];"
--		end

--	frozen replace_bytes_in_range_with_bytes (a_ns_data: POINTER; a_range: POINTER; a_bytes: POINTER)
--			-- - (void)replaceBytesInRange: (NSRange) range withBytes: (NSRange) bytes
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data replaceBytesInRange: *(NSRange*)$a_range withBytes: $a_bytes];"
--		end

--	frozen reset_bytes_in_range (a_ns_data: POINTER; a_range: POINTER)
--			-- - (void)resetBytesInRange: (NSRange) range
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data resetBytesInRange: *(NSRange*)$a_range];"
--		end

--	frozen set_data (a_ns_data: POINTER; a_data: POINTER)
--			-- - (void)setData: (NSData *) data
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data setData: $a_data];"
--		end

--	frozen replace_bytes_in_range_with_bytes_length (a_ns_data: POINTER; a_range: POINTER; a_replacement_bytes: POINTER; a_replacement_length: INTEGER)
--			-- - (void)replaceBytesInRange: (NSRange) range withBytes: (NSRange) replacementBytes length: (NSRange) replacementLength
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[(NSData*)$a_ns_data replaceBytesInRange: *(NSRange*)$a_range withBytes: $a_replacement_bytes length: $a_replacement_length];"
--		end

--	frozen init_with_capacity (a_ns_data: POINTER; a_capacity: INTEGER): POINTER
--			-- - (id)initWithCapacity: (NSUInteger) capacity
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithCapacity: $a_capacity];"
--		end

--	frozen init_with_length (a_ns_data: POINTER; a_length: INTEGER): POINTER
--			-- - (id)initWithLength: (NSUInteger) length
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"return [(NSData*)$a_ns_data initWithLength: $a_length];"
--		end

end
