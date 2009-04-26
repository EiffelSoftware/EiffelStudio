note
	description: "Summary description for {NS_DICTIONARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY

inherit
	NS_OBJECT

create
	make_shared,
	dictionary,
	dictionary_with_object_for_key

feature -- Creation

	dictionary
		do
			cocoa_object := dictionary_dictionary
		end

	dictionary_with_object_for_key (a_object, a_key: NS_OBJECT)
		do
			cocoa_object := dictionary_dictionary_with_object_for_key (a_object.cocoa_object, ns_font_attribute_name)--a_key.cocoa_object)
		end

feature {NONE} -- Objective-C implementation

--@interface NSDictionary : NSObject <NSCopying, NSMutableCopying, NSCoding, NSFastEnumeration>

--- (NSUInteger)count;
--- (id)objectForKey:(id)aKey;
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

	frozen dictionary_dictionary : POINTER
			--+ (id)dictionary;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSDictionary dictionary];"
		end

	frozen dictionary_dictionary_with_object_for_key (a_object, a_key: POINTER) : POINTER
			--+ (id)dictionaryWithObject:(id)object forKey:(id)key;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSDictionary dictionaryWithObject: $a_object forKey: $a_key];"
		end

--+ (id)dictionaryWithObjects:(id *)objects forKeys:(id *)keys count:(NSUInteger)cnt;
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
