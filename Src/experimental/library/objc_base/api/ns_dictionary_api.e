note
	description: "Summary description for {NS_DICTIONARY_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY_API

feature -- Objective-C implementation

--@interface NSDictionary : NSObject <NSCopying, NSMutableCopying, NSCoding, NSFastEnumeration>

--- (NSUInteger)count;
	frozen object_for_key (a_dictionary, a_key: POINTER): POINTER
			--- (id)objectForKey:(id)aKey;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [(NSDictionary*)$a_dictionary objectForKey: $a_key];"
		end
--- (NSEnumerator *)keyEnumerator;

--@end

--@interface NSDictionary (NSExtendedDictionary)

--- (NSArray *)allKeys;
--- (NSArray *)allKeysForObject:(id)anObject;
--- (NSArray *)allValues;
--- (NSString *)description;
--- (NSString *)descriptionInStringsFileFormat;
--- (NSString *)descriptionWithLocale:(id)locale;
--- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;
--- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary;
--- (NSEnumerator *)objectEnumerator;
--- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker;
--- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
--- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if url of a type that cannot be written atomically.

--- (NSArray *)keysSortedByValueUsingSelector:(SEL)comparator;
--- (void)getObjects:(id *)objects andKeys:(id *)keys;

--@end

--@interface NSDictionary (NSDictionaryCreation)

	frozen create_default: POINTER
			-- - (id)init;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [[NSDictionary alloc] init];"
		end

	frozen dictionary_with_object_for_key (a_object, a_key: POINTER): POINTER
			-- - (id)initWithObject:(id)object forKey:(id)key;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [NSDictionary dictionaryWithObject: $a_object forKey: $a_key];"
		end

	frozen create_with_objects_for_keys (a_objects, a_keys: POINTER): POINTER
			-- - (id)initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [[NSDictionary alloc] initWithObjects: $a_objects forKeys: $a_keys];"
		end

	frozen init (a_ptr: POINTER): POINTER
			-- - (id)init;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [(NSDictionary*)$a_ptr init];"
		end

	frozen init_with_objects_for_keys (a_ptr, a_objects, a_keys: POINTER): POINTER
			-- - (id)initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt;
		external
			"C inline use <Foundation/NSDictionary.h>"
		alias
			"return [(NSDictionary*)$a_ptr initWithObjects: $a_objects forKeys: $a_keys];"
		end

--+ (id)dictionaryWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
--+ (id)dictionaryWithDictionary:(NSDictionary *)dict;
--+ (id)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;

--- (id)initWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt;
--- (id)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
--- (id)initWithDictionary:(NSDictionary *)otherDictionary;
--- (id)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag;
--- (id)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;

--+ (id)dictionaryWithContentsOfFile:(NSString *)path;
--+ (id)dictionaryWithContentsOfURL:(NSURL *)url;
--- (id)initWithContentsOfFile:(NSString *)path;
--- (id)initWithContentsOfURL:(NSURL *)url;

--@end
end
