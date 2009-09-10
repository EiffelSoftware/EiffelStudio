note
	description: "Summary description for {NS_MUTABLE_DICTIONARY_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MUTABLE_DICTIONARY_API

inherit
	NS_OBJECT_BASIC_TYPE

feature -- Creating and Initializing a Mutable Dictionary

	frozen alloc: POINTER
			-- alloc a NSMutableDictionary;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [NSMutableDictionary alloc];"
		end

	frozen dictionary_with_capacity (a_capacity: like ns_uinteger): POINTER
			-- + (id)dictionaryWithOCapacity:(NSUInteger)numItems;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [NSMutableDictionary dictionaryWithCapacity: $a_capacity];"
		end

	frozen init_with_capacity (a_ptr: POINTER; a_capacity: like ns_uinteger): POINTER
			-- - (id)initWithOCapacity:(NSUInteger)numItems;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [(NSMutableDictionary*)$a_ptr initWithCapacity: $a_capacity];"
		end

feature -- Adding Entries to a Mutable Dictionary

	frozen set_object_for_key (target: POINTER; a_object: POINTER; a_key: POINTER)
			-- - (void)setObject:(id)anObject forKey:(id)aKey
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"[(NSMutableDictionary*)$target setObject: $a_object forKey: $a_key];"
		end


feature -- Removing Entries From a Mutable Dictionary

end
