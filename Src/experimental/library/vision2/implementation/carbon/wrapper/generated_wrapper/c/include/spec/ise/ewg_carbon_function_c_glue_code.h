
// Wraps call to function '__CFRangeMake' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro___CFRangeMake(ewg_param_loc, ewg_param_len) __CFRangeMake ((CFIndex)ewg_param_loc, (CFIndex)ewg_param_len)

CFRange * ewg_function___CFRangeMake (CFIndex loc, CFIndex len);
// Wraps call to function 'CFNullGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFNullGetTypeID CFNullGetTypeID ()

CFTypeID  ewg_function_CFNullGetTypeID (void);
// Wraps call to function 'CFAllocatorGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorGetTypeID CFAllocatorGetTypeID ()

CFTypeID  ewg_function_CFAllocatorGetTypeID (void);
// Wraps call to function 'CFAllocatorSetDefault' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorSetDefault(ewg_param_allocator) CFAllocatorSetDefault ((CFAllocatorRef)ewg_param_allocator)

void  ewg_function_CFAllocatorSetDefault (CFAllocatorRef allocator);
// Wraps call to function 'CFAllocatorGetDefault' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorGetDefault CFAllocatorGetDefault ()

CFAllocatorRef  ewg_function_CFAllocatorGetDefault (void);
// Wraps call to function 'CFAllocatorCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorCreate(ewg_param_allocator, ewg_param_context) CFAllocatorCreate ((CFAllocatorRef)ewg_param_allocator, (CFAllocatorContext*)ewg_param_context)

CFAllocatorRef  ewg_function_CFAllocatorCreate (CFAllocatorRef allocator, CFAllocatorContext *context);
// Wraps call to function 'CFAllocatorAllocate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorAllocate(ewg_param_allocator, ewg_param_size, ewg_param_hint) CFAllocatorAllocate ((CFAllocatorRef)ewg_param_allocator, (CFIndex)ewg_param_size, (CFOptionFlags)ewg_param_hint)

void * ewg_function_CFAllocatorAllocate (CFAllocatorRef allocator, CFIndex size, CFOptionFlags hint);
// Wraps call to function 'CFAllocatorReallocate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorReallocate(ewg_param_allocator, ewg_param_ptr, ewg_param_newsize, ewg_param_hint) CFAllocatorReallocate ((CFAllocatorRef)ewg_param_allocator, (void*)ewg_param_ptr, (CFIndex)ewg_param_newsize, (CFOptionFlags)ewg_param_hint)

void * ewg_function_CFAllocatorReallocate (CFAllocatorRef allocator, void *ptr, CFIndex newsize, CFOptionFlags hint);
// Wraps call to function 'CFAllocatorDeallocate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorDeallocate(ewg_param_allocator, ewg_param_ptr) CFAllocatorDeallocate ((CFAllocatorRef)ewg_param_allocator, (void*)ewg_param_ptr)

void  ewg_function_CFAllocatorDeallocate (CFAllocatorRef allocator, void *ptr);
// Wraps call to function 'CFAllocatorGetPreferredSizeForSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorGetPreferredSizeForSize(ewg_param_allocator, ewg_param_size, ewg_param_hint) CFAllocatorGetPreferredSizeForSize ((CFAllocatorRef)ewg_param_allocator, (CFIndex)ewg_param_size, (CFOptionFlags)ewg_param_hint)

CFIndex  ewg_function_CFAllocatorGetPreferredSizeForSize (CFAllocatorRef allocator, CFIndex size, CFOptionFlags hint);
// Wraps call to function 'CFAllocatorGetContext' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFAllocatorGetContext(ewg_param_allocator, ewg_param_context) CFAllocatorGetContext ((CFAllocatorRef)ewg_param_allocator, (CFAllocatorContext*)ewg_param_context)

void  ewg_function_CFAllocatorGetContext (CFAllocatorRef allocator, CFAllocatorContext *context);
// Wraps call to function 'CFGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFGetTypeID(ewg_param_cf) CFGetTypeID ((CFTypeRef)ewg_param_cf)

CFTypeID  ewg_function_CFGetTypeID (CFTypeRef cf);
// Wraps call to function 'CFCopyTypeIDDescription' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFCopyTypeIDDescription(ewg_param_type_id) CFCopyTypeIDDescription ((CFTypeID)ewg_param_type_id)

CFStringRef  ewg_function_CFCopyTypeIDDescription (CFTypeID type_id);
// Wraps call to function 'CFRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFRetain(ewg_param_cf) CFRetain ((CFTypeRef)ewg_param_cf)

CFTypeRef  ewg_function_CFRetain (CFTypeRef cf);
// Wraps call to function 'CFRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFRelease(ewg_param_cf) CFRelease ((CFTypeRef)ewg_param_cf)

void  ewg_function_CFRelease (CFTypeRef cf);
// Wraps call to function 'CFGetRetainCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFGetRetainCount(ewg_param_cf) CFGetRetainCount ((CFTypeRef)ewg_param_cf)

CFIndex  ewg_function_CFGetRetainCount (CFTypeRef cf);
// Wraps call to function 'CFMakeCollectable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFMakeCollectable(ewg_param_cf) CFMakeCollectable ((CFTypeRef)ewg_param_cf)

CFTypeRef  ewg_function_CFMakeCollectable (CFTypeRef cf);
// Wraps call to function 'CFEqual' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFEqual(ewg_param_cf1, ewg_param_cf2) CFEqual ((CFTypeRef)ewg_param_cf1, (CFTypeRef)ewg_param_cf2)

Boolean  ewg_function_CFEqual (CFTypeRef cf1, CFTypeRef cf2);
// Wraps call to function 'CFHash' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFHash(ewg_param_cf) CFHash ((CFTypeRef)ewg_param_cf)

CFHashCode  ewg_function_CFHash (CFTypeRef cf);
// Wraps call to function 'CFCopyDescription' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFCopyDescription(ewg_param_cf) CFCopyDescription ((CFTypeRef)ewg_param_cf)

CFStringRef  ewg_function_CFCopyDescription (CFTypeRef cf);
// Wraps call to function 'CFGetAllocator' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFGetAllocator(ewg_param_cf) CFGetAllocator ((CFTypeRef)ewg_param_cf)

CFAllocatorRef  ewg_function_CFGetAllocator (CFTypeRef cf);
// Wraps call to function 'CFStringGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetTypeID CFStringGetTypeID ()

CFTypeID  ewg_function_CFStringGetTypeID (void);
// Wraps call to function 'CFStringCreateWithPascalString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithPascalString(ewg_param_alloc, ewg_param_pStr, ewg_param_encoding) CFStringCreateWithPascalString ((CFAllocatorRef)ewg_param_alloc, (ConstStr255Param)ewg_param_pStr, (CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFStringCreateWithPascalString (CFAllocatorRef alloc, ConstStr255Param pStr, CFStringEncoding encoding);
// Wraps call to function 'CFStringCreateWithCString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithCString(ewg_param_alloc, ewg_param_cStr, ewg_param_encoding) CFStringCreateWithCString ((CFAllocatorRef)ewg_param_alloc, (char const*)ewg_param_cStr, (CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFStringCreateWithCString (CFAllocatorRef alloc, char const *cStr, CFStringEncoding encoding);
// Wraps call to function 'CFStringCreateWithCharacters' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithCharacters(ewg_param_alloc, ewg_param_chars, ewg_param_numChars) CFStringCreateWithCharacters ((CFAllocatorRef)ewg_param_alloc, (UniChar const*)ewg_param_chars, (CFIndex)ewg_param_numChars)

CFStringRef  ewg_function_CFStringCreateWithCharacters (CFAllocatorRef alloc, UniChar const *chars, CFIndex numChars);
// Wraps call to function 'CFStringCreateWithPascalStringNoCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithPascalStringNoCopy(ewg_param_alloc, ewg_param_pStr, ewg_param_encoding, ewg_param_contentsDeallocator) CFStringCreateWithPascalStringNoCopy ((CFAllocatorRef)ewg_param_alloc, (ConstStr255Param)ewg_param_pStr, (CFStringEncoding)ewg_param_encoding, (CFAllocatorRef)ewg_param_contentsDeallocator)

CFStringRef  ewg_function_CFStringCreateWithPascalStringNoCopy (CFAllocatorRef alloc, ConstStr255Param pStr, CFStringEncoding encoding, CFAllocatorRef contentsDeallocator);
// Wraps call to function 'CFStringCreateWithCStringNoCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithCStringNoCopy(ewg_param_alloc, ewg_param_cStr, ewg_param_encoding, ewg_param_contentsDeallocator) CFStringCreateWithCStringNoCopy ((CFAllocatorRef)ewg_param_alloc, (char const*)ewg_param_cStr, (CFStringEncoding)ewg_param_encoding, (CFAllocatorRef)ewg_param_contentsDeallocator)

CFStringRef  ewg_function_CFStringCreateWithCStringNoCopy (CFAllocatorRef alloc, char const *cStr, CFStringEncoding encoding, CFAllocatorRef contentsDeallocator);
// Wraps call to function 'CFStringCreateWithCharactersNoCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithCharactersNoCopy(ewg_param_alloc, ewg_param_chars, ewg_param_numChars, ewg_param_contentsDeallocator) CFStringCreateWithCharactersNoCopy ((CFAllocatorRef)ewg_param_alloc, (UniChar const*)ewg_param_chars, (CFIndex)ewg_param_numChars, (CFAllocatorRef)ewg_param_contentsDeallocator)

CFStringRef  ewg_function_CFStringCreateWithCharactersNoCopy (CFAllocatorRef alloc, UniChar const *chars, CFIndex numChars, CFAllocatorRef contentsDeallocator);
// Wraps call to function 'CFStringCreateWithSubstring' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithSubstring(ewg_param_alloc, ewg_param_str, ewg_param_range) CFStringCreateWithSubstring ((CFAllocatorRef)ewg_param_alloc, (CFStringRef)ewg_param_str, *(CFRange*)ewg_param_range)

CFStringRef  ewg_function_CFStringCreateWithSubstring (CFAllocatorRef alloc, CFStringRef str, CFRange *range);
// Wraps call to function 'CFStringCreateCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateCopy(ewg_param_alloc, ewg_param_theString) CFStringCreateCopy ((CFAllocatorRef)ewg_param_alloc, (CFStringRef)ewg_param_theString)

CFStringRef  ewg_function_CFStringCreateCopy (CFAllocatorRef alloc, CFStringRef theString);
// Wraps call to function 'CFStringCreateWithFormat' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithFormat(ewg_param_alloc, ewg_param_formatOptions, ewg_param_format) CFStringCreateWithFormat ((CFAllocatorRef)ewg_param_alloc, (CFDictionaryRef)ewg_param_formatOptions, (CFStringRef)ewg_param_format)

CFStringRef  ewg_function_CFStringCreateWithFormat (CFAllocatorRef alloc, CFDictionaryRef formatOptions, CFStringRef format);
// Wraps call to function 'CFStringCreateMutable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateMutable(ewg_param_alloc, ewg_param_maxLength) CFStringCreateMutable ((CFAllocatorRef)ewg_param_alloc, (CFIndex)ewg_param_maxLength)

CFMutableStringRef  ewg_function_CFStringCreateMutable (CFAllocatorRef alloc, CFIndex maxLength);
// Wraps call to function 'CFStringCreateMutableCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateMutableCopy(ewg_param_alloc, ewg_param_maxLength, ewg_param_theString) CFStringCreateMutableCopy ((CFAllocatorRef)ewg_param_alloc, (CFIndex)ewg_param_maxLength, (CFStringRef)ewg_param_theString)

CFMutableStringRef  ewg_function_CFStringCreateMutableCopy (CFAllocatorRef alloc, CFIndex maxLength, CFStringRef theString);
// Wraps call to function 'CFStringCreateMutableWithExternalCharactersNoCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateMutableWithExternalCharactersNoCopy(ewg_param_alloc, ewg_param_chars, ewg_param_numChars, ewg_param_capacity, ewg_param_externalCharactersAllocator) CFStringCreateMutableWithExternalCharactersNoCopy ((CFAllocatorRef)ewg_param_alloc, (UniChar*)ewg_param_chars, (CFIndex)ewg_param_numChars, (CFIndex)ewg_param_capacity, (CFAllocatorRef)ewg_param_externalCharactersAllocator)

CFMutableStringRef  ewg_function_CFStringCreateMutableWithExternalCharactersNoCopy (CFAllocatorRef alloc, UniChar *chars, CFIndex numChars, CFIndex capacity, CFAllocatorRef externalCharactersAllocator);
// Wraps call to function 'CFStringGetLength' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetLength(ewg_param_theString) CFStringGetLength ((CFStringRef)ewg_param_theString)

CFIndex  ewg_function_CFStringGetLength (CFStringRef theString);
// Wraps call to function 'CFStringGetCharacterAtIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetCharacterAtIndex(ewg_param_theString, ewg_param_idx) CFStringGetCharacterAtIndex ((CFStringRef)ewg_param_theString, (CFIndex)ewg_param_idx)

UniChar  ewg_function_CFStringGetCharacterAtIndex (CFStringRef theString, CFIndex idx);
// Wraps call to function 'CFStringGetCharacters' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetCharacters(ewg_param_theString, ewg_param_range, ewg_param_buffer) CFStringGetCharacters ((CFStringRef)ewg_param_theString, *(CFRange*)ewg_param_range, (UniChar*)ewg_param_buffer)

void  ewg_function_CFStringGetCharacters (CFStringRef theString, CFRange *range, UniChar *buffer);
// Wraps call to function 'CFStringGetPascalString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetPascalString(ewg_param_theString, ewg_param_buffer, ewg_param_bufferSize, ewg_param_encoding) CFStringGetPascalString ((CFStringRef)ewg_param_theString, (StringPtr)ewg_param_buffer, (CFIndex)ewg_param_bufferSize, (CFStringEncoding)ewg_param_encoding)

Boolean  ewg_function_CFStringGetPascalString (CFStringRef theString, StringPtr buffer, CFIndex bufferSize, CFStringEncoding encoding);
// Wraps call to function 'CFStringGetCString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetCString(ewg_param_theString, ewg_param_buffer, ewg_param_bufferSize, ewg_param_encoding) CFStringGetCString ((CFStringRef)ewg_param_theString, (char*)ewg_param_buffer, (CFIndex)ewg_param_bufferSize, (CFStringEncoding)ewg_param_encoding)

Boolean  ewg_function_CFStringGetCString (CFStringRef theString, char *buffer, CFIndex bufferSize, CFStringEncoding encoding);
// Wraps call to function 'CFStringGetPascalStringPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetPascalStringPtr(ewg_param_theString, ewg_param_encoding) CFStringGetPascalStringPtr ((CFStringRef)ewg_param_theString, (CFStringEncoding)ewg_param_encoding)

ConstStringPtr  ewg_function_CFStringGetPascalStringPtr (CFStringRef theString, CFStringEncoding encoding);
// Wraps call to function 'CFStringGetCStringPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetCStringPtr(ewg_param_theString, ewg_param_encoding) CFStringGetCStringPtr ((CFStringRef)ewg_param_theString, (CFStringEncoding)ewg_param_encoding)

char const * ewg_function_CFStringGetCStringPtr (CFStringRef theString, CFStringEncoding encoding);
// Wraps call to function 'CFStringGetCharactersPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetCharactersPtr(ewg_param_theString) CFStringGetCharactersPtr ((CFStringRef)ewg_param_theString)

UniChar const * ewg_function_CFStringGetCharactersPtr (CFStringRef theString);
// Wraps call to function 'CFStringGetBytes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetBytes(ewg_param_theString, ewg_param_range, ewg_param_encoding, ewg_param_lossByte, ewg_param_isExternalRepresentation, ewg_param_buffer, ewg_param_maxBufLen, ewg_param_usedBufLen) CFStringGetBytes ((CFStringRef)ewg_param_theString, *(CFRange*)ewg_param_range, (CFStringEncoding)ewg_param_encoding, (UInt8)ewg_param_lossByte, (Boolean)ewg_param_isExternalRepresentation, (UInt8*)ewg_param_buffer, (CFIndex)ewg_param_maxBufLen, (CFIndex*)ewg_param_usedBufLen)

CFIndex  ewg_function_CFStringGetBytes (CFStringRef theString, CFRange *range, CFStringEncoding encoding, UInt8 lossByte, Boolean isExternalRepresentation, UInt8 *buffer, CFIndex maxBufLen, CFIndex *usedBufLen);
// Wraps call to function 'CFStringCreateWithBytes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithBytes(ewg_param_alloc, ewg_param_bytes, ewg_param_numBytes, ewg_param_encoding, ewg_param_isExternalRepresentation) CFStringCreateWithBytes ((CFAllocatorRef)ewg_param_alloc, (UInt8 const*)ewg_param_bytes, (CFIndex)ewg_param_numBytes, (CFStringEncoding)ewg_param_encoding, (Boolean)ewg_param_isExternalRepresentation)

CFStringRef  ewg_function_CFStringCreateWithBytes (CFAllocatorRef alloc, UInt8 const *bytes, CFIndex numBytes, CFStringEncoding encoding, Boolean isExternalRepresentation);
// Wraps call to function 'CFStringCreateFromExternalRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateFromExternalRepresentation(ewg_param_alloc, ewg_param_data, ewg_param_encoding) CFStringCreateFromExternalRepresentation ((CFAllocatorRef)ewg_param_alloc, (CFDataRef)ewg_param_data, (CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFStringCreateFromExternalRepresentation (CFAllocatorRef alloc, CFDataRef data, CFStringEncoding encoding);
// Wraps call to function 'CFStringCreateExternalRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateExternalRepresentation(ewg_param_alloc, ewg_param_theString, ewg_param_encoding, ewg_param_lossByte) CFStringCreateExternalRepresentation ((CFAllocatorRef)ewg_param_alloc, (CFStringRef)ewg_param_theString, (CFStringEncoding)ewg_param_encoding, (UInt8)ewg_param_lossByte)

CFDataRef  ewg_function_CFStringCreateExternalRepresentation (CFAllocatorRef alloc, CFStringRef theString, CFStringEncoding encoding, UInt8 lossByte);
// Wraps call to function 'CFStringGetSmallestEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetSmallestEncoding(ewg_param_theString) CFStringGetSmallestEncoding ((CFStringRef)ewg_param_theString)

CFStringEncoding  ewg_function_CFStringGetSmallestEncoding (CFStringRef theString);
// Wraps call to function 'CFStringGetFastestEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetFastestEncoding(ewg_param_theString) CFStringGetFastestEncoding ((CFStringRef)ewg_param_theString)

CFStringEncoding  ewg_function_CFStringGetFastestEncoding (CFStringRef theString);
// Wraps call to function 'CFStringGetSystemEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetSystemEncoding CFStringGetSystemEncoding ()

CFStringEncoding  ewg_function_CFStringGetSystemEncoding (void);
// Wraps call to function 'CFStringGetMaximumSizeForEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetMaximumSizeForEncoding(ewg_param_length, ewg_param_encoding) CFStringGetMaximumSizeForEncoding ((CFIndex)ewg_param_length, (CFStringEncoding)ewg_param_encoding)

CFIndex  ewg_function_CFStringGetMaximumSizeForEncoding (CFIndex length, CFStringEncoding encoding);
// Wraps call to function 'CFStringGetFileSystemRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetFileSystemRepresentation(ewg_param_string, ewg_param_buffer, ewg_param_maxBufLen) CFStringGetFileSystemRepresentation ((CFStringRef)ewg_param_string, (char*)ewg_param_buffer, (CFIndex)ewg_param_maxBufLen)

Boolean  ewg_function_CFStringGetFileSystemRepresentation (CFStringRef string, char *buffer, CFIndex maxBufLen);
// Wraps call to function 'CFStringGetMaximumSizeOfFileSystemRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetMaximumSizeOfFileSystemRepresentation(ewg_param_string) CFStringGetMaximumSizeOfFileSystemRepresentation ((CFStringRef)ewg_param_string)

CFIndex  ewg_function_CFStringGetMaximumSizeOfFileSystemRepresentation (CFStringRef string);
// Wraps call to function 'CFStringCreateWithFileSystemRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateWithFileSystemRepresentation(ewg_param_alloc, ewg_param_buffer) CFStringCreateWithFileSystemRepresentation ((CFAllocatorRef)ewg_param_alloc, (char const*)ewg_param_buffer)

CFStringRef  ewg_function_CFStringCreateWithFileSystemRepresentation (CFAllocatorRef alloc, char const *buffer);
// Wraps call to function 'CFStringCompareWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCompareWithOptions(ewg_param_theString1, ewg_param_theString2, ewg_param_rangeToCompare, ewg_param_compareOptions) CFStringCompareWithOptions ((CFStringRef)ewg_param_theString1, (CFStringRef)ewg_param_theString2, *(CFRange*)ewg_param_rangeToCompare, (CFOptionFlags)ewg_param_compareOptions)

CFComparisonResult  ewg_function_CFStringCompareWithOptions (CFStringRef theString1, CFStringRef theString2, CFRange *rangeToCompare, CFOptionFlags compareOptions);
// Wraps call to function 'CFStringCompare' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCompare(ewg_param_theString1, ewg_param_theString2, ewg_param_compareOptions) CFStringCompare ((CFStringRef)ewg_param_theString1, (CFStringRef)ewg_param_theString2, (CFOptionFlags)ewg_param_compareOptions)

CFComparisonResult  ewg_function_CFStringCompare (CFStringRef theString1, CFStringRef theString2, CFOptionFlags compareOptions);
// Wraps call to function 'CFStringFindWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringFindWithOptions(ewg_param_theString, ewg_param_stringToFind, ewg_param_rangeToSearch, ewg_param_searchOptions, ewg_param_result) CFStringFindWithOptions ((CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_stringToFind, *(CFRange*)ewg_param_rangeToSearch, (CFOptionFlags)ewg_param_searchOptions, (CFRange*)ewg_param_result)

Boolean  ewg_function_CFStringFindWithOptions (CFStringRef theString, CFStringRef stringToFind, CFRange *rangeToSearch, CFOptionFlags searchOptions, CFRange *result);
// Wraps call to function 'CFStringCreateArrayWithFindResults' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateArrayWithFindResults(ewg_param_alloc, ewg_param_theString, ewg_param_stringToFind, ewg_param_rangeToSearch, ewg_param_compareOptions) CFStringCreateArrayWithFindResults ((CFAllocatorRef)ewg_param_alloc, (CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_stringToFind, *(CFRange*)ewg_param_rangeToSearch, (CFOptionFlags)ewg_param_compareOptions)

CFArrayRef  ewg_function_CFStringCreateArrayWithFindResults (CFAllocatorRef alloc, CFStringRef theString, CFStringRef stringToFind, CFRange *rangeToSearch, CFOptionFlags compareOptions);
// Wraps call to function 'CFStringFind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringFind(ewg_param_theString, ewg_param_stringToFind, ewg_param_compareOptions) CFStringFind ((CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_stringToFind, (CFOptionFlags)ewg_param_compareOptions)

CFRange * ewg_function_CFStringFind (CFStringRef theString, CFStringRef stringToFind, CFOptionFlags compareOptions);
// Wraps call to function 'CFStringHasPrefix' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringHasPrefix(ewg_param_theString, ewg_param_prefix) CFStringHasPrefix ((CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_prefix)

Boolean  ewg_function_CFStringHasPrefix (CFStringRef theString, CFStringRef prefix);
// Wraps call to function 'CFStringHasSuffix' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringHasSuffix(ewg_param_theString, ewg_param_suffix) CFStringHasSuffix ((CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_suffix)

Boolean  ewg_function_CFStringHasSuffix (CFStringRef theString, CFStringRef suffix);
// Wraps call to function 'CFStringGetRangeOfComposedCharactersAtIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetRangeOfComposedCharactersAtIndex(ewg_param_theString, ewg_param_theIndex) CFStringGetRangeOfComposedCharactersAtIndex ((CFStringRef)ewg_param_theString, (CFIndex)ewg_param_theIndex)

CFRange * ewg_function_CFStringGetRangeOfComposedCharactersAtIndex (CFStringRef theString, CFIndex theIndex);
// Wraps call to function 'CFStringFindCharacterFromSet' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringFindCharacterFromSet(ewg_param_theString, ewg_param_theSet, ewg_param_rangeToSearch, ewg_param_searchOptions, ewg_param_result) CFStringFindCharacterFromSet ((CFStringRef)ewg_param_theString, (CFCharacterSetRef)ewg_param_theSet, *(CFRange*)ewg_param_rangeToSearch, (CFOptionFlags)ewg_param_searchOptions, (CFRange*)ewg_param_result)

Boolean  ewg_function_CFStringFindCharacterFromSet (CFStringRef theString, CFCharacterSetRef theSet, CFRange *rangeToSearch, CFOptionFlags searchOptions, CFRange *result);
// Wraps call to function 'CFStringGetLineBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetLineBounds(ewg_param_theString, ewg_param_range, ewg_param_lineBeginIndex, ewg_param_lineEndIndex, ewg_param_contentsEndIndex) CFStringGetLineBounds ((CFStringRef)ewg_param_theString, *(CFRange*)ewg_param_range, (CFIndex*)ewg_param_lineBeginIndex, (CFIndex*)ewg_param_lineEndIndex, (CFIndex*)ewg_param_contentsEndIndex)

void  ewg_function_CFStringGetLineBounds (CFStringRef theString, CFRange *range, CFIndex *lineBeginIndex, CFIndex *lineEndIndex, CFIndex *contentsEndIndex);
// Wraps call to function 'CFStringCreateByCombiningStrings' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateByCombiningStrings(ewg_param_alloc, ewg_param_theArray, ewg_param_separatorString) CFStringCreateByCombiningStrings ((CFAllocatorRef)ewg_param_alloc, (CFArrayRef)ewg_param_theArray, (CFStringRef)ewg_param_separatorString)

CFStringRef  ewg_function_CFStringCreateByCombiningStrings (CFAllocatorRef alloc, CFArrayRef theArray, CFStringRef separatorString);
// Wraps call to function 'CFStringCreateArrayBySeparatingStrings' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCreateArrayBySeparatingStrings(ewg_param_alloc, ewg_param_theString, ewg_param_separatorString) CFStringCreateArrayBySeparatingStrings ((CFAllocatorRef)ewg_param_alloc, (CFStringRef)ewg_param_theString, (CFStringRef)ewg_param_separatorString)

CFArrayRef  ewg_function_CFStringCreateArrayBySeparatingStrings (CFAllocatorRef alloc, CFStringRef theString, CFStringRef separatorString);
// Wraps call to function 'CFStringGetIntValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetIntValue(ewg_param_str) CFStringGetIntValue ((CFStringRef)ewg_param_str)

SInt32  ewg_function_CFStringGetIntValue (CFStringRef str);
// Wraps call to function 'CFStringGetDoubleValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetDoubleValue(ewg_param_str) CFStringGetDoubleValue ((CFStringRef)ewg_param_str)

double  ewg_function_CFStringGetDoubleValue (CFStringRef str);
// Wraps call to function 'CFStringAppend' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringAppend(ewg_param_theString, ewg_param_appendedString) CFStringAppend ((CFMutableStringRef)ewg_param_theString, (CFStringRef)ewg_param_appendedString)

void  ewg_function_CFStringAppend (CFMutableStringRef theString, CFStringRef appendedString);
// Wraps call to function 'CFStringAppendCharacters' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringAppendCharacters(ewg_param_theString, ewg_param_chars, ewg_param_numChars) CFStringAppendCharacters ((CFMutableStringRef)ewg_param_theString, (UniChar const*)ewg_param_chars, (CFIndex)ewg_param_numChars)

void  ewg_function_CFStringAppendCharacters (CFMutableStringRef theString, UniChar const *chars, CFIndex numChars);
// Wraps call to function 'CFStringAppendPascalString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringAppendPascalString(ewg_param_theString, ewg_param_pStr, ewg_param_encoding) CFStringAppendPascalString ((CFMutableStringRef)ewg_param_theString, (ConstStr255Param)ewg_param_pStr, (CFStringEncoding)ewg_param_encoding)

void  ewg_function_CFStringAppendPascalString (CFMutableStringRef theString, ConstStr255Param pStr, CFStringEncoding encoding);
// Wraps call to function 'CFStringAppendCString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringAppendCString(ewg_param_theString, ewg_param_cStr, ewg_param_encoding) CFStringAppendCString ((CFMutableStringRef)ewg_param_theString, (char const*)ewg_param_cStr, (CFStringEncoding)ewg_param_encoding)

void  ewg_function_CFStringAppendCString (CFMutableStringRef theString, char const *cStr, CFStringEncoding encoding);
// Wraps call to function 'CFStringAppendFormat' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringAppendFormat(ewg_param_theString, ewg_param_formatOptions, ewg_param_format) CFStringAppendFormat ((CFMutableStringRef)ewg_param_theString, (CFDictionaryRef)ewg_param_formatOptions, (CFStringRef)ewg_param_format)

void  ewg_function_CFStringAppendFormat (CFMutableStringRef theString, CFDictionaryRef formatOptions, CFStringRef format);
// Wraps call to function 'CFStringInsert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringInsert(ewg_param_str, ewg_param_idx, ewg_param_insertedStr) CFStringInsert ((CFMutableStringRef)ewg_param_str, (CFIndex)ewg_param_idx, (CFStringRef)ewg_param_insertedStr)

void  ewg_function_CFStringInsert (CFMutableStringRef str, CFIndex idx, CFStringRef insertedStr);
// Wraps call to function 'CFStringDelete' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringDelete(ewg_param_theString, ewg_param_range) CFStringDelete ((CFMutableStringRef)ewg_param_theString, *(CFRange*)ewg_param_range)

void  ewg_function_CFStringDelete (CFMutableStringRef theString, CFRange *range);
// Wraps call to function 'CFStringReplace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringReplace(ewg_param_theString, ewg_param_range, ewg_param_replacement) CFStringReplace ((CFMutableStringRef)ewg_param_theString, *(CFRange*)ewg_param_range, (CFStringRef)ewg_param_replacement)

void  ewg_function_CFStringReplace (CFMutableStringRef theString, CFRange *range, CFStringRef replacement);
// Wraps call to function 'CFStringReplaceAll' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringReplaceAll(ewg_param_theString, ewg_param_replacement) CFStringReplaceAll ((CFMutableStringRef)ewg_param_theString, (CFStringRef)ewg_param_replacement)

void  ewg_function_CFStringReplaceAll (CFMutableStringRef theString, CFStringRef replacement);
// Wraps call to function 'CFStringFindAndReplace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringFindAndReplace(ewg_param_theString, ewg_param_stringToFind, ewg_param_replacementString, ewg_param_rangeToSearch, ewg_param_compareOptions) CFStringFindAndReplace ((CFMutableStringRef)ewg_param_theString, (CFStringRef)ewg_param_stringToFind, (CFStringRef)ewg_param_replacementString, *(CFRange*)ewg_param_rangeToSearch, (CFOptionFlags)ewg_param_compareOptions)

CFIndex  ewg_function_CFStringFindAndReplace (CFMutableStringRef theString, CFStringRef stringToFind, CFStringRef replacementString, CFRange *rangeToSearch, CFOptionFlags compareOptions);
// Wraps call to function 'CFStringSetExternalCharactersNoCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringSetExternalCharactersNoCopy(ewg_param_theString, ewg_param_chars, ewg_param_length, ewg_param_capacity) CFStringSetExternalCharactersNoCopy ((CFMutableStringRef)ewg_param_theString, (UniChar*)ewg_param_chars, (CFIndex)ewg_param_length, (CFIndex)ewg_param_capacity)

void  ewg_function_CFStringSetExternalCharactersNoCopy (CFMutableStringRef theString, UniChar *chars, CFIndex length, CFIndex capacity);
// Wraps call to function 'CFStringPad' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringPad(ewg_param_theString, ewg_param_padString, ewg_param_length, ewg_param_indexIntoPad) CFStringPad ((CFMutableStringRef)ewg_param_theString, (CFStringRef)ewg_param_padString, (CFIndex)ewg_param_length, (CFIndex)ewg_param_indexIntoPad)

void  ewg_function_CFStringPad (CFMutableStringRef theString, CFStringRef padString, CFIndex length, CFIndex indexIntoPad);
// Wraps call to function 'CFStringTrim' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringTrim(ewg_param_theString, ewg_param_trimString) CFStringTrim ((CFMutableStringRef)ewg_param_theString, (CFStringRef)ewg_param_trimString)

void  ewg_function_CFStringTrim (CFMutableStringRef theString, CFStringRef trimString);
// Wraps call to function 'CFStringTrimWhitespace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringTrimWhitespace(ewg_param_theString) CFStringTrimWhitespace ((CFMutableStringRef)ewg_param_theString)

void  ewg_function_CFStringTrimWhitespace (CFMutableStringRef theString);
// Wraps call to function 'CFStringLowercase' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringLowercase(ewg_param_theString, ewg_param_locale) CFStringLowercase ((CFMutableStringRef)ewg_param_theString, (CFLocaleRef)ewg_param_locale)

void  ewg_function_CFStringLowercase (CFMutableStringRef theString, CFLocaleRef locale);
// Wraps call to function 'CFStringUppercase' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringUppercase(ewg_param_theString, ewg_param_locale) CFStringUppercase ((CFMutableStringRef)ewg_param_theString, (CFLocaleRef)ewg_param_locale)

void  ewg_function_CFStringUppercase (CFMutableStringRef theString, CFLocaleRef locale);
// Wraps call to function 'CFStringCapitalize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringCapitalize(ewg_param_theString, ewg_param_locale) CFStringCapitalize ((CFMutableStringRef)ewg_param_theString, (CFLocaleRef)ewg_param_locale)

void  ewg_function_CFStringCapitalize (CFMutableStringRef theString, CFLocaleRef locale);
// Wraps call to function 'CFStringNormalize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringNormalize(ewg_param_theString, ewg_param_theForm) CFStringNormalize ((CFMutableStringRef)ewg_param_theString, (CFStringNormalizationForm)ewg_param_theForm)

void  ewg_function_CFStringNormalize (CFMutableStringRef theString, CFStringNormalizationForm theForm);
// Wraps call to function 'CFStringTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringTransform(ewg_param_string, ewg_param_range, ewg_param_transform, ewg_param_reverse) CFStringTransform ((CFMutableStringRef)ewg_param_string, (CFRange*)ewg_param_range, (CFStringRef)ewg_param_transform, (Boolean)ewg_param_reverse)

Boolean  ewg_function_CFStringTransform (CFMutableStringRef string, CFRange *range, CFStringRef transform, Boolean reverse);
// Wraps call to function 'CFStringIsEncodingAvailable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringIsEncodingAvailable(ewg_param_encoding) CFStringIsEncodingAvailable ((CFStringEncoding)ewg_param_encoding)

Boolean  ewg_function_CFStringIsEncodingAvailable (CFStringEncoding encoding);
// Wraps call to function 'CFStringGetListOfAvailableEncodings' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetListOfAvailableEncodings CFStringGetListOfAvailableEncodings ()

CFStringEncoding const * ewg_function_CFStringGetListOfAvailableEncodings (void);
// Wraps call to function 'CFStringGetNameOfEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetNameOfEncoding(ewg_param_encoding) CFStringGetNameOfEncoding ((CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFStringGetNameOfEncoding (CFStringEncoding encoding);
// Wraps call to function 'CFStringConvertEncodingToNSStringEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertEncodingToNSStringEncoding(ewg_param_encoding) CFStringConvertEncodingToNSStringEncoding ((CFStringEncoding)ewg_param_encoding)

UInt32  ewg_function_CFStringConvertEncodingToNSStringEncoding (CFStringEncoding encoding);
// Wraps call to function 'CFStringConvertNSStringEncodingToEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertNSStringEncodingToEncoding(ewg_param_encoding) CFStringConvertNSStringEncodingToEncoding ((UInt32)ewg_param_encoding)

CFStringEncoding  ewg_function_CFStringConvertNSStringEncodingToEncoding (UInt32 encoding);
// Wraps call to function 'CFStringConvertEncodingToWindowsCodepage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertEncodingToWindowsCodepage(ewg_param_encoding) CFStringConvertEncodingToWindowsCodepage ((CFStringEncoding)ewg_param_encoding)

UInt32  ewg_function_CFStringConvertEncodingToWindowsCodepage (CFStringEncoding encoding);
// Wraps call to function 'CFStringConvertWindowsCodepageToEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertWindowsCodepageToEncoding(ewg_param_codepage) CFStringConvertWindowsCodepageToEncoding ((UInt32)ewg_param_codepage)

CFStringEncoding  ewg_function_CFStringConvertWindowsCodepageToEncoding (UInt32 codepage);
// Wraps call to function 'CFStringConvertIANACharSetNameToEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertIANACharSetNameToEncoding(ewg_param_theString) CFStringConvertIANACharSetNameToEncoding ((CFStringRef)ewg_param_theString)

CFStringEncoding  ewg_function_CFStringConvertIANACharSetNameToEncoding (CFStringRef theString);
// Wraps call to function 'CFStringConvertEncodingToIANACharSetName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringConvertEncodingToIANACharSetName(ewg_param_encoding) CFStringConvertEncodingToIANACharSetName ((CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFStringConvertEncodingToIANACharSetName (CFStringEncoding encoding);
// Wraps call to function 'CFStringGetMostCompatibleMacStringEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFStringGetMostCompatibleMacStringEncoding(ewg_param_encoding) CFStringGetMostCompatibleMacStringEncoding ((CFStringEncoding)ewg_param_encoding)

CFStringEncoding  ewg_function_CFStringGetMostCompatibleMacStringEncoding (CFStringEncoding encoding);
// Wraps call to function 'CFShow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFShow(ewg_param_obj) CFShow ((CFTypeRef)ewg_param_obj)

void  ewg_function_CFShow (CFTypeRef obj);
// Wraps call to function 'CFShowStr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFShowStr(ewg_param_str) CFShowStr ((CFStringRef)ewg_param_str)

void  ewg_function_CFShowStr (CFStringRef str);
// Wraps call to function '__CFStringMakeConstantString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro___CFStringMakeConstantString(ewg_param_cStr) __CFStringMakeConstantString ((char const*)ewg_param_cStr)

CFStringRef  ewg_function___CFStringMakeConstantString (char const *cStr);
// Wraps call to function 'CFURLGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetTypeID CFURLGetTypeID ()

CFTypeID  ewg_function_CFURLGetTypeID (void);
// Wraps call to function 'CFURLCreateWithBytes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateWithBytes(ewg_param_allocator, ewg_param_URLBytes, ewg_param_length, ewg_param_encoding, ewg_param_baseURL) CFURLCreateWithBytes ((CFAllocatorRef)ewg_param_allocator, (UInt8 const*)ewg_param_URLBytes, (CFIndex)ewg_param_length, (CFStringEncoding)ewg_param_encoding, (CFURLRef)ewg_param_baseURL)

CFURLRef  ewg_function_CFURLCreateWithBytes (CFAllocatorRef allocator, UInt8 const *URLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL);
// Wraps call to function 'CFURLCreateData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateData(ewg_param_allocator, ewg_param_url, ewg_param_encoding, ewg_param_escapeWhitespace) CFURLCreateData ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url, (CFStringEncoding)ewg_param_encoding, (Boolean)ewg_param_escapeWhitespace)

CFDataRef  ewg_function_CFURLCreateData (CFAllocatorRef allocator, CFURLRef url, CFStringEncoding encoding, Boolean escapeWhitespace);
// Wraps call to function 'CFURLCreateWithString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateWithString(ewg_param_allocator, ewg_param_URLString, ewg_param_baseURL) CFURLCreateWithString ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_URLString, (CFURLRef)ewg_param_baseURL)

CFURLRef  ewg_function_CFURLCreateWithString (CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL);
// Wraps call to function 'CFURLCreateAbsoluteURLWithBytes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateAbsoluteURLWithBytes(ewg_param_alloc, ewg_param_relativeURLBytes, ewg_param_length, ewg_param_encoding, ewg_param_baseURL, ewg_param_useCompatibilityMode) CFURLCreateAbsoluteURLWithBytes ((CFAllocatorRef)ewg_param_alloc, (UInt8 const*)ewg_param_relativeURLBytes, (CFIndex)ewg_param_length, (CFStringEncoding)ewg_param_encoding, (CFURLRef)ewg_param_baseURL, (Boolean)ewg_param_useCompatibilityMode)

CFURLRef  ewg_function_CFURLCreateAbsoluteURLWithBytes (CFAllocatorRef alloc, UInt8 const *relativeURLBytes, CFIndex length, CFStringEncoding encoding, CFURLRef baseURL, Boolean useCompatibilityMode);
// Wraps call to function 'CFURLCreateWithFileSystemPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateWithFileSystemPath(ewg_param_allocator, ewg_param_filePath, ewg_param_pathStyle, ewg_param_isDirectory) CFURLCreateWithFileSystemPath ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_filePath, (CFURLPathStyle)ewg_param_pathStyle, (Boolean)ewg_param_isDirectory)

CFURLRef  ewg_function_CFURLCreateWithFileSystemPath (CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory);
// Wraps call to function 'CFURLCreateFromFileSystemRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateFromFileSystemRepresentation(ewg_param_allocator, ewg_param_buffer, ewg_param_bufLen, ewg_param_isDirectory) CFURLCreateFromFileSystemRepresentation ((CFAllocatorRef)ewg_param_allocator, (UInt8 const*)ewg_param_buffer, (CFIndex)ewg_param_bufLen, (Boolean)ewg_param_isDirectory)

CFURLRef  ewg_function_CFURLCreateFromFileSystemRepresentation (CFAllocatorRef allocator, UInt8 const *buffer, CFIndex bufLen, Boolean isDirectory);
// Wraps call to function 'CFURLCreateWithFileSystemPathRelativeToBase' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateWithFileSystemPathRelativeToBase(ewg_param_allocator, ewg_param_filePath, ewg_param_pathStyle, ewg_param_isDirectory, ewg_param_baseURL) CFURLCreateWithFileSystemPathRelativeToBase ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_filePath, (CFURLPathStyle)ewg_param_pathStyle, (Boolean)ewg_param_isDirectory, (CFURLRef)ewg_param_baseURL)

CFURLRef  ewg_function_CFURLCreateWithFileSystemPathRelativeToBase (CFAllocatorRef allocator, CFStringRef filePath, CFURLPathStyle pathStyle, Boolean isDirectory, CFURLRef baseURL);
// Wraps call to function 'CFURLCreateFromFileSystemRepresentationRelativeToBase' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateFromFileSystemRepresentationRelativeToBase(ewg_param_allocator, ewg_param_buffer, ewg_param_bufLen, ewg_param_isDirectory, ewg_param_baseURL) CFURLCreateFromFileSystemRepresentationRelativeToBase ((CFAllocatorRef)ewg_param_allocator, (UInt8 const*)ewg_param_buffer, (CFIndex)ewg_param_bufLen, (Boolean)ewg_param_isDirectory, (CFURLRef)ewg_param_baseURL)

CFURLRef  ewg_function_CFURLCreateFromFileSystemRepresentationRelativeToBase (CFAllocatorRef allocator, UInt8 const *buffer, CFIndex bufLen, Boolean isDirectory, CFURLRef baseURL);
// Wraps call to function 'CFURLGetFileSystemRepresentation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetFileSystemRepresentation(ewg_param_url, ewg_param_resolveAgainstBase, ewg_param_buffer, ewg_param_maxBufLen) CFURLGetFileSystemRepresentation ((CFURLRef)ewg_param_url, (Boolean)ewg_param_resolveAgainstBase, (UInt8*)ewg_param_buffer, (CFIndex)ewg_param_maxBufLen)

Boolean  ewg_function_CFURLGetFileSystemRepresentation (CFURLRef url, Boolean resolveAgainstBase, UInt8 *buffer, CFIndex maxBufLen);
// Wraps call to function 'CFURLCopyAbsoluteURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyAbsoluteURL(ewg_param_relativeURL) CFURLCopyAbsoluteURL ((CFURLRef)ewg_param_relativeURL)

CFURLRef  ewg_function_CFURLCopyAbsoluteURL (CFURLRef relativeURL);
// Wraps call to function 'CFURLGetString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetString(ewg_param_anURL) CFURLGetString ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLGetString (CFURLRef anURL);
// Wraps call to function 'CFURLGetBaseURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetBaseURL(ewg_param_anURL) CFURLGetBaseURL ((CFURLRef)ewg_param_anURL)

CFURLRef  ewg_function_CFURLGetBaseURL (CFURLRef anURL);
// Wraps call to function 'CFURLCanBeDecomposed' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCanBeDecomposed(ewg_param_anURL) CFURLCanBeDecomposed ((CFURLRef)ewg_param_anURL)

Boolean  ewg_function_CFURLCanBeDecomposed (CFURLRef anURL);
// Wraps call to function 'CFURLCopyScheme' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyScheme(ewg_param_anURL) CFURLCopyScheme ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyScheme (CFURLRef anURL);
// Wraps call to function 'CFURLCopyNetLocation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyNetLocation(ewg_param_anURL) CFURLCopyNetLocation ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyNetLocation (CFURLRef anURL);
// Wraps call to function 'CFURLCopyPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyPath(ewg_param_anURL) CFURLCopyPath ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyPath (CFURLRef anURL);
// Wraps call to function 'CFURLCopyStrictPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyStrictPath(ewg_param_anURL, ewg_param_isAbsolute) CFURLCopyStrictPath ((CFURLRef)ewg_param_anURL, (Boolean*)ewg_param_isAbsolute)

CFStringRef  ewg_function_CFURLCopyStrictPath (CFURLRef anURL, Boolean *isAbsolute);
// Wraps call to function 'CFURLCopyFileSystemPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyFileSystemPath(ewg_param_anURL, ewg_param_pathStyle) CFURLCopyFileSystemPath ((CFURLRef)ewg_param_anURL, (CFURLPathStyle)ewg_param_pathStyle)

CFStringRef  ewg_function_CFURLCopyFileSystemPath (CFURLRef anURL, CFURLPathStyle pathStyle);
// Wraps call to function 'CFURLHasDirectoryPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLHasDirectoryPath(ewg_param_anURL) CFURLHasDirectoryPath ((CFURLRef)ewg_param_anURL)

Boolean  ewg_function_CFURLHasDirectoryPath (CFURLRef anURL);
// Wraps call to function 'CFURLCopyResourceSpecifier' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyResourceSpecifier(ewg_param_anURL) CFURLCopyResourceSpecifier ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyResourceSpecifier (CFURLRef anURL);
// Wraps call to function 'CFURLCopyHostName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyHostName(ewg_param_anURL) CFURLCopyHostName ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyHostName (CFURLRef anURL);
// Wraps call to function 'CFURLGetPortNumber' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetPortNumber(ewg_param_anURL) CFURLGetPortNumber ((CFURLRef)ewg_param_anURL)

SInt32  ewg_function_CFURLGetPortNumber (CFURLRef anURL);
// Wraps call to function 'CFURLCopyUserName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyUserName(ewg_param_anURL) CFURLCopyUserName ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyUserName (CFURLRef anURL);
// Wraps call to function 'CFURLCopyPassword' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyPassword(ewg_param_anURL) CFURLCopyPassword ((CFURLRef)ewg_param_anURL)

CFStringRef  ewg_function_CFURLCopyPassword (CFURLRef anURL);
// Wraps call to function 'CFURLCopyParameterString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyParameterString(ewg_param_anURL, ewg_param_charactersToLeaveEscaped) CFURLCopyParameterString ((CFURLRef)ewg_param_anURL, (CFStringRef)ewg_param_charactersToLeaveEscaped)

CFStringRef  ewg_function_CFURLCopyParameterString (CFURLRef anURL, CFStringRef charactersToLeaveEscaped);
// Wraps call to function 'CFURLCopyQueryString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyQueryString(ewg_param_anURL, ewg_param_charactersToLeaveEscaped) CFURLCopyQueryString ((CFURLRef)ewg_param_anURL, (CFStringRef)ewg_param_charactersToLeaveEscaped)

CFStringRef  ewg_function_CFURLCopyQueryString (CFURLRef anURL, CFStringRef charactersToLeaveEscaped);
// Wraps call to function 'CFURLCopyFragment' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyFragment(ewg_param_anURL, ewg_param_charactersToLeaveEscaped) CFURLCopyFragment ((CFURLRef)ewg_param_anURL, (CFStringRef)ewg_param_charactersToLeaveEscaped)

CFStringRef  ewg_function_CFURLCopyFragment (CFURLRef anURL, CFStringRef charactersToLeaveEscaped);
// Wraps call to function 'CFURLCopyLastPathComponent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyLastPathComponent(ewg_param_url) CFURLCopyLastPathComponent ((CFURLRef)ewg_param_url)

CFStringRef  ewg_function_CFURLCopyLastPathComponent (CFURLRef url);
// Wraps call to function 'CFURLCopyPathExtension' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCopyPathExtension(ewg_param_url) CFURLCopyPathExtension ((CFURLRef)ewg_param_url)

CFStringRef  ewg_function_CFURLCopyPathExtension (CFURLRef url);
// Wraps call to function 'CFURLCreateCopyAppendingPathComponent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateCopyAppendingPathComponent(ewg_param_allocator, ewg_param_url, ewg_param_pathComponent, ewg_param_isDirectory) CFURLCreateCopyAppendingPathComponent ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url, (CFStringRef)ewg_param_pathComponent, (Boolean)ewg_param_isDirectory)

CFURLRef  ewg_function_CFURLCreateCopyAppendingPathComponent (CFAllocatorRef allocator, CFURLRef url, CFStringRef pathComponent, Boolean isDirectory);
// Wraps call to function 'CFURLCreateCopyDeletingLastPathComponent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateCopyDeletingLastPathComponent(ewg_param_allocator, ewg_param_url) CFURLCreateCopyDeletingLastPathComponent ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url)

CFURLRef  ewg_function_CFURLCreateCopyDeletingLastPathComponent (CFAllocatorRef allocator, CFURLRef url);
// Wraps call to function 'CFURLCreateCopyAppendingPathExtension' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateCopyAppendingPathExtension(ewg_param_allocator, ewg_param_url, ewg_param_extension) CFURLCreateCopyAppendingPathExtension ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url, (CFStringRef)ewg_param_extension)

CFURLRef  ewg_function_CFURLCreateCopyAppendingPathExtension (CFAllocatorRef allocator, CFURLRef url, CFStringRef extension);
// Wraps call to function 'CFURLCreateCopyDeletingPathExtension' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateCopyDeletingPathExtension(ewg_param_allocator, ewg_param_url) CFURLCreateCopyDeletingPathExtension ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url)

CFURLRef  ewg_function_CFURLCreateCopyDeletingPathExtension (CFAllocatorRef allocator, CFURLRef url);
// Wraps call to function 'CFURLGetBytes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetBytes(ewg_param_url, ewg_param_buffer, ewg_param_bufferLength) CFURLGetBytes ((CFURLRef)ewg_param_url, (UInt8*)ewg_param_buffer, (CFIndex)ewg_param_bufferLength)

CFIndex  ewg_function_CFURLGetBytes (CFURLRef url, UInt8 *buffer, CFIndex bufferLength);
// Wraps call to function 'CFURLGetByteRangeForComponent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetByteRangeForComponent(ewg_param_url, ewg_param_component, ewg_param_rangeIncludingSeparators) CFURLGetByteRangeForComponent ((CFURLRef)ewg_param_url, (CFURLComponentType)ewg_param_component, (CFRange*)ewg_param_rangeIncludingSeparators)

CFRange * ewg_function_CFURLGetByteRangeForComponent (CFURLRef url, CFURLComponentType component, CFRange *rangeIncludingSeparators);
// Wraps call to function 'CFURLCreateStringByReplacingPercentEscapes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateStringByReplacingPercentEscapes(ewg_param_allocator, ewg_param_originalString, ewg_param_charactersToLeaveEscaped) CFURLCreateStringByReplacingPercentEscapes ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_originalString, (CFStringRef)ewg_param_charactersToLeaveEscaped)

CFStringRef  ewg_function_CFURLCreateStringByReplacingPercentEscapes (CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveEscaped);
// Wraps call to function 'CFURLCreateStringByReplacingPercentEscapesUsingEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateStringByReplacingPercentEscapesUsingEncoding(ewg_param_allocator, ewg_param_origString, ewg_param_charsToLeaveEscaped, ewg_param_encoding) CFURLCreateStringByReplacingPercentEscapesUsingEncoding ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_origString, (CFStringRef)ewg_param_charsToLeaveEscaped, (CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFURLCreateStringByReplacingPercentEscapesUsingEncoding (CFAllocatorRef allocator, CFStringRef origString, CFStringRef charsToLeaveEscaped, CFStringEncoding encoding);
// Wraps call to function 'CFURLCreateStringByAddingPercentEscapes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateStringByAddingPercentEscapes(ewg_param_allocator, ewg_param_originalString, ewg_param_charactersToLeaveUnescaped, ewg_param_legalURLCharactersToBeEscaped, ewg_param_encoding) CFURLCreateStringByAddingPercentEscapes ((CFAllocatorRef)ewg_param_allocator, (CFStringRef)ewg_param_originalString, (CFStringRef)ewg_param_charactersToLeaveUnescaped, (CFStringRef)ewg_param_legalURLCharactersToBeEscaped, (CFStringEncoding)ewg_param_encoding)

CFStringRef  ewg_function_CFURLCreateStringByAddingPercentEscapes (CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveUnescaped, CFStringRef legalURLCharactersToBeEscaped, CFStringEncoding encoding);
// Wraps call to function 'CFURLCreateFromFSRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLCreateFromFSRef(ewg_param_allocator, ewg_param_fsRef) CFURLCreateFromFSRef ((CFAllocatorRef)ewg_param_allocator, (struct FSRef const*)ewg_param_fsRef)

CFURLRef  ewg_function_CFURLCreateFromFSRef (CFAllocatorRef allocator, struct FSRef const *fsRef);
// Wraps call to function 'CFURLGetFSRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFURLGetFSRef(ewg_param_url, ewg_param_fsRef) CFURLGetFSRef ((CFURLRef)ewg_param_url, (struct FSRef*)ewg_param_fsRef)

Boolean  ewg_function_CFURLGetFSRef (CFURLRef url, struct FSRef *fsRef);
// Wraps call to function 'CFBundleGetMainBundle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetMainBundle CFBundleGetMainBundle ()

CFBundleRef  ewg_function_CFBundleGetMainBundle (void);
// Wraps call to function 'CFBundleGetBundleWithIdentifier' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetBundleWithIdentifier(ewg_param_bundleID) CFBundleGetBundleWithIdentifier ((CFStringRef)ewg_param_bundleID)

CFBundleRef  ewg_function_CFBundleGetBundleWithIdentifier (CFStringRef bundleID);
// Wraps call to function 'CFBundleGetAllBundles' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetAllBundles CFBundleGetAllBundles ()

CFArrayRef  ewg_function_CFBundleGetAllBundles (void);
// Wraps call to function 'CFBundleGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetTypeID CFBundleGetTypeID ()

UInt32  ewg_function_CFBundleGetTypeID (void);
// Wraps call to function 'CFBundleCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCreate(ewg_param_allocator, ewg_param_bundleURL) CFBundleCreate ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_bundleURL)

CFBundleRef  ewg_function_CFBundleCreate (CFAllocatorRef allocator, CFURLRef bundleURL);
// Wraps call to function 'CFBundleCreateBundlesFromDirectory' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCreateBundlesFromDirectory(ewg_param_allocator, ewg_param_directoryURL, ewg_param_bundleType) CFBundleCreateBundlesFromDirectory ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_directoryURL, (CFStringRef)ewg_param_bundleType)

CFArrayRef  ewg_function_CFBundleCreateBundlesFromDirectory (CFAllocatorRef allocator, CFURLRef directoryURL, CFStringRef bundleType);
// Wraps call to function 'CFBundleCopyBundleURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyBundleURL(ewg_param_bundle) CFBundleCopyBundleURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopyBundleURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetValueForInfoDictionaryKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetValueForInfoDictionaryKey(ewg_param_bundle, ewg_param_key) CFBundleGetValueForInfoDictionaryKey ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_key)

CFTypeRef  ewg_function_CFBundleGetValueForInfoDictionaryKey (CFBundleRef bundle, CFStringRef key);
// Wraps call to function 'CFBundleGetInfoDictionary' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetInfoDictionary(ewg_param_bundle) CFBundleGetInfoDictionary ((CFBundleRef)ewg_param_bundle)

CFDictionaryRef  ewg_function_CFBundleGetInfoDictionary (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetLocalInfoDictionary' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetLocalInfoDictionary(ewg_param_bundle) CFBundleGetLocalInfoDictionary ((CFBundleRef)ewg_param_bundle)

CFDictionaryRef  ewg_function_CFBundleGetLocalInfoDictionary (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetPackageInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetPackageInfo(ewg_param_bundle, ewg_param_packageType, ewg_param_packageCreator) CFBundleGetPackageInfo ((CFBundleRef)ewg_param_bundle, (UInt32*)ewg_param_packageType, (UInt32*)ewg_param_packageCreator)

void  ewg_function_CFBundleGetPackageInfo (CFBundleRef bundle, UInt32 *packageType, UInt32 *packageCreator);
// Wraps call to function 'CFBundleGetIdentifier' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetIdentifier(ewg_param_bundle) CFBundleGetIdentifier ((CFBundleRef)ewg_param_bundle)

CFStringRef  ewg_function_CFBundleGetIdentifier (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetVersionNumber' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetVersionNumber(ewg_param_bundle) CFBundleGetVersionNumber ((CFBundleRef)ewg_param_bundle)

UInt32  ewg_function_CFBundleGetVersionNumber (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetDevelopmentRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetDevelopmentRegion(ewg_param_bundle) CFBundleGetDevelopmentRegion ((CFBundleRef)ewg_param_bundle)

CFStringRef  ewg_function_CFBundleGetDevelopmentRegion (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopySupportFilesDirectoryURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopySupportFilesDirectoryURL(ewg_param_bundle) CFBundleCopySupportFilesDirectoryURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopySupportFilesDirectoryURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopyResourcesDirectoryURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourcesDirectoryURL(ewg_param_bundle) CFBundleCopyResourcesDirectoryURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopyResourcesDirectoryURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopyPrivateFrameworksURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyPrivateFrameworksURL(ewg_param_bundle) CFBundleCopyPrivateFrameworksURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopyPrivateFrameworksURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopySharedFrameworksURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopySharedFrameworksURL(ewg_param_bundle) CFBundleCopySharedFrameworksURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopySharedFrameworksURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopySharedSupportURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopySharedSupportURL(ewg_param_bundle) CFBundleCopySharedSupportURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopySharedSupportURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopyBuiltInPlugInsURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyBuiltInPlugInsURL(ewg_param_bundle) CFBundleCopyBuiltInPlugInsURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopyBuiltInPlugInsURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopyInfoDictionaryInDirectory' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyInfoDictionaryInDirectory(ewg_param_bundleURL) CFBundleCopyInfoDictionaryInDirectory ((CFURLRef)ewg_param_bundleURL)

CFDictionaryRef  ewg_function_CFBundleCopyInfoDictionaryInDirectory (CFURLRef bundleURL);
// Wraps call to function 'CFBundleGetPackageInfoInDirectory' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetPackageInfoInDirectory(ewg_param_url, ewg_param_packageType, ewg_param_packageCreator) CFBundleGetPackageInfoInDirectory ((CFURLRef)ewg_param_url, (UInt32*)ewg_param_packageType, (UInt32*)ewg_param_packageCreator)

Boolean  ewg_function_CFBundleGetPackageInfoInDirectory (CFURLRef url, UInt32 *packageType, UInt32 *packageCreator);
// Wraps call to function 'CFBundleCopyResourceURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURL(ewg_param_bundle, ewg_param_resourceName, ewg_param_resourceType, ewg_param_subDirName) CFBundleCopyResourceURL ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_resourceName, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName)

CFURLRef  ewg_function_CFBundleCopyResourceURL (CFBundleRef bundle, CFStringRef resourceName, CFStringRef resourceType, CFStringRef subDirName);
// Wraps call to function 'CFBundleCopyResourceURLsOfType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURLsOfType(ewg_param_bundle, ewg_param_resourceType, ewg_param_subDirName) CFBundleCopyResourceURLsOfType ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName)

CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfType (CFBundleRef bundle, CFStringRef resourceType, CFStringRef subDirName);
// Wraps call to function 'CFBundleCopyLocalizedString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyLocalizedString(ewg_param_bundle, ewg_param_key, ewg_param_value, ewg_param_tableName) CFBundleCopyLocalizedString ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_key, (CFStringRef)ewg_param_value, (CFStringRef)ewg_param_tableName)

CFStringRef  ewg_function_CFBundleCopyLocalizedString (CFBundleRef bundle, CFStringRef key, CFStringRef value, CFStringRef tableName);
// Wraps call to function 'CFBundleCopyResourceURLInDirectory' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURLInDirectory(ewg_param_bundleURL, ewg_param_resourceName, ewg_param_resourceType, ewg_param_subDirName) CFBundleCopyResourceURLInDirectory ((CFURLRef)ewg_param_bundleURL, (CFStringRef)ewg_param_resourceName, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName)

CFURLRef  ewg_function_CFBundleCopyResourceURLInDirectory (CFURLRef bundleURL, CFStringRef resourceName, CFStringRef resourceType, CFStringRef subDirName);
// Wraps call to function 'CFBundleCopyResourceURLsOfTypeInDirectory' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURLsOfTypeInDirectory(ewg_param_bundleURL, ewg_param_resourceType, ewg_param_subDirName) CFBundleCopyResourceURLsOfTypeInDirectory ((CFURLRef)ewg_param_bundleURL, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName)

CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfTypeInDirectory (CFURLRef bundleURL, CFStringRef resourceType, CFStringRef subDirName);
// Wraps call to function 'CFBundleCopyBundleLocalizations' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyBundleLocalizations(ewg_param_bundle) CFBundleCopyBundleLocalizations ((CFBundleRef)ewg_param_bundle)

CFArrayRef  ewg_function_CFBundleCopyBundleLocalizations (CFBundleRef bundle);
// Wraps call to function 'CFBundleCopyPreferredLocalizationsFromArray' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyPreferredLocalizationsFromArray(ewg_param_locArray) CFBundleCopyPreferredLocalizationsFromArray ((CFArrayRef)ewg_param_locArray)

CFArrayRef  ewg_function_CFBundleCopyPreferredLocalizationsFromArray (CFArrayRef locArray);
// Wraps call to function 'CFBundleCopyLocalizationsForPreferences' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyLocalizationsForPreferences(ewg_param_locArray, ewg_param_prefArray) CFBundleCopyLocalizationsForPreferences ((CFArrayRef)ewg_param_locArray, (CFArrayRef)ewg_param_prefArray)

CFArrayRef  ewg_function_CFBundleCopyLocalizationsForPreferences (CFArrayRef locArray, CFArrayRef prefArray);
// Wraps call to function 'CFBundleCopyResourceURLForLocalization' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURLForLocalization(ewg_param_bundle, ewg_param_resourceName, ewg_param_resourceType, ewg_param_subDirName, ewg_param_localizationName) CFBundleCopyResourceURLForLocalization ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_resourceName, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName, (CFStringRef)ewg_param_localizationName)

CFURLRef  ewg_function_CFBundleCopyResourceURLForLocalization (CFBundleRef bundle, CFStringRef resourceName, CFStringRef resourceType, CFStringRef subDirName, CFStringRef localizationName);
// Wraps call to function 'CFBundleCopyResourceURLsOfTypeForLocalization' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyResourceURLsOfTypeForLocalization(ewg_param_bundle, ewg_param_resourceType, ewg_param_subDirName, ewg_param_localizationName) CFBundleCopyResourceURLsOfTypeForLocalization ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_resourceType, (CFStringRef)ewg_param_subDirName, (CFStringRef)ewg_param_localizationName)

CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfTypeForLocalization (CFBundleRef bundle, CFStringRef resourceType, CFStringRef subDirName, CFStringRef localizationName);
// Wraps call to function 'CFBundleCopyInfoDictionaryForURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyInfoDictionaryForURL(ewg_param_url) CFBundleCopyInfoDictionaryForURL ((CFURLRef)ewg_param_url)

CFDictionaryRef  ewg_function_CFBundleCopyInfoDictionaryForURL (CFURLRef url);
// Wraps call to function 'CFBundleCopyLocalizationsForURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyLocalizationsForURL(ewg_param_url) CFBundleCopyLocalizationsForURL ((CFURLRef)ewg_param_url)

CFArrayRef  ewg_function_CFBundleCopyLocalizationsForURL (CFURLRef url);
// Wraps call to function 'CFBundleCopyExecutableURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyExecutableURL(ewg_param_bundle) CFBundleCopyExecutableURL ((CFBundleRef)ewg_param_bundle)

CFURLRef  ewg_function_CFBundleCopyExecutableURL (CFBundleRef bundle);
// Wraps call to function 'CFBundleIsExecutableLoaded' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleIsExecutableLoaded(ewg_param_bundle) CFBundleIsExecutableLoaded ((CFBundleRef)ewg_param_bundle)

Boolean  ewg_function_CFBundleIsExecutableLoaded (CFBundleRef bundle);
// Wraps call to function 'CFBundleLoadExecutable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleLoadExecutable(ewg_param_bundle) CFBundleLoadExecutable ((CFBundleRef)ewg_param_bundle)

Boolean  ewg_function_CFBundleLoadExecutable (CFBundleRef bundle);
// Wraps call to function 'CFBundleUnloadExecutable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleUnloadExecutable(ewg_param_bundle) CFBundleUnloadExecutable ((CFBundleRef)ewg_param_bundle)

void  ewg_function_CFBundleUnloadExecutable (CFBundleRef bundle);
// Wraps call to function 'CFBundleGetFunctionPointerForName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetFunctionPointerForName(ewg_param_bundle, ewg_param_functionName) CFBundleGetFunctionPointerForName ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_functionName)

void * ewg_function_CFBundleGetFunctionPointerForName (CFBundleRef bundle, CFStringRef functionName);
// Wraps call to function 'CFBundleGetFunctionPointersForNames' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetFunctionPointersForNames(ewg_param_bundle, ewg_param_functionNames, ewg_param_ftbl) CFBundleGetFunctionPointersForNames ((CFBundleRef)ewg_param_bundle, (CFArrayRef)ewg_param_functionNames, ewg_param_ftbl)

void  ewg_function_CFBundleGetFunctionPointersForNames (CFBundleRef bundle, CFArrayRef functionNames, void *ftbl);
// Wraps call to function 'CFBundleGetDataPointerForName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetDataPointerForName(ewg_param_bundle, ewg_param_symbolName) CFBundleGetDataPointerForName ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_symbolName)

void * ewg_function_CFBundleGetDataPointerForName (CFBundleRef bundle, CFStringRef symbolName);
// Wraps call to function 'CFBundleGetDataPointersForNames' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetDataPointersForNames(ewg_param_bundle, ewg_param_symbolNames, ewg_param_stbl) CFBundleGetDataPointersForNames ((CFBundleRef)ewg_param_bundle, (CFArrayRef)ewg_param_symbolNames, ewg_param_stbl)

void  ewg_function_CFBundleGetDataPointersForNames (CFBundleRef bundle, CFArrayRef symbolNames, void *stbl);
// Wraps call to function 'CFBundleCopyAuxiliaryExecutableURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCopyAuxiliaryExecutableURL(ewg_param_bundle, ewg_param_executableName) CFBundleCopyAuxiliaryExecutableURL ((CFBundleRef)ewg_param_bundle, (CFStringRef)ewg_param_executableName)

CFURLRef  ewg_function_CFBundleCopyAuxiliaryExecutableURL (CFBundleRef bundle, CFStringRef executableName);
// Wraps call to function 'CFBundleGetPlugIn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleGetPlugIn(ewg_param_bundle) CFBundleGetPlugIn ((CFBundleRef)ewg_param_bundle)

CFPlugInRef  ewg_function_CFBundleGetPlugIn (CFBundleRef bundle);
// Wraps call to function 'CFBundleOpenBundleResourceMap' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleOpenBundleResourceMap(ewg_param_bundle) CFBundleOpenBundleResourceMap ((CFBundleRef)ewg_param_bundle)

short  ewg_function_CFBundleOpenBundleResourceMap (CFBundleRef bundle);
// Wraps call to function 'CFBundleOpenBundleResourceFiles' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleOpenBundleResourceFiles(ewg_param_bundle, ewg_param_refNum, ewg_param_localizedRefNum) CFBundleOpenBundleResourceFiles ((CFBundleRef)ewg_param_bundle, (short*)ewg_param_refNum, (short*)ewg_param_localizedRefNum)

SInt32  ewg_function_CFBundleOpenBundleResourceFiles (CFBundleRef bundle, short *refNum, short *localizedRefNum);
// Wraps call to function 'CFBundleCloseBundleResourceMap' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CFBundleCloseBundleResourceMap(ewg_param_bundle, ewg_param_refNum) CFBundleCloseBundleResourceMap ((CFBundleRef)ewg_param_bundle, (short)ewg_param_refNum)

void  ewg_function_CFBundleCloseBundleResourceMap (CFBundleRef bundle, short refNum);
// Wraps call to function 'CGPointMake' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPointMake(ewg_param_x, ewg_param_y) CGPointMake ((float)ewg_param_x, (float)ewg_param_y)

CGPoint * ewg_function_CGPointMake (float x, float y);
// Wraps call to function 'CGSizeMake' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGSizeMake(ewg_param_width, ewg_param_height) CGSizeMake ((float)ewg_param_width, (float)ewg_param_height)

CGSize * ewg_function_CGSizeMake (float width, float height);
// Wraps call to function 'CGRectMake' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectMake(ewg_param_x, ewg_param_y, ewg_param_width, ewg_param_height) CGRectMake ((float)ewg_param_x, (float)ewg_param_y, (float)ewg_param_width, (float)ewg_param_height)

CGRect * ewg_function_CGRectMake (float x, float y, float width, float height);
// Wraps call to function 'CGRectGetMinX' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMinX(ewg_param_rect) CGRectGetMinX (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMinX (CGRect *rect);
// Wraps call to function 'CGRectGetMidX' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMidX(ewg_param_rect) CGRectGetMidX (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMidX (CGRect *rect);
// Wraps call to function 'CGRectGetMaxX' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMaxX(ewg_param_rect) CGRectGetMaxX (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMaxX (CGRect *rect);
// Wraps call to function 'CGRectGetMinY' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMinY(ewg_param_rect) CGRectGetMinY (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMinY (CGRect *rect);
// Wraps call to function 'CGRectGetMidY' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMidY(ewg_param_rect) CGRectGetMidY (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMidY (CGRect *rect);
// Wraps call to function 'CGRectGetMaxY' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetMaxY(ewg_param_rect) CGRectGetMaxY (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetMaxY (CGRect *rect);
// Wraps call to function 'CGRectGetWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetWidth(ewg_param_rect) CGRectGetWidth (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetWidth (CGRect *rect);
// Wraps call to function 'CGRectGetHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectGetHeight(ewg_param_rect) CGRectGetHeight (*(CGRect*)ewg_param_rect)

float  ewg_function_CGRectGetHeight (CGRect *rect);
// Wraps call to function 'CGPointEqualToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPointEqualToPoint(ewg_param_point1, ewg_param_point2) CGPointEqualToPoint (*(CGPoint*)ewg_param_point1, *(CGPoint*)ewg_param_point2)

int  ewg_function_CGPointEqualToPoint (CGPoint *point1, CGPoint *point2);
// Wraps call to function 'CGSizeEqualToSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGSizeEqualToSize(ewg_param_size1, ewg_param_size2) CGSizeEqualToSize (*(CGSize*)ewg_param_size1, *(CGSize*)ewg_param_size2)

int  ewg_function_CGSizeEqualToSize (CGSize *size1, CGSize *size2);
// Wraps call to function 'CGRectEqualToRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectEqualToRect(ewg_param_rect1, ewg_param_rect2) CGRectEqualToRect (*(CGRect*)ewg_param_rect1, *(CGRect*)ewg_param_rect2)

int  ewg_function_CGRectEqualToRect (CGRect *rect1, CGRect *rect2);
// Wraps call to function 'CGRectStandardize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectStandardize(ewg_param_rect) CGRectStandardize (*(CGRect*)ewg_param_rect)

CGRect * ewg_function_CGRectStandardize (CGRect *rect);
// Wraps call to function 'CGRectIsEmpty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIsEmpty(ewg_param_rect) CGRectIsEmpty (*(CGRect*)ewg_param_rect)

int  ewg_function_CGRectIsEmpty (CGRect *rect);
// Wraps call to function 'CGRectIsNull' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIsNull(ewg_param_rect) CGRectIsNull (*(CGRect*)ewg_param_rect)

int  ewg_function_CGRectIsNull (CGRect *rect);
// Wraps call to function 'CGRectIsInfinite' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIsInfinite(ewg_param_rect) CGRectIsInfinite (*(CGRect*)ewg_param_rect)

_Bool  ewg_function_CGRectIsInfinite (CGRect *rect);
// Wraps call to function 'CGRectInset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectInset(ewg_param_rect, ewg_param_dx, ewg_param_dy) CGRectInset (*(CGRect*)ewg_param_rect, (float)ewg_param_dx, (float)ewg_param_dy)

CGRect * ewg_function_CGRectInset (CGRect *rect, float dx, float dy);
// Wraps call to function 'CGRectIntegral' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIntegral(ewg_param_rect) CGRectIntegral (*(CGRect*)ewg_param_rect)

CGRect * ewg_function_CGRectIntegral (CGRect *rect);
// Wraps call to function 'CGRectUnion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectUnion(ewg_param_r1, ewg_param_r2) CGRectUnion (*(CGRect*)ewg_param_r1, *(CGRect*)ewg_param_r2)

CGRect * ewg_function_CGRectUnion (CGRect *r1, CGRect *r2);
// Wraps call to function 'CGRectIntersection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIntersection(ewg_param_r1, ewg_param_r2) CGRectIntersection (*(CGRect*)ewg_param_r1, *(CGRect*)ewg_param_r2)

CGRect * ewg_function_CGRectIntersection (CGRect *r1, CGRect *r2);
// Wraps call to function 'CGRectOffset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectOffset(ewg_param_rect, ewg_param_dx, ewg_param_dy) CGRectOffset (*(CGRect*)ewg_param_rect, (float)ewg_param_dx, (float)ewg_param_dy)

CGRect * ewg_function_CGRectOffset (CGRect *rect, float dx, float dy);
// Wraps call to function 'CGRectDivide' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectDivide(ewg_param_rect, ewg_param_slice, ewg_param_remainder, ewg_param_amount, ewg_param_edge) CGRectDivide (*(CGRect*)ewg_param_rect, (CGRect*)ewg_param_slice, (CGRect*)ewg_param_remainder, (float)ewg_param_amount, (CGRectEdge)ewg_param_edge)

void  ewg_function_CGRectDivide (CGRect *rect, CGRect *slice, CGRect *remainder, float amount, CGRectEdge edge);
// Wraps call to function 'CGRectContainsPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectContainsPoint(ewg_param_rect, ewg_param_point) CGRectContainsPoint (*(CGRect*)ewg_param_rect, *(CGPoint*)ewg_param_point)

int  ewg_function_CGRectContainsPoint (CGRect *rect, CGPoint *point);
// Wraps call to function 'CGRectContainsRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectContainsRect(ewg_param_rect1, ewg_param_rect2) CGRectContainsRect (*(CGRect*)ewg_param_rect1, *(CGRect*)ewg_param_rect2)

int  ewg_function_CGRectContainsRect (CGRect *rect1, CGRect *rect2);
// Wraps call to function 'CGRectIntersectsRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectIntersectsRect(ewg_param_rect1, ewg_param_rect2) CGRectIntersectsRect (*(CGRect*)ewg_param_rect1, *(CGRect*)ewg_param_rect2)

int  ewg_function_CGRectIntersectsRect (CGRect *rect1, CGRect *rect2);
// Wraps call to function 'CGAffineTransformMake' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformMake(ewg_param_a, ewg_param_b, ewg_param_c, ewg_param_d, ewg_param_tx, ewg_param_ty) CGAffineTransformMake ((float)ewg_param_a, (float)ewg_param_b, (float)ewg_param_c, (float)ewg_param_d, (float)ewg_param_tx, (float)ewg_param_ty)

CGAffineTransform * ewg_function_CGAffineTransformMake (float a, float b, float c, float d, float tx, float ty);
// Wraps call to function 'CGAffineTransformMakeTranslation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformMakeTranslation(ewg_param_tx, ewg_param_ty) CGAffineTransformMakeTranslation ((float)ewg_param_tx, (float)ewg_param_ty)

CGAffineTransform * ewg_function_CGAffineTransformMakeTranslation (float tx, float ty);
// Wraps call to function 'CGAffineTransformMakeScale' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformMakeScale(ewg_param_sx, ewg_param_sy) CGAffineTransformMakeScale ((float)ewg_param_sx, (float)ewg_param_sy)

CGAffineTransform * ewg_function_CGAffineTransformMakeScale (float sx, float sy);
// Wraps call to function 'CGAffineTransformMakeRotation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformMakeRotation(ewg_param_angle) CGAffineTransformMakeRotation ((float)ewg_param_angle)

CGAffineTransform * ewg_function_CGAffineTransformMakeRotation (float angle);
// Wraps call to function 'CGAffineTransformIsIdentity' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformIsIdentity(ewg_param_t) CGAffineTransformIsIdentity (*(CGAffineTransform*)ewg_param_t)

_Bool  ewg_function_CGAffineTransformIsIdentity (CGAffineTransform *t);
// Wraps call to function 'CGAffineTransformTranslate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformTranslate(ewg_param_t, ewg_param_tx, ewg_param_ty) CGAffineTransformTranslate (*(CGAffineTransform*)ewg_param_t, (float)ewg_param_tx, (float)ewg_param_ty)

CGAffineTransform * ewg_function_CGAffineTransformTranslate (CGAffineTransform *t, float tx, float ty);
// Wraps call to function 'CGAffineTransformScale' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformScale(ewg_param_t, ewg_param_sx, ewg_param_sy) CGAffineTransformScale (*(CGAffineTransform*)ewg_param_t, (float)ewg_param_sx, (float)ewg_param_sy)

CGAffineTransform * ewg_function_CGAffineTransformScale (CGAffineTransform *t, float sx, float sy);
// Wraps call to function 'CGAffineTransformRotate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformRotate(ewg_param_t, ewg_param_angle) CGAffineTransformRotate (*(CGAffineTransform*)ewg_param_t, (float)ewg_param_angle)

CGAffineTransform * ewg_function_CGAffineTransformRotate (CGAffineTransform *t, float angle);
// Wraps call to function 'CGAffineTransformInvert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformInvert(ewg_param_t) CGAffineTransformInvert (*(CGAffineTransform*)ewg_param_t)

CGAffineTransform * ewg_function_CGAffineTransformInvert (CGAffineTransform *t);
// Wraps call to function 'CGAffineTransformConcat' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformConcat(ewg_param_t1, ewg_param_t2) CGAffineTransformConcat (*(CGAffineTransform*)ewg_param_t1, *(CGAffineTransform*)ewg_param_t2)

CGAffineTransform * ewg_function_CGAffineTransformConcat (CGAffineTransform *t1, CGAffineTransform *t2);
// Wraps call to function 'CGAffineTransformEqualToTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGAffineTransformEqualToTransform(ewg_param_t1, ewg_param_t2) CGAffineTransformEqualToTransform (*(CGAffineTransform*)ewg_param_t1, *(CGAffineTransform*)ewg_param_t2)

_Bool  ewg_function_CGAffineTransformEqualToTransform (CGAffineTransform *t1, CGAffineTransform *t2);
// Wraps call to function 'CGPointApplyAffineTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPointApplyAffineTransform(ewg_param_point, ewg_param_t) CGPointApplyAffineTransform (*(CGPoint*)ewg_param_point, *(CGAffineTransform*)ewg_param_t)

CGPoint * ewg_function_CGPointApplyAffineTransform (CGPoint *point, CGAffineTransform *t);
// Wraps call to function 'CGSizeApplyAffineTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGSizeApplyAffineTransform(ewg_param_size, ewg_param_t) CGSizeApplyAffineTransform (*(CGSize*)ewg_param_size, *(CGAffineTransform*)ewg_param_t)

CGSize * ewg_function_CGSizeApplyAffineTransform (CGSize *size, CGAffineTransform *t);
// Wraps call to function 'CGRectApplyAffineTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGRectApplyAffineTransform(ewg_param_rect, ewg_param_t) CGRectApplyAffineTransform (*(CGRect*)ewg_param_rect, *(CGAffineTransform*)ewg_param_t)

CGRect * ewg_function_CGRectApplyAffineTransform (CGRect *rect, CGAffineTransform *t);
// Wraps call to function 'CGDataProviderGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderGetTypeID CGDataProviderGetTypeID ()

CFTypeID  ewg_function_CGDataProviderGetTypeID (void);
// Wraps call to function 'CGDataProviderCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreate(ewg_param_info, ewg_param_callbacks) CGDataProviderCreate ((void*)ewg_param_info, (CGDataProviderCallbacks const*)ewg_param_callbacks)

CGDataProviderRef  ewg_function_CGDataProviderCreate (void *info, CGDataProviderCallbacks const *callbacks);
// Wraps call to function 'CGDataProviderCreateDirectAccess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreateDirectAccess(ewg_param_info, ewg_param_size, ewg_param_callbacks) CGDataProviderCreateDirectAccess ((void*)ewg_param_info, (size_t)ewg_param_size, (CGDataProviderDirectAccessCallbacks const*)ewg_param_callbacks)

CGDataProviderRef  ewg_function_CGDataProviderCreateDirectAccess (void *info, size_t size, CGDataProviderDirectAccessCallbacks const *callbacks);
// Wraps call to function 'CGDataProviderCreateWithData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreateWithData(ewg_param_info, ewg_param_data, ewg_param_size, ewg_param_releaseData) CGDataProviderCreateWithData ((void*)ewg_param_info, (void const*)ewg_param_data, (size_t)ewg_param_size, (CGDataProviderReleaseDataCallback)ewg_param_releaseData)

CGDataProviderRef  ewg_function_CGDataProviderCreateWithData (void *info, void const *data, size_t size, CGDataProviderReleaseDataCallback releaseData);
// Wraps call to function 'CGDataProviderCreateWithCFData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreateWithCFData(ewg_param_data) CGDataProviderCreateWithCFData ((CFDataRef)ewg_param_data)

CGDataProviderRef  ewg_function_CGDataProviderCreateWithCFData (CFDataRef data);
// Wraps call to function 'CGDataProviderCreateWithURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreateWithURL(ewg_param_url) CGDataProviderCreateWithURL ((CFURLRef)ewg_param_url)

CGDataProviderRef  ewg_function_CGDataProviderCreateWithURL (CFURLRef url);
// Wraps call to function 'CGDataProviderRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderRetain(ewg_param_provider) CGDataProviderRetain ((CGDataProviderRef)ewg_param_provider)

CGDataProviderRef  ewg_function_CGDataProviderRetain (CGDataProviderRef provider);
// Wraps call to function 'CGDataProviderRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderRelease(ewg_param_provider) CGDataProviderRelease ((CGDataProviderRef)ewg_param_provider)

void  ewg_function_CGDataProviderRelease (CGDataProviderRef provider);
// Wraps call to function 'CGDataProviderCreateWithFilename' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGDataProviderCreateWithFilename(ewg_param_filename) CGDataProviderCreateWithFilename ((char const*)ewg_param_filename)

CGDataProviderRef  ewg_function_CGDataProviderCreateWithFilename (char const *filename);
// Wraps call to function 'CGImageGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetTypeID CGImageGetTypeID ()

CFTypeID  ewg_function_CGImageGetTypeID (void);
// Wraps call to function 'CGImageCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreate(ewg_param_width, ewg_param_height, ewg_param_bitsPerComponent, ewg_param_bitsPerPixel, ewg_param_bytesPerRow, ewg_param_colorspace, ewg_param_bitmapInfo, ewg_param_provider, ewg_param_decode, ewg_param_shouldInterpolate, ewg_param_intent) CGImageCreate ((size_t)ewg_param_width, (size_t)ewg_param_height, (size_t)ewg_param_bitsPerComponent, (size_t)ewg_param_bitsPerPixel, (size_t)ewg_param_bytesPerRow, (CGColorSpaceRef)ewg_param_colorspace, (CGBitmapInfo)ewg_param_bitmapInfo, (CGDataProviderRef)ewg_param_provider, ewg_param_decode, (_Bool)ewg_param_shouldInterpolate, (CGColorRenderingIntent)ewg_param_intent)

CGImageRef  ewg_function_CGImageCreate (size_t width, size_t height, size_t bitsPerComponent, size_t bitsPerPixel, size_t bytesPerRow, CGColorSpaceRef colorspace, CGBitmapInfo bitmapInfo, CGDataProviderRef provider, void *decode, _Bool shouldInterpolate, CGColorRenderingIntent intent);
// Wraps call to function 'CGImageMaskCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageMaskCreate(ewg_param_width, ewg_param_height, ewg_param_bitsPerComponent, ewg_param_bitsPerPixel, ewg_param_bytesPerRow, ewg_param_provider, ewg_param_decode, ewg_param_shouldInterpolate) CGImageMaskCreate ((size_t)ewg_param_width, (size_t)ewg_param_height, (size_t)ewg_param_bitsPerComponent, (size_t)ewg_param_bitsPerPixel, (size_t)ewg_param_bytesPerRow, (CGDataProviderRef)ewg_param_provider, ewg_param_decode, (_Bool)ewg_param_shouldInterpolate)

CGImageRef  ewg_function_CGImageMaskCreate (size_t width, size_t height, size_t bitsPerComponent, size_t bitsPerPixel, size_t bytesPerRow, CGDataProviderRef provider, void *decode, _Bool shouldInterpolate);
// Wraps call to function 'CGImageCreateCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateCopy(ewg_param_image) CGImageCreateCopy ((CGImageRef)ewg_param_image)

CGImageRef  ewg_function_CGImageCreateCopy (CGImageRef image);
// Wraps call to function 'CGImageCreateWithJPEGDataProvider' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateWithJPEGDataProvider(ewg_param_source, ewg_param_decode, ewg_param_shouldInterpolate, ewg_param_intent) CGImageCreateWithJPEGDataProvider ((CGDataProviderRef)ewg_param_source, ewg_param_decode, (_Bool)ewg_param_shouldInterpolate, (CGColorRenderingIntent)ewg_param_intent)

CGImageRef  ewg_function_CGImageCreateWithJPEGDataProvider (CGDataProviderRef source, void *decode, _Bool shouldInterpolate, CGColorRenderingIntent intent);
// Wraps call to function 'CGImageCreateWithPNGDataProvider' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateWithPNGDataProvider(ewg_param_source, ewg_param_decode, ewg_param_shouldInterpolate, ewg_param_intent) CGImageCreateWithPNGDataProvider ((CGDataProviderRef)ewg_param_source, ewg_param_decode, (_Bool)ewg_param_shouldInterpolate, (CGColorRenderingIntent)ewg_param_intent)

CGImageRef  ewg_function_CGImageCreateWithPNGDataProvider (CGDataProviderRef source, void *decode, _Bool shouldInterpolate, CGColorRenderingIntent intent);
// Wraps call to function 'CGImageCreateWithImageInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateWithImageInRect(ewg_param_image, ewg_param_rect) CGImageCreateWithImageInRect ((CGImageRef)ewg_param_image, *(CGRect*)ewg_param_rect)

CGImageRef  ewg_function_CGImageCreateWithImageInRect (CGImageRef image, CGRect *rect);
// Wraps call to function 'CGImageCreateWithMask' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateWithMask(ewg_param_image, ewg_param_mask) CGImageCreateWithMask ((CGImageRef)ewg_param_image, (CGImageRef)ewg_param_mask)

CGImageRef  ewg_function_CGImageCreateWithMask (CGImageRef image, CGImageRef mask);
// Wraps call to function 'CGImageCreateWithMaskingColors' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateWithMaskingColors(ewg_param_image, ewg_param_components) CGImageCreateWithMaskingColors ((CGImageRef)ewg_param_image, ewg_param_components)

CGImageRef  ewg_function_CGImageCreateWithMaskingColors (CGImageRef image, void *components);
// Wraps call to function 'CGImageCreateCopyWithColorSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageCreateCopyWithColorSpace(ewg_param_image, ewg_param_colorspace) CGImageCreateCopyWithColorSpace ((CGImageRef)ewg_param_image, (CGColorSpaceRef)ewg_param_colorspace)

CGImageRef  ewg_function_CGImageCreateCopyWithColorSpace (CGImageRef image, CGColorSpaceRef colorspace);
// Wraps call to function 'CGImageRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageRetain(ewg_param_image) CGImageRetain ((CGImageRef)ewg_param_image)

CGImageRef  ewg_function_CGImageRetain (CGImageRef image);
// Wraps call to function 'CGImageRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageRelease(ewg_param_image) CGImageRelease ((CGImageRef)ewg_param_image)

void  ewg_function_CGImageRelease (CGImageRef image);
// Wraps call to function 'CGImageIsMask' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageIsMask(ewg_param_image) CGImageIsMask ((CGImageRef)ewg_param_image)

_Bool  ewg_function_CGImageIsMask (CGImageRef image);
// Wraps call to function 'CGImageGetWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetWidth(ewg_param_image) CGImageGetWidth ((CGImageRef)ewg_param_image)

size_t  ewg_function_CGImageGetWidth (CGImageRef image);
// Wraps call to function 'CGImageGetHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetHeight(ewg_param_image) CGImageGetHeight ((CGImageRef)ewg_param_image)

size_t  ewg_function_CGImageGetHeight (CGImageRef image);
// Wraps call to function 'CGImageGetBitsPerComponent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetBitsPerComponent(ewg_param_image) CGImageGetBitsPerComponent ((CGImageRef)ewg_param_image)

size_t  ewg_function_CGImageGetBitsPerComponent (CGImageRef image);
// Wraps call to function 'CGImageGetBitsPerPixel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetBitsPerPixel(ewg_param_image) CGImageGetBitsPerPixel ((CGImageRef)ewg_param_image)

size_t  ewg_function_CGImageGetBitsPerPixel (CGImageRef image);
// Wraps call to function 'CGImageGetBytesPerRow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetBytesPerRow(ewg_param_image) CGImageGetBytesPerRow ((CGImageRef)ewg_param_image)

size_t  ewg_function_CGImageGetBytesPerRow (CGImageRef image);
// Wraps call to function 'CGImageGetColorSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetColorSpace(ewg_param_image) CGImageGetColorSpace ((CGImageRef)ewg_param_image)

CGColorSpaceRef  ewg_function_CGImageGetColorSpace (CGImageRef image);
// Wraps call to function 'CGImageGetAlphaInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetAlphaInfo(ewg_param_image) CGImageGetAlphaInfo ((CGImageRef)ewg_param_image)

CGImageAlphaInfo  ewg_function_CGImageGetAlphaInfo (CGImageRef image);
// Wraps call to function 'CGImageGetDataProvider' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetDataProvider(ewg_param_image) CGImageGetDataProvider ((CGImageRef)ewg_param_image)

CGDataProviderRef  ewg_function_CGImageGetDataProvider (CGImageRef image);
// Wraps call to function 'CGImageGetDecode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetDecode(ewg_param_image) CGImageGetDecode ((CGImageRef)ewg_param_image)

float const * ewg_function_CGImageGetDecode (CGImageRef image);
// Wraps call to function 'CGImageGetShouldInterpolate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetShouldInterpolate(ewg_param_image) CGImageGetShouldInterpolate ((CGImageRef)ewg_param_image)

_Bool  ewg_function_CGImageGetShouldInterpolate (CGImageRef image);
// Wraps call to function 'CGImageGetRenderingIntent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetRenderingIntent(ewg_param_image) CGImageGetRenderingIntent ((CGImageRef)ewg_param_image)

CGColorRenderingIntent  ewg_function_CGImageGetRenderingIntent (CGImageRef image);
// Wraps call to function 'CGImageGetBitmapInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGImageGetBitmapInfo(ewg_param_image) CGImageGetBitmapInfo ((CGImageRef)ewg_param_image)

CGBitmapInfo  ewg_function_CGImageGetBitmapInfo (CGImageRef image);
// Wraps call to function 'CGPathGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathGetTypeID CGPathGetTypeID ()

CFTypeID  ewg_function_CGPathGetTypeID (void);
// Wraps call to function 'CGPathCreateMutable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathCreateMutable CGPathCreateMutable ()

CGMutablePathRef  ewg_function_CGPathCreateMutable (void);
// Wraps call to function 'CGPathCreateCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathCreateCopy(ewg_param_path) CGPathCreateCopy ((CGPathRef)ewg_param_path)

CGPathRef  ewg_function_CGPathCreateCopy (CGPathRef path);
// Wraps call to function 'CGPathCreateMutableCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathCreateMutableCopy(ewg_param_path) CGPathCreateMutableCopy ((CGPathRef)ewg_param_path)

CGMutablePathRef  ewg_function_CGPathCreateMutableCopy (CGPathRef path);
// Wraps call to function 'CGPathRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathRetain(ewg_param_path) CGPathRetain ((CGPathRef)ewg_param_path)

CGPathRef  ewg_function_CGPathRetain (CGPathRef path);
// Wraps call to function 'CGPathRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathRelease(ewg_param_path) CGPathRelease ((CGPathRef)ewg_param_path)

void  ewg_function_CGPathRelease (CGPathRef path);
// Wraps call to function 'CGPathEqualToPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathEqualToPath(ewg_param_path1, ewg_param_path2) CGPathEqualToPath ((CGPathRef)ewg_param_path1, (CGPathRef)ewg_param_path2)

_Bool  ewg_function_CGPathEqualToPath (CGPathRef path1, CGPathRef path2);
// Wraps call to function 'CGPathMoveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathMoveToPoint(ewg_param_path, ewg_param_m, ewg_param_x, ewg_param_y) CGPathMoveToPoint ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGPathMoveToPoint (CGMutablePathRef path, CGAffineTransform const *m, float x, float y);
// Wraps call to function 'CGPathAddLineToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddLineToPoint(ewg_param_path, ewg_param_m, ewg_param_x, ewg_param_y) CGPathAddLineToPoint ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGPathAddLineToPoint (CGMutablePathRef path, CGAffineTransform const *m, float x, float y);
// Wraps call to function 'CGPathAddQuadCurveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddQuadCurveToPoint(ewg_param_path, ewg_param_m, ewg_param_cpx, ewg_param_cpy, ewg_param_x, ewg_param_y) CGPathAddQuadCurveToPoint ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_cpx, (float)ewg_param_cpy, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGPathAddQuadCurveToPoint (CGMutablePathRef path, CGAffineTransform const *m, float cpx, float cpy, float x, float y);
// Wraps call to function 'CGPathAddCurveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddCurveToPoint(ewg_param_path, ewg_param_m, ewg_param_cp1x, ewg_param_cp1y, ewg_param_cp2x, ewg_param_cp2y, ewg_param_x, ewg_param_y) CGPathAddCurveToPoint ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_cp1x, (float)ewg_param_cp1y, (float)ewg_param_cp2x, (float)ewg_param_cp2y, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGPathAddCurveToPoint (CGMutablePathRef path, CGAffineTransform const *m, float cp1x, float cp1y, float cp2x, float cp2y, float x, float y);
// Wraps call to function 'CGPathCloseSubpath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathCloseSubpath(ewg_param_path) CGPathCloseSubpath ((CGMutablePathRef)ewg_param_path)

void  ewg_function_CGPathCloseSubpath (CGMutablePathRef path);
// Wraps call to function 'CGPathAddRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddRect(ewg_param_path, ewg_param_m, ewg_param_rect) CGPathAddRect ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, *(CGRect*)ewg_param_rect)

void  ewg_function_CGPathAddRect (CGMutablePathRef path, CGAffineTransform const *m, CGRect *rect);
// Wraps call to function 'CGPathAddRects' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddRects(ewg_param_path, ewg_param_m, ewg_param_rects, ewg_param_count) CGPathAddRects ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, ewg_param_rects, (size_t)ewg_param_count)

void  ewg_function_CGPathAddRects (CGMutablePathRef path, CGAffineTransform const *m, void *rects, size_t count);
// Wraps call to function 'CGPathAddLines' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddLines(ewg_param_path, ewg_param_m, ewg_param_points, ewg_param_count) CGPathAddLines ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, ewg_param_points, (size_t)ewg_param_count)

void  ewg_function_CGPathAddLines (CGMutablePathRef path, CGAffineTransform const *m, void *points, size_t count);
// Wraps call to function 'CGPathAddEllipseInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddEllipseInRect(ewg_param_path, ewg_param_m, ewg_param_rect) CGPathAddEllipseInRect ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, *(CGRect*)ewg_param_rect)

void  ewg_function_CGPathAddEllipseInRect (CGMutablePathRef path, CGAffineTransform const *m, CGRect *rect);
// Wraps call to function 'CGPathAddArc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddArc(ewg_param_path, ewg_param_m, ewg_param_x, ewg_param_y, ewg_param_radius, ewg_param_startAngle, ewg_param_endAngle, ewg_param_clockwise) CGPathAddArc ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_x, (float)ewg_param_y, (float)ewg_param_radius, (float)ewg_param_startAngle, (float)ewg_param_endAngle, (_Bool)ewg_param_clockwise)

void  ewg_function_CGPathAddArc (CGMutablePathRef path, CGAffineTransform const *m, float x, float y, float radius, float startAngle, float endAngle, _Bool clockwise);
// Wraps call to function 'CGPathAddArcToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddArcToPoint(ewg_param_path, ewg_param_m, ewg_param_x1, ewg_param_y1, ewg_param_x2, ewg_param_y2, ewg_param_radius) CGPathAddArcToPoint ((CGMutablePathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, (float)ewg_param_x1, (float)ewg_param_y1, (float)ewg_param_x2, (float)ewg_param_y2, (float)ewg_param_radius)

void  ewg_function_CGPathAddArcToPoint (CGMutablePathRef path, CGAffineTransform const *m, float x1, float y1, float x2, float y2, float radius);
// Wraps call to function 'CGPathAddPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathAddPath(ewg_param_path1, ewg_param_m, ewg_param_path2) CGPathAddPath ((CGMutablePathRef)ewg_param_path1, (CGAffineTransform const*)ewg_param_m, (CGPathRef)ewg_param_path2)

void  ewg_function_CGPathAddPath (CGMutablePathRef path1, CGAffineTransform const *m, CGPathRef path2);
// Wraps call to function 'CGPathIsEmpty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathIsEmpty(ewg_param_path) CGPathIsEmpty ((CGPathRef)ewg_param_path)

_Bool  ewg_function_CGPathIsEmpty (CGPathRef path);
// Wraps call to function 'CGPathIsRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathIsRect(ewg_param_path, ewg_param_rect) CGPathIsRect ((CGPathRef)ewg_param_path, (CGRect*)ewg_param_rect)

_Bool  ewg_function_CGPathIsRect (CGPathRef path, CGRect *rect);
// Wraps call to function 'CGPathGetCurrentPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathGetCurrentPoint(ewg_param_path) CGPathGetCurrentPoint ((CGPathRef)ewg_param_path)

CGPoint * ewg_function_CGPathGetCurrentPoint (CGPathRef path);
// Wraps call to function 'CGPathGetBoundingBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathGetBoundingBox(ewg_param_path) CGPathGetBoundingBox ((CGPathRef)ewg_param_path)

CGRect * ewg_function_CGPathGetBoundingBox (CGPathRef path);
// Wraps call to function 'CGPathContainsPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathContainsPoint(ewg_param_path, ewg_param_m, ewg_param_point, ewg_param_eoFill) CGPathContainsPoint ((CGPathRef)ewg_param_path, (CGAffineTransform const*)ewg_param_m, *(CGPoint*)ewg_param_point, (_Bool)ewg_param_eoFill)

_Bool  ewg_function_CGPathContainsPoint (CGPathRef path, CGAffineTransform const *m, CGPoint *point, _Bool eoFill);
// Wraps call to function 'CGPathApply' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGPathApply(ewg_param_path, ewg_param_info, ewg_param_function) CGPathApply ((CGPathRef)ewg_param_path, (void*)ewg_param_info, (CGPathApplierFunction)ewg_param_function)

void  ewg_function_CGPathApply (CGPathRef path, void *info, CGPathApplierFunction function);
// Wraps call to function 'CGContextGetTypeID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetTypeID CGContextGetTypeID ()

CFTypeID  ewg_function_CGContextGetTypeID (void);
// Wraps call to function 'CGContextSaveGState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSaveGState(ewg_param_c) CGContextSaveGState ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextSaveGState (CGContextRef c);
// Wraps call to function 'CGContextRestoreGState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextRestoreGState(ewg_param_c) CGContextRestoreGState ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextRestoreGState (CGContextRef c);
// Wraps call to function 'CGContextScaleCTM' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextScaleCTM(ewg_param_c, ewg_param_sx, ewg_param_sy) CGContextScaleCTM ((CGContextRef)ewg_param_c, (float)ewg_param_sx, (float)ewg_param_sy)

void  ewg_function_CGContextScaleCTM (CGContextRef c, float sx, float sy);
// Wraps call to function 'CGContextTranslateCTM' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextTranslateCTM(ewg_param_c, ewg_param_tx, ewg_param_ty) CGContextTranslateCTM ((CGContextRef)ewg_param_c, (float)ewg_param_tx, (float)ewg_param_ty)

void  ewg_function_CGContextTranslateCTM (CGContextRef c, float tx, float ty);
// Wraps call to function 'CGContextRotateCTM' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextRotateCTM(ewg_param_c, ewg_param_angle) CGContextRotateCTM ((CGContextRef)ewg_param_c, (float)ewg_param_angle)

void  ewg_function_CGContextRotateCTM (CGContextRef c, float angle);
// Wraps call to function 'CGContextConcatCTM' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConcatCTM(ewg_param_c, ewg_param_transform) CGContextConcatCTM ((CGContextRef)ewg_param_c, *(CGAffineTransform*)ewg_param_transform)

void  ewg_function_CGContextConcatCTM (CGContextRef c, CGAffineTransform *transform);
// Wraps call to function 'CGContextGetCTM' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetCTM(ewg_param_c) CGContextGetCTM ((CGContextRef)ewg_param_c)

CGAffineTransform * ewg_function_CGContextGetCTM (CGContextRef c);
// Wraps call to function 'CGContextSetLineWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetLineWidth(ewg_param_c, ewg_param_width) CGContextSetLineWidth ((CGContextRef)ewg_param_c, (float)ewg_param_width)

void  ewg_function_CGContextSetLineWidth (CGContextRef c, float width);
// Wraps call to function 'CGContextSetLineCap' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetLineCap(ewg_param_c, ewg_param_cap) CGContextSetLineCap ((CGContextRef)ewg_param_c, (CGLineCap)ewg_param_cap)

void  ewg_function_CGContextSetLineCap (CGContextRef c, CGLineCap cap);
// Wraps call to function 'CGContextSetLineJoin' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetLineJoin(ewg_param_c, ewg_param_join) CGContextSetLineJoin ((CGContextRef)ewg_param_c, (CGLineJoin)ewg_param_join)

void  ewg_function_CGContextSetLineJoin (CGContextRef c, CGLineJoin join);
// Wraps call to function 'CGContextSetMiterLimit' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetMiterLimit(ewg_param_c, ewg_param_limit) CGContextSetMiterLimit ((CGContextRef)ewg_param_c, (float)ewg_param_limit)

void  ewg_function_CGContextSetMiterLimit (CGContextRef c, float limit);
// Wraps call to function 'CGContextSetLineDash' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetLineDash(ewg_param_c, ewg_param_phase, ewg_param_lengths, ewg_param_count) CGContextSetLineDash ((CGContextRef)ewg_param_c, (float)ewg_param_phase, ewg_param_lengths, (size_t)ewg_param_count)

void  ewg_function_CGContextSetLineDash (CGContextRef c, float phase, void *lengths, size_t count);
// Wraps call to function 'CGContextSetFlatness' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFlatness(ewg_param_c, ewg_param_flatness) CGContextSetFlatness ((CGContextRef)ewg_param_c, (float)ewg_param_flatness)

void  ewg_function_CGContextSetFlatness (CGContextRef c, float flatness);
// Wraps call to function 'CGContextSetAlpha' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetAlpha(ewg_param_c, ewg_param_alpha) CGContextSetAlpha ((CGContextRef)ewg_param_c, (float)ewg_param_alpha)

void  ewg_function_CGContextSetAlpha (CGContextRef c, float alpha);
// Wraps call to function 'CGContextSetBlendMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetBlendMode(ewg_param_context, ewg_param_mode) CGContextSetBlendMode ((CGContextRef)ewg_param_context, (CGBlendMode)ewg_param_mode)

void  ewg_function_CGContextSetBlendMode (CGContextRef context, CGBlendMode mode);
// Wraps call to function 'CGContextBeginPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextBeginPath(ewg_param_c) CGContextBeginPath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextBeginPath (CGContextRef c);
// Wraps call to function 'CGContextMoveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextMoveToPoint(ewg_param_c, ewg_param_x, ewg_param_y) CGContextMoveToPoint ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGContextMoveToPoint (CGContextRef c, float x, float y);
// Wraps call to function 'CGContextAddLineToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddLineToPoint(ewg_param_c, ewg_param_x, ewg_param_y) CGContextAddLineToPoint ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGContextAddLineToPoint (CGContextRef c, float x, float y);
// Wraps call to function 'CGContextAddCurveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddCurveToPoint(ewg_param_c, ewg_param_cp1x, ewg_param_cp1y, ewg_param_cp2x, ewg_param_cp2y, ewg_param_x, ewg_param_y) CGContextAddCurveToPoint ((CGContextRef)ewg_param_c, (float)ewg_param_cp1x, (float)ewg_param_cp1y, (float)ewg_param_cp2x, (float)ewg_param_cp2y, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGContextAddCurveToPoint (CGContextRef c, float cp1x, float cp1y, float cp2x, float cp2y, float x, float y);
// Wraps call to function 'CGContextAddQuadCurveToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddQuadCurveToPoint(ewg_param_c, ewg_param_cpx, ewg_param_cpy, ewg_param_x, ewg_param_y) CGContextAddQuadCurveToPoint ((CGContextRef)ewg_param_c, (float)ewg_param_cpx, (float)ewg_param_cpy, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGContextAddQuadCurveToPoint (CGContextRef c, float cpx, float cpy, float x, float y);
// Wraps call to function 'CGContextClosePath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClosePath(ewg_param_c) CGContextClosePath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextClosePath (CGContextRef c);
// Wraps call to function 'CGContextAddRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddRect(ewg_param_c, ewg_param_rect) CGContextAddRect ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextAddRect (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextAddRects' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddRects(ewg_param_c, ewg_param_rects, ewg_param_count) CGContextAddRects ((CGContextRef)ewg_param_c, ewg_param_rects, (size_t)ewg_param_count)

void  ewg_function_CGContextAddRects (CGContextRef c, void *rects, size_t count);
// Wraps call to function 'CGContextAddLines' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddLines(ewg_param_c, ewg_param_points, ewg_param_count) CGContextAddLines ((CGContextRef)ewg_param_c, ewg_param_points, (size_t)ewg_param_count)

void  ewg_function_CGContextAddLines (CGContextRef c, void *points, size_t count);
// Wraps call to function 'CGContextAddEllipseInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddEllipseInRect(ewg_param_context, ewg_param_rect) CGContextAddEllipseInRect ((CGContextRef)ewg_param_context, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextAddEllipseInRect (CGContextRef context, CGRect *rect);
// Wraps call to function 'CGContextAddArc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddArc(ewg_param_c, ewg_param_x, ewg_param_y, ewg_param_radius, ewg_param_startAngle, ewg_param_endAngle, ewg_param_clockwise) CGContextAddArc ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y, (float)ewg_param_radius, (float)ewg_param_startAngle, (float)ewg_param_endAngle, (int)ewg_param_clockwise)

void  ewg_function_CGContextAddArc (CGContextRef c, float x, float y, float radius, float startAngle, float endAngle, int clockwise);
// Wraps call to function 'CGContextAddArcToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddArcToPoint(ewg_param_c, ewg_param_x1, ewg_param_y1, ewg_param_x2, ewg_param_y2, ewg_param_radius) CGContextAddArcToPoint ((CGContextRef)ewg_param_c, (float)ewg_param_x1, (float)ewg_param_y1, (float)ewg_param_x2, (float)ewg_param_y2, (float)ewg_param_radius)

void  ewg_function_CGContextAddArcToPoint (CGContextRef c, float x1, float y1, float x2, float y2, float radius);
// Wraps call to function 'CGContextAddPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextAddPath(ewg_param_context, ewg_param_path) CGContextAddPath ((CGContextRef)ewg_param_context, (CGPathRef)ewg_param_path)

void  ewg_function_CGContextAddPath (CGContextRef context, CGPathRef path);
// Wraps call to function 'CGContextReplacePathWithStrokedPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextReplacePathWithStrokedPath(ewg_param_c) CGContextReplacePathWithStrokedPath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextReplacePathWithStrokedPath (CGContextRef c);
// Wraps call to function 'CGContextIsPathEmpty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextIsPathEmpty(ewg_param_c) CGContextIsPathEmpty ((CGContextRef)ewg_param_c)

_Bool  ewg_function_CGContextIsPathEmpty (CGContextRef c);
// Wraps call to function 'CGContextGetPathCurrentPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetPathCurrentPoint(ewg_param_c) CGContextGetPathCurrentPoint ((CGContextRef)ewg_param_c)

CGPoint * ewg_function_CGContextGetPathCurrentPoint (CGContextRef c);
// Wraps call to function 'CGContextGetPathBoundingBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetPathBoundingBox(ewg_param_c) CGContextGetPathBoundingBox ((CGContextRef)ewg_param_c)

CGRect * ewg_function_CGContextGetPathBoundingBox (CGContextRef c);
// Wraps call to function 'CGContextPathContainsPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextPathContainsPoint(ewg_param_context, ewg_param_point, ewg_param_mode) CGContextPathContainsPoint ((CGContextRef)ewg_param_context, *(CGPoint*)ewg_param_point, (CGPathDrawingMode)ewg_param_mode)

_Bool  ewg_function_CGContextPathContainsPoint (CGContextRef context, CGPoint *point, CGPathDrawingMode mode);
// Wraps call to function 'CGContextDrawPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextDrawPath(ewg_param_c, ewg_param_mode) CGContextDrawPath ((CGContextRef)ewg_param_c, (CGPathDrawingMode)ewg_param_mode)

void  ewg_function_CGContextDrawPath (CGContextRef c, CGPathDrawingMode mode);
// Wraps call to function 'CGContextFillPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextFillPath(ewg_param_c) CGContextFillPath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextFillPath (CGContextRef c);
// Wraps call to function 'CGContextEOFillPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextEOFillPath(ewg_param_c) CGContextEOFillPath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextEOFillPath (CGContextRef c);
// Wraps call to function 'CGContextStrokePath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextStrokePath(ewg_param_c) CGContextStrokePath ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextStrokePath (CGContextRef c);
// Wraps call to function 'CGContextFillRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextFillRect(ewg_param_c, ewg_param_rect) CGContextFillRect ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextFillRect (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextFillRects' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextFillRects(ewg_param_c, ewg_param_rects, ewg_param_count) CGContextFillRects ((CGContextRef)ewg_param_c, ewg_param_rects, (size_t)ewg_param_count)

void  ewg_function_CGContextFillRects (CGContextRef c, void *rects, size_t count);
// Wraps call to function 'CGContextStrokeRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextStrokeRect(ewg_param_c, ewg_param_rect) CGContextStrokeRect ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextStrokeRect (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextStrokeRectWithWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextStrokeRectWithWidth(ewg_param_c, ewg_param_rect, ewg_param_width) CGContextStrokeRectWithWidth ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect, (float)ewg_param_width)

void  ewg_function_CGContextStrokeRectWithWidth (CGContextRef c, CGRect *rect, float width);
// Wraps call to function 'CGContextClearRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClearRect(ewg_param_c, ewg_param_rect) CGContextClearRect ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextClearRect (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextFillEllipseInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextFillEllipseInRect(ewg_param_context, ewg_param_rect) CGContextFillEllipseInRect ((CGContextRef)ewg_param_context, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextFillEllipseInRect (CGContextRef context, CGRect *rect);
// Wraps call to function 'CGContextStrokeEllipseInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextStrokeEllipseInRect(ewg_param_context, ewg_param_rect) CGContextStrokeEllipseInRect ((CGContextRef)ewg_param_context, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextStrokeEllipseInRect (CGContextRef context, CGRect *rect);
// Wraps call to function 'CGContextStrokeLineSegments' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextStrokeLineSegments(ewg_param_c, ewg_param_points, ewg_param_count) CGContextStrokeLineSegments ((CGContextRef)ewg_param_c, ewg_param_points, (size_t)ewg_param_count)

void  ewg_function_CGContextStrokeLineSegments (CGContextRef c, void *points, size_t count);
// Wraps call to function 'CGContextClip' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClip(ewg_param_c) CGContextClip ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextClip (CGContextRef c);
// Wraps call to function 'CGContextEOClip' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextEOClip(ewg_param_c) CGContextEOClip ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextEOClip (CGContextRef c);
// Wraps call to function 'CGContextClipToMask' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClipToMask(ewg_param_c, ewg_param_rect, ewg_param_mask) CGContextClipToMask ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect, (CGImageRef)ewg_param_mask)

void  ewg_function_CGContextClipToMask (CGContextRef c, CGRect *rect, CGImageRef mask);
// Wraps call to function 'CGContextGetClipBoundingBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetClipBoundingBox(ewg_param_c) CGContextGetClipBoundingBox ((CGContextRef)ewg_param_c)

CGRect * ewg_function_CGContextGetClipBoundingBox (CGContextRef c);
// Wraps call to function 'CGContextClipToRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClipToRect(ewg_param_c, ewg_param_rect) CGContextClipToRect ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

void  ewg_function_CGContextClipToRect (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextClipToRects' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextClipToRects(ewg_param_c, ewg_param_rects, ewg_param_count) CGContextClipToRects ((CGContextRef)ewg_param_c, ewg_param_rects, (size_t)ewg_param_count)

void  ewg_function_CGContextClipToRects (CGContextRef c, void *rects, size_t count);
// Wraps call to function 'CGContextSetFillColorWithColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFillColorWithColor(ewg_param_c, ewg_param_color) CGContextSetFillColorWithColor ((CGContextRef)ewg_param_c, (CGColorRef)ewg_param_color)

void  ewg_function_CGContextSetFillColorWithColor (CGContextRef c, CGColorRef color);
// Wraps call to function 'CGContextSetStrokeColorWithColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetStrokeColorWithColor(ewg_param_c, ewg_param_color) CGContextSetStrokeColorWithColor ((CGContextRef)ewg_param_c, (CGColorRef)ewg_param_color)

void  ewg_function_CGContextSetStrokeColorWithColor (CGContextRef c, CGColorRef color);
// Wraps call to function 'CGContextSetFillColorSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFillColorSpace(ewg_param_c, ewg_param_colorspace) CGContextSetFillColorSpace ((CGContextRef)ewg_param_c, (CGColorSpaceRef)ewg_param_colorspace)

void  ewg_function_CGContextSetFillColorSpace (CGContextRef c, CGColorSpaceRef colorspace);
// Wraps call to function 'CGContextSetStrokeColorSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetStrokeColorSpace(ewg_param_c, ewg_param_colorspace) CGContextSetStrokeColorSpace ((CGContextRef)ewg_param_c, (CGColorSpaceRef)ewg_param_colorspace)

void  ewg_function_CGContextSetStrokeColorSpace (CGContextRef c, CGColorSpaceRef colorspace);
// Wraps call to function 'CGContextSetFillColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFillColor(ewg_param_c, ewg_param_components) CGContextSetFillColor ((CGContextRef)ewg_param_c, ewg_param_components)

void  ewg_function_CGContextSetFillColor (CGContextRef c, void *components);
// Wraps call to function 'CGContextSetStrokeColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetStrokeColor(ewg_param_c, ewg_param_components) CGContextSetStrokeColor ((CGContextRef)ewg_param_c, ewg_param_components)

void  ewg_function_CGContextSetStrokeColor (CGContextRef c, void *components);
// Wraps call to function 'CGContextSetFillPattern' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFillPattern(ewg_param_c, ewg_param_pattern, ewg_param_components) CGContextSetFillPattern ((CGContextRef)ewg_param_c, (CGPatternRef)ewg_param_pattern, ewg_param_components)

void  ewg_function_CGContextSetFillPattern (CGContextRef c, CGPatternRef pattern, void *components);
// Wraps call to function 'CGContextSetStrokePattern' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetStrokePattern(ewg_param_c, ewg_param_pattern, ewg_param_components) CGContextSetStrokePattern ((CGContextRef)ewg_param_c, (CGPatternRef)ewg_param_pattern, ewg_param_components)

void  ewg_function_CGContextSetStrokePattern (CGContextRef c, CGPatternRef pattern, void *components);
// Wraps call to function 'CGContextSetPatternPhase' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetPatternPhase(ewg_param_c, ewg_param_phase) CGContextSetPatternPhase ((CGContextRef)ewg_param_c, *(CGSize*)ewg_param_phase)

void  ewg_function_CGContextSetPatternPhase (CGContextRef c, CGSize *phase);
// Wraps call to function 'CGContextSetGrayFillColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetGrayFillColor(ewg_param_c, ewg_param_gray, ewg_param_alpha) CGContextSetGrayFillColor ((CGContextRef)ewg_param_c, (float)ewg_param_gray, (float)ewg_param_alpha)

void  ewg_function_CGContextSetGrayFillColor (CGContextRef c, float gray, float alpha);
// Wraps call to function 'CGContextSetGrayStrokeColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetGrayStrokeColor(ewg_param_c, ewg_param_gray, ewg_param_alpha) CGContextSetGrayStrokeColor ((CGContextRef)ewg_param_c, (float)ewg_param_gray, (float)ewg_param_alpha)

void  ewg_function_CGContextSetGrayStrokeColor (CGContextRef c, float gray, float alpha);
// Wraps call to function 'CGContextSetRGBFillColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetRGBFillColor(ewg_param_c, ewg_param_red, ewg_param_green, ewg_param_blue, ewg_param_alpha) CGContextSetRGBFillColor ((CGContextRef)ewg_param_c, (float)ewg_param_red, (float)ewg_param_green, (float)ewg_param_blue, (float)ewg_param_alpha)

void  ewg_function_CGContextSetRGBFillColor (CGContextRef c, float red, float green, float blue, float alpha);
// Wraps call to function 'CGContextSetRGBStrokeColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetRGBStrokeColor(ewg_param_c, ewg_param_red, ewg_param_green, ewg_param_blue, ewg_param_alpha) CGContextSetRGBStrokeColor ((CGContextRef)ewg_param_c, (float)ewg_param_red, (float)ewg_param_green, (float)ewg_param_blue, (float)ewg_param_alpha)

void  ewg_function_CGContextSetRGBStrokeColor (CGContextRef c, float red, float green, float blue, float alpha);
// Wraps call to function 'CGContextSetCMYKFillColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetCMYKFillColor(ewg_param_c, ewg_param_cyan, ewg_param_magenta, ewg_param_yellow, ewg_param_black, ewg_param_alpha) CGContextSetCMYKFillColor ((CGContextRef)ewg_param_c, (float)ewg_param_cyan, (float)ewg_param_magenta, (float)ewg_param_yellow, (float)ewg_param_black, (float)ewg_param_alpha)

void  ewg_function_CGContextSetCMYKFillColor (CGContextRef c, float cyan, float magenta, float yellow, float black, float alpha);
// Wraps call to function 'CGContextSetCMYKStrokeColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetCMYKStrokeColor(ewg_param_c, ewg_param_cyan, ewg_param_magenta, ewg_param_yellow, ewg_param_black, ewg_param_alpha) CGContextSetCMYKStrokeColor ((CGContextRef)ewg_param_c, (float)ewg_param_cyan, (float)ewg_param_magenta, (float)ewg_param_yellow, (float)ewg_param_black, (float)ewg_param_alpha)

void  ewg_function_CGContextSetCMYKStrokeColor (CGContextRef c, float cyan, float magenta, float yellow, float black, float alpha);
// Wraps call to function 'CGContextSetRenderingIntent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetRenderingIntent(ewg_param_c, ewg_param_intent) CGContextSetRenderingIntent ((CGContextRef)ewg_param_c, (CGColorRenderingIntent)ewg_param_intent)

void  ewg_function_CGContextSetRenderingIntent (CGContextRef c, CGColorRenderingIntent intent);
// Wraps call to function 'CGContextDrawImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextDrawImage(ewg_param_c, ewg_param_rect, ewg_param_image) CGContextDrawImage ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect, (CGImageRef)ewg_param_image)

void  ewg_function_CGContextDrawImage (CGContextRef c, CGRect *rect, CGImageRef image);
// Wraps call to function 'CGContextGetInterpolationQuality' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetInterpolationQuality(ewg_param_c) CGContextGetInterpolationQuality ((CGContextRef)ewg_param_c)

CGInterpolationQuality  ewg_function_CGContextGetInterpolationQuality (CGContextRef c);
// Wraps call to function 'CGContextSetInterpolationQuality' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetInterpolationQuality(ewg_param_c, ewg_param_quality) CGContextSetInterpolationQuality ((CGContextRef)ewg_param_c, (CGInterpolationQuality)ewg_param_quality)

void  ewg_function_CGContextSetInterpolationQuality (CGContextRef c, CGInterpolationQuality quality);
// Wraps call to function 'CGContextSetShadowWithColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetShadowWithColor(ewg_param_context, ewg_param_offset, ewg_param_blur, ewg_param_color) CGContextSetShadowWithColor ((CGContextRef)ewg_param_context, *(CGSize*)ewg_param_offset, (float)ewg_param_blur, (CGColorRef)ewg_param_color)

void  ewg_function_CGContextSetShadowWithColor (CGContextRef context, CGSize *offset, float blur, CGColorRef color);
// Wraps call to function 'CGContextSetShadow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetShadow(ewg_param_context, ewg_param_offset, ewg_param_blur) CGContextSetShadow ((CGContextRef)ewg_param_context, *(CGSize*)ewg_param_offset, (float)ewg_param_blur)

void  ewg_function_CGContextSetShadow (CGContextRef context, CGSize *offset, float blur);
// Wraps call to function 'CGContextDrawShading' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextDrawShading(ewg_param_c, ewg_param_shading) CGContextDrawShading ((CGContextRef)ewg_param_c, (CGShadingRef)ewg_param_shading)

void  ewg_function_CGContextDrawShading (CGContextRef c, CGShadingRef shading);
// Wraps call to function 'CGContextSetCharacterSpacing' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetCharacterSpacing(ewg_param_c, ewg_param_spacing) CGContextSetCharacterSpacing ((CGContextRef)ewg_param_c, (float)ewg_param_spacing)

void  ewg_function_CGContextSetCharacterSpacing (CGContextRef c, float spacing);
// Wraps call to function 'CGContextSetTextPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetTextPosition(ewg_param_c, ewg_param_x, ewg_param_y) CGContextSetTextPosition ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y)

void  ewg_function_CGContextSetTextPosition (CGContextRef c, float x, float y);
// Wraps call to function 'CGContextGetTextPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetTextPosition(ewg_param_c) CGContextGetTextPosition ((CGContextRef)ewg_param_c)

CGPoint * ewg_function_CGContextGetTextPosition (CGContextRef c);
// Wraps call to function 'CGContextSetTextMatrix' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetTextMatrix(ewg_param_c, ewg_param_t) CGContextSetTextMatrix ((CGContextRef)ewg_param_c, *(CGAffineTransform*)ewg_param_t)

void  ewg_function_CGContextSetTextMatrix (CGContextRef c, CGAffineTransform *t);
// Wraps call to function 'CGContextGetTextMatrix' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetTextMatrix(ewg_param_c) CGContextGetTextMatrix ((CGContextRef)ewg_param_c)

CGAffineTransform * ewg_function_CGContextGetTextMatrix (CGContextRef c);
// Wraps call to function 'CGContextSetTextDrawingMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetTextDrawingMode(ewg_param_c, ewg_param_mode) CGContextSetTextDrawingMode ((CGContextRef)ewg_param_c, (CGTextDrawingMode)ewg_param_mode)

void  ewg_function_CGContextSetTextDrawingMode (CGContextRef c, CGTextDrawingMode mode);
// Wraps call to function 'CGContextSetFont' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFont(ewg_param_c, ewg_param_font) CGContextSetFont ((CGContextRef)ewg_param_c, (CGFontRef)ewg_param_font)

void  ewg_function_CGContextSetFont (CGContextRef c, CGFontRef font);
// Wraps call to function 'CGContextSetFontSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetFontSize(ewg_param_c, ewg_param_size) CGContextSetFontSize ((CGContextRef)ewg_param_c, (float)ewg_param_size)

void  ewg_function_CGContextSetFontSize (CGContextRef c, float size);
// Wraps call to function 'CGContextSelectFont' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSelectFont(ewg_param_c, ewg_param_name, ewg_param_size, ewg_param_textEncoding) CGContextSelectFont ((CGContextRef)ewg_param_c, (char const*)ewg_param_name, (float)ewg_param_size, (CGTextEncoding)ewg_param_textEncoding)

void  ewg_function_CGContextSelectFont (CGContextRef c, char const *name, float size, CGTextEncoding textEncoding);
// Wraps call to function 'CGContextShowText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextShowText(ewg_param_c, ewg_param_string, ewg_param_length) CGContextShowText ((CGContextRef)ewg_param_c, (char const*)ewg_param_string, (size_t)ewg_param_length)

void  ewg_function_CGContextShowText (CGContextRef c, char const *string, size_t length);
// Wraps call to function 'CGContextShowGlyphs' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextShowGlyphs(ewg_param_c, ewg_param_g, ewg_param_count) CGContextShowGlyphs ((CGContextRef)ewg_param_c, ewg_param_g, (size_t)ewg_param_count)

void  ewg_function_CGContextShowGlyphs (CGContextRef c, void *g, size_t count);
// Wraps call to function 'CGContextShowGlyphsWithAdvances' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextShowGlyphsWithAdvances(ewg_param_c, ewg_param_glyphs, ewg_param_advances, ewg_param_count) CGContextShowGlyphsWithAdvances ((CGContextRef)ewg_param_c, ewg_param_glyphs, ewg_param_advances, (size_t)ewg_param_count)

void  ewg_function_CGContextShowGlyphsWithAdvances (CGContextRef c, void *glyphs, void *advances, size_t count);
// Wraps call to function 'CGContextShowTextAtPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextShowTextAtPoint(ewg_param_c, ewg_param_x, ewg_param_y, ewg_param_string, ewg_param_length) CGContextShowTextAtPoint ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y, (char const*)ewg_param_string, (size_t)ewg_param_length)

void  ewg_function_CGContextShowTextAtPoint (CGContextRef c, float x, float y, char const *string, size_t length);
// Wraps call to function 'CGContextShowGlyphsAtPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextShowGlyphsAtPoint(ewg_param_c, ewg_param_x, ewg_param_y, ewg_param_glyphs, ewg_param_count) CGContextShowGlyphsAtPoint ((CGContextRef)ewg_param_c, (float)ewg_param_x, (float)ewg_param_y, ewg_param_glyphs, (size_t)ewg_param_count)

void  ewg_function_CGContextShowGlyphsAtPoint (CGContextRef c, float x, float y, void *glyphs, size_t count);
// Wraps call to function 'CGContextDrawPDFPage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextDrawPDFPage(ewg_param_c, ewg_param_page) CGContextDrawPDFPage ((CGContextRef)ewg_param_c, (CGPDFPageRef)ewg_param_page)

void  ewg_function_CGContextDrawPDFPage (CGContextRef c, CGPDFPageRef page);
// Wraps call to function 'CGContextDrawPDFDocument' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextDrawPDFDocument(ewg_param_c, ewg_param_rect, ewg_param_document, ewg_param_page) CGContextDrawPDFDocument ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect, (CGPDFDocumentRef)ewg_param_document, (int)ewg_param_page)

void  ewg_function_CGContextDrawPDFDocument (CGContextRef c, CGRect *rect, CGPDFDocumentRef document, int page);
// Wraps call to function 'CGContextBeginPage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextBeginPage(ewg_param_c, ewg_param_mediaBox) CGContextBeginPage ((CGContextRef)ewg_param_c, (CGRect const*)ewg_param_mediaBox)

void  ewg_function_CGContextBeginPage (CGContextRef c, CGRect const *mediaBox);
// Wraps call to function 'CGContextEndPage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextEndPage(ewg_param_c) CGContextEndPage ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextEndPage (CGContextRef c);
// Wraps call to function 'CGContextRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextRetain(ewg_param_c) CGContextRetain ((CGContextRef)ewg_param_c)

CGContextRef  ewg_function_CGContextRetain (CGContextRef c);
// Wraps call to function 'CGContextRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextRelease(ewg_param_c) CGContextRelease ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextRelease (CGContextRef c);
// Wraps call to function 'CGContextFlush' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextFlush(ewg_param_c) CGContextFlush ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextFlush (CGContextRef c);
// Wraps call to function 'CGContextSynchronize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSynchronize(ewg_param_c) CGContextSynchronize ((CGContextRef)ewg_param_c)

void  ewg_function_CGContextSynchronize (CGContextRef c);
// Wraps call to function 'CGContextSetShouldAntialias' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetShouldAntialias(ewg_param_c, ewg_param_shouldAntialias) CGContextSetShouldAntialias ((CGContextRef)ewg_param_c, (_Bool)ewg_param_shouldAntialias)

void  ewg_function_CGContextSetShouldAntialias (CGContextRef c, _Bool shouldAntialias);
// Wraps call to function 'CGContextSetAllowsAntialiasing' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetAllowsAntialiasing(ewg_param_context, ewg_param_allowsAntialiasing) CGContextSetAllowsAntialiasing ((CGContextRef)ewg_param_context, (_Bool)ewg_param_allowsAntialiasing)

void  ewg_function_CGContextSetAllowsAntialiasing (CGContextRef context, _Bool allowsAntialiasing);
// Wraps call to function 'CGContextSetShouldSmoothFonts' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextSetShouldSmoothFonts(ewg_param_c, ewg_param_shouldSmoothFonts) CGContextSetShouldSmoothFonts ((CGContextRef)ewg_param_c, (_Bool)ewg_param_shouldSmoothFonts)

void  ewg_function_CGContextSetShouldSmoothFonts (CGContextRef c, _Bool shouldSmoothFonts);
// Wraps call to function 'CGContextBeginTransparencyLayer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextBeginTransparencyLayer(ewg_param_context, ewg_param_auxiliaryInfo) CGContextBeginTransparencyLayer ((CGContextRef)ewg_param_context, (CFDictionaryRef)ewg_param_auxiliaryInfo)

void  ewg_function_CGContextBeginTransparencyLayer (CGContextRef context, CFDictionaryRef auxiliaryInfo);
// Wraps call to function 'CGContextEndTransparencyLayer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextEndTransparencyLayer(ewg_param_context) CGContextEndTransparencyLayer ((CGContextRef)ewg_param_context)

void  ewg_function_CGContextEndTransparencyLayer (CGContextRef context);
// Wraps call to function 'CGContextGetUserSpaceToDeviceSpaceTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextGetUserSpaceToDeviceSpaceTransform(ewg_param_c) CGContextGetUserSpaceToDeviceSpaceTransform ((CGContextRef)ewg_param_c)

CGAffineTransform * ewg_function_CGContextGetUserSpaceToDeviceSpaceTransform (CGContextRef c);
// Wraps call to function 'CGContextConvertPointToDeviceSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertPointToDeviceSpace(ewg_param_c, ewg_param_point) CGContextConvertPointToDeviceSpace ((CGContextRef)ewg_param_c, *(CGPoint*)ewg_param_point)

CGPoint * ewg_function_CGContextConvertPointToDeviceSpace (CGContextRef c, CGPoint *point);
// Wraps call to function 'CGContextConvertPointToUserSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertPointToUserSpace(ewg_param_c, ewg_param_point) CGContextConvertPointToUserSpace ((CGContextRef)ewg_param_c, *(CGPoint*)ewg_param_point)

CGPoint * ewg_function_CGContextConvertPointToUserSpace (CGContextRef c, CGPoint *point);
// Wraps call to function 'CGContextConvertSizeToDeviceSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertSizeToDeviceSpace(ewg_param_c, ewg_param_size) CGContextConvertSizeToDeviceSpace ((CGContextRef)ewg_param_c, *(CGSize*)ewg_param_size)

CGSize * ewg_function_CGContextConvertSizeToDeviceSpace (CGContextRef c, CGSize *size);
// Wraps call to function 'CGContextConvertSizeToUserSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertSizeToUserSpace(ewg_param_c, ewg_param_size) CGContextConvertSizeToUserSpace ((CGContextRef)ewg_param_c, *(CGSize*)ewg_param_size)

CGSize * ewg_function_CGContextConvertSizeToUserSpace (CGContextRef c, CGSize *size);
// Wraps call to function 'CGContextConvertRectToDeviceSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertRectToDeviceSpace(ewg_param_c, ewg_param_rect) CGContextConvertRectToDeviceSpace ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

CGRect * ewg_function_CGContextConvertRectToDeviceSpace (CGContextRef c, CGRect *rect);
// Wraps call to function 'CGContextConvertRectToUserSpace' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CGContextConvertRectToUserSpace(ewg_param_c, ewg_param_rect) CGContextConvertRectToUserSpace ((CGContextRef)ewg_param_c, *(CGRect*)ewg_param_rect)

CGRect * ewg_function_CGContextConvertRectToUserSpace (CGContextRef c, CGRect *rect);
// Wraps call to function 'NewAECoerceDescUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewAECoerceDescUPP(ewg_param_userRoutine) NewAECoerceDescUPP ((AECoerceDescProcPtr)ewg_param_userRoutine)

AECoerceDescUPP  ewg_function_NewAECoerceDescUPP (AECoerceDescProcPtr userRoutine);
// Wraps call to function 'NewAECoercePtrUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewAECoercePtrUPP(ewg_param_userRoutine) NewAECoercePtrUPP ((AECoercePtrProcPtr)ewg_param_userRoutine)

AECoercePtrUPP  ewg_function_NewAECoercePtrUPP (AECoercePtrProcPtr userRoutine);
// Wraps call to function 'DisposeAECoerceDescUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeAECoerceDescUPP(ewg_param_userUPP) DisposeAECoerceDescUPP ((AECoerceDescUPP)ewg_param_userUPP)

void  ewg_function_DisposeAECoerceDescUPP (AECoerceDescUPP userUPP);
// Wraps call to function 'DisposeAECoercePtrUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeAECoercePtrUPP(ewg_param_userUPP) DisposeAECoercePtrUPP ((AECoercePtrUPP)ewg_param_userUPP)

void  ewg_function_DisposeAECoercePtrUPP (AECoercePtrUPP userUPP);
// Wraps call to function 'InvokeAECoerceDescUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeAECoerceDescUPP(ewg_param_fromDesc, ewg_param_toType, ewg_param_handlerRefcon, ewg_param_toDesc, ewg_param_userUPP) InvokeAECoerceDescUPP ((AEDesc const*)ewg_param_fromDesc, (DescType)ewg_param_toType, (long)ewg_param_handlerRefcon, (AEDesc*)ewg_param_toDesc, (AECoerceDescUPP)ewg_param_userUPP)

OSErr  ewg_function_InvokeAECoerceDescUPP (AEDesc const *fromDesc, DescType toType, long handlerRefcon, AEDesc *toDesc, AECoerceDescUPP userUPP);
// Wraps call to function 'InvokeAECoercePtrUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeAECoercePtrUPP(ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize, ewg_param_toType, ewg_param_handlerRefcon, ewg_param_result, ewg_param_userUPP) InvokeAECoercePtrUPP ((DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize, (DescType)ewg_param_toType, (long)ewg_param_handlerRefcon, (AEDesc*)ewg_param_result, (AECoercePtrUPP)ewg_param_userUPP)

OSErr  ewg_function_InvokeAECoercePtrUPP (DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, long handlerRefcon, AEDesc *result, AECoercePtrUPP userUPP);
// Wraps call to function 'AEInstallCoercionHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEInstallCoercionHandler(ewg_param_fromType, ewg_param_toType, ewg_param_handler, ewg_param_handlerRefcon, ewg_param_fromTypeIsDesc, ewg_param_isSysHandler) AEInstallCoercionHandler ((DescType)ewg_param_fromType, (DescType)ewg_param_toType, (AECoercionHandlerUPP)ewg_param_handler, (long)ewg_param_handlerRefcon, (Boolean)ewg_param_fromTypeIsDesc, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEInstallCoercionHandler (DescType fromType, DescType toType, AECoercionHandlerUPP handler, long handlerRefcon, Boolean fromTypeIsDesc, Boolean isSysHandler);
// Wraps call to function 'AERemoveCoercionHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AERemoveCoercionHandler(ewg_param_fromType, ewg_param_toType, ewg_param_handler, ewg_param_isSysHandler) AERemoveCoercionHandler ((DescType)ewg_param_fromType, (DescType)ewg_param_toType, (AECoercionHandlerUPP)ewg_param_handler, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AERemoveCoercionHandler (DescType fromType, DescType toType, AECoercionHandlerUPP handler, Boolean isSysHandler);
// Wraps call to function 'AEGetCoercionHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetCoercionHandler(ewg_param_fromType, ewg_param_toType, ewg_param_handler, ewg_param_handlerRefcon, ewg_param_fromTypeIsDesc, ewg_param_isSysHandler) AEGetCoercionHandler ((DescType)ewg_param_fromType, (DescType)ewg_param_toType, (AECoercionHandlerUPP*)ewg_param_handler, (long*)ewg_param_handlerRefcon, (Boolean*)ewg_param_fromTypeIsDesc, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEGetCoercionHandler (DescType fromType, DescType toType, AECoercionHandlerUPP *handler, long *handlerRefcon, Boolean *fromTypeIsDesc, Boolean isSysHandler);
// Wraps call to function 'AECoercePtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECoercePtr(ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize, ewg_param_toType, ewg_param_result) AECoercePtr ((DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize, (DescType)ewg_param_toType, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AECoercePtr (DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, AEDesc *result);
// Wraps call to function 'AECoerceDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECoerceDesc(ewg_param_theAEDesc, ewg_param_toType, ewg_param_result) AECoerceDesc ((AEDesc const*)ewg_param_theAEDesc, (DescType)ewg_param_toType, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AECoerceDesc (AEDesc const *theAEDesc, DescType toType, AEDesc *result);
// Wraps call to function 'AEInitializeDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEInitializeDesc(ewg_param_desc) AEInitializeDesc ((AEDesc*)ewg_param_desc)

void  ewg_function_AEInitializeDesc (AEDesc *desc);
// Wraps call to function 'AECreateDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECreateDesc(ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize, ewg_param_result) AECreateDesc ((DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AECreateDesc (DescType typeCode, void const *dataPtr, Size dataSize, AEDesc *result);
// Wraps call to function 'AEDisposeDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEDisposeDesc(ewg_param_theAEDesc) AEDisposeDesc ((AEDesc*)ewg_param_theAEDesc)

OSErr  ewg_function_AEDisposeDesc (AEDesc *theAEDesc);
// Wraps call to function 'AEDuplicateDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEDuplicateDesc(ewg_param_theAEDesc, ewg_param_result) AEDuplicateDesc ((AEDesc const*)ewg_param_theAEDesc, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AEDuplicateDesc (AEDesc const *theAEDesc, AEDesc *result);
// Wraps call to function 'AECreateDescFromExternalPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECreateDescFromExternalPtr(ewg_param_descriptorType, ewg_param_dataPtr, ewg_param_dataLength, ewg_param_disposeCallback, ewg_param_disposeRefcon, ewg_param_theDesc) AECreateDescFromExternalPtr ((OSType)ewg_param_descriptorType, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataLength, (AEDisposeExternalUPP)ewg_param_disposeCallback, (long)ewg_param_disposeRefcon, (AEDesc*)ewg_param_theDesc)

OSStatus  ewg_function_AECreateDescFromExternalPtr (OSType descriptorType, void const *dataPtr, Size dataLength, AEDisposeExternalUPP disposeCallback, long disposeRefcon, AEDesc *theDesc);
// Wraps call to function 'AECreateList' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECreateList(ewg_param_factoringPtr, ewg_param_factoredSize, ewg_param_isRecord, ewg_param_resultList) AECreateList ((void const*)ewg_param_factoringPtr, (Size)ewg_param_factoredSize, (Boolean)ewg_param_isRecord, (AEDescList*)ewg_param_resultList)

OSErr  ewg_function_AECreateList (void const *factoringPtr, Size factoredSize, Boolean isRecord, AEDescList *resultList);
// Wraps call to function 'AECountItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECountItems(ewg_param_theAEDescList, ewg_param_theCount) AECountItems ((AEDescList const*)ewg_param_theAEDescList, (long*)ewg_param_theCount)

OSErr  ewg_function_AECountItems (AEDescList const *theAEDescList, long *theCount);
// Wraps call to function 'AEPutPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutPtr(ewg_param_theAEDescList, ewg_param_index, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize) AEPutPtr ((AEDescList*)ewg_param_theAEDescList, (long)ewg_param_index, (DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize)

OSErr  ewg_function_AEPutPtr (AEDescList *theAEDescList, long index, DescType typeCode, void const *dataPtr, Size dataSize);
// Wraps call to function 'AEPutDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutDesc(ewg_param_theAEDescList, ewg_param_index, ewg_param_theAEDesc) AEPutDesc ((AEDescList*)ewg_param_theAEDescList, (long)ewg_param_index, (AEDesc const*)ewg_param_theAEDesc)

OSErr  ewg_function_AEPutDesc (AEDescList *theAEDescList, long index, AEDesc const *theAEDesc);
// Wraps call to function 'AEGetNthPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetNthPtr(ewg_param_theAEDescList, ewg_param_index, ewg_param_desiredType, ewg_param_theAEKeyword, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_maximumSize, ewg_param_actualSize) AEGetNthPtr ((AEDescList const*)ewg_param_theAEDescList, (long)ewg_param_index, (DescType)ewg_param_desiredType, (AEKeyword*)ewg_param_theAEKeyword, (DescType*)ewg_param_typeCode, (void*)ewg_param_dataPtr, (Size)ewg_param_maximumSize, (Size*)ewg_param_actualSize)

OSErr  ewg_function_AEGetNthPtr (AEDescList const *theAEDescList, long index, DescType desiredType, AEKeyword *theAEKeyword, DescType *typeCode, void *dataPtr, Size maximumSize, Size *actualSize);
// Wraps call to function 'AEGetNthDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetNthDesc(ewg_param_theAEDescList, ewg_param_index, ewg_param_desiredType, ewg_param_theAEKeyword, ewg_param_result) AEGetNthDesc ((AEDescList const*)ewg_param_theAEDescList, (long)ewg_param_index, (DescType)ewg_param_desiredType, (AEKeyword*)ewg_param_theAEKeyword, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AEGetNthDesc (AEDescList const *theAEDescList, long index, DescType desiredType, AEKeyword *theAEKeyword, AEDesc *result);
// Wraps call to function 'AESizeOfNthItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AESizeOfNthItem(ewg_param_theAEDescList, ewg_param_index, ewg_param_typeCode, ewg_param_dataSize) AESizeOfNthItem ((AEDescList const*)ewg_param_theAEDescList, (long)ewg_param_index, (DescType*)ewg_param_typeCode, (Size*)ewg_param_dataSize)

OSErr  ewg_function_AESizeOfNthItem (AEDescList const *theAEDescList, long index, DescType *typeCode, Size *dataSize);
// Wraps call to function 'AEGetArray' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetArray(ewg_param_theAEDescList, ewg_param_arrayType, ewg_param_arrayPtr, ewg_param_maximumSize, ewg_param_itemType, ewg_param_itemSize, ewg_param_itemCount) AEGetArray ((AEDescList const*)ewg_param_theAEDescList, (AEArrayType)ewg_param_arrayType, (AEArrayDataPointer)ewg_param_arrayPtr, (Size)ewg_param_maximumSize, (DescType*)ewg_param_itemType, (Size*)ewg_param_itemSize, (long*)ewg_param_itemCount)

OSErr  ewg_function_AEGetArray (AEDescList const *theAEDescList, AEArrayType arrayType, AEArrayDataPointer arrayPtr, Size maximumSize, DescType *itemType, Size *itemSize, long *itemCount);
// Wraps call to function 'AEPutArray' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutArray(ewg_param_theAEDescList, ewg_param_arrayType, ewg_param_arrayPtr, ewg_param_itemType, ewg_param_itemSize, ewg_param_itemCount) AEPutArray ((AEDescList*)ewg_param_theAEDescList, (AEArrayType)ewg_param_arrayType, (AEArrayData const*)ewg_param_arrayPtr, (DescType)ewg_param_itemType, (Size)ewg_param_itemSize, (long)ewg_param_itemCount)

OSErr  ewg_function_AEPutArray (AEDescList *theAEDescList, AEArrayType arrayType, AEArrayData const *arrayPtr, DescType itemType, Size itemSize, long itemCount);
// Wraps call to function 'AEDeleteItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEDeleteItem(ewg_param_theAEDescList, ewg_param_index) AEDeleteItem ((AEDescList*)ewg_param_theAEDescList, (long)ewg_param_index)

OSErr  ewg_function_AEDeleteItem (AEDescList *theAEDescList, long index);
// Wraps call to function 'AECheckIsRecord' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECheckIsRecord(ewg_param_theDesc) AECheckIsRecord ((AEDesc const*)ewg_param_theDesc)

Boolean  ewg_function_AECheckIsRecord (AEDesc const *theDesc);
// Wraps call to function 'AECreateAppleEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECreateAppleEvent(ewg_param_theAEEventClass, ewg_param_theAEEventID, ewg_param_target, ewg_param_returnID, ewg_param_transactionID, ewg_param_result) AECreateAppleEvent ((AEEventClass)ewg_param_theAEEventClass, (AEEventID)ewg_param_theAEEventID, (AEAddressDesc const*)ewg_param_target, (AEReturnID)ewg_param_returnID, (AETransactionID)ewg_param_transactionID, (AppleEvent*)ewg_param_result)

OSErr  ewg_function_AECreateAppleEvent (AEEventClass theAEEventClass, AEEventID theAEEventID, AEAddressDesc const *target, AEReturnID returnID, AETransactionID transactionID, AppleEvent *result);
// Wraps call to function 'AEPutParamPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutParamPtr(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize) AEPutParamPtr ((AppleEvent*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize)

OSErr  ewg_function_AEPutParamPtr (AppleEvent *theAppleEvent, AEKeyword theAEKeyword, DescType typeCode, void const *dataPtr, Size dataSize);
// Wraps call to function 'AEPutParamDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutParamDesc(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_theAEDesc) AEPutParamDesc ((AppleEvent*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (AEDesc const*)ewg_param_theAEDesc)

OSErr  ewg_function_AEPutParamDesc (AppleEvent *theAppleEvent, AEKeyword theAEKeyword, AEDesc const *theAEDesc);
// Wraps call to function 'AEGetParamPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetParamPtr(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_desiredType, ewg_param_actualType, ewg_param_dataPtr, ewg_param_maximumSize, ewg_param_actualSize) AEGetParamPtr ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_desiredType, (DescType*)ewg_param_actualType, (void*)ewg_param_dataPtr, (Size)ewg_param_maximumSize, (Size*)ewg_param_actualSize)

OSErr  ewg_function_AEGetParamPtr (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType desiredType, DescType *actualType, void *dataPtr, Size maximumSize, Size *actualSize);
// Wraps call to function 'AEGetParamDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetParamDesc(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_desiredType, ewg_param_result) AEGetParamDesc ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_desiredType, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AEGetParamDesc (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType desiredType, AEDesc *result);
// Wraps call to function 'AESizeOfParam' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AESizeOfParam(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_typeCode, ewg_param_dataSize) AESizeOfParam ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType*)ewg_param_typeCode, (Size*)ewg_param_dataSize)

OSErr  ewg_function_AESizeOfParam (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType *typeCode, Size *dataSize);
// Wraps call to function 'AEDeleteParam' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEDeleteParam(ewg_param_theAppleEvent, ewg_param_theAEKeyword) AEDeleteParam ((AppleEvent*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword)

OSErr  ewg_function_AEDeleteParam (AppleEvent *theAppleEvent, AEKeyword theAEKeyword);
// Wraps call to function 'AEGetAttributePtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetAttributePtr(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_desiredType, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_maximumSize, ewg_param_actualSize) AEGetAttributePtr ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_desiredType, (DescType*)ewg_param_typeCode, (void*)ewg_param_dataPtr, (Size)ewg_param_maximumSize, (Size*)ewg_param_actualSize)

OSErr  ewg_function_AEGetAttributePtr (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType desiredType, DescType *typeCode, void *dataPtr, Size maximumSize, Size *actualSize);
// Wraps call to function 'AEGetAttributeDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetAttributeDesc(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_desiredType, ewg_param_result) AEGetAttributeDesc ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_desiredType, (AEDesc*)ewg_param_result)

OSErr  ewg_function_AEGetAttributeDesc (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType desiredType, AEDesc *result);
// Wraps call to function 'AESizeOfAttribute' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AESizeOfAttribute(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_typeCode, ewg_param_dataSize) AESizeOfAttribute ((AppleEvent const*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType*)ewg_param_typeCode, (Size*)ewg_param_dataSize)

OSErr  ewg_function_AESizeOfAttribute (AppleEvent const *theAppleEvent, AEKeyword theAEKeyword, DescType *typeCode, Size *dataSize);
// Wraps call to function 'AEPutAttributePtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutAttributePtr(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize) AEPutAttributePtr ((AppleEvent*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize)

OSErr  ewg_function_AEPutAttributePtr (AppleEvent *theAppleEvent, AEKeyword theAEKeyword, DescType typeCode, void const *dataPtr, Size dataSize);
// Wraps call to function 'AEPutAttributeDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEPutAttributeDesc(ewg_param_theAppleEvent, ewg_param_theAEKeyword, ewg_param_theAEDesc) AEPutAttributeDesc ((AppleEvent*)ewg_param_theAppleEvent, (AEKeyword)ewg_param_theAEKeyword, (AEDesc const*)ewg_param_theAEDesc)

OSErr  ewg_function_AEPutAttributeDesc (AppleEvent *theAppleEvent, AEKeyword theAEKeyword, AEDesc const *theAEDesc);
// Wraps call to function 'AESizeOfFlattenedDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AESizeOfFlattenedDesc(ewg_param_theAEDesc) AESizeOfFlattenedDesc ((AEDesc const*)ewg_param_theAEDesc)

Size  ewg_function_AESizeOfFlattenedDesc (AEDesc const *theAEDesc);
// Wraps call to function 'AEFlattenDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEFlattenDesc(ewg_param_theAEDesc, ewg_param_buffer, ewg_param_bufferSize, ewg_param_actualSize) AEFlattenDesc ((AEDesc const*)ewg_param_theAEDesc, (Ptr)ewg_param_buffer, (Size)ewg_param_bufferSize, (Size*)ewg_param_actualSize)

OSStatus  ewg_function_AEFlattenDesc (AEDesc const *theAEDesc, Ptr buffer, Size bufferSize, Size *actualSize);
// Wraps call to function 'AEUnflattenDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEUnflattenDesc(ewg_param_buffer, ewg_param_result) AEUnflattenDesc ((void const*)ewg_param_buffer, (AEDesc*)ewg_param_result)

OSStatus  ewg_function_AEUnflattenDesc (void const *buffer, AEDesc *result);
// Wraps call to function 'AEGetDescData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetDescData(ewg_param_theAEDesc, ewg_param_dataPtr, ewg_param_maximumSize) AEGetDescData ((AEDesc const*)ewg_param_theAEDesc, (void*)ewg_param_dataPtr, (Size)ewg_param_maximumSize)

OSErr  ewg_function_AEGetDescData (AEDesc const *theAEDesc, void *dataPtr, Size maximumSize);
// Wraps call to function 'AEGetDescDataSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetDescDataSize(ewg_param_theAEDesc) AEGetDescDataSize ((AEDesc const*)ewg_param_theAEDesc)

Size  ewg_function_AEGetDescDataSize (AEDesc const *theAEDesc);
// Wraps call to function 'AEReplaceDescData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEReplaceDescData(ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize, ewg_param_theAEDesc) AEReplaceDescData ((DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize, (AEDesc*)ewg_param_theAEDesc)

OSErr  ewg_function_AEReplaceDescData (DescType typeCode, void const *dataPtr, Size dataSize, AEDesc *theAEDesc);
// Wraps call to function 'AEGetDescDataRange' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetDescDataRange(ewg_param_dataDesc, ewg_param_buffer, ewg_param_offset, ewg_param_length) AEGetDescDataRange ((AEDesc const*)ewg_param_dataDesc, (void*)ewg_param_buffer, (Size)ewg_param_offset, (Size)ewg_param_length)

OSStatus  ewg_function_AEGetDescDataRange (AEDesc const *dataDesc, void *buffer, Size offset, Size length);
// Wraps call to function 'NewAEDisposeExternalUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewAEDisposeExternalUPP(ewg_param_userRoutine) NewAEDisposeExternalUPP ((AEDisposeExternalProcPtr)ewg_param_userRoutine)

AEDisposeExternalUPP  ewg_function_NewAEDisposeExternalUPP (AEDisposeExternalProcPtr userRoutine);
// Wraps call to function 'NewAEEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewAEEventHandlerUPP(ewg_param_userRoutine) NewAEEventHandlerUPP ((AEEventHandlerProcPtr)ewg_param_userRoutine)

AEEventHandlerUPP  ewg_function_NewAEEventHandlerUPP (AEEventHandlerProcPtr userRoutine);
// Wraps call to function 'DisposeAEDisposeExternalUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeAEDisposeExternalUPP(ewg_param_userUPP) DisposeAEDisposeExternalUPP ((AEDisposeExternalUPP)ewg_param_userUPP)

void  ewg_function_DisposeAEDisposeExternalUPP (AEDisposeExternalUPP userUPP);
// Wraps call to function 'DisposeAEEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeAEEventHandlerUPP(ewg_param_userUPP) DisposeAEEventHandlerUPP ((AEEventHandlerUPP)ewg_param_userUPP)

void  ewg_function_DisposeAEEventHandlerUPP (AEEventHandlerUPP userUPP);
// Wraps call to function 'InvokeAEDisposeExternalUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeAEDisposeExternalUPP(ewg_param_dataPtr, ewg_param_dataLength, ewg_param_refcon, ewg_param_userUPP) InvokeAEDisposeExternalUPP ((void const*)ewg_param_dataPtr, (Size)ewg_param_dataLength, (long)ewg_param_refcon, (AEDisposeExternalUPP)ewg_param_userUPP)

void  ewg_function_InvokeAEDisposeExternalUPP (void const *dataPtr, Size dataLength, long refcon, AEDisposeExternalUPP userUPP);
// Wraps call to function 'InvokeAEEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeAEEventHandlerUPP(ewg_param_theAppleEvent, ewg_param_reply, ewg_param_handlerRefcon, ewg_param_userUPP) InvokeAEEventHandlerUPP ((AppleEvent const*)ewg_param_theAppleEvent, (AppleEvent*)ewg_param_reply, (long)ewg_param_handlerRefcon, (AEEventHandlerUPP)ewg_param_userUPP)

OSErr  ewg_function_InvokeAEEventHandlerUPP (AppleEvent const *theAppleEvent, AppleEvent *reply, long handlerRefcon, AEEventHandlerUPP userUPP);
// Wraps call to function 'AEInstallEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEInstallEventHandler(ewg_param_theAEEventClass, ewg_param_theAEEventID, ewg_param_handler, ewg_param_handlerRefcon, ewg_param_isSysHandler) AEInstallEventHandler ((AEEventClass)ewg_param_theAEEventClass, (AEEventID)ewg_param_theAEEventID, (AEEventHandlerUPP)ewg_param_handler, (long)ewg_param_handlerRefcon, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEInstallEventHandler (AEEventClass theAEEventClass, AEEventID theAEEventID, AEEventHandlerUPP handler, long handlerRefcon, Boolean isSysHandler);
// Wraps call to function 'AERemoveEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AERemoveEventHandler(ewg_param_theAEEventClass, ewg_param_theAEEventID, ewg_param_handler, ewg_param_isSysHandler) AERemoveEventHandler ((AEEventClass)ewg_param_theAEEventClass, (AEEventID)ewg_param_theAEEventID, (AEEventHandlerUPP)ewg_param_handler, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AERemoveEventHandler (AEEventClass theAEEventClass, AEEventID theAEEventID, AEEventHandlerUPP handler, Boolean isSysHandler);
// Wraps call to function 'AEGetEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetEventHandler(ewg_param_theAEEventClass, ewg_param_theAEEventID, ewg_param_handler, ewg_param_handlerRefcon, ewg_param_isSysHandler) AEGetEventHandler ((AEEventClass)ewg_param_theAEEventClass, (AEEventID)ewg_param_theAEEventID, (AEEventHandlerUPP*)ewg_param_handler, (long*)ewg_param_handlerRefcon, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEGetEventHandler (AEEventClass theAEEventClass, AEEventID theAEEventID, AEEventHandlerUPP *handler, long *handlerRefcon, Boolean isSysHandler);
// Wraps call to function 'AEInstallSpecialHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEInstallSpecialHandler(ewg_param_functionClass, ewg_param_handler, ewg_param_isSysHandler) AEInstallSpecialHandler ((AEKeyword)ewg_param_functionClass, (AEEventHandlerUPP)ewg_param_handler, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEInstallSpecialHandler (AEKeyword functionClass, AEEventHandlerUPP handler, Boolean isSysHandler);
// Wraps call to function 'AERemoveSpecialHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AERemoveSpecialHandler(ewg_param_functionClass, ewg_param_handler, ewg_param_isSysHandler) AERemoveSpecialHandler ((AEKeyword)ewg_param_functionClass, (AEEventHandlerUPP)ewg_param_handler, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AERemoveSpecialHandler (AEKeyword functionClass, AEEventHandlerUPP handler, Boolean isSysHandler);
// Wraps call to function 'AEGetSpecialHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEGetSpecialHandler(ewg_param_functionClass, ewg_param_handler, ewg_param_isSysHandler) AEGetSpecialHandler ((AEKeyword)ewg_param_functionClass, (AEEventHandlerUPP*)ewg_param_handler, (Boolean)ewg_param_isSysHandler)

OSErr  ewg_function_AEGetSpecialHandler (AEKeyword functionClass, AEEventHandlerUPP *handler, Boolean isSysHandler);
// Wraps call to function 'AEManagerInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEManagerInfo(ewg_param_keyWord, ewg_param_result) AEManagerInfo ((AEKeyword)ewg_param_keyWord, (long*)ewg_param_result)

OSErr  ewg_function_AEManagerInfo (AEKeyword keyWord, long *result);
// Wraps call to function 'AECreateRemoteProcessResolver' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AECreateRemoteProcessResolver(ewg_param_allocator, ewg_param_url) AECreateRemoteProcessResolver ((CFAllocatorRef)ewg_param_allocator, (CFURLRef)ewg_param_url)

AERemoteProcessResolverRef  ewg_function_AECreateRemoteProcessResolver (CFAllocatorRef allocator, CFURLRef url);
// Wraps call to function 'AEDisposeRemoteProcessResolver' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AEDisposeRemoteProcessResolver(ewg_param_ref) AEDisposeRemoteProcessResolver ((AERemoteProcessResolverRef)ewg_param_ref)

void  ewg_function_AEDisposeRemoteProcessResolver (AERemoteProcessResolverRef ref);
// Wraps call to function 'AERemoteProcessResolverGetProcesses' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AERemoteProcessResolverGetProcesses(ewg_param_ref, ewg_param_outError) AERemoteProcessResolverGetProcesses ((AERemoteProcessResolverRef)ewg_param_ref, (CFStreamError*)ewg_param_outError)

CFArrayRef  ewg_function_AERemoteProcessResolverGetProcesses (AERemoteProcessResolverRef ref, CFStreamError *outError);
// Wraps call to function 'AERemoteProcessResolverScheduleWithRunLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AERemoteProcessResolverScheduleWithRunLoop(ewg_param_ref, ewg_param_runLoop, ewg_param_runLoopMode, ewg_param_callback, ewg_param_ctx) AERemoteProcessResolverScheduleWithRunLoop ((AERemoteProcessResolverRef)ewg_param_ref, (CFRunLoopRef)ewg_param_runLoop, (CFStringRef)ewg_param_runLoopMode, (AERemoteProcessResolverCallback)ewg_param_callback, (AERemoteProcessResolverContext const*)ewg_param_ctx)

void  ewg_function_AERemoteProcessResolverScheduleWithRunLoop (AERemoteProcessResolverRef ref, CFRunLoopRef runLoop, CFStringRef runLoopMode, AERemoteProcessResolverCallback callback, AERemoteProcessResolverContext const *ctx);
// Wraps call to function 'QDPictCreateWithProvider' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictCreateWithProvider(ewg_param_provider) QDPictCreateWithProvider ((CGDataProviderRef)ewg_param_provider)

QDPictRef  ewg_function_QDPictCreateWithProvider (CGDataProviderRef provider);
// Wraps call to function 'QDPictCreateWithURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictCreateWithURL(ewg_param_url) QDPictCreateWithURL ((CFURLRef)ewg_param_url)

QDPictRef  ewg_function_QDPictCreateWithURL (CFURLRef url);
// Wraps call to function 'QDPictRetain' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictRetain(ewg_param_pictRef) QDPictRetain ((QDPictRef)ewg_param_pictRef)

QDPictRef  ewg_function_QDPictRetain (QDPictRef pictRef);
// Wraps call to function 'QDPictRelease' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictRelease(ewg_param_pictRef) QDPictRelease ((QDPictRef)ewg_param_pictRef)

void  ewg_function_QDPictRelease (QDPictRef pictRef);
// Wraps call to function 'QDPictGetBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictGetBounds(ewg_param_pictRef) QDPictGetBounds ((QDPictRef)ewg_param_pictRef)

CGRect * ewg_function_QDPictGetBounds (QDPictRef pictRef);
// Wraps call to function 'QDPictGetResolution' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictGetResolution(ewg_param_pictRef, ewg_param_xRes, ewg_param_yRes) QDPictGetResolution ((QDPictRef)ewg_param_pictRef, (float*)ewg_param_xRes, (float*)ewg_param_yRes)

void  ewg_function_QDPictGetResolution (QDPictRef pictRef, float *xRes, float *yRes);
// Wraps call to function 'QDPictDrawToCGContext' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QDPictDrawToCGContext(ewg_param_ctx, ewg_param_rect, ewg_param_pictRef) QDPictDrawToCGContext ((CGContextRef)ewg_param_ctx, *(CGRect*)ewg_param_rect, (QDPictRef)ewg_param_pictRef)

OSStatus  ewg_function_QDPictDrawToCGContext (CGContextRef ctx, CGRect *rect, QDPictRef pictRef);
// Wraps call to function 'LaunchApplication' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LaunchApplication(ewg_param_LaunchParams) LaunchApplication ((LaunchPBPtr)ewg_param_LaunchParams)

OSErr  ewg_function_LaunchApplication (LaunchPBPtr LaunchParams);
// Wraps call to function 'GetCurrentProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentProcess(ewg_param_PSN) GetCurrentProcess ((ProcessSerialNumber*)ewg_param_PSN)

OSErr  ewg_function_GetCurrentProcess (ProcessSerialNumber *PSN);
// Wraps call to function 'GetFrontProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetFrontProcess(ewg_param_PSN) GetFrontProcess ((ProcessSerialNumber*)ewg_param_PSN)

OSErr  ewg_function_GetFrontProcess (ProcessSerialNumber *PSN);
// Wraps call to function 'GetNextProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNextProcess(ewg_param_PSN) GetNextProcess ((ProcessSerialNumber*)ewg_param_PSN)

OSErr  ewg_function_GetNextProcess (ProcessSerialNumber *PSN);
// Wraps call to function 'GetProcessInformation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetProcessInformation(ewg_param_PSN, ewg_param_info) GetProcessInformation ((ProcessSerialNumber const*)ewg_param_PSN, (ProcessInfoRec*)ewg_param_info)

OSErr  ewg_function_GetProcessInformation (ProcessSerialNumber const *PSN, ProcessInfoRec *info);
// Wraps call to function 'ProcessInformationCopyDictionary' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ProcessInformationCopyDictionary(ewg_param_PSN, ewg_param_infoToReturn) ProcessInformationCopyDictionary ((ProcessSerialNumber const*)ewg_param_PSN, (UInt32)ewg_param_infoToReturn)

CFDictionaryRef  ewg_function_ProcessInformationCopyDictionary (ProcessSerialNumber const *PSN, UInt32 infoToReturn);
// Wraps call to function 'SetFrontProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetFrontProcess(ewg_param_PSN) SetFrontProcess ((ProcessSerialNumber const*)ewg_param_PSN)

OSErr  ewg_function_SetFrontProcess (ProcessSerialNumber const *PSN);
// Wraps call to function 'SetFrontProcessWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetFrontProcessWithOptions(ewg_param_inProcess, ewg_param_inOptions) SetFrontProcessWithOptions ((ProcessSerialNumber const*)ewg_param_inProcess, (OptionBits)ewg_param_inOptions)

OSStatus  ewg_function_SetFrontProcessWithOptions (ProcessSerialNumber const *inProcess, OptionBits inOptions);
// Wraps call to function 'WakeUpProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_WakeUpProcess(ewg_param_PSN) WakeUpProcess ((ProcessSerialNumber const*)ewg_param_PSN)

OSErr  ewg_function_WakeUpProcess (ProcessSerialNumber const *PSN);
// Wraps call to function 'SameProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SameProcess(ewg_param_PSN1, ewg_param_PSN2, ewg_param_result) SameProcess ((ProcessSerialNumber const*)ewg_param_PSN1, (ProcessSerialNumber const*)ewg_param_PSN2, (Boolean*)ewg_param_result)

OSErr  ewg_function_SameProcess (ProcessSerialNumber const *PSN1, ProcessSerialNumber const *PSN2, Boolean *result);
// Wraps call to function 'ExitToShell' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ExitToShell ExitToShell ()

void  ewg_function_ExitToShell (void);
// Wraps call to function 'KillProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_KillProcess(ewg_param_inProcess) KillProcess ((ProcessSerialNumber const*)ewg_param_inProcess)

OSErr  ewg_function_KillProcess (ProcessSerialNumber const *inProcess);
// Wraps call to function 'GetProcessBundleLocation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetProcessBundleLocation(ewg_param_psn, ewg_param_location) GetProcessBundleLocation ((ProcessSerialNumber const*)ewg_param_psn, (FSRef*)ewg_param_location)

OSStatus  ewg_function_GetProcessBundleLocation (ProcessSerialNumber const *psn, FSRef *location);
// Wraps call to function 'CopyProcessName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyProcessName(ewg_param_psn, ewg_param_name) CopyProcessName ((ProcessSerialNumber const*)ewg_param_psn, (CFStringRef*)ewg_param_name)

OSStatus  ewg_function_CopyProcessName (ProcessSerialNumber const *psn, CFStringRef *name);
// Wraps call to function 'GetProcessPID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetProcessPID(ewg_param_psn, ewg_param_pid) GetProcessPID ((ProcessSerialNumber const*)ewg_param_psn, (pid_t*)ewg_param_pid)

OSStatus  ewg_function_GetProcessPID (ProcessSerialNumber const *psn, pid_t *pid);
// Wraps call to function 'GetProcessForPID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetProcessForPID(ewg_param_pid, ewg_param_psn) GetProcessForPID ((pid_t)ewg_param_pid, (ProcessSerialNumber*)ewg_param_psn)

OSStatus  ewg_function_GetProcessForPID (pid_t pid, ProcessSerialNumber *psn);
// Wraps call to function 'IsProcessVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsProcessVisible(ewg_param_psn) IsProcessVisible ((ProcessSerialNumber const*)ewg_param_psn)

Boolean  ewg_function_IsProcessVisible (ProcessSerialNumber const *psn);
// Wraps call to function 'ShowHideProcess' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowHideProcess(ewg_param_psn, ewg_param_visible) ShowHideProcess ((ProcessSerialNumber const*)ewg_param_psn, (Boolean)ewg_param_visible)

OSErr  ewg_function_ShowHideProcess (ProcessSerialNumber const *psn, Boolean visible);
// Wraps call to function 'TransformProcessType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TransformProcessType(ewg_param_psn, ewg_param_transformState) TransformProcessType ((ProcessSerialNumber const*)ewg_param_psn, (ProcessApplicationTransformState)ewg_param_transformState)

OSStatus  ewg_function_TransformProcessType (ProcessSerialNumber const *psn, ProcessApplicationTransformState transformState);
// Wraps call to function 'GetCurrentEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEventLoop GetCurrentEventLoop ()

EventLoopRef  ewg_function_GetCurrentEventLoop (void);
// Wraps call to function 'GetMainEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMainEventLoop GetMainEventLoop ()

EventLoopRef  ewg_function_GetMainEventLoop (void);
// Wraps call to function 'RunCurrentEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RunCurrentEventLoop(ewg_param_inTimeout) RunCurrentEventLoop ((EventTimeout)ewg_param_inTimeout)

OSStatus  ewg_function_RunCurrentEventLoop (EventTimeout inTimeout);
// Wraps call to function 'QuitEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QuitEventLoop(ewg_param_inEventLoop) QuitEventLoop ((EventLoopRef)ewg_param_inEventLoop)

OSStatus  ewg_function_QuitEventLoop (EventLoopRef inEventLoop);
// Wraps call to function 'GetCFRunLoopFromEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCFRunLoopFromEventLoop(ewg_param_inEventLoop) GetCFRunLoopFromEventLoop ((EventLoopRef)ewg_param_inEventLoop)

CFTypeRef  ewg_function_GetCFRunLoopFromEventLoop (EventLoopRef inEventLoop);
// Wraps call to function 'ReceiveNextEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReceiveNextEvent(ewg_param_inNumTypes, ewg_param_inList, ewg_param_inTimeout, ewg_param_inPullEvent, ewg_param_outEvent) ReceiveNextEvent ((UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList, (EventTimeout)ewg_param_inTimeout, (Boolean)ewg_param_inPullEvent, (EventRef*)ewg_param_outEvent)

OSStatus  ewg_function_ReceiveNextEvent (UInt32 inNumTypes, EventTypeSpec const *inList, EventTimeout inTimeout, Boolean inPullEvent, EventRef *outEvent);
// Wraps call to function 'CreateEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateEvent(ewg_param_inAllocator, ewg_param_inClassID, ewg_param_inKind, ewg_param_inWhen, ewg_param_inAttributes, ewg_param_outEvent) CreateEvent ((CFAllocatorRef)ewg_param_inAllocator, (UInt32)ewg_param_inClassID, (UInt32)ewg_param_inKind, (EventTime)ewg_param_inWhen, (EventAttributes)ewg_param_inAttributes, (EventRef*)ewg_param_outEvent)

OSStatus  ewg_function_CreateEvent (CFAllocatorRef inAllocator, UInt32 inClassID, UInt32 inKind, EventTime inWhen, EventAttributes inAttributes, EventRef *outEvent);
// Wraps call to function 'CopyEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyEvent(ewg_param_inOther) CopyEvent ((EventRef)ewg_param_inOther)

EventRef  ewg_function_CopyEvent (EventRef inOther);
// Wraps call to function 'CopyEventAs' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyEventAs(ewg_param_inAllocator, ewg_param_inOther, ewg_param_inEventClass, ewg_param_inEventKind) CopyEventAs ((CFAllocatorRef)ewg_param_inAllocator, (EventRef)ewg_param_inOther, (UInt32)ewg_param_inEventClass, (UInt32)ewg_param_inEventKind)

EventRef  ewg_function_CopyEventAs (CFAllocatorRef inAllocator, EventRef inOther, UInt32 inEventClass, UInt32 inEventKind);
// Wraps call to function 'RetainEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RetainEvent(ewg_param_inEvent) RetainEvent ((EventRef)ewg_param_inEvent)

EventRef  ewg_function_RetainEvent (EventRef inEvent);
// Wraps call to function 'GetEventRetainCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventRetainCount(ewg_param_inEvent) GetEventRetainCount ((EventRef)ewg_param_inEvent)

UInt32  ewg_function_GetEventRetainCount (EventRef inEvent);
// Wraps call to function 'ReleaseEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseEvent(ewg_param_inEvent) ReleaseEvent ((EventRef)ewg_param_inEvent)

void  ewg_function_ReleaseEvent (EventRef inEvent);
// Wraps call to function 'SetEventParameter' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetEventParameter(ewg_param_inEvent, ewg_param_inName, ewg_param_inType, ewg_param_inSize, ewg_param_inDataPtr) SetEventParameter ((EventRef)ewg_param_inEvent, (EventParamName)ewg_param_inName, (EventParamType)ewg_param_inType, (UInt32)ewg_param_inSize, (void const*)ewg_param_inDataPtr)

OSStatus  ewg_function_SetEventParameter (EventRef inEvent, EventParamName inName, EventParamType inType, UInt32 inSize, void const *inDataPtr);
// Wraps call to function 'GetEventParameter' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventParameter(ewg_param_inEvent, ewg_param_inName, ewg_param_inDesiredType, ewg_param_outActualType, ewg_param_inBufferSize, ewg_param_outActualSize, ewg_param_outData) GetEventParameter ((EventRef)ewg_param_inEvent, (EventParamName)ewg_param_inName, (EventParamType)ewg_param_inDesiredType, (EventParamType*)ewg_param_outActualType, (UInt32)ewg_param_inBufferSize, (UInt32*)ewg_param_outActualSize, (void*)ewg_param_outData)

OSStatus  ewg_function_GetEventParameter (EventRef inEvent, EventParamName inName, EventParamType inDesiredType, EventParamType *outActualType, UInt32 inBufferSize, UInt32 *outActualSize, void *outData);
// Wraps call to function 'GetEventClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventClass(ewg_param_inEvent) GetEventClass ((EventRef)ewg_param_inEvent)

UInt32  ewg_function_GetEventClass (EventRef inEvent);
// Wraps call to function 'GetEventKind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventKind(ewg_param_inEvent) GetEventKind ((EventRef)ewg_param_inEvent)

UInt32  ewg_function_GetEventKind (EventRef inEvent);
// Wraps call to function 'GetEventTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventTime(ewg_param_inEvent) GetEventTime ((EventRef)ewg_param_inEvent)

EventTime  ewg_function_GetEventTime (EventRef inEvent);
// Wraps call to function 'SetEventTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetEventTime(ewg_param_inEvent, ewg_param_inTime) SetEventTime ((EventRef)ewg_param_inEvent, (EventTime)ewg_param_inTime)

OSStatus  ewg_function_SetEventTime (EventRef inEvent, EventTime inTime);
// Wraps call to function 'GetCurrentEventQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEventQueue GetCurrentEventQueue ()

EventQueueRef  ewg_function_GetCurrentEventQueue (void);
// Wraps call to function 'GetMainEventQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMainEventQueue GetMainEventQueue ()

EventQueueRef  ewg_function_GetMainEventQueue (void);
// Wraps call to function 'NewEventComparatorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewEventComparatorUPP(ewg_param_userRoutine) NewEventComparatorUPP ((EventComparatorProcPtr)ewg_param_userRoutine)

EventComparatorUPP  ewg_function_NewEventComparatorUPP (EventComparatorProcPtr userRoutine);
// Wraps call to function 'DisposeEventComparatorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeEventComparatorUPP(ewg_param_userUPP) DisposeEventComparatorUPP ((EventComparatorUPP)ewg_param_userUPP)

void  ewg_function_DisposeEventComparatorUPP (EventComparatorUPP userUPP);
// Wraps call to function 'InvokeEventComparatorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeEventComparatorUPP(ewg_param_inEvent, ewg_param_inCompareData, ewg_param_userUPP) InvokeEventComparatorUPP ((EventRef)ewg_param_inEvent, (void*)ewg_param_inCompareData, (EventComparatorUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeEventComparatorUPP (EventRef inEvent, void *inCompareData, EventComparatorUPP userUPP);
// Wraps call to function 'PostEventToQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PostEventToQueue(ewg_param_inQueue, ewg_param_inEvent, ewg_param_inPriority) PostEventToQueue ((EventQueueRef)ewg_param_inQueue, (EventRef)ewg_param_inEvent, (EventPriority)ewg_param_inPriority)

OSStatus  ewg_function_PostEventToQueue (EventQueueRef inQueue, EventRef inEvent, EventPriority inPriority);
// Wraps call to function 'FlushEventsMatchingListFromQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FlushEventsMatchingListFromQueue(ewg_param_inQueue, ewg_param_inNumTypes, ewg_param_inList) FlushEventsMatchingListFromQueue ((EventQueueRef)ewg_param_inQueue, (UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList)

OSStatus  ewg_function_FlushEventsMatchingListFromQueue (EventQueueRef inQueue, UInt32 inNumTypes, EventTypeSpec const *inList);
// Wraps call to function 'FlushSpecificEventsFromQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FlushSpecificEventsFromQueue(ewg_param_inQueue, ewg_param_inComparator, ewg_param_inCompareData) FlushSpecificEventsFromQueue ((EventQueueRef)ewg_param_inQueue, (EventComparatorUPP)ewg_param_inComparator, (void*)ewg_param_inCompareData)

OSStatus  ewg_function_FlushSpecificEventsFromQueue (EventQueueRef inQueue, EventComparatorUPP inComparator, void *inCompareData);
// Wraps call to function 'FlushEventQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FlushEventQueue(ewg_param_inQueue) FlushEventQueue ((EventQueueRef)ewg_param_inQueue)

OSStatus  ewg_function_FlushEventQueue (EventQueueRef inQueue);
// Wraps call to function 'FindSpecificEventInQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FindSpecificEventInQueue(ewg_param_inQueue, ewg_param_inComparator, ewg_param_inCompareData) FindSpecificEventInQueue ((EventQueueRef)ewg_param_inQueue, (EventComparatorUPP)ewg_param_inComparator, (void*)ewg_param_inCompareData)

EventRef  ewg_function_FindSpecificEventInQueue (EventQueueRef inQueue, EventComparatorUPP inComparator, void *inCompareData);
// Wraps call to function 'GetNumEventsInQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNumEventsInQueue(ewg_param_inQueue) GetNumEventsInQueue ((EventQueueRef)ewg_param_inQueue)

UInt32  ewg_function_GetNumEventsInQueue (EventQueueRef inQueue);
// Wraps call to function 'RemoveEventFromQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveEventFromQueue(ewg_param_inQueue, ewg_param_inEvent) RemoveEventFromQueue ((EventQueueRef)ewg_param_inQueue, (EventRef)ewg_param_inEvent)

OSStatus  ewg_function_RemoveEventFromQueue (EventQueueRef inQueue, EventRef inEvent);
// Wraps call to function 'IsEventInQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsEventInQueue(ewg_param_inQueue, ewg_param_inEvent) IsEventInQueue ((EventQueueRef)ewg_param_inQueue, (EventRef)ewg_param_inEvent)

Boolean  ewg_function_IsEventInQueue (EventQueueRef inQueue, EventRef inEvent);
// Wraps call to function 'AcquireFirstMatchingEventInQueue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AcquireFirstMatchingEventInQueue(ewg_param_inQueue, ewg_param_inNumTypes, ewg_param_inList, ewg_param_inOptions) AcquireFirstMatchingEventInQueue ((EventQueueRef)ewg_param_inQueue, (UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList, (OptionBits)ewg_param_inOptions)

EventRef  ewg_function_AcquireFirstMatchingEventInQueue (EventQueueRef inQueue, UInt32 inNumTypes, EventTypeSpec const *inList, OptionBits inOptions);
// Wraps call to function 'GetCurrentEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEvent GetCurrentEvent ()

EventRef  ewg_function_GetCurrentEvent (void);
// Wraps call to function 'GetCurrentEventButtonState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEventButtonState GetCurrentEventButtonState ()

UInt32  ewg_function_GetCurrentEventButtonState (void);
// Wraps call to function 'GetCurrentEventKeyModifiers' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEventKeyModifiers GetCurrentEventKeyModifiers ()

UInt32  ewg_function_GetCurrentEventKeyModifiers (void);
// Wraps call to function 'GetCurrentButtonState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentButtonState GetCurrentButtonState ()

UInt32  ewg_function_GetCurrentButtonState (void);
// Wraps call to function 'GetCurrentEventTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentEventTime GetCurrentEventTime ()

EventTime  ewg_function_GetCurrentEventTime (void);
// Wraps call to function 'NewEventLoopTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewEventLoopTimerUPP(ewg_param_userRoutine) NewEventLoopTimerUPP ((EventLoopTimerProcPtr)ewg_param_userRoutine)

EventLoopTimerUPP  ewg_function_NewEventLoopTimerUPP (EventLoopTimerProcPtr userRoutine);
// Wraps call to function 'NewEventLoopIdleTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewEventLoopIdleTimerUPP(ewg_param_userRoutine) NewEventLoopIdleTimerUPP ((EventLoopIdleTimerProcPtr)ewg_param_userRoutine)

EventLoopIdleTimerUPP  ewg_function_NewEventLoopIdleTimerUPP (EventLoopIdleTimerProcPtr userRoutine);
// Wraps call to function 'DisposeEventLoopTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeEventLoopTimerUPP(ewg_param_userUPP) DisposeEventLoopTimerUPP ((EventLoopTimerUPP)ewg_param_userUPP)

void  ewg_function_DisposeEventLoopTimerUPP (EventLoopTimerUPP userUPP);
// Wraps call to function 'DisposeEventLoopIdleTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeEventLoopIdleTimerUPP(ewg_param_userUPP) DisposeEventLoopIdleTimerUPP ((EventLoopIdleTimerUPP)ewg_param_userUPP)

void  ewg_function_DisposeEventLoopIdleTimerUPP (EventLoopIdleTimerUPP userUPP);
// Wraps call to function 'InvokeEventLoopTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeEventLoopTimerUPP(ewg_param_inTimer, ewg_param_inUserData, ewg_param_userUPP) InvokeEventLoopTimerUPP ((EventLoopTimerRef)ewg_param_inTimer, (void*)ewg_param_inUserData, (EventLoopTimerUPP)ewg_param_userUPP)

void  ewg_function_InvokeEventLoopTimerUPP (EventLoopTimerRef inTimer, void *inUserData, EventLoopTimerUPP userUPP);
// Wraps call to function 'InvokeEventLoopIdleTimerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeEventLoopIdleTimerUPP(ewg_param_inTimer, ewg_param_inState, ewg_param_inUserData, ewg_param_userUPP) InvokeEventLoopIdleTimerUPP ((EventLoopTimerRef)ewg_param_inTimer, (EventLoopIdleTimerMessage)ewg_param_inState, (void*)ewg_param_inUserData, (EventLoopIdleTimerUPP)ewg_param_userUPP)

void  ewg_function_InvokeEventLoopIdleTimerUPP (EventLoopTimerRef inTimer, EventLoopIdleTimerMessage inState, void *inUserData, EventLoopIdleTimerUPP userUPP);
// Wraps call to function 'InstallEventLoopTimer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InstallEventLoopTimer(ewg_param_inEventLoop, ewg_param_inFireDelay, ewg_param_inInterval, ewg_param_inTimerProc, ewg_param_inTimerData, ewg_param_outTimer) InstallEventLoopTimer ((EventLoopRef)ewg_param_inEventLoop, (EventTimerInterval)ewg_param_inFireDelay, (EventTimerInterval)ewg_param_inInterval, (EventLoopTimerUPP)ewg_param_inTimerProc, (void*)ewg_param_inTimerData, (EventLoopTimerRef*)ewg_param_outTimer)

OSStatus  ewg_function_InstallEventLoopTimer (EventLoopRef inEventLoop, EventTimerInterval inFireDelay, EventTimerInterval inInterval, EventLoopTimerUPP inTimerProc, void *inTimerData, EventLoopTimerRef *outTimer);
// Wraps call to function 'InstallEventLoopIdleTimer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InstallEventLoopIdleTimer(ewg_param_inEventLoop, ewg_param_inDelay, ewg_param_inInterval, ewg_param_inTimerProc, ewg_param_inTimerData, ewg_param_outTimer) InstallEventLoopIdleTimer ((EventLoopRef)ewg_param_inEventLoop, (EventTimerInterval)ewg_param_inDelay, (EventTimerInterval)ewg_param_inInterval, (EventLoopIdleTimerUPP)ewg_param_inTimerProc, (void*)ewg_param_inTimerData, (EventLoopTimerRef*)ewg_param_outTimer)

OSStatus  ewg_function_InstallEventLoopIdleTimer (EventLoopRef inEventLoop, EventTimerInterval inDelay, EventTimerInterval inInterval, EventLoopIdleTimerUPP inTimerProc, void *inTimerData, EventLoopTimerRef *outTimer);
// Wraps call to function 'RemoveEventLoopTimer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveEventLoopTimer(ewg_param_inTimer) RemoveEventLoopTimer ((EventLoopTimerRef)ewg_param_inTimer)

OSStatus  ewg_function_RemoveEventLoopTimer (EventLoopTimerRef inTimer);
// Wraps call to function 'SetEventLoopTimerNextFireTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetEventLoopTimerNextFireTime(ewg_param_inTimer, ewg_param_inNextFire) SetEventLoopTimerNextFireTime ((EventLoopTimerRef)ewg_param_inTimer, (EventTimerInterval)ewg_param_inNextFire)

OSStatus  ewg_function_SetEventLoopTimerNextFireTime (EventLoopTimerRef inTimer, EventTimerInterval inNextFire);
// Wraps call to function 'NewEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewEventHandlerUPP(ewg_param_userRoutine) NewEventHandlerUPP ((EventHandlerProcPtr)ewg_param_userRoutine)

EventHandlerUPP  ewg_function_NewEventHandlerUPP (EventHandlerProcPtr userRoutine);
// Wraps call to function 'DisposeEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeEventHandlerUPP(ewg_param_userUPP) DisposeEventHandlerUPP ((EventHandlerUPP)ewg_param_userUPP)

void  ewg_function_DisposeEventHandlerUPP (EventHandlerUPP userUPP);
// Wraps call to function 'InvokeEventHandlerUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeEventHandlerUPP(ewg_param_inHandlerCallRef, ewg_param_inEvent, ewg_param_inUserData, ewg_param_userUPP) InvokeEventHandlerUPP ((EventHandlerCallRef)ewg_param_inHandlerCallRef, (EventRef)ewg_param_inEvent, (void*)ewg_param_inUserData, (EventHandlerUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeEventHandlerUPP (EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData, EventHandlerUPP userUPP);
// Wraps call to function 'InstallEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InstallEventHandler(ewg_param_inTarget, ewg_param_inHandler, ewg_param_inNumTypes, ewg_param_inList, ewg_param_inUserData, ewg_param_outRef) InstallEventHandler ((EventTargetRef)ewg_param_inTarget, (EventHandlerUPP)ewg_param_inHandler, (UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList, (void*)ewg_param_inUserData, (EventHandlerRef*)ewg_param_outRef)

OSStatus  ewg_function_InstallEventHandler (EventTargetRef inTarget, EventHandlerUPP inHandler, UInt32 inNumTypes, EventTypeSpec const *inList, void *inUserData, EventHandlerRef *outRef);
// Wraps call to function 'InstallStandardEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InstallStandardEventHandler(ewg_param_inTarget) InstallStandardEventHandler ((EventTargetRef)ewg_param_inTarget)

OSStatus  ewg_function_InstallStandardEventHandler (EventTargetRef inTarget);
// Wraps call to function 'RemoveEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveEventHandler(ewg_param_inHandlerRef) RemoveEventHandler ((EventHandlerRef)ewg_param_inHandlerRef)

OSStatus  ewg_function_RemoveEventHandler (EventHandlerRef inHandlerRef);
// Wraps call to function 'AddEventTypesToHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AddEventTypesToHandler(ewg_param_inHandlerRef, ewg_param_inNumTypes, ewg_param_inList) AddEventTypesToHandler ((EventHandlerRef)ewg_param_inHandlerRef, (UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList)

OSStatus  ewg_function_AddEventTypesToHandler (EventHandlerRef inHandlerRef, UInt32 inNumTypes, EventTypeSpec const *inList);
// Wraps call to function 'RemoveEventTypesFromHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveEventTypesFromHandler(ewg_param_inHandlerRef, ewg_param_inNumTypes, ewg_param_inList) RemoveEventTypesFromHandler ((EventHandlerRef)ewg_param_inHandlerRef, (UInt32)ewg_param_inNumTypes, (EventTypeSpec const*)ewg_param_inList)

OSStatus  ewg_function_RemoveEventTypesFromHandler (EventHandlerRef inHandlerRef, UInt32 inNumTypes, EventTypeSpec const *inList);
// Wraps call to function 'CallNextEventHandler' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CallNextEventHandler(ewg_param_inCallRef, ewg_param_inEvent) CallNextEventHandler ((EventHandlerCallRef)ewg_param_inCallRef, (EventRef)ewg_param_inEvent)

OSStatus  ewg_function_CallNextEventHandler (EventHandlerCallRef inCallRef, EventRef inEvent);
// Wraps call to function 'SendEventToEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SendEventToEventTarget(ewg_param_inEvent, ewg_param_inTarget) SendEventToEventTarget ((EventRef)ewg_param_inEvent, (EventTargetRef)ewg_param_inTarget)

OSStatus  ewg_function_SendEventToEventTarget (EventRef inEvent, EventTargetRef inTarget);
// Wraps call to function 'SendEventToEventTargetWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SendEventToEventTargetWithOptions(ewg_param_inEvent, ewg_param_inTarget, ewg_param_inOptions) SendEventToEventTargetWithOptions ((EventRef)ewg_param_inEvent, (EventTargetRef)ewg_param_inTarget, (OptionBits)ewg_param_inOptions)

OSStatus  ewg_function_SendEventToEventTargetWithOptions (EventRef inEvent, EventTargetRef inTarget, OptionBits inOptions);
// Wraps call to function 'EnableSecureEventInput' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableSecureEventInput EnableSecureEventInput ()

OSStatus  ewg_function_EnableSecureEventInput (void);
// Wraps call to function 'DisableSecureEventInput' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableSecureEventInput DisableSecureEventInput ()

OSStatus  ewg_function_DisableSecureEventInput (void);
// Wraps call to function 'IsSecureEventInputEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsSecureEventInputEnabled IsSecureEventInputEnabled ()

Boolean  ewg_function_IsSecureEventInputEnabled (void);
// Wraps call to function 'HIObjectRegisterSubclass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectRegisterSubclass(ewg_param_inClassID, ewg_param_inBaseClassID, ewg_param_inOptions, ewg_param_inConstructProc, ewg_param_inNumEvents, ewg_param_inEventList, ewg_param_inConstructData, ewg_param_outClassRef) HIObjectRegisterSubclass ((CFStringRef)ewg_param_inClassID, (CFStringRef)ewg_param_inBaseClassID, (OptionBits)ewg_param_inOptions, (EventHandlerUPP)ewg_param_inConstructProc, (UInt32)ewg_param_inNumEvents, (EventTypeSpec const*)ewg_param_inEventList, (void*)ewg_param_inConstructData, (HIObjectClassRef*)ewg_param_outClassRef)

OSStatus  ewg_function_HIObjectRegisterSubclass (CFStringRef inClassID, CFStringRef inBaseClassID, OptionBits inOptions, EventHandlerUPP inConstructProc, UInt32 inNumEvents, EventTypeSpec const *inEventList, void *inConstructData, HIObjectClassRef *outClassRef);
// Wraps call to function 'HIObjectUnregisterClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectUnregisterClass(ewg_param_inClassRef) HIObjectUnregisterClass ((HIObjectClassRef)ewg_param_inClassRef)

OSStatus  ewg_function_HIObjectUnregisterClass (HIObjectClassRef inClassRef);
// Wraps call to function 'HIObjectCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectCreate(ewg_param_inClassID, ewg_param_inConstructData, ewg_param_outObject) HIObjectCreate ((CFStringRef)ewg_param_inClassID, (EventRef)ewg_param_inConstructData, (HIObjectRef*)ewg_param_outObject)

OSStatus  ewg_function_HIObjectCreate (CFStringRef inClassID, EventRef inConstructData, HIObjectRef *outObject);
// Wraps call to function 'HIObjectGetEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectGetEventTarget(ewg_param_inObject) HIObjectGetEventTarget ((HIObjectRef)ewg_param_inObject)

EventTargetRef  ewg_function_HIObjectGetEventTarget (HIObjectRef inObject);
// Wraps call to function 'HIObjectPrintDebugInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectPrintDebugInfo(ewg_param_inObject) HIObjectPrintDebugInfo ((HIObjectRef)ewg_param_inObject)

void  ewg_function_HIObjectPrintDebugInfo (HIObjectRef inObject);
// Wraps call to function 'HIObjectCopyClassID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectCopyClassID(ewg_param_inObject) HIObjectCopyClassID ((HIObjectRef)ewg_param_inObject)

CFStringRef  ewg_function_HIObjectCopyClassID (HIObjectRef inObject);
// Wraps call to function 'HIObjectIsOfClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectIsOfClass(ewg_param_inObject, ewg_param_inObjectClassID) HIObjectIsOfClass ((HIObjectRef)ewg_param_inObject, (CFStringRef)ewg_param_inObjectClassID)

Boolean  ewg_function_HIObjectIsOfClass (HIObjectRef inObject, CFStringRef inObjectClassID);
// Wraps call to function 'HIObjectDynamicCast' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectDynamicCast(ewg_param_inObject, ewg_param_inClassID) HIObjectDynamicCast ((HIObjectRef)ewg_param_inObject, (CFStringRef)ewg_param_inClassID)

void * ewg_function_HIObjectDynamicCast (HIObjectRef inObject, CFStringRef inClassID);
// Wraps call to function 'HIObjectCreateFromBundle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectCreateFromBundle(ewg_param_inBundle, ewg_param_outObject) HIObjectCreateFromBundle ((CFBundleRef)ewg_param_inBundle, (HIObjectRef*)ewg_param_outObject)

OSStatus  ewg_function_HIObjectCreateFromBundle (CFBundleRef inBundle, HIObjectRef *outObject);
// Wraps call to function 'HIObjectIsAccessibilityIgnored' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectIsAccessibilityIgnored(ewg_param_inObject) HIObjectIsAccessibilityIgnored ((HIObjectRef)ewg_param_inObject)

Boolean  ewg_function_HIObjectIsAccessibilityIgnored (HIObjectRef inObject);
// Wraps call to function 'HIObjectSetAccessibilityIgnored' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectSetAccessibilityIgnored(ewg_param_inObject, ewg_param_inIgnored) HIObjectSetAccessibilityIgnored ((HIObjectRef)ewg_param_inObject, (Boolean)ewg_param_inIgnored)

OSStatus  ewg_function_HIObjectSetAccessibilityIgnored (HIObjectRef inObject, Boolean inIgnored);
// Wraps call to function 'HIObjectSetAuxiliaryAccessibilityAttribute' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectSetAuxiliaryAccessibilityAttribute(ewg_param_inHIObject, ewg_param_inIdentifier, ewg_param_inAttributeName, ewg_param_inAttributeData) HIObjectSetAuxiliaryAccessibilityAttribute ((HIObjectRef)ewg_param_inHIObject, (UInt64)ewg_param_inIdentifier, (CFStringRef)ewg_param_inAttributeName, (CFTypeRef)ewg_param_inAttributeData)

OSStatus  ewg_function_HIObjectSetAuxiliaryAccessibilityAttribute (HIObjectRef inHIObject, UInt64 inIdentifier, CFStringRef inAttributeName, CFTypeRef inAttributeData);
// Wraps call to function 'HIObjectOverrideAccessibilityContainment' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectOverrideAccessibilityContainment(ewg_param_inHIObject, ewg_param_inDesiredParent, ewg_param_inDesiredWindow, ewg_param_inDesiredTopLevelUIElement) HIObjectOverrideAccessibilityContainment ((HIObjectRef)ewg_param_inHIObject, (AXUIElementRef)ewg_param_inDesiredParent, (AXUIElementRef)ewg_param_inDesiredWindow, (AXUIElementRef)ewg_param_inDesiredTopLevelUIElement)

OSStatus  ewg_function_HIObjectOverrideAccessibilityContainment (HIObjectRef inHIObject, AXUIElementRef inDesiredParent, AXUIElementRef inDesiredWindow, AXUIElementRef inDesiredTopLevelUIElement);
// Wraps call to function 'HIObjectIsArchivingIgnored' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectIsArchivingIgnored(ewg_param_inObject) HIObjectIsArchivingIgnored ((HIObjectRef)ewg_param_inObject)

Boolean  ewg_function_HIObjectIsArchivingIgnored (HIObjectRef inObject);
// Wraps call to function 'HIObjectSetArchivingIgnored' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectSetArchivingIgnored(ewg_param_inObject, ewg_param_inIgnored) HIObjectSetArchivingIgnored ((HIObjectRef)ewg_param_inObject, (Boolean)ewg_param_inIgnored)

OSStatus  ewg_function_HIObjectSetArchivingIgnored (HIObjectRef inObject, Boolean inIgnored);
// Wraps call to function 'HIObjectCopyCustomArchiveData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectCopyCustomArchiveData(ewg_param_inObject, ewg_param_outCustomData) HIObjectCopyCustomArchiveData ((HIObjectRef)ewg_param_inObject, (CFDictionaryRef*)ewg_param_outCustomData)

OSStatus  ewg_function_HIObjectCopyCustomArchiveData (HIObjectRef inObject, CFDictionaryRef *outCustomData);
// Wraps call to function 'HIObjectSetCustomArchiveData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIObjectSetCustomArchiveData(ewg_param_inObject, ewg_param_inCustomData) HIObjectSetCustomArchiveData ((HIObjectRef)ewg_param_inObject, (CFDictionaryRef)ewg_param_inCustomData)

OSStatus  ewg_function_HIObjectSetCustomArchiveData (HIObjectRef inObject, CFDictionaryRef inCustomData);
// Wraps call to function 'HIGetScaleFactor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIGetScaleFactor HIGetScaleFactor ()

float  ewg_function_HIGetScaleFactor (void);
// Wraps call to function 'HIPointConvert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIPointConvert(ewg_param_ioPoint, ewg_param_inSourceSpace, ewg_param_inSourceObject, ewg_param_inDestinationSpace, ewg_param_inDestinationObject) HIPointConvert ((HIPoint*)ewg_param_ioPoint, (HICoordinateSpace)ewg_param_inSourceSpace, (void*)ewg_param_inSourceObject, (HICoordinateSpace)ewg_param_inDestinationSpace, (void*)ewg_param_inDestinationObject)

void  ewg_function_HIPointConvert (HIPoint *ioPoint, HICoordinateSpace inSourceSpace, void *inSourceObject, HICoordinateSpace inDestinationSpace, void *inDestinationObject);
// Wraps call to function 'HIRectConvert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIRectConvert(ewg_param_ioRect, ewg_param_inSourceSpace, ewg_param_inSourceObject, ewg_param_inDestinationSpace, ewg_param_inDestinationObject) HIRectConvert ((HIRect*)ewg_param_ioRect, (HICoordinateSpace)ewg_param_inSourceSpace, (void*)ewg_param_inSourceObject, (HICoordinateSpace)ewg_param_inDestinationSpace, (void*)ewg_param_inDestinationObject)

void  ewg_function_HIRectConvert (HIRect *ioRect, HICoordinateSpace inSourceSpace, void *inSourceObject, HICoordinateSpace inDestinationSpace, void *inDestinationObject);
// Wraps call to function 'HISizeConvert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISizeConvert(ewg_param_ioSize, ewg_param_inSourceSpace, ewg_param_inSourceObject, ewg_param_inDestinationSpace, ewg_param_inDestinationObject) HISizeConvert ((HISize*)ewg_param_ioSize, (HICoordinateSpace)ewg_param_inSourceSpace, (void*)ewg_param_inSourceObject, (HICoordinateSpace)ewg_param_inDestinationSpace, (void*)ewg_param_inDestinationObject)

void  ewg_function_HISizeConvert (HISize *ioSize, HICoordinateSpace inSourceSpace, void *inSourceObject, HICoordinateSpace inDestinationSpace, void *inDestinationObject);
// Wraps call to function 'GetMouse' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMouse(ewg_param_mouseLoc) GetMouse ((Point*)ewg_param_mouseLoc)

void  ewg_function_GetMouse (Point *mouseLoc);
// Wraps call to function 'Button' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_Button Button ()

Boolean  ewg_function_Button (void);
// Wraps call to function 'StillDown' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_StillDown StillDown ()

Boolean  ewg_function_StillDown (void);
// Wraps call to function 'WaitMouseUp' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_WaitMouseUp WaitMouseUp ()

Boolean  ewg_function_WaitMouseUp (void);
// Wraps call to function 'KeyTranslate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_KeyTranslate(ewg_param_transData, ewg_param_keycode, ewg_param_state) KeyTranslate ((void const*)ewg_param_transData, (UInt16)ewg_param_keycode, (UInt32*)ewg_param_state)

UInt32  ewg_function_KeyTranslate (void const *transData, UInt16 keycode, UInt32 *state);
// Wraps call to function 'GetCaretTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCaretTime GetCaretTime ()

UInt32  ewg_function_GetCaretTime (void);
// Wraps call to function 'GetKeys' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetKeys(ewg_param_theKeys) GetKeys (ewg_param_theKeys)

void  ewg_function_GetKeys (void *theKeys);
// Wraps call to function 'GetDblTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDblTime GetDblTime ()

UInt32  ewg_function_GetDblTime (void);
// Wraps call to function 'SetEventMask' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetEventMask(ewg_param_value) SetEventMask ((EventMask)ewg_param_value)

void  ewg_function_SetEventMask (EventMask value);
// Wraps call to function 'GetNextEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNextEvent(ewg_param_eventMask, ewg_param_theEvent) GetNextEvent ((EventMask)ewg_param_eventMask, (EventRecord*)ewg_param_theEvent)

Boolean  ewg_function_GetNextEvent (EventMask eventMask, EventRecord *theEvent);
// Wraps call to function 'WaitNextEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_WaitNextEvent(ewg_param_eventMask, ewg_param_theEvent, ewg_param_sleep, ewg_param_mouseRgn) WaitNextEvent ((EventMask)ewg_param_eventMask, (EventRecord*)ewg_param_theEvent, (UInt32)ewg_param_sleep, (RgnHandle)ewg_param_mouseRgn)

Boolean  ewg_function_WaitNextEvent (EventMask eventMask, EventRecord *theEvent, UInt32 sleep, RgnHandle mouseRgn);
// Wraps call to function 'EventAvail' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EventAvail(ewg_param_eventMask, ewg_param_theEvent) EventAvail ((EventMask)ewg_param_eventMask, (EventRecord*)ewg_param_theEvent)

Boolean  ewg_function_EventAvail (EventMask eventMask, EventRecord *theEvent);
// Wraps call to function 'PostEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PostEvent(ewg_param_eventNum, ewg_param_eventMsg) PostEvent ((EventKind)ewg_param_eventNum, (UInt32)ewg_param_eventMsg)

OSErr  ewg_function_PostEvent (EventKind eventNum, UInt32 eventMsg);
// Wraps call to function 'FlushEvents' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FlushEvents(ewg_param_whichMask, ewg_param_stopMask) FlushEvents ((EventMask)ewg_param_whichMask, (EventMask)ewg_param_stopMask)

void  ewg_function_FlushEvents (EventMask whichMask, EventMask stopMask);
// Wraps call to function 'GetGlobalMouse' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetGlobalMouse(ewg_param_globalMouse) GetGlobalMouse ((Point*)ewg_param_globalMouse)

void  ewg_function_GetGlobalMouse (Point *globalMouse);
// Wraps call to function 'GetCurrentKeyModifiers' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetCurrentKeyModifiers GetCurrentKeyModifiers ()

UInt32  ewg_function_GetCurrentKeyModifiers (void);
// Wraps call to function 'CheckEventQueueForUserCancel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CheckEventQueueForUserCancel CheckEventQueueForUserCancel ()

Boolean  ewg_function_CheckEventQueueForUserCancel (void);
// Wraps call to function 'KeyScript' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_KeyScript(ewg_param_code) KeyScript ((short)ewg_param_code)

void  ewg_function_KeyScript (short code);
// Wraps call to function 'IsCmdChar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsCmdChar(ewg_param_event, ewg_param_test) IsCmdChar ((EventRecord const*)ewg_param_event, (short)ewg_param_test)

Boolean  ewg_function_IsCmdChar (EventRecord const *event, short test);
// Wraps call to function 'LMGetKeyThresh' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMGetKeyThresh LMGetKeyThresh ()

SInt16  ewg_function_LMGetKeyThresh (void);
// Wraps call to function 'LMSetKeyThresh' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMSetKeyThresh(ewg_param_value) LMSetKeyThresh ((SInt16)ewg_param_value)

void  ewg_function_LMSetKeyThresh (SInt16 value);
// Wraps call to function 'LMGetKeyRepThresh' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMGetKeyRepThresh LMGetKeyRepThresh ()

SInt16  ewg_function_LMGetKeyRepThresh (void);
// Wraps call to function 'LMSetKeyRepThresh' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMSetKeyRepThresh(ewg_param_value) LMSetKeyRepThresh ((SInt16)ewg_param_value)

void  ewg_function_LMSetKeyRepThresh (SInt16 value);
// Wraps call to function 'LMGetKbdLast' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMGetKbdLast LMGetKbdLast ()

UInt8  ewg_function_LMGetKbdLast (void);
// Wraps call to function 'LMSetKbdLast' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMSetKbdLast(ewg_param_value) LMSetKbdLast ((UInt8)ewg_param_value)

void  ewg_function_LMSetKbdLast (UInt8 value);
// Wraps call to function 'LMGetKbdType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMGetKbdType LMGetKbdType ()

UInt8  ewg_function_LMGetKbdType (void);
// Wraps call to function 'LMSetKbdType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMSetKbdType(ewg_param_value) LMSetKbdType ((UInt8)ewg_param_value)

void  ewg_function_LMSetKbdType (UInt8 value);
// Wraps call to function 'NewMenuDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewMenuDefUPP(ewg_param_userRoutine) NewMenuDefUPP ((MenuDefProcPtr)ewg_param_userRoutine)

MenuDefUPP  ewg_function_NewMenuDefUPP (MenuDefProcPtr userRoutine);
// Wraps call to function 'DisposeMenuDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeMenuDefUPP(ewg_param_userUPP) DisposeMenuDefUPP ((MenuDefUPP)ewg_param_userUPP)

void  ewg_function_DisposeMenuDefUPP (MenuDefUPP userUPP);
// Wraps call to function 'InvokeMenuDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeMenuDefUPP(ewg_param_message, ewg_param_theMenu, ewg_param_menuRect, ewg_param_hitPt, ewg_param_whichItem, ewg_param_userUPP) InvokeMenuDefUPP ((short)ewg_param_message, (MenuRef)ewg_param_theMenu, (Rect*)ewg_param_menuRect, *(Point*)ewg_param_hitPt, (short*)ewg_param_whichItem, (MenuDefUPP)ewg_param_userUPP)

void  ewg_function_InvokeMenuDefUPP (short message, MenuRef theMenu, Rect *menuRect, Point *hitPt, short *whichItem, MenuDefUPP userUPP);
// Wraps call to function 'NewMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewMenu(ewg_param_menuID, ewg_param_menuTitle) NewMenu ((MenuID)ewg_param_menuID, (ConstStr255Param)ewg_param_menuTitle)

MenuRef  ewg_function_NewMenu (MenuID menuID, ConstStr255Param menuTitle);
// Wraps call to function 'GetMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenu(ewg_param_resourceID) GetMenu ((short)ewg_param_resourceID)

MenuRef  ewg_function_GetMenu (short resourceID);
// Wraps call to function 'DisposeMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeMenu(ewg_param_theMenu) DisposeMenu ((MenuRef)ewg_param_theMenu)

void  ewg_function_DisposeMenu (MenuRef theMenu);
// Wraps call to function 'CalcMenuSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CalcMenuSize(ewg_param_theMenu) CalcMenuSize ((MenuRef)ewg_param_theMenu)

void  ewg_function_CalcMenuSize (MenuRef theMenu);
// Wraps call to function 'CountMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CountMenuItems(ewg_param_theMenu) CountMenuItems ((MenuRef)ewg_param_theMenu)

UInt16  ewg_function_CountMenuItems (MenuRef theMenu);
// Wraps call to function 'GetMenuFont' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuFont(ewg_param_menu, ewg_param_outFontID, ewg_param_outFontSize) GetMenuFont ((MenuRef)ewg_param_menu, (SInt16*)ewg_param_outFontID, (UInt16*)ewg_param_outFontSize)

OSStatus  ewg_function_GetMenuFont (MenuRef menu, SInt16 *outFontID, UInt16 *outFontSize);
// Wraps call to function 'SetMenuFont' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuFont(ewg_param_menu, ewg_param_inFontID, ewg_param_inFontSize) SetMenuFont ((MenuRef)ewg_param_menu, (SInt16)ewg_param_inFontID, (UInt16)ewg_param_inFontSize)

OSStatus  ewg_function_SetMenuFont (MenuRef menu, SInt16 inFontID, UInt16 inFontSize);
// Wraps call to function 'GetMenuExcludesMarkColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuExcludesMarkColumn(ewg_param_menu) GetMenuExcludesMarkColumn ((MenuRef)ewg_param_menu)

Boolean  ewg_function_GetMenuExcludesMarkColumn (MenuRef menu);
// Wraps call to function 'SetMenuExcludesMarkColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuExcludesMarkColumn(ewg_param_menu, ewg_param_excludesMark) SetMenuExcludesMarkColumn ((MenuRef)ewg_param_menu, (Boolean)ewg_param_excludesMark)

OSStatus  ewg_function_SetMenuExcludesMarkColumn (MenuRef menu, Boolean excludesMark);
// Wraps call to function 'RegisterMenuDefinition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RegisterMenuDefinition(ewg_param_inResID, ewg_param_inDefSpec) RegisterMenuDefinition ((SInt16)ewg_param_inResID, (MenuDefSpecPtr)ewg_param_inDefSpec)

OSStatus  ewg_function_RegisterMenuDefinition (SInt16 inResID, MenuDefSpecPtr inDefSpec);
// Wraps call to function 'CreateNewMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateNewMenu(ewg_param_inMenuID, ewg_param_inMenuAttributes, ewg_param_outMenuRef) CreateNewMenu ((MenuID)ewg_param_inMenuID, (MenuAttributes)ewg_param_inMenuAttributes, (MenuRef*)ewg_param_outMenuRef)

OSStatus  ewg_function_CreateNewMenu (MenuID inMenuID, MenuAttributes inMenuAttributes, MenuRef *outMenuRef);
// Wraps call to function 'CreateCustomMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateCustomMenu(ewg_param_inDefSpec, ewg_param_inMenuID, ewg_param_inMenuAttributes, ewg_param_outMenuRef) CreateCustomMenu ((MenuDefSpec const*)ewg_param_inDefSpec, (MenuID)ewg_param_inMenuID, (MenuAttributes)ewg_param_inMenuAttributes, (MenuRef*)ewg_param_outMenuRef)

OSStatus  ewg_function_CreateCustomMenu (MenuDefSpec const *inDefSpec, MenuID inMenuID, MenuAttributes inMenuAttributes, MenuRef *outMenuRef);
// Wraps call to function 'IsValidMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsValidMenu(ewg_param_inMenu) IsValidMenu ((MenuRef)ewg_param_inMenu)

Boolean  ewg_function_IsValidMenu (MenuRef inMenu);
// Wraps call to function 'GetMenuRetainCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuRetainCount(ewg_param_inMenu) GetMenuRetainCount ((MenuRef)ewg_param_inMenu)

ItemCount  ewg_function_GetMenuRetainCount (MenuRef inMenu);
// Wraps call to function 'RetainMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RetainMenu(ewg_param_inMenu) RetainMenu ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_RetainMenu (MenuRef inMenu);
// Wraps call to function 'ReleaseMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseMenu(ewg_param_inMenu) ReleaseMenu ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_ReleaseMenu (MenuRef inMenu);
// Wraps call to function 'DuplicateMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DuplicateMenu(ewg_param_inSourceMenu, ewg_param_outMenu) DuplicateMenu ((MenuRef)ewg_param_inSourceMenu, (MenuRef*)ewg_param_outMenu)

OSStatus  ewg_function_DuplicateMenu (MenuRef inSourceMenu, MenuRef *outMenu);
// Wraps call to function 'CopyMenuTitleAsCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyMenuTitleAsCFString(ewg_param_inMenu, ewg_param_outString) CopyMenuTitleAsCFString ((MenuRef)ewg_param_inMenu, (CFStringRef*)ewg_param_outString)

OSStatus  ewg_function_CopyMenuTitleAsCFString (MenuRef inMenu, CFStringRef *outString);
// Wraps call to function 'SetMenuTitleWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuTitleWithCFString(ewg_param_inMenu, ewg_param_inString) SetMenuTitleWithCFString ((MenuRef)ewg_param_inMenu, (CFStringRef)ewg_param_inString)

OSStatus  ewg_function_SetMenuTitleWithCFString (MenuRef inMenu, CFStringRef inString);
// Wraps call to function 'SetMenuTitleIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuTitleIcon(ewg_param_inMenu, ewg_param_inType, ewg_param_inIcon) SetMenuTitleIcon ((MenuRef)ewg_param_inMenu, (UInt32)ewg_param_inType, (void*)ewg_param_inIcon)

OSStatus  ewg_function_SetMenuTitleIcon (MenuRef inMenu, UInt32 inType, void *inIcon);
// Wraps call to function 'GetMenuTitleIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuTitleIcon(ewg_param_inMenu, ewg_param_outType, ewg_param_outIcon) GetMenuTitleIcon ((MenuRef)ewg_param_inMenu, (UInt32*)ewg_param_outType, (void**)ewg_param_outIcon)

OSStatus  ewg_function_GetMenuTitleIcon (MenuRef inMenu, UInt32 *outType, void **outIcon);
// Wraps call to function 'InvalidateMenuSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalidateMenuSize(ewg_param_inMenu) InvalidateMenuSize ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_InvalidateMenuSize (MenuRef inMenu);
// Wraps call to function 'IsMenuSizeInvalid' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuSizeInvalid(ewg_param_inMenu) IsMenuSizeInvalid ((MenuRef)ewg_param_inMenu)

Boolean  ewg_function_IsMenuSizeInvalid (MenuRef inMenu);
// Wraps call to function 'EraseMenuBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EraseMenuBackground(ewg_param_inMenu, ewg_param_inEraseRect, ewg_param_inContext) EraseMenuBackground ((MenuRef)ewg_param_inMenu, (Rect const*)ewg_param_inEraseRect, (CGContextRef)ewg_param_inContext)

OSStatus  ewg_function_EraseMenuBackground (MenuRef inMenu, Rect const *inEraseRect, CGContextRef inContext);
// Wraps call to function 'ScrollMenuImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ScrollMenuImage(ewg_param_inMenu, ewg_param_inScrollRect, ewg_param_inHScroll, ewg_param_inVScroll, ewg_param_inContext) ScrollMenuImage ((MenuRef)ewg_param_inMenu, (Rect const*)ewg_param_inScrollRect, (int)ewg_param_inHScroll, (int)ewg_param_inVScroll, (CGContextRef)ewg_param_inContext)

OSStatus  ewg_function_ScrollMenuImage (MenuRef inMenu, Rect const *inScrollRect, int inHScroll, int inVScroll, CGContextRef inContext);
// Wraps call to function 'AppendMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AppendMenu(ewg_param_menu, ewg_param_data) AppendMenu ((MenuRef)ewg_param_menu, (ConstStr255Param)ewg_param_data)

void  ewg_function_AppendMenu (MenuRef menu, ConstStr255Param data);
// Wraps call to function 'InsertResMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertResMenu(ewg_param_theMenu, ewg_param_theType, ewg_param_afterItem) InsertResMenu ((MenuRef)ewg_param_theMenu, (ResType)ewg_param_theType, (MenuItemIndex)ewg_param_afterItem)

void  ewg_function_InsertResMenu (MenuRef theMenu, ResType theType, MenuItemIndex afterItem);
// Wraps call to function 'AppendResMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AppendResMenu(ewg_param_theMenu, ewg_param_theType) AppendResMenu ((MenuRef)ewg_param_theMenu, (ResType)ewg_param_theType)

void  ewg_function_AppendResMenu (MenuRef theMenu, ResType theType);
// Wraps call to function 'InsertMenuItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertMenuItem(ewg_param_theMenu, ewg_param_itemString, ewg_param_afterItem) InsertMenuItem ((MenuRef)ewg_param_theMenu, (ConstStr255Param)ewg_param_itemString, (MenuItemIndex)ewg_param_afterItem)

void  ewg_function_InsertMenuItem (MenuRef theMenu, ConstStr255Param itemString, MenuItemIndex afterItem);
// Wraps call to function 'DeleteMenuItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DeleteMenuItem(ewg_param_theMenu, ewg_param_item) DeleteMenuItem ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item)

void  ewg_function_DeleteMenuItem (MenuRef theMenu, MenuItemIndex item);
// Wraps call to function 'InsertFontResMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertFontResMenu(ewg_param_theMenu, ewg_param_afterItem, ewg_param_scriptFilter) InsertFontResMenu ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_afterItem, (short)ewg_param_scriptFilter)

void  ewg_function_InsertFontResMenu (MenuRef theMenu, MenuItemIndex afterItem, short scriptFilter);
// Wraps call to function 'InsertIntlResMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertIntlResMenu(ewg_param_theMenu, ewg_param_theType, ewg_param_afterItem, ewg_param_scriptFilter) InsertIntlResMenu ((MenuRef)ewg_param_theMenu, (ResType)ewg_param_theType, (MenuItemIndex)ewg_param_afterItem, (short)ewg_param_scriptFilter)

void  ewg_function_InsertIntlResMenu (MenuRef theMenu, ResType theType, MenuItemIndex afterItem, short scriptFilter);
// Wraps call to function 'AppendMenuItemText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AppendMenuItemText(ewg_param_menu, ewg_param_inString) AppendMenuItemText ((MenuRef)ewg_param_menu, (ConstStr255Param)ewg_param_inString)

OSStatus  ewg_function_AppendMenuItemText (MenuRef menu, ConstStr255Param inString);
// Wraps call to function 'InsertMenuItemText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertMenuItemText(ewg_param_menu, ewg_param_inString, ewg_param_afterItem) InsertMenuItemText ((MenuRef)ewg_param_menu, (ConstStr255Param)ewg_param_inString, (MenuItemIndex)ewg_param_afterItem)

OSStatus  ewg_function_InsertMenuItemText (MenuRef menu, ConstStr255Param inString, MenuItemIndex afterItem);
// Wraps call to function 'CopyMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyMenuItems(ewg_param_inSourceMenu, ewg_param_inFirstItem, ewg_param_inNumItems, ewg_param_inDestMenu, ewg_param_inInsertAfter) CopyMenuItems ((MenuRef)ewg_param_inSourceMenu, (MenuItemIndex)ewg_param_inFirstItem, (ItemCount)ewg_param_inNumItems, (MenuRef)ewg_param_inDestMenu, (MenuItemIndex)ewg_param_inInsertAfter)

OSStatus  ewg_function_CopyMenuItems (MenuRef inSourceMenu, MenuItemIndex inFirstItem, ItemCount inNumItems, MenuRef inDestMenu, MenuItemIndex inInsertAfter);
// Wraps call to function 'DeleteMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DeleteMenuItems(ewg_param_inMenu, ewg_param_inFirstItem, ewg_param_inNumItems) DeleteMenuItems ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inFirstItem, (ItemCount)ewg_param_inNumItems)

OSStatus  ewg_function_DeleteMenuItems (MenuRef inMenu, MenuItemIndex inFirstItem, ItemCount inNumItems);
// Wraps call to function 'AppendMenuItemTextWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AppendMenuItemTextWithCFString(ewg_param_inMenu, ewg_param_inString, ewg_param_inAttributes, ewg_param_inCommandID, ewg_param_outNewItem) AppendMenuItemTextWithCFString ((MenuRef)ewg_param_inMenu, (CFStringRef)ewg_param_inString, (MenuItemAttributes)ewg_param_inAttributes, (MenuCommand)ewg_param_inCommandID, (MenuItemIndex*)ewg_param_outNewItem)

OSStatus  ewg_function_AppendMenuItemTextWithCFString (MenuRef inMenu, CFStringRef inString, MenuItemAttributes inAttributes, MenuCommand inCommandID, MenuItemIndex *outNewItem);
// Wraps call to function 'InsertMenuItemTextWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertMenuItemTextWithCFString(ewg_param_inMenu, ewg_param_inString, ewg_param_inAfterItem, ewg_param_inAttributes, ewg_param_inCommandID) InsertMenuItemTextWithCFString ((MenuRef)ewg_param_inMenu, (CFStringRef)ewg_param_inString, (MenuItemIndex)ewg_param_inAfterItem, (MenuItemAttributes)ewg_param_inAttributes, (MenuCommand)ewg_param_inCommandID)

OSStatus  ewg_function_InsertMenuItemTextWithCFString (MenuRef inMenu, CFStringRef inString, MenuItemIndex inAfterItem, MenuItemAttributes inAttributes, MenuCommand inCommandID);
// Wraps call to function 'MenuKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MenuKey(ewg_param_ch) MenuKey ((CharParameter)ewg_param_ch)

long  ewg_function_MenuKey (CharParameter ch);
// Wraps call to function 'MenuSelect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MenuSelect(ewg_param_startPt) MenuSelect (*(Point*)ewg_param_startPt)

long  ewg_function_MenuSelect (Point *startPt);
// Wraps call to function 'PopUpMenuSelect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PopUpMenuSelect(ewg_param_menu, ewg_param_top, ewg_param_left, ewg_param_popUpItem) PopUpMenuSelect ((MenuRef)ewg_param_menu, (short)ewg_param_top, (short)ewg_param_left, (MenuItemIndex)ewg_param_popUpItem)

long  ewg_function_PopUpMenuSelect (MenuRef menu, short top, short left, MenuItemIndex popUpItem);
// Wraps call to function 'MenuChoice' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MenuChoice MenuChoice ()

long  ewg_function_MenuChoice (void);
// Wraps call to function 'MenuEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MenuEvent(ewg_param_inEvent) MenuEvent ((EventRecord const*)ewg_param_inEvent)

UInt32  ewg_function_MenuEvent (EventRecord const *inEvent);
// Wraps call to function 'IsMenuKeyEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuKeyEvent(ewg_param_inStartMenu, ewg_param_inEvent, ewg_param_inOptions, ewg_param_outMenu, ewg_param_outMenuItem) IsMenuKeyEvent ((MenuRef)ewg_param_inStartMenu, (EventRef)ewg_param_inEvent, (MenuEventOptions)ewg_param_inOptions, (MenuRef*)ewg_param_outMenu, (MenuItemIndex*)ewg_param_outMenuItem)

Boolean  ewg_function_IsMenuKeyEvent (MenuRef inStartMenu, EventRef inEvent, MenuEventOptions inOptions, MenuRef *outMenu, MenuItemIndex *outMenuItem);
// Wraps call to function 'InvalidateMenuEnabling' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalidateMenuEnabling(ewg_param_inMenu) InvalidateMenuEnabling ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_InvalidateMenuEnabling (MenuRef inMenu);
// Wraps call to function 'CancelMenuTracking' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CancelMenuTracking(ewg_param_inRootMenu, ewg_param_inImmediate, ewg_param_inDismissalReason) CancelMenuTracking ((MenuRef)ewg_param_inRootMenu, (Boolean)ewg_param_inImmediate, (UInt32)ewg_param_inDismissalReason)

OSStatus  ewg_function_CancelMenuTracking (MenuRef inRootMenu, Boolean inImmediate, UInt32 inDismissalReason);
// Wraps call to function 'GetMBarHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMBarHeight GetMBarHeight ()

short  ewg_function_GetMBarHeight (void);
// Wraps call to function 'DrawMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DrawMenuBar DrawMenuBar ()

void  ewg_function_DrawMenuBar (void);
// Wraps call to function 'InvalMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalMenuBar InvalMenuBar ()

void  ewg_function_InvalMenuBar (void);
// Wraps call to function 'IsMenuBarInvalid' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuBarInvalid(ewg_param_rootMenu) IsMenuBarInvalid ((MenuRef)ewg_param_rootMenu)

Boolean  ewg_function_IsMenuBarInvalid (MenuRef rootMenu);
// Wraps call to function 'HiliteMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HiliteMenu(ewg_param_menuID) HiliteMenu ((MenuID)ewg_param_menuID)

void  ewg_function_HiliteMenu (MenuID menuID);
// Wraps call to function 'GetNewMBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNewMBar(ewg_param_menuBarID) GetNewMBar ((short)ewg_param_menuBarID)

MenuBarHandle  ewg_function_GetNewMBar (short menuBarID);
// Wraps call to function 'GetMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuBar GetMenuBar ()

MenuBarHandle  ewg_function_GetMenuBar (void);
// Wraps call to function 'SetMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuBar(ewg_param_mbar) SetMenuBar ((MenuBarHandle)ewg_param_mbar)

void  ewg_function_SetMenuBar (MenuBarHandle mbar);
// Wraps call to function 'DuplicateMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DuplicateMenuBar(ewg_param_inMbar, ewg_param_outMbar) DuplicateMenuBar ((MenuBarHandle)ewg_param_inMbar, (MenuBarHandle*)ewg_param_outMbar)

OSStatus  ewg_function_DuplicateMenuBar (MenuBarHandle inMbar, MenuBarHandle *outMbar);
// Wraps call to function 'DisposeMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeMenuBar(ewg_param_inMbar) DisposeMenuBar ((MenuBarHandle)ewg_param_inMbar)

OSStatus  ewg_function_DisposeMenuBar (MenuBarHandle inMbar);
// Wraps call to function 'GetMenuHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuHandle(ewg_param_menuID) GetMenuHandle ((MenuID)ewg_param_menuID)

MenuRef  ewg_function_GetMenuHandle (MenuID menuID);
// Wraps call to function 'InsertMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InsertMenu(ewg_param_theMenu, ewg_param_beforeID) InsertMenu ((MenuRef)ewg_param_theMenu, (MenuID)ewg_param_beforeID)

void  ewg_function_InsertMenu (MenuRef theMenu, MenuID beforeID);
// Wraps call to function 'DeleteMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DeleteMenu(ewg_param_menuID) DeleteMenu ((MenuID)ewg_param_menuID)

void  ewg_function_DeleteMenu (MenuID menuID);
// Wraps call to function 'ClearMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ClearMenuBar ClearMenuBar ()

void  ewg_function_ClearMenuBar (void);
// Wraps call to function 'SetMenuFlashCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuFlashCount(ewg_param_count) SetMenuFlashCount ((short)ewg_param_count)

void  ewg_function_SetMenuFlashCount (short count);
// Wraps call to function 'FlashMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FlashMenuBar(ewg_param_menuID) FlashMenuBar ((MenuID)ewg_param_menuID)

void  ewg_function_FlashMenuBar (MenuID menuID);
// Wraps call to function 'IsMenuBarVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuBarVisible IsMenuBarVisible ()

Boolean  ewg_function_IsMenuBarVisible (void);
// Wraps call to function 'ShowMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowMenuBar ShowMenuBar ()

void  ewg_function_ShowMenuBar (void);
// Wraps call to function 'HideMenuBar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HideMenuBar HideMenuBar ()

void  ewg_function_HideMenuBar (void);
// Wraps call to function 'AcquireRootMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AcquireRootMenu AcquireRootMenu ()

MenuRef  ewg_function_AcquireRootMenu (void);
// Wraps call to function 'SetRootMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetRootMenu(ewg_param_inMenu) SetRootMenu ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_SetRootMenu (MenuRef inMenu);
// Wraps call to function 'CheckMenuItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CheckMenuItem(ewg_param_theMenu, ewg_param_item, ewg_param_checked) CheckMenuItem ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (Boolean)ewg_param_checked)

void  ewg_function_CheckMenuItem (MenuRef theMenu, MenuItemIndex item, Boolean checked);
// Wraps call to function 'SetMenuItemText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemText(ewg_param_theMenu, ewg_param_item, ewg_param_itemString) SetMenuItemText ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (ConstStr255Param)ewg_param_itemString)

void  ewg_function_SetMenuItemText (MenuRef theMenu, MenuItemIndex item, ConstStr255Param itemString);
// Wraps call to function 'GetMenuItemText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemText(ewg_param_theMenu, ewg_param_item, ewg_param_itemString) GetMenuItemText ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, ewg_param_itemString)

void  ewg_function_GetMenuItemText (MenuRef theMenu, MenuItemIndex item, void *itemString);
// Wraps call to function 'SetItemMark' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetItemMark(ewg_param_theMenu, ewg_param_item, ewg_param_markChar) SetItemMark ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (CharParameter)ewg_param_markChar)

void  ewg_function_SetItemMark (MenuRef theMenu, MenuItemIndex item, CharParameter markChar);
// Wraps call to function 'GetItemMark' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetItemMark(ewg_param_theMenu, ewg_param_item, ewg_param_markChar) GetItemMark ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (CharParameter*)ewg_param_markChar)

void  ewg_function_GetItemMark (MenuRef theMenu, MenuItemIndex item, CharParameter *markChar);
// Wraps call to function 'SetItemCmd' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetItemCmd(ewg_param_theMenu, ewg_param_item, ewg_param_cmdChar) SetItemCmd ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (CharParameter)ewg_param_cmdChar)

void  ewg_function_SetItemCmd (MenuRef theMenu, MenuItemIndex item, CharParameter cmdChar);
// Wraps call to function 'GetItemCmd' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetItemCmd(ewg_param_theMenu, ewg_param_item, ewg_param_cmdChar) GetItemCmd ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (CharParameter*)ewg_param_cmdChar)

void  ewg_function_GetItemCmd (MenuRef theMenu, MenuItemIndex item, CharParameter *cmdChar);
// Wraps call to function 'SetItemIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetItemIcon(ewg_param_theMenu, ewg_param_item, ewg_param_iconIndex) SetItemIcon ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (short)ewg_param_iconIndex)

void  ewg_function_SetItemIcon (MenuRef theMenu, MenuItemIndex item, short iconIndex);
// Wraps call to function 'GetItemIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetItemIcon(ewg_param_theMenu, ewg_param_item, ewg_param_iconIndex) GetItemIcon ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (short*)ewg_param_iconIndex)

void  ewg_function_GetItemIcon (MenuRef theMenu, MenuItemIndex item, short *iconIndex);
// Wraps call to function 'SetItemStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetItemStyle(ewg_param_theMenu, ewg_param_item, ewg_param_chStyle) SetItemStyle ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (StyleParameter)ewg_param_chStyle)

void  ewg_function_SetItemStyle (MenuRef theMenu, MenuItemIndex item, StyleParameter chStyle);
// Wraps call to function 'GetItemStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetItemStyle(ewg_param_theMenu, ewg_param_item, ewg_param_chStyle) GetItemStyle ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item, (Style*)ewg_param_chStyle)

void  ewg_function_GetItemStyle (MenuRef theMenu, MenuItemIndex item, Style *chStyle);
// Wraps call to function 'SetMenuItemCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemCommandID(ewg_param_inMenu, ewg_param_inItem, ewg_param_inCommandID) SetMenuItemCommandID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuCommand)ewg_param_inCommandID)

OSErr  ewg_function_SetMenuItemCommandID (MenuRef inMenu, MenuItemIndex inItem, MenuCommand inCommandID);
// Wraps call to function 'GetMenuItemCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemCommandID(ewg_param_inMenu, ewg_param_inItem, ewg_param_outCommandID) GetMenuItemCommandID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuCommand*)ewg_param_outCommandID)

OSErr  ewg_function_GetMenuItemCommandID (MenuRef inMenu, MenuItemIndex inItem, MenuCommand *outCommandID);
// Wraps call to function 'SetMenuItemModifiers' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemModifiers(ewg_param_inMenu, ewg_param_inItem, ewg_param_inModifiers) SetMenuItemModifiers ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt8)ewg_param_inModifiers)

OSErr  ewg_function_SetMenuItemModifiers (MenuRef inMenu, MenuItemIndex inItem, UInt8 inModifiers);
// Wraps call to function 'GetMenuItemModifiers' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemModifiers(ewg_param_inMenu, ewg_param_inItem, ewg_param_outModifiers) GetMenuItemModifiers ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt8*)ewg_param_outModifiers)

OSErr  ewg_function_GetMenuItemModifiers (MenuRef inMenu, MenuItemIndex inItem, UInt8 *outModifiers);
// Wraps call to function 'SetMenuItemIconHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemIconHandle(ewg_param_inMenu, ewg_param_inItem, ewg_param_inIconType, ewg_param_inIconHandle) SetMenuItemIconHandle ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt8)ewg_param_inIconType, (Handle)ewg_param_inIconHandle)

OSErr  ewg_function_SetMenuItemIconHandle (MenuRef inMenu, MenuItemIndex inItem, UInt8 inIconType, Handle inIconHandle);
// Wraps call to function 'GetMenuItemIconHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemIconHandle(ewg_param_inMenu, ewg_param_inItem, ewg_param_outIconType, ewg_param_outIconHandle) GetMenuItemIconHandle ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt8*)ewg_param_outIconType, (Handle*)ewg_param_outIconHandle)

OSErr  ewg_function_GetMenuItemIconHandle (MenuRef inMenu, MenuItemIndex inItem, UInt8 *outIconType, Handle *outIconHandle);
// Wraps call to function 'SetMenuItemTextEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemTextEncoding(ewg_param_inMenu, ewg_param_inItem, ewg_param_inScriptID) SetMenuItemTextEncoding ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (TextEncoding)ewg_param_inScriptID)

OSErr  ewg_function_SetMenuItemTextEncoding (MenuRef inMenu, MenuItemIndex inItem, TextEncoding inScriptID);
// Wraps call to function 'GetMenuItemTextEncoding' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemTextEncoding(ewg_param_inMenu, ewg_param_inItem, ewg_param_outScriptID) GetMenuItemTextEncoding ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (TextEncoding*)ewg_param_outScriptID)

OSErr  ewg_function_GetMenuItemTextEncoding (MenuRef inMenu, MenuItemIndex inItem, TextEncoding *outScriptID);
// Wraps call to function 'SetMenuItemHierarchicalID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemHierarchicalID(ewg_param_inMenu, ewg_param_inItem, ewg_param_inHierID) SetMenuItemHierarchicalID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuID)ewg_param_inHierID)

OSErr  ewg_function_SetMenuItemHierarchicalID (MenuRef inMenu, MenuItemIndex inItem, MenuID inHierID);
// Wraps call to function 'GetMenuItemHierarchicalID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemHierarchicalID(ewg_param_inMenu, ewg_param_inItem, ewg_param_outHierID) GetMenuItemHierarchicalID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuID*)ewg_param_outHierID)

OSErr  ewg_function_GetMenuItemHierarchicalID (MenuRef inMenu, MenuItemIndex inItem, MenuID *outHierID);
// Wraps call to function 'SetMenuItemFontID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemFontID(ewg_param_inMenu, ewg_param_inItem, ewg_param_inFontID) SetMenuItemFontID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (SInt16)ewg_param_inFontID)

OSErr  ewg_function_SetMenuItemFontID (MenuRef inMenu, MenuItemIndex inItem, SInt16 inFontID);
// Wraps call to function 'GetMenuItemFontID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemFontID(ewg_param_inMenu, ewg_param_inItem, ewg_param_outFontID) GetMenuItemFontID ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (SInt16*)ewg_param_outFontID)

OSErr  ewg_function_GetMenuItemFontID (MenuRef inMenu, MenuItemIndex inItem, SInt16 *outFontID);
// Wraps call to function 'SetMenuItemRefCon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemRefCon(ewg_param_inMenu, ewg_param_inItem, ewg_param_inRefCon) SetMenuItemRefCon ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt32)ewg_param_inRefCon)

OSErr  ewg_function_SetMenuItemRefCon (MenuRef inMenu, MenuItemIndex inItem, UInt32 inRefCon);
// Wraps call to function 'GetMenuItemRefCon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemRefCon(ewg_param_inMenu, ewg_param_inItem, ewg_param_outRefCon) GetMenuItemRefCon ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt32*)ewg_param_outRefCon)

OSErr  ewg_function_GetMenuItemRefCon (MenuRef inMenu, MenuItemIndex inItem, UInt32 *outRefCon);
// Wraps call to function 'SetMenuItemKeyGlyph' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemKeyGlyph(ewg_param_inMenu, ewg_param_inItem, ewg_param_inGlyph) SetMenuItemKeyGlyph ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (SInt16)ewg_param_inGlyph)

OSErr  ewg_function_SetMenuItemKeyGlyph (MenuRef inMenu, MenuItemIndex inItem, SInt16 inGlyph);
// Wraps call to function 'GetMenuItemKeyGlyph' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemKeyGlyph(ewg_param_inMenu, ewg_param_inItem, ewg_param_outGlyph) GetMenuItemKeyGlyph ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (SInt16*)ewg_param_outGlyph)

OSErr  ewg_function_GetMenuItemKeyGlyph (MenuRef inMenu, MenuItemIndex inItem, SInt16 *outGlyph);
// Wraps call to function 'EnableMenuItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableMenuItem(ewg_param_theMenu, ewg_param_item) EnableMenuItem ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item)

void  ewg_function_EnableMenuItem (MenuRef theMenu, MenuItemIndex item);
// Wraps call to function 'DisableMenuItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableMenuItem(ewg_param_theMenu, ewg_param_item) DisableMenuItem ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item)

void  ewg_function_DisableMenuItem (MenuRef theMenu, MenuItemIndex item);
// Wraps call to function 'IsMenuItemEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuItemEnabled(ewg_param_menu, ewg_param_item) IsMenuItemEnabled ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item)

Boolean  ewg_function_IsMenuItemEnabled (MenuRef menu, MenuItemIndex item);
// Wraps call to function 'EnableMenuItemIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableMenuItemIcon(ewg_param_theMenu, ewg_param_item) EnableMenuItemIcon ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item)

void  ewg_function_EnableMenuItemIcon (MenuRef theMenu, MenuItemIndex item);
// Wraps call to function 'DisableMenuItemIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableMenuItemIcon(ewg_param_theMenu, ewg_param_item) DisableMenuItemIcon ((MenuRef)ewg_param_theMenu, (MenuItemIndex)ewg_param_item)

void  ewg_function_DisableMenuItemIcon (MenuRef theMenu, MenuItemIndex item);
// Wraps call to function 'IsMenuItemIconEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuItemIconEnabled(ewg_param_menu, ewg_param_item) IsMenuItemIconEnabled ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item)

Boolean  ewg_function_IsMenuItemIconEnabled (MenuRef menu, MenuItemIndex item);
// Wraps call to function 'SetMenuItemHierarchicalMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemHierarchicalMenu(ewg_param_inMenu, ewg_param_inItem, ewg_param_inHierMenu) SetMenuItemHierarchicalMenu ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuRef)ewg_param_inHierMenu)

OSStatus  ewg_function_SetMenuItemHierarchicalMenu (MenuRef inMenu, MenuItemIndex inItem, MenuRef inHierMenu);
// Wraps call to function 'GetMenuItemHierarchicalMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemHierarchicalMenu(ewg_param_inMenu, ewg_param_inItem, ewg_param_outHierMenu) GetMenuItemHierarchicalMenu ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (MenuRef*)ewg_param_outHierMenu)

OSStatus  ewg_function_GetMenuItemHierarchicalMenu (MenuRef inMenu, MenuItemIndex inItem, MenuRef *outHierMenu);
// Wraps call to function 'CopyMenuItemTextAsCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyMenuItemTextAsCFString(ewg_param_inMenu, ewg_param_inItem, ewg_param_outString) CopyMenuItemTextAsCFString ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (CFStringRef*)ewg_param_outString)

OSStatus  ewg_function_CopyMenuItemTextAsCFString (MenuRef inMenu, MenuItemIndex inItem, CFStringRef *outString);
// Wraps call to function 'SetMenuItemTextWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemTextWithCFString(ewg_param_inMenu, ewg_param_inItem, ewg_param_inString) SetMenuItemTextWithCFString ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (CFStringRef)ewg_param_inString)

OSStatus  ewg_function_SetMenuItemTextWithCFString (MenuRef inMenu, MenuItemIndex inItem, CFStringRef inString);
// Wraps call to function 'GetMenuItemIndent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemIndent(ewg_param_inMenu, ewg_param_inItem, ewg_param_outIndent) GetMenuItemIndent ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt32*)ewg_param_outIndent)

OSStatus  ewg_function_GetMenuItemIndent (MenuRef inMenu, MenuItemIndex inItem, UInt32 *outIndent);
// Wraps call to function 'SetMenuItemIndent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemIndent(ewg_param_inMenu, ewg_param_inItem, ewg_param_inIndent) SetMenuItemIndent ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (UInt32)ewg_param_inIndent)

OSStatus  ewg_function_SetMenuItemIndent (MenuRef inMenu, MenuItemIndex inItem, UInt32 inIndent);
// Wraps call to function 'GetMenuItemCommandKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemCommandKey(ewg_param_inMenu, ewg_param_inItem, ewg_param_inGetVirtualKey, ewg_param_outKey) GetMenuItemCommandKey ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (Boolean)ewg_param_inGetVirtualKey, (UInt16*)ewg_param_outKey)

OSStatus  ewg_function_GetMenuItemCommandKey (MenuRef inMenu, MenuItemIndex inItem, Boolean inGetVirtualKey, UInt16 *outKey);
// Wraps call to function 'SetMenuItemCommandKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemCommandKey(ewg_param_inMenu, ewg_param_inItem, ewg_param_inSetVirtualKey, ewg_param_inKey) SetMenuItemCommandKey ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (Boolean)ewg_param_inSetVirtualKey, (UInt16)ewg_param_inKey)

OSStatus  ewg_function_SetMenuItemCommandKey (MenuRef inMenu, MenuItemIndex inItem, Boolean inSetVirtualKey, UInt16 inKey);
// Wraps call to function 'DeleteMCEntries' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DeleteMCEntries(ewg_param_menuID, ewg_param_menuItem) DeleteMCEntries ((MenuID)ewg_param_menuID, (short)ewg_param_menuItem)

void  ewg_function_DeleteMCEntries (MenuID menuID, short menuItem);
// Wraps call to function 'GetMCInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMCInfo GetMCInfo ()

MCTableHandle  ewg_function_GetMCInfo (void);
// Wraps call to function 'SetMCInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMCInfo(ewg_param_menuCTbl) SetMCInfo ((MCTableHandle)ewg_param_menuCTbl)

void  ewg_function_SetMCInfo (MCTableHandle menuCTbl);
// Wraps call to function 'DisposeMCInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeMCInfo(ewg_param_menuCTbl) DisposeMCInfo ((MCTableHandle)ewg_param_menuCTbl)

void  ewg_function_DisposeMCInfo (MCTableHandle menuCTbl);
// Wraps call to function 'GetMCEntry' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMCEntry(ewg_param_menuID, ewg_param_menuItem) GetMCEntry ((MenuID)ewg_param_menuID, (short)ewg_param_menuItem)

MCEntryPtr  ewg_function_GetMCEntry (MenuID menuID, short menuItem);
// Wraps call to function 'SetMCEntries' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMCEntries(ewg_param_numEntries, ewg_param_menuCEntries) SetMCEntries ((short)ewg_param_numEntries, (MCTablePtr)ewg_param_menuCEntries)

void  ewg_function_SetMCEntries (short numEntries, MCTablePtr menuCEntries);
// Wraps call to function 'GetMenuItemProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemProperty(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_bufferSize, ewg_param_actualSize, ewg_param_propertyBuffer) GetMenuItemProperty ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_bufferSize, (UInt32*)ewg_param_actualSize, (void*)ewg_param_propertyBuffer)

OSStatus  ewg_function_GetMenuItemProperty (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag, UInt32 bufferSize, UInt32 *actualSize, void *propertyBuffer);
// Wraps call to function 'GetMenuItemPropertySize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemPropertySize(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_size) GetMenuItemPropertySize ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32*)ewg_param_size)

OSStatus  ewg_function_GetMenuItemPropertySize (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag, UInt32 *size);
// Wraps call to function 'SetMenuItemProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemProperty(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_propertySize, ewg_param_propertyData) SetMenuItemProperty ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_propertySize, (void const*)ewg_param_propertyData)

OSStatus  ewg_function_SetMenuItemProperty (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag, UInt32 propertySize, void const *propertyData);
// Wraps call to function 'RemoveMenuItemProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveMenuItemProperty(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag) RemoveMenuItemProperty ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag)

OSStatus  ewg_function_RemoveMenuItemProperty (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag);
// Wraps call to function 'GetMenuItemPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemPropertyAttributes(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributes) GetMenuItemPropertyAttributes ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32*)ewg_param_attributes)

OSStatus  ewg_function_GetMenuItemPropertyAttributes (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag, UInt32 *attributes);
// Wraps call to function 'ChangeMenuItemPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeMenuItemPropertyAttributes(ewg_param_menu, ewg_param_item, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributesToSet, ewg_param_attributesToClear) ChangeMenuItemPropertyAttributes ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_attributesToSet, (UInt32)ewg_param_attributesToClear)

OSStatus  ewg_function_ChangeMenuItemPropertyAttributes (MenuRef menu, MenuItemIndex item, OSType propertyCreator, OSType propertyTag, UInt32 attributesToSet, UInt32 attributesToClear);
// Wraps call to function 'GetMenuAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuAttributes(ewg_param_menu, ewg_param_outAttributes) GetMenuAttributes ((MenuRef)ewg_param_menu, (MenuAttributes*)ewg_param_outAttributes)

OSStatus  ewg_function_GetMenuAttributes (MenuRef menu, MenuAttributes *outAttributes);
// Wraps call to function 'ChangeMenuAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeMenuAttributes(ewg_param_menu, ewg_param_setTheseAttributes, ewg_param_clearTheseAttributes) ChangeMenuAttributes ((MenuRef)ewg_param_menu, (MenuAttributes)ewg_param_setTheseAttributes, (MenuAttributes)ewg_param_clearTheseAttributes)

OSStatus  ewg_function_ChangeMenuAttributes (MenuRef menu, MenuAttributes setTheseAttributes, MenuAttributes clearTheseAttributes);
// Wraps call to function 'GetMenuItemAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuItemAttributes(ewg_param_menu, ewg_param_item, ewg_param_outAttributes) GetMenuItemAttributes ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (MenuItemAttributes*)ewg_param_outAttributes)

OSStatus  ewg_function_GetMenuItemAttributes (MenuRef menu, MenuItemIndex item, MenuItemAttributes *outAttributes);
// Wraps call to function 'ChangeMenuItemAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeMenuItemAttributes(ewg_param_menu, ewg_param_item, ewg_param_setTheseAttributes, ewg_param_clearTheseAttributes) ChangeMenuItemAttributes ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (MenuItemAttributes)ewg_param_setTheseAttributes, (MenuItemAttributes)ewg_param_clearTheseAttributes)

OSStatus  ewg_function_ChangeMenuItemAttributes (MenuRef menu, MenuItemIndex item, MenuItemAttributes setTheseAttributes, MenuItemAttributes clearTheseAttributes);
// Wraps call to function 'DisableAllMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableAllMenuItems(ewg_param_theMenu) DisableAllMenuItems ((MenuRef)ewg_param_theMenu)

void  ewg_function_DisableAllMenuItems (MenuRef theMenu);
// Wraps call to function 'EnableAllMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableAllMenuItems(ewg_param_theMenu) EnableAllMenuItems ((MenuRef)ewg_param_theMenu)

void  ewg_function_EnableAllMenuItems (MenuRef theMenu);
// Wraps call to function 'MenuHasEnabledItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MenuHasEnabledItems(ewg_param_theMenu) MenuHasEnabledItems ((MenuRef)ewg_param_theMenu)

Boolean  ewg_function_MenuHasEnabledItems (MenuRef theMenu);
// Wraps call to function 'GetMenuTrackingData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuTrackingData(ewg_param_theMenu, ewg_param_outData) GetMenuTrackingData ((MenuRef)ewg_param_theMenu, (MenuTrackingData*)ewg_param_outData)

OSStatus  ewg_function_GetMenuTrackingData (MenuRef theMenu, MenuTrackingData *outData);
// Wraps call to function 'GetMenuType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuType(ewg_param_theMenu, ewg_param_outType) GetMenuType ((MenuRef)ewg_param_theMenu, (UInt16*)ewg_param_outType)

OSStatus  ewg_function_GetMenuType (MenuRef theMenu, UInt16 *outType);
// Wraps call to function 'CountMenuItemsWithCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CountMenuItemsWithCommandID(ewg_param_inMenu, ewg_param_inCommandID) CountMenuItemsWithCommandID ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID)

ItemCount  ewg_function_CountMenuItemsWithCommandID (MenuRef inMenu, MenuCommand inCommandID);
// Wraps call to function 'GetIndMenuItemWithCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetIndMenuItemWithCommandID(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inItemIndex, ewg_param_outMenu, ewg_param_outIndex) GetIndMenuItemWithCommandID ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (UInt32)ewg_param_inItemIndex, (MenuRef*)ewg_param_outMenu, (MenuItemIndex*)ewg_param_outIndex)

OSStatus  ewg_function_GetIndMenuItemWithCommandID (MenuRef inMenu, MenuCommand inCommandID, UInt32 inItemIndex, MenuRef *outMenu, MenuItemIndex *outIndex);
// Wraps call to function 'EnableMenuCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableMenuCommand(ewg_param_inMenu, ewg_param_inCommandID) EnableMenuCommand ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID)

void  ewg_function_EnableMenuCommand (MenuRef inMenu, MenuCommand inCommandID);
// Wraps call to function 'DisableMenuCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableMenuCommand(ewg_param_inMenu, ewg_param_inCommandID) DisableMenuCommand ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID)

void  ewg_function_DisableMenuCommand (MenuRef inMenu, MenuCommand inCommandID);
// Wraps call to function 'IsMenuCommandEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuCommandEnabled(ewg_param_inMenu, ewg_param_inCommandID) IsMenuCommandEnabled ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID)

Boolean  ewg_function_IsMenuCommandEnabled (MenuRef inMenu, MenuCommand inCommandID);
// Wraps call to function 'SetMenuCommandMark' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuCommandMark(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inMark) SetMenuCommandMark ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (UniChar)ewg_param_inMark)

OSStatus  ewg_function_SetMenuCommandMark (MenuRef inMenu, MenuCommand inCommandID, UniChar inMark);
// Wraps call to function 'GetMenuCommandMark' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuCommandMark(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_outMark) GetMenuCommandMark ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (UniChar*)ewg_param_outMark)

OSStatus  ewg_function_GetMenuCommandMark (MenuRef inMenu, MenuCommand inCommandID, UniChar *outMark);
// Wraps call to function 'GetMenuCommandProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuCommandProperty(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inPropertyCreator, ewg_param_inPropertyTag, ewg_param_inBufferSize, ewg_param_outActualSize, ewg_param_inPropertyBuffer) GetMenuCommandProperty ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (OSType)ewg_param_inPropertyCreator, (OSType)ewg_param_inPropertyTag, (ByteCount)ewg_param_inBufferSize, (ByteCount*)ewg_param_outActualSize, (void*)ewg_param_inPropertyBuffer)

OSStatus  ewg_function_GetMenuCommandProperty (MenuRef inMenu, MenuCommand inCommandID, OSType inPropertyCreator, OSType inPropertyTag, ByteCount inBufferSize, ByteCount *outActualSize, void *inPropertyBuffer);
// Wraps call to function 'GetMenuCommandPropertySize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuCommandPropertySize(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inPropertyCreator, ewg_param_inPropertyTag, ewg_param_outSize) GetMenuCommandPropertySize ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (OSType)ewg_param_inPropertyCreator, (OSType)ewg_param_inPropertyTag, (ByteCount*)ewg_param_outSize)

OSStatus  ewg_function_GetMenuCommandPropertySize (MenuRef inMenu, MenuCommand inCommandID, OSType inPropertyCreator, OSType inPropertyTag, ByteCount *outSize);
// Wraps call to function 'SetMenuCommandProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuCommandProperty(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inPropertyCreator, ewg_param_inPropertyTag, ewg_param_inPropertySize, ewg_param_inPropertyData) SetMenuCommandProperty ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (OSType)ewg_param_inPropertyCreator, (OSType)ewg_param_inPropertyTag, (ByteCount)ewg_param_inPropertySize, (void const*)ewg_param_inPropertyData)

OSStatus  ewg_function_SetMenuCommandProperty (MenuRef inMenu, MenuCommand inCommandID, OSType inPropertyCreator, OSType inPropertyTag, ByteCount inPropertySize, void const *inPropertyData);
// Wraps call to function 'RemoveMenuCommandProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveMenuCommandProperty(ewg_param_inMenu, ewg_param_inCommandID, ewg_param_inPropertyCreator, ewg_param_inPropertyTag) RemoveMenuCommandProperty ((MenuRef)ewg_param_inMenu, (MenuCommand)ewg_param_inCommandID, (OSType)ewg_param_inPropertyCreator, (OSType)ewg_param_inPropertyTag)

OSStatus  ewg_function_RemoveMenuCommandProperty (MenuRef inMenu, MenuCommand inCommandID, OSType inPropertyCreator, OSType inPropertyTag);
// Wraps call to function 'CopyMenuItemData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyMenuItemData(ewg_param_inMenu, ewg_param_inItem, ewg_param_inIsCommandID, ewg_param_ioData) CopyMenuItemData ((MenuRef)ewg_param_inMenu, (MenuItemID)ewg_param_inItem, (Boolean)ewg_param_inIsCommandID, (MenuItemDataPtr)ewg_param_ioData)

OSStatus  ewg_function_CopyMenuItemData (MenuRef inMenu, MenuItemID inItem, Boolean inIsCommandID, MenuItemDataPtr ioData);
// Wraps call to function 'SetMenuItemData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuItemData(ewg_param_inMenu, ewg_param_inItem, ewg_param_inIsCommandID, ewg_param_inData) SetMenuItemData ((MenuRef)ewg_param_inMenu, (MenuItemID)ewg_param_inItem, (Boolean)ewg_param_inIsCommandID, (MenuItemDataRec const*)ewg_param_inData)

OSStatus  ewg_function_SetMenuItemData (MenuRef inMenu, MenuItemID inItem, Boolean inIsCommandID, MenuItemDataRec const *inData);
// Wraps call to function 'IsMenuItemInvalid' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMenuItemInvalid(ewg_param_inMenu, ewg_param_inItem) IsMenuItemInvalid ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem)

Boolean  ewg_function_IsMenuItemInvalid (MenuRef inMenu, MenuItemIndex inItem);
// Wraps call to function 'InvalidateMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalidateMenuItems(ewg_param_inMenu, ewg_param_inFirstItem, ewg_param_inNumItems) InvalidateMenuItems ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inFirstItem, (ItemCount)ewg_param_inNumItems)

OSStatus  ewg_function_InvalidateMenuItems (MenuRef inMenu, MenuItemIndex inFirstItem, ItemCount inNumItems);
// Wraps call to function 'UpdateInvalidMenuItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UpdateInvalidMenuItems(ewg_param_inMenu) UpdateInvalidMenuItems ((MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_UpdateInvalidMenuItems (MenuRef inMenu);
// Wraps call to function 'CreateStandardFontMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateStandardFontMenu(ewg_param_menu, ewg_param_afterItem, ewg_param_firstHierMenuID, ewg_param_options, ewg_param_outHierMenuCount) CreateStandardFontMenu ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_afterItem, (MenuID)ewg_param_firstHierMenuID, (OptionBits)ewg_param_options, (ItemCount*)ewg_param_outHierMenuCount)

OSStatus  ewg_function_CreateStandardFontMenu (MenuRef menu, MenuItemIndex afterItem, MenuID firstHierMenuID, OptionBits options, ItemCount *outHierMenuCount);
// Wraps call to function 'UpdateStandardFontMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UpdateStandardFontMenu(ewg_param_menu, ewg_param_outHierMenuCount) UpdateStandardFontMenu ((MenuRef)ewg_param_menu, (ItemCount*)ewg_param_outHierMenuCount)

OSStatus  ewg_function_UpdateStandardFontMenu (MenuRef menu, ItemCount *outHierMenuCount);
// Wraps call to function 'GetFontFamilyFromMenuSelection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetFontFamilyFromMenuSelection(ewg_param_menu, ewg_param_item, ewg_param_outFontFamily, ewg_param_outStyle) GetFontFamilyFromMenuSelection ((MenuRef)ewg_param_menu, (MenuItemIndex)ewg_param_item, (FMFontFamily*)ewg_param_outFontFamily, (FMFontStyle*)ewg_param_outStyle)

OSStatus  ewg_function_GetFontFamilyFromMenuSelection (MenuRef menu, MenuItemIndex item, FMFontFamily *outFontFamily, FMFontStyle *outStyle);
// Wraps call to function 'InitContextualMenus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InitContextualMenus InitContextualMenus ()

OSStatus  ewg_function_InitContextualMenus (void);
// Wraps call to function 'IsShowContextualMenuClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsShowContextualMenuClick(ewg_param_inEvent) IsShowContextualMenuClick ((EventRecord const*)ewg_param_inEvent)

Boolean  ewg_function_IsShowContextualMenuClick (EventRecord const *inEvent);
// Wraps call to function 'IsShowContextualMenuEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsShowContextualMenuEvent(ewg_param_inEvent) IsShowContextualMenuEvent ((EventRef)ewg_param_inEvent)

Boolean  ewg_function_IsShowContextualMenuEvent (EventRef inEvent);
// Wraps call to function 'ContextualMenuSelect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ContextualMenuSelect(ewg_param_inMenu, ewg_param_inGlobalLocation, ewg_param_inReserved, ewg_param_inHelpType, ewg_param_inHelpItemString, ewg_param_inSelection, ewg_param_outUserSelectionType, ewg_param_outMenuID, ewg_param_outMenuItem) ContextualMenuSelect ((MenuRef)ewg_param_inMenu, *(Point*)ewg_param_inGlobalLocation, (Boolean)ewg_param_inReserved, (UInt32)ewg_param_inHelpType, (ConstStr255Param)ewg_param_inHelpItemString, (AEDesc const*)ewg_param_inSelection, (UInt32*)ewg_param_outUserSelectionType, (MenuID*)ewg_param_outMenuID, (MenuItemIndex*)ewg_param_outMenuItem)

OSStatus  ewg_function_ContextualMenuSelect (MenuRef inMenu, Point *inGlobalLocation, Boolean inReserved, UInt32 inHelpType, ConstStr255Param inHelpItemString, AEDesc const *inSelection, UInt32 *outUserSelectionType, MenuID *outMenuID, MenuItemIndex *outMenuItem);
// Wraps call to function 'ProcessIsContextualMenuClient' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ProcessIsContextualMenuClient(ewg_param_inPSN) ProcessIsContextualMenuClient ((ProcessSerialNumber*)ewg_param_inPSN)

Boolean  ewg_function_ProcessIsContextualMenuClient (ProcessSerialNumber *inPSN);
// Wraps call to function 'LMGetTheMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_LMGetTheMenu LMGetTheMenu ()

MenuID  ewg_function_LMGetTheMenu (void);
// Wraps call to function 'GetMenuID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuID(ewg_param_menu) GetMenuID ((MenuRef)ewg_param_menu)

MenuID  ewg_function_GetMenuID (MenuRef menu);
// Wraps call to function 'GetMenuWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuWidth(ewg_param_menu) GetMenuWidth ((MenuRef)ewg_param_menu)

SInt16  ewg_function_GetMenuWidth (MenuRef menu);
// Wraps call to function 'GetMenuHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuHeight(ewg_param_menu) GetMenuHeight ((MenuRef)ewg_param_menu)

SInt16  ewg_function_GetMenuHeight (MenuRef menu);
// Wraps call to function 'GetMenuTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuTitle(ewg_param_menu, ewg_param_title) GetMenuTitle ((MenuRef)ewg_param_menu, ewg_param_title)

StringPtr  ewg_function_GetMenuTitle (MenuRef menu, void *title);
// Wraps call to function 'GetMenuDefinition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuDefinition(ewg_param_menu, ewg_param_outDefSpec) GetMenuDefinition ((MenuRef)ewg_param_menu, (MenuDefSpecPtr)ewg_param_outDefSpec)

OSStatus  ewg_function_GetMenuDefinition (MenuRef menu, MenuDefSpecPtr outDefSpec);
// Wraps call to function 'SetMenuID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuID(ewg_param_menu, ewg_param_menuID) SetMenuID ((MenuRef)ewg_param_menu, (MenuID)ewg_param_menuID)

void  ewg_function_SetMenuID (MenuRef menu, MenuID menuID);
// Wraps call to function 'SetMenuWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuWidth(ewg_param_menu, ewg_param_width) SetMenuWidth ((MenuRef)ewg_param_menu, (SInt16)ewg_param_width)

void  ewg_function_SetMenuWidth (MenuRef menu, SInt16 width);
// Wraps call to function 'SetMenuHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuHeight(ewg_param_menu, ewg_param_height) SetMenuHeight ((MenuRef)ewg_param_menu, (SInt16)ewg_param_height)

void  ewg_function_SetMenuHeight (MenuRef menu, SInt16 height);
// Wraps call to function 'SetMenuTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuTitle(ewg_param_menu, ewg_param_title) SetMenuTitle ((MenuRef)ewg_param_menu, (ConstStr255Param)ewg_param_title)

OSStatus  ewg_function_SetMenuTitle (MenuRef menu, ConstStr255Param title);
// Wraps call to function 'SetMenuDefinition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMenuDefinition(ewg_param_menu, ewg_param_defSpec) SetMenuDefinition ((MenuRef)ewg_param_menu, (MenuDefSpec const*)ewg_param_defSpec)

OSStatus  ewg_function_SetMenuDefinition (MenuRef menu, MenuDefSpec const *defSpec);
// Wraps call to function 'NewControlActionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlActionUPP(ewg_param_userRoutine) NewControlActionUPP ((ControlActionProcPtr)ewg_param_userRoutine)

ControlActionUPP  ewg_function_NewControlActionUPP (ControlActionProcPtr userRoutine);
// Wraps call to function 'DisposeControlActionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlActionUPP(ewg_param_userUPP) DisposeControlActionUPP ((ControlActionUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlActionUPP (ControlActionUPP userUPP);
// Wraps call to function 'InvokeControlActionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlActionUPP(ewg_param_theControl, ewg_param_partCode, ewg_param_userUPP) InvokeControlActionUPP ((ControlRef)ewg_param_theControl, (ControlPartCode)ewg_param_partCode, (ControlActionUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlActionUPP (ControlRef theControl, ControlPartCode partCode, ControlActionUPP userUPP);
// Wraps call to function 'NewControlDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlDefUPP(ewg_param_userRoutine) NewControlDefUPP ((ControlDefProcPtr)ewg_param_userRoutine)

ControlDefUPP  ewg_function_NewControlDefUPP (ControlDefProcPtr userRoutine);
// Wraps call to function 'DisposeControlDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlDefUPP(ewg_param_userUPP) DisposeControlDefUPP ((ControlDefUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlDefUPP (ControlDefUPP userUPP);
// Wraps call to function 'InvokeControlDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlDefUPP(ewg_param_varCode, ewg_param_theControl, ewg_param_message, ewg_param_param, ewg_param_userUPP) InvokeControlDefUPP ((SInt16)ewg_param_varCode, (ControlRef)ewg_param_theControl, (ControlDefProcMessage)ewg_param_message, (SInt32)ewg_param_param, (ControlDefUPP)ewg_param_userUPP)

SInt32  ewg_function_InvokeControlDefUPP (SInt16 varCode, ControlRef theControl, ControlDefProcMessage message, SInt32 param, ControlDefUPP userUPP);
// Wraps call to function 'NewControlKeyFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlKeyFilterUPP(ewg_param_userRoutine) NewControlKeyFilterUPP ((ControlKeyFilterProcPtr)ewg_param_userRoutine)

ControlKeyFilterUPP  ewg_function_NewControlKeyFilterUPP (ControlKeyFilterProcPtr userRoutine);
// Wraps call to function 'DisposeControlKeyFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlKeyFilterUPP(ewg_param_userUPP) DisposeControlKeyFilterUPP ((ControlKeyFilterUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlKeyFilterUPP (ControlKeyFilterUPP userUPP);
// Wraps call to function 'InvokeControlKeyFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlKeyFilterUPP(ewg_param_theControl, ewg_param_keyCode, ewg_param_charCode, ewg_param_modifiers, ewg_param_userUPP) InvokeControlKeyFilterUPP ((ControlRef)ewg_param_theControl, (SInt16*)ewg_param_keyCode, (SInt16*)ewg_param_charCode, (EventModifiers*)ewg_param_modifiers, (ControlKeyFilterUPP)ewg_param_userUPP)

ControlKeyFilterResult  ewg_function_InvokeControlKeyFilterUPP (ControlRef theControl, SInt16 *keyCode, SInt16 *charCode, EventModifiers *modifiers, ControlKeyFilterUPP userUPP);
// Wraps call to function 'CreateCustomControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateCustomControl(ewg_param_owningWindow, ewg_param_contBounds, ewg_param_def, ewg_param_initData, ewg_param_outControl) CreateCustomControl ((WindowRef)ewg_param_owningWindow, (Rect const*)ewg_param_contBounds, (ControlDefSpec const*)ewg_param_def, (Collection)ewg_param_initData, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateCustomControl (WindowRef owningWindow, Rect const *contBounds, ControlDefSpec const *def, Collection initData, ControlRef *outControl);
// Wraps call to function 'NewControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControl(ewg_param_owningWindow, ewg_param_boundsRect, ewg_param_controlTitle, ewg_param_initiallyVisible, ewg_param_initialValue, ewg_param_minimumValue, ewg_param_maximumValue, ewg_param_procID, ewg_param_controlReference) NewControl ((WindowRef)ewg_param_owningWindow, (Rect const*)ewg_param_boundsRect, (ConstStr255Param)ewg_param_controlTitle, (Boolean)ewg_param_initiallyVisible, (SInt16)ewg_param_initialValue, (SInt16)ewg_param_minimumValue, (SInt16)ewg_param_maximumValue, (SInt16)ewg_param_procID, (SInt32)ewg_param_controlReference)

ControlRef  ewg_function_NewControl (WindowRef owningWindow, Rect const *boundsRect, ConstStr255Param controlTitle, Boolean initiallyVisible, SInt16 initialValue, SInt16 minimumValue, SInt16 maximumValue, SInt16 procID, SInt32 controlReference);
// Wraps call to function 'GetNewControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNewControl(ewg_param_resourceID, ewg_param_owningWindow) GetNewControl ((SInt16)ewg_param_resourceID, (WindowRef)ewg_param_owningWindow)

ControlRef  ewg_function_GetNewControl (SInt16 resourceID, WindowRef owningWindow);
// Wraps call to function 'DisposeControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControl(ewg_param_theControl) DisposeControl ((ControlRef)ewg_param_theControl)

void  ewg_function_DisposeControl (ControlRef theControl);
// Wraps call to function 'KillControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_KillControls(ewg_param_theWindow) KillControls ((WindowRef)ewg_param_theWindow)

void  ewg_function_KillControls (WindowRef theWindow);
// Wraps call to function 'NewControlCNTLToCollectionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlCNTLToCollectionUPP(ewg_param_userRoutine) NewControlCNTLToCollectionUPP ((ControlCNTLToCollectionProcPtr)ewg_param_userRoutine)

ControlCNTLToCollectionUPP  ewg_function_NewControlCNTLToCollectionUPP (ControlCNTLToCollectionProcPtr userRoutine);
// Wraps call to function 'DisposeControlCNTLToCollectionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlCNTLToCollectionUPP(ewg_param_userUPP) DisposeControlCNTLToCollectionUPP ((ControlCNTLToCollectionUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlCNTLToCollectionUPP (ControlCNTLToCollectionUPP userUPP);
// Wraps call to function 'InvokeControlCNTLToCollectionUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlCNTLToCollectionUPP(ewg_param_bounds, ewg_param_value, ewg_param_visible, ewg_param_max, ewg_param_min, ewg_param_procID, ewg_param_refCon, ewg_param_title, ewg_param_collection, ewg_param_userUPP) InvokeControlCNTLToCollectionUPP ((Rect const*)ewg_param_bounds, (SInt16)ewg_param_value, (Boolean)ewg_param_visible, (SInt16)ewg_param_max, (SInt16)ewg_param_min, (SInt16)ewg_param_procID, (SInt32)ewg_param_refCon, (ConstStr255Param)ewg_param_title, (Collection)ewg_param_collection, (ControlCNTLToCollectionUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeControlCNTLToCollectionUPP (Rect const *bounds, SInt16 value, Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon, ConstStr255Param title, Collection collection, ControlCNTLToCollectionUPP userUPP);
// Wraps call to function 'RegisterControlDefinition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RegisterControlDefinition(ewg_param_inCDEFResID, ewg_param_inControlDef, ewg_param_inConversionProc) RegisterControlDefinition ((SInt16)ewg_param_inCDEFResID, (ControlDefSpec const*)ewg_param_inControlDef, (ControlCNTLToCollectionUPP)ewg_param_inConversionProc)

OSStatus  ewg_function_RegisterControlDefinition (SInt16 inCDEFResID, ControlDefSpec const *inControlDef, ControlCNTLToCollectionUPP inConversionProc);
// Wraps call to function 'HiliteControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HiliteControl(ewg_param_theControl, ewg_param_hiliteState) HiliteControl ((ControlRef)ewg_param_theControl, (ControlPartCode)ewg_param_hiliteState)

void  ewg_function_HiliteControl (ControlRef theControl, ControlPartCode hiliteState);
// Wraps call to function 'ShowControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowControl(ewg_param_theControl) ShowControl ((ControlRef)ewg_param_theControl)

void  ewg_function_ShowControl (ControlRef theControl);
// Wraps call to function 'HideControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HideControl(ewg_param_theControl) HideControl ((ControlRef)ewg_param_theControl)

void  ewg_function_HideControl (ControlRef theControl);
// Wraps call to function 'IsControlActive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsControlActive(ewg_param_inControl) IsControlActive ((ControlRef)ewg_param_inControl)

Boolean  ewg_function_IsControlActive (ControlRef inControl);
// Wraps call to function 'IsControlVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsControlVisible(ewg_param_inControl) IsControlVisible ((ControlRef)ewg_param_inControl)

Boolean  ewg_function_IsControlVisible (ControlRef inControl);
// Wraps call to function 'ActivateControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ActivateControl(ewg_param_inControl) ActivateControl ((ControlRef)ewg_param_inControl)

OSErr  ewg_function_ActivateControl (ControlRef inControl);
// Wraps call to function 'DeactivateControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DeactivateControl(ewg_param_inControl) DeactivateControl ((ControlRef)ewg_param_inControl)

OSErr  ewg_function_DeactivateControl (ControlRef inControl);
// Wraps call to function 'SetControlVisibility' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlVisibility(ewg_param_inControl, ewg_param_inIsVisible, ewg_param_inDoDraw) SetControlVisibility ((ControlRef)ewg_param_inControl, (Boolean)ewg_param_inIsVisible, (Boolean)ewg_param_inDoDraw)

OSErr  ewg_function_SetControlVisibility (ControlRef inControl, Boolean inIsVisible, Boolean inDoDraw);
// Wraps call to function 'IsControlEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsControlEnabled(ewg_param_inControl) IsControlEnabled ((ControlRef)ewg_param_inControl)

Boolean  ewg_function_IsControlEnabled (ControlRef inControl);
// Wraps call to function 'EnableControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableControl(ewg_param_inControl) EnableControl ((ControlRef)ewg_param_inControl)

OSStatus  ewg_function_EnableControl (ControlRef inControl);
// Wraps call to function 'DisableControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableControl(ewg_param_inControl) DisableControl ((ControlRef)ewg_param_inControl)

OSStatus  ewg_function_DisableControl (ControlRef inControl);
// Wraps call to function 'DrawControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DrawControls(ewg_param_theWindow) DrawControls ((WindowRef)ewg_param_theWindow)

void  ewg_function_DrawControls (WindowRef theWindow);
// Wraps call to function 'Draw1Control' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_Draw1Control(ewg_param_theControl) Draw1Control ((ControlRef)ewg_param_theControl)

void  ewg_function_Draw1Control (ControlRef theControl);
// Wraps call to function 'UpdateControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UpdateControls(ewg_param_inWindow, ewg_param_inUpdateRegion) UpdateControls ((WindowRef)ewg_param_inWindow, (RgnHandle)ewg_param_inUpdateRegion)

void  ewg_function_UpdateControls (WindowRef inWindow, RgnHandle inUpdateRegion);
// Wraps call to function 'GetBestControlRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetBestControlRect(ewg_param_inControl, ewg_param_outRect, ewg_param_outBaseLineOffset) GetBestControlRect ((ControlRef)ewg_param_inControl, (Rect*)ewg_param_outRect, (SInt16*)ewg_param_outBaseLineOffset)

OSErr  ewg_function_GetBestControlRect (ControlRef inControl, Rect *outRect, SInt16 *outBaseLineOffset);
// Wraps call to function 'SetControlFontStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlFontStyle(ewg_param_inControl, ewg_param_inStyle) SetControlFontStyle ((ControlRef)ewg_param_inControl, (ControlFontStyleRec const*)ewg_param_inStyle)

OSErr  ewg_function_SetControlFontStyle (ControlRef inControl, ControlFontStyleRec const *inStyle);
// Wraps call to function 'DrawControlInCurrentPort' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DrawControlInCurrentPort(ewg_param_inControl) DrawControlInCurrentPort ((ControlRef)ewg_param_inControl)

void  ewg_function_DrawControlInCurrentPort (ControlRef inControl);
// Wraps call to function 'SetUpControlBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetUpControlBackground(ewg_param_inControl, ewg_param_inDepth, ewg_param_inIsColorDevice) SetUpControlBackground ((ControlRef)ewg_param_inControl, (SInt16)ewg_param_inDepth, (Boolean)ewg_param_inIsColorDevice)

OSErr  ewg_function_SetUpControlBackground (ControlRef inControl, SInt16 inDepth, Boolean inIsColorDevice);
// Wraps call to function 'SetUpControlTextColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetUpControlTextColor(ewg_param_inControl, ewg_param_inDepth, ewg_param_inIsColorDevice) SetUpControlTextColor ((ControlRef)ewg_param_inControl, (SInt16)ewg_param_inDepth, (Boolean)ewg_param_inIsColorDevice)

OSErr  ewg_function_SetUpControlTextColor (ControlRef inControl, SInt16 inDepth, Boolean inIsColorDevice);
// Wraps call to function 'NewControlColorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlColorUPP(ewg_param_userRoutine) NewControlColorUPP ((ControlColorProcPtr)ewg_param_userRoutine)

ControlColorUPP  ewg_function_NewControlColorUPP (ControlColorProcPtr userRoutine);
// Wraps call to function 'DisposeControlColorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlColorUPP(ewg_param_userUPP) DisposeControlColorUPP ((ControlColorUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlColorUPP (ControlColorUPP userUPP);
// Wraps call to function 'InvokeControlColorUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlColorUPP(ewg_param_inControl, ewg_param_inMessage, ewg_param_inDrawDepth, ewg_param_inDrawInColor, ewg_param_userUPP) InvokeControlColorUPP ((ControlRef)ewg_param_inControl, (SInt16)ewg_param_inMessage, (SInt16)ewg_param_inDrawDepth, (Boolean)ewg_param_inDrawInColor, (ControlColorUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeControlColorUPP (ControlRef inControl, SInt16 inMessage, SInt16 inDrawDepth, Boolean inDrawInColor, ControlColorUPP userUPP);
// Wraps call to function 'SetControlColorProc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlColorProc(ewg_param_inControl, ewg_param_inProc) SetControlColorProc ((ControlRef)ewg_param_inControl, (ControlColorUPP)ewg_param_inProc)

OSStatus  ewg_function_SetControlColorProc (ControlRef inControl, ControlColorUPP inProc);
// Wraps call to function 'TrackControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackControl(ewg_param_theControl, ewg_param_startPoint, ewg_param_actionProc) TrackControl ((ControlRef)ewg_param_theControl, *(Point*)ewg_param_startPoint, (ControlActionUPP)ewg_param_actionProc)

ControlPartCode  ewg_function_TrackControl (ControlRef theControl, Point *startPoint, ControlActionUPP actionProc);
// Wraps call to function 'DragControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DragControl(ewg_param_theControl, ewg_param_startPoint, ewg_param_limitRect, ewg_param_slopRect, ewg_param_axis) DragControl ((ControlRef)ewg_param_theControl, *(Point*)ewg_param_startPoint, (Rect const*)ewg_param_limitRect, (Rect const*)ewg_param_slopRect, (DragConstraint)ewg_param_axis)

void  ewg_function_DragControl (ControlRef theControl, Point *startPoint, Rect const *limitRect, Rect const *slopRect, DragConstraint axis);
// Wraps call to function 'TestControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TestControl(ewg_param_theControl, ewg_param_testPoint) TestControl ((ControlRef)ewg_param_theControl, *(Point*)ewg_param_testPoint)

ControlPartCode  ewg_function_TestControl (ControlRef theControl, Point *testPoint);
// Wraps call to function 'FindControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FindControl(ewg_param_testPoint, ewg_param_theWindow, ewg_param_theControl) FindControl (*(Point*)ewg_param_testPoint, (WindowRef)ewg_param_theWindow, (ControlRef*)ewg_param_theControl)

ControlPartCode  ewg_function_FindControl (Point *testPoint, WindowRef theWindow, ControlRef *theControl);
// Wraps call to function 'FindControlUnderMouse' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FindControlUnderMouse(ewg_param_inWhere, ewg_param_inWindow, ewg_param_outPart) FindControlUnderMouse (*(Point*)ewg_param_inWhere, (WindowRef)ewg_param_inWindow, (ControlPartCode*)ewg_param_outPart)

ControlRef  ewg_function_FindControlUnderMouse (Point *inWhere, WindowRef inWindow, ControlPartCode *outPart);
// Wraps call to function 'HandleControlClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlClick(ewg_param_inControl, ewg_param_inWhere, ewg_param_inModifiers, ewg_param_inAction) HandleControlClick ((ControlRef)ewg_param_inControl, *(Point*)ewg_param_inWhere, (EventModifiers)ewg_param_inModifiers, (ControlActionUPP)ewg_param_inAction)

ControlPartCode  ewg_function_HandleControlClick (ControlRef inControl, Point *inWhere, EventModifiers inModifiers, ControlActionUPP inAction);
// Wraps call to function 'HandleControlContextualMenuClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlContextualMenuClick(ewg_param_inControl, ewg_param_inWhere, ewg_param_menuDisplayed) HandleControlContextualMenuClick ((ControlRef)ewg_param_inControl, *(Point*)ewg_param_inWhere, (Boolean*)ewg_param_menuDisplayed)

OSStatus  ewg_function_HandleControlContextualMenuClick (ControlRef inControl, Point *inWhere, Boolean *menuDisplayed);
// Wraps call to function 'GetControlClickActivation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlClickActivation(ewg_param_inControl, ewg_param_inWhere, ewg_param_inModifiers, ewg_param_outResult) GetControlClickActivation ((ControlRef)ewg_param_inControl, *(Point*)ewg_param_inWhere, (EventModifiers)ewg_param_inModifiers, (ClickActivationResult*)ewg_param_outResult)

OSStatus  ewg_function_GetControlClickActivation (ControlRef inControl, Point *inWhere, EventModifiers inModifiers, ClickActivationResult *outResult);
// Wraps call to function 'HandleControlKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlKey(ewg_param_inControl, ewg_param_inKeyCode, ewg_param_inCharCode, ewg_param_inModifiers) HandleControlKey ((ControlRef)ewg_param_inControl, (SInt16)ewg_param_inKeyCode, (SInt16)ewg_param_inCharCode, (EventModifiers)ewg_param_inModifiers)

ControlPartCode  ewg_function_HandleControlKey (ControlRef inControl, SInt16 inKeyCode, SInt16 inCharCode, EventModifiers inModifiers);
// Wraps call to function 'HandleControlSetCursor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlSetCursor(ewg_param_control, ewg_param_localPoint, ewg_param_modifiers, ewg_param_cursorWasSet) HandleControlSetCursor ((ControlRef)ewg_param_control, *(Point*)ewg_param_localPoint, (EventModifiers)ewg_param_modifiers, (Boolean*)ewg_param_cursorWasSet)

OSStatus  ewg_function_HandleControlSetCursor (ControlRef control, Point *localPoint, EventModifiers modifiers, Boolean *cursorWasSet);
// Wraps call to function 'MoveControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveControl(ewg_param_theControl, ewg_param_h, ewg_param_v) MoveControl ((ControlRef)ewg_param_theControl, (SInt16)ewg_param_h, (SInt16)ewg_param_v)

void  ewg_function_MoveControl (ControlRef theControl, SInt16 h, SInt16 v);
// Wraps call to function 'SizeControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SizeControl(ewg_param_theControl, ewg_param_w, ewg_param_h) SizeControl ((ControlRef)ewg_param_theControl, (SInt16)ewg_param_w, (SInt16)ewg_param_h)

void  ewg_function_SizeControl (ControlRef theControl, SInt16 w, SInt16 h);
// Wraps call to function 'SetControlTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlTitle(ewg_param_theControl, ewg_param_title) SetControlTitle ((ControlRef)ewg_param_theControl, (ConstStr255Param)ewg_param_title)

void  ewg_function_SetControlTitle (ControlRef theControl, ConstStr255Param title);
// Wraps call to function 'GetControlTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlTitle(ewg_param_theControl, ewg_param_title) GetControlTitle ((ControlRef)ewg_param_theControl, ewg_param_title)

void  ewg_function_GetControlTitle (ControlRef theControl, void *title);
// Wraps call to function 'SetControlTitleWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlTitleWithCFString(ewg_param_inControl, ewg_param_inString) SetControlTitleWithCFString ((ControlRef)ewg_param_inControl, (CFStringRef)ewg_param_inString)

OSStatus  ewg_function_SetControlTitleWithCFString (ControlRef inControl, CFStringRef inString);
// Wraps call to function 'CopyControlTitleAsCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyControlTitleAsCFString(ewg_param_inControl, ewg_param_outString) CopyControlTitleAsCFString ((ControlRef)ewg_param_inControl, (CFStringRef*)ewg_param_outString)

OSStatus  ewg_function_CopyControlTitleAsCFString (ControlRef inControl, CFStringRef *outString);
// Wraps call to function 'GetControlValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlValue(ewg_param_theControl) GetControlValue ((ControlRef)ewg_param_theControl)

SInt16  ewg_function_GetControlValue (ControlRef theControl);
// Wraps call to function 'SetControlValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlValue(ewg_param_theControl, ewg_param_newValue) SetControlValue ((ControlRef)ewg_param_theControl, (SInt16)ewg_param_newValue)

void  ewg_function_SetControlValue (ControlRef theControl, SInt16 newValue);
// Wraps call to function 'GetControlMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlMinimum(ewg_param_theControl) GetControlMinimum ((ControlRef)ewg_param_theControl)

SInt16  ewg_function_GetControlMinimum (ControlRef theControl);
// Wraps call to function 'SetControlMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlMinimum(ewg_param_theControl, ewg_param_newMinimum) SetControlMinimum ((ControlRef)ewg_param_theControl, (SInt16)ewg_param_newMinimum)

void  ewg_function_SetControlMinimum (ControlRef theControl, SInt16 newMinimum);
// Wraps call to function 'GetControlMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlMaximum(ewg_param_theControl) GetControlMaximum ((ControlRef)ewg_param_theControl)

SInt16  ewg_function_GetControlMaximum (ControlRef theControl);
// Wraps call to function 'SetControlMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlMaximum(ewg_param_theControl, ewg_param_newMaximum) SetControlMaximum ((ControlRef)ewg_param_theControl, (SInt16)ewg_param_newMaximum)

void  ewg_function_SetControlMaximum (ControlRef theControl, SInt16 newMaximum);
// Wraps call to function 'GetControlViewSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlViewSize(ewg_param_theControl) GetControlViewSize ((ControlRef)ewg_param_theControl)

SInt32  ewg_function_GetControlViewSize (ControlRef theControl);
// Wraps call to function 'SetControlViewSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlViewSize(ewg_param_theControl, ewg_param_newViewSize) SetControlViewSize ((ControlRef)ewg_param_theControl, (SInt32)ewg_param_newViewSize)

void  ewg_function_SetControlViewSize (ControlRef theControl, SInt32 newViewSize);
// Wraps call to function 'GetControl32BitValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControl32BitValue(ewg_param_theControl) GetControl32BitValue ((ControlRef)ewg_param_theControl)

SInt32  ewg_function_GetControl32BitValue (ControlRef theControl);
// Wraps call to function 'SetControl32BitValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControl32BitValue(ewg_param_theControl, ewg_param_newValue) SetControl32BitValue ((ControlRef)ewg_param_theControl, (SInt32)ewg_param_newValue)

void  ewg_function_SetControl32BitValue (ControlRef theControl, SInt32 newValue);
// Wraps call to function 'GetControl32BitMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControl32BitMaximum(ewg_param_theControl) GetControl32BitMaximum ((ControlRef)ewg_param_theControl)

SInt32  ewg_function_GetControl32BitMaximum (ControlRef theControl);
// Wraps call to function 'SetControl32BitMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControl32BitMaximum(ewg_param_theControl, ewg_param_newMaximum) SetControl32BitMaximum ((ControlRef)ewg_param_theControl, (SInt32)ewg_param_newMaximum)

void  ewg_function_SetControl32BitMaximum (ControlRef theControl, SInt32 newMaximum);
// Wraps call to function 'GetControl32BitMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControl32BitMinimum(ewg_param_theControl) GetControl32BitMinimum ((ControlRef)ewg_param_theControl)

SInt32  ewg_function_GetControl32BitMinimum (ControlRef theControl);
// Wraps call to function 'SetControl32BitMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControl32BitMinimum(ewg_param_theControl, ewg_param_newMinimum) SetControl32BitMinimum ((ControlRef)ewg_param_theControl, (SInt32)ewg_param_newMinimum)

void  ewg_function_SetControl32BitMinimum (ControlRef theControl, SInt32 newMinimum);
// Wraps call to function 'IsValidControlHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsValidControlHandle(ewg_param_theControl) IsValidControlHandle ((ControlRef)ewg_param_theControl)

Boolean  ewg_function_IsValidControlHandle (ControlRef theControl);
// Wraps call to function 'SetControlID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlID(ewg_param_inControl, ewg_param_inID) SetControlID ((ControlRef)ewg_param_inControl, (ControlID const*)ewg_param_inID)

OSStatus  ewg_function_SetControlID (ControlRef inControl, ControlID const *inID);
// Wraps call to function 'GetControlID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlID(ewg_param_inControl, ewg_param_outID) GetControlID ((ControlRef)ewg_param_inControl, (ControlID*)ewg_param_outID)

OSStatus  ewg_function_GetControlID (ControlRef inControl, ControlID *outID);
// Wraps call to function 'GetControlByID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlByID(ewg_param_inWindow, ewg_param_inID, ewg_param_outControl) GetControlByID ((WindowRef)ewg_param_inWindow, (ControlID const*)ewg_param_inID, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_GetControlByID (WindowRef inWindow, ControlID const *inID, ControlRef *outControl);
// Wraps call to function 'SetControlCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlCommandID(ewg_param_inControl, ewg_param_inCommandID) SetControlCommandID ((ControlRef)ewg_param_inControl, (UInt32)ewg_param_inCommandID)

OSStatus  ewg_function_SetControlCommandID (ControlRef inControl, UInt32 inCommandID);
// Wraps call to function 'GetControlCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlCommandID(ewg_param_inControl, ewg_param_outCommandID) GetControlCommandID ((ControlRef)ewg_param_inControl, (UInt32*)ewg_param_outCommandID)

OSStatus  ewg_function_GetControlCommandID (ControlRef inControl, UInt32 *outCommandID);
// Wraps call to function 'GetControlKind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlKind(ewg_param_inControl, ewg_param_outControlKind) GetControlKind ((ControlRef)ewg_param_inControl, (ControlKind*)ewg_param_outControlKind)

OSStatus  ewg_function_GetControlKind (ControlRef inControl, ControlKind *outControlKind);
// Wraps call to function 'GetControlProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlProperty(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_bufferSize, ewg_param_actualSize, ewg_param_propertyBuffer) GetControlProperty ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_bufferSize, (UInt32*)ewg_param_actualSize, (void*)ewg_param_propertyBuffer)

OSStatus  ewg_function_GetControlProperty (ControlRef control, OSType propertyCreator, OSType propertyTag, UInt32 bufferSize, UInt32 *actualSize, void *propertyBuffer);
// Wraps call to function 'GetControlPropertySize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlPropertySize(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_size) GetControlPropertySize ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32*)ewg_param_size)

OSStatus  ewg_function_GetControlPropertySize (ControlRef control, OSType propertyCreator, OSType propertyTag, UInt32 *size);
// Wraps call to function 'SetControlProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlProperty(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_propertySize, ewg_param_propertyData) SetControlProperty ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_propertySize, (void const*)ewg_param_propertyData)

OSStatus  ewg_function_SetControlProperty (ControlRef control, OSType propertyCreator, OSType propertyTag, UInt32 propertySize, void const *propertyData);
// Wraps call to function 'RemoveControlProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveControlProperty(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag) RemoveControlProperty ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag)

OSStatus  ewg_function_RemoveControlProperty (ControlRef control, OSType propertyCreator, OSType propertyTag);
// Wraps call to function 'GetControlPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlPropertyAttributes(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributes) GetControlPropertyAttributes ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32*)ewg_param_attributes)

OSStatus  ewg_function_GetControlPropertyAttributes (ControlRef control, OSType propertyCreator, OSType propertyTag, UInt32 *attributes);
// Wraps call to function 'ChangeControlPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeControlPropertyAttributes(ewg_param_control, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributesToSet, ewg_param_attributesToClear) ChangeControlPropertyAttributes ((ControlRef)ewg_param_control, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_attributesToSet, (UInt32)ewg_param_attributesToClear)

OSStatus  ewg_function_ChangeControlPropertyAttributes (ControlRef control, OSType propertyCreator, OSType propertyTag, UInt32 attributesToSet, UInt32 attributesToClear);
// Wraps call to function 'GetControlRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlRegion(ewg_param_inControl, ewg_param_inPart, ewg_param_outRegion) GetControlRegion ((ControlRef)ewg_param_inControl, (ControlPartCode)ewg_param_inPart, (RgnHandle)ewg_param_outRegion)

OSStatus  ewg_function_GetControlRegion (ControlRef inControl, ControlPartCode inPart, RgnHandle outRegion);
// Wraps call to function 'GetControlVariant' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlVariant(ewg_param_theControl) GetControlVariant ((ControlRef)ewg_param_theControl)

ControlVariant  ewg_function_GetControlVariant (ControlRef theControl);
// Wraps call to function 'SetControlAction' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlAction(ewg_param_theControl, ewg_param_actionProc) SetControlAction ((ControlRef)ewg_param_theControl, (ControlActionUPP)ewg_param_actionProc)

void  ewg_function_SetControlAction (ControlRef theControl, ControlActionUPP actionProc);
// Wraps call to function 'GetControlAction' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlAction(ewg_param_theControl) GetControlAction ((ControlRef)ewg_param_theControl)

ControlActionUPP  ewg_function_GetControlAction (ControlRef theControl);
// Wraps call to function 'SetControlReference' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlReference(ewg_param_theControl, ewg_param_data) SetControlReference ((ControlRef)ewg_param_theControl, (SInt32)ewg_param_data)

void  ewg_function_SetControlReference (ControlRef theControl, SInt32 data);
// Wraps call to function 'GetControlReference' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlReference(ewg_param_theControl) GetControlReference ((ControlRef)ewg_param_theControl)

SInt32  ewg_function_GetControlReference (ControlRef theControl);
// Wraps call to function 'SendControlMessage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SendControlMessage(ewg_param_inControl, ewg_param_inMessage, ewg_param_inParam) SendControlMessage ((ControlRef)ewg_param_inControl, (SInt16)ewg_param_inMessage, (void*)ewg_param_inParam)

SInt32  ewg_function_SendControlMessage (ControlRef inControl, SInt16 inMessage, void *inParam);
// Wraps call to function 'DumpControlHierarchy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DumpControlHierarchy(ewg_param_inWindow, ewg_param_inDumpFile) DumpControlHierarchy ((WindowRef)ewg_param_inWindow, (FSSpec const*)ewg_param_inDumpFile)

OSErr  ewg_function_DumpControlHierarchy (WindowRef inWindow, FSSpec const *inDumpFile);
// Wraps call to function 'CreateRootControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateRootControl(ewg_param_inWindow, ewg_param_outControl) CreateRootControl ((WindowRef)ewg_param_inWindow, (ControlRef*)ewg_param_outControl)

OSErr  ewg_function_CreateRootControl (WindowRef inWindow, ControlRef *outControl);
// Wraps call to function 'GetRootControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetRootControl(ewg_param_inWindow, ewg_param_outControl) GetRootControl ((WindowRef)ewg_param_inWindow, (ControlRef*)ewg_param_outControl)

OSErr  ewg_function_GetRootControl (WindowRef inWindow, ControlRef *outControl);
// Wraps call to function 'EmbedControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EmbedControl(ewg_param_inControl, ewg_param_inContainer) EmbedControl ((ControlRef)ewg_param_inControl, (ControlRef)ewg_param_inContainer)

OSErr  ewg_function_EmbedControl (ControlRef inControl, ControlRef inContainer);
// Wraps call to function 'AutoEmbedControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AutoEmbedControl(ewg_param_inControl, ewg_param_inWindow) AutoEmbedControl ((ControlRef)ewg_param_inControl, (WindowRef)ewg_param_inWindow)

OSErr  ewg_function_AutoEmbedControl (ControlRef inControl, WindowRef inWindow);
// Wraps call to function 'GetSuperControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetSuperControl(ewg_param_inControl, ewg_param_outParent) GetSuperControl ((ControlRef)ewg_param_inControl, (ControlRef*)ewg_param_outParent)

OSErr  ewg_function_GetSuperControl (ControlRef inControl, ControlRef *outParent);
// Wraps call to function 'CountSubControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CountSubControls(ewg_param_inControl, ewg_param_outNumChildren) CountSubControls ((ControlRef)ewg_param_inControl, (UInt16*)ewg_param_outNumChildren)

OSErr  ewg_function_CountSubControls (ControlRef inControl, UInt16 *outNumChildren);
// Wraps call to function 'GetIndexedSubControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetIndexedSubControl(ewg_param_inControl, ewg_param_inIndex, ewg_param_outSubControl) GetIndexedSubControl ((ControlRef)ewg_param_inControl, (UInt16)ewg_param_inIndex, (ControlRef*)ewg_param_outSubControl)

OSErr  ewg_function_GetIndexedSubControl (ControlRef inControl, UInt16 inIndex, ControlRef *outSubControl);
// Wraps call to function 'SetControlSupervisor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlSupervisor(ewg_param_inControl, ewg_param_inBoss) SetControlSupervisor ((ControlRef)ewg_param_inControl, (ControlRef)ewg_param_inBoss)

OSErr  ewg_function_SetControlSupervisor (ControlRef inControl, ControlRef inBoss);
// Wraps call to function 'GetKeyboardFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetKeyboardFocus(ewg_param_inWindow, ewg_param_outControl) GetKeyboardFocus ((WindowRef)ewg_param_inWindow, (ControlRef*)ewg_param_outControl)

OSErr  ewg_function_GetKeyboardFocus (WindowRef inWindow, ControlRef *outControl);
// Wraps call to function 'SetKeyboardFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetKeyboardFocus(ewg_param_inWindow, ewg_param_inControl, ewg_param_inPart) SetKeyboardFocus ((WindowRef)ewg_param_inWindow, (ControlRef)ewg_param_inControl, (ControlFocusPart)ewg_param_inPart)

OSErr  ewg_function_SetKeyboardFocus (WindowRef inWindow, ControlRef inControl, ControlFocusPart inPart);
// Wraps call to function 'AdvanceKeyboardFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AdvanceKeyboardFocus(ewg_param_inWindow) AdvanceKeyboardFocus ((WindowRef)ewg_param_inWindow)

OSErr  ewg_function_AdvanceKeyboardFocus (WindowRef inWindow);
// Wraps call to function 'ReverseKeyboardFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReverseKeyboardFocus(ewg_param_inWindow) ReverseKeyboardFocus ((WindowRef)ewg_param_inWindow)

OSErr  ewg_function_ReverseKeyboardFocus (WindowRef inWindow);
// Wraps call to function 'ClearKeyboardFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ClearKeyboardFocus(ewg_param_inWindow) ClearKeyboardFocus ((WindowRef)ewg_param_inWindow)

OSErr  ewg_function_ClearKeyboardFocus (WindowRef inWindow);
// Wraps call to function 'GetControlFeatures' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlFeatures(ewg_param_inControl, ewg_param_outFeatures) GetControlFeatures ((ControlRef)ewg_param_inControl, (UInt32*)ewg_param_outFeatures)

OSErr  ewg_function_GetControlFeatures (ControlRef inControl, UInt32 *outFeatures);
// Wraps call to function 'SetControlData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlData(ewg_param_inControl, ewg_param_inPart, ewg_param_inTagName, ewg_param_inSize, ewg_param_inData) SetControlData ((ControlRef)ewg_param_inControl, (ControlPartCode)ewg_param_inPart, (ResType)ewg_param_inTagName, (Size)ewg_param_inSize, (void const*)ewg_param_inData)

OSErr  ewg_function_SetControlData (ControlRef inControl, ControlPartCode inPart, ResType inTagName, Size inSize, void const *inData);
// Wraps call to function 'GetControlData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlData(ewg_param_inControl, ewg_param_inPart, ewg_param_inTagName, ewg_param_inBufferSize, ewg_param_inBuffer, ewg_param_outActualSize) GetControlData ((ControlRef)ewg_param_inControl, (ControlPartCode)ewg_param_inPart, (ResType)ewg_param_inTagName, (Size)ewg_param_inBufferSize, (void*)ewg_param_inBuffer, (Size*)ewg_param_outActualSize)

OSErr  ewg_function_GetControlData (ControlRef inControl, ControlPartCode inPart, ResType inTagName, Size inBufferSize, void *inBuffer, Size *outActualSize);
// Wraps call to function 'GetControlDataSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlDataSize(ewg_param_inControl, ewg_param_inPart, ewg_param_inTagName, ewg_param_outMaxSize) GetControlDataSize ((ControlRef)ewg_param_inControl, (ControlPartCode)ewg_param_inPart, (ResType)ewg_param_inTagName, (Size*)ewg_param_outMaxSize)

OSErr  ewg_function_GetControlDataSize (ControlRef inControl, ControlPartCode inPart, ResType inTagName, Size *outMaxSize);
// Wraps call to function 'HandleControlDragTracking' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlDragTracking(ewg_param_inControl, ewg_param_inMessage, ewg_param_inDrag, ewg_param_outLikesDrag) HandleControlDragTracking ((ControlRef)ewg_param_inControl, (DragTrackingMessage)ewg_param_inMessage, (DragReference)ewg_param_inDrag, (Boolean*)ewg_param_outLikesDrag)

OSStatus  ewg_function_HandleControlDragTracking (ControlRef inControl, DragTrackingMessage inMessage, DragReference inDrag, Boolean *outLikesDrag);
// Wraps call to function 'HandleControlDragReceive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HandleControlDragReceive(ewg_param_inControl, ewg_param_inDrag) HandleControlDragReceive ((ControlRef)ewg_param_inControl, (DragReference)ewg_param_inDrag)

OSStatus  ewg_function_HandleControlDragReceive (ControlRef inControl, DragReference inDrag);
// Wraps call to function 'SetControlDragTrackingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlDragTrackingEnabled(ewg_param_inControl, ewg_param_inTracks) SetControlDragTrackingEnabled ((ControlRef)ewg_param_inControl, (Boolean)ewg_param_inTracks)

OSStatus  ewg_function_SetControlDragTrackingEnabled (ControlRef inControl, Boolean inTracks);
// Wraps call to function 'IsControlDragTrackingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsControlDragTrackingEnabled(ewg_param_inControl, ewg_param_outTracks) IsControlDragTrackingEnabled ((ControlRef)ewg_param_inControl, (Boolean*)ewg_param_outTracks)

OSStatus  ewg_function_IsControlDragTrackingEnabled (ControlRef inControl, Boolean *outTracks);
// Wraps call to function 'SetAutomaticControlDragTrackingEnabledForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetAutomaticControlDragTrackingEnabledForWindow(ewg_param_inWindow, ewg_param_inTracks) SetAutomaticControlDragTrackingEnabledForWindow ((WindowRef)ewg_param_inWindow, (Boolean)ewg_param_inTracks)

OSStatus  ewg_function_SetAutomaticControlDragTrackingEnabledForWindow (WindowRef inWindow, Boolean inTracks);
// Wraps call to function 'IsAutomaticControlDragTrackingEnabledForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsAutomaticControlDragTrackingEnabledForWindow(ewg_param_inWindow, ewg_param_outTracks) IsAutomaticControlDragTrackingEnabledForWindow ((WindowRef)ewg_param_inWindow, (Boolean*)ewg_param_outTracks)

OSStatus  ewg_function_IsAutomaticControlDragTrackingEnabledForWindow (WindowRef inWindow, Boolean *outTracks);
// Wraps call to function 'GetControlBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlBounds(ewg_param_control, ewg_param_bounds) GetControlBounds ((ControlRef)ewg_param_control, (Rect*)ewg_param_bounds)

Rect * ewg_function_GetControlBounds (ControlRef control, Rect *bounds);
// Wraps call to function 'IsControlHilited' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsControlHilited(ewg_param_control) IsControlHilited ((ControlRef)ewg_param_control)

Boolean  ewg_function_IsControlHilited (ControlRef control);
// Wraps call to function 'GetControlHilite' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlHilite(ewg_param_control) GetControlHilite ((ControlRef)ewg_param_control)

UInt16  ewg_function_GetControlHilite (ControlRef control);
// Wraps call to function 'GetControlOwner' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlOwner(ewg_param_control) GetControlOwner ((ControlRef)ewg_param_control)

WindowRef  ewg_function_GetControlOwner (ControlRef control);
// Wraps call to function 'GetControlDataHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlDataHandle(ewg_param_control) GetControlDataHandle ((ControlRef)ewg_param_control)

Handle  ewg_function_GetControlDataHandle (ControlRef control);
// Wraps call to function 'GetControlPopupMenuHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlPopupMenuHandle(ewg_param_control) GetControlPopupMenuHandle ((ControlRef)ewg_param_control)

MenuRef  ewg_function_GetControlPopupMenuHandle (ControlRef control);
// Wraps call to function 'GetControlPopupMenuID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlPopupMenuID(ewg_param_control) GetControlPopupMenuID ((ControlRef)ewg_param_control)

short  ewg_function_GetControlPopupMenuID (ControlRef control);
// Wraps call to function 'SetControlDataHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlDataHandle(ewg_param_control, ewg_param_dataHandle) SetControlDataHandle ((ControlRef)ewg_param_control, (Handle)ewg_param_dataHandle)

void  ewg_function_SetControlDataHandle (ControlRef control, Handle dataHandle);
// Wraps call to function 'SetControlBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlBounds(ewg_param_control, ewg_param_bounds) SetControlBounds ((ControlRef)ewg_param_control, (Rect const*)ewg_param_bounds)

void  ewg_function_SetControlBounds (ControlRef control, Rect const *bounds);
// Wraps call to function 'SetControlPopupMenuHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlPopupMenuHandle(ewg_param_control, ewg_param_popupMenu) SetControlPopupMenuHandle ((ControlRef)ewg_param_control, (MenuRef)ewg_param_popupMenu)

void  ewg_function_SetControlPopupMenuHandle (ControlRef control, MenuRef popupMenu);
// Wraps call to function 'SetControlPopupMenuID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetControlPopupMenuID(ewg_param_control, ewg_param_menuID) SetControlPopupMenuID ((ControlRef)ewg_param_control, (short)ewg_param_menuID)

void  ewg_function_SetControlPopupMenuID (ControlRef control, short menuID);
// Wraps call to function 'IdleControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IdleControls(ewg_param_inWindow) IdleControls ((WindowRef)ewg_param_inWindow)

void  ewg_function_IdleControls (WindowRef inWindow);
// Wraps call to function 'NewWindowDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewWindowDefUPP(ewg_param_userRoutine) NewWindowDefUPP ((WindowDefProcPtr)ewg_param_userRoutine)

WindowDefUPP  ewg_function_NewWindowDefUPP (WindowDefProcPtr userRoutine);
// Wraps call to function 'NewWindowPaintUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewWindowPaintUPP(ewg_param_userRoutine) NewWindowPaintUPP ((WindowPaintProcPtr)ewg_param_userRoutine)

WindowPaintUPP  ewg_function_NewWindowPaintUPP (WindowPaintProcPtr userRoutine);
// Wraps call to function 'DisposeWindowDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeWindowDefUPP(ewg_param_userUPP) DisposeWindowDefUPP ((WindowDefUPP)ewg_param_userUPP)

void  ewg_function_DisposeWindowDefUPP (WindowDefUPP userUPP);
// Wraps call to function 'DisposeWindowPaintUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeWindowPaintUPP(ewg_param_userUPP) DisposeWindowPaintUPP ((WindowPaintUPP)ewg_param_userUPP)

void  ewg_function_DisposeWindowPaintUPP (WindowPaintUPP userUPP);
// Wraps call to function 'InvokeWindowDefUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeWindowDefUPP(ewg_param_varCode, ewg_param_window, ewg_param_message, ewg_param_param, ewg_param_userUPP) InvokeWindowDefUPP ((short)ewg_param_varCode, (WindowRef)ewg_param_window, (short)ewg_param_message, (long)ewg_param_param, (WindowDefUPP)ewg_param_userUPP)

long  ewg_function_InvokeWindowDefUPP (short varCode, WindowRef window, short message, long param, WindowDefUPP userUPP);
// Wraps call to function 'InvokeWindowPaintUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeWindowPaintUPP(ewg_param_device, ewg_param_qdContext, ewg_param_window, ewg_param_inClientPaintRgn, ewg_param_outSystemPaintRgn, ewg_param_refCon, ewg_param_userUPP) InvokeWindowPaintUPP ((GDHandle)ewg_param_device, (GrafPtr)ewg_param_qdContext, (WindowRef)ewg_param_window, (RgnHandle)ewg_param_inClientPaintRgn, (RgnHandle)ewg_param_outSystemPaintRgn, (void*)ewg_param_refCon, (WindowPaintUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeWindowPaintUPP (GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon, WindowPaintUPP userUPP);
// Wraps call to function 'GetNewCWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNewCWindow(ewg_param_windowID, ewg_param_wStorage, ewg_param_behind) GetNewCWindow ((short)ewg_param_windowID, (void*)ewg_param_wStorage, (WindowRef)ewg_param_behind)

WindowRef  ewg_function_GetNewCWindow (short windowID, void *wStorage, WindowRef behind);
// Wraps call to function 'NewWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewWindow(ewg_param_wStorage, ewg_param_boundsRect, ewg_param_title, ewg_param_visible, ewg_param_theProc, ewg_param_behind, ewg_param_goAwayFlag, ewg_param_refCon) NewWindow ((void*)ewg_param_wStorage, (Rect const*)ewg_param_boundsRect, (ConstStr255Param)ewg_param_title, (Boolean)ewg_param_visible, (short)ewg_param_theProc, (WindowRef)ewg_param_behind, (Boolean)ewg_param_goAwayFlag, (long)ewg_param_refCon)

WindowRef  ewg_function_NewWindow (void *wStorage, Rect const *boundsRect, ConstStr255Param title, Boolean visible, short theProc, WindowRef behind, Boolean goAwayFlag, long refCon);
// Wraps call to function 'GetNewWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNewWindow(ewg_param_windowID, ewg_param_wStorage, ewg_param_behind) GetNewWindow ((short)ewg_param_windowID, (void*)ewg_param_wStorage, (WindowRef)ewg_param_behind)

WindowRef  ewg_function_GetNewWindow (short windowID, void *wStorage, WindowRef behind);
// Wraps call to function 'NewCWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewCWindow(ewg_param_wStorage, ewg_param_boundsRect, ewg_param_title, ewg_param_visible, ewg_param_procID, ewg_param_behind, ewg_param_goAwayFlag, ewg_param_refCon) NewCWindow ((void*)ewg_param_wStorage, (Rect const*)ewg_param_boundsRect, (ConstStr255Param)ewg_param_title, (Boolean)ewg_param_visible, (short)ewg_param_procID, (WindowRef)ewg_param_behind, (Boolean)ewg_param_goAwayFlag, (long)ewg_param_refCon)

WindowRef  ewg_function_NewCWindow (void *wStorage, Rect const *boundsRect, ConstStr255Param title, Boolean visible, short procID, WindowRef behind, Boolean goAwayFlag, long refCon);
// Wraps call to function 'DisposeWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeWindow(ewg_param_window) DisposeWindow ((WindowRef)ewg_param_window)

void  ewg_function_DisposeWindow (WindowRef window);
// Wraps call to function 'CreateNewWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateNewWindow(ewg_param_windowClass, ewg_param_attributes, ewg_param_contentBounds, ewg_param_outWindow) CreateNewWindow ((WindowClass)ewg_param_windowClass, (WindowAttributes)ewg_param_attributes, (Rect const*)ewg_param_contentBounds, (WindowRef*)ewg_param_outWindow)

OSStatus  ewg_function_CreateNewWindow (WindowClass windowClass, WindowAttributes attributes, Rect const *contentBounds, WindowRef *outWindow);
// Wraps call to function 'CreateWindowFromResource' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateWindowFromResource(ewg_param_resID, ewg_param_outWindow) CreateWindowFromResource ((SInt16)ewg_param_resID, (WindowRef*)ewg_param_outWindow)

OSStatus  ewg_function_CreateWindowFromResource (SInt16 resID, WindowRef *outWindow);
// Wraps call to function 'StoreWindowIntoCollection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_StoreWindowIntoCollection(ewg_param_window, ewg_param_collection) StoreWindowIntoCollection ((WindowRef)ewg_param_window, (Collection)ewg_param_collection)

OSStatus  ewg_function_StoreWindowIntoCollection (WindowRef window, Collection collection);
// Wraps call to function 'CreateWindowFromCollection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateWindowFromCollection(ewg_param_collection, ewg_param_outWindow) CreateWindowFromCollection ((Collection)ewg_param_collection, (WindowRef*)ewg_param_outWindow)

OSStatus  ewg_function_CreateWindowFromCollection (Collection collection, WindowRef *outWindow);
// Wraps call to function 'GetWindowOwnerCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowOwnerCount(ewg_param_window, ewg_param_outCount) GetWindowOwnerCount ((WindowRef)ewg_param_window, (UInt32*)ewg_param_outCount)

OSStatus  ewg_function_GetWindowOwnerCount (WindowRef window, UInt32 *outCount);
// Wraps call to function 'CloneWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CloneWindow(ewg_param_window) CloneWindow ((WindowRef)ewg_param_window)

OSStatus  ewg_function_CloneWindow (WindowRef window);
// Wraps call to function 'GetWindowRetainCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowRetainCount(ewg_param_inWindow) GetWindowRetainCount ((WindowRef)ewg_param_inWindow)

ItemCount  ewg_function_GetWindowRetainCount (WindowRef inWindow);
// Wraps call to function 'RetainWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RetainWindow(ewg_param_inWindow) RetainWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_RetainWindow (WindowRef inWindow);
// Wraps call to function 'ReleaseWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseWindow(ewg_param_inWindow) ReleaseWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_ReleaseWindow (WindowRef inWindow);
// Wraps call to function 'CreateCustomWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateCustomWindow(ewg_param_def, ewg_param_windowClass, ewg_param_attributes, ewg_param_contentBounds, ewg_param_outWindow) CreateCustomWindow ((WindowDefSpec const*)ewg_param_def, (WindowClass)ewg_param_windowClass, (WindowAttributes)ewg_param_attributes, (Rect const*)ewg_param_contentBounds, (WindowRef*)ewg_param_outWindow)

OSStatus  ewg_function_CreateCustomWindow (WindowDefSpec const *def, WindowClass windowClass, WindowAttributes attributes, Rect const *contentBounds, WindowRef *outWindow);
// Wraps call to function 'ReshapeCustomWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReshapeCustomWindow(ewg_param_window) ReshapeCustomWindow ((WindowRef)ewg_param_window)

OSStatus  ewg_function_ReshapeCustomWindow (WindowRef window);
// Wraps call to function 'RegisterWindowDefinition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RegisterWindowDefinition(ewg_param_inResID, ewg_param_inDefSpec) RegisterWindowDefinition ((SInt16)ewg_param_inResID, (WindowDefSpec const*)ewg_param_inDefSpec)

OSStatus  ewg_function_RegisterWindowDefinition (SInt16 inResID, WindowDefSpec const *inDefSpec);
// Wraps call to function 'GetWindowWidgetHilite' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowWidgetHilite(ewg_param_inWindow, ewg_param_outHilite) GetWindowWidgetHilite ((WindowRef)ewg_param_inWindow, (WindowDefPartCode*)ewg_param_outHilite)

OSStatus  ewg_function_GetWindowWidgetHilite (WindowRef inWindow, WindowDefPartCode *outHilite);
// Wraps call to function 'IsValidWindowClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsValidWindowClass(ewg_param_inClass) IsValidWindowClass ((WindowClass)ewg_param_inClass)

Boolean  ewg_function_IsValidWindowClass (WindowClass inClass);
// Wraps call to function 'GetAvailableWindowAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetAvailableWindowAttributes(ewg_param_inClass) GetAvailableWindowAttributes ((WindowClass)ewg_param_inClass)

WindowAttributes  ewg_function_GetAvailableWindowAttributes (WindowClass inClass);
// Wraps call to function 'GetWindowClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowClass(ewg_param_window, ewg_param_outClass) GetWindowClass ((WindowRef)ewg_param_window, (WindowClass*)ewg_param_outClass)

OSStatus  ewg_function_GetWindowClass (WindowRef window, WindowClass *outClass);
// Wraps call to function 'GetWindowAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowAttributes(ewg_param_window, ewg_param_outAttributes) GetWindowAttributes ((WindowRef)ewg_param_window, (WindowAttributes*)ewg_param_outAttributes)

OSStatus  ewg_function_GetWindowAttributes (WindowRef window, WindowAttributes *outAttributes);
// Wraps call to function 'ChangeWindowAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeWindowAttributes(ewg_param_window, ewg_param_setTheseAttributes, ewg_param_clearTheseAttributes) ChangeWindowAttributes ((WindowRef)ewg_param_window, (WindowAttributes)ewg_param_setTheseAttributes, (WindowAttributes)ewg_param_clearTheseAttributes)

OSStatus  ewg_function_ChangeWindowAttributes (WindowRef window, WindowAttributes setTheseAttributes, WindowAttributes clearTheseAttributes);
// Wraps call to function 'SetWindowClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowClass(ewg_param_inWindow, ewg_param_inWindowClass) SetWindowClass ((WindowRef)ewg_param_inWindow, (WindowClass)ewg_param_inWindowClass)

OSStatus  ewg_function_SetWindowClass (WindowRef inWindow, WindowClass inWindowClass);
// Wraps call to function 'HIWindowChangeClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowChangeClass(ewg_param_inWindow, ewg_param_inWindowClass) HIWindowChangeClass ((HIWindowRef)ewg_param_inWindow, (WindowClass)ewg_param_inWindowClass)

OSStatus  ewg_function_HIWindowChangeClass (HIWindowRef inWindow, WindowClass inWindowClass);
// Wraps call to function 'HIWindowFlush' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowFlush(ewg_param_inWindow) HIWindowFlush ((HIWindowRef)ewg_param_inWindow)

OSStatus  ewg_function_HIWindowFlush (HIWindowRef inWindow);
// Wraps call to function 'SetWindowModality' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowModality(ewg_param_inWindow, ewg_param_inModalKind, ewg_param_inUnavailableWindow) SetWindowModality ((WindowRef)ewg_param_inWindow, (WindowModality)ewg_param_inModalKind, (WindowRef)ewg_param_inUnavailableWindow)

OSStatus  ewg_function_SetWindowModality (WindowRef inWindow, WindowModality inModalKind, WindowRef inUnavailableWindow);
// Wraps call to function 'GetWindowModality' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowModality(ewg_param_inWindow, ewg_param_outModalKind, ewg_param_outUnavailableWindow) GetWindowModality ((WindowRef)ewg_param_inWindow, (WindowModality*)ewg_param_outModalKind, (WindowRef*)ewg_param_outUnavailableWindow)

OSStatus  ewg_function_GetWindowModality (WindowRef inWindow, WindowModality *outModalKind, WindowRef *outUnavailableWindow);
// Wraps call to function 'HIWindowIsDocumentModalTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowIsDocumentModalTarget(ewg_param_inWindow, ewg_param_outOwner) HIWindowIsDocumentModalTarget ((HIWindowRef)ewg_param_inWindow, (HIWindowRef*)ewg_param_outOwner)

Boolean  ewg_function_HIWindowIsDocumentModalTarget (HIWindowRef inWindow, HIWindowRef *outOwner);
// Wraps call to function 'ShowFloatingWindows' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowFloatingWindows ShowFloatingWindows ()

OSStatus  ewg_function_ShowFloatingWindows (void);
// Wraps call to function 'HideFloatingWindows' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HideFloatingWindows HideFloatingWindows ()

OSStatus  ewg_function_HideFloatingWindows (void);
// Wraps call to function 'AreFloatingWindowsVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AreFloatingWindowsVisible AreFloatingWindowsVisible ()

Boolean  ewg_function_AreFloatingWindowsVisible (void);
// Wraps call to function 'CreateWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateWindowGroup(ewg_param_inAttributes, ewg_param_outGroup) CreateWindowGroup ((WindowGroupAttributes)ewg_param_inAttributes, (WindowGroupRef*)ewg_param_outGroup)

OSStatus  ewg_function_CreateWindowGroup (WindowGroupAttributes inAttributes, WindowGroupRef *outGroup);
// Wraps call to function 'RetainWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RetainWindowGroup(ewg_param_inGroup) RetainWindowGroup ((WindowGroupRef)ewg_param_inGroup)

OSStatus  ewg_function_RetainWindowGroup (WindowGroupRef inGroup);
// Wraps call to function 'ReleaseWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseWindowGroup(ewg_param_inGroup) ReleaseWindowGroup ((WindowGroupRef)ewg_param_inGroup)

OSStatus  ewg_function_ReleaseWindowGroup (WindowGroupRef inGroup);
// Wraps call to function 'GetWindowGroupRetainCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupRetainCount(ewg_param_inGroup) GetWindowGroupRetainCount ((WindowGroupRef)ewg_param_inGroup)

ItemCount  ewg_function_GetWindowGroupRetainCount (WindowGroupRef inGroup);
// Wraps call to function 'GetWindowGroupOfClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupOfClass(ewg_param_windowClass) GetWindowGroupOfClass ((WindowClass)ewg_param_windowClass)

WindowGroupRef  ewg_function_GetWindowGroupOfClass (WindowClass windowClass);
// Wraps call to function 'SetWindowGroupName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroupName(ewg_param_inGroup, ewg_param_inName) SetWindowGroupName ((WindowGroupRef)ewg_param_inGroup, (CFStringRef)ewg_param_inName)

OSStatus  ewg_function_SetWindowGroupName (WindowGroupRef inGroup, CFStringRef inName);
// Wraps call to function 'CopyWindowGroupName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyWindowGroupName(ewg_param_inGroup, ewg_param_outName) CopyWindowGroupName ((WindowGroupRef)ewg_param_inGroup, (CFStringRef*)ewg_param_outName)

OSStatus  ewg_function_CopyWindowGroupName (WindowGroupRef inGroup, CFStringRef *outName);
// Wraps call to function 'GetWindowGroupAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupAttributes(ewg_param_inGroup, ewg_param_outAttributes) GetWindowGroupAttributes ((WindowGroupRef)ewg_param_inGroup, (WindowGroupAttributes*)ewg_param_outAttributes)

OSStatus  ewg_function_GetWindowGroupAttributes (WindowGroupRef inGroup, WindowGroupAttributes *outAttributes);
// Wraps call to function 'ChangeWindowGroupAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeWindowGroupAttributes(ewg_param_inGroup, ewg_param_setTheseAttributes, ewg_param_clearTheseAttributes) ChangeWindowGroupAttributes ((WindowGroupRef)ewg_param_inGroup, (WindowGroupAttributes)ewg_param_setTheseAttributes, (WindowGroupAttributes)ewg_param_clearTheseAttributes)

OSStatus  ewg_function_ChangeWindowGroupAttributes (WindowGroupRef inGroup, WindowGroupAttributes setTheseAttributes, WindowGroupAttributes clearTheseAttributes);
// Wraps call to function 'SetWindowGroupLevel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroupLevel(ewg_param_inGroup, ewg_param_inLevel) SetWindowGroupLevel ((WindowGroupRef)ewg_param_inGroup, (SInt32)ewg_param_inLevel)

OSStatus  ewg_function_SetWindowGroupLevel (WindowGroupRef inGroup, SInt32 inLevel);
// Wraps call to function 'GetWindowGroupLevel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupLevel(ewg_param_inGroup, ewg_param_outLevel) GetWindowGroupLevel ((WindowGroupRef)ewg_param_inGroup, (SInt32*)ewg_param_outLevel)

OSStatus  ewg_function_GetWindowGroupLevel (WindowGroupRef inGroup, SInt32 *outLevel);
// Wraps call to function 'SetWindowGroupLevelOfType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroupLevelOfType(ewg_param_inGroup, ewg_param_inLevelType, ewg_param_inLevel) SetWindowGroupLevelOfType ((WindowGroupRef)ewg_param_inGroup, (UInt32)ewg_param_inLevelType, (CGWindowLevel)ewg_param_inLevel)

OSStatus  ewg_function_SetWindowGroupLevelOfType (WindowGroupRef inGroup, UInt32 inLevelType, CGWindowLevel inLevel);
// Wraps call to function 'GetWindowGroupLevelOfType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupLevelOfType(ewg_param_inGroup, ewg_param_inLevelType, ewg_param_outLevel) GetWindowGroupLevelOfType ((WindowGroupRef)ewg_param_inGroup, (UInt32)ewg_param_inLevelType, (CGWindowLevel*)ewg_param_outLevel)

OSStatus  ewg_function_GetWindowGroupLevelOfType (WindowGroupRef inGroup, UInt32 inLevelType, CGWindowLevel *outLevel);
// Wraps call to function 'SendWindowGroupBehind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SendWindowGroupBehind(ewg_param_inGroup, ewg_param_behindGroup) SendWindowGroupBehind ((WindowGroupRef)ewg_param_inGroup, (WindowGroupRef)ewg_param_behindGroup)

OSStatus  ewg_function_SendWindowGroupBehind (WindowGroupRef inGroup, WindowGroupRef behindGroup);
// Wraps call to function 'GetWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroup(ewg_param_inWindow) GetWindowGroup ((WindowRef)ewg_param_inWindow)

WindowGroupRef  ewg_function_GetWindowGroup (WindowRef inWindow);
// Wraps call to function 'SetWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroup(ewg_param_inWindow, ewg_param_inNewGroup) SetWindowGroup ((WindowRef)ewg_param_inWindow, (WindowGroupRef)ewg_param_inNewGroup)

OSStatus  ewg_function_SetWindowGroup (WindowRef inWindow, WindowGroupRef inNewGroup);
// Wraps call to function 'IsWindowContainedInGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowContainedInGroup(ewg_param_inWindow, ewg_param_inGroup) IsWindowContainedInGroup ((WindowRef)ewg_param_inWindow, (WindowGroupRef)ewg_param_inGroup)

Boolean  ewg_function_IsWindowContainedInGroup (WindowRef inWindow, WindowGroupRef inGroup);
// Wraps call to function 'GetWindowGroupParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupParent(ewg_param_inGroup) GetWindowGroupParent ((WindowGroupRef)ewg_param_inGroup)

WindowGroupRef  ewg_function_GetWindowGroupParent (WindowGroupRef inGroup);
// Wraps call to function 'SetWindowGroupParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroupParent(ewg_param_inGroup, ewg_param_inNewGroup) SetWindowGroupParent ((WindowGroupRef)ewg_param_inGroup, (WindowGroupRef)ewg_param_inNewGroup)

OSStatus  ewg_function_SetWindowGroupParent (WindowGroupRef inGroup, WindowGroupRef inNewGroup);
// Wraps call to function 'GetWindowGroupSibling' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupSibling(ewg_param_inGroup, ewg_param_inNextGroup) GetWindowGroupSibling ((WindowGroupRef)ewg_param_inGroup, (Boolean)ewg_param_inNextGroup)

WindowGroupRef  ewg_function_GetWindowGroupSibling (WindowGroupRef inGroup, Boolean inNextGroup);
// Wraps call to function 'GetWindowGroupOwner' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupOwner(ewg_param_inGroup) GetWindowGroupOwner ((WindowGroupRef)ewg_param_inGroup)

WindowRef  ewg_function_GetWindowGroupOwner (WindowGroupRef inGroup);
// Wraps call to function 'SetWindowGroupOwner' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowGroupOwner(ewg_param_inGroup, ewg_param_inWindow) SetWindowGroupOwner ((WindowGroupRef)ewg_param_inGroup, (WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_SetWindowGroupOwner (WindowGroupRef inGroup, WindowRef inWindow);
// Wraps call to function 'CountWindowGroupContents' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CountWindowGroupContents(ewg_param_inGroup, ewg_param_inOptions) CountWindowGroupContents ((WindowGroupRef)ewg_param_inGroup, (WindowGroupContentOptions)ewg_param_inOptions)

ItemCount  ewg_function_CountWindowGroupContents (WindowGroupRef inGroup, WindowGroupContentOptions inOptions);
// Wraps call to function 'GetWindowGroupContents' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGroupContents(ewg_param_inGroup, ewg_param_inOptions, ewg_param_inAllowedItems, ewg_param_outNumItems, ewg_param_outItems) GetWindowGroupContents ((WindowGroupRef)ewg_param_inGroup, (WindowGroupContentOptions)ewg_param_inOptions, (ItemCount)ewg_param_inAllowedItems, (ItemCount*)ewg_param_outNumItems, (void**)ewg_param_outItems)

OSStatus  ewg_function_GetWindowGroupContents (WindowGroupRef inGroup, WindowGroupContentOptions inOptions, ItemCount inAllowedItems, ItemCount *outNumItems, void **outItems);
// Wraps call to function 'GetIndexedWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetIndexedWindow(ewg_param_inGroup, ewg_param_inIndex, ewg_param_inOptions, ewg_param_outWindow) GetIndexedWindow ((WindowGroupRef)ewg_param_inGroup, (UInt32)ewg_param_inIndex, (WindowGroupContentOptions)ewg_param_inOptions, (WindowRef*)ewg_param_outWindow)

OSStatus  ewg_function_GetIndexedWindow (WindowGroupRef inGroup, UInt32 inIndex, WindowGroupContentOptions inOptions, WindowRef *outWindow);
// Wraps call to function 'GetWindowIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowIndex(ewg_param_inWindow, ewg_param_inStartGroup, ewg_param_inOptions, ewg_param_outIndex) GetWindowIndex ((WindowRef)ewg_param_inWindow, (WindowGroupRef)ewg_param_inStartGroup, (WindowGroupContentOptions)ewg_param_inOptions, (UInt32*)ewg_param_outIndex)

OSStatus  ewg_function_GetWindowIndex (WindowRef inWindow, WindowGroupRef inStartGroup, WindowGroupContentOptions inOptions, UInt32 *outIndex);
// Wraps call to function 'ActiveNonFloatingWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ActiveNonFloatingWindow ActiveNonFloatingWindow ()

WindowRef  ewg_function_ActiveNonFloatingWindow (void);
// Wraps call to function 'IsWindowActive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowActive(ewg_param_inWindow) IsWindowActive ((WindowRef)ewg_param_inWindow)

Boolean  ewg_function_IsWindowActive (WindowRef inWindow);
// Wraps call to function 'ActivateWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ActivateWindow(ewg_param_inWindow, ewg_param_inActivate) ActivateWindow ((WindowRef)ewg_param_inWindow, (Boolean)ewg_param_inActivate)

OSStatus  ewg_function_ActivateWindow (WindowRef inWindow, Boolean inActivate);
// Wraps call to function 'GetWindowActivationScope' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowActivationScope(ewg_param_inWindow, ewg_param_outScope) GetWindowActivationScope ((WindowRef)ewg_param_inWindow, (WindowActivationScope*)ewg_param_outScope)

OSStatus  ewg_function_GetWindowActivationScope (WindowRef inWindow, WindowActivationScope *outScope);
// Wraps call to function 'SetWindowActivationScope' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowActivationScope(ewg_param_inWindow, ewg_param_inScope) SetWindowActivationScope ((WindowRef)ewg_param_inWindow, (WindowActivationScope)ewg_param_inScope)

OSStatus  ewg_function_SetWindowActivationScope (WindowRef inWindow, WindowActivationScope inScope);
// Wraps call to function 'DebugPrintWindowGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DebugPrintWindowGroup(ewg_param_inGroup) DebugPrintWindowGroup ((WindowGroupRef)ewg_param_inGroup)

void  ewg_function_DebugPrintWindowGroup (WindowGroupRef inGroup);
// Wraps call to function 'DebugPrintAllWindowGroups' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DebugPrintAllWindowGroups DebugPrintAllWindowGroups ()

void  ewg_function_DebugPrintAllWindowGroups (void);
// Wraps call to function 'SetThemeWindowBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetThemeWindowBackground(ewg_param_inWindow, ewg_param_inBrush, ewg_param_inUpdate) SetThemeWindowBackground ((WindowRef)ewg_param_inWindow, (ThemeBrush)ewg_param_inBrush, (Boolean)ewg_param_inUpdate)

OSStatus  ewg_function_SetThemeWindowBackground (WindowRef inWindow, ThemeBrush inBrush, Boolean inUpdate);
// Wraps call to function 'SetThemeTextColorForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetThemeTextColorForWindow(ewg_param_inWindow, ewg_param_inActive, ewg_param_inDepth, ewg_param_inColorDev) SetThemeTextColorForWindow ((WindowRef)ewg_param_inWindow, (Boolean)ewg_param_inActive, (SInt16)ewg_param_inDepth, (Boolean)ewg_param_inColorDev)

OSStatus  ewg_function_SetThemeTextColorForWindow (WindowRef inWindow, Boolean inActive, SInt16 inDepth, Boolean inColorDev);
// Wraps call to function 'SetWindowContentColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowContentColor(ewg_param_window, ewg_param_color) SetWindowContentColor ((WindowRef)ewg_param_window, (RGBColor const*)ewg_param_color)

OSStatus  ewg_function_SetWindowContentColor (WindowRef window, RGBColor const *color);
// Wraps call to function 'GetWindowContentColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowContentColor(ewg_param_window, ewg_param_color) GetWindowContentColor ((WindowRef)ewg_param_window, (RGBColor*)ewg_param_color)

OSStatus  ewg_function_GetWindowContentColor (WindowRef window, RGBColor *color);
// Wraps call to function 'GetWindowContentPattern' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowContentPattern(ewg_param_window, ewg_param_outPixPat) GetWindowContentPattern ((WindowRef)ewg_param_window, (PixPatHandle)ewg_param_outPixPat)

OSStatus  ewg_function_GetWindowContentPattern (WindowRef window, PixPatHandle outPixPat);
// Wraps call to function 'SetWindowContentPattern' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowContentPattern(ewg_param_window, ewg_param_pixPat) SetWindowContentPattern ((WindowRef)ewg_param_window, (PixPatHandle)ewg_param_pixPat)

OSStatus  ewg_function_SetWindowContentPattern (WindowRef window, PixPatHandle pixPat);
// Wraps call to function 'InstallWindowContentPaintProc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InstallWindowContentPaintProc(ewg_param_window, ewg_param_paintProc, ewg_param_options, ewg_param_refCon) InstallWindowContentPaintProc ((WindowRef)ewg_param_window, (WindowPaintUPP)ewg_param_paintProc, (WindowPaintProcOptions)ewg_param_options, (void*)ewg_param_refCon)

OSStatus  ewg_function_InstallWindowContentPaintProc (WindowRef window, WindowPaintUPP paintProc, WindowPaintProcOptions options, void *refCon);
// Wraps call to function 'ScrollWindowRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ScrollWindowRect(ewg_param_inWindow, ewg_param_inScrollRect, ewg_param_inHPixels, ewg_param_inVPixels, ewg_param_inOptions, ewg_param_outExposedRgn) ScrollWindowRect ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inScrollRect, (SInt16)ewg_param_inHPixels, (SInt16)ewg_param_inVPixels, (ScrollWindowOptions)ewg_param_inOptions, (RgnHandle)ewg_param_outExposedRgn)

OSStatus  ewg_function_ScrollWindowRect (WindowRef inWindow, Rect const *inScrollRect, SInt16 inHPixels, SInt16 inVPixels, ScrollWindowOptions inOptions, RgnHandle outExposedRgn);
// Wraps call to function 'ScrollWindowRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ScrollWindowRegion(ewg_param_inWindow, ewg_param_inScrollRgn, ewg_param_inHPixels, ewg_param_inVPixels, ewg_param_inOptions, ewg_param_outExposedRgn) ScrollWindowRegion ((WindowRef)ewg_param_inWindow, (RgnHandle)ewg_param_inScrollRgn, (SInt16)ewg_param_inHPixels, (SInt16)ewg_param_inVPixels, (ScrollWindowOptions)ewg_param_inOptions, (RgnHandle)ewg_param_outExposedRgn)

OSStatus  ewg_function_ScrollWindowRegion (WindowRef inWindow, RgnHandle inScrollRgn, SInt16 inHPixels, SInt16 inVPixels, ScrollWindowOptions inOptions, RgnHandle outExposedRgn);
// Wraps call to function 'ClipAbove' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ClipAbove(ewg_param_window) ClipAbove ((WindowRef)ewg_param_window)

void  ewg_function_ClipAbove (WindowRef window);
// Wraps call to function 'PaintOne' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PaintOne(ewg_param_window, ewg_param_clobberedRgn) PaintOne ((WindowRef)ewg_param_window, (RgnHandle)ewg_param_clobberedRgn)

void  ewg_function_PaintOne (WindowRef window, RgnHandle clobberedRgn);
// Wraps call to function 'PaintBehind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PaintBehind(ewg_param_startWindow, ewg_param_clobberedRgn) PaintBehind ((WindowRef)ewg_param_startWindow, (RgnHandle)ewg_param_clobberedRgn)

void  ewg_function_PaintBehind (WindowRef startWindow, RgnHandle clobberedRgn);
// Wraps call to function 'CalcVis' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CalcVis(ewg_param_window) CalcVis ((WindowRef)ewg_param_window)

void  ewg_function_CalcVis (WindowRef window);
// Wraps call to function 'CalcVisBehind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CalcVisBehind(ewg_param_startWindow, ewg_param_clobberedRgn) CalcVisBehind ((WindowRef)ewg_param_startWindow, (RgnHandle)ewg_param_clobberedRgn)

void  ewg_function_CalcVisBehind (WindowRef startWindow, RgnHandle clobberedRgn);
// Wraps call to function 'CheckUpdate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CheckUpdate(ewg_param_theEvent) CheckUpdate ((EventRecord*)ewg_param_theEvent)

Boolean  ewg_function_CheckUpdate (EventRecord *theEvent);
// Wraps call to function 'FindWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FindWindow(ewg_param_thePoint, ewg_param_window) FindWindow (*(Point*)ewg_param_thePoint, (WindowRef*)ewg_param_window)

WindowPartCode  ewg_function_FindWindow (Point *thePoint, WindowRef *window);
// Wraps call to function 'FrontWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FrontWindow FrontWindow ()

WindowRef  ewg_function_FrontWindow (void);
// Wraps call to function 'BringToFront' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_BringToFront(ewg_param_window) BringToFront ((WindowRef)ewg_param_window)

void  ewg_function_BringToFront (WindowRef window);
// Wraps call to function 'SendBehind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SendBehind(ewg_param_window, ewg_param_behindWindow) SendBehind ((WindowRef)ewg_param_window, (WindowRef)ewg_param_behindWindow)

void  ewg_function_SendBehind (WindowRef window, WindowRef behindWindow);
// Wraps call to function 'SelectWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SelectWindow(ewg_param_window) SelectWindow ((WindowRef)ewg_param_window)

void  ewg_function_SelectWindow (WindowRef window);
// Wraps call to function 'FrontNonFloatingWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FrontNonFloatingWindow FrontNonFloatingWindow ()

WindowRef  ewg_function_FrontNonFloatingWindow (void);
// Wraps call to function 'GetNextWindowOfClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNextWindowOfClass(ewg_param_inWindow, ewg_param_inWindowClass, ewg_param_mustBeVisible) GetNextWindowOfClass ((WindowRef)ewg_param_inWindow, (WindowClass)ewg_param_inWindowClass, (Boolean)ewg_param_mustBeVisible)

WindowRef  ewg_function_GetNextWindowOfClass (WindowRef inWindow, WindowClass inWindowClass, Boolean mustBeVisible);
// Wraps call to function 'GetFrontWindowOfClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetFrontWindowOfClass(ewg_param_inWindowClass, ewg_param_mustBeVisible) GetFrontWindowOfClass ((WindowClass)ewg_param_inWindowClass, (Boolean)ewg_param_mustBeVisible)

WindowRef  ewg_function_GetFrontWindowOfClass (WindowClass inWindowClass, Boolean mustBeVisible);
// Wraps call to function 'FindWindowOfClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_FindWindowOfClass(ewg_param_where, ewg_param_inWindowClass, ewg_param_outWindow, ewg_param_outWindowPart) FindWindowOfClass ((Point const*)ewg_param_where, (WindowClass)ewg_param_inWindowClass, (WindowRef*)ewg_param_outWindow, (WindowPartCode*)ewg_param_outWindowPart)

OSStatus  ewg_function_FindWindowOfClass (Point const *where, WindowClass inWindowClass, WindowRef *outWindow, WindowPartCode *outWindowPart);
// Wraps call to function 'CreateStandardWindowMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateStandardWindowMenu(ewg_param_inOptions, ewg_param_outMenu) CreateStandardWindowMenu ((OptionBits)ewg_param_inOptions, (MenuRef*)ewg_param_outMenu)

OSStatus  ewg_function_CreateStandardWindowMenu (OptionBits inOptions, MenuRef *outMenu);
// Wraps call to function 'SetWindowAlternateTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowAlternateTitle(ewg_param_inWindow, ewg_param_inTitle) SetWindowAlternateTitle ((WindowRef)ewg_param_inWindow, (CFStringRef)ewg_param_inTitle)

OSStatus  ewg_function_SetWindowAlternateTitle (WindowRef inWindow, CFStringRef inTitle);
// Wraps call to function 'CopyWindowAlternateTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyWindowAlternateTitle(ewg_param_inWindow, ewg_param_outTitle) CopyWindowAlternateTitle ((WindowRef)ewg_param_inWindow, (CFStringRef*)ewg_param_outTitle)

OSStatus  ewg_function_CopyWindowAlternateTitle (WindowRef inWindow, CFStringRef *outTitle);
// Wraps call to function 'IsValidWindowPtr' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsValidWindowPtr(ewg_param_possibleWindow) IsValidWindowPtr ((WindowRef)ewg_param_possibleWindow)

Boolean  ewg_function_IsValidWindowPtr (WindowRef possibleWindow);
// Wraps call to function 'HiliteWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HiliteWindow(ewg_param_window, ewg_param_fHilite) HiliteWindow ((WindowRef)ewg_param_window, (Boolean)ewg_param_fHilite)

void  ewg_function_HiliteWindow (WindowRef window, Boolean fHilite);
// Wraps call to function 'SetWRefCon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWRefCon(ewg_param_window, ewg_param_data) SetWRefCon ((WindowRef)ewg_param_window, (long)ewg_param_data)

void  ewg_function_SetWRefCon (WindowRef window, long data);
// Wraps call to function 'GetWRefCon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWRefCon(ewg_param_window) GetWRefCon ((WindowRef)ewg_param_window)

long  ewg_function_GetWRefCon (WindowRef window);
// Wraps call to function 'SetWindowPic' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowPic(ewg_param_window, ewg_param_pic) SetWindowPic ((WindowRef)ewg_param_window, (PicHandle)ewg_param_pic)

void  ewg_function_SetWindowPic (WindowRef window, PicHandle pic);
// Wraps call to function 'GetWindowPic' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowPic(ewg_param_window) GetWindowPic ((WindowRef)ewg_param_window)

PicHandle  ewg_function_GetWindowPic (WindowRef window);
// Wraps call to function 'GetWVariant' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWVariant(ewg_param_window) GetWVariant ((WindowRef)ewg_param_window)

short  ewg_function_GetWVariant (WindowRef window);
// Wraps call to function 'GetWindowFeatures' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowFeatures(ewg_param_window, ewg_param_outFeatures) GetWindowFeatures ((WindowRef)ewg_param_window, (UInt32*)ewg_param_outFeatures)

OSStatus  ewg_function_GetWindowFeatures (WindowRef window, UInt32 *outFeatures);
// Wraps call to function 'GetWindowRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowRegion(ewg_param_window, ewg_param_inRegionCode, ewg_param_ioWinRgn) GetWindowRegion ((WindowRef)ewg_param_window, (WindowRegionCode)ewg_param_inRegionCode, (RgnHandle)ewg_param_ioWinRgn)

OSStatus  ewg_function_GetWindowRegion (WindowRef window, WindowRegionCode inRegionCode, RgnHandle ioWinRgn);
// Wraps call to function 'GetWindowStructureWidths' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowStructureWidths(ewg_param_inWindow, ewg_param_outRect) GetWindowStructureWidths ((WindowRef)ewg_param_inWindow, (Rect*)ewg_param_outRect)

OSStatus  ewg_function_GetWindowStructureWidths (WindowRef inWindow, Rect *outRect);
// Wraps call to function 'HIWindowChangeFeatures' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowChangeFeatures(ewg_param_inWindow, ewg_param_inSetThese, ewg_param_inClearThese) HIWindowChangeFeatures ((WindowRef)ewg_param_inWindow, (UInt64)ewg_param_inSetThese, (UInt64)ewg_param_inClearThese)

OSStatus  ewg_function_HIWindowChangeFeatures (WindowRef inWindow, UInt64 inSetThese, UInt64 inClearThese);
// Wraps call to function 'BeginUpdate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_BeginUpdate(ewg_param_window) BeginUpdate ((WindowRef)ewg_param_window)

void  ewg_function_BeginUpdate (WindowRef window);
// Wraps call to function 'EndUpdate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EndUpdate(ewg_param_window) EndUpdate ((WindowRef)ewg_param_window)

void  ewg_function_EndUpdate (WindowRef window);
// Wraps call to function 'InvalWindowRgn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalWindowRgn(ewg_param_window, ewg_param_region) InvalWindowRgn ((WindowRef)ewg_param_window, (RgnHandle)ewg_param_region)

OSStatus  ewg_function_InvalWindowRgn (WindowRef window, RgnHandle region);
// Wraps call to function 'InvalWindowRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvalWindowRect(ewg_param_window, ewg_param_bounds) InvalWindowRect ((WindowRef)ewg_param_window, (Rect const*)ewg_param_bounds)

OSStatus  ewg_function_InvalWindowRect (WindowRef window, Rect const *bounds);
// Wraps call to function 'ValidWindowRgn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ValidWindowRgn(ewg_param_window, ewg_param_region) ValidWindowRgn ((WindowRef)ewg_param_window, (RgnHandle)ewg_param_region)

OSStatus  ewg_function_ValidWindowRgn (WindowRef window, RgnHandle region);
// Wraps call to function 'ValidWindowRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ValidWindowRect(ewg_param_window, ewg_param_bounds) ValidWindowRect ((WindowRef)ewg_param_window, (Rect const*)ewg_param_bounds)

OSStatus  ewg_function_ValidWindowRect (WindowRef window, Rect const *bounds);
// Wraps call to function 'DrawGrowIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DrawGrowIcon(ewg_param_window) DrawGrowIcon ((WindowRef)ewg_param_window)

void  ewg_function_DrawGrowIcon (WindowRef window);
// Wraps call to function 'SetWTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWTitle(ewg_param_window, ewg_param_title) SetWTitle ((WindowRef)ewg_param_window, (ConstStr255Param)ewg_param_title)

void  ewg_function_SetWTitle (WindowRef window, ConstStr255Param title);
// Wraps call to function 'GetWTitle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWTitle(ewg_param_window, ewg_param_title) GetWTitle ((WindowRef)ewg_param_window, ewg_param_title)

void  ewg_function_GetWTitle (WindowRef window, void *title);
// Wraps call to function 'SetWindowTitleWithCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowTitleWithCFString(ewg_param_inWindow, ewg_param_inString) SetWindowTitleWithCFString ((WindowRef)ewg_param_inWindow, (CFStringRef)ewg_param_inString)

OSStatus  ewg_function_SetWindowTitleWithCFString (WindowRef inWindow, CFStringRef inString);
// Wraps call to function 'CopyWindowTitleAsCFString' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyWindowTitleAsCFString(ewg_param_inWindow, ewg_param_outString) CopyWindowTitleAsCFString ((WindowRef)ewg_param_inWindow, (CFStringRef*)ewg_param_outString)

OSStatus  ewg_function_CopyWindowTitleAsCFString (WindowRef inWindow, CFStringRef *outString);
// Wraps call to function 'SetWindowProxyFSSpec' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowProxyFSSpec(ewg_param_window, ewg_param_inFile) SetWindowProxyFSSpec ((WindowRef)ewg_param_window, (FSSpec const*)ewg_param_inFile)

OSStatus  ewg_function_SetWindowProxyFSSpec (WindowRef window, FSSpec const *inFile);
// Wraps call to function 'GetWindowProxyFSSpec' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowProxyFSSpec(ewg_param_window, ewg_param_outFile) GetWindowProxyFSSpec ((WindowRef)ewg_param_window, (FSSpec*)ewg_param_outFile)

OSStatus  ewg_function_GetWindowProxyFSSpec (WindowRef window, FSSpec *outFile);
// Wraps call to function 'HIWindowSetProxyFSRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowSetProxyFSRef(ewg_param_window, ewg_param_inRef) HIWindowSetProxyFSRef ((WindowRef)ewg_param_window, (FSRef const*)ewg_param_inRef)

OSStatus  ewg_function_HIWindowSetProxyFSRef (WindowRef window, FSRef const *inRef);
// Wraps call to function 'HIWindowGetProxyFSRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowGetProxyFSRef(ewg_param_window, ewg_param_outRef) HIWindowGetProxyFSRef ((WindowRef)ewg_param_window, (FSRef*)ewg_param_outRef)

OSStatus  ewg_function_HIWindowGetProxyFSRef (WindowRef window, FSRef *outRef);
// Wraps call to function 'SetWindowProxyAlias' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowProxyAlias(ewg_param_inWindow, ewg_param_inAlias) SetWindowProxyAlias ((WindowRef)ewg_param_inWindow, (AliasHandle)ewg_param_inAlias)

OSStatus  ewg_function_SetWindowProxyAlias (WindowRef inWindow, AliasHandle inAlias);
// Wraps call to function 'GetWindowProxyAlias' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowProxyAlias(ewg_param_window, ewg_param_alias) GetWindowProxyAlias ((WindowRef)ewg_param_window, (AliasHandle*)ewg_param_alias)

OSStatus  ewg_function_GetWindowProxyAlias (WindowRef window, AliasHandle *alias);
// Wraps call to function 'SetWindowProxyCreatorAndType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowProxyCreatorAndType(ewg_param_window, ewg_param_fileCreator, ewg_param_fileType, ewg_param_vRefNum) SetWindowProxyCreatorAndType ((WindowRef)ewg_param_window, (OSType)ewg_param_fileCreator, (OSType)ewg_param_fileType, (SInt16)ewg_param_vRefNum)

OSStatus  ewg_function_SetWindowProxyCreatorAndType (WindowRef window, OSType fileCreator, OSType fileType, SInt16 vRefNum);
// Wraps call to function 'GetWindowProxyIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowProxyIcon(ewg_param_window, ewg_param_outIcon) GetWindowProxyIcon ((WindowRef)ewg_param_window, (IconRef*)ewg_param_outIcon)

OSStatus  ewg_function_GetWindowProxyIcon (WindowRef window, IconRef *outIcon);
// Wraps call to function 'SetWindowProxyIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowProxyIcon(ewg_param_window, ewg_param_icon) SetWindowProxyIcon ((WindowRef)ewg_param_window, (IconRef)ewg_param_icon)

OSStatus  ewg_function_SetWindowProxyIcon (WindowRef window, IconRef icon);
// Wraps call to function 'RemoveWindowProxy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveWindowProxy(ewg_param_window) RemoveWindowProxy ((WindowRef)ewg_param_window)

OSStatus  ewg_function_RemoveWindowProxy (WindowRef window);
// Wraps call to function 'BeginWindowProxyDrag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_BeginWindowProxyDrag(ewg_param_window, ewg_param_outNewDrag, ewg_param_outDragOutlineRgn) BeginWindowProxyDrag ((WindowRef)ewg_param_window, (DragReference*)ewg_param_outNewDrag, (RgnHandle)ewg_param_outDragOutlineRgn)

OSStatus  ewg_function_BeginWindowProxyDrag (WindowRef window, DragReference *outNewDrag, RgnHandle outDragOutlineRgn);
// Wraps call to function 'EndWindowProxyDrag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EndWindowProxyDrag(ewg_param_window, ewg_param_theDrag) EndWindowProxyDrag ((WindowRef)ewg_param_window, (DragReference)ewg_param_theDrag)

OSStatus  ewg_function_EndWindowProxyDrag (WindowRef window, DragReference theDrag);
// Wraps call to function 'TrackWindowProxyFromExistingDrag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackWindowProxyFromExistingDrag(ewg_param_window, ewg_param_startPt, ewg_param_drag, ewg_param_inDragOutlineRgn) TrackWindowProxyFromExistingDrag ((WindowRef)ewg_param_window, *(Point*)ewg_param_startPt, (DragReference)ewg_param_drag, (RgnHandle)ewg_param_inDragOutlineRgn)

OSStatus  ewg_function_TrackWindowProxyFromExistingDrag (WindowRef window, Point *startPt, DragReference drag, RgnHandle inDragOutlineRgn);
// Wraps call to function 'TrackWindowProxyDrag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackWindowProxyDrag(ewg_param_window, ewg_param_startPt) TrackWindowProxyDrag ((WindowRef)ewg_param_window, *(Point*)ewg_param_startPt)

OSStatus  ewg_function_TrackWindowProxyDrag (WindowRef window, Point *startPt);
// Wraps call to function 'IsWindowModified' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowModified(ewg_param_window) IsWindowModified ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowModified (WindowRef window);
// Wraps call to function 'SetWindowModified' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowModified(ewg_param_window, ewg_param_modified) SetWindowModified ((WindowRef)ewg_param_window, (Boolean)ewg_param_modified)

OSStatus  ewg_function_SetWindowModified (WindowRef window, Boolean modified);
// Wraps call to function 'IsWindowPathSelectClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowPathSelectClick(ewg_param_window, ewg_param_event) IsWindowPathSelectClick ((WindowRef)ewg_param_window, (EventRecord const*)ewg_param_event)

Boolean  ewg_function_IsWindowPathSelectClick (WindowRef window, EventRecord const *event);
// Wraps call to function 'IsWindowPathSelectEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowPathSelectEvent(ewg_param_window, ewg_param_inEvent) IsWindowPathSelectEvent ((WindowRef)ewg_param_window, (EventRef)ewg_param_inEvent)

Boolean  ewg_function_IsWindowPathSelectEvent (WindowRef window, EventRef inEvent);
// Wraps call to function 'WindowPathSelect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_WindowPathSelect(ewg_param_window, ewg_param_menu, ewg_param_outMenuResult) WindowPathSelect ((WindowRef)ewg_param_window, (MenuRef)ewg_param_menu, (SInt32*)ewg_param_outMenuResult)

OSStatus  ewg_function_WindowPathSelect (WindowRef window, MenuRef menu, SInt32 *outMenuResult);
// Wraps call to function 'HiliteWindowFrameForDrag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HiliteWindowFrameForDrag(ewg_param_window, ewg_param_hilited) HiliteWindowFrameForDrag ((WindowRef)ewg_param_window, (Boolean)ewg_param_hilited)

OSStatus  ewg_function_HiliteWindowFrameForDrag (WindowRef window, Boolean hilited);
// Wraps call to function 'TransitionWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TransitionWindow(ewg_param_inWindow, ewg_param_inEffect, ewg_param_inAction, ewg_param_inRect) TransitionWindow ((WindowRef)ewg_param_inWindow, (WindowTransitionEffect)ewg_param_inEffect, (WindowTransitionAction)ewg_param_inAction, (Rect const*)ewg_param_inRect)

OSStatus  ewg_function_TransitionWindow (WindowRef inWindow, WindowTransitionEffect inEffect, WindowTransitionAction inAction, Rect const *inRect);
// Wraps call to function 'TransitionWindowAndParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TransitionWindowAndParent(ewg_param_inWindow, ewg_param_inParentWindow, ewg_param_inEffect, ewg_param_inAction, ewg_param_inRect) TransitionWindowAndParent ((WindowRef)ewg_param_inWindow, (WindowRef)ewg_param_inParentWindow, (WindowTransitionEffect)ewg_param_inEffect, (WindowTransitionAction)ewg_param_inAction, (Rect const*)ewg_param_inRect)

OSStatus  ewg_function_TransitionWindowAndParent (WindowRef inWindow, WindowRef inParentWindow, WindowTransitionEffect inEffect, WindowTransitionAction inAction, Rect const *inRect);
// Wraps call to function 'TransitionWindowWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TransitionWindowWithOptions(ewg_param_inWindow, ewg_param_inEffect, ewg_param_inAction, ewg_param_inBounds, ewg_param_inAsync, ewg_param_inOptions) TransitionWindowWithOptions ((WindowRef)ewg_param_inWindow, (WindowTransitionEffect)ewg_param_inEffect, (WindowTransitionAction)ewg_param_inAction, (HIRect const*)ewg_param_inBounds, (Boolean)ewg_param_inAsync, (TransitionWindowOptions*)ewg_param_inOptions)

OSStatus  ewg_function_TransitionWindowWithOptions (WindowRef inWindow, WindowTransitionEffect inEffect, WindowTransitionAction inAction, HIRect const *inBounds, Boolean inAsync, TransitionWindowOptions *inOptions);
// Wraps call to function 'MoveWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveWindow(ewg_param_window, ewg_param_hGlobal, ewg_param_vGlobal, ewg_param_front) MoveWindow ((WindowRef)ewg_param_window, (short)ewg_param_hGlobal, (short)ewg_param_vGlobal, (Boolean)ewg_param_front)

void  ewg_function_MoveWindow (WindowRef window, short hGlobal, short vGlobal, Boolean front);
// Wraps call to function 'SizeWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SizeWindow(ewg_param_window, ewg_param_w, ewg_param_h, ewg_param_fUpdate) SizeWindow ((WindowRef)ewg_param_window, (short)ewg_param_w, (short)ewg_param_h, (Boolean)ewg_param_fUpdate)

void  ewg_function_SizeWindow (WindowRef window, short w, short h, Boolean fUpdate);
// Wraps call to function 'GrowWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GrowWindow(ewg_param_window, ewg_param_startPt, ewg_param_bBox) GrowWindow ((WindowRef)ewg_param_window, *(Point*)ewg_param_startPt, (Rect const*)ewg_param_bBox)

long  ewg_function_GrowWindow (WindowRef window, Point *startPt, Rect const *bBox);
// Wraps call to function 'DragWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DragWindow(ewg_param_window, ewg_param_startPt, ewg_param_boundsRect) DragWindow ((WindowRef)ewg_param_window, *(Point*)ewg_param_startPt, (Rect const*)ewg_param_boundsRect)

void  ewg_function_DragWindow (WindowRef window, Point *startPt, Rect const *boundsRect);
// Wraps call to function 'ZoomWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ZoomWindow(ewg_param_window, ewg_param_partCode, ewg_param_front) ZoomWindow ((WindowRef)ewg_param_window, (WindowPartCode)ewg_param_partCode, (Boolean)ewg_param_front)

void  ewg_function_ZoomWindow (WindowRef window, WindowPartCode partCode, Boolean front);
// Wraps call to function 'IsWindowCollapsable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowCollapsable(ewg_param_window) IsWindowCollapsable ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowCollapsable (WindowRef window);
// Wraps call to function 'IsWindowCollapsed' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowCollapsed(ewg_param_window) IsWindowCollapsed ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowCollapsed (WindowRef window);
// Wraps call to function 'CollapseWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CollapseWindow(ewg_param_window, ewg_param_collapse) CollapseWindow ((WindowRef)ewg_param_window, (Boolean)ewg_param_collapse)

OSStatus  ewg_function_CollapseWindow (WindowRef window, Boolean collapse);
// Wraps call to function 'CollapseAllWindows' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CollapseAllWindows(ewg_param_collapse) CollapseAllWindows ((Boolean)ewg_param_collapse)

OSStatus  ewg_function_CollapseAllWindows (Boolean collapse);
// Wraps call to function 'CreateQDContextForCollapsedWindowDockTile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateQDContextForCollapsedWindowDockTile(ewg_param_inWindow, ewg_param_outContext) CreateQDContextForCollapsedWindowDockTile ((WindowRef)ewg_param_inWindow, (CGrafPtr*)ewg_param_outContext)

OSStatus  ewg_function_CreateQDContextForCollapsedWindowDockTile (WindowRef inWindow, CGrafPtr *outContext);
// Wraps call to function 'ReleaseQDContextForCollapsedWindowDockTile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseQDContextForCollapsedWindowDockTile(ewg_param_inWindow, ewg_param_inContext) ReleaseQDContextForCollapsedWindowDockTile ((WindowRef)ewg_param_inWindow, (CGrafPtr)ewg_param_inContext)

OSStatus  ewg_function_ReleaseQDContextForCollapsedWindowDockTile (WindowRef inWindow, CGrafPtr inContext);
// Wraps call to function 'UpdateCollapsedWindowDockTile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UpdateCollapsedWindowDockTile(ewg_param_inWindow) UpdateCollapsedWindowDockTile ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_UpdateCollapsedWindowDockTile (WindowRef inWindow);
// Wraps call to function 'SetWindowDockTileMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowDockTileMenu(ewg_param_inWindow, ewg_param_inMenu) SetWindowDockTileMenu ((WindowRef)ewg_param_inWindow, (MenuRef)ewg_param_inMenu)

OSStatus  ewg_function_SetWindowDockTileMenu (WindowRef inWindow, MenuRef inMenu);
// Wraps call to function 'GetWindowDockTileMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowDockTileMenu(ewg_param_inWindow) GetWindowDockTileMenu ((WindowRef)ewg_param_inWindow)

MenuRef  ewg_function_GetWindowDockTileMenu (WindowRef inWindow);
// Wraps call to function 'GetWindowBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowBounds(ewg_param_window, ewg_param_regionCode, ewg_param_globalBounds) GetWindowBounds ((WindowRef)ewg_param_window, (WindowRegionCode)ewg_param_regionCode, (Rect*)ewg_param_globalBounds)

OSStatus  ewg_function_GetWindowBounds (WindowRef window, WindowRegionCode regionCode, Rect *globalBounds);
// Wraps call to function 'SetWindowResizeLimits' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowResizeLimits(ewg_param_inWindow, ewg_param_inMinLimits, ewg_param_inMaxLimits) SetWindowResizeLimits ((WindowRef)ewg_param_inWindow, (HISize const*)ewg_param_inMinLimits, (HISize const*)ewg_param_inMaxLimits)

OSStatus  ewg_function_SetWindowResizeLimits (WindowRef inWindow, HISize const *inMinLimits, HISize const *inMaxLimits);
// Wraps call to function 'GetWindowResizeLimits' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowResizeLimits(ewg_param_inWindow, ewg_param_outMinLimits, ewg_param_outMaxLimits) GetWindowResizeLimits ((WindowRef)ewg_param_inWindow, (HISize*)ewg_param_outMinLimits, (HISize*)ewg_param_outMaxLimits)

OSStatus  ewg_function_GetWindowResizeLimits (WindowRef inWindow, HISize *outMinLimits, HISize *outMaxLimits);
// Wraps call to function 'ResizeWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ResizeWindow(ewg_param_inWindow, ewg_param_inStartPoint, ewg_param_inSizeConstraints, ewg_param_outNewContentRect) ResizeWindow ((WindowRef)ewg_param_inWindow, *(Point*)ewg_param_inStartPoint, (Rect const*)ewg_param_inSizeConstraints, (Rect*)ewg_param_outNewContentRect)

Boolean  ewg_function_ResizeWindow (WindowRef inWindow, Point *inStartPoint, Rect const *inSizeConstraints, Rect *outNewContentRect);
// Wraps call to function 'SetWindowBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowBounds(ewg_param_window, ewg_param_regionCode, ewg_param_globalBounds) SetWindowBounds ((WindowRef)ewg_param_window, (WindowRegionCode)ewg_param_regionCode, (Rect const*)ewg_param_globalBounds)

OSStatus  ewg_function_SetWindowBounds (WindowRef window, WindowRegionCode regionCode, Rect const *globalBounds);
// Wraps call to function 'RepositionWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RepositionWindow(ewg_param_window, ewg_param_parentWindow, ewg_param_method) RepositionWindow ((WindowRef)ewg_param_window, (WindowRef)ewg_param_parentWindow, (WindowPositionMethod)ewg_param_method)

OSStatus  ewg_function_RepositionWindow (WindowRef window, WindowRef parentWindow, WindowPositionMethod method);
// Wraps call to function 'MoveWindowStructure' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveWindowStructure(ewg_param_window, ewg_param_hGlobal, ewg_param_vGlobal) MoveWindowStructure ((WindowRef)ewg_param_window, (short)ewg_param_hGlobal, (short)ewg_param_vGlobal)

OSStatus  ewg_function_MoveWindowStructure (WindowRef window, short hGlobal, short vGlobal);
// Wraps call to function 'IsWindowInStandardState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowInStandardState(ewg_param_inWindow, ewg_param_inIdealSize, ewg_param_outIdealStandardState) IsWindowInStandardState ((WindowRef)ewg_param_inWindow, (Point const*)ewg_param_inIdealSize, (Rect*)ewg_param_outIdealStandardState)

Boolean  ewg_function_IsWindowInStandardState (WindowRef inWindow, Point const *inIdealSize, Rect *outIdealStandardState);
// Wraps call to function 'ZoomWindowIdeal' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ZoomWindowIdeal(ewg_param_inWindow, ewg_param_inPartCode, ewg_param_ioIdealSize) ZoomWindowIdeal ((WindowRef)ewg_param_inWindow, (WindowPartCode)ewg_param_inPartCode, (Point*)ewg_param_ioIdealSize)

OSStatus  ewg_function_ZoomWindowIdeal (WindowRef inWindow, WindowPartCode inPartCode, Point *ioIdealSize);
// Wraps call to function 'GetWindowIdealUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowIdealUserState(ewg_param_inWindow, ewg_param_outUserState) GetWindowIdealUserState ((WindowRef)ewg_param_inWindow, (Rect*)ewg_param_outUserState)

OSStatus  ewg_function_GetWindowIdealUserState (WindowRef inWindow, Rect *outUserState);
// Wraps call to function 'SetWindowIdealUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowIdealUserState(ewg_param_inWindow, ewg_param_inUserState) SetWindowIdealUserState ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inUserState)

OSStatus  ewg_function_SetWindowIdealUserState (WindowRef inWindow, Rect const *inUserState);
// Wraps call to function 'GetWindowGreatestAreaDevice' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowGreatestAreaDevice(ewg_param_inWindow, ewg_param_inRegion, ewg_param_outGreatestDevice, ewg_param_outGreatestDeviceRect) GetWindowGreatestAreaDevice ((WindowRef)ewg_param_inWindow, (WindowRegionCode)ewg_param_inRegion, (GDHandle*)ewg_param_outGreatestDevice, (Rect*)ewg_param_outGreatestDeviceRect)

OSStatus  ewg_function_GetWindowGreatestAreaDevice (WindowRef inWindow, WindowRegionCode inRegion, GDHandle *outGreatestDevice, Rect *outGreatestDeviceRect);
// Wraps call to function 'ConstrainWindowToScreen' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ConstrainWindowToScreen(ewg_param_inWindowRef, ewg_param_inRegionCode, ewg_param_inOptions, ewg_param_inScreenRect, ewg_param_outStructure) ConstrainWindowToScreen ((WindowRef)ewg_param_inWindowRef, (WindowRegionCode)ewg_param_inRegionCode, (WindowConstrainOptions)ewg_param_inOptions, (Rect const*)ewg_param_inScreenRect, (Rect*)ewg_param_outStructure)

OSStatus  ewg_function_ConstrainWindowToScreen (WindowRef inWindowRef, WindowRegionCode inRegionCode, WindowConstrainOptions inOptions, Rect const *inScreenRect, Rect *outStructure);
// Wraps call to function 'GetAvailableWindowPositioningBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetAvailableWindowPositioningBounds(ewg_param_inDevice, ewg_param_outAvailableRect) GetAvailableWindowPositioningBounds ((GDHandle)ewg_param_inDevice, (Rect*)ewg_param_outAvailableRect)

OSStatus  ewg_function_GetAvailableWindowPositioningBounds (GDHandle inDevice, Rect *outAvailableRect);
// Wraps call to function 'GetAvailableWindowPositioningRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetAvailableWindowPositioningRegion(ewg_param_inDevice, ewg_param_ioRgn) GetAvailableWindowPositioningRegion ((GDHandle)ewg_param_inDevice, (RgnHandle)ewg_param_ioRgn)

OSStatus  ewg_function_GetAvailableWindowPositioningRegion (GDHandle inDevice, RgnHandle ioRgn);
// Wraps call to function 'HideWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HideWindow(ewg_param_window) HideWindow ((WindowRef)ewg_param_window)

void  ewg_function_HideWindow (WindowRef window);
// Wraps call to function 'ShowWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowWindow(ewg_param_window) ShowWindow ((WindowRef)ewg_param_window)

void  ewg_function_ShowWindow (WindowRef window);
// Wraps call to function 'ShowHide' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowHide(ewg_param_window, ewg_param_showFlag) ShowHide ((WindowRef)ewg_param_window, (Boolean)ewg_param_showFlag)

void  ewg_function_ShowHide (WindowRef window, Boolean showFlag);
// Wraps call to function 'IsWindowVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowVisible(ewg_param_window) IsWindowVisible ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowVisible (WindowRef window);
// Wraps call to function 'IsWindowLatentVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowLatentVisible(ewg_param_inWindow, ewg_param_outLatentVisible) IsWindowLatentVisible ((WindowRef)ewg_param_inWindow, (WindowLatentVisibility*)ewg_param_outLatentVisible)

Boolean  ewg_function_IsWindowLatentVisible (WindowRef inWindow, WindowLatentVisibility *outLatentVisible);
// Wraps call to function 'HIWindowGetAvailability' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowGetAvailability(ewg_param_inWindow, ewg_param_outAvailability) HIWindowGetAvailability ((HIWindowRef)ewg_param_inWindow, (HIWindowAvailability*)ewg_param_outAvailability)

OSStatus  ewg_function_HIWindowGetAvailability (HIWindowRef inWindow, HIWindowAvailability *outAvailability);
// Wraps call to function 'HIWindowChangeAvailability' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowChangeAvailability(ewg_param_inWindow, ewg_param_inSetAvailability, ewg_param_inClearAvailability) HIWindowChangeAvailability ((HIWindowRef)ewg_param_inWindow, (HIWindowAvailability)ewg_param_inSetAvailability, (HIWindowAvailability)ewg_param_inClearAvailability)

OSStatus  ewg_function_HIWindowChangeAvailability (HIWindowRef inWindow, HIWindowAvailability inSetAvailability, HIWindowAvailability inClearAvailability);
// Wraps call to function 'ShowSheetWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowSheetWindow(ewg_param_inSheet, ewg_param_inParentWindow) ShowSheetWindow ((WindowRef)ewg_param_inSheet, (WindowRef)ewg_param_inParentWindow)

OSStatus  ewg_function_ShowSheetWindow (WindowRef inSheet, WindowRef inParentWindow);
// Wraps call to function 'HideSheetWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HideSheetWindow(ewg_param_inSheet) HideSheetWindow ((WindowRef)ewg_param_inSheet)

OSStatus  ewg_function_HideSheetWindow (WindowRef inSheet);
// Wraps call to function 'DetachSheetWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DetachSheetWindow(ewg_param_inSheet) DetachSheetWindow ((WindowRef)ewg_param_inSheet)

OSStatus  ewg_function_DetachSheetWindow (WindowRef inSheet);
// Wraps call to function 'GetSheetWindowParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetSheetWindowParent(ewg_param_inSheet, ewg_param_outParentWindow) GetSheetWindowParent ((WindowRef)ewg_param_inSheet, (WindowRef*)ewg_param_outParentWindow)

OSStatus  ewg_function_GetSheetWindowParent (WindowRef inSheet, WindowRef *outParentWindow);
// Wraps call to function 'GetDrawerPreferredEdge' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDrawerPreferredEdge(ewg_param_inDrawerWindow) GetDrawerPreferredEdge ((WindowRef)ewg_param_inDrawerWindow)

OptionBits  ewg_function_GetDrawerPreferredEdge (WindowRef inDrawerWindow);
// Wraps call to function 'SetDrawerPreferredEdge' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDrawerPreferredEdge(ewg_param_inDrawerWindow, ewg_param_inEdge) SetDrawerPreferredEdge ((WindowRef)ewg_param_inDrawerWindow, (OptionBits)ewg_param_inEdge)

OSStatus  ewg_function_SetDrawerPreferredEdge (WindowRef inDrawerWindow, OptionBits inEdge);
// Wraps call to function 'GetDrawerCurrentEdge' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDrawerCurrentEdge(ewg_param_inDrawerWindow) GetDrawerCurrentEdge ((WindowRef)ewg_param_inDrawerWindow)

OptionBits  ewg_function_GetDrawerCurrentEdge (WindowRef inDrawerWindow);
// Wraps call to function 'GetDrawerState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDrawerState(ewg_param_inDrawerWindow) GetDrawerState ((WindowRef)ewg_param_inDrawerWindow)

WindowDrawerState  ewg_function_GetDrawerState (WindowRef inDrawerWindow);
// Wraps call to function 'GetDrawerParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDrawerParent(ewg_param_inDrawerWindow) GetDrawerParent ((WindowRef)ewg_param_inDrawerWindow)

WindowRef  ewg_function_GetDrawerParent (WindowRef inDrawerWindow);
// Wraps call to function 'SetDrawerParent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDrawerParent(ewg_param_inDrawerWindow, ewg_param_inParent) SetDrawerParent ((WindowRef)ewg_param_inDrawerWindow, (WindowRef)ewg_param_inParent)

OSStatus  ewg_function_SetDrawerParent (WindowRef inDrawerWindow, WindowRef inParent);
// Wraps call to function 'SetDrawerOffsets' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDrawerOffsets(ewg_param_inDrawerWindow, ewg_param_inLeadingOffset, ewg_param_inTrailingOffset) SetDrawerOffsets ((WindowRef)ewg_param_inDrawerWindow, (float)ewg_param_inLeadingOffset, (float)ewg_param_inTrailingOffset)

OSStatus  ewg_function_SetDrawerOffsets (WindowRef inDrawerWindow, float inLeadingOffset, float inTrailingOffset);
// Wraps call to function 'GetDrawerOffsets' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDrawerOffsets(ewg_param_inDrawerWindow, ewg_param_outLeadingOffset, ewg_param_outTrailingOffset) GetDrawerOffsets ((WindowRef)ewg_param_inDrawerWindow, (float*)ewg_param_outLeadingOffset, (float*)ewg_param_outTrailingOffset)

OSStatus  ewg_function_GetDrawerOffsets (WindowRef inDrawerWindow, float *outLeadingOffset, float *outTrailingOffset);
// Wraps call to function 'ToggleDrawer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ToggleDrawer(ewg_param_inDrawerWindow) ToggleDrawer ((WindowRef)ewg_param_inDrawerWindow)

OSStatus  ewg_function_ToggleDrawer (WindowRef inDrawerWindow);
// Wraps call to function 'OpenDrawer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_OpenDrawer(ewg_param_inDrawerWindow, ewg_param_inEdge, ewg_param_inAsync) OpenDrawer ((WindowRef)ewg_param_inDrawerWindow, (OptionBits)ewg_param_inEdge, (Boolean)ewg_param_inAsync)

OSStatus  ewg_function_OpenDrawer (WindowRef inDrawerWindow, OptionBits inEdge, Boolean inAsync);
// Wraps call to function 'CloseDrawer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CloseDrawer(ewg_param_inDrawerWindow, ewg_param_inAsync) CloseDrawer ((WindowRef)ewg_param_inDrawerWindow, (Boolean)ewg_param_inAsync)

OSStatus  ewg_function_CloseDrawer (WindowRef inDrawerWindow, Boolean inAsync);
// Wraps call to function 'DisableScreenUpdates' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisableScreenUpdates DisableScreenUpdates ()

OSStatus  ewg_function_DisableScreenUpdates (void);
// Wraps call to function 'EnableScreenUpdates' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableScreenUpdates EnableScreenUpdates ()

OSStatus  ewg_function_EnableScreenUpdates (void);
// Wraps call to function 'SetWindowToolbar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowToolbar(ewg_param_inWindow, ewg_param_inToolbar) SetWindowToolbar ((WindowRef)ewg_param_inWindow, (HIToolbarRef)ewg_param_inToolbar)

OSStatus  ewg_function_SetWindowToolbar (WindowRef inWindow, HIToolbarRef inToolbar);
// Wraps call to function 'GetWindowToolbar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowToolbar(ewg_param_inWindow, ewg_param_outToolbar) GetWindowToolbar ((WindowRef)ewg_param_inWindow, (HIToolbarRef*)ewg_param_outToolbar)

OSStatus  ewg_function_GetWindowToolbar (WindowRef inWindow, HIToolbarRef *outToolbar);
// Wraps call to function 'ShowHideWindowToolbar' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ShowHideWindowToolbar(ewg_param_inWindow, ewg_param_inShow, ewg_param_inAnimate) ShowHideWindowToolbar ((WindowRef)ewg_param_inWindow, (Boolean)ewg_param_inShow, (Boolean)ewg_param_inAnimate)

OSStatus  ewg_function_ShowHideWindowToolbar (WindowRef inWindow, Boolean inShow, Boolean inAnimate);
// Wraps call to function 'IsWindowToolbarVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowToolbarVisible(ewg_param_inWindow) IsWindowToolbarVisible ((WindowRef)ewg_param_inWindow)

Boolean  ewg_function_IsWindowToolbarVisible (WindowRef inWindow);
// Wraps call to function 'SetWindowAlpha' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowAlpha(ewg_param_inWindow, ewg_param_inAlpha) SetWindowAlpha ((WindowRef)ewg_param_inWindow, (float)ewg_param_inAlpha)

OSStatus  ewg_function_SetWindowAlpha (WindowRef inWindow, float inAlpha);
// Wraps call to function 'GetWindowAlpha' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowAlpha(ewg_param_inWindow, ewg_param_outAlpha) GetWindowAlpha ((WindowRef)ewg_param_inWindow, (float*)ewg_param_outAlpha)

OSStatus  ewg_function_GetWindowAlpha (WindowRef inWindow, float *outAlpha);
// Wraps call to function 'HIWindowInvalidateShadow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowInvalidateShadow(ewg_param_inWindow) HIWindowInvalidateShadow ((HIWindowRef)ewg_param_inWindow)

OSStatus  ewg_function_HIWindowInvalidateShadow (HIWindowRef inWindow);
// Wraps call to function 'HIWindowGetScaleMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIWindowGetScaleMode(ewg_param_inWindow, ewg_param_outMode, ewg_param_outScaleFactor) HIWindowGetScaleMode ((HIWindowRef)ewg_param_inWindow, (HIWindowScaleMode*)ewg_param_outMode, (float*)ewg_param_outScaleFactor)

OSStatus  ewg_function_HIWindowGetScaleMode (HIWindowRef inWindow, HIWindowScaleMode *outMode, float *outScaleFactor);
// Wraps call to function 'GetWindowProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowProperty(ewg_param_window, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_bufferSize, ewg_param_actualSize, ewg_param_propertyBuffer) GetWindowProperty ((WindowRef)ewg_param_window, (PropertyCreator)ewg_param_propertyCreator, (PropertyTag)ewg_param_propertyTag, (UInt32)ewg_param_bufferSize, (UInt32*)ewg_param_actualSize, (void*)ewg_param_propertyBuffer)

OSStatus  ewg_function_GetWindowProperty (WindowRef window, PropertyCreator propertyCreator, PropertyTag propertyTag, UInt32 bufferSize, UInt32 *actualSize, void *propertyBuffer);
// Wraps call to function 'GetWindowPropertySize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowPropertySize(ewg_param_window, ewg_param_creator, ewg_param_tag, ewg_param_size) GetWindowPropertySize ((WindowRef)ewg_param_window, (PropertyCreator)ewg_param_creator, (PropertyTag)ewg_param_tag, (UInt32*)ewg_param_size)

OSStatus  ewg_function_GetWindowPropertySize (WindowRef window, PropertyCreator creator, PropertyTag tag, UInt32 *size);
// Wraps call to function 'SetWindowProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowProperty(ewg_param_window, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_propertySize, ewg_param_propertyBuffer) SetWindowProperty ((WindowRef)ewg_param_window, (PropertyCreator)ewg_param_propertyCreator, (PropertyTag)ewg_param_propertyTag, (UInt32)ewg_param_propertySize, (void const*)ewg_param_propertyBuffer)

OSStatus  ewg_function_SetWindowProperty (WindowRef window, PropertyCreator propertyCreator, PropertyTag propertyTag, UInt32 propertySize, void const *propertyBuffer);
// Wraps call to function 'RemoveWindowProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveWindowProperty(ewg_param_window, ewg_param_propertyCreator, ewg_param_propertyTag) RemoveWindowProperty ((WindowRef)ewg_param_window, (PropertyCreator)ewg_param_propertyCreator, (PropertyTag)ewg_param_propertyTag)

OSStatus  ewg_function_RemoveWindowProperty (WindowRef window, PropertyCreator propertyCreator, PropertyTag propertyTag);
// Wraps call to function 'GetWindowPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowPropertyAttributes(ewg_param_window, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributes) GetWindowPropertyAttributes ((WindowRef)ewg_param_window, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32*)ewg_param_attributes)

OSStatus  ewg_function_GetWindowPropertyAttributes (WindowRef window, OSType propertyCreator, OSType propertyTag, UInt32 *attributes);
// Wraps call to function 'ChangeWindowPropertyAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeWindowPropertyAttributes(ewg_param_window, ewg_param_propertyCreator, ewg_param_propertyTag, ewg_param_attributesToSet, ewg_param_attributesToClear) ChangeWindowPropertyAttributes ((WindowRef)ewg_param_window, (OSType)ewg_param_propertyCreator, (OSType)ewg_param_propertyTag, (UInt32)ewg_param_attributesToSet, (UInt32)ewg_param_attributesToClear)

OSStatus  ewg_function_ChangeWindowPropertyAttributes (WindowRef window, OSType propertyCreator, OSType propertyTag, UInt32 attributesToSet, UInt32 attributesToClear);
// Wraps call to function 'PinRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PinRect(ewg_param_theRect, ewg_param_thePt) PinRect ((Rect const*)ewg_param_theRect, *(Point*)ewg_param_thePt)

long  ewg_function_PinRect (Rect const *theRect, Point *thePt);
// Wraps call to function 'GetGrayRgn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetGrayRgn GetGrayRgn ()

RgnHandle  ewg_function_GetGrayRgn (void);
// Wraps call to function 'TrackBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackBox(ewg_param_window, ewg_param_thePt, ewg_param_partCode) TrackBox ((WindowRef)ewg_param_window, *(Point*)ewg_param_thePt, (WindowPartCode)ewg_param_partCode)

Boolean  ewg_function_TrackBox (WindowRef window, Point *thePt, WindowPartCode partCode);
// Wraps call to function 'TrackGoAway' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackGoAway(ewg_param_window, ewg_param_thePt) TrackGoAway ((WindowRef)ewg_param_window, *(Point*)ewg_param_thePt)

Boolean  ewg_function_TrackGoAway (WindowRef window, Point *thePt);
// Wraps call to function 'DragGrayRgn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DragGrayRgn(ewg_param_theRgn, ewg_param_startPt, ewg_param_limitRect, ewg_param_slopRect, ewg_param_axis, ewg_param_actionProc) DragGrayRgn ((RgnHandle)ewg_param_theRgn, *(Point*)ewg_param_startPt, (Rect const*)ewg_param_limitRect, (Rect const*)ewg_param_slopRect, (short)ewg_param_axis, (DragGrayRgnUPP)ewg_param_actionProc)

long  ewg_function_DragGrayRgn (RgnHandle theRgn, Point *startPt, Rect const *limitRect, Rect const *slopRect, short axis, DragGrayRgnUPP actionProc);
// Wraps call to function 'DragTheRgn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DragTheRgn(ewg_param_theRgn, ewg_param_startPt, ewg_param_limitRect, ewg_param_slopRect, ewg_param_axis, ewg_param_actionProc) DragTheRgn ((RgnHandle)ewg_param_theRgn, *(Point*)ewg_param_startPt, (Rect const*)ewg_param_limitRect, (Rect const*)ewg_param_slopRect, (short)ewg_param_axis, (DragGrayRgnUPP)ewg_param_actionProc)

long  ewg_function_DragTheRgn (RgnHandle theRgn, Point *startPt, Rect const *limitRect, Rect const *slopRect, short axis, DragGrayRgnUPP actionProc);
// Wraps call to function 'GetWindowList' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowList GetWindowList ()

WindowRef  ewg_function_GetWindowList (void);
// Wraps call to function 'GetWindowPort' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowPort(ewg_param_window) GetWindowPort ((WindowRef)ewg_param_window)

CGrafPtr  ewg_function_GetWindowPort (WindowRef window);
// Wraps call to function 'GetWindowStructurePort' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowStructurePort(ewg_param_inWindow) GetWindowStructurePort ((WindowRef)ewg_param_inWindow)

CGrafPtr  ewg_function_GetWindowStructurePort (WindowRef inWindow);
// Wraps call to function 'GetWindowKind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowKind(ewg_param_window) GetWindowKind ((WindowRef)ewg_param_window)

short  ewg_function_GetWindowKind (WindowRef window);
// Wraps call to function 'IsWindowHilited' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowHilited(ewg_param_window) IsWindowHilited ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowHilited (WindowRef window);
// Wraps call to function 'IsWindowUpdatePending' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsWindowUpdatePending(ewg_param_window) IsWindowUpdatePending ((WindowRef)ewg_param_window)

Boolean  ewg_function_IsWindowUpdatePending (WindowRef window);
// Wraps call to function 'GetNextWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetNextWindow(ewg_param_window) GetNextWindow ((WindowRef)ewg_param_window)

WindowRef  ewg_function_GetNextWindow (WindowRef window);
// Wraps call to function 'GetPreviousWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetPreviousWindow(ewg_param_inWindow) GetPreviousWindow ((WindowRef)ewg_param_inWindow)

WindowRef  ewg_function_GetPreviousWindow (WindowRef inWindow);
// Wraps call to function 'GetWindowStandardState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowStandardState(ewg_param_window, ewg_param_rect) GetWindowStandardState ((WindowRef)ewg_param_window, (Rect*)ewg_param_rect)

Rect * ewg_function_GetWindowStandardState (WindowRef window, Rect *rect);
// Wraps call to function 'GetWindowUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowUserState(ewg_param_window, ewg_param_rect) GetWindowUserState ((WindowRef)ewg_param_window, (Rect*)ewg_param_rect)

Rect * ewg_function_GetWindowUserState (WindowRef window, Rect *rect);
// Wraps call to function 'SetWindowKind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowKind(ewg_param_window, ewg_param_kind) SetWindowKind ((WindowRef)ewg_param_window, (short)ewg_param_kind)

void  ewg_function_SetWindowKind (WindowRef window, short kind);
// Wraps call to function 'SetWindowStandardState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowStandardState(ewg_param_window, ewg_param_rect) SetWindowStandardState ((WindowRef)ewg_param_window, (Rect const*)ewg_param_rect)

void  ewg_function_SetWindowStandardState (WindowRef window, Rect const *rect);
// Wraps call to function 'SetWindowUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowUserState(ewg_param_window, ewg_param_rect) SetWindowUserState ((WindowRef)ewg_param_window, (Rect const*)ewg_param_rect)

void  ewg_function_SetWindowUserState (WindowRef window, Rect const *rect);
// Wraps call to function 'SetPortWindowPort' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetPortWindowPort(ewg_param_window) SetPortWindowPort ((WindowRef)ewg_param_window)

void  ewg_function_SetPortWindowPort (WindowRef window);
// Wraps call to function 'GetWindowPortBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowPortBounds(ewg_param_window, ewg_param_bounds) GetWindowPortBounds ((WindowRef)ewg_param_window, (Rect*)ewg_param_bounds)

Rect * ewg_function_GetWindowPortBounds (WindowRef window, Rect *bounds);
// Wraps call to function 'GetWindowFromPort' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowFromPort(ewg_param_port) GetWindowFromPort ((CGrafPtr)ewg_param_port)

WindowRef  ewg_function_GetWindowFromPort (CGrafPtr port);
// Wraps call to function 'IsUserCancelEventRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsUserCancelEventRef(ewg_param_event) IsUserCancelEventRef ((EventRef)ewg_param_event)

Boolean  ewg_function_IsUserCancelEventRef (EventRef event);
// Wraps call to function 'TrackMouseLocation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackMouseLocation(ewg_param_inPort, ewg_param_outPt, ewg_param_outResult) TrackMouseLocation ((GrafPtr)ewg_param_inPort, (Point*)ewg_param_outPt, (MouseTrackingResult*)ewg_param_outResult)

OSStatus  ewg_function_TrackMouseLocation (GrafPtr inPort, Point *outPt, MouseTrackingResult *outResult);
// Wraps call to function 'TrackMouseLocationWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackMouseLocationWithOptions(ewg_param_inPort, ewg_param_inOptions, ewg_param_inTimeout, ewg_param_outPt, ewg_param_outModifiers, ewg_param_outResult) TrackMouseLocationWithOptions ((GrafPtr)ewg_param_inPort, (OptionBits)ewg_param_inOptions, (EventTimeout)ewg_param_inTimeout, (Point*)ewg_param_outPt, (UInt32*)ewg_param_outModifiers, (MouseTrackingResult*)ewg_param_outResult)

OSStatus  ewg_function_TrackMouseLocationWithOptions (GrafPtr inPort, OptionBits inOptions, EventTimeout inTimeout, Point *outPt, UInt32 *outModifiers, MouseTrackingResult *outResult);
// Wraps call to function 'TrackMouseRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TrackMouseRegion(ewg_param_inPort, ewg_param_inRegion, ewg_param_ioWasInRgn, ewg_param_outResult) TrackMouseRegion ((GrafPtr)ewg_param_inPort, (RgnHandle)ewg_param_inRegion, (Boolean*)ewg_param_ioWasInRgn, (MouseTrackingResult*)ewg_param_outResult)

OSStatus  ewg_function_TrackMouseRegion (GrafPtr inPort, RgnHandle inRegion, Boolean *ioWasInRgn, MouseTrackingResult *outResult);
// Wraps call to function 'HIMouseTrackingGetParameters' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIMouseTrackingGetParameters(ewg_param_inSelector, ewg_param_outTime, ewg_param_outDistance) HIMouseTrackingGetParameters ((OSType)ewg_param_inSelector, (EventTime*)ewg_param_outTime, (HISize*)ewg_param_outDistance)

OSStatus  ewg_function_HIMouseTrackingGetParameters (OSType inSelector, EventTime *outTime, HISize *outDistance);
// Wraps call to function 'ConvertEventRefToEventRecord' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ConvertEventRefToEventRecord(ewg_param_inEvent, ewg_param_outEvent) ConvertEventRefToEventRecord ((EventRef)ewg_param_inEvent, (EventRecord*)ewg_param_outEvent)

Boolean  ewg_function_ConvertEventRefToEventRecord (EventRef inEvent, EventRecord *outEvent);
// Wraps call to function 'IsEventInMask' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsEventInMask(ewg_param_inEvent, ewg_param_inMask) IsEventInMask ((EventRef)ewg_param_inEvent, (EventMask)ewg_param_inMask)

Boolean  ewg_function_IsEventInMask (EventRef inEvent, EventMask inMask);
// Wraps call to function 'GetLastUserEventTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetLastUserEventTime GetLastUserEventTime ()

EventTime  ewg_function_GetLastUserEventTime (void);
// Wraps call to function 'IsMouseCoalescingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsMouseCoalescingEnabled IsMouseCoalescingEnabled ()

Boolean  ewg_function_IsMouseCoalescingEnabled (void);
// Wraps call to function 'SetMouseCoalescingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMouseCoalescingEnabled(ewg_param_inNewState, ewg_param_outOldState) SetMouseCoalescingEnabled ((Boolean)ewg_param_inNewState, (Boolean*)ewg_param_outOldState)

OSStatus  ewg_function_SetMouseCoalescingEnabled (Boolean inNewState, Boolean *outOldState);
// Wraps call to function 'CreateTypeStringWithOSType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateTypeStringWithOSType(ewg_param_inType) CreateTypeStringWithOSType ((OSType)ewg_param_inType)

CFStringRef  ewg_function_CreateTypeStringWithOSType (OSType inType);
// Wraps call to function 'CopyServicesMenuCommandKeys' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyServicesMenuCommandKeys(ewg_param_outCommandKeyArray) CopyServicesMenuCommandKeys ((CFArrayRef*)ewg_param_outCommandKeyArray)

OSStatus  ewg_function_CopyServicesMenuCommandKeys (CFArrayRef *outCommandKeyArray);
// Wraps call to function 'AXUIElementCreateWithHIObjectAndIdentifier' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXUIElementCreateWithHIObjectAndIdentifier(ewg_param_inHIObject, ewg_param_inIdentifier) AXUIElementCreateWithHIObjectAndIdentifier ((HIObjectRef)ewg_param_inHIObject, (UInt64)ewg_param_inIdentifier)

AXUIElementRef  ewg_function_AXUIElementCreateWithHIObjectAndIdentifier (HIObjectRef inHIObject, UInt64 inIdentifier);
// Wraps call to function 'AXUIElementGetHIObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXUIElementGetHIObject(ewg_param_inUIElement) AXUIElementGetHIObject ((AXUIElementRef)ewg_param_inUIElement)

HIObjectRef  ewg_function_AXUIElementGetHIObject (AXUIElementRef inUIElement);
// Wraps call to function 'AXUIElementGetIdentifier' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXUIElementGetIdentifier(ewg_param_inUIElement, ewg_param_outIdentifier) AXUIElementGetIdentifier ((AXUIElementRef)ewg_param_inUIElement, (UInt64*)ewg_param_outIdentifier)

void  ewg_function_AXUIElementGetIdentifier (AXUIElementRef inUIElement, UInt64 *outIdentifier);
// Wraps call to function 'AXNotificationHIObjectNotify' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXNotificationHIObjectNotify(ewg_param_inNotification, ewg_param_inHIObject, ewg_param_inIdentifier) AXNotificationHIObjectNotify ((CFStringRef)ewg_param_inNotification, (HIObjectRef)ewg_param_inHIObject, (UInt64)ewg_param_inIdentifier)

void  ewg_function_AXNotificationHIObjectNotify (CFStringRef inNotification, HIObjectRef inHIObject, UInt64 inIdentifier);
// Wraps call to function 'HICopyAccessibilityRoleDescription' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HICopyAccessibilityRoleDescription(ewg_param_inRole, ewg_param_inSubrole) HICopyAccessibilityRoleDescription ((CFStringRef)ewg_param_inRole, (CFStringRef)ewg_param_inSubrole)

CFStringRef  ewg_function_HICopyAccessibilityRoleDescription (CFStringRef inRole, CFStringRef inSubrole);
// Wraps call to function 'HICopyAccessibilityActionDescription' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HICopyAccessibilityActionDescription(ewg_param_inAction) HICopyAccessibilityActionDescription ((CFStringRef)ewg_param_inAction)

CFStringRef  ewg_function_HICopyAccessibilityActionDescription (CFStringRef inAction);
// Wraps call to function 'GetWindowEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowEventTarget(ewg_param_inWindow) GetWindowEventTarget ((WindowRef)ewg_param_inWindow)

EventTargetRef  ewg_function_GetWindowEventTarget (WindowRef inWindow);
// Wraps call to function 'GetControlEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetControlEventTarget(ewg_param_inControl) GetControlEventTarget ((ControlRef)ewg_param_inControl)

EventTargetRef  ewg_function_GetControlEventTarget (ControlRef inControl);
// Wraps call to function 'GetMenuEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMenuEventTarget(ewg_param_inMenu) GetMenuEventTarget ((MenuRef)ewg_param_inMenu)

EventTargetRef  ewg_function_GetMenuEventTarget (MenuRef inMenu);
// Wraps call to function 'GetApplicationEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetApplicationEventTarget GetApplicationEventTarget ()

EventTargetRef  ewg_function_GetApplicationEventTarget (void);
// Wraps call to function 'GetUserFocusEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetUserFocusEventTarget GetUserFocusEventTarget ()

EventTargetRef  ewg_function_GetUserFocusEventTarget (void);
// Wraps call to function 'GetEventDispatcherTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventDispatcherTarget GetEventDispatcherTarget ()

EventTargetRef  ewg_function_GetEventDispatcherTarget (void);
// Wraps call to function 'GetEventMonitorTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetEventMonitorTarget GetEventMonitorTarget ()

EventTargetRef  ewg_function_GetEventMonitorTarget (void);
// Wraps call to function 'ProcessHICommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ProcessHICommand(ewg_param_inCommand) ProcessHICommand ((HICommand const*)ewg_param_inCommand)

OSStatus  ewg_function_ProcessHICommand (HICommand const *inCommand);
// Wraps call to function 'RunApplicationEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RunApplicationEventLoop RunApplicationEventLoop ()

void  ewg_function_RunApplicationEventLoop (void);
// Wraps call to function 'QuitApplicationEventLoop' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QuitApplicationEventLoop QuitApplicationEventLoop ()

void  ewg_function_QuitApplicationEventLoop (void);
// Wraps call to function 'RunAppModalLoopForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RunAppModalLoopForWindow(ewg_param_inWindow) RunAppModalLoopForWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_RunAppModalLoopForWindow (WindowRef inWindow);
// Wraps call to function 'QuitAppModalLoopForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_QuitAppModalLoopForWindow(ewg_param_inWindow) QuitAppModalLoopForWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_QuitAppModalLoopForWindow (WindowRef inWindow);
// Wraps call to function 'BeginAppModalStateForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_BeginAppModalStateForWindow(ewg_param_inWindow) BeginAppModalStateForWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_BeginAppModalStateForWindow (WindowRef inWindow);
// Wraps call to function 'EndAppModalStateForWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EndAppModalStateForWindow(ewg_param_inWindow) EndAppModalStateForWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_EndAppModalStateForWindow (WindowRef inWindow);
// Wraps call to function 'SetUserFocusWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetUserFocusWindow(ewg_param_inWindow) SetUserFocusWindow ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_SetUserFocusWindow (WindowRef inWindow);
// Wraps call to function 'GetUserFocusWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetUserFocusWindow GetUserFocusWindow ()

WindowRef  ewg_function_GetUserFocusWindow (void);
// Wraps call to function 'SetWindowDefaultButton' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowDefaultButton(ewg_param_inWindow, ewg_param_inControl) SetWindowDefaultButton ((WindowRef)ewg_param_inWindow, (ControlRef)ewg_param_inControl)

OSStatus  ewg_function_SetWindowDefaultButton (WindowRef inWindow, ControlRef inControl);
// Wraps call to function 'SetWindowCancelButton' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowCancelButton(ewg_param_inWindow, ewg_param_inControl) SetWindowCancelButton ((WindowRef)ewg_param_inWindow, (ControlRef)ewg_param_inControl)

OSStatus  ewg_function_SetWindowCancelButton (WindowRef inWindow, ControlRef inControl);
// Wraps call to function 'GetWindowDefaultButton' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowDefaultButton(ewg_param_inWindow, ewg_param_outControl) GetWindowDefaultButton ((WindowRef)ewg_param_inWindow, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_GetWindowDefaultButton (WindowRef inWindow, ControlRef *outControl);
// Wraps call to function 'GetWindowCancelButton' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetWindowCancelButton(ewg_param_inWindow, ewg_param_outControl) GetWindowCancelButton ((WindowRef)ewg_param_inWindow, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_GetWindowCancelButton (WindowRef inWindow, ControlRef *outControl);
// Wraps call to function 'RegisterEventHotKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RegisterEventHotKey(ewg_param_inHotKeyCode, ewg_param_inHotKeyModifiers, ewg_param_inHotKeyID, ewg_param_inTarget, ewg_param_inOptions, ewg_param_outRef) RegisterEventHotKey ((UInt32)ewg_param_inHotKeyCode, (UInt32)ewg_param_inHotKeyModifiers, *(EventHotKeyID*)ewg_param_inHotKeyID, (EventTargetRef)ewg_param_inTarget, (OptionBits)ewg_param_inOptions, (EventHotKeyRef*)ewg_param_outRef)

OSStatus  ewg_function_RegisterEventHotKey (UInt32 inHotKeyCode, UInt32 inHotKeyModifiers, EventHotKeyID *inHotKeyID, EventTargetRef inTarget, OptionBits inOptions, EventHotKeyRef *outRef);
// Wraps call to function 'UnregisterEventHotKey' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UnregisterEventHotKey(ewg_param_inHotKey) UnregisterEventHotKey ((EventHotKeyRef)ewg_param_inHotKey)

OSStatus  ewg_function_UnregisterEventHotKey (EventHotKeyRef inHotKey);
// Wraps call to function 'CopySymbolicHotKeys' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopySymbolicHotKeys(ewg_param_outHotKeyArray) CopySymbolicHotKeys ((CFArrayRef*)ewg_param_outHotKeyArray)

OSStatus  ewg_function_CopySymbolicHotKeys (CFArrayRef *outHotKeyArray);
// Wraps call to function 'PushSymbolicHotKeyMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PushSymbolicHotKeyMode(ewg_param_inOptions) PushSymbolicHotKeyMode ((OptionBits)ewg_param_inOptions)

void * ewg_function_PushSymbolicHotKeyMode (OptionBits inOptions);
// Wraps call to function 'PopSymbolicHotKeyMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PopSymbolicHotKeyMode(ewg_param_inToken) PopSymbolicHotKeyMode ((void*)ewg_param_inToken)

void  ewg_function_PopSymbolicHotKeyMode (void *inToken);
// Wraps call to function 'GetSymbolicHotKeyMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetSymbolicHotKeyMode GetSymbolicHotKeyMode ()

OptionBits  ewg_function_GetSymbolicHotKeyMode (void);
// Wraps call to function 'CreateMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateMouseTrackingRegion(ewg_param_inWindow, ewg_param_inRegion, ewg_param_inClip, ewg_param_inOptions, ewg_param_inID, ewg_param_inRefCon, ewg_param_inTargetToNotify, ewg_param_outTrackingRef) CreateMouseTrackingRegion ((WindowRef)ewg_param_inWindow, (RgnHandle)ewg_param_inRegion, (RgnHandle)ewg_param_inClip, (MouseTrackingOptions)ewg_param_inOptions, *(MouseTrackingRegionID*)ewg_param_inID, (void*)ewg_param_inRefCon, (EventTargetRef)ewg_param_inTargetToNotify, (MouseTrackingRef*)ewg_param_outTrackingRef)

OSStatus  ewg_function_CreateMouseTrackingRegion (WindowRef inWindow, RgnHandle inRegion, RgnHandle inClip, MouseTrackingOptions inOptions, MouseTrackingRegionID *inID, void *inRefCon, EventTargetRef inTargetToNotify, MouseTrackingRef *outTrackingRef);
// Wraps call to function 'RetainMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RetainMouseTrackingRegion(ewg_param_inMouseRef) RetainMouseTrackingRegion ((MouseTrackingRef)ewg_param_inMouseRef)

OSStatus  ewg_function_RetainMouseTrackingRegion (MouseTrackingRef inMouseRef);
// Wraps call to function 'ReleaseMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseMouseTrackingRegion(ewg_param_inMouseRef) ReleaseMouseTrackingRegion ((MouseTrackingRef)ewg_param_inMouseRef)

OSStatus  ewg_function_ReleaseMouseTrackingRegion (MouseTrackingRef inMouseRef);
// Wraps call to function 'ChangeMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ChangeMouseTrackingRegion(ewg_param_inMouseRef, ewg_param_inRegion, ewg_param_inClip) ChangeMouseTrackingRegion ((MouseTrackingRef)ewg_param_inMouseRef, (RgnHandle)ewg_param_inRegion, (RgnHandle)ewg_param_inClip)

OSStatus  ewg_function_ChangeMouseTrackingRegion (MouseTrackingRef inMouseRef, RgnHandle inRegion, RgnHandle inClip);
// Wraps call to function 'ClipMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ClipMouseTrackingRegion(ewg_param_inMouseRef, ewg_param_inRegion) ClipMouseTrackingRegion ((MouseTrackingRef)ewg_param_inMouseRef, (RgnHandle)ewg_param_inRegion)

OSStatus  ewg_function_ClipMouseTrackingRegion (MouseTrackingRef inMouseRef, RgnHandle inRegion);
// Wraps call to function 'GetMouseTrackingRegionID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMouseTrackingRegionID(ewg_param_inMouseRef, ewg_param_outID) GetMouseTrackingRegionID ((MouseTrackingRef)ewg_param_inMouseRef, (MouseTrackingRegionID*)ewg_param_outID)

OSStatus  ewg_function_GetMouseTrackingRegionID (MouseTrackingRef inMouseRef, MouseTrackingRegionID *outID);
// Wraps call to function 'GetMouseTrackingRegionRefCon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetMouseTrackingRegionRefCon(ewg_param_inMouseRef, ewg_param_outRefCon) GetMouseTrackingRegionRefCon ((MouseTrackingRef)ewg_param_inMouseRef, (void**)ewg_param_outRefCon)

OSStatus  ewg_function_GetMouseTrackingRegionRefCon (MouseTrackingRef inMouseRef, void **outRefCon);
// Wraps call to function 'MoveMouseTrackingRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveMouseTrackingRegion(ewg_param_inMouseRef, ewg_param_deltaH, ewg_param_deltaV, ewg_param_inClip) MoveMouseTrackingRegion ((MouseTrackingRef)ewg_param_inMouseRef, (SInt16)ewg_param_deltaH, (SInt16)ewg_param_deltaV, (RgnHandle)ewg_param_inClip)

OSStatus  ewg_function_MoveMouseTrackingRegion (MouseTrackingRef inMouseRef, SInt16 deltaH, SInt16 deltaV, RgnHandle inClip);
// Wraps call to function 'SetMouseTrackingRegionEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetMouseTrackingRegionEnabled(ewg_param_inMouseRef, ewg_param_inEnabled) SetMouseTrackingRegionEnabled ((MouseTrackingRef)ewg_param_inMouseRef, (Boolean)ewg_param_inEnabled)

OSStatus  ewg_function_SetMouseTrackingRegionEnabled (MouseTrackingRef inMouseRef, Boolean inEnabled);
// Wraps call to function 'ClipWindowMouseTrackingRegions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ClipWindowMouseTrackingRegions(ewg_param_inWindow, ewg_param_inSignature, ewg_param_inClip) ClipWindowMouseTrackingRegions ((WindowRef)ewg_param_inWindow, (OSType)ewg_param_inSignature, (RgnHandle)ewg_param_inClip)

OSStatus  ewg_function_ClipWindowMouseTrackingRegions (WindowRef inWindow, OSType inSignature, RgnHandle inClip);
// Wraps call to function 'MoveWindowMouseTrackingRegions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveWindowMouseTrackingRegions(ewg_param_inWindow, ewg_param_inSignature, ewg_param_deltaH, ewg_param_deltaV, ewg_param_inClip) MoveWindowMouseTrackingRegions ((WindowRef)ewg_param_inWindow, (OSType)ewg_param_inSignature, (SInt16)ewg_param_deltaH, (SInt16)ewg_param_deltaV, (RgnHandle)ewg_param_inClip)

OSStatus  ewg_function_MoveWindowMouseTrackingRegions (WindowRef inWindow, OSType inSignature, SInt16 deltaH, SInt16 deltaV, RgnHandle inClip);
// Wraps call to function 'SetWindowMouseTrackingRegionsEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetWindowMouseTrackingRegionsEnabled(ewg_param_inWindow, ewg_param_inSignature, ewg_param_inEnabled) SetWindowMouseTrackingRegionsEnabled ((WindowRef)ewg_param_inWindow, (OSType)ewg_param_inSignature, (Boolean)ewg_param_inEnabled)

OSStatus  ewg_function_SetWindowMouseTrackingRegionsEnabled (WindowRef inWindow, OSType inSignature, Boolean inEnabled);
// Wraps call to function 'ReleaseWindowMouseTrackingRegions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ReleaseWindowMouseTrackingRegions(ewg_param_inWindow, ewg_param_inSignature) ReleaseWindowMouseTrackingRegions ((WindowRef)ewg_param_inWindow, (OSType)ewg_param_inSignature)

OSStatus  ewg_function_ReleaseWindowMouseTrackingRegions (WindowRef inWindow, OSType inSignature);
// Wraps call to function 'RegisterToolboxObjectClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RegisterToolboxObjectClass(ewg_param_inClassID, ewg_param_inBaseClass, ewg_param_inNumEvents, ewg_param_inEventList, ewg_param_inEventHandler, ewg_param_inEventHandlerData, ewg_param_outClassRef) RegisterToolboxObjectClass ((CFStringRef)ewg_param_inClassID, (ToolboxObjectClassRef)ewg_param_inBaseClass, (UInt32)ewg_param_inNumEvents, (EventTypeSpec const*)ewg_param_inEventList, (EventHandlerUPP)ewg_param_inEventHandler, (void*)ewg_param_inEventHandlerData, (ToolboxObjectClassRef*)ewg_param_outClassRef)

OSStatus  ewg_function_RegisterToolboxObjectClass (CFStringRef inClassID, ToolboxObjectClassRef inBaseClass, UInt32 inNumEvents, EventTypeSpec const *inEventList, EventHandlerUPP inEventHandler, void *inEventHandlerData, ToolboxObjectClassRef *outClassRef);
// Wraps call to function 'UnregisterToolboxObjectClass' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UnregisterToolboxObjectClass(ewg_param_inClassRef) UnregisterToolboxObjectClass ((ToolboxObjectClassRef)ewg_param_inClassRef)

OSStatus  ewg_function_UnregisterToolboxObjectClass (ToolboxObjectClassRef inClassRef);
// Wraps call to function 'HIViewGetRoot' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetRoot(ewg_param_inWindow) HIViewGetRoot ((WindowRef)ewg_param_inWindow)

HIViewRef  ewg_function_HIViewGetRoot (WindowRef inWindow);
// Wraps call to function 'HIViewAddSubview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewAddSubview(ewg_param_inParent, ewg_param_inNewChild) HIViewAddSubview ((HIViewRef)ewg_param_inParent, (HIViewRef)ewg_param_inNewChild)

OSStatus  ewg_function_HIViewAddSubview (HIViewRef inParent, HIViewRef inNewChild);
// Wraps call to function 'HIViewRemoveFromSuperview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewRemoveFromSuperview(ewg_param_inView) HIViewRemoveFromSuperview ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewRemoveFromSuperview (HIViewRef inView);
// Wraps call to function 'HIViewGetSuperview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetSuperview(ewg_param_inView) HIViewGetSuperview ((HIViewRef)ewg_param_inView)

HIViewRef  ewg_function_HIViewGetSuperview (HIViewRef inView);
// Wraps call to function 'HIViewGetFirstSubview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetFirstSubview(ewg_param_inView) HIViewGetFirstSubview ((HIViewRef)ewg_param_inView)

HIViewRef  ewg_function_HIViewGetFirstSubview (HIViewRef inView);
// Wraps call to function 'HIViewGetLastSubview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetLastSubview(ewg_param_inView) HIViewGetLastSubview ((HIViewRef)ewg_param_inView)

HIViewRef  ewg_function_HIViewGetLastSubview (HIViewRef inView);
// Wraps call to function 'HIViewGetNextView' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetNextView(ewg_param_inView) HIViewGetNextView ((HIViewRef)ewg_param_inView)

HIViewRef  ewg_function_HIViewGetNextView (HIViewRef inView);
// Wraps call to function 'HIViewGetPreviousView' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetPreviousView(ewg_param_inView) HIViewGetPreviousView ((HIViewRef)ewg_param_inView)

HIViewRef  ewg_function_HIViewGetPreviousView (HIViewRef inView);
// Wraps call to function 'HIViewCountSubviews' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewCountSubviews(ewg_param_inView) HIViewCountSubviews ((HIViewRef)ewg_param_inView)

CFIndex  ewg_function_HIViewCountSubviews (HIViewRef inView);
// Wraps call to function 'HIViewGetIndexedSubview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetIndexedSubview(ewg_param_inView, ewg_param_inSubviewIndex, ewg_param_outSubview) HIViewGetIndexedSubview ((HIViewRef)ewg_param_inView, (CFIndex)ewg_param_inSubviewIndex, (HIViewRef*)ewg_param_outSubview)

OSStatus  ewg_function_HIViewGetIndexedSubview (HIViewRef inView, CFIndex inSubviewIndex, HIViewRef *outSubview);
// Wraps call to function 'HIViewSetZOrder' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetZOrder(ewg_param_inView, ewg_param_inOp, ewg_param_inOther) HIViewSetZOrder ((HIViewRef)ewg_param_inView, (HIViewZOrderOp)ewg_param_inOp, (HIViewRef)ewg_param_inOther)

OSStatus  ewg_function_HIViewSetZOrder (HIViewRef inView, HIViewZOrderOp inOp, HIViewRef inOther);
// Wraps call to function 'HIViewSetVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetVisible(ewg_param_inView, ewg_param_inVisible) HIViewSetVisible ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inVisible)

OSStatus  ewg_function_HIViewSetVisible (HIViewRef inView, Boolean inVisible);
// Wraps call to function 'HIViewIsVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsVisible(ewg_param_inView) HIViewIsVisible ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsVisible (HIViewRef inView);
// Wraps call to function 'HIViewIsLatentlyVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsLatentlyVisible(ewg_param_inView) HIViewIsLatentlyVisible ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsLatentlyVisible (HIViewRef inView);
// Wraps call to function 'HIViewSetHilite' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetHilite(ewg_param_inView, ewg_param_inHilitePart) HIViewSetHilite ((HIViewRef)ewg_param_inView, (HIViewPartCode)ewg_param_inHilitePart)

OSStatus  ewg_function_HIViewSetHilite (HIViewRef inView, HIViewPartCode inHilitePart);
// Wraps call to function 'HIViewIsActive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsActive(ewg_param_inView, ewg_param_outIsLatentActive) HIViewIsActive ((HIViewRef)ewg_param_inView, (Boolean*)ewg_param_outIsLatentActive)

Boolean  ewg_function_HIViewIsActive (HIViewRef inView, Boolean *outIsLatentActive);
// Wraps call to function 'HIViewSetActivated' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetActivated(ewg_param_inView, ewg_param_inSetActivated) HIViewSetActivated ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inSetActivated)

OSStatus  ewg_function_HIViewSetActivated (HIViewRef inView, Boolean inSetActivated);
// Wraps call to function 'HIViewIsEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsEnabled(ewg_param_inView, ewg_param_outIsLatentEnabled) HIViewIsEnabled ((HIViewRef)ewg_param_inView, (Boolean*)ewg_param_outIsLatentEnabled)

Boolean  ewg_function_HIViewIsEnabled (HIViewRef inView, Boolean *outIsLatentEnabled);
// Wraps call to function 'HIViewSetEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetEnabled(ewg_param_inView, ewg_param_inSetEnabled) HIViewSetEnabled ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inSetEnabled)

OSStatus  ewg_function_HIViewSetEnabled (HIViewRef inView, Boolean inSetEnabled);
// Wraps call to function 'HIViewIsCompositingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsCompositingEnabled(ewg_param_inView) HIViewIsCompositingEnabled ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsCompositingEnabled (HIViewRef inView);
// Wraps call to function 'HIViewSetText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetText(ewg_param_inView, ewg_param_inText) HIViewSetText ((HIViewRef)ewg_param_inView, (CFStringRef)ewg_param_inText)

OSStatus  ewg_function_HIViewSetText (HIViewRef inView, CFStringRef inText);
// Wraps call to function 'HIViewCopyText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewCopyText(ewg_param_inView) HIViewCopyText ((HIViewRef)ewg_param_inView)

CFStringRef  ewg_function_HIViewCopyText (HIViewRef inView);
// Wraps call to function 'HIViewGetValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetValue(ewg_param_inView) HIViewGetValue ((HIViewRef)ewg_param_inView)

SInt32  ewg_function_HIViewGetValue (HIViewRef inView);
// Wraps call to function 'HIViewSetValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetValue(ewg_param_inView, ewg_param_inValue) HIViewSetValue ((HIViewRef)ewg_param_inView, (SInt32)ewg_param_inValue)

OSStatus  ewg_function_HIViewSetValue (HIViewRef inView, SInt32 inValue);
// Wraps call to function 'HIViewGetMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetMinimum(ewg_param_inView) HIViewGetMinimum ((HIViewRef)ewg_param_inView)

SInt32  ewg_function_HIViewGetMinimum (HIViewRef inView);
// Wraps call to function 'HIViewSetMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetMinimum(ewg_param_inView, ewg_param_inMinimum) HIViewSetMinimum ((HIViewRef)ewg_param_inView, (SInt32)ewg_param_inMinimum)

OSStatus  ewg_function_HIViewSetMinimum (HIViewRef inView, SInt32 inMinimum);
// Wraps call to function 'HIViewGetMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetMaximum(ewg_param_inView) HIViewGetMaximum ((HIViewRef)ewg_param_inView)

SInt32  ewg_function_HIViewGetMaximum (HIViewRef inView);
// Wraps call to function 'HIViewSetMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetMaximum(ewg_param_inView, ewg_param_inMaximum) HIViewSetMaximum ((HIViewRef)ewg_param_inView, (SInt32)ewg_param_inMaximum)

OSStatus  ewg_function_HIViewSetMaximum (HIViewRef inView, SInt32 inMaximum);
// Wraps call to function 'HIViewGetViewSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetViewSize(ewg_param_inView) HIViewGetViewSize ((HIViewRef)ewg_param_inView)

SInt32  ewg_function_HIViewGetViewSize (HIViewRef inView);
// Wraps call to function 'HIViewSetViewSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetViewSize(ewg_param_inView, ewg_param_inViewSize) HIViewSetViewSize ((HIViewRef)ewg_param_inView, (SInt32)ewg_param_inViewSize)

OSStatus  ewg_function_HIViewSetViewSize (HIViewRef inView, SInt32 inViewSize);
// Wraps call to function 'HIViewIsValid' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsValid(ewg_param_inView) HIViewIsValid ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsValid (HIViewRef inView);
// Wraps call to function 'HIViewSetID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetID(ewg_param_inView, ewg_param_inID) HIViewSetID ((HIViewRef)ewg_param_inView, *(HIViewID*)ewg_param_inID)

OSStatus  ewg_function_HIViewSetID (HIViewRef inView, HIViewID *inID);
// Wraps call to function 'HIViewGetID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetID(ewg_param_inView, ewg_param_outID) HIViewGetID ((HIViewRef)ewg_param_inView, (HIViewID*)ewg_param_outID)

OSStatus  ewg_function_HIViewGetID (HIViewRef inView, HIViewID *outID);
// Wraps call to function 'HIViewSetCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetCommandID(ewg_param_inView, ewg_param_inCommandID) HIViewSetCommandID ((HIViewRef)ewg_param_inView, (UInt32)ewg_param_inCommandID)

OSStatus  ewg_function_HIViewSetCommandID (HIViewRef inView, UInt32 inCommandID);
// Wraps call to function 'HIViewGetCommandID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetCommandID(ewg_param_inView, ewg_param_outCommandID) HIViewGetCommandID ((HIViewRef)ewg_param_inView, (UInt32*)ewg_param_outCommandID)

OSStatus  ewg_function_HIViewGetCommandID (HIViewRef inView, UInt32 *outCommandID);
// Wraps call to function 'HIViewGetKind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetKind(ewg_param_inView, ewg_param_outViewKind) HIViewGetKind ((HIViewRef)ewg_param_inView, (HIViewKind*)ewg_param_outViewKind)

OSStatus  ewg_function_HIViewGetKind (HIViewRef inView, HIViewKind *outViewKind);
// Wraps call to function 'HIViewGetBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetBounds(ewg_param_inView, ewg_param_outRect) HIViewGetBounds ((HIViewRef)ewg_param_inView, (HIRect*)ewg_param_outRect)

OSStatus  ewg_function_HIViewGetBounds (HIViewRef inView, HIRect *outRect);
// Wraps call to function 'HIViewGetFrame' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetFrame(ewg_param_inView, ewg_param_outRect) HIViewGetFrame ((HIViewRef)ewg_param_inView, (HIRect*)ewg_param_outRect)

OSStatus  ewg_function_HIViewGetFrame (HIViewRef inView, HIRect *outRect);
// Wraps call to function 'HIViewSetFrame' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetFrame(ewg_param_inView, ewg_param_inRect) HIViewSetFrame ((HIViewRef)ewg_param_inView, (HIRect const*)ewg_param_inRect)

OSStatus  ewg_function_HIViewSetFrame (HIViewRef inView, HIRect const *inRect);
// Wraps call to function 'HIViewMoveBy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewMoveBy(ewg_param_inView, ewg_param_inDX, ewg_param_inDY) HIViewMoveBy ((HIViewRef)ewg_param_inView, (float)ewg_param_inDX, (float)ewg_param_inDY)

OSStatus  ewg_function_HIViewMoveBy (HIViewRef inView, float inDX, float inDY);
// Wraps call to function 'HIViewPlaceInSuperviewAt' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewPlaceInSuperviewAt(ewg_param_inView, ewg_param_inX, ewg_param_inY) HIViewPlaceInSuperviewAt ((HIViewRef)ewg_param_inView, (float)ewg_param_inX, (float)ewg_param_inY)

OSStatus  ewg_function_HIViewPlaceInSuperviewAt (HIViewRef inView, float inX, float inY);
// Wraps call to function 'HIViewReshapeStructure' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewReshapeStructure(ewg_param_inView) HIViewReshapeStructure ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewReshapeStructure (HIViewRef inView);
// Wraps call to function 'HIViewRegionChanged' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewRegionChanged(ewg_param_inView, ewg_param_inRegionCode) HIViewRegionChanged ((HIViewRef)ewg_param_inView, (HIViewPartCode)ewg_param_inRegionCode)

OSStatus  ewg_function_HIViewRegionChanged (HIViewRef inView, HIViewPartCode inRegionCode);
// Wraps call to function 'HIViewCopyShape' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewCopyShape(ewg_param_inView, ewg_param_inPart, ewg_param_outShape) HIViewCopyShape ((HIViewRef)ewg_param_inView, (HIViewPartCode)ewg_param_inPart, (HIShapeRef*)ewg_param_outShape)

OSStatus  ewg_function_HIViewCopyShape (HIViewRef inView, HIViewPartCode inPart, HIShapeRef *outShape);
// Wraps call to function 'HIViewGetOptimalBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetOptimalBounds(ewg_param_inView, ewg_param_outBounds, ewg_param_outBaseLineOffset) HIViewGetOptimalBounds ((HIViewRef)ewg_param_inView, (HIRect*)ewg_param_outBounds, (float*)ewg_param_outBaseLineOffset)

OSStatus  ewg_function_HIViewGetOptimalBounds (HIViewRef inView, HIRect *outBounds, float *outBaseLineOffset);
// Wraps call to function 'HIViewGetViewForMouseEvent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetViewForMouseEvent(ewg_param_inView, ewg_param_inEvent, ewg_param_outView) HIViewGetViewForMouseEvent ((HIViewRef)ewg_param_inView, (EventRef)ewg_param_inEvent, (HIViewRef*)ewg_param_outView)

OSStatus  ewg_function_HIViewGetViewForMouseEvent (HIViewRef inView, EventRef inEvent, HIViewRef *outView);
// Wraps call to function 'HIViewClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewClick(ewg_param_inView, ewg_param_inEvent) HIViewClick ((HIViewRef)ewg_param_inView, (EventRef)ewg_param_inEvent)

OSStatus  ewg_function_HIViewClick (HIViewRef inView, EventRef inEvent);
// Wraps call to function 'HIViewSimulateClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSimulateClick(ewg_param_inView, ewg_param_inPartToClick, ewg_param_inModifiers, ewg_param_outPartClicked) HIViewSimulateClick ((HIViewRef)ewg_param_inView, (HIViewPartCode)ewg_param_inPartToClick, (UInt32)ewg_param_inModifiers, (HIViewPartCode*)ewg_param_outPartClicked)

OSStatus  ewg_function_HIViewSimulateClick (HIViewRef inView, HIViewPartCode inPartToClick, UInt32 inModifiers, HIViewPartCode *outPartClicked);
// Wraps call to function 'HIViewGetPartHit' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetPartHit(ewg_param_inView, ewg_param_inPoint, ewg_param_outPart) HIViewGetPartHit ((HIViewRef)ewg_param_inView, (HIPoint const*)ewg_param_inPoint, (HIViewPartCode*)ewg_param_outPart)

OSStatus  ewg_function_HIViewGetPartHit (HIViewRef inView, HIPoint const *inPoint, HIViewPartCode *outPart);
// Wraps call to function 'HIViewGetSubviewHit' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetSubviewHit(ewg_param_inView, ewg_param_inPoint, ewg_param_inDeep, ewg_param_outView) HIViewGetSubviewHit ((HIViewRef)ewg_param_inView, (HIPoint const*)ewg_param_inPoint, (Boolean)ewg_param_inDeep, (HIViewRef*)ewg_param_outView)

OSStatus  ewg_function_HIViewGetSubviewHit (HIViewRef inView, HIPoint const *inPoint, Boolean inDeep, HIViewRef *outView);
// Wraps call to function 'HIViewNewTrackingArea' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewNewTrackingArea(ewg_param_inView, ewg_param_inShape, ewg_param_inID, ewg_param_outRef) HIViewNewTrackingArea ((HIViewRef)ewg_param_inView, (HIShapeRef)ewg_param_inShape, (HIViewTrackingAreaID)ewg_param_inID, (HIViewTrackingAreaRef*)ewg_param_outRef)

OSStatus  ewg_function_HIViewNewTrackingArea (HIViewRef inView, HIShapeRef inShape, HIViewTrackingAreaID inID, HIViewTrackingAreaRef *outRef);
// Wraps call to function 'HIViewChangeTrackingArea' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewChangeTrackingArea(ewg_param_inArea, ewg_param_inShape) HIViewChangeTrackingArea ((HIViewTrackingAreaRef)ewg_param_inArea, (HIShapeRef)ewg_param_inShape)

OSStatus  ewg_function_HIViewChangeTrackingArea (HIViewTrackingAreaRef inArea, HIShapeRef inShape);
// Wraps call to function 'HIViewGetTrackingAreaID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetTrackingAreaID(ewg_param_inArea, ewg_param_outID) HIViewGetTrackingAreaID ((HIViewTrackingAreaRef)ewg_param_inArea, (HIViewTrackingAreaID*)ewg_param_outID)

OSStatus  ewg_function_HIViewGetTrackingAreaID (HIViewTrackingAreaRef inArea, HIViewTrackingAreaID *outID);
// Wraps call to function 'HIViewDisposeTrackingArea' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewDisposeTrackingArea(ewg_param_inArea) HIViewDisposeTrackingArea ((HIViewTrackingAreaRef)ewg_param_inArea)

OSStatus  ewg_function_HIViewDisposeTrackingArea (HIViewTrackingAreaRef inArea);
// Wraps call to function 'HIViewGetNeedsDisplay' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetNeedsDisplay(ewg_param_inView) HIViewGetNeedsDisplay ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewGetNeedsDisplay (HIViewRef inView);
// Wraps call to function 'HIViewSetNeedsDisplay' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetNeedsDisplay(ewg_param_inView, ewg_param_inNeedsDisplay) HIViewSetNeedsDisplay ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inNeedsDisplay)

OSStatus  ewg_function_HIViewSetNeedsDisplay (HIViewRef inView, Boolean inNeedsDisplay);
// Wraps call to function 'HIViewSetNeedsDisplayInRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetNeedsDisplayInRect(ewg_param_inView, ewg_param_inRect, ewg_param_inNeedsDisplay) HIViewSetNeedsDisplayInRect ((HIViewRef)ewg_param_inView, (HIRect const*)ewg_param_inRect, (Boolean)ewg_param_inNeedsDisplay)

OSStatus  ewg_function_HIViewSetNeedsDisplayInRect (HIViewRef inView, HIRect const *inRect, Boolean inNeedsDisplay);
// Wraps call to function 'HIViewSetNeedsDisplayInShape' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetNeedsDisplayInShape(ewg_param_inView, ewg_param_inArea, ewg_param_inNeedsDisplay) HIViewSetNeedsDisplayInShape ((HIViewRef)ewg_param_inView, (HIShapeRef)ewg_param_inArea, (Boolean)ewg_param_inNeedsDisplay)

OSStatus  ewg_function_HIViewSetNeedsDisplayInShape (HIViewRef inView, HIShapeRef inArea, Boolean inNeedsDisplay);
// Wraps call to function 'HIViewSetNeedsDisplayInRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetNeedsDisplayInRegion(ewg_param_inView, ewg_param_inRgn, ewg_param_inNeedsDisplay) HIViewSetNeedsDisplayInRegion ((HIViewRef)ewg_param_inView, (RgnHandle)ewg_param_inRgn, (Boolean)ewg_param_inNeedsDisplay)

OSStatus  ewg_function_HIViewSetNeedsDisplayInRegion (HIViewRef inView, RgnHandle inRgn, Boolean inNeedsDisplay);
// Wraps call to function 'HIViewRender' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewRender(ewg_param_inView) HIViewRender ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewRender (HIViewRef inView);
// Wraps call to function 'HIViewFlashDirtyArea' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewFlashDirtyArea(ewg_param_inWindow) HIViewFlashDirtyArea ((WindowRef)ewg_param_inWindow)

OSStatus  ewg_function_HIViewFlashDirtyArea (WindowRef inWindow);
// Wraps call to function 'HIViewGetSizeConstraints' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetSizeConstraints(ewg_param_inView, ewg_param_outMinSize, ewg_param_outMaxSize) HIViewGetSizeConstraints ((HIViewRef)ewg_param_inView, (HISize*)ewg_param_outMinSize, (HISize*)ewg_param_outMaxSize)

OSStatus  ewg_function_HIViewGetSizeConstraints (HIViewRef inView, HISize *outMinSize, HISize *outMaxSize);
// Wraps call to function 'HIViewConvertPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewConvertPoint(ewg_param_ioPoint, ewg_param_inSourceView, ewg_param_inDestView) HIViewConvertPoint ((HIPoint*)ewg_param_ioPoint, (HIViewRef)ewg_param_inSourceView, (HIViewRef)ewg_param_inDestView)

OSStatus  ewg_function_HIViewConvertPoint (HIPoint *ioPoint, HIViewRef inSourceView, HIViewRef inDestView);
// Wraps call to function 'HIViewConvertRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewConvertRect(ewg_param_ioRect, ewg_param_inSourceView, ewg_param_inDestView) HIViewConvertRect ((HIRect*)ewg_param_ioRect, (HIViewRef)ewg_param_inSourceView, (HIViewRef)ewg_param_inDestView)

OSStatus  ewg_function_HIViewConvertRect (HIRect *ioRect, HIViewRef inSourceView, HIViewRef inDestView);
// Wraps call to function 'HIViewConvertRegion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewConvertRegion(ewg_param_ioRgn, ewg_param_inSourceView, ewg_param_inDestView) HIViewConvertRegion ((RgnHandle)ewg_param_ioRgn, (HIViewRef)ewg_param_inSourceView, (HIViewRef)ewg_param_inDestView)

OSStatus  ewg_function_HIViewConvertRegion (RgnHandle ioRgn, HIViewRef inSourceView, HIViewRef inDestView);
// Wraps call to function 'HIViewSetDrawingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetDrawingEnabled(ewg_param_inView, ewg_param_inEnabled) HIViewSetDrawingEnabled ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inEnabled)

OSStatus  ewg_function_HIViewSetDrawingEnabled (HIViewRef inView, Boolean inEnabled);
// Wraps call to function 'HIViewIsDrawingEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsDrawingEnabled(ewg_param_inView) HIViewIsDrawingEnabled ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsDrawingEnabled (HIViewRef inView);
// Wraps call to function 'HIViewScrollRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewScrollRect(ewg_param_inView, ewg_param_inRect, ewg_param_inDX, ewg_param_inDY) HIViewScrollRect ((HIViewRef)ewg_param_inView, (HIRect const*)ewg_param_inRect, (float)ewg_param_inDX, (float)ewg_param_inDY)

OSStatus  ewg_function_HIViewScrollRect (HIViewRef inView, HIRect const *inRect, float inDX, float inDY);
// Wraps call to function 'HIViewSetBoundsOrigin' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetBoundsOrigin(ewg_param_inView, ewg_param_inX, ewg_param_inY) HIViewSetBoundsOrigin ((HIViewRef)ewg_param_inView, (float)ewg_param_inX, (float)ewg_param_inY)

OSStatus  ewg_function_HIViewSetBoundsOrigin (HIViewRef inView, float inX, float inY);
// Wraps call to function 'HIViewAdvanceFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewAdvanceFocus(ewg_param_inRootForFocus, ewg_param_inModifiers) HIViewAdvanceFocus ((HIViewRef)ewg_param_inRootForFocus, (EventModifiers)ewg_param_inModifiers)

OSStatus  ewg_function_HIViewAdvanceFocus (HIViewRef inRootForFocus, EventModifiers inModifiers);
// Wraps call to function 'HIViewGetFocusPart' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetFocusPart(ewg_param_inView, ewg_param_outFocusPart) HIViewGetFocusPart ((HIViewRef)ewg_param_inView, (HIViewPartCode*)ewg_param_outFocusPart)

OSStatus  ewg_function_HIViewGetFocusPart (HIViewRef inView, HIViewPartCode *outFocusPart);
// Wraps call to function 'HIViewSubtreeContainsFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSubtreeContainsFocus(ewg_param_inSubtreeStart) HIViewSubtreeContainsFocus ((HIViewRef)ewg_param_inSubtreeStart)

Boolean  ewg_function_HIViewSubtreeContainsFocus (HIViewRef inSubtreeStart);
// Wraps call to function 'HIViewSetNextFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetNextFocus(ewg_param_inView, ewg_param_inNextFocus) HIViewSetNextFocus ((HIViewRef)ewg_param_inView, (HIViewRef)ewg_param_inNextFocus)

OSStatus  ewg_function_HIViewSetNextFocus (HIViewRef inView, HIViewRef inNextFocus);
// Wraps call to function 'HIViewSetFirstSubViewFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetFirstSubViewFocus(ewg_param_inParent, ewg_param_inSubView) HIViewSetFirstSubViewFocus ((HIViewRef)ewg_param_inParent, (HIViewRef)ewg_param_inSubView)

OSStatus  ewg_function_HIViewSetFirstSubViewFocus (HIViewRef inParent, HIViewRef inSubView);
// Wraps call to function 'HIViewGetLayoutInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetLayoutInfo(ewg_param_inView, ewg_param_outLayoutInfo) HIViewGetLayoutInfo ((HIViewRef)ewg_param_inView, (HILayoutInfo*)ewg_param_outLayoutInfo)

OSStatus  ewg_function_HIViewGetLayoutInfo (HIViewRef inView, HILayoutInfo *outLayoutInfo);
// Wraps call to function 'HIViewSetLayoutInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSetLayoutInfo(ewg_param_inView, ewg_param_inLayoutInfo) HIViewSetLayoutInfo ((HIViewRef)ewg_param_inView, (HILayoutInfo const*)ewg_param_inLayoutInfo)

OSStatus  ewg_function_HIViewSetLayoutInfo (HIViewRef inView, HILayoutInfo const *inLayoutInfo);
// Wraps call to function 'HIViewSuspendLayout' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewSuspendLayout(ewg_param_inView) HIViewSuspendLayout ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewSuspendLayout (HIViewRef inView);
// Wraps call to function 'HIViewResumeLayout' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewResumeLayout(ewg_param_inView) HIViewResumeLayout ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewResumeLayout (HIViewRef inView);
// Wraps call to function 'HIViewIsLayoutActive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsLayoutActive(ewg_param_inView) HIViewIsLayoutActive ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsLayoutActive (HIViewRef inView);
// Wraps call to function 'HIViewIsLayoutLatentlyActive' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewIsLayoutLatentlyActive(ewg_param_inView) HIViewIsLayoutLatentlyActive ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIViewIsLayoutLatentlyActive (HIViewRef inView);
// Wraps call to function 'HIViewApplyLayout' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewApplyLayout(ewg_param_inView) HIViewApplyLayout ((HIViewRef)ewg_param_inView)

OSStatus  ewg_function_HIViewApplyLayout (HIViewRef inView);
// Wraps call to function 'HIViewGetWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetWindow(ewg_param_inView) HIViewGetWindow ((HIViewRef)ewg_param_inView)

WindowRef  ewg_function_HIViewGetWindow (HIViewRef inView);
// Wraps call to function 'HIViewFindByID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewFindByID(ewg_param_inStartView, ewg_param_inID, ewg_param_outControl) HIViewFindByID ((HIViewRef)ewg_param_inStartView, *(HIViewID*)ewg_param_inID, (HIViewRef*)ewg_param_outControl)

OSStatus  ewg_function_HIViewFindByID (HIViewRef inStartView, HIViewID *inID, HIViewRef *outControl);
// Wraps call to function 'HIViewGetAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetAttributes(ewg_param_inView, ewg_param_outAttrs) HIViewGetAttributes ((HIViewRef)ewg_param_inView, (OptionBits*)ewg_param_outAttrs)

OSStatus  ewg_function_HIViewGetAttributes (HIViewRef inView, OptionBits *outAttrs);
// Wraps call to function 'HIViewChangeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewChangeAttributes(ewg_param_inView, ewg_param_inAttrsToSet, ewg_param_inAttrsToClear) HIViewChangeAttributes ((HIViewRef)ewg_param_inView, (OptionBits)ewg_param_inAttrsToSet, (OptionBits)ewg_param_inAttrsToClear)

OSStatus  ewg_function_HIViewChangeAttributes (HIViewRef inView, OptionBits inAttrsToSet, OptionBits inAttrsToClear);
// Wraps call to function 'HIViewCreateOffscreenImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewCreateOffscreenImage(ewg_param_inView, ewg_param_inOptions, ewg_param_outFrame, ewg_param_outImage) HIViewCreateOffscreenImage ((HIViewRef)ewg_param_inView, (OptionBits)ewg_param_inOptions, (HIRect*)ewg_param_outFrame, (CGImageRef*)ewg_param_outImage)

OSStatus  ewg_function_HIViewCreateOffscreenImage (HIViewRef inView, OptionBits inOptions, HIRect *outFrame, CGImageRef *outImage);
// Wraps call to function 'HIViewDrawCGImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewDrawCGImage(ewg_param_inContext, ewg_param_inBounds, ewg_param_inImage) HIViewDrawCGImage ((CGContextRef)ewg_param_inContext, (HIRect const*)ewg_param_inBounds, (CGImageRef)ewg_param_inImage)

OSStatus  ewg_function_HIViewDrawCGImage (CGContextRef inContext, HIRect const *inBounds, CGImageRef inImage);
// Wraps call to function 'HIViewGetFeatures' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetFeatures(ewg_param_inView, ewg_param_outFeatures) HIViewGetFeatures ((HIViewRef)ewg_param_inView, (HIViewFeatures*)ewg_param_outFeatures)

OSStatus  ewg_function_HIViewGetFeatures (HIViewRef inView, HIViewFeatures *outFeatures);
// Wraps call to function 'HIViewChangeFeatures' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewChangeFeatures(ewg_param_inView, ewg_param_inFeaturesToSet, ewg_param_inFeaturesToClear) HIViewChangeFeatures ((HIViewRef)ewg_param_inView, (HIViewFeatures)ewg_param_inFeaturesToSet, (HIViewFeatures)ewg_param_inFeaturesToClear)

OSStatus  ewg_function_HIViewChangeFeatures (HIViewRef inView, HIViewFeatures inFeaturesToSet, HIViewFeatures inFeaturesToClear);
// Wraps call to function 'HICreateTransformedCGImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HICreateTransformedCGImage(ewg_param_inImage, ewg_param_inTransform, ewg_param_outImage) HICreateTransformedCGImage ((CGImageRef)ewg_param_inImage, (OptionBits)ewg_param_inTransform, (CGImageRef*)ewg_param_outImage)

OSStatus  ewg_function_HICreateTransformedCGImage (CGImageRef inImage, OptionBits inTransform, CGImageRef *outImage);
// Wraps call to function 'HIViewGetEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIViewGetEventTarget(ewg_param_inView) HIViewGetEventTarget ((HIViewRef)ewg_param_inView)

EventTargetRef  ewg_function_HIViewGetEventTarget (HIViewRef inView);
// Wraps call to function 'HIGrowBoxViewSetTransparent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIGrowBoxViewSetTransparent(ewg_param_inGrowBoxView, ewg_param_inTransparent) HIGrowBoxViewSetTransparent ((HIViewRef)ewg_param_inGrowBoxView, (Boolean)ewg_param_inTransparent)

OSStatus  ewg_function_HIGrowBoxViewSetTransparent (HIViewRef inGrowBoxView, Boolean inTransparent);
// Wraps call to function 'HIGrowBoxViewIsTransparent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIGrowBoxViewIsTransparent(ewg_param_inGrowBoxView) HIGrowBoxViewIsTransparent ((HIViewRef)ewg_param_inGrowBoxView)

Boolean  ewg_function_HIGrowBoxViewIsTransparent (HIViewRef inGrowBoxView);
// Wraps call to function 'HIScrollViewCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIScrollViewCreate(ewg_param_inOptions, ewg_param_outView) HIScrollViewCreate ((OptionBits)ewg_param_inOptions, (HIViewRef*)ewg_param_outView)

OSStatus  ewg_function_HIScrollViewCreate (OptionBits inOptions, HIViewRef *outView);
// Wraps call to function 'HIScrollViewSetScrollBarAutoHide' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIScrollViewSetScrollBarAutoHide(ewg_param_inView, ewg_param_inAutoHide) HIScrollViewSetScrollBarAutoHide ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inAutoHide)

OSStatus  ewg_function_HIScrollViewSetScrollBarAutoHide (HIViewRef inView, Boolean inAutoHide);
// Wraps call to function 'HIScrollViewGetScrollBarAutoHide' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIScrollViewGetScrollBarAutoHide(ewg_param_inView) HIScrollViewGetScrollBarAutoHide ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIScrollViewGetScrollBarAutoHide (HIViewRef inView);
// Wraps call to function 'HIScrollViewNavigate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIScrollViewNavigate(ewg_param_inView, ewg_param_inAction) HIScrollViewNavigate ((HIViewRef)ewg_param_inView, (HIScrollViewAction)ewg_param_inAction)

OSStatus  ewg_function_HIScrollViewNavigate (HIViewRef inView, HIScrollViewAction inAction);
// Wraps call to function 'HIScrollViewCanNavigate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIScrollViewCanNavigate(ewg_param_inView, ewg_param_inAction) HIScrollViewCanNavigate ((HIViewRef)ewg_param_inView, (HIScrollViewAction)ewg_param_inAction)

Boolean  ewg_function_HIScrollViewCanNavigate (HIViewRef inView, HIScrollViewAction inAction);
// Wraps call to function 'HIImageViewCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewCreate(ewg_param_inImage, ewg_param_outControl) HIImageViewCreate ((CGImageRef)ewg_param_inImage, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_HIImageViewCreate (CGImageRef inImage, ControlRef *outControl);
// Wraps call to function 'HIImageViewSetOpaque' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewSetOpaque(ewg_param_inView, ewg_param_inOpaque) HIImageViewSetOpaque ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inOpaque)

OSStatus  ewg_function_HIImageViewSetOpaque (HIViewRef inView, Boolean inOpaque);
// Wraps call to function 'HIImageViewIsOpaque' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewIsOpaque(ewg_param_inView) HIImageViewIsOpaque ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIImageViewIsOpaque (HIViewRef inView);
// Wraps call to function 'HIImageViewSetAlpha' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewSetAlpha(ewg_param_inView, ewg_param_inAlpha) HIImageViewSetAlpha ((HIViewRef)ewg_param_inView, (float)ewg_param_inAlpha)

OSStatus  ewg_function_HIImageViewSetAlpha (HIViewRef inView, float inAlpha);
// Wraps call to function 'HIImageViewGetAlpha' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewGetAlpha(ewg_param_inView) HIImageViewGetAlpha ((HIViewRef)ewg_param_inView)

float  ewg_function_HIImageViewGetAlpha (HIViewRef inView);
// Wraps call to function 'HIImageViewSetScaleToFit' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewSetScaleToFit(ewg_param_inView, ewg_param_inScaleToFit) HIImageViewSetScaleToFit ((HIViewRef)ewg_param_inView, (Boolean)ewg_param_inScaleToFit)

OSStatus  ewg_function_HIImageViewSetScaleToFit (HIViewRef inView, Boolean inScaleToFit);
// Wraps call to function 'HIImageViewGetScaleToFit' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewGetScaleToFit(ewg_param_inView) HIImageViewGetScaleToFit ((HIViewRef)ewg_param_inView)

Boolean  ewg_function_HIImageViewGetScaleToFit (HIViewRef inView);
// Wraps call to function 'HIImageViewSetImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewSetImage(ewg_param_inView, ewg_param_inImage) HIImageViewSetImage ((HIViewRef)ewg_param_inView, (CGImageRef)ewg_param_inImage)

OSStatus  ewg_function_HIImageViewSetImage (HIViewRef inView, CGImageRef inImage);
// Wraps call to function 'HIImageViewCopyImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIImageViewCopyImage(ewg_param_inView) HIImageViewCopyImage ((HIViewRef)ewg_param_inView)

CGImageRef  ewg_function_HIImageViewCopyImage (HIViewRef inView);
// Wraps call to function 'HIComboBoxCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxCreate(ewg_param_boundsRect, ewg_param_text, ewg_param_style, ewg_param_list, ewg_param_inAttributes, ewg_param_outComboBox) HIComboBoxCreate ((HIRect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_text, (ControlFontStyleRec const*)ewg_param_style, (CFArrayRef)ewg_param_list, (OptionBits)ewg_param_inAttributes, (HIViewRef*)ewg_param_outComboBox)

OSStatus  ewg_function_HIComboBoxCreate (HIRect const *boundsRect, CFStringRef text, ControlFontStyleRec const *style, CFArrayRef list, OptionBits inAttributes, HIViewRef *outComboBox);
// Wraps call to function 'HIComboBoxGetItemCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxGetItemCount(ewg_param_inComboBox) HIComboBoxGetItemCount ((HIViewRef)ewg_param_inComboBox)

ItemCount  ewg_function_HIComboBoxGetItemCount (HIViewRef inComboBox);
// Wraps call to function 'HIComboBoxInsertTextItemAtIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxInsertTextItemAtIndex(ewg_param_inComboBox, ewg_param_inIndex, ewg_param_inText) HIComboBoxInsertTextItemAtIndex ((HIViewRef)ewg_param_inComboBox, (CFIndex)ewg_param_inIndex, (CFStringRef)ewg_param_inText)

OSStatus  ewg_function_HIComboBoxInsertTextItemAtIndex (HIViewRef inComboBox, CFIndex inIndex, CFStringRef inText);
// Wraps call to function 'HIComboBoxAppendTextItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxAppendTextItem(ewg_param_inComboBox, ewg_param_inText, ewg_param_outIndex) HIComboBoxAppendTextItem ((HIViewRef)ewg_param_inComboBox, (CFStringRef)ewg_param_inText, (CFIndex*)ewg_param_outIndex)

OSStatus  ewg_function_HIComboBoxAppendTextItem (HIViewRef inComboBox, CFStringRef inText, CFIndex *outIndex);
// Wraps call to function 'HIComboBoxCopyTextItemAtIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxCopyTextItemAtIndex(ewg_param_inComboBox, ewg_param_inIndex, ewg_param_outString) HIComboBoxCopyTextItemAtIndex ((HIViewRef)ewg_param_inComboBox, (CFIndex)ewg_param_inIndex, (CFStringRef*)ewg_param_outString)

OSStatus  ewg_function_HIComboBoxCopyTextItemAtIndex (HIViewRef inComboBox, CFIndex inIndex, CFStringRef *outString);
// Wraps call to function 'HIComboBoxRemoveItemAtIndex' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxRemoveItemAtIndex(ewg_param_inComboBox, ewg_param_inIndex) HIComboBoxRemoveItemAtIndex ((HIViewRef)ewg_param_inComboBox, (CFIndex)ewg_param_inIndex)

OSStatus  ewg_function_HIComboBoxRemoveItemAtIndex (HIViewRef inComboBox, CFIndex inIndex);
// Wraps call to function 'HIComboBoxChangeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxChangeAttributes(ewg_param_inComboBox, ewg_param_inAttributesToSet, ewg_param_inAttributesToClear) HIComboBoxChangeAttributes ((HIViewRef)ewg_param_inComboBox, (OptionBits)ewg_param_inAttributesToSet, (OptionBits)ewg_param_inAttributesToClear)

OSStatus  ewg_function_HIComboBoxChangeAttributes (HIViewRef inComboBox, OptionBits inAttributesToSet, OptionBits inAttributesToClear);
// Wraps call to function 'HIComboBoxGetAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxGetAttributes(ewg_param_inComboBox, ewg_param_outAttributes) HIComboBoxGetAttributes ((HIViewRef)ewg_param_inComboBox, (OptionBits*)ewg_param_outAttributes)

OSStatus  ewg_function_HIComboBoxGetAttributes (HIViewRef inComboBox, OptionBits *outAttributes);
// Wraps call to function 'HIComboBoxIsListVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxIsListVisible(ewg_param_inComboBox) HIComboBoxIsListVisible ((HIViewRef)ewg_param_inComboBox)

Boolean  ewg_function_HIComboBoxIsListVisible (HIViewRef inComboBox);
// Wraps call to function 'HIComboBoxSetListVisible' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIComboBoxSetListVisible(ewg_param_inComboBox, ewg_param_inVisible) HIComboBoxSetListVisible ((HIViewRef)ewg_param_inComboBox, (Boolean)ewg_param_inVisible)

OSStatus  ewg_function_HIComboBoxSetListVisible (HIViewRef inComboBox, Boolean inVisible);
// Wraps call to function 'HISearchFieldCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldCreate(ewg_param_inBounds, ewg_param_inAttributes, ewg_param_inSearchMenu, ewg_param_inDescriptiveText, ewg_param_outRef) HISearchFieldCreate ((HIRect const*)ewg_param_inBounds, (OptionBits)ewg_param_inAttributes, (MenuRef)ewg_param_inSearchMenu, (CFStringRef)ewg_param_inDescriptiveText, (HIViewRef*)ewg_param_outRef)

OSStatus  ewg_function_HISearchFieldCreate (HIRect const *inBounds, OptionBits inAttributes, MenuRef inSearchMenu, CFStringRef inDescriptiveText, HIViewRef *outRef);
// Wraps call to function 'HISearchFieldSetSearchMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldSetSearchMenu(ewg_param_inSearchField, ewg_param_inSearchMenu) HISearchFieldSetSearchMenu ((HIViewRef)ewg_param_inSearchField, (MenuRef)ewg_param_inSearchMenu)

OSStatus  ewg_function_HISearchFieldSetSearchMenu (HIViewRef inSearchField, MenuRef inSearchMenu);
// Wraps call to function 'HISearchFieldGetSearchMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldGetSearchMenu(ewg_param_inSearchField, ewg_param_outSearchMenu) HISearchFieldGetSearchMenu ((HIViewRef)ewg_param_inSearchField, (MenuRef*)ewg_param_outSearchMenu)

OSStatus  ewg_function_HISearchFieldGetSearchMenu (HIViewRef inSearchField, MenuRef *outSearchMenu);
// Wraps call to function 'HISearchFieldChangeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldChangeAttributes(ewg_param_inSearchField, ewg_param_inAttributesToSet, ewg_param_inAttributesToClear) HISearchFieldChangeAttributes ((HIViewRef)ewg_param_inSearchField, (OptionBits)ewg_param_inAttributesToSet, (OptionBits)ewg_param_inAttributesToClear)

OSStatus  ewg_function_HISearchFieldChangeAttributes (HIViewRef inSearchField, OptionBits inAttributesToSet, OptionBits inAttributesToClear);
// Wraps call to function 'HISearchFieldGetAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldGetAttributes(ewg_param_inSearchField, ewg_param_outAttributes) HISearchFieldGetAttributes ((HIViewRef)ewg_param_inSearchField, (OptionBits*)ewg_param_outAttributes)

OSStatus  ewg_function_HISearchFieldGetAttributes (HIViewRef inSearchField, OptionBits *outAttributes);
// Wraps call to function 'HISearchFieldSetDescriptiveText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldSetDescriptiveText(ewg_param_inSearchField, ewg_param_inDescription) HISearchFieldSetDescriptiveText ((HIViewRef)ewg_param_inSearchField, (CFStringRef)ewg_param_inDescription)

OSStatus  ewg_function_HISearchFieldSetDescriptiveText (HIViewRef inSearchField, CFStringRef inDescription);
// Wraps call to function 'HISearchFieldCopyDescriptiveText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISearchFieldCopyDescriptiveText(ewg_param_inSearchField, ewg_param_outDescription) HISearchFieldCopyDescriptiveText ((HIViewRef)ewg_param_inSearchField, (CFStringRef*)ewg_param_outDescription)

OSStatus  ewg_function_HISearchFieldCopyDescriptiveText (HIViewRef inSearchField, CFStringRef *outDescription);
// Wraps call to function 'HIMenuViewGetMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIMenuViewGetMenu(ewg_param_inView) HIMenuViewGetMenu ((HIViewRef)ewg_param_inView)

MenuRef  ewg_function_HIMenuViewGetMenu (HIViewRef inView);
// Wraps call to function 'HIMenuGetContentView' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HIMenuGetContentView(ewg_param_inMenu, ewg_param_inMenuType, ewg_param_outView) HIMenuGetContentView ((MenuRef)ewg_param_inMenu, (ThemeMenuType)ewg_param_inMenuType, (HIViewRef*)ewg_param_outView)

OSStatus  ewg_function_HIMenuGetContentView (MenuRef inMenu, ThemeMenuType inMenuType, HIViewRef *outView);
// Wraps call to function 'HISegmentedViewCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewCreate(ewg_param_inBounds, ewg_param_outRef) HISegmentedViewCreate ((HIRect const*)ewg_param_inBounds, (HIViewRef*)ewg_param_outRef)

OSStatus  ewg_function_HISegmentedViewCreate (HIRect const *inBounds, HIViewRef *outRef);
// Wraps call to function 'HISegmentedViewSetSegmentCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentCount(ewg_param_inSegmentedView, ewg_param_inSegmentCount) HISegmentedViewSetSegmentCount ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentCount)

OSStatus  ewg_function_HISegmentedViewSetSegmentCount (HIViewRef inSegmentedView, UInt32 inSegmentCount);
// Wraps call to function 'HISegmentedViewGetSegmentCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentCount(ewg_param_inSegmentedView) HISegmentedViewGetSegmentCount ((HIViewRef)ewg_param_inSegmentedView)

UInt32  ewg_function_HISegmentedViewGetSegmentCount (HIViewRef inSegmentedView);
// Wraps call to function 'HISegmentedViewSetSegmentBehavior' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentBehavior(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inBehavior) HISegmentedViewSetSegmentBehavior ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (HISegmentBehavior)ewg_param_inBehavior)

OSStatus  ewg_function_HISegmentedViewSetSegmentBehavior (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, HISegmentBehavior inBehavior);
// Wraps call to function 'HISegmentedViewGetSegmentBehavior' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentBehavior(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewGetSegmentBehavior ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

HISegmentBehavior  ewg_function_HISegmentedViewGetSegmentBehavior (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewChangeSegmentAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewChangeSegmentAttributes(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inAttributesToSet, ewg_param_inAttributesToClear) HISegmentedViewChangeSegmentAttributes ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (OptionBits)ewg_param_inAttributesToSet, (OptionBits)ewg_param_inAttributesToClear)

OSStatus  ewg_function_HISegmentedViewChangeSegmentAttributes (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, OptionBits inAttributesToSet, OptionBits inAttributesToClear);
// Wraps call to function 'HISegmentedViewGetSegmentAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentAttributes(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewGetSegmentAttributes ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

OptionBits  ewg_function_HISegmentedViewGetSegmentAttributes (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewSetSegmentValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentValue(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inValue) HISegmentedViewSetSegmentValue ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (SInt32)ewg_param_inValue)

OSStatus  ewg_function_HISegmentedViewSetSegmentValue (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, SInt32 inValue);
// Wraps call to function 'HISegmentedViewGetSegmentValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentValue(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewGetSegmentValue ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

SInt32  ewg_function_HISegmentedViewGetSegmentValue (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewSetSegmentEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentEnabled(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inEnabled) HISegmentedViewSetSegmentEnabled ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (Boolean)ewg_param_inEnabled)

OSStatus  ewg_function_HISegmentedViewSetSegmentEnabled (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, Boolean inEnabled);
// Wraps call to function 'HISegmentedViewIsSegmentEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewIsSegmentEnabled(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewIsSegmentEnabled ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

Boolean  ewg_function_HISegmentedViewIsSegmentEnabled (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewSetSegmentCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentCommand(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inCommand) HISegmentedViewSetSegmentCommand ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (UInt32)ewg_param_inCommand)

OSStatus  ewg_function_HISegmentedViewSetSegmentCommand (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, UInt32 inCommand);
// Wraps call to function 'HISegmentedViewGetSegmentCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentCommand(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewGetSegmentCommand ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

UInt32  ewg_function_HISegmentedViewGetSegmentCommand (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewSetSegmentLabel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentLabel(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inLabel) HISegmentedViewSetSegmentLabel ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (CFStringRef)ewg_param_inLabel)

OSStatus  ewg_function_HISegmentedViewSetSegmentLabel (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, CFStringRef inLabel);
// Wraps call to function 'HISegmentedViewCopySegmentLabel' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewCopySegmentLabel(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_outLabel) HISegmentedViewCopySegmentLabel ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (CFStringRef*)ewg_param_outLabel)

OSStatus  ewg_function_HISegmentedViewCopySegmentLabel (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, CFStringRef *outLabel);
// Wraps call to function 'HISegmentedViewSetSegmentContentWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentContentWidth(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inAutoCalculateWidth, ewg_param_inWidth) HISegmentedViewSetSegmentContentWidth ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (Boolean)ewg_param_inAutoCalculateWidth, (float)ewg_param_inWidth)

OSStatus  ewg_function_HISegmentedViewSetSegmentContentWidth (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, Boolean inAutoCalculateWidth, float inWidth);
// Wraps call to function 'HISegmentedViewGetSegmentContentWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentContentWidth(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_outAutoCalculated) HISegmentedViewGetSegmentContentWidth ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (Boolean*)ewg_param_outAutoCalculated)

float  ewg_function_HISegmentedViewGetSegmentContentWidth (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, Boolean *outAutoCalculated);
// Wraps call to function 'HISegmentedViewSetSegmentImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewSetSegmentImage(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_inImage) HISegmentedViewSetSegmentImage ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (HIViewImageContentInfo const*)ewg_param_inImage)

OSStatus  ewg_function_HISegmentedViewSetSegmentImage (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, HIViewImageContentInfo const *inImage);
// Wraps call to function 'HISegmentedViewGetSegmentImageContentType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewGetSegmentImageContentType(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased) HISegmentedViewGetSegmentImageContentType ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased)

HIViewImageContentType  ewg_function_HISegmentedViewGetSegmentImageContentType (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased);
// Wraps call to function 'HISegmentedViewCopySegmentImage' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HISegmentedViewCopySegmentImage(ewg_param_inSegmentedView, ewg_param_inSegmentIndexOneBased, ewg_param_ioImage) HISegmentedViewCopySegmentImage ((HIViewRef)ewg_param_inSegmentedView, (UInt32)ewg_param_inSegmentIndexOneBased, (HIViewImageContentInfo*)ewg_param_ioImage)

OSStatus  ewg_function_HISegmentedViewCopySegmentImage (HIViewRef inSegmentedView, UInt32 inSegmentIndexOneBased, HIViewImageContentInfo *ioImage);
// Wraps call to function 'NewTXNFindUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewTXNFindUPP(ewg_param_userRoutine) NewTXNFindUPP ((TXNFindProcPtr)ewg_param_userRoutine)

TXNFindUPP  ewg_function_NewTXNFindUPP (TXNFindProcPtr userRoutine);
// Wraps call to function 'NewTXNActionNameMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewTXNActionNameMapperUPP(ewg_param_userRoutine) NewTXNActionNameMapperUPP ((TXNActionNameMapperProcPtr)ewg_param_userRoutine)

TXNActionNameMapperUPP  ewg_function_NewTXNActionNameMapperUPP (TXNActionNameMapperProcPtr userRoutine);
// Wraps call to function 'NewTXNContextualMenuSetupUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewTXNContextualMenuSetupUPP(ewg_param_userRoutine) NewTXNContextualMenuSetupUPP ((TXNContextualMenuSetupProcPtr)ewg_param_userRoutine)

TXNContextualMenuSetupUPP  ewg_function_NewTXNContextualMenuSetupUPP (TXNContextualMenuSetupProcPtr userRoutine);
// Wraps call to function 'NewTXNScrollInfoUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewTXNScrollInfoUPP(ewg_param_userRoutine) NewTXNScrollInfoUPP ((TXNScrollInfoProcPtr)ewg_param_userRoutine)

TXNScrollInfoUPP  ewg_function_NewTXNScrollInfoUPP (TXNScrollInfoProcPtr userRoutine);
// Wraps call to function 'DisposeTXNFindUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeTXNFindUPP(ewg_param_userUPP) DisposeTXNFindUPP ((TXNFindUPP)ewg_param_userUPP)

void  ewg_function_DisposeTXNFindUPP (TXNFindUPP userUPP);
// Wraps call to function 'DisposeTXNActionNameMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeTXNActionNameMapperUPP(ewg_param_userUPP) DisposeTXNActionNameMapperUPP ((TXNActionNameMapperUPP)ewg_param_userUPP)

void  ewg_function_DisposeTXNActionNameMapperUPP (TXNActionNameMapperUPP userUPP);
// Wraps call to function 'DisposeTXNContextualMenuSetupUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeTXNContextualMenuSetupUPP(ewg_param_userUPP) DisposeTXNContextualMenuSetupUPP ((TXNContextualMenuSetupUPP)ewg_param_userUPP)

void  ewg_function_DisposeTXNContextualMenuSetupUPP (TXNContextualMenuSetupUPP userUPP);
// Wraps call to function 'DisposeTXNScrollInfoUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeTXNScrollInfoUPP(ewg_param_userUPP) DisposeTXNScrollInfoUPP ((TXNScrollInfoUPP)ewg_param_userUPP)

void  ewg_function_DisposeTXNScrollInfoUPP (TXNScrollInfoUPP userUPP);
// Wraps call to function 'InvokeTXNFindUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeTXNFindUPP(ewg_param_matchData, ewg_param_iDataType, ewg_param_iMatchOptions, ewg_param_iSearchTextPtr, ewg_param_encoding, ewg_param_absStartOffset, ewg_param_searchTextLength, ewg_param_oStartMatch, ewg_param_oEndMatch, ewg_param_ofound, ewg_param_refCon, ewg_param_userUPP) InvokeTXNFindUPP ((TXNMatchTextRecord const*)ewg_param_matchData, (TXNDataType)ewg_param_iDataType, (TXNMatchOptions)ewg_param_iMatchOptions, (void const*)ewg_param_iSearchTextPtr, (TextEncoding)ewg_param_encoding, (TXNOffset)ewg_param_absStartOffset, (ByteCount)ewg_param_searchTextLength, (TXNOffset*)ewg_param_oStartMatch, (TXNOffset*)ewg_param_oEndMatch, (Boolean*)ewg_param_ofound, (UInt32)ewg_param_refCon, (TXNFindUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeTXNFindUPP (TXNMatchTextRecord const *matchData, TXNDataType iDataType, TXNMatchOptions iMatchOptions, void const *iSearchTextPtr, TextEncoding encoding, TXNOffset absStartOffset, ByteCount searchTextLength, TXNOffset *oStartMatch, TXNOffset *oEndMatch, Boolean *ofound, UInt32 refCon, TXNFindUPP userUPP);
// Wraps call to function 'InvokeTXNActionNameMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeTXNActionNameMapperUPP(ewg_param_actionName, ewg_param_commandID, ewg_param_inUserData, ewg_param_userUPP) InvokeTXNActionNameMapperUPP ((CFStringRef)ewg_param_actionName, (UInt32)ewg_param_commandID, (void*)ewg_param_inUserData, (TXNActionNameMapperUPP)ewg_param_userUPP)

CFStringRef  ewg_function_InvokeTXNActionNameMapperUPP (CFStringRef actionName, UInt32 commandID, void *inUserData, TXNActionNameMapperUPP userUPP);
// Wraps call to function 'InvokeTXNContextualMenuSetupUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeTXNContextualMenuSetupUPP(ewg_param_iContextualMenu, ewg_param_object, ewg_param_inUserData, ewg_param_userUPP) InvokeTXNContextualMenuSetupUPP ((MenuRef)ewg_param_iContextualMenu, (TXNObject)ewg_param_object, (void*)ewg_param_inUserData, (TXNContextualMenuSetupUPP)ewg_param_userUPP)

void  ewg_function_InvokeTXNContextualMenuSetupUPP (MenuRef iContextualMenu, TXNObject object, void *inUserData, TXNContextualMenuSetupUPP userUPP);
// Wraps call to function 'InvokeTXNScrollInfoUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeTXNScrollInfoUPP(ewg_param_iValue, ewg_param_iMaximumValue, ewg_param_iScrollBarOrientation, ewg_param_iRefCon, ewg_param_userUPP) InvokeTXNScrollInfoUPP ((SInt32)ewg_param_iValue, (SInt32)ewg_param_iMaximumValue, (TXNScrollBarOrientation)ewg_param_iScrollBarOrientation, (SInt32)ewg_param_iRefCon, (TXNScrollInfoUPP)ewg_param_userUPP)

void  ewg_function_InvokeTXNScrollInfoUPP (SInt32 iValue, SInt32 iMaximumValue, TXNScrollBarOrientation iScrollBarOrientation, SInt32 iRefCon, TXNScrollInfoUPP userUPP);
// Wraps call to function 'TXNCreateObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCreateObject(ewg_param_iFrameRect, ewg_param_iFrameOptions, ewg_param_oTXNObject) TXNCreateObject ((HIRect const*)ewg_param_iFrameRect, (TXNFrameOptions)ewg_param_iFrameOptions, (TXNObject*)ewg_param_oTXNObject)

OSStatus  ewg_function_TXNCreateObject (HIRect const *iFrameRect, TXNFrameOptions iFrameOptions, TXNObject *oTXNObject);
// Wraps call to function 'TXNDeleteObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDeleteObject(ewg_param_iTXNObject) TXNDeleteObject ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNDeleteObject (TXNObject iTXNObject);
// Wraps call to function 'TXNInitTextension' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNInitTextension(ewg_param_iDefaultFonts, ewg_param_iCountDefaultFonts, ewg_param_iUsageFlags) TXNInitTextension (ewg_param_iDefaultFonts, (ItemCount)ewg_param_iCountDefaultFonts, (TXNInitOptions)ewg_param_iUsageFlags)

OSStatus  ewg_function_TXNInitTextension (void *iDefaultFonts, ItemCount iCountDefaultFonts, TXNInitOptions iUsageFlags);
// Wraps call to function 'TXNVersionInformation' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNVersionInformation(ewg_param_oFeatureFlags) TXNVersionInformation ((TXNFeatureBits*)ewg_param_oFeatureFlags)

TXNVersionValue  ewg_function_TXNVersionInformation (TXNFeatureBits *oFeatureFlags);
// Wraps call to function 'TXNAttachObjectToWindowRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNAttachObjectToWindowRef(ewg_param_iTXNObject, ewg_param_iWindowRef) TXNAttachObjectToWindowRef ((TXNObject)ewg_param_iTXNObject, (WindowRef)ewg_param_iWindowRef)

OSStatus  ewg_function_TXNAttachObjectToWindowRef (TXNObject iTXNObject, WindowRef iWindowRef);
// Wraps call to function 'TXNGetWindowRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetWindowRef(ewg_param_iTXNObject) TXNGetWindowRef ((TXNObject)ewg_param_iTXNObject)

WindowRef  ewg_function_TXNGetWindowRef (TXNObject iTXNObject);
// Wraps call to function 'TXNKeyDown' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNKeyDown(ewg_param_iTXNObject, ewg_param_iEvent) TXNKeyDown ((TXNObject)ewg_param_iTXNObject, (EventRecord const*)ewg_param_iEvent)

void  ewg_function_TXNKeyDown (TXNObject iTXNObject, EventRecord const *iEvent);
// Wraps call to function 'TXNAdjustCursor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNAdjustCursor(ewg_param_iTXNObject, ewg_param_ioCursorRgn) TXNAdjustCursor ((TXNObject)ewg_param_iTXNObject, (RgnHandle)ewg_param_ioCursorRgn)

void  ewg_function_TXNAdjustCursor (TXNObject iTXNObject, RgnHandle ioCursorRgn);
// Wraps call to function 'TXNClick' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNClick(ewg_param_iTXNObject, ewg_param_iEvent) TXNClick ((TXNObject)ewg_param_iTXNObject, (EventRecord const*)ewg_param_iEvent)

void  ewg_function_TXNClick (TXNObject iTXNObject, EventRecord const *iEvent);
// Wraps call to function 'TXNSelectAll' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSelectAll(ewg_param_iTXNObject) TXNSelectAll ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNSelectAll (TXNObject iTXNObject);
// Wraps call to function 'TXNFocus' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNFocus(ewg_param_iTXNObject, ewg_param_iBecomingFocused) TXNFocus ((TXNObject)ewg_param_iTXNObject, (Boolean)ewg_param_iBecomingFocused)

void  ewg_function_TXNFocus (TXNObject iTXNObject, Boolean iBecomingFocused);
// Wraps call to function 'TXNUpdate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNUpdate(ewg_param_iTXNObject) TXNUpdate ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNUpdate (TXNObject iTXNObject);
// Wraps call to function 'TXNDrawObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDrawObject(ewg_param_iTXNObject, ewg_param_iClipRect, ewg_param_iDrawItems) TXNDrawObject ((TXNObject)ewg_param_iTXNObject, (HIRect const*)ewg_param_iClipRect, (TXNDrawItems)ewg_param_iDrawItems)

OSStatus  ewg_function_TXNDrawObject (TXNObject iTXNObject, HIRect const *iClipRect, TXNDrawItems iDrawItems);
// Wraps call to function 'TXNForceUpdate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNForceUpdate(ewg_param_iTXNObject) TXNForceUpdate ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNForceUpdate (TXNObject iTXNObject);
// Wraps call to function 'TXNGetSleepTicks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetSleepTicks(ewg_param_iTXNObject) TXNGetSleepTicks ((TXNObject)ewg_param_iTXNObject)

UInt32  ewg_function_TXNGetSleepTicks (TXNObject iTXNObject);
// Wraps call to function 'TXNIdle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNIdle(ewg_param_iTXNObject) TXNIdle ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNIdle (TXNObject iTXNObject);
// Wraps call to function 'TXNGrowWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGrowWindow(ewg_param_iTXNObject, ewg_param_iEvent) TXNGrowWindow ((TXNObject)ewg_param_iTXNObject, (EventRecord const*)ewg_param_iEvent)

void  ewg_function_TXNGrowWindow (TXNObject iTXNObject, EventRecord const *iEvent);
// Wraps call to function 'TXNZoomWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNZoomWindow(ewg_param_iTXNObject, ewg_param_iPart) TXNZoomWindow ((TXNObject)ewg_param_iTXNObject, (SInt16)ewg_param_iPart)

void  ewg_function_TXNZoomWindow (TXNObject iTXNObject, SInt16 iPart);
// Wraps call to function 'TXNBeginActionGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNBeginActionGroup(ewg_param_iTXNObject, ewg_param_iActionGroupName) TXNBeginActionGroup ((TXNObject)ewg_param_iTXNObject, (CFStringRef)ewg_param_iActionGroupName)

OSStatus  ewg_function_TXNBeginActionGroup (TXNObject iTXNObject, CFStringRef iActionGroupName);
// Wraps call to function 'TXNEndActionGroup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNEndActionGroup(ewg_param_iTXNObject) TXNEndActionGroup ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNEndActionGroup (TXNObject iTXNObject);
// Wraps call to function 'TXNCanUndoAction' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCanUndoAction(ewg_param_iTXNObject, ewg_param_oActionName) TXNCanUndoAction ((TXNObject)ewg_param_iTXNObject, (CFStringRef*)ewg_param_oActionName)

Boolean  ewg_function_TXNCanUndoAction (TXNObject iTXNObject, CFStringRef *oActionName);
// Wraps call to function 'TXNCanRedoAction' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCanRedoAction(ewg_param_iTXNObject, ewg_param_oActionName) TXNCanRedoAction ((TXNObject)ewg_param_iTXNObject, (CFStringRef*)ewg_param_oActionName)

Boolean  ewg_function_TXNCanRedoAction (TXNObject iTXNObject, CFStringRef *oActionName);
// Wraps call to function 'TXNSetActionNameMapper' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetActionNameMapper(ewg_param_iTXNObject, ewg_param_iStringForKeyProc, ewg_param_iUserData) TXNSetActionNameMapper ((TXNObject)ewg_param_iTXNObject, (TXNActionNameMapperUPP)ewg_param_iStringForKeyProc, (void const*)ewg_param_iUserData)

OSStatus  ewg_function_TXNSetActionNameMapper (TXNObject iTXNObject, TXNActionNameMapperUPP iStringForKeyProc, void const *iUserData);
// Wraps call to function 'TXNUndo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNUndo(ewg_param_iTXNObject) TXNUndo ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNUndo (TXNObject iTXNObject);
// Wraps call to function 'TXNRedo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNRedo(ewg_param_iTXNObject) TXNRedo ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNRedo (TXNObject iTXNObject);
// Wraps call to function 'TXNClearUndo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNClearUndo(ewg_param_iTXNObject) TXNClearUndo ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNClearUndo (TXNObject iTXNObject);
// Wraps call to function 'TXNCut' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCut(ewg_param_iTXNObject) TXNCut ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNCut (TXNObject iTXNObject);
// Wraps call to function 'TXNCopy' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCopy(ewg_param_iTXNObject) TXNCopy ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNCopy (TXNObject iTXNObject);
// Wraps call to function 'TXNPaste' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNPaste(ewg_param_iTXNObject) TXNPaste ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNPaste (TXNObject iTXNObject);
// Wraps call to function 'TXNClear' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNClear(ewg_param_iTXNObject) TXNClear ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNClear (TXNObject iTXNObject);
// Wraps call to function 'TXNIsScrapPastable' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNIsScrapPastable TXNIsScrapPastable ()

Boolean  ewg_function_TXNIsScrapPastable (void);
// Wraps call to function 'TXNGetSelection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetSelection(ewg_param_iTXNObject, ewg_param_oStartOffset, ewg_param_oEndOffset) TXNGetSelection ((TXNObject)ewg_param_iTXNObject, (TXNOffset*)ewg_param_oStartOffset, (TXNOffset*)ewg_param_oEndOffset)

void  ewg_function_TXNGetSelection (TXNObject iTXNObject, TXNOffset *oStartOffset, TXNOffset *oEndOffset);
// Wraps call to function 'TXNShowSelection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNShowSelection(ewg_param_iTXNObject, ewg_param_iShowEnd) TXNShowSelection ((TXNObject)ewg_param_iTXNObject, (Boolean)ewg_param_iShowEnd)

void  ewg_function_TXNShowSelection (TXNObject iTXNObject, Boolean iShowEnd);
// Wraps call to function 'TXNIsSelectionEmpty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNIsSelectionEmpty(ewg_param_iTXNObject) TXNIsSelectionEmpty ((TXNObject)ewg_param_iTXNObject)

Boolean  ewg_function_TXNIsSelectionEmpty (TXNObject iTXNObject);
// Wraps call to function 'TXNSetSelection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetSelection(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset) TXNSetSelection ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset)

OSStatus  ewg_function_TXNSetSelection (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset);
// Wraps call to function 'TXNGetContinuousTypeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetContinuousTypeAttributes(ewg_param_iTXNObject, ewg_param_oContinuousFlags, ewg_param_iCount, ewg_param_ioTypeAttributes) TXNGetContinuousTypeAttributes ((TXNObject)ewg_param_iTXNObject, (TXNContinuousFlags*)ewg_param_oContinuousFlags, (ItemCount)ewg_param_iCount, ewg_param_ioTypeAttributes)

OSStatus  ewg_function_TXNGetContinuousTypeAttributes (TXNObject iTXNObject, TXNContinuousFlags *oContinuousFlags, ItemCount iCount, void *ioTypeAttributes);
// Wraps call to function 'TXNSetTypeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetTypeAttributes(ewg_param_iTXNObject, ewg_param_iAttrCount, ewg_param_iAttributes, ewg_param_iStartOffset, ewg_param_iEndOffset) TXNSetTypeAttributes ((TXNObject)ewg_param_iTXNObject, (ItemCount)ewg_param_iAttrCount, ewg_param_iAttributes, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset)

OSStatus  ewg_function_TXNSetTypeAttributes (TXNObject iTXNObject, ItemCount iAttrCount, void *iAttributes, TXNOffset iStartOffset, TXNOffset iEndOffset);
// Wraps call to function 'TXNSetTXNObjectControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetTXNObjectControls(ewg_param_iTXNObject, ewg_param_iClearAll, ewg_param_iControlCount, ewg_param_iControlTags, ewg_param_iControlData) TXNSetTXNObjectControls ((TXNObject)ewg_param_iTXNObject, (Boolean)ewg_param_iClearAll, (ItemCount)ewg_param_iControlCount, ewg_param_iControlTags, ewg_param_iControlData)

OSStatus  ewg_function_TXNSetTXNObjectControls (TXNObject iTXNObject, Boolean iClearAll, ItemCount iControlCount, void *iControlTags, void *iControlData);
// Wraps call to function 'TXNGetTXNObjectControls' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetTXNObjectControls(ewg_param_iTXNObject, ewg_param_iControlCount, ewg_param_iControlTags, ewg_param_oControlData) TXNGetTXNObjectControls ((TXNObject)ewg_param_iTXNObject, (ItemCount)ewg_param_iControlCount, ewg_param_iControlTags, ewg_param_oControlData)

OSStatus  ewg_function_TXNGetTXNObjectControls (TXNObject iTXNObject, ItemCount iControlCount, void *iControlTags, void *oControlData);
// Wraps call to function 'TXNSetBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetBackground(ewg_param_iTXNObject, ewg_param_iBackgroundInfo) TXNSetBackground ((TXNObject)ewg_param_iTXNObject, (TXNBackground const*)ewg_param_iBackgroundInfo)

OSStatus  ewg_function_TXNSetBackground (TXNObject iTXNObject, TXNBackground const *iBackgroundInfo);
// Wraps call to function 'TXNEchoMode' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNEchoMode(ewg_param_iTXNObject, ewg_param_iEchoCharacter, ewg_param_iEncoding, ewg_param_iOn) TXNEchoMode ((TXNObject)ewg_param_iTXNObject, (UniChar)ewg_param_iEchoCharacter, (TextEncoding)ewg_param_iEncoding, (Boolean)ewg_param_iOn)

OSStatus  ewg_function_TXNEchoMode (TXNObject iTXNObject, UniChar iEchoCharacter, TextEncoding iEncoding, Boolean iOn);
// Wraps call to function 'TXNCountRunsInRange' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCountRunsInRange(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_oRunCount) TXNCountRunsInRange ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (ItemCount*)ewg_param_oRunCount)

OSStatus  ewg_function_TXNCountRunsInRange (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, ItemCount *oRunCount);
// Wraps call to function 'TXNGetIndexedRunInfoFromRange' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetIndexedRunInfoFromRange(ewg_param_iTXNObject, ewg_param_iIndex, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_oRunStartOffset, ewg_param_oRunEndOffset, ewg_param_oRunDataType, ewg_param_iTypeAttributeCount, ewg_param_ioTypeAttributes) TXNGetIndexedRunInfoFromRange ((TXNObject)ewg_param_iTXNObject, (ItemCount)ewg_param_iIndex, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (TXNOffset*)ewg_param_oRunStartOffset, (TXNOffset*)ewg_param_oRunEndOffset, (TXNDataType*)ewg_param_oRunDataType, (ItemCount)ewg_param_iTypeAttributeCount, (TXNTypeAttributes*)ewg_param_ioTypeAttributes)

OSStatus  ewg_function_TXNGetIndexedRunInfoFromRange (TXNObject iTXNObject, ItemCount iIndex, TXNOffset iStartOffset, TXNOffset iEndOffset, TXNOffset *oRunStartOffset, TXNOffset *oRunEndOffset, TXNDataType *oRunDataType, ItemCount iTypeAttributeCount, TXNTypeAttributes *ioTypeAttributes);
// Wraps call to function 'TXNDataSize' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDataSize(ewg_param_iTXNObject) TXNDataSize ((TXNObject)ewg_param_iTXNObject)

ByteCount  ewg_function_TXNDataSize (TXNObject iTXNObject);
// Wraps call to function 'TXNWriteRangeToCFURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNWriteRangeToCFURL(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_iDataOptions, ewg_param_iDocumentAttributes, ewg_param_iFileURL) TXNWriteRangeToCFURL ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (CFDictionaryRef)ewg_param_iDataOptions, (CFDictionaryRef)ewg_param_iDocumentAttributes, (CFURLRef)ewg_param_iFileURL)

OSStatus  ewg_function_TXNWriteRangeToCFURL (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, CFDictionaryRef iDataOptions, CFDictionaryRef iDocumentAttributes, CFURLRef iFileURL);
// Wraps call to function 'TXNReadFromCFURL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNReadFromCFURL(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_iDataOptions, ewg_param_iFileURL, ewg_param_oDocumentAttributes) TXNReadFromCFURL ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (CFDictionaryRef)ewg_param_iDataOptions, (CFURLRef)ewg_param_iFileURL, (CFDictionaryRef*)ewg_param_oDocumentAttributes)

OSStatus  ewg_function_TXNReadFromCFURL (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, CFDictionaryRef iDataOptions, CFURLRef iFileURL, CFDictionaryRef *oDocumentAttributes);
// Wraps call to function 'TXNCopyTypeIdentifiersForRange' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCopyTypeIdentifiersForRange(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_oTypeIdentifiersForRange) TXNCopyTypeIdentifiersForRange ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (CFArrayRef*)ewg_param_oTypeIdentifiersForRange)

OSStatus  ewg_function_TXNCopyTypeIdentifiersForRange (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, CFArrayRef *oTypeIdentifiersForRange);
// Wraps call to function 'TXNGetData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetData(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_oDataHandle) TXNGetData ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (Handle*)ewg_param_oDataHandle)

OSStatus  ewg_function_TXNGetData (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, Handle *oDataHandle);
// Wraps call to function 'TXNGetDataEncoded' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetDataEncoded(ewg_param_iTXNObject, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_oDataHandle, ewg_param_iEncoding) TXNGetDataEncoded ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset, (Handle*)ewg_param_oDataHandle, (TXNDataType)ewg_param_iEncoding)

OSStatus  ewg_function_TXNGetDataEncoded (TXNObject iTXNObject, TXNOffset iStartOffset, TXNOffset iEndOffset, Handle *oDataHandle, TXNDataType iEncoding);
// Wraps call to function 'TXNSetData' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetData(ewg_param_iTXNObject, ewg_param_iDataType, ewg_param_iDataPtr, ewg_param_iDataSize, ewg_param_iStartOffset, ewg_param_iEndOffset) TXNSetData ((TXNObject)ewg_param_iTXNObject, (TXNDataType)ewg_param_iDataType, (void const*)ewg_param_iDataPtr, (ByteCount)ewg_param_iDataSize, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset)

OSStatus  ewg_function_TXNSetData (TXNObject iTXNObject, TXNDataType iDataType, void const *iDataPtr, ByteCount iDataSize, TXNOffset iStartOffset, TXNOffset iEndOffset);
// Wraps call to function 'TXNFlattenObjectToCFDataRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNFlattenObjectToCFDataRef(ewg_param_iTXNObject, ewg_param_iTXNDataType, ewg_param_oDataRef) TXNFlattenObjectToCFDataRef ((TXNObject)ewg_param_iTXNObject, (TXNDataType)ewg_param_iTXNDataType, (CFDataRef*)ewg_param_oDataRef)

OSStatus  ewg_function_TXNFlattenObjectToCFDataRef (TXNObject iTXNObject, TXNDataType iTXNDataType, CFDataRef *oDataRef);
// Wraps call to function 'TXNRevert' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNRevert(ewg_param_iTXNObject) TXNRevert ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNRevert (TXNObject iTXNObject);
// Wraps call to function 'TXNPageSetup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNPageSetup(ewg_param_iTXNObject) TXNPageSetup ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNPageSetup (TXNObject iTXNObject);
// Wraps call to function 'TXNPrint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNPrint(ewg_param_iTXNObject) TXNPrint ((TXNObject)ewg_param_iTXNObject)

OSStatus  ewg_function_TXNPrint (TXNObject iTXNObject);
// Wraps call to function 'TXNFind' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNFind(ewg_param_iTXNObject, ewg_param_iMatchTextDataPtr, ewg_param_iDataType, ewg_param_iMatchOptions, ewg_param_iStartSearchOffset, ewg_param_iEndSearchOffset, ewg_param_iFindProc, ewg_param_iRefCon, ewg_param_oStartMatchOffset, ewg_param_oEndMatchOffset) TXNFind ((TXNObject)ewg_param_iTXNObject, (TXNMatchTextRecord const*)ewg_param_iMatchTextDataPtr, (TXNDataType)ewg_param_iDataType, (TXNMatchOptions)ewg_param_iMatchOptions, (TXNOffset)ewg_param_iStartSearchOffset, (TXNOffset)ewg_param_iEndSearchOffset, (TXNFindUPP)ewg_param_iFindProc, (SInt32)ewg_param_iRefCon, (TXNOffset*)ewg_param_oStartMatchOffset, (TXNOffset*)ewg_param_oEndMatchOffset)

OSStatus  ewg_function_TXNFind (TXNObject iTXNObject, TXNMatchTextRecord const *iMatchTextDataPtr, TXNDataType iDataType, TXNMatchOptions iMatchOptions, TXNOffset iStartSearchOffset, TXNOffset iEndSearchOffset, TXNFindUPP iFindProc, SInt32 iRefCon, TXNOffset *oStartMatchOffset, TXNOffset *oEndMatchOffset);
// Wraps call to function 'TXNSetFontDefaults' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetFontDefaults(ewg_param_iTXNObject, ewg_param_iCount, ewg_param_iFontDefaults) TXNSetFontDefaults ((TXNObject)ewg_param_iTXNObject, (ItemCount)ewg_param_iCount, ewg_param_iFontDefaults)

OSStatus  ewg_function_TXNSetFontDefaults (TXNObject iTXNObject, ItemCount iCount, void *iFontDefaults);
// Wraps call to function 'TXNGetFontDefaults' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetFontDefaults(ewg_param_iTXNObject, ewg_param_ioCount, ewg_param_oFontDefaults) TXNGetFontDefaults ((TXNObject)ewg_param_iTXNObject, (ItemCount*)ewg_param_ioCount, ewg_param_oFontDefaults)

OSStatus  ewg_function_TXNGetFontDefaults (TXNObject iTXNObject, ItemCount *ioCount, void *oFontDefaults);
// Wraps call to function 'TXNNewFontMenuObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNNewFontMenuObject(ewg_param_iFontMenuHandle, ewg_param_iMenuID, ewg_param_iStartHierMenuID, ewg_param_oTXNFontMenuObject) TXNNewFontMenuObject ((MenuRef)ewg_param_iFontMenuHandle, (SInt16)ewg_param_iMenuID, (SInt16)ewg_param_iStartHierMenuID, (TXNFontMenuObject*)ewg_param_oTXNFontMenuObject)

OSStatus  ewg_function_TXNNewFontMenuObject (MenuRef iFontMenuHandle, SInt16 iMenuID, SInt16 iStartHierMenuID, TXNFontMenuObject *oTXNFontMenuObject);
// Wraps call to function 'TXNGetFontMenuHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetFontMenuHandle(ewg_param_iTXNFontMenuObject, ewg_param_oFontMenuHandle) TXNGetFontMenuHandle ((TXNFontMenuObject)ewg_param_iTXNFontMenuObject, (MenuRef*)ewg_param_oFontMenuHandle)

OSStatus  ewg_function_TXNGetFontMenuHandle (TXNFontMenuObject iTXNFontMenuObject, MenuRef *oFontMenuHandle);
// Wraps call to function 'TXNDisposeFontMenuObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDisposeFontMenuObject(ewg_param_iTXNFontMenuObject) TXNDisposeFontMenuObject ((TXNFontMenuObject)ewg_param_iTXNFontMenuObject)

OSStatus  ewg_function_TXNDisposeFontMenuObject (TXNFontMenuObject iTXNFontMenuObject);
// Wraps call to function 'TXNDoFontMenuSelection' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDoFontMenuSelection(ewg_param_iTXNObject, ewg_param_iTXNFontMenuObject, ewg_param_iMenuID, ewg_param_iMenuItem) TXNDoFontMenuSelection ((TXNObject)ewg_param_iTXNObject, (TXNFontMenuObject)ewg_param_iTXNFontMenuObject, (SInt16)ewg_param_iMenuID, (SInt16)ewg_param_iMenuItem)

OSStatus  ewg_function_TXNDoFontMenuSelection (TXNObject iTXNObject, TXNFontMenuObject iTXNFontMenuObject, SInt16 iMenuID, SInt16 iMenuItem);
// Wraps call to function 'TXNPrepareFontMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNPrepareFontMenu(ewg_param_iTXNObject, ewg_param_iTXNFontMenuObject) TXNPrepareFontMenu ((TXNObject)ewg_param_iTXNObject, (TXNFontMenuObject)ewg_param_iTXNFontMenuObject)

OSStatus  ewg_function_TXNPrepareFontMenu (TXNObject iTXNObject, TXNFontMenuObject iTXNFontMenuObject);
// Wraps call to function 'TXNDrawUnicodeTextBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDrawUnicodeTextBox(ewg_param_iText, ewg_param_iLen, ewg_param_ioBox, ewg_param_iStyle, ewg_param_iOptions) TXNDrawUnicodeTextBox (ewg_param_iText, (UniCharCount)ewg_param_iLen, (Rect*)ewg_param_ioBox, (ATSUStyle)ewg_param_iStyle, (TXNTextBoxOptionsData const*)ewg_param_iOptions)

OSStatus  ewg_function_TXNDrawUnicodeTextBox (void *iText, UniCharCount iLen, Rect *ioBox, ATSUStyle iStyle, TXNTextBoxOptionsData const *iOptions);
// Wraps call to function 'TXNDrawCFStringTextBox' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDrawCFStringTextBox(ewg_param_iText, ewg_param_ioBox, ewg_param_iStyle, ewg_param_iOptions) TXNDrawCFStringTextBox ((CFStringRef)ewg_param_iText, (Rect*)ewg_param_ioBox, (ATSUStyle)ewg_param_iStyle, (TXNTextBoxOptionsData const*)ewg_param_iOptions)

OSStatus  ewg_function_TXNDrawCFStringTextBox (CFStringRef iText, Rect *ioBox, ATSUStyle iStyle, TXNTextBoxOptionsData const *iOptions);
// Wraps call to function 'TXNGetLineCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetLineCount(ewg_param_iTXNObject, ewg_param_oLineTotal) TXNGetLineCount ((TXNObject)ewg_param_iTXNObject, (ItemCount*)ewg_param_oLineTotal)

OSStatus  ewg_function_TXNGetLineCount (TXNObject iTXNObject, ItemCount *oLineTotal);
// Wraps call to function 'TXNGetLineMetrics' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetLineMetrics(ewg_param_iTXNObject, ewg_param_iLineNumber, ewg_param_oLineWidth, ewg_param_oLineHeight) TXNGetLineMetrics ((TXNObject)ewg_param_iTXNObject, (UInt32)ewg_param_iLineNumber, (Fixed*)ewg_param_oLineWidth, (Fixed*)ewg_param_oLineHeight)

OSStatus  ewg_function_TXNGetLineMetrics (TXNObject iTXNObject, UInt32 iLineNumber, Fixed *oLineWidth, Fixed *oLineHeight);
// Wraps call to function 'TXNGetChangeCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetChangeCount(ewg_param_iTXNObject) TXNGetChangeCount ((TXNObject)ewg_param_iTXNObject)

ItemCount  ewg_function_TXNGetChangeCount (TXNObject iTXNObject);
// Wraps call to function 'TXNGetCountForActionType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetCountForActionType(ewg_param_iTXNObject, ewg_param_iActionTypeName, ewg_param_oCount) TXNGetCountForActionType ((TXNObject)ewg_param_iTXNObject, (CFStringRef)ewg_param_iActionTypeName, (ItemCount*)ewg_param_oCount)

OSStatus  ewg_function_TXNGetCountForActionType (TXNObject iTXNObject, CFStringRef iActionTypeName, ItemCount *oCount);
// Wraps call to function 'TXNClearCountForActionType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNClearCountForActionType(ewg_param_iTXNObject, ewg_param_iActionTypeName) TXNClearCountForActionType ((TXNObject)ewg_param_iTXNObject, (CFStringRef)ewg_param_iActionTypeName)

OSStatus  ewg_function_TXNClearCountForActionType (TXNObject iTXNObject, CFStringRef iActionTypeName);
// Wraps call to function 'TXNSetHIRectBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetHIRectBounds(ewg_param_iTXNObject, ewg_param_iViewRect, ewg_param_iDestinationRect, ewg_param_iUpdate) TXNSetHIRectBounds ((TXNObject)ewg_param_iTXNObject, (HIRect const*)ewg_param_iViewRect, (HIRect const*)ewg_param_iDestinationRect, (Boolean)ewg_param_iUpdate)

void  ewg_function_TXNSetHIRectBounds (TXNObject iTXNObject, HIRect const *iViewRect, HIRect const *iDestinationRect, Boolean iUpdate);
// Wraps call to function 'TXNGetHIRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetHIRect(ewg_param_iTXNObject, ewg_param_iTXNRectKey, ewg_param_oRectangle) TXNGetHIRect ((TXNObject)ewg_param_iTXNObject, (TXNRectKey)ewg_param_iTXNRectKey, (HIRect*)ewg_param_oRectangle)

OSStatus  ewg_function_TXNGetHIRect (TXNObject iTXNObject, TXNRectKey iTXNRectKey, HIRect *oRectangle);
// Wraps call to function 'TXNResizeFrame' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNResizeFrame(ewg_param_iTXNObject, ewg_param_iWidth, ewg_param_iHeight, ewg_param_iTXNFrameID) TXNResizeFrame ((TXNObject)ewg_param_iTXNObject, (UInt32)ewg_param_iWidth, (UInt32)ewg_param_iHeight, (TXNFrameID)ewg_param_iTXNFrameID)

void  ewg_function_TXNResizeFrame (TXNObject iTXNObject, UInt32 iWidth, UInt32 iHeight, TXNFrameID iTXNFrameID);
// Wraps call to function 'TXNSetFrameBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetFrameBounds(ewg_param_iTXNObject, ewg_param_iTop, ewg_param_iLeft, ewg_param_iBottom, ewg_param_iRight, ewg_param_iTXNFrameID) TXNSetFrameBounds ((TXNObject)ewg_param_iTXNObject, (SInt32)ewg_param_iTop, (SInt32)ewg_param_iLeft, (SInt32)ewg_param_iBottom, (SInt32)ewg_param_iRight, (TXNFrameID)ewg_param_iTXNFrameID)

void  ewg_function_TXNSetFrameBounds (TXNObject iTXNObject, SInt32 iTop, SInt32 iLeft, SInt32 iBottom, SInt32 iRight, TXNFrameID iTXNFrameID);
// Wraps call to function 'TXNGetViewRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetViewRect(ewg_param_iTXNObject, ewg_param_oViewRect) TXNGetViewRect ((TXNObject)ewg_param_iTXNObject, (Rect*)ewg_param_oViewRect)

void  ewg_function_TXNGetViewRect (TXNObject iTXNObject, Rect *oViewRect);
// Wraps call to function 'TXNRecalcTextLayout' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNRecalcTextLayout(ewg_param_iTXNObject) TXNRecalcTextLayout ((TXNObject)ewg_param_iTXNObject)

void  ewg_function_TXNRecalcTextLayout (TXNObject iTXNObject);
// Wraps call to function 'TXNScroll' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNScroll(ewg_param_iTXNObject, ewg_param_iVerticalScrollUnit, ewg_param_iHorizontalScrollUnit, ewg_param_ioVerticalDelta, ewg_param_ioHorizontalDelta) TXNScroll ((TXNObject)ewg_param_iTXNObject, (TXNScrollUnit)ewg_param_iVerticalScrollUnit, (TXNScrollUnit)ewg_param_iHorizontalScrollUnit, (SInt32*)ewg_param_ioVerticalDelta, (SInt32*)ewg_param_ioHorizontalDelta)

OSStatus  ewg_function_TXNScroll (TXNObject iTXNObject, TXNScrollUnit iVerticalScrollUnit, TXNScrollUnit iHorizontalScrollUnit, SInt32 *ioVerticalDelta, SInt32 *ioHorizontalDelta);
// Wraps call to function 'TXNRegisterScrollInfoProc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNRegisterScrollInfoProc(ewg_param_iTXNObject, ewg_param_iTXNScrollInfoUPP, ewg_param_iRefCon) TXNRegisterScrollInfoProc ((TXNObject)ewg_param_iTXNObject, (TXNScrollInfoUPP)ewg_param_iTXNScrollInfoUPP, (SInt32)ewg_param_iRefCon)

void  ewg_function_TXNRegisterScrollInfoProc (TXNObject iTXNObject, TXNScrollInfoUPP iTXNScrollInfoUPP, SInt32 iRefCon);
// Wraps call to function 'TXNSetScrollbarState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetScrollbarState(ewg_param_iTXNObject, ewg_param_iActiveState) TXNSetScrollbarState ((TXNObject)ewg_param_iTXNObject, (TXNScrollBarState)ewg_param_iActiveState)

OSStatus  ewg_function_TXNSetScrollbarState (TXNObject iTXNObject, TXNScrollBarState iActiveState);
// Wraps call to function 'TXNHIPointToOffset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNHIPointToOffset(ewg_param_iTXNObject, ewg_param_iHIPoint, ewg_param_oOffset) TXNHIPointToOffset ((TXNObject)ewg_param_iTXNObject, (HIPoint const*)ewg_param_iHIPoint, (TXNOffset*)ewg_param_oOffset)

OSStatus  ewg_function_TXNHIPointToOffset (TXNObject iTXNObject, HIPoint const *iHIPoint, TXNOffset *oOffset);
// Wraps call to function 'TXNOffsetToHIPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNOffsetToHIPoint(ewg_param_iTXNObject, ewg_param_iOffset, ewg_param_oHIPoint) TXNOffsetToHIPoint ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iOffset, (HIPoint*)ewg_param_oHIPoint)

OSStatus  ewg_function_TXNOffsetToHIPoint (TXNObject iTXNObject, TXNOffset iOffset, HIPoint *oHIPoint);
// Wraps call to function 'TXNDragTracker' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDragTracker(ewg_param_iTXNObject, ewg_param_iTXNFrameID, ewg_param_iMessage, ewg_param_iWindow, ewg_param_iDragReference, ewg_param_iDifferentObjectSameWindow) TXNDragTracker ((TXNObject)ewg_param_iTXNObject, (TXNFrameID)ewg_param_iTXNFrameID, (DragTrackingMessage)ewg_param_iMessage, (WindowRef)ewg_param_iWindow, (DragReference)ewg_param_iDragReference, (Boolean)ewg_param_iDifferentObjectSameWindow)

OSErr  ewg_function_TXNDragTracker (TXNObject iTXNObject, TXNFrameID iTXNFrameID, DragTrackingMessage iMessage, WindowRef iWindow, DragReference iDragReference, Boolean iDifferentObjectSameWindow);
// Wraps call to function 'TXNDragReceiver' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDragReceiver(ewg_param_iTXNObject, ewg_param_iTXNFrameID, ewg_param_iWindow, ewg_param_iDragReference, ewg_param_iDifferentObjectSameWindow) TXNDragReceiver ((TXNObject)ewg_param_iTXNObject, (TXNFrameID)ewg_param_iTXNFrameID, (WindowRef)ewg_param_iWindow, (DragReference)ewg_param_iDragReference, (Boolean)ewg_param_iDifferentObjectSameWindow)

OSErr  ewg_function_TXNDragReceiver (TXNObject iTXNObject, TXNFrameID iTXNFrameID, WindowRef iWindow, DragReference iDragReference, Boolean iDifferentObjectSameWindow);
// Wraps call to function 'TXNSetCommandEventSupport' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetCommandEventSupport(ewg_param_iTXNObject, ewg_param_iOptions) TXNSetCommandEventSupport ((TXNObject)ewg_param_iTXNObject, (TXNCommandEventSupportOptions)ewg_param_iOptions)

OSStatus  ewg_function_TXNSetCommandEventSupport (TXNObject iTXNObject, TXNCommandEventSupportOptions iOptions);
// Wraps call to function 'TXNGetCommandEventSupport' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetCommandEventSupport(ewg_param_iTXNObject, ewg_param_oOptions) TXNGetCommandEventSupport ((TXNObject)ewg_param_iTXNObject, (TXNCommandEventSupportOptions*)ewg_param_oOptions)

OSStatus  ewg_function_TXNGetCommandEventSupport (TXNObject iTXNObject, TXNCommandEventSupportOptions *oOptions);
// Wraps call to function 'TXNSetSpellCheckAsYouType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetSpellCheckAsYouType(ewg_param_iTXNObject, ewg_param_iActivate) TXNSetSpellCheckAsYouType ((TXNObject)ewg_param_iTXNObject, (Boolean)ewg_param_iActivate)

OSStatus  ewg_function_TXNSetSpellCheckAsYouType (TXNObject iTXNObject, Boolean iActivate);
// Wraps call to function 'TXNGetSpellCheckAsYouType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetSpellCheckAsYouType(ewg_param_iTXNObject) TXNGetSpellCheckAsYouType ((TXNObject)ewg_param_iTXNObject)

Boolean  ewg_function_TXNGetSpellCheckAsYouType (TXNObject iTXNObject);
// Wraps call to function 'TXNSetEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetEventTarget(ewg_param_iTXNObject, ewg_param_iEventTarget) TXNSetEventTarget ((TXNObject)ewg_param_iTXNObject, (HIObjectRef)ewg_param_iEventTarget)

OSStatus  ewg_function_TXNSetEventTarget (TXNObject iTXNObject, HIObjectRef iEventTarget);
// Wraps call to function 'TXNGetEventTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetEventTarget(ewg_param_iTXNObject, ewg_param_oEventTarget) TXNGetEventTarget ((TXNObject)ewg_param_iTXNObject, (HIObjectRef*)ewg_param_oEventTarget)

OSStatus  ewg_function_TXNGetEventTarget (TXNObject iTXNObject, HIObjectRef *oEventTarget);
// Wraps call to function 'TXNSetContextualMenuSetup' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetContextualMenuSetup(ewg_param_iTXNObject, ewg_param_iMenuSetupProc, ewg_param_iUserData) TXNSetContextualMenuSetup ((TXNObject)ewg_param_iTXNObject, (TXNContextualMenuSetupUPP)ewg_param_iMenuSetupProc, (void const*)ewg_param_iUserData)

OSStatus  ewg_function_TXNSetContextualMenuSetup (TXNObject iTXNObject, TXNContextualMenuSetupUPP iMenuSetupProc, void const *iUserData);
// Wraps call to function 'TXNGetAccessibilityHIObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetAccessibilityHIObject(ewg_param_iTXNObject, ewg_param_oHIObjectRef) TXNGetAccessibilityHIObject ((TXNObject)ewg_param_iTXNObject, (HIObjectRef*)ewg_param_oHIObjectRef)

OSStatus  ewg_function_TXNGetAccessibilityHIObject (TXNObject iTXNObject, HIObjectRef *oHIObjectRef);
// Wraps call to function 'HITextViewCreate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HITextViewCreate(ewg_param_inBoundsRect, ewg_param_inOptions, ewg_param_inTXNFrameOptions, ewg_param_outTextView) HITextViewCreate ((HIRect const*)ewg_param_inBoundsRect, (OptionBits)ewg_param_inOptions, (TXNFrameOptions)ewg_param_inTXNFrameOptions, (HIViewRef*)ewg_param_outTextView)

OSStatus  ewg_function_HITextViewCreate (HIRect const *inBoundsRect, OptionBits inOptions, TXNFrameOptions inTXNFrameOptions, HIViewRef *outTextView);
// Wraps call to function 'HITextViewGetTXNObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HITextViewGetTXNObject(ewg_param_inTextView) HITextViewGetTXNObject ((HIViewRef)ewg_param_inTextView)

TXNObject  ewg_function_HITextViewGetTXNObject (HIViewRef inTextView);
// Wraps call to function 'HITextViewSetBackgroundColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HITextViewSetBackgroundColor(ewg_param_inTextView, ewg_param_inColor) HITextViewSetBackgroundColor ((HIViewRef)ewg_param_inTextView, (CGColorRef)ewg_param_inColor)

OSStatus  ewg_function_HITextViewSetBackgroundColor (HIViewRef inTextView, CGColorRef inColor);
// Wraps call to function 'HITextViewCopyBackgroundColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HITextViewCopyBackgroundColor(ewg_param_inTextView, ewg_param_outColor) HITextViewCopyBackgroundColor ((HIViewRef)ewg_param_inTextView, (CGColorRef*)ewg_param_outColor)

OSStatus  ewg_function_HITextViewCopyBackgroundColor (HIViewRef inTextView, CGColorRef *outColor);
// Wraps call to function 'NewTXNActionKeyMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewTXNActionKeyMapperUPP(ewg_param_userRoutine) NewTXNActionKeyMapperUPP ((TXNActionKeyMapperProcPtr)ewg_param_userRoutine)

TXNActionKeyMapperUPP  ewg_function_NewTXNActionKeyMapperUPP (TXNActionKeyMapperProcPtr userRoutine);
// Wraps call to function 'DisposeTXNActionKeyMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeTXNActionKeyMapperUPP(ewg_param_userUPP) DisposeTXNActionKeyMapperUPP ((TXNActionKeyMapperUPP)ewg_param_userUPP)

void  ewg_function_DisposeTXNActionKeyMapperUPP (TXNActionKeyMapperUPP userUPP);
// Wraps call to function 'InvokeTXNActionKeyMapperUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeTXNActionKeyMapperUPP(ewg_param_actionKey, ewg_param_commandID, ewg_param_userUPP) InvokeTXNActionKeyMapperUPP ((TXNActionKey)ewg_param_actionKey, (UInt32)ewg_param_commandID, (TXNActionKeyMapperUPP)ewg_param_userUPP)

CFStringRef  ewg_function_InvokeTXNActionKeyMapperUPP (TXNActionKey actionKey, UInt32 commandID, TXNActionKeyMapperUPP userUPP);
// Wraps call to function 'TXNSetViewRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetViewRect(ewg_param_iTXNObject, ewg_param_iViewRect) TXNSetViewRect ((TXNObject)ewg_param_iTXNObject, (Rect const*)ewg_param_iViewRect)

void  ewg_function_TXNSetViewRect (TXNObject iTXNObject, Rect const *iViewRect);
// Wraps call to function 'TXNNewObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNNewObject(ewg_param_iFileSpec, ewg_param_iWindow, ewg_param_iFrame, ewg_param_iFrameOptions, ewg_param_iFrameType, ewg_param_iFileType, ewg_param_iPermanentEncoding, ewg_param_oTXNObject, ewg_param_oTXNFrameID, ewg_param_iRefCon) TXNNewObject ((FSSpec const*)ewg_param_iFileSpec, (WindowRef)ewg_param_iWindow, (Rect const*)ewg_param_iFrame, (TXNFrameOptions)ewg_param_iFrameOptions, (TXNFrameType)ewg_param_iFrameType, (TXNFileType)ewg_param_iFileType, (TXNPermanentTextEncodingType)ewg_param_iPermanentEncoding, (TXNObject*)ewg_param_oTXNObject, (TXNFrameID*)ewg_param_oTXNFrameID, (TXNObjectRefcon)ewg_param_iRefCon)

OSStatus  ewg_function_TXNNewObject (FSSpec const *iFileSpec, WindowRef iWindow, Rect const *iFrame, TXNFrameOptions iFrameOptions, TXNFrameType iFrameType, TXNFileType iFileType, TXNPermanentTextEncodingType iPermanentEncoding, TXNObject *oTXNObject, TXNFrameID *oTXNFrameID, TXNObjectRefcon iRefCon);
// Wraps call to function 'TXNTerminateTextension' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNTerminateTextension TXNTerminateTextension ()

void  ewg_function_TXNTerminateTextension (void);
// Wraps call to function 'TXNSetDataFromFile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetDataFromFile(ewg_param_iTXNObject, ewg_param_iFileRefNum, ewg_param_iFileType, ewg_param_iFileLength, ewg_param_iStartOffset, ewg_param_iEndOffset) TXNSetDataFromFile ((TXNObject)ewg_param_iTXNObject, (SInt16)ewg_param_iFileRefNum, (OSType)ewg_param_iFileType, (ByteCount)ewg_param_iFileLength, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset)

OSStatus  ewg_function_TXNSetDataFromFile (TXNObject iTXNObject, SInt16 iFileRefNum, OSType iFileType, ByteCount iFileLength, TXNOffset iStartOffset, TXNOffset iEndOffset);
// Wraps call to function 'TXNConvertToPublicScrap' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNConvertToPublicScrap TXNConvertToPublicScrap ()

OSStatus  ewg_function_TXNConvertToPublicScrap (void);
// Wraps call to function 'TXNConvertFromPublicScrap' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNConvertFromPublicScrap TXNConvertFromPublicScrap ()

OSStatus  ewg_function_TXNConvertFromPublicScrap (void);
// Wraps call to function 'TXNDraw' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNDraw(ewg_param_iTXNObject, ewg_param_iDrawPort) TXNDraw ((TXNObject)ewg_param_iTXNObject, (GWorldPtr)ewg_param_iDrawPort)

void  ewg_function_TXNDraw (TXNObject iTXNObject, GWorldPtr iDrawPort);
// Wraps call to function 'TXNAttachObjectToWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNAttachObjectToWindow(ewg_param_iTXNObject, ewg_param_iWindow, ewg_param_iIsActualWindow) TXNAttachObjectToWindow ((TXNObject)ewg_param_iTXNObject, (GWorldPtr)ewg_param_iWindow, (Boolean)ewg_param_iIsActualWindow)

OSStatus  ewg_function_TXNAttachObjectToWindow (TXNObject iTXNObject, GWorldPtr iWindow, Boolean iIsActualWindow);
// Wraps call to function 'TXNIsObjectAttachedToWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNIsObjectAttachedToWindow(ewg_param_iTXNObject) TXNIsObjectAttachedToWindow ((TXNObject)ewg_param_iTXNObject)

Boolean  ewg_function_TXNIsObjectAttachedToWindow (TXNObject iTXNObject);
// Wraps call to function 'TXNIsObjectAttachedToSpecificWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNIsObjectAttachedToSpecificWindow(ewg_param_iTXNObject, ewg_param_iWindow, ewg_param_oAttached) TXNIsObjectAttachedToSpecificWindow ((TXNObject)ewg_param_iTXNObject, (WindowRef)ewg_param_iWindow, (Boolean*)ewg_param_oAttached)

OSStatus  ewg_function_TXNIsObjectAttachedToSpecificWindow (TXNObject iTXNObject, WindowRef iWindow, Boolean *oAttached);
// Wraps call to function 'TXNSetRectBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetRectBounds(ewg_param_iTXNObject, ewg_param_iViewRect, ewg_param_iDestinationRect, ewg_param_iUpdate) TXNSetRectBounds ((TXNObject)ewg_param_iTXNObject, (Rect const*)ewg_param_iViewRect, (TXNLongRect const*)ewg_param_iDestinationRect, (Boolean)ewg_param_iUpdate)

void  ewg_function_TXNSetRectBounds (TXNObject iTXNObject, Rect const *iViewRect, TXNLongRect const *iDestinationRect, Boolean iUpdate);
// Wraps call to function 'TXNGetRectBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetRectBounds(ewg_param_iTXNObject, ewg_param_oViewRect, ewg_param_oDestinationRect, ewg_param_oTextRect) TXNGetRectBounds ((TXNObject)ewg_param_iTXNObject, (Rect*)ewg_param_oViewRect, (TXNLongRect*)ewg_param_oDestinationRect, (TXNLongRect*)ewg_param_oTextRect)

OSStatus  ewg_function_TXNGetRectBounds (TXNObject iTXNObject, Rect *oViewRect, TXNLongRect *oDestinationRect, TXNLongRect *oTextRect);
// Wraps call to function 'TXNActivate' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNActivate(ewg_param_iTXNObject, ewg_param_iTXNFrameID, ewg_param_iActiveState) TXNActivate ((TXNObject)ewg_param_iTXNObject, (TXNFrameID)ewg_param_iTXNFrameID, (TXNScrollBarState)ewg_param_iActiveState)

OSStatus  ewg_function_TXNActivate (TXNObject iTXNObject, TXNFrameID iTXNFrameID, TXNScrollBarState iActiveState);
// Wraps call to function 'TXNPointToOffset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNPointToOffset(ewg_param_iTXNObject, ewg_param_iPoint, ewg_param_oOffset) TXNPointToOffset ((TXNObject)ewg_param_iTXNObject, *(Point*)ewg_param_iPoint, (TXNOffset*)ewg_param_oOffset)

OSStatus  ewg_function_TXNPointToOffset (TXNObject iTXNObject, Point *iPoint, TXNOffset *oOffset);
// Wraps call to function 'TXNOffsetToPoint' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNOffsetToPoint(ewg_param_iTXNObject, ewg_param_iOffset, ewg_param_oPoint) TXNOffsetToPoint ((TXNObject)ewg_param_iTXNObject, (TXNOffset)ewg_param_iOffset, (Point*)ewg_param_oPoint)

OSStatus  ewg_function_TXNOffsetToPoint (TXNObject iTXNObject, TXNOffset iOffset, Point *oPoint);
// Wraps call to function 'TXNCanUndo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCanUndo(ewg_param_iTXNObject, ewg_param_oTXNActionKey) TXNCanUndo ((TXNObject)ewg_param_iTXNObject, (TXNActionKey*)ewg_param_oTXNActionKey)

Boolean  ewg_function_TXNCanUndo (TXNObject iTXNObject, TXNActionKey *oTXNActionKey);
// Wraps call to function 'TXNCanRedo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNCanRedo(ewg_param_iTXNObject, ewg_param_oTXNActionKey) TXNCanRedo ((TXNObject)ewg_param_iTXNObject, (TXNActionKey*)ewg_param_oTXNActionKey)

Boolean  ewg_function_TXNCanRedo (TXNObject iTXNObject, TXNActionKey *oTXNActionKey);
// Wraps call to function 'TXNGetActionChangeCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNGetActionChangeCount(ewg_param_iTXNObject, ewg_param_iOptions, ewg_param_oCount) TXNGetActionChangeCount ((TXNObject)ewg_param_iTXNObject, (TXNCountOptions)ewg_param_iOptions, (ItemCount*)ewg_param_oCount)

OSStatus  ewg_function_TXNGetActionChangeCount (TXNObject iTXNObject, TXNCountOptions iOptions, ItemCount *oCount);
// Wraps call to function 'TXNClearActionChangeCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNClearActionChangeCount(ewg_param_iTXNObject, ewg_param_iOptions) TXNClearActionChangeCount ((TXNObject)ewg_param_iTXNObject, (TXNCountOptions)ewg_param_iOptions)

OSStatus  ewg_function_TXNClearActionChangeCount (TXNObject iTXNObject, TXNCountOptions iOptions);
// Wraps call to function 'TXNSetDataFromCFURLRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSetDataFromCFURLRef(ewg_param_iTXNObject, ewg_param_iURL, ewg_param_iStartOffset, ewg_param_iEndOffset) TXNSetDataFromCFURLRef ((TXNObject)ewg_param_iTXNObject, (CFURLRef)ewg_param_iURL, (TXNOffset)ewg_param_iStartOffset, (TXNOffset)ewg_param_iEndOffset)

OSStatus  ewg_function_TXNSetDataFromCFURLRef (TXNObject iTXNObject, CFURLRef iURL, TXNOffset iStartOffset, TXNOffset iEndOffset);
// Wraps call to function 'TXNSave' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_TXNSave(ewg_param_iTXNObject, ewg_param_iType, ewg_param_iResType, ewg_param_iPermanentEncoding, ewg_param_iFileSpecification, ewg_param_iDataReference, ewg_param_iResourceReference) TXNSave ((TXNObject)ewg_param_iTXNObject, (TXNFileType)ewg_param_iType, (OSType)ewg_param_iResType, (TXNPermanentTextEncodingType)ewg_param_iPermanentEncoding, (FSSpec const*)ewg_param_iFileSpecification, (SInt16)ewg_param_iDataReference, (SInt16)ewg_param_iResourceReference)

OSStatus  ewg_function_TXNSave (TXNObject iTXNObject, TXNFileType iType, OSType iResType, TXNPermanentTextEncodingType iPermanentEncoding, FSSpec const *iFileSpecification, SInt16 iDataReference, SInt16 iResourceReference);
// Wraps call to function 'NewHMControlContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewHMControlContentUPP(ewg_param_userRoutine) NewHMControlContentUPP ((HMControlContentProcPtr)ewg_param_userRoutine)

HMControlContentUPP  ewg_function_NewHMControlContentUPP (HMControlContentProcPtr userRoutine);
// Wraps call to function 'NewHMWindowContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewHMWindowContentUPP(ewg_param_userRoutine) NewHMWindowContentUPP ((HMWindowContentProcPtr)ewg_param_userRoutine)

HMWindowContentUPP  ewg_function_NewHMWindowContentUPP (HMWindowContentProcPtr userRoutine);
// Wraps call to function 'NewHMMenuTitleContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewHMMenuTitleContentUPP(ewg_param_userRoutine) NewHMMenuTitleContentUPP ((HMMenuTitleContentProcPtr)ewg_param_userRoutine)

HMMenuTitleContentUPP  ewg_function_NewHMMenuTitleContentUPP (HMMenuTitleContentProcPtr userRoutine);
// Wraps call to function 'NewHMMenuItemContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewHMMenuItemContentUPP(ewg_param_userRoutine) NewHMMenuItemContentUPP ((HMMenuItemContentProcPtr)ewg_param_userRoutine)

HMMenuItemContentUPP  ewg_function_NewHMMenuItemContentUPP (HMMenuItemContentProcPtr userRoutine);
// Wraps call to function 'DisposeHMControlContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeHMControlContentUPP(ewg_param_userUPP) DisposeHMControlContentUPP ((HMControlContentUPP)ewg_param_userUPP)

void  ewg_function_DisposeHMControlContentUPP (HMControlContentUPP userUPP);
// Wraps call to function 'DisposeHMWindowContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeHMWindowContentUPP(ewg_param_userUPP) DisposeHMWindowContentUPP ((HMWindowContentUPP)ewg_param_userUPP)

void  ewg_function_DisposeHMWindowContentUPP (HMWindowContentUPP userUPP);
// Wraps call to function 'DisposeHMMenuTitleContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeHMMenuTitleContentUPP(ewg_param_userUPP) DisposeHMMenuTitleContentUPP ((HMMenuTitleContentUPP)ewg_param_userUPP)

void  ewg_function_DisposeHMMenuTitleContentUPP (HMMenuTitleContentUPP userUPP);
// Wraps call to function 'DisposeHMMenuItemContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeHMMenuItemContentUPP(ewg_param_userUPP) DisposeHMMenuItemContentUPP ((HMMenuItemContentUPP)ewg_param_userUPP)

void  ewg_function_DisposeHMMenuItemContentUPP (HMMenuItemContentUPP userUPP);
// Wraps call to function 'InvokeHMControlContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeHMControlContentUPP(ewg_param_inControl, ewg_param_inGlobalMouse, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent, ewg_param_userUPP) InvokeHMControlContentUPP ((ControlRef)ewg_param_inControl, *(Point*)ewg_param_inGlobalMouse, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent, (HMControlContentUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeHMControlContentUPP (ControlRef inControl, Point *inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent, HMControlContentUPP userUPP);
// Wraps call to function 'InvokeHMWindowContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeHMWindowContentUPP(ewg_param_inWindow, ewg_param_inGlobalMouse, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent, ewg_param_userUPP) InvokeHMWindowContentUPP ((WindowRef)ewg_param_inWindow, *(Point*)ewg_param_inGlobalMouse, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent, (HMWindowContentUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeHMWindowContentUPP (WindowRef inWindow, Point *inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent, HMWindowContentUPP userUPP);
// Wraps call to function 'InvokeHMMenuTitleContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeHMMenuTitleContentUPP(ewg_param_inMenu, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent, ewg_param_userUPP) InvokeHMMenuTitleContentUPP ((MenuRef)ewg_param_inMenu, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent, (HMMenuTitleContentUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeHMMenuTitleContentUPP (MenuRef inMenu, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent, HMMenuTitleContentUPP userUPP);
// Wraps call to function 'InvokeHMMenuItemContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeHMMenuItemContentUPP(ewg_param_inTrackingData, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent, ewg_param_userUPP) InvokeHMMenuItemContentUPP ((MenuTrackingData const*)ewg_param_inTrackingData, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent, (HMMenuItemContentUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeHMMenuItemContentUPP (MenuTrackingData const *inTrackingData, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent, HMMenuItemContentUPP userUPP);
// Wraps call to function 'HMGetHelpMenu' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetHelpMenu(ewg_param_outHelpMenu, ewg_param_outFirstCustomItemIndex) HMGetHelpMenu ((MenuRef*)ewg_param_outHelpMenu, (MenuItemIndex*)ewg_param_outFirstCustomItemIndex)

OSStatus  ewg_function_HMGetHelpMenu (MenuRef *outHelpMenu, MenuItemIndex *outFirstCustomItemIndex);
// Wraps call to function 'HMSetControlHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetControlHelpContent(ewg_param_inControl, ewg_param_inContent) HMSetControlHelpContent ((ControlRef)ewg_param_inControl, (HMHelpContentRec const*)ewg_param_inContent)

OSStatus  ewg_function_HMSetControlHelpContent (ControlRef inControl, HMHelpContentRec const *inContent);
// Wraps call to function 'HMGetControlHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetControlHelpContent(ewg_param_inControl, ewg_param_outContent) HMGetControlHelpContent ((ControlRef)ewg_param_inControl, (HMHelpContentRec*)ewg_param_outContent)

OSStatus  ewg_function_HMGetControlHelpContent (ControlRef inControl, HMHelpContentRec *outContent);
// Wraps call to function 'HMSetWindowHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetWindowHelpContent(ewg_param_inWindow, ewg_param_inContent) HMSetWindowHelpContent ((WindowRef)ewg_param_inWindow, (HMHelpContentRec const*)ewg_param_inContent)

OSStatus  ewg_function_HMSetWindowHelpContent (WindowRef inWindow, HMHelpContentRec const *inContent);
// Wraps call to function 'HMGetWindowHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetWindowHelpContent(ewg_param_inWindow, ewg_param_outContent) HMGetWindowHelpContent ((WindowRef)ewg_param_inWindow, (HMHelpContentRec*)ewg_param_outContent)

OSStatus  ewg_function_HMGetWindowHelpContent (WindowRef inWindow, HMHelpContentRec *outContent);
// Wraps call to function 'HMSetMenuItemHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetMenuItemHelpContent(ewg_param_inMenu, ewg_param_inItem, ewg_param_inContent) HMSetMenuItemHelpContent ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (HMHelpContentRec const*)ewg_param_inContent)

OSStatus  ewg_function_HMSetMenuItemHelpContent (MenuRef inMenu, MenuItemIndex inItem, HMHelpContentRec const *inContent);
// Wraps call to function 'HMGetMenuItemHelpContent' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetMenuItemHelpContent(ewg_param_inMenu, ewg_param_inItem, ewg_param_outContent) HMGetMenuItemHelpContent ((MenuRef)ewg_param_inMenu, (MenuItemIndex)ewg_param_inItem, (HMHelpContentRec*)ewg_param_outContent)

OSStatus  ewg_function_HMGetMenuItemHelpContent (MenuRef inMenu, MenuItemIndex inItem, HMHelpContentRec *outContent);
// Wraps call to function 'HMInstallControlContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMInstallControlContentCallback(ewg_param_inControl, ewg_param_inContentUPP) HMInstallControlContentCallback ((ControlRef)ewg_param_inControl, (HMControlContentUPP)ewg_param_inContentUPP)

OSStatus  ewg_function_HMInstallControlContentCallback (ControlRef inControl, HMControlContentUPP inContentUPP);
// Wraps call to function 'HMInstallWindowContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMInstallWindowContentCallback(ewg_param_inWindow, ewg_param_inContentUPP) HMInstallWindowContentCallback ((WindowRef)ewg_param_inWindow, (HMWindowContentUPP)ewg_param_inContentUPP)

OSStatus  ewg_function_HMInstallWindowContentCallback (WindowRef inWindow, HMWindowContentUPP inContentUPP);
// Wraps call to function 'HMInstallMenuTitleContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMInstallMenuTitleContentCallback(ewg_param_inMenu, ewg_param_inContentUPP) HMInstallMenuTitleContentCallback ((MenuRef)ewg_param_inMenu, (HMMenuTitleContentUPP)ewg_param_inContentUPP)

OSStatus  ewg_function_HMInstallMenuTitleContentCallback (MenuRef inMenu, HMMenuTitleContentUPP inContentUPP);
// Wraps call to function 'HMInstallMenuItemContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMInstallMenuItemContentCallback(ewg_param_inMenu, ewg_param_inContentUPP) HMInstallMenuItemContentCallback ((MenuRef)ewg_param_inMenu, (HMMenuItemContentUPP)ewg_param_inContentUPP)

OSStatus  ewg_function_HMInstallMenuItemContentCallback (MenuRef inMenu, HMMenuItemContentUPP inContentUPP);
// Wraps call to function 'HMGetControlContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetControlContentCallback(ewg_param_inControl, ewg_param_outContentUPP) HMGetControlContentCallback ((ControlRef)ewg_param_inControl, (HMControlContentUPP*)ewg_param_outContentUPP)

OSStatus  ewg_function_HMGetControlContentCallback (ControlRef inControl, HMControlContentUPP *outContentUPP);
// Wraps call to function 'HMGetWindowContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetWindowContentCallback(ewg_param_inWindow, ewg_param_outContentUPP) HMGetWindowContentCallback ((WindowRef)ewg_param_inWindow, (HMWindowContentUPP*)ewg_param_outContentUPP)

OSStatus  ewg_function_HMGetWindowContentCallback (WindowRef inWindow, HMWindowContentUPP *outContentUPP);
// Wraps call to function 'HMGetMenuTitleContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetMenuTitleContentCallback(ewg_param_inMenu, ewg_param_outContentUPP) HMGetMenuTitleContentCallback ((MenuRef)ewg_param_inMenu, (HMMenuTitleContentUPP*)ewg_param_outContentUPP)

OSStatus  ewg_function_HMGetMenuTitleContentCallback (MenuRef inMenu, HMMenuTitleContentUPP *outContentUPP);
// Wraps call to function 'HMGetMenuItemContentCallback' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetMenuItemContentCallback(ewg_param_inMenu, ewg_param_outContentUPP) HMGetMenuItemContentCallback ((MenuRef)ewg_param_inMenu, (HMMenuItemContentUPP*)ewg_param_outContentUPP)

OSStatus  ewg_function_HMGetMenuItemContentCallback (MenuRef inMenu, HMMenuItemContentUPP *outContentUPP);
// Wraps call to function 'HMAreHelpTagsDisplayed' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMAreHelpTagsDisplayed HMAreHelpTagsDisplayed ()

Boolean  ewg_function_HMAreHelpTagsDisplayed (void);
// Wraps call to function 'HMSetHelpTagsDisplayed' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetHelpTagsDisplayed(ewg_param_inDisplayTags) HMSetHelpTagsDisplayed ((Boolean)ewg_param_inDisplayTags)

OSStatus  ewg_function_HMSetHelpTagsDisplayed (Boolean inDisplayTags);
// Wraps call to function 'HMSetTagDelay' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetTagDelay(ewg_param_inDelay) HMSetTagDelay ((Duration)ewg_param_inDelay)

OSStatus  ewg_function_HMSetTagDelay (Duration inDelay);
// Wraps call to function 'HMGetTagDelay' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMGetTagDelay(ewg_param_outDelay) HMGetTagDelay ((Duration*)ewg_param_outDelay)

OSStatus  ewg_function_HMGetTagDelay (Duration *outDelay);
// Wraps call to function 'HMSetMenuHelpFromBalloonRsrc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetMenuHelpFromBalloonRsrc(ewg_param_inMenu, ewg_param_inHmnuRsrcID) HMSetMenuHelpFromBalloonRsrc ((MenuRef)ewg_param_inMenu, (SInt16)ewg_param_inHmnuRsrcID)

OSStatus  ewg_function_HMSetMenuHelpFromBalloonRsrc (MenuRef inMenu, SInt16 inHmnuRsrcID);
// Wraps call to function 'HMSetDialogHelpFromBalloonRsrc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMSetDialogHelpFromBalloonRsrc(ewg_param_inDialog, ewg_param_inHdlgRsrcID, ewg_param_inItemStart) HMSetDialogHelpFromBalloonRsrc ((DialogRef)ewg_param_inDialog, (SInt16)ewg_param_inHdlgRsrcID, (SInt16)ewg_param_inItemStart)

OSStatus  ewg_function_HMSetDialogHelpFromBalloonRsrc (DialogRef inDialog, SInt16 inHdlgRsrcID, SInt16 inItemStart);
// Wraps call to function 'HMDisplayTag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMDisplayTag(ewg_param_inContent) HMDisplayTag ((HMHelpContentRec const*)ewg_param_inContent)

OSStatus  ewg_function_HMDisplayTag (HMHelpContentRec const *inContent);
// Wraps call to function 'HMHideTag' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMHideTag HMHideTag ()

OSStatus  ewg_function_HMHideTag (void);
// Wraps call to function 'HMHideTagWithOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HMHideTagWithOptions(ewg_param_inOptions) HMHideTagWithOptions ((OptionBits)ewg_param_inOptions)

OSStatus  ewg_function_HMHideTagWithOptions (OptionBits inOptions);
// Wraps call to function 'CreateBevelButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateBevelButtonControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_thickness, ewg_param_behavior, ewg_param_info, ewg_param_menuID, ewg_param_menuBehavior, ewg_param_menuPlacement, ewg_param_outControl) CreateBevelButtonControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (ControlBevelThickness)ewg_param_thickness, (ControlBevelButtonBehavior)ewg_param_behavior, (ControlButtonContentInfoPtr)ewg_param_info, (SInt16)ewg_param_menuID, (ControlBevelButtonMenuBehavior)ewg_param_menuBehavior, (ControlBevelButtonMenuPlacement)ewg_param_menuPlacement, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateBevelButtonControl (WindowRef window, Rect const *boundsRect, CFStringRef title, ControlBevelThickness thickness, ControlBevelButtonBehavior behavior, ControlButtonContentInfoPtr info, SInt16 menuID, ControlBevelButtonMenuBehavior menuBehavior, ControlBevelButtonMenuPlacement menuPlacement, ControlRef *outControl);
// Wraps call to function 'GetBevelButtonMenuValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetBevelButtonMenuValue(ewg_param_inButton, ewg_param_outValue) GetBevelButtonMenuValue ((ControlRef)ewg_param_inButton, (SInt16*)ewg_param_outValue)

OSErr  ewg_function_GetBevelButtonMenuValue (ControlRef inButton, SInt16 *outValue);
// Wraps call to function 'SetBevelButtonMenuValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonMenuValue(ewg_param_inButton, ewg_param_inValue) SetBevelButtonMenuValue ((ControlRef)ewg_param_inButton, (SInt16)ewg_param_inValue)

OSErr  ewg_function_SetBevelButtonMenuValue (ControlRef inButton, SInt16 inValue);
// Wraps call to function 'GetBevelButtonMenuHandle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetBevelButtonMenuHandle(ewg_param_inButton, ewg_param_outHandle) GetBevelButtonMenuHandle ((ControlRef)ewg_param_inButton, (MenuHandle*)ewg_param_outHandle)

OSErr  ewg_function_GetBevelButtonMenuHandle (ControlRef inButton, MenuHandle *outHandle);
// Wraps call to function 'GetBevelButtonContentInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetBevelButtonContentInfo(ewg_param_inButton, ewg_param_outContent) GetBevelButtonContentInfo ((ControlRef)ewg_param_inButton, (ControlButtonContentInfoPtr)ewg_param_outContent)

OSErr  ewg_function_GetBevelButtonContentInfo (ControlRef inButton, ControlButtonContentInfoPtr outContent);
// Wraps call to function 'SetBevelButtonContentInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonContentInfo(ewg_param_inButton, ewg_param_inContent) SetBevelButtonContentInfo ((ControlRef)ewg_param_inButton, (ControlButtonContentInfoPtr)ewg_param_inContent)

OSErr  ewg_function_SetBevelButtonContentInfo (ControlRef inButton, ControlButtonContentInfoPtr inContent);
// Wraps call to function 'SetBevelButtonTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonTransform(ewg_param_inButton, ewg_param_transform) SetBevelButtonTransform ((ControlRef)ewg_param_inButton, (IconTransformType)ewg_param_transform)

OSErr  ewg_function_SetBevelButtonTransform (ControlRef inButton, IconTransformType transform);
// Wraps call to function 'SetBevelButtonGraphicAlignment' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonGraphicAlignment(ewg_param_inButton, ewg_param_inAlign, ewg_param_inHOffset, ewg_param_inVOffset) SetBevelButtonGraphicAlignment ((ControlRef)ewg_param_inButton, (ControlButtonGraphicAlignment)ewg_param_inAlign, (SInt16)ewg_param_inHOffset, (SInt16)ewg_param_inVOffset)

OSErr  ewg_function_SetBevelButtonGraphicAlignment (ControlRef inButton, ControlButtonGraphicAlignment inAlign, SInt16 inHOffset, SInt16 inVOffset);
// Wraps call to function 'SetBevelButtonTextAlignment' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonTextAlignment(ewg_param_inButton, ewg_param_inAlign, ewg_param_inHOffset) SetBevelButtonTextAlignment ((ControlRef)ewg_param_inButton, (ControlButtonTextAlignment)ewg_param_inAlign, (SInt16)ewg_param_inHOffset)

OSErr  ewg_function_SetBevelButtonTextAlignment (ControlRef inButton, ControlButtonTextAlignment inAlign, SInt16 inHOffset);
// Wraps call to function 'SetBevelButtonTextPlacement' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetBevelButtonTextPlacement(ewg_param_inButton, ewg_param_inWhere) SetBevelButtonTextPlacement ((ControlRef)ewg_param_inButton, (ControlButtonTextPlacement)ewg_param_inWhere)

OSErr  ewg_function_SetBevelButtonTextPlacement (ControlRef inButton, ControlButtonTextPlacement inWhere);
// Wraps call to function 'CreateSliderControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateSliderControl(ewg_param_window, ewg_param_boundsRect, ewg_param_value, ewg_param_minimum, ewg_param_maximum, ewg_param_orientation, ewg_param_numTickMarks, ewg_param_liveTracking, ewg_param_liveTrackingProc, ewg_param_outControl) CreateSliderControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt32)ewg_param_value, (SInt32)ewg_param_minimum, (SInt32)ewg_param_maximum, (ControlSliderOrientation)ewg_param_orientation, (UInt16)ewg_param_numTickMarks, (Boolean)ewg_param_liveTracking, (ControlActionUPP)ewg_param_liveTrackingProc, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateSliderControl (WindowRef window, Rect const *boundsRect, SInt32 value, SInt32 minimum, SInt32 maximum, ControlSliderOrientation orientation, UInt16 numTickMarks, Boolean liveTracking, ControlActionUPP liveTrackingProc, ControlRef *outControl);
// Wraps call to function 'CreateDisclosureTriangleControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateDisclosureTriangleControl(ewg_param_inWindow, ewg_param_inBoundsRect, ewg_param_inOrientation, ewg_param_inTitle, ewg_param_inInitialValue, ewg_param_inDrawTitle, ewg_param_inAutoToggles, ewg_param_outControl) CreateDisclosureTriangleControl ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inBoundsRect, (ControlDisclosureTriangleOrientation)ewg_param_inOrientation, (CFStringRef)ewg_param_inTitle, (SInt32)ewg_param_inInitialValue, (Boolean)ewg_param_inDrawTitle, (Boolean)ewg_param_inAutoToggles, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateDisclosureTriangleControl (WindowRef inWindow, Rect const *inBoundsRect, ControlDisclosureTriangleOrientation inOrientation, CFStringRef inTitle, SInt32 inInitialValue, Boolean inDrawTitle, Boolean inAutoToggles, ControlRef *outControl);
// Wraps call to function 'SetDisclosureTriangleLastValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDisclosureTriangleLastValue(ewg_param_inTabControl, ewg_param_inValue) SetDisclosureTriangleLastValue ((ControlRef)ewg_param_inTabControl, (SInt16)ewg_param_inValue)

OSErr  ewg_function_SetDisclosureTriangleLastValue (ControlRef inTabControl, SInt16 inValue);
// Wraps call to function 'CreateProgressBarControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateProgressBarControl(ewg_param_window, ewg_param_boundsRect, ewg_param_value, ewg_param_minimum, ewg_param_maximum, ewg_param_indeterminate, ewg_param_outControl) CreateProgressBarControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt32)ewg_param_value, (SInt32)ewg_param_minimum, (SInt32)ewg_param_maximum, (Boolean)ewg_param_indeterminate, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateProgressBarControl (WindowRef window, Rect const *boundsRect, SInt32 value, SInt32 minimum, SInt32 maximum, Boolean indeterminate, ControlRef *outControl);
// Wraps call to function 'CreateRelevanceBarControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateRelevanceBarControl(ewg_param_window, ewg_param_boundsRect, ewg_param_value, ewg_param_minimum, ewg_param_maximum, ewg_param_outControl) CreateRelevanceBarControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt32)ewg_param_value, (SInt32)ewg_param_minimum, (SInt32)ewg_param_maximum, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateRelevanceBarControl (WindowRef window, Rect const *boundsRect, SInt32 value, SInt32 minimum, SInt32 maximum, ControlRef *outControl);
// Wraps call to function 'CreateLittleArrowsControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateLittleArrowsControl(ewg_param_window, ewg_param_boundsRect, ewg_param_value, ewg_param_minimum, ewg_param_maximum, ewg_param_increment, ewg_param_outControl) CreateLittleArrowsControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt32)ewg_param_value, (SInt32)ewg_param_minimum, (SInt32)ewg_param_maximum, (SInt32)ewg_param_increment, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateLittleArrowsControl (WindowRef window, Rect const *boundsRect, SInt32 value, SInt32 minimum, SInt32 maximum, SInt32 increment, ControlRef *outControl);
// Wraps call to function 'CreateChasingArrowsControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateChasingArrowsControl(ewg_param_window, ewg_param_boundsRect, ewg_param_outControl) CreateChasingArrowsControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateChasingArrowsControl (WindowRef window, Rect const *boundsRect, ControlRef *outControl);
// Wraps call to function 'CreateTabsControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateTabsControl(ewg_param_window, ewg_param_boundsRect, ewg_param_size, ewg_param_direction, ewg_param_numTabs, ewg_param_tabArray, ewg_param_outControl) CreateTabsControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlTabSize)ewg_param_size, (ControlTabDirection)ewg_param_direction, (UInt16)ewg_param_numTabs, (ControlTabEntry const*)ewg_param_tabArray, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateTabsControl (WindowRef window, Rect const *boundsRect, ControlTabSize size, ControlTabDirection direction, UInt16 numTabs, ControlTabEntry const *tabArray, ControlRef *outControl);
// Wraps call to function 'GetTabContentRect' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetTabContentRect(ewg_param_inTabControl, ewg_param_outContentRect) GetTabContentRect ((ControlRef)ewg_param_inTabControl, (Rect*)ewg_param_outContentRect)

OSErr  ewg_function_GetTabContentRect (ControlRef inTabControl, Rect *outContentRect);
// Wraps call to function 'SetTabEnabled' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetTabEnabled(ewg_param_inTabControl, ewg_param_inTabToHilite, ewg_param_inEnabled) SetTabEnabled ((ControlRef)ewg_param_inTabControl, (SInt16)ewg_param_inTabToHilite, (Boolean)ewg_param_inEnabled)

OSErr  ewg_function_SetTabEnabled (ControlRef inTabControl, SInt16 inTabToHilite, Boolean inEnabled);
// Wraps call to function 'CreateSeparatorControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateSeparatorControl(ewg_param_window, ewg_param_boundsRect, ewg_param_outControl) CreateSeparatorControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateSeparatorControl (WindowRef window, Rect const *boundsRect, ControlRef *outControl);
// Wraps call to function 'CreateGroupBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateGroupBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_primary, ewg_param_outControl) CreateGroupBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (Boolean)ewg_param_primary, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateGroupBoxControl (WindowRef window, Rect const *boundsRect, CFStringRef title, Boolean primary, ControlRef *outControl);
// Wraps call to function 'CreateCheckGroupBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateCheckGroupBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_initialValue, ewg_param_primary, ewg_param_autoToggle, ewg_param_outControl) CreateCheckGroupBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (SInt32)ewg_param_initialValue, (Boolean)ewg_param_primary, (Boolean)ewg_param_autoToggle, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateCheckGroupBoxControl (WindowRef window, Rect const *boundsRect, CFStringRef title, SInt32 initialValue, Boolean primary, Boolean autoToggle, ControlRef *outControl);
// Wraps call to function 'CreatePopupGroupBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePopupGroupBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_primary, ewg_param_menuID, ewg_param_variableWidth, ewg_param_titleWidth, ewg_param_titleJustification, ewg_param_titleStyle, ewg_param_outControl) CreatePopupGroupBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (Boolean)ewg_param_primary, (SInt16)ewg_param_menuID, (Boolean)ewg_param_variableWidth, (SInt16)ewg_param_titleWidth, (SInt16)ewg_param_titleJustification, (Style)ewg_param_titleStyle, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePopupGroupBoxControl (WindowRef window, Rect const *boundsRect, CFStringRef title, Boolean primary, SInt16 menuID, Boolean variableWidth, SInt16 titleWidth, SInt16 titleJustification, Style titleStyle, ControlRef *outControl);
// Wraps call to function 'CreateImageWellControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateImageWellControl(ewg_param_window, ewg_param_boundsRect, ewg_param_info, ewg_param_outControl) CreateImageWellControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlButtonContentInfo const*)ewg_param_info, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateImageWellControl (WindowRef window, Rect const *boundsRect, ControlButtonContentInfo const *info, ControlRef *outControl);
// Wraps call to function 'GetImageWellContentInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetImageWellContentInfo(ewg_param_inButton, ewg_param_outContent) GetImageWellContentInfo ((ControlRef)ewg_param_inButton, (ControlButtonContentInfoPtr)ewg_param_outContent)

OSErr  ewg_function_GetImageWellContentInfo (ControlRef inButton, ControlButtonContentInfoPtr outContent);
// Wraps call to function 'SetImageWellContentInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetImageWellContentInfo(ewg_param_inButton, ewg_param_inContent) SetImageWellContentInfo ((ControlRef)ewg_param_inButton, (ControlButtonContentInfoPtr)ewg_param_inContent)

OSErr  ewg_function_SetImageWellContentInfo (ControlRef inButton, ControlButtonContentInfoPtr inContent);
// Wraps call to function 'SetImageWellTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetImageWellTransform(ewg_param_inButton, ewg_param_inTransform) SetImageWellTransform ((ControlRef)ewg_param_inButton, (IconTransformType)ewg_param_inTransform)

OSErr  ewg_function_SetImageWellTransform (ControlRef inButton, IconTransformType inTransform);
// Wraps call to function 'CreatePopupArrowControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePopupArrowControl(ewg_param_window, ewg_param_boundsRect, ewg_param_orientation, ewg_param_size, ewg_param_outControl) CreatePopupArrowControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlPopupArrowOrientation)ewg_param_orientation, (ControlPopupArrowSize)ewg_param_size, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePopupArrowControl (WindowRef window, Rect const *boundsRect, ControlPopupArrowOrientation orientation, ControlPopupArrowSize size, ControlRef *outControl);
// Wraps call to function 'CreatePlacardControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePlacardControl(ewg_param_window, ewg_param_boundsRect, ewg_param_outControl) CreatePlacardControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePlacardControl (WindowRef window, Rect const *boundsRect, ControlRef *outControl);
// Wraps call to function 'CreateClockControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateClockControl(ewg_param_window, ewg_param_boundsRect, ewg_param_clockType, ewg_param_clockFlags, ewg_param_outControl) CreateClockControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlClockType)ewg_param_clockType, (ControlClockFlags)ewg_param_clockFlags, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateClockControl (WindowRef window, Rect const *boundsRect, ControlClockType clockType, ControlClockFlags clockFlags, ControlRef *outControl);
// Wraps call to function 'CreateUserPaneControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateUserPaneControl(ewg_param_window, ewg_param_boundsRect, ewg_param_features, ewg_param_outControl) CreateUserPaneControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (UInt32)ewg_param_features, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateUserPaneControl (WindowRef window, Rect const *boundsRect, UInt32 features, ControlRef *outControl);
// Wraps call to function 'NewControlUserPaneDrawUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneDrawUPP(ewg_param_userRoutine) NewControlUserPaneDrawUPP ((ControlUserPaneDrawProcPtr)ewg_param_userRoutine)

ControlUserPaneDrawUPP  ewg_function_NewControlUserPaneDrawUPP (ControlUserPaneDrawProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneHitTestUPP(ewg_param_userRoutine) NewControlUserPaneHitTestUPP ((ControlUserPaneHitTestProcPtr)ewg_param_userRoutine)

ControlUserPaneHitTestUPP  ewg_function_NewControlUserPaneHitTestUPP (ControlUserPaneHitTestProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneTrackingUPP(ewg_param_userRoutine) NewControlUserPaneTrackingUPP ((ControlUserPaneTrackingProcPtr)ewg_param_userRoutine)

ControlUserPaneTrackingUPP  ewg_function_NewControlUserPaneTrackingUPP (ControlUserPaneTrackingProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneIdleUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneIdleUPP(ewg_param_userRoutine) NewControlUserPaneIdleUPP ((ControlUserPaneIdleProcPtr)ewg_param_userRoutine)

ControlUserPaneIdleUPP  ewg_function_NewControlUserPaneIdleUPP (ControlUserPaneIdleProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneKeyDownUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneKeyDownUPP(ewg_param_userRoutine) NewControlUserPaneKeyDownUPP ((ControlUserPaneKeyDownProcPtr)ewg_param_userRoutine)

ControlUserPaneKeyDownUPP  ewg_function_NewControlUserPaneKeyDownUPP (ControlUserPaneKeyDownProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneActivateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneActivateUPP(ewg_param_userRoutine) NewControlUserPaneActivateUPP ((ControlUserPaneActivateProcPtr)ewg_param_userRoutine)

ControlUserPaneActivateUPP  ewg_function_NewControlUserPaneActivateUPP (ControlUserPaneActivateProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneFocusUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneFocusUPP(ewg_param_userRoutine) NewControlUserPaneFocusUPP ((ControlUserPaneFocusProcPtr)ewg_param_userRoutine)

ControlUserPaneFocusUPP  ewg_function_NewControlUserPaneFocusUPP (ControlUserPaneFocusProcPtr userRoutine);
// Wraps call to function 'NewControlUserPaneBackgroundUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlUserPaneBackgroundUPP(ewg_param_userRoutine) NewControlUserPaneBackgroundUPP ((ControlUserPaneBackgroundProcPtr)ewg_param_userRoutine)

ControlUserPaneBackgroundUPP  ewg_function_NewControlUserPaneBackgroundUPP (ControlUserPaneBackgroundProcPtr userRoutine);
// Wraps call to function 'DisposeControlUserPaneDrawUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneDrawUPP(ewg_param_userUPP) DisposeControlUserPaneDrawUPP ((ControlUserPaneDrawUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneDrawUPP (ControlUserPaneDrawUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneHitTestUPP(ewg_param_userUPP) DisposeControlUserPaneHitTestUPP ((ControlUserPaneHitTestUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneHitTestUPP (ControlUserPaneHitTestUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneTrackingUPP(ewg_param_userUPP) DisposeControlUserPaneTrackingUPP ((ControlUserPaneTrackingUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneTrackingUPP (ControlUserPaneTrackingUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneIdleUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneIdleUPP(ewg_param_userUPP) DisposeControlUserPaneIdleUPP ((ControlUserPaneIdleUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneIdleUPP (ControlUserPaneIdleUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneKeyDownUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneKeyDownUPP(ewg_param_userUPP) DisposeControlUserPaneKeyDownUPP ((ControlUserPaneKeyDownUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneKeyDownUPP (ControlUserPaneKeyDownUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneActivateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneActivateUPP(ewg_param_userUPP) DisposeControlUserPaneActivateUPP ((ControlUserPaneActivateUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneActivateUPP (ControlUserPaneActivateUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneFocusUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneFocusUPP(ewg_param_userUPP) DisposeControlUserPaneFocusUPP ((ControlUserPaneFocusUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneFocusUPP (ControlUserPaneFocusUPP userUPP);
// Wraps call to function 'DisposeControlUserPaneBackgroundUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlUserPaneBackgroundUPP(ewg_param_userUPP) DisposeControlUserPaneBackgroundUPP ((ControlUserPaneBackgroundUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlUserPaneBackgroundUPP (ControlUserPaneBackgroundUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneDrawUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneDrawUPP(ewg_param_control, ewg_param_part, ewg_param_userUPP) InvokeControlUserPaneDrawUPP ((ControlRef)ewg_param_control, (SInt16)ewg_param_part, (ControlUserPaneDrawUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlUserPaneDrawUPP (ControlRef control, SInt16 part, ControlUserPaneDrawUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneHitTestUPP(ewg_param_control, ewg_param_where, ewg_param_userUPP) InvokeControlUserPaneHitTestUPP ((ControlRef)ewg_param_control, *(Point*)ewg_param_where, (ControlUserPaneHitTestUPP)ewg_param_userUPP)

ControlPartCode  ewg_function_InvokeControlUserPaneHitTestUPP (ControlRef control, Point *where, ControlUserPaneHitTestUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneTrackingUPP(ewg_param_control, ewg_param_startPt, ewg_param_actionProc, ewg_param_userUPP) InvokeControlUserPaneTrackingUPP ((ControlRef)ewg_param_control, *(Point*)ewg_param_startPt, (ControlActionUPP)ewg_param_actionProc, (ControlUserPaneTrackingUPP)ewg_param_userUPP)

ControlPartCode  ewg_function_InvokeControlUserPaneTrackingUPP (ControlRef control, Point *startPt, ControlActionUPP actionProc, ControlUserPaneTrackingUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneIdleUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneIdleUPP(ewg_param_control, ewg_param_userUPP) InvokeControlUserPaneIdleUPP ((ControlRef)ewg_param_control, (ControlUserPaneIdleUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlUserPaneIdleUPP (ControlRef control, ControlUserPaneIdleUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneKeyDownUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneKeyDownUPP(ewg_param_control, ewg_param_keyCode, ewg_param_charCode, ewg_param_modifiers, ewg_param_userUPP) InvokeControlUserPaneKeyDownUPP ((ControlRef)ewg_param_control, (SInt16)ewg_param_keyCode, (SInt16)ewg_param_charCode, (SInt16)ewg_param_modifiers, (ControlUserPaneKeyDownUPP)ewg_param_userUPP)

ControlPartCode  ewg_function_InvokeControlUserPaneKeyDownUPP (ControlRef control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers, ControlUserPaneKeyDownUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneActivateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneActivateUPP(ewg_param_control, ewg_param_activating, ewg_param_userUPP) InvokeControlUserPaneActivateUPP ((ControlRef)ewg_param_control, (Boolean)ewg_param_activating, (ControlUserPaneActivateUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlUserPaneActivateUPP (ControlRef control, Boolean activating, ControlUserPaneActivateUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneFocusUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneFocusUPP(ewg_param_control, ewg_param_action, ewg_param_userUPP) InvokeControlUserPaneFocusUPP ((ControlRef)ewg_param_control, (ControlFocusPart)ewg_param_action, (ControlUserPaneFocusUPP)ewg_param_userUPP)

ControlPartCode  ewg_function_InvokeControlUserPaneFocusUPP (ControlRef control, ControlFocusPart action, ControlUserPaneFocusUPP userUPP);
// Wraps call to function 'InvokeControlUserPaneBackgroundUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlUserPaneBackgroundUPP(ewg_param_control, ewg_param_info, ewg_param_userUPP) InvokeControlUserPaneBackgroundUPP ((ControlRef)ewg_param_control, (ControlBackgroundPtr)ewg_param_info, (ControlUserPaneBackgroundUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlUserPaneBackgroundUPP (ControlRef control, ControlBackgroundPtr info, ControlUserPaneBackgroundUPP userUPP);
// Wraps call to function 'CreateEditTextControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateEditTextControl(ewg_param_window, ewg_param_boundsRect, ewg_param_text, ewg_param_isPassword, ewg_param_useInlineInput, ewg_param_style, ewg_param_outControl) CreateEditTextControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_text, (Boolean)ewg_param_isPassword, (Boolean)ewg_param_useInlineInput, (ControlFontStyleRec const*)ewg_param_style, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateEditTextControl (WindowRef window, Rect const *boundsRect, CFStringRef text, Boolean isPassword, Boolean useInlineInput, ControlFontStyleRec const *style, ControlRef *outControl);
// Wraps call to function 'NewControlEditTextValidationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewControlEditTextValidationUPP(ewg_param_userRoutine) NewControlEditTextValidationUPP ((ControlEditTextValidationProcPtr)ewg_param_userRoutine)

ControlEditTextValidationUPP  ewg_function_NewControlEditTextValidationUPP (ControlEditTextValidationProcPtr userRoutine);
// Wraps call to function 'DisposeControlEditTextValidationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeControlEditTextValidationUPP(ewg_param_userUPP) DisposeControlEditTextValidationUPP ((ControlEditTextValidationUPP)ewg_param_userUPP)

void  ewg_function_DisposeControlEditTextValidationUPP (ControlEditTextValidationUPP userUPP);
// Wraps call to function 'InvokeControlEditTextValidationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeControlEditTextValidationUPP(ewg_param_control, ewg_param_userUPP) InvokeControlEditTextValidationUPP ((ControlRef)ewg_param_control, (ControlEditTextValidationUPP)ewg_param_userUPP)

void  ewg_function_InvokeControlEditTextValidationUPP (ControlRef control, ControlEditTextValidationUPP userUPP);
// Wraps call to function 'CreateStaticTextControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateStaticTextControl(ewg_param_window, ewg_param_boundsRect, ewg_param_text, ewg_param_style, ewg_param_outControl) CreateStaticTextControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_text, (ControlFontStyleRec const*)ewg_param_style, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateStaticTextControl (WindowRef window, Rect const *boundsRect, CFStringRef text, ControlFontStyleRec const *style, ControlRef *outControl);
// Wraps call to function 'CreatePictureControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePictureControl(ewg_param_window, ewg_param_boundsRect, ewg_param_content, ewg_param_dontTrack, ewg_param_outControl) CreatePictureControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlButtonContentInfo const*)ewg_param_content, (Boolean)ewg_param_dontTrack, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePictureControl (WindowRef window, Rect const *boundsRect, ControlButtonContentInfo const *content, Boolean dontTrack, ControlRef *outControl);
// Wraps call to function 'CreateIconControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateIconControl(ewg_param_inWindow, ewg_param_inBoundsRect, ewg_param_inIconContent, ewg_param_inDontTrack, ewg_param_outControl) CreateIconControl ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inBoundsRect, (ControlButtonContentInfo const*)ewg_param_inIconContent, (Boolean)ewg_param_inDontTrack, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateIconControl (WindowRef inWindow, Rect const *inBoundsRect, ControlButtonContentInfo const *inIconContent, Boolean inDontTrack, ControlRef *outControl);
// Wraps call to function 'CreateWindowHeaderControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateWindowHeaderControl(ewg_param_window, ewg_param_boundsRect, ewg_param_isListHeader, ewg_param_outControl) CreateWindowHeaderControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (Boolean)ewg_param_isListHeader, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateWindowHeaderControl (WindowRef window, Rect const *boundsRect, Boolean isListHeader, ControlRef *outControl);
// Wraps call to function 'CreateListBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateListBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_autoSize, ewg_param_numRows, ewg_param_numColumns, ewg_param_horizScroll, ewg_param_vertScroll, ewg_param_cellHeight, ewg_param_cellWidth, ewg_param_hasGrowSpace, ewg_param_listDef, ewg_param_outControl) CreateListBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (Boolean)ewg_param_autoSize, (SInt16)ewg_param_numRows, (SInt16)ewg_param_numColumns, (Boolean)ewg_param_horizScroll, (Boolean)ewg_param_vertScroll, (SInt16)ewg_param_cellHeight, (SInt16)ewg_param_cellWidth, (Boolean)ewg_param_hasGrowSpace, (ListDefSpec const*)ewg_param_listDef, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateListBoxControl (WindowRef window, Rect const *boundsRect, Boolean autoSize, SInt16 numRows, SInt16 numColumns, Boolean horizScroll, Boolean vertScroll, SInt16 cellHeight, SInt16 cellWidth, Boolean hasGrowSpace, ListDefSpec const *listDef, ControlRef *outControl);
// Wraps call to function 'CreatePushButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePushButtonControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_outControl) CreatePushButtonControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePushButtonControl (WindowRef window, Rect const *boundsRect, CFStringRef title, ControlRef *outControl);
// Wraps call to function 'CreatePushButtonWithIconControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePushButtonWithIconControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_icon, ewg_param_iconAlignment, ewg_param_outControl) CreatePushButtonWithIconControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (ControlButtonContentInfo*)ewg_param_icon, (ControlPushButtonIconAlignment)ewg_param_iconAlignment, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePushButtonWithIconControl (WindowRef window, Rect const *boundsRect, CFStringRef title, ControlButtonContentInfo *icon, ControlPushButtonIconAlignment iconAlignment, ControlRef *outControl);
// Wraps call to function 'CreateRadioButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateRadioButtonControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_initialValue, ewg_param_autoToggle, ewg_param_outControl) CreateRadioButtonControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (SInt32)ewg_param_initialValue, (Boolean)ewg_param_autoToggle, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateRadioButtonControl (WindowRef window, Rect const *boundsRect, CFStringRef title, SInt32 initialValue, Boolean autoToggle, ControlRef *outControl);
// Wraps call to function 'CreateCheckBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateCheckBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_initialValue, ewg_param_autoToggle, ewg_param_outControl) CreateCheckBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (SInt32)ewg_param_initialValue, (Boolean)ewg_param_autoToggle, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateCheckBoxControl (WindowRef window, Rect const *boundsRect, CFStringRef title, SInt32 initialValue, Boolean autoToggle, ControlRef *outControl);
// Wraps call to function 'CreateScrollBarControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateScrollBarControl(ewg_param_window, ewg_param_boundsRect, ewg_param_value, ewg_param_minimum, ewg_param_maximum, ewg_param_viewSize, ewg_param_liveTracking, ewg_param_liveTrackingProc, ewg_param_outControl) CreateScrollBarControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt32)ewg_param_value, (SInt32)ewg_param_minimum, (SInt32)ewg_param_maximum, (SInt32)ewg_param_viewSize, (Boolean)ewg_param_liveTracking, (ControlActionUPP)ewg_param_liveTrackingProc, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateScrollBarControl (WindowRef window, Rect const *boundsRect, SInt32 value, SInt32 minimum, SInt32 maximum, SInt32 viewSize, Boolean liveTracking, ControlActionUPP liveTrackingProc, ControlRef *outControl);
// Wraps call to function 'CreatePopupButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreatePopupButtonControl(ewg_param_window, ewg_param_boundsRect, ewg_param_title, ewg_param_menuID, ewg_param_variableWidth, ewg_param_titleWidth, ewg_param_titleJustification, ewg_param_titleStyle, ewg_param_outControl) CreatePopupButtonControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_title, (SInt16)ewg_param_menuID, (Boolean)ewg_param_variableWidth, (SInt16)ewg_param_titleWidth, (SInt16)ewg_param_titleJustification, (Style)ewg_param_titleStyle, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreatePopupButtonControl (WindowRef window, Rect const *boundsRect, CFStringRef title, SInt16 menuID, Boolean variableWidth, SInt16 titleWidth, SInt16 titleJustification, Style titleStyle, ControlRef *outControl);
// Wraps call to function 'CreateRadioGroupControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateRadioGroupControl(ewg_param_window, ewg_param_boundsRect, ewg_param_outControl) CreateRadioGroupControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateRadioGroupControl (WindowRef window, Rect const *boundsRect, ControlRef *outControl);
// Wraps call to function 'CreateScrollingTextBoxControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateScrollingTextBoxControl(ewg_param_window, ewg_param_boundsRect, ewg_param_contentResID, ewg_param_autoScroll, ewg_param_delayBeforeAutoScroll, ewg_param_delayBetweenAutoScroll, ewg_param_autoScrollAmount, ewg_param_outControl) CreateScrollingTextBoxControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (SInt16)ewg_param_contentResID, (Boolean)ewg_param_autoScroll, (UInt32)ewg_param_delayBeforeAutoScroll, (UInt32)ewg_param_delayBetweenAutoScroll, (UInt16)ewg_param_autoScrollAmount, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateScrollingTextBoxControl (WindowRef window, Rect const *boundsRect, SInt16 contentResID, Boolean autoScroll, UInt32 delayBeforeAutoScroll, UInt32 delayBetweenAutoScroll, UInt16 autoScrollAmount, ControlRef *outControl);
// Wraps call to function 'CreateDisclosureButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateDisclosureButtonControl(ewg_param_inWindow, ewg_param_inBoundsRect, ewg_param_inValue, ewg_param_inAutoToggles, ewg_param_outControl) CreateDisclosureButtonControl ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inBoundsRect, (SInt32)ewg_param_inValue, (Boolean)ewg_param_inAutoToggles, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateDisclosureButtonControl (WindowRef inWindow, Rect const *inBoundsRect, SInt32 inValue, Boolean inAutoToggles, ControlRef *outControl);
// Wraps call to function 'CreateRoundButtonControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateRoundButtonControl(ewg_param_inWindow, ewg_param_inBoundsRect, ewg_param_inSize, ewg_param_inContent, ewg_param_outControl) CreateRoundButtonControl ((WindowRef)ewg_param_inWindow, (Rect const*)ewg_param_inBoundsRect, (ControlRoundButtonSize)ewg_param_inSize, (ControlButtonContentInfo*)ewg_param_inContent, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateRoundButtonControl (WindowRef inWindow, Rect const *inBoundsRect, ControlRoundButtonSize inSize, ControlButtonContentInfo *inContent, ControlRef *outControl);
// Wraps call to function 'NewDataBrowserItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemUPP(ewg_param_userRoutine) NewDataBrowserItemUPP ((DataBrowserItemProcPtr)ewg_param_userRoutine)

DataBrowserItemUPP  ewg_function_NewDataBrowserItemUPP (DataBrowserItemProcPtr userRoutine);
// Wraps call to function 'DisposeDataBrowserItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemUPP(ewg_param_userUPP) DisposeDataBrowserItemUPP ((DataBrowserItemUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemUPP (DataBrowserItemUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemUPP(ewg_param_item, ewg_param_state, ewg_param_clientData, ewg_param_userUPP) InvokeDataBrowserItemUPP ((DataBrowserItemID)ewg_param_item, (DataBrowserItemState)ewg_param_state, (void*)ewg_param_clientData, (DataBrowserItemUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserItemUPP (DataBrowserItemID item, DataBrowserItemState state, void *clientData, DataBrowserItemUPP userUPP);
// Wraps call to function 'CreateDataBrowserControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateDataBrowserControl(ewg_param_window, ewg_param_boundsRect, ewg_param_style, ewg_param_outControl) CreateDataBrowserControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (DataBrowserViewStyle)ewg_param_style, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateDataBrowserControl (WindowRef window, Rect const *boundsRect, DataBrowserViewStyle style, ControlRef *outControl);
// Wraps call to function 'GetDataBrowserViewStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserViewStyle(ewg_param_browser, ewg_param_style) GetDataBrowserViewStyle ((ControlRef)ewg_param_browser, (DataBrowserViewStyle*)ewg_param_style)

OSStatus  ewg_function_GetDataBrowserViewStyle (ControlRef browser, DataBrowserViewStyle *style);
// Wraps call to function 'SetDataBrowserViewStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserViewStyle(ewg_param_browser, ewg_param_style) SetDataBrowserViewStyle ((ControlRef)ewg_param_browser, (DataBrowserViewStyle)ewg_param_style)

OSStatus  ewg_function_SetDataBrowserViewStyle (ControlRef browser, DataBrowserViewStyle style);
// Wraps call to function 'DataBrowserChangeAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DataBrowserChangeAttributes(ewg_param_inDataBrowser, ewg_param_inAttributesToSet, ewg_param_inAttributesToClear) DataBrowserChangeAttributes ((ControlRef)ewg_param_inDataBrowser, (OptionBits)ewg_param_inAttributesToSet, (OptionBits)ewg_param_inAttributesToClear)

OSStatus  ewg_function_DataBrowserChangeAttributes (ControlRef inDataBrowser, OptionBits inAttributesToSet, OptionBits inAttributesToClear);
// Wraps call to function 'DataBrowserGetAttributes' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DataBrowserGetAttributes(ewg_param_inDataBrowser, ewg_param_outAttributes) DataBrowserGetAttributes ((ControlRef)ewg_param_inDataBrowser, (OptionBits*)ewg_param_outAttributes)

OSStatus  ewg_function_DataBrowserGetAttributes (ControlRef inDataBrowser, OptionBits *outAttributes);
// Wraps call to function 'DataBrowserSetMetric' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DataBrowserSetMetric(ewg_param_inDataBrowser, ewg_param_inMetric, ewg_param_inUseDefaultValue, ewg_param_inValue) DataBrowserSetMetric ((ControlRef)ewg_param_inDataBrowser, (DataBrowserMetric)ewg_param_inMetric, (Boolean)ewg_param_inUseDefaultValue, (float)ewg_param_inValue)

OSStatus  ewg_function_DataBrowserSetMetric (ControlRef inDataBrowser, DataBrowserMetric inMetric, Boolean inUseDefaultValue, float inValue);
// Wraps call to function 'DataBrowserGetMetric' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DataBrowserGetMetric(ewg_param_inDataBrowser, ewg_param_inMetric, ewg_param_outUsingDefaultValue, ewg_param_outValue) DataBrowserGetMetric ((ControlRef)ewg_param_inDataBrowser, (DataBrowserMetric)ewg_param_inMetric, (Boolean*)ewg_param_outUsingDefaultValue, (float*)ewg_param_outValue)

OSStatus  ewg_function_DataBrowserGetMetric (ControlRef inDataBrowser, DataBrowserMetric inMetric, Boolean *outUsingDefaultValue, float *outValue);
// Wraps call to function 'AddDataBrowserItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AddDataBrowserItems(ewg_param_browser, ewg_param_container, ewg_param_numItems, ewg_param_items, ewg_param_preSortProperty) AddDataBrowserItems ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (UInt32)ewg_param_numItems, (DataBrowserItemID const*)ewg_param_items, (DataBrowserPropertyID)ewg_param_preSortProperty)

OSStatus  ewg_function_AddDataBrowserItems (ControlRef browser, DataBrowserItemID container, UInt32 numItems, DataBrowserItemID const *items, DataBrowserPropertyID preSortProperty);
// Wraps call to function 'RemoveDataBrowserItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveDataBrowserItems(ewg_param_browser, ewg_param_container, ewg_param_numItems, ewg_param_items, ewg_param_preSortProperty) RemoveDataBrowserItems ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (UInt32)ewg_param_numItems, (DataBrowserItemID const*)ewg_param_items, (DataBrowserPropertyID)ewg_param_preSortProperty)

OSStatus  ewg_function_RemoveDataBrowserItems (ControlRef browser, DataBrowserItemID container, UInt32 numItems, DataBrowserItemID const *items, DataBrowserPropertyID preSortProperty);
// Wraps call to function 'UpdateDataBrowserItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_UpdateDataBrowserItems(ewg_param_browser, ewg_param_container, ewg_param_numItems, ewg_param_items, ewg_param_preSortProperty, ewg_param_propertyID) UpdateDataBrowserItems ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (UInt32)ewg_param_numItems, (DataBrowserItemID const*)ewg_param_items, (DataBrowserPropertyID)ewg_param_preSortProperty, (DataBrowserPropertyID)ewg_param_propertyID)

OSStatus  ewg_function_UpdateDataBrowserItems (ControlRef browser, DataBrowserItemID container, UInt32 numItems, DataBrowserItemID const *items, DataBrowserPropertyID preSortProperty, DataBrowserPropertyID propertyID);
// Wraps call to function 'EnableDataBrowserEditCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_EnableDataBrowserEditCommand(ewg_param_browser, ewg_param_command) EnableDataBrowserEditCommand ((ControlRef)ewg_param_browser, (DataBrowserEditCommand)ewg_param_command)

Boolean  ewg_function_EnableDataBrowserEditCommand (ControlRef browser, DataBrowserEditCommand command);
// Wraps call to function 'ExecuteDataBrowserEditCommand' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ExecuteDataBrowserEditCommand(ewg_param_browser, ewg_param_command) ExecuteDataBrowserEditCommand ((ControlRef)ewg_param_browser, (DataBrowserEditCommand)ewg_param_command)

OSStatus  ewg_function_ExecuteDataBrowserEditCommand (ControlRef browser, DataBrowserEditCommand command);
// Wraps call to function 'GetDataBrowserSelectionAnchor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserSelectionAnchor(ewg_param_browser, ewg_param_first, ewg_param_last) GetDataBrowserSelectionAnchor ((ControlRef)ewg_param_browser, (DataBrowserItemID*)ewg_param_first, (DataBrowserItemID*)ewg_param_last)

OSStatus  ewg_function_GetDataBrowserSelectionAnchor (ControlRef browser, DataBrowserItemID *first, DataBrowserItemID *last);
// Wraps call to function 'MoveDataBrowserSelectionAnchor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_MoveDataBrowserSelectionAnchor(ewg_param_browser, ewg_param_direction, ewg_param_extendSelection) MoveDataBrowserSelectionAnchor ((ControlRef)ewg_param_browser, (DataBrowserSelectionAnchorDirection)ewg_param_direction, (Boolean)ewg_param_extendSelection)

OSStatus  ewg_function_MoveDataBrowserSelectionAnchor (ControlRef browser, DataBrowserSelectionAnchorDirection direction, Boolean extendSelection);
// Wraps call to function 'OpenDataBrowserContainer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_OpenDataBrowserContainer(ewg_param_browser, ewg_param_container) OpenDataBrowserContainer ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container)

OSStatus  ewg_function_OpenDataBrowserContainer (ControlRef browser, DataBrowserItemID container);
// Wraps call to function 'CloseDataBrowserContainer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CloseDataBrowserContainer(ewg_param_browser, ewg_param_container) CloseDataBrowserContainer ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container)

OSStatus  ewg_function_CloseDataBrowserContainer (ControlRef browser, DataBrowserItemID container);
// Wraps call to function 'SortDataBrowserContainer' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SortDataBrowserContainer(ewg_param_browser, ewg_param_container, ewg_param_sortChildren) SortDataBrowserContainer ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (Boolean)ewg_param_sortChildren)

OSStatus  ewg_function_SortDataBrowserContainer (ControlRef browser, DataBrowserItemID container, Boolean sortChildren);
// Wraps call to function 'GetDataBrowserItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItems(ewg_param_browser, ewg_param_container, ewg_param_recurse, ewg_param_state, ewg_param_items) GetDataBrowserItems ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (Boolean)ewg_param_recurse, (DataBrowserItemState)ewg_param_state, (Handle)ewg_param_items)

OSStatus  ewg_function_GetDataBrowserItems (ControlRef browser, DataBrowserItemID container, Boolean recurse, DataBrowserItemState state, Handle items);
// Wraps call to function 'GetDataBrowserItemCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemCount(ewg_param_browser, ewg_param_container, ewg_param_recurse, ewg_param_state, ewg_param_numItems) GetDataBrowserItemCount ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (Boolean)ewg_param_recurse, (DataBrowserItemState)ewg_param_state, (UInt32*)ewg_param_numItems)

OSStatus  ewg_function_GetDataBrowserItemCount (ControlRef browser, DataBrowserItemID container, Boolean recurse, DataBrowserItemState state, UInt32 *numItems);
// Wraps call to function 'ForEachDataBrowserItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_ForEachDataBrowserItem(ewg_param_browser, ewg_param_container, ewg_param_recurse, ewg_param_state, ewg_param_callback, ewg_param_clientData) ForEachDataBrowserItem ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_container, (Boolean)ewg_param_recurse, (DataBrowserItemState)ewg_param_state, (DataBrowserItemUPP)ewg_param_callback, (void*)ewg_param_clientData)

OSStatus  ewg_function_ForEachDataBrowserItem (ControlRef browser, DataBrowserItemID container, Boolean recurse, DataBrowserItemState state, DataBrowserItemUPP callback, void *clientData);
// Wraps call to function 'IsDataBrowserItemSelected' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_IsDataBrowserItemSelected(ewg_param_browser, ewg_param_item) IsDataBrowserItemSelected ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item)

Boolean  ewg_function_IsDataBrowserItemSelected (ControlRef browser, DataBrowserItemID item);
// Wraps call to function 'GetDataBrowserItemState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemState(ewg_param_browser, ewg_param_item, ewg_param_state) GetDataBrowserItemState ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserItemState*)ewg_param_state)

OSStatus  ewg_function_GetDataBrowserItemState (ControlRef browser, DataBrowserItemID item, DataBrowserItemState *state);
// Wraps call to function 'RevealDataBrowserItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RevealDataBrowserItem(ewg_param_browser, ewg_param_item, ewg_param_propertyID, ewg_param_options) RevealDataBrowserItem ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_propertyID, (DataBrowserRevealOptions)ewg_param_options)

OSStatus  ewg_function_RevealDataBrowserItem (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID propertyID, DataBrowserRevealOptions options);
// Wraps call to function 'SetDataBrowserSelectedItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserSelectedItems(ewg_param_browser, ewg_param_numItems, ewg_param_items, ewg_param_operation) SetDataBrowserSelectedItems ((ControlRef)ewg_param_browser, (UInt32)ewg_param_numItems, (DataBrowserItemID const*)ewg_param_items, (DataBrowserSetOption)ewg_param_operation)

OSStatus  ewg_function_SetDataBrowserSelectedItems (ControlRef browser, UInt32 numItems, DataBrowserItemID const *items, DataBrowserSetOption operation);
// Wraps call to function 'SetDataBrowserUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserUserState(ewg_param_browser, ewg_param_stateInfo) SetDataBrowserUserState ((ControlRef)ewg_param_browser, (CFDictionaryRef)ewg_param_stateInfo)

OSStatus  ewg_function_SetDataBrowserUserState (ControlRef browser, CFDictionaryRef stateInfo);
// Wraps call to function 'GetDataBrowserUserState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserUserState(ewg_param_browser, ewg_param_stateInfo) GetDataBrowserUserState ((ControlRef)ewg_param_browser, (CFDictionaryRef*)ewg_param_stateInfo)

OSStatus  ewg_function_GetDataBrowserUserState (ControlRef browser, CFDictionaryRef *stateInfo);
// Wraps call to function 'SetDataBrowserActiveItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserActiveItems(ewg_param_browser, ewg_param_active) SetDataBrowserActiveItems ((ControlRef)ewg_param_browser, (Boolean)ewg_param_active)

OSStatus  ewg_function_SetDataBrowserActiveItems (ControlRef browser, Boolean active);
// Wraps call to function 'GetDataBrowserActiveItems' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserActiveItems(ewg_param_browser, ewg_param_active) GetDataBrowserActiveItems ((ControlRef)ewg_param_browser, (Boolean*)ewg_param_active)

OSStatus  ewg_function_GetDataBrowserActiveItems (ControlRef browser, Boolean *active);
// Wraps call to function 'SetDataBrowserScrollBarInset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserScrollBarInset(ewg_param_browser, ewg_param_insetRect) SetDataBrowserScrollBarInset ((ControlRef)ewg_param_browser, (Rect*)ewg_param_insetRect)

OSStatus  ewg_function_SetDataBrowserScrollBarInset (ControlRef browser, Rect *insetRect);
// Wraps call to function 'GetDataBrowserScrollBarInset' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserScrollBarInset(ewg_param_browser, ewg_param_insetRect) GetDataBrowserScrollBarInset ((ControlRef)ewg_param_browser, (Rect*)ewg_param_insetRect)

OSStatus  ewg_function_GetDataBrowserScrollBarInset (ControlRef browser, Rect *insetRect);
// Wraps call to function 'SetDataBrowserTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTarget(ewg_param_browser, ewg_param_target) SetDataBrowserTarget ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_target)

OSStatus  ewg_function_SetDataBrowserTarget (ControlRef browser, DataBrowserItemID target);
// Wraps call to function 'GetDataBrowserTarget' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTarget(ewg_param_browser, ewg_param_target) GetDataBrowserTarget ((ControlRef)ewg_param_browser, (DataBrowserItemID*)ewg_param_target)

OSStatus  ewg_function_GetDataBrowserTarget (ControlRef browser, DataBrowserItemID *target);
// Wraps call to function 'SetDataBrowserSortOrder' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserSortOrder(ewg_param_browser, ewg_param_order) SetDataBrowserSortOrder ((ControlRef)ewg_param_browser, (DataBrowserSortOrder)ewg_param_order)

OSStatus  ewg_function_SetDataBrowserSortOrder (ControlRef browser, DataBrowserSortOrder order);
// Wraps call to function 'GetDataBrowserSortOrder' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserSortOrder(ewg_param_browser, ewg_param_order) GetDataBrowserSortOrder ((ControlRef)ewg_param_browser, (DataBrowserSortOrder*)ewg_param_order)

OSStatus  ewg_function_GetDataBrowserSortOrder (ControlRef browser, DataBrowserSortOrder *order);
// Wraps call to function 'SetDataBrowserScrollPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserScrollPosition(ewg_param_browser, ewg_param_top, ewg_param_left) SetDataBrowserScrollPosition ((ControlRef)ewg_param_browser, (UInt32)ewg_param_top, (UInt32)ewg_param_left)

OSStatus  ewg_function_SetDataBrowserScrollPosition (ControlRef browser, UInt32 top, UInt32 left);
// Wraps call to function 'GetDataBrowserScrollPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserScrollPosition(ewg_param_browser, ewg_param_top, ewg_param_left) GetDataBrowserScrollPosition ((ControlRef)ewg_param_browser, (UInt32*)ewg_param_top, (UInt32*)ewg_param_left)

OSStatus  ewg_function_GetDataBrowserScrollPosition (ControlRef browser, UInt32 *top, UInt32 *left);
// Wraps call to function 'SetDataBrowserHasScrollBars' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserHasScrollBars(ewg_param_browser, ewg_param_horiz, ewg_param_vert) SetDataBrowserHasScrollBars ((ControlRef)ewg_param_browser, (Boolean)ewg_param_horiz, (Boolean)ewg_param_vert)

OSStatus  ewg_function_SetDataBrowserHasScrollBars (ControlRef browser, Boolean horiz, Boolean vert);
// Wraps call to function 'GetDataBrowserHasScrollBars' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserHasScrollBars(ewg_param_browser, ewg_param_horiz, ewg_param_vert) GetDataBrowserHasScrollBars ((ControlRef)ewg_param_browser, (Boolean*)ewg_param_horiz, (Boolean*)ewg_param_vert)

OSStatus  ewg_function_GetDataBrowserHasScrollBars (ControlRef browser, Boolean *horiz, Boolean *vert);
// Wraps call to function 'SetDataBrowserSortProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserSortProperty(ewg_param_browser, ewg_param_property) SetDataBrowserSortProperty ((ControlRef)ewg_param_browser, (DataBrowserPropertyID)ewg_param_property)

OSStatus  ewg_function_SetDataBrowserSortProperty (ControlRef browser, DataBrowserPropertyID property);
// Wraps call to function 'GetDataBrowserSortProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserSortProperty(ewg_param_browser, ewg_param_property) GetDataBrowserSortProperty ((ControlRef)ewg_param_browser, (DataBrowserPropertyID*)ewg_param_property)

OSStatus  ewg_function_GetDataBrowserSortProperty (ControlRef browser, DataBrowserPropertyID *property);
// Wraps call to function 'SetDataBrowserSelectionFlags' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserSelectionFlags(ewg_param_browser, ewg_param_selectionFlags) SetDataBrowserSelectionFlags ((ControlRef)ewg_param_browser, (DataBrowserSelectionFlags)ewg_param_selectionFlags)

OSStatus  ewg_function_SetDataBrowserSelectionFlags (ControlRef browser, DataBrowserSelectionFlags selectionFlags);
// Wraps call to function 'GetDataBrowserSelectionFlags' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserSelectionFlags(ewg_param_browser, ewg_param_selectionFlags) GetDataBrowserSelectionFlags ((ControlRef)ewg_param_browser, (DataBrowserSelectionFlags*)ewg_param_selectionFlags)

OSStatus  ewg_function_GetDataBrowserSelectionFlags (ControlRef browser, DataBrowserSelectionFlags *selectionFlags);
// Wraps call to function 'SetDataBrowserPropertyFlags' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserPropertyFlags(ewg_param_browser, ewg_param_property, ewg_param_flags) SetDataBrowserPropertyFlags ((ControlRef)ewg_param_browser, (DataBrowserPropertyID)ewg_param_property, (DataBrowserPropertyFlags)ewg_param_flags)

OSStatus  ewg_function_SetDataBrowserPropertyFlags (ControlRef browser, DataBrowserPropertyID property, DataBrowserPropertyFlags flags);
// Wraps call to function 'GetDataBrowserPropertyFlags' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserPropertyFlags(ewg_param_browser, ewg_param_property, ewg_param_flags) GetDataBrowserPropertyFlags ((ControlRef)ewg_param_browser, (DataBrowserPropertyID)ewg_param_property, (DataBrowserPropertyFlags*)ewg_param_flags)

OSStatus  ewg_function_GetDataBrowserPropertyFlags (ControlRef browser, DataBrowserPropertyID property, DataBrowserPropertyFlags *flags);
// Wraps call to function 'SetDataBrowserEditText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserEditText(ewg_param_browser, ewg_param_text) SetDataBrowserEditText ((ControlRef)ewg_param_browser, (CFStringRef)ewg_param_text)

OSStatus  ewg_function_SetDataBrowserEditText (ControlRef browser, CFStringRef text);
// Wraps call to function 'CopyDataBrowserEditText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CopyDataBrowserEditText(ewg_param_browser, ewg_param_text) CopyDataBrowserEditText ((ControlRef)ewg_param_browser, (CFStringRef*)ewg_param_text)

OSStatus  ewg_function_CopyDataBrowserEditText (ControlRef browser, CFStringRef *text);
// Wraps call to function 'GetDataBrowserEditText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserEditText(ewg_param_browser, ewg_param_text) GetDataBrowserEditText ((ControlRef)ewg_param_browser, (CFMutableStringRef)ewg_param_text)

OSStatus  ewg_function_GetDataBrowserEditText (ControlRef browser, CFMutableStringRef text);
// Wraps call to function 'SetDataBrowserEditItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserEditItem(ewg_param_browser, ewg_param_item, ewg_param_property) SetDataBrowserEditItem ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property)

OSStatus  ewg_function_SetDataBrowserEditItem (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property);
// Wraps call to function 'GetDataBrowserEditItem' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserEditItem(ewg_param_browser, ewg_param_item, ewg_param_property) GetDataBrowserEditItem ((ControlRef)ewg_param_browser, (DataBrowserItemID*)ewg_param_item, (DataBrowserPropertyID*)ewg_param_property)

OSStatus  ewg_function_GetDataBrowserEditItem (ControlRef browser, DataBrowserItemID *item, DataBrowserPropertyID *property);
// Wraps call to function 'GetDataBrowserItemPartBounds' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemPartBounds(ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_part, ewg_param_bounds) GetDataBrowserItemPartBounds ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (DataBrowserPropertyPart)ewg_param_part, (Rect*)ewg_param_bounds)

OSStatus  ewg_function_GetDataBrowserItemPartBounds (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserPropertyPart part, Rect *bounds);
// Wraps call to function 'SetDataBrowserItemDataIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataIcon(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataIcon ((DataBrowserItemDataRef)ewg_param_itemData, (IconRef)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataIcon (DataBrowserItemDataRef itemData, IconRef theData);
// Wraps call to function 'GetDataBrowserItemDataIcon' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataIcon(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataIcon ((DataBrowserItemDataRef)ewg_param_itemData, (IconRef*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataIcon (DataBrowserItemDataRef itemData, IconRef *theData);
// Wraps call to function 'SetDataBrowserItemDataText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataText(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataText ((DataBrowserItemDataRef)ewg_param_itemData, (CFStringRef)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataText (DataBrowserItemDataRef itemData, CFStringRef theData);
// Wraps call to function 'GetDataBrowserItemDataText' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataText(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataText ((DataBrowserItemDataRef)ewg_param_itemData, (CFStringRef*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataText (DataBrowserItemDataRef itemData, CFStringRef *theData);
// Wraps call to function 'SetDataBrowserItemDataValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataValue(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataValue ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataValue (DataBrowserItemDataRef itemData, SInt32 theData);
// Wraps call to function 'GetDataBrowserItemDataValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataValue(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataValue ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataValue (DataBrowserItemDataRef itemData, SInt32 *theData);
// Wraps call to function 'SetDataBrowserItemDataMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataMinimum(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataMinimum ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataMinimum (DataBrowserItemDataRef itemData, SInt32 theData);
// Wraps call to function 'GetDataBrowserItemDataMinimum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataMinimum(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataMinimum ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataMinimum (DataBrowserItemDataRef itemData, SInt32 *theData);
// Wraps call to function 'SetDataBrowserItemDataMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataMaximum(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataMaximum ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataMaximum (DataBrowserItemDataRef itemData, SInt32 theData);
// Wraps call to function 'GetDataBrowserItemDataMaximum' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataMaximum(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataMaximum ((DataBrowserItemDataRef)ewg_param_itemData, (SInt32*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataMaximum (DataBrowserItemDataRef itemData, SInt32 *theData);
// Wraps call to function 'SetDataBrowserItemDataBooleanValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataBooleanValue(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataBooleanValue ((DataBrowserItemDataRef)ewg_param_itemData, (Boolean)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataBooleanValue (DataBrowserItemDataRef itemData, Boolean theData);
// Wraps call to function 'GetDataBrowserItemDataBooleanValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataBooleanValue(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataBooleanValue ((DataBrowserItemDataRef)ewg_param_itemData, (Boolean*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataBooleanValue (DataBrowserItemDataRef itemData, Boolean *theData);
// Wraps call to function 'SetDataBrowserItemDataMenuRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataMenuRef(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataMenuRef ((DataBrowserItemDataRef)ewg_param_itemData, (MenuRef)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataMenuRef (DataBrowserItemDataRef itemData, MenuRef theData);
// Wraps call to function 'GetDataBrowserItemDataMenuRef' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataMenuRef(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataMenuRef ((DataBrowserItemDataRef)ewg_param_itemData, (MenuRef*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataMenuRef (DataBrowserItemDataRef itemData, MenuRef *theData);
// Wraps call to function 'SetDataBrowserItemDataRGBColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataRGBColor(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataRGBColor ((DataBrowserItemDataRef)ewg_param_itemData, (RGBColor const*)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataRGBColor (DataBrowserItemDataRef itemData, RGBColor const *theData);
// Wraps call to function 'GetDataBrowserItemDataRGBColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataRGBColor(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataRGBColor ((DataBrowserItemDataRef)ewg_param_itemData, (RGBColor*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataRGBColor (DataBrowserItemDataRef itemData, RGBColor *theData);
// Wraps call to function 'SetDataBrowserItemDataDrawState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataDrawState(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataDrawState ((DataBrowserItemDataRef)ewg_param_itemData, (ThemeDrawState)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataDrawState (DataBrowserItemDataRef itemData, ThemeDrawState theData);
// Wraps call to function 'GetDataBrowserItemDataDrawState' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataDrawState(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataDrawState ((DataBrowserItemDataRef)ewg_param_itemData, (ThemeDrawState*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataDrawState (DataBrowserItemDataRef itemData, ThemeDrawState *theData);
// Wraps call to function 'SetDataBrowserItemDataButtonValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataButtonValue(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataButtonValue ((DataBrowserItemDataRef)ewg_param_itemData, (ThemeButtonValue)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataButtonValue (DataBrowserItemDataRef itemData, ThemeButtonValue theData);
// Wraps call to function 'GetDataBrowserItemDataButtonValue' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataButtonValue(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataButtonValue ((DataBrowserItemDataRef)ewg_param_itemData, (ThemeButtonValue*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataButtonValue (DataBrowserItemDataRef itemData, ThemeButtonValue *theData);
// Wraps call to function 'SetDataBrowserItemDataIconTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataIconTransform(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataIconTransform ((DataBrowserItemDataRef)ewg_param_itemData, (IconTransformType)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataIconTransform (DataBrowserItemDataRef itemData, IconTransformType theData);
// Wraps call to function 'GetDataBrowserItemDataIconTransform' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataIconTransform(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataIconTransform ((DataBrowserItemDataRef)ewg_param_itemData, (IconTransformType*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataIconTransform (DataBrowserItemDataRef itemData, IconTransformType *theData);
// Wraps call to function 'SetDataBrowserItemDataDateTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataDateTime(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataDateTime ((DataBrowserItemDataRef)ewg_param_itemData, (long)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataDateTime (DataBrowserItemDataRef itemData, long theData);
// Wraps call to function 'GetDataBrowserItemDataDateTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataDateTime(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataDateTime ((DataBrowserItemDataRef)ewg_param_itemData, (long*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataDateTime (DataBrowserItemDataRef itemData, long *theData);
// Wraps call to function 'SetDataBrowserItemDataLongDateTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataLongDateTime(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataLongDateTime ((DataBrowserItemDataRef)ewg_param_itemData, (LongDateTime const*)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataLongDateTime (DataBrowserItemDataRef itemData, LongDateTime const *theData);
// Wraps call to function 'GetDataBrowserItemDataLongDateTime' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataLongDateTime(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataLongDateTime ((DataBrowserItemDataRef)ewg_param_itemData, (LongDateTime*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataLongDateTime (DataBrowserItemDataRef itemData, LongDateTime *theData);
// Wraps call to function 'SetDataBrowserItemDataItemID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserItemDataItemID(ewg_param_itemData, ewg_param_theData) SetDataBrowserItemDataItemID ((DataBrowserItemDataRef)ewg_param_itemData, (DataBrowserItemID)ewg_param_theData)

OSStatus  ewg_function_SetDataBrowserItemDataItemID (DataBrowserItemDataRef itemData, DataBrowserItemID theData);
// Wraps call to function 'GetDataBrowserItemDataItemID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataItemID(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataItemID ((DataBrowserItemDataRef)ewg_param_itemData, (DataBrowserItemID*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataItemID (DataBrowserItemDataRef itemData, DataBrowserItemID *theData);
// Wraps call to function 'GetDataBrowserItemDataProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserItemDataProperty(ewg_param_itemData, ewg_param_theData) GetDataBrowserItemDataProperty ((DataBrowserItemDataRef)ewg_param_itemData, (DataBrowserPropertyID*)ewg_param_theData)

OSStatus  ewg_function_GetDataBrowserItemDataProperty (DataBrowserItemDataRef itemData, DataBrowserPropertyID *theData);
// Wraps call to function 'NewDataBrowserItemDataUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemDataUPP(ewg_param_userRoutine) NewDataBrowserItemDataUPP ((DataBrowserItemDataProcPtr)ewg_param_userRoutine)

DataBrowserItemDataUPP  ewg_function_NewDataBrowserItemDataUPP (DataBrowserItemDataProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemCompareUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemCompareUPP(ewg_param_userRoutine) NewDataBrowserItemCompareUPP ((DataBrowserItemCompareProcPtr)ewg_param_userRoutine)

DataBrowserItemCompareUPP  ewg_function_NewDataBrowserItemCompareUPP (DataBrowserItemCompareProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemNotificationWithItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemNotificationWithItemUPP(ewg_param_userRoutine) NewDataBrowserItemNotificationWithItemUPP ((DataBrowserItemNotificationWithItemProcPtr)ewg_param_userRoutine)

DataBrowserItemNotificationWithItemUPP  ewg_function_NewDataBrowserItemNotificationWithItemUPP (DataBrowserItemNotificationWithItemProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemNotificationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemNotificationUPP(ewg_param_userRoutine) NewDataBrowserItemNotificationUPP ((DataBrowserItemNotificationProcPtr)ewg_param_userRoutine)

DataBrowserItemNotificationUPP  ewg_function_NewDataBrowserItemNotificationUPP (DataBrowserItemNotificationProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserAddDragItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserAddDragItemUPP(ewg_param_userRoutine) NewDataBrowserAddDragItemUPP ((DataBrowserAddDragItemProcPtr)ewg_param_userRoutine)

DataBrowserAddDragItemUPP  ewg_function_NewDataBrowserAddDragItemUPP (DataBrowserAddDragItemProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserAcceptDragUPP(ewg_param_userRoutine) NewDataBrowserAcceptDragUPP ((DataBrowserAcceptDragProcPtr)ewg_param_userRoutine)

DataBrowserAcceptDragUPP  ewg_function_NewDataBrowserAcceptDragUPP (DataBrowserAcceptDragProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserReceiveDragUPP(ewg_param_userRoutine) NewDataBrowserReceiveDragUPP ((DataBrowserReceiveDragProcPtr)ewg_param_userRoutine)

DataBrowserReceiveDragUPP  ewg_function_NewDataBrowserReceiveDragUPP (DataBrowserReceiveDragProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserPostProcessDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserPostProcessDragUPP(ewg_param_userRoutine) NewDataBrowserPostProcessDragUPP ((DataBrowserPostProcessDragProcPtr)ewg_param_userRoutine)

DataBrowserPostProcessDragUPP  ewg_function_NewDataBrowserPostProcessDragUPP (DataBrowserPostProcessDragProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserGetContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserGetContextualMenuUPP(ewg_param_userRoutine) NewDataBrowserGetContextualMenuUPP ((DataBrowserGetContextualMenuProcPtr)ewg_param_userRoutine)

DataBrowserGetContextualMenuUPP  ewg_function_NewDataBrowserGetContextualMenuUPP (DataBrowserGetContextualMenuProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserSelectContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserSelectContextualMenuUPP(ewg_param_userRoutine) NewDataBrowserSelectContextualMenuUPP ((DataBrowserSelectContextualMenuProcPtr)ewg_param_userRoutine)

DataBrowserSelectContextualMenuUPP  ewg_function_NewDataBrowserSelectContextualMenuUPP (DataBrowserSelectContextualMenuProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemHelpContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemHelpContentUPP(ewg_param_userRoutine) NewDataBrowserItemHelpContentUPP ((DataBrowserItemHelpContentProcPtr)ewg_param_userRoutine)

DataBrowserItemHelpContentUPP  ewg_function_NewDataBrowserItemHelpContentUPP (DataBrowserItemHelpContentProcPtr userRoutine);
// Wraps call to function 'DisposeDataBrowserItemDataUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemDataUPP(ewg_param_userUPP) DisposeDataBrowserItemDataUPP ((DataBrowserItemDataUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemDataUPP (DataBrowserItemDataUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemCompareUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemCompareUPP(ewg_param_userUPP) DisposeDataBrowserItemCompareUPP ((DataBrowserItemCompareUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemCompareUPP (DataBrowserItemCompareUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemNotificationWithItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemNotificationWithItemUPP(ewg_param_userUPP) DisposeDataBrowserItemNotificationWithItemUPP ((DataBrowserItemNotificationWithItemUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemNotificationWithItemUPP (DataBrowserItemNotificationWithItemUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemNotificationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemNotificationUPP(ewg_param_userUPP) DisposeDataBrowserItemNotificationUPP ((DataBrowserItemNotificationUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemNotificationUPP (DataBrowserItemNotificationUPP userUPP);
// Wraps call to function 'DisposeDataBrowserAddDragItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserAddDragItemUPP(ewg_param_userUPP) DisposeDataBrowserAddDragItemUPP ((DataBrowserAddDragItemUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserAddDragItemUPP (DataBrowserAddDragItemUPP userUPP);
// Wraps call to function 'DisposeDataBrowserAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserAcceptDragUPP(ewg_param_userUPP) DisposeDataBrowserAcceptDragUPP ((DataBrowserAcceptDragUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserAcceptDragUPP (DataBrowserAcceptDragUPP userUPP);
// Wraps call to function 'DisposeDataBrowserReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserReceiveDragUPP(ewg_param_userUPP) DisposeDataBrowserReceiveDragUPP ((DataBrowserReceiveDragUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserReceiveDragUPP (DataBrowserReceiveDragUPP userUPP);
// Wraps call to function 'DisposeDataBrowserPostProcessDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserPostProcessDragUPP(ewg_param_userUPP) DisposeDataBrowserPostProcessDragUPP ((DataBrowserPostProcessDragUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserPostProcessDragUPP (DataBrowserPostProcessDragUPP userUPP);
// Wraps call to function 'DisposeDataBrowserGetContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserGetContextualMenuUPP(ewg_param_userUPP) DisposeDataBrowserGetContextualMenuUPP ((DataBrowserGetContextualMenuUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserGetContextualMenuUPP (DataBrowserGetContextualMenuUPP userUPP);
// Wraps call to function 'DisposeDataBrowserSelectContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserSelectContextualMenuUPP(ewg_param_userUPP) DisposeDataBrowserSelectContextualMenuUPP ((DataBrowserSelectContextualMenuUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserSelectContextualMenuUPP (DataBrowserSelectContextualMenuUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemHelpContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemHelpContentUPP(ewg_param_userUPP) DisposeDataBrowserItemHelpContentUPP ((DataBrowserItemHelpContentUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemHelpContentUPP (DataBrowserItemHelpContentUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemDataUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemDataUPP(ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_itemData, ewg_param_setValue, ewg_param_userUPP) InvokeDataBrowserItemDataUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (DataBrowserItemDataRef)ewg_param_itemData, (Boolean)ewg_param_setValue, (DataBrowserItemDataUPP)ewg_param_userUPP)

OSStatus  ewg_function_InvokeDataBrowserItemDataUPP (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemDataRef itemData, Boolean setValue, DataBrowserItemDataUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemCompareUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemCompareUPP(ewg_param_browser, ewg_param_itemOne, ewg_param_itemTwo, ewg_param_sortProperty, ewg_param_userUPP) InvokeDataBrowserItemCompareUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemOne, (DataBrowserItemID)ewg_param_itemTwo, (DataBrowserPropertyID)ewg_param_sortProperty, (DataBrowserItemCompareUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserItemCompareUPP (ControlRef browser, DataBrowserItemID itemOne, DataBrowserItemID itemTwo, DataBrowserPropertyID sortProperty, DataBrowserItemCompareUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemNotificationWithItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemNotificationWithItemUPP(ewg_param_browser, ewg_param_item, ewg_param_message, ewg_param_itemData, ewg_param_userUPP) InvokeDataBrowserItemNotificationWithItemUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserItemNotification)ewg_param_message, (DataBrowserItemDataRef)ewg_param_itemData, (DataBrowserItemNotificationWithItemUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserItemNotificationWithItemUPP (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemDataRef itemData, DataBrowserItemNotificationWithItemUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemNotificationUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemNotificationUPP(ewg_param_browser, ewg_param_item, ewg_param_message, ewg_param_userUPP) InvokeDataBrowserItemNotificationUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserItemNotification)ewg_param_message, (DataBrowserItemNotificationUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserItemNotificationUPP (ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemNotificationUPP userUPP);
// Wraps call to function 'InvokeDataBrowserAddDragItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserAddDragItemUPP(ewg_param_browser, ewg_param_theDrag, ewg_param_item, ewg_param_itemRef, ewg_param_userUPP) InvokeDataBrowserAddDragItemUPP ((ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (DataBrowserItemID)ewg_param_item, (ItemReference*)ewg_param_itemRef, (DataBrowserAddDragItemUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserAddDragItemUPP (ControlRef browser, DragReference theDrag, DataBrowserItemID item, ItemReference *itemRef, DataBrowserAddDragItemUPP userUPP);
// Wraps call to function 'InvokeDataBrowserAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserAcceptDragUPP(ewg_param_browser, ewg_param_theDrag, ewg_param_item, ewg_param_userUPP) InvokeDataBrowserAcceptDragUPP ((ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (DataBrowserItemID)ewg_param_item, (DataBrowserAcceptDragUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserAcceptDragUPP (ControlRef browser, DragReference theDrag, DataBrowserItemID item, DataBrowserAcceptDragUPP userUPP);
// Wraps call to function 'InvokeDataBrowserReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserReceiveDragUPP(ewg_param_browser, ewg_param_theDrag, ewg_param_item, ewg_param_userUPP) InvokeDataBrowserReceiveDragUPP ((ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (DataBrowserItemID)ewg_param_item, (DataBrowserReceiveDragUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserReceiveDragUPP (ControlRef browser, DragReference theDrag, DataBrowserItemID item, DataBrowserReceiveDragUPP userUPP);
// Wraps call to function 'InvokeDataBrowserPostProcessDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserPostProcessDragUPP(ewg_param_browser, ewg_param_theDrag, ewg_param_trackDragResult, ewg_param_userUPP) InvokeDataBrowserPostProcessDragUPP ((ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (OSStatus)ewg_param_trackDragResult, (DataBrowserPostProcessDragUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserPostProcessDragUPP (ControlRef browser, DragReference theDrag, OSStatus trackDragResult, DataBrowserPostProcessDragUPP userUPP);
// Wraps call to function 'InvokeDataBrowserGetContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserGetContextualMenuUPP(ewg_param_browser, ewg_param_menu, ewg_param_helpType, ewg_param_helpItemString, ewg_param_selection, ewg_param_userUPP) InvokeDataBrowserGetContextualMenuUPP ((ControlRef)ewg_param_browser, (MenuRef*)ewg_param_menu, (UInt32*)ewg_param_helpType, (CFStringRef*)ewg_param_helpItemString, (AEDesc*)ewg_param_selection, (DataBrowserGetContextualMenuUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserGetContextualMenuUPP (ControlRef browser, MenuRef *menu, UInt32 *helpType, CFStringRef *helpItemString, AEDesc *selection, DataBrowserGetContextualMenuUPP userUPP);
// Wraps call to function 'InvokeDataBrowserSelectContextualMenuUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserSelectContextualMenuUPP(ewg_param_browser, ewg_param_menu, ewg_param_selectionType, ewg_param_menuID, ewg_param_menuItem, ewg_param_userUPP) InvokeDataBrowserSelectContextualMenuUPP ((ControlRef)ewg_param_browser, (MenuRef)ewg_param_menu, (UInt32)ewg_param_selectionType, (SInt16)ewg_param_menuID, (MenuItemIndex)ewg_param_menuItem, (DataBrowserSelectContextualMenuUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserSelectContextualMenuUPP (ControlRef browser, MenuRef menu, UInt32 selectionType, SInt16 menuID, MenuItemIndex menuItem, DataBrowserSelectContextualMenuUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemHelpContentUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemHelpContentUPP(ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent, ewg_param_userUPP) InvokeDataBrowserItemHelpContentUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent, (DataBrowserItemHelpContentUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserItemHelpContentUPP (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent, DataBrowserItemHelpContentUPP userUPP);
// Wraps call to function 'InitDataBrowserCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InitDataBrowserCallbacks(ewg_param_callbacks) InitDataBrowserCallbacks ((DataBrowserCallbacks*)ewg_param_callbacks)

OSStatus  ewg_function_InitDataBrowserCallbacks (DataBrowserCallbacks *callbacks);
// Wraps call to function 'GetDataBrowserCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserCallbacks(ewg_param_browser, ewg_param_callbacks) GetDataBrowserCallbacks ((ControlRef)ewg_param_browser, (DataBrowserCallbacks*)ewg_param_callbacks)

OSStatus  ewg_function_GetDataBrowserCallbacks (ControlRef browser, DataBrowserCallbacks *callbacks);
// Wraps call to function 'SetDataBrowserCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserCallbacks(ewg_param_browser, ewg_param_callbacks) SetDataBrowserCallbacks ((ControlRef)ewg_param_browser, (DataBrowserCallbacks const*)ewg_param_callbacks)

OSStatus  ewg_function_SetDataBrowserCallbacks (ControlRef browser, DataBrowserCallbacks const *callbacks);
// Wraps call to function 'NewDataBrowserDrawItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserDrawItemUPP(ewg_param_userRoutine) NewDataBrowserDrawItemUPP ((DataBrowserDrawItemProcPtr)ewg_param_userRoutine)

DataBrowserDrawItemUPP  ewg_function_NewDataBrowserDrawItemUPP (DataBrowserDrawItemProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserEditItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserEditItemUPP(ewg_param_userRoutine) NewDataBrowserEditItemUPP ((DataBrowserEditItemProcPtr)ewg_param_userRoutine)

DataBrowserEditItemUPP  ewg_function_NewDataBrowserEditItemUPP (DataBrowserEditItemProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserHitTestUPP(ewg_param_userRoutine) NewDataBrowserHitTestUPP ((DataBrowserHitTestProcPtr)ewg_param_userRoutine)

DataBrowserHitTestUPP  ewg_function_NewDataBrowserHitTestUPP (DataBrowserHitTestProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserTrackingUPP(ewg_param_userRoutine) NewDataBrowserTrackingUPP ((DataBrowserTrackingProcPtr)ewg_param_userRoutine)

DataBrowserTrackingUPP  ewg_function_NewDataBrowserTrackingUPP (DataBrowserTrackingProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemDragRgnUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemDragRgnUPP(ewg_param_userRoutine) NewDataBrowserItemDragRgnUPP ((DataBrowserItemDragRgnProcPtr)ewg_param_userRoutine)

DataBrowserItemDragRgnUPP  ewg_function_NewDataBrowserItemDragRgnUPP (DataBrowserItemDragRgnProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemAcceptDragUPP(ewg_param_userRoutine) NewDataBrowserItemAcceptDragUPP ((DataBrowserItemAcceptDragProcPtr)ewg_param_userRoutine)

DataBrowserItemAcceptDragUPP  ewg_function_NewDataBrowserItemAcceptDragUPP (DataBrowserItemAcceptDragProcPtr userRoutine);
// Wraps call to function 'NewDataBrowserItemReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewDataBrowserItemReceiveDragUPP(ewg_param_userRoutine) NewDataBrowserItemReceiveDragUPP ((DataBrowserItemReceiveDragProcPtr)ewg_param_userRoutine)

DataBrowserItemReceiveDragUPP  ewg_function_NewDataBrowserItemReceiveDragUPP (DataBrowserItemReceiveDragProcPtr userRoutine);
// Wraps call to function 'DisposeDataBrowserDrawItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserDrawItemUPP(ewg_param_userUPP) DisposeDataBrowserDrawItemUPP ((DataBrowserDrawItemUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserDrawItemUPP (DataBrowserDrawItemUPP userUPP);
// Wraps call to function 'DisposeDataBrowserEditItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserEditItemUPP(ewg_param_userUPP) DisposeDataBrowserEditItemUPP ((DataBrowserEditItemUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserEditItemUPP (DataBrowserEditItemUPP userUPP);
// Wraps call to function 'DisposeDataBrowserHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserHitTestUPP(ewg_param_userUPP) DisposeDataBrowserHitTestUPP ((DataBrowserHitTestUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserHitTestUPP (DataBrowserHitTestUPP userUPP);
// Wraps call to function 'DisposeDataBrowserTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserTrackingUPP(ewg_param_userUPP) DisposeDataBrowserTrackingUPP ((DataBrowserTrackingUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserTrackingUPP (DataBrowserTrackingUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemDragRgnUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemDragRgnUPP(ewg_param_userUPP) DisposeDataBrowserItemDragRgnUPP ((DataBrowserItemDragRgnUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemDragRgnUPP (DataBrowserItemDragRgnUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemAcceptDragUPP(ewg_param_userUPP) DisposeDataBrowserItemAcceptDragUPP ((DataBrowserItemAcceptDragUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemAcceptDragUPP (DataBrowserItemAcceptDragUPP userUPP);
// Wraps call to function 'DisposeDataBrowserItemReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeDataBrowserItemReceiveDragUPP(ewg_param_userUPP) DisposeDataBrowserItemReceiveDragUPP ((DataBrowserItemReceiveDragUPP)ewg_param_userUPP)

void  ewg_function_DisposeDataBrowserItemReceiveDragUPP (DataBrowserItemReceiveDragUPP userUPP);
// Wraps call to function 'InvokeDataBrowserDrawItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserDrawItemUPP(ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_itemState, ewg_param_theRect, ewg_param_gdDepth, ewg_param_colorDevice, ewg_param_userUPP) InvokeDataBrowserDrawItemUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (DataBrowserItemState)ewg_param_itemState, (Rect const*)ewg_param_theRect, (SInt16)ewg_param_gdDepth, (Boolean)ewg_param_colorDevice, (DataBrowserDrawItemUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserDrawItemUPP (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemState itemState, Rect const *theRect, SInt16 gdDepth, Boolean colorDevice, DataBrowserDrawItemUPP userUPP);
// Wraps call to function 'InvokeDataBrowserEditItemUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserEditItemUPP(ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_theString, ewg_param_maxEditTextRect, ewg_param_shrinkToFit, ewg_param_userUPP) InvokeDataBrowserEditItemUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (CFStringRef)ewg_param_theString, (Rect*)ewg_param_maxEditTextRect, (Boolean*)ewg_param_shrinkToFit, (DataBrowserEditItemUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserEditItemUPP (ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, CFStringRef theString, Rect *maxEditTextRect, Boolean *shrinkToFit, DataBrowserEditItemUPP userUPP);
// Wraps call to function 'InvokeDataBrowserHitTestUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserHitTestUPP(ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_mouseRect, ewg_param_userUPP) InvokeDataBrowserHitTestUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (Rect const*)ewg_param_mouseRect, (DataBrowserHitTestUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserHitTestUPP (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Rect const *mouseRect, DataBrowserHitTestUPP userUPP);
// Wraps call to function 'InvokeDataBrowserTrackingUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserTrackingUPP(ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_startPt, ewg_param_modifiers, ewg_param_userUPP) InvokeDataBrowserTrackingUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, *(Point*)ewg_param_startPt, (EventModifiers)ewg_param_modifiers, (DataBrowserTrackingUPP)ewg_param_userUPP)

DataBrowserTrackingResult  ewg_function_InvokeDataBrowserTrackingUPP (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Point *startPt, EventModifiers modifiers, DataBrowserTrackingUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemDragRgnUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemDragRgnUPP(ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_dragRgn, ewg_param_userUPP) InvokeDataBrowserItemDragRgnUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (RgnHandle)ewg_param_dragRgn, (DataBrowserItemDragRgnUPP)ewg_param_userUPP)

void  ewg_function_InvokeDataBrowserItemDragRgnUPP (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, RgnHandle dragRgn, DataBrowserItemDragRgnUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemAcceptDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemAcceptDragUPP(ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_theDrag, ewg_param_userUPP) InvokeDataBrowserItemAcceptDragUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (DragReference)ewg_param_theDrag, (DataBrowserItemAcceptDragUPP)ewg_param_userUPP)

DataBrowserDragFlags  ewg_function_InvokeDataBrowserItemAcceptDragUPP (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, DragReference theDrag, DataBrowserItemAcceptDragUPP userUPP);
// Wraps call to function 'InvokeDataBrowserItemReceiveDragUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeDataBrowserItemReceiveDragUPP(ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_dragFlags, ewg_param_theDrag, ewg_param_userUPP) InvokeDataBrowserItemReceiveDragUPP ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (DataBrowserDragFlags)ewg_param_dragFlags, (DragReference)ewg_param_theDrag, (DataBrowserItemReceiveDragUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeDataBrowserItemReceiveDragUPP (ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, DataBrowserDragFlags dragFlags, DragReference theDrag, DataBrowserItemReceiveDragUPP userUPP);
// Wraps call to function 'InitDataBrowserCustomCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InitDataBrowserCustomCallbacks(ewg_param_callbacks) InitDataBrowserCustomCallbacks ((DataBrowserCustomCallbacks*)ewg_param_callbacks)

OSStatus  ewg_function_InitDataBrowserCustomCallbacks (DataBrowserCustomCallbacks *callbacks);
// Wraps call to function 'GetDataBrowserCustomCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserCustomCallbacks(ewg_param_browser, ewg_param_callbacks) GetDataBrowserCustomCallbacks ((ControlRef)ewg_param_browser, (DataBrowserCustomCallbacks*)ewg_param_callbacks)

OSStatus  ewg_function_GetDataBrowserCustomCallbacks (ControlRef browser, DataBrowserCustomCallbacks *callbacks);
// Wraps call to function 'SetDataBrowserCustomCallbacks' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserCustomCallbacks(ewg_param_browser, ewg_param_callbacks) SetDataBrowserCustomCallbacks ((ControlRef)ewg_param_browser, (DataBrowserCustomCallbacks const*)ewg_param_callbacks)

OSStatus  ewg_function_SetDataBrowserCustomCallbacks (ControlRef browser, DataBrowserCustomCallbacks const *callbacks);
// Wraps call to function 'RemoveDataBrowserTableViewColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RemoveDataBrowserTableViewColumn(ewg_param_browser, ewg_param_column) RemoveDataBrowserTableViewColumn ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column)

OSStatus  ewg_function_RemoveDataBrowserTableViewColumn (ControlRef browser, DataBrowserTableViewColumnID column);
// Wraps call to function 'GetDataBrowserTableViewColumnCount' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewColumnCount(ewg_param_browser, ewg_param_numColumns) GetDataBrowserTableViewColumnCount ((ControlRef)ewg_param_browser, (UInt32*)ewg_param_numColumns)

OSStatus  ewg_function_GetDataBrowserTableViewColumnCount (ControlRef browser, UInt32 *numColumns);
// Wraps call to function 'SetDataBrowserTableViewHiliteStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewHiliteStyle(ewg_param_browser, ewg_param_hiliteStyle) SetDataBrowserTableViewHiliteStyle ((ControlRef)ewg_param_browser, (DataBrowserTableViewHiliteStyle)ewg_param_hiliteStyle)

OSStatus  ewg_function_SetDataBrowserTableViewHiliteStyle (ControlRef browser, DataBrowserTableViewHiliteStyle hiliteStyle);
// Wraps call to function 'GetDataBrowserTableViewHiliteStyle' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewHiliteStyle(ewg_param_browser, ewg_param_hiliteStyle) GetDataBrowserTableViewHiliteStyle ((ControlRef)ewg_param_browser, (DataBrowserTableViewHiliteStyle*)ewg_param_hiliteStyle)

OSStatus  ewg_function_GetDataBrowserTableViewHiliteStyle (ControlRef browser, DataBrowserTableViewHiliteStyle *hiliteStyle);
// Wraps call to function 'SetDataBrowserTableViewRowHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewRowHeight(ewg_param_browser, ewg_param_height) SetDataBrowserTableViewRowHeight ((ControlRef)ewg_param_browser, (UInt16)ewg_param_height)

OSStatus  ewg_function_SetDataBrowserTableViewRowHeight (ControlRef browser, UInt16 height);
// Wraps call to function 'GetDataBrowserTableViewRowHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewRowHeight(ewg_param_browser, ewg_param_height) GetDataBrowserTableViewRowHeight ((ControlRef)ewg_param_browser, (UInt16*)ewg_param_height)

OSStatus  ewg_function_GetDataBrowserTableViewRowHeight (ControlRef browser, UInt16 *height);
// Wraps call to function 'SetDataBrowserTableViewColumnWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewColumnWidth(ewg_param_browser, ewg_param_width) SetDataBrowserTableViewColumnWidth ((ControlRef)ewg_param_browser, (UInt16)ewg_param_width)

OSStatus  ewg_function_SetDataBrowserTableViewColumnWidth (ControlRef browser, UInt16 width);
// Wraps call to function 'GetDataBrowserTableViewColumnWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewColumnWidth(ewg_param_browser, ewg_param_width) GetDataBrowserTableViewColumnWidth ((ControlRef)ewg_param_browser, (UInt16*)ewg_param_width)

OSStatus  ewg_function_GetDataBrowserTableViewColumnWidth (ControlRef browser, UInt16 *width);
// Wraps call to function 'SetDataBrowserTableViewItemRowHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewItemRowHeight(ewg_param_browser, ewg_param_item, ewg_param_height) SetDataBrowserTableViewItemRowHeight ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (UInt16)ewg_param_height)

OSStatus  ewg_function_SetDataBrowserTableViewItemRowHeight (ControlRef browser, DataBrowserItemID item, UInt16 height);
// Wraps call to function 'GetDataBrowserTableViewItemRowHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewItemRowHeight(ewg_param_browser, ewg_param_item, ewg_param_height) GetDataBrowserTableViewItemRowHeight ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (UInt16*)ewg_param_height)

OSStatus  ewg_function_GetDataBrowserTableViewItemRowHeight (ControlRef browser, DataBrowserItemID item, UInt16 *height);
// Wraps call to function 'SetDataBrowserTableViewNamedColumnWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewNamedColumnWidth(ewg_param_browser, ewg_param_column, ewg_param_width) SetDataBrowserTableViewNamedColumnWidth ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (UInt16)ewg_param_width)

OSStatus  ewg_function_SetDataBrowserTableViewNamedColumnWidth (ControlRef browser, DataBrowserTableViewColumnID column, UInt16 width);
// Wraps call to function 'GetDataBrowserTableViewNamedColumnWidth' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewNamedColumnWidth(ewg_param_browser, ewg_param_column, ewg_param_width) GetDataBrowserTableViewNamedColumnWidth ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (UInt16*)ewg_param_width)

OSStatus  ewg_function_GetDataBrowserTableViewNamedColumnWidth (ControlRef browser, DataBrowserTableViewColumnID column, UInt16 *width);
// Wraps call to function 'SetDataBrowserTableViewGeometry' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewGeometry(ewg_param_browser, ewg_param_variableWidthColumns, ewg_param_variableHeightRows) SetDataBrowserTableViewGeometry ((ControlRef)ewg_param_browser, (Boolean)ewg_param_variableWidthColumns, (Boolean)ewg_param_variableHeightRows)

OSStatus  ewg_function_SetDataBrowserTableViewGeometry (ControlRef browser, Boolean variableWidthColumns, Boolean variableHeightRows);
// Wraps call to function 'GetDataBrowserTableViewGeometry' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewGeometry(ewg_param_browser, ewg_param_variableWidthColumns, ewg_param_variableHeightRows) GetDataBrowserTableViewGeometry ((ControlRef)ewg_param_browser, (Boolean*)ewg_param_variableWidthColumns, (Boolean*)ewg_param_variableHeightRows)

OSStatus  ewg_function_GetDataBrowserTableViewGeometry (ControlRef browser, Boolean *variableWidthColumns, Boolean *variableHeightRows);
// Wraps call to function 'GetDataBrowserTableViewItemID' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewItemID(ewg_param_browser, ewg_param_row, ewg_param_item) GetDataBrowserTableViewItemID ((ControlRef)ewg_param_browser, (DataBrowserTableViewRowIndex)ewg_param_row, (DataBrowserItemID*)ewg_param_item)

OSStatus  ewg_function_GetDataBrowserTableViewItemID (ControlRef browser, DataBrowserTableViewRowIndex row, DataBrowserItemID *item);
// Wraps call to function 'SetDataBrowserTableViewItemRow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewItemRow(ewg_param_browser, ewg_param_item, ewg_param_row) SetDataBrowserTableViewItemRow ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserTableViewRowIndex)ewg_param_row)

OSStatus  ewg_function_SetDataBrowserTableViewItemRow (ControlRef browser, DataBrowserItemID item, DataBrowserTableViewRowIndex row);
// Wraps call to function 'GetDataBrowserTableViewItemRow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewItemRow(ewg_param_browser, ewg_param_item, ewg_param_row) GetDataBrowserTableViewItemRow ((ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserTableViewRowIndex*)ewg_param_row)

OSStatus  ewg_function_GetDataBrowserTableViewItemRow (ControlRef browser, DataBrowserItemID item, DataBrowserTableViewRowIndex *row);
// Wraps call to function 'SetDataBrowserTableViewColumnPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserTableViewColumnPosition(ewg_param_browser, ewg_param_column, ewg_param_position) SetDataBrowserTableViewColumnPosition ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (DataBrowserTableViewColumnIndex)ewg_param_position)

OSStatus  ewg_function_SetDataBrowserTableViewColumnPosition (ControlRef browser, DataBrowserTableViewColumnID column, DataBrowserTableViewColumnIndex position);
// Wraps call to function 'GetDataBrowserTableViewColumnPosition' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewColumnPosition(ewg_param_browser, ewg_param_column, ewg_param_position) GetDataBrowserTableViewColumnPosition ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (DataBrowserTableViewColumnIndex*)ewg_param_position)

OSStatus  ewg_function_GetDataBrowserTableViewColumnPosition (ControlRef browser, DataBrowserTableViewColumnID column, DataBrowserTableViewColumnIndex *position);
// Wraps call to function 'GetDataBrowserTableViewColumnProperty' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserTableViewColumnProperty(ewg_param_browser, ewg_param_column, ewg_param_property) GetDataBrowserTableViewColumnProperty ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnIndex)ewg_param_column, (DataBrowserTableViewColumnID*)ewg_param_property)

OSStatus  ewg_function_GetDataBrowserTableViewColumnProperty (ControlRef browser, DataBrowserTableViewColumnIndex column, DataBrowserTableViewColumnID *property);
// Wraps call to function 'AutoSizeDataBrowserListViewColumns' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AutoSizeDataBrowserListViewColumns(ewg_param_browser) AutoSizeDataBrowserListViewColumns ((ControlRef)ewg_param_browser)

OSStatus  ewg_function_AutoSizeDataBrowserListViewColumns (ControlRef browser);
// Wraps call to function 'AddDataBrowserListViewColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AddDataBrowserListViewColumn(ewg_param_browser, ewg_param_columnDesc, ewg_param_position) AddDataBrowserListViewColumn ((ControlRef)ewg_param_browser, (DataBrowserListViewColumnDesc*)ewg_param_columnDesc, (DataBrowserTableViewColumnIndex)ewg_param_position)

OSStatus  ewg_function_AddDataBrowserListViewColumn (ControlRef browser, DataBrowserListViewColumnDesc *columnDesc, DataBrowserTableViewColumnIndex position);
// Wraps call to function 'GetDataBrowserListViewHeaderDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserListViewHeaderDesc(ewg_param_browser, ewg_param_column, ewg_param_desc) GetDataBrowserListViewHeaderDesc ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (DataBrowserListViewHeaderDesc*)ewg_param_desc)

OSStatus  ewg_function_GetDataBrowserListViewHeaderDesc (ControlRef browser, DataBrowserTableViewColumnID column, DataBrowserListViewHeaderDesc *desc);
// Wraps call to function 'SetDataBrowserListViewHeaderDesc' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserListViewHeaderDesc(ewg_param_browser, ewg_param_column, ewg_param_desc) SetDataBrowserListViewHeaderDesc ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (DataBrowserListViewHeaderDesc*)ewg_param_desc)

OSStatus  ewg_function_SetDataBrowserListViewHeaderDesc (ControlRef browser, DataBrowserTableViewColumnID column, DataBrowserListViewHeaderDesc *desc);
// Wraps call to function 'SetDataBrowserListViewHeaderBtnHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserListViewHeaderBtnHeight(ewg_param_browser, ewg_param_height) SetDataBrowserListViewHeaderBtnHeight ((ControlRef)ewg_param_browser, (UInt16)ewg_param_height)

OSStatus  ewg_function_SetDataBrowserListViewHeaderBtnHeight (ControlRef browser, UInt16 height);
// Wraps call to function 'GetDataBrowserListViewHeaderBtnHeight' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserListViewHeaderBtnHeight(ewg_param_browser, ewg_param_height) GetDataBrowserListViewHeaderBtnHeight ((ControlRef)ewg_param_browser, (UInt16*)ewg_param_height)

OSStatus  ewg_function_GetDataBrowserListViewHeaderBtnHeight (ControlRef browser, UInt16 *height);
// Wraps call to function 'SetDataBrowserListViewUsePlainBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserListViewUsePlainBackground(ewg_param_browser, ewg_param_usePlainBackground) SetDataBrowserListViewUsePlainBackground ((ControlRef)ewg_param_browser, (Boolean)ewg_param_usePlainBackground)

OSStatus  ewg_function_SetDataBrowserListViewUsePlainBackground (ControlRef browser, Boolean usePlainBackground);
// Wraps call to function 'GetDataBrowserListViewUsePlainBackground' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserListViewUsePlainBackground(ewg_param_browser, ewg_param_usePlainBackground) GetDataBrowserListViewUsePlainBackground ((ControlRef)ewg_param_browser, (Boolean*)ewg_param_usePlainBackground)

OSStatus  ewg_function_GetDataBrowserListViewUsePlainBackground (ControlRef browser, Boolean *usePlainBackground);
// Wraps call to function 'SetDataBrowserListViewDisclosureColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserListViewDisclosureColumn(ewg_param_browser, ewg_param_column, ewg_param_expandableRows) SetDataBrowserListViewDisclosureColumn ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID)ewg_param_column, (Boolean)ewg_param_expandableRows)

OSStatus  ewg_function_SetDataBrowserListViewDisclosureColumn (ControlRef browser, DataBrowserTableViewColumnID column, Boolean expandableRows);
// Wraps call to function 'GetDataBrowserListViewDisclosureColumn' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserListViewDisclosureColumn(ewg_param_browser, ewg_param_column, ewg_param_expandableRows) GetDataBrowserListViewDisclosureColumn ((ControlRef)ewg_param_browser, (DataBrowserTableViewColumnID*)ewg_param_column, (Boolean*)ewg_param_expandableRows)

OSStatus  ewg_function_GetDataBrowserListViewDisclosureColumn (ControlRef browser, DataBrowserTableViewColumnID *column, Boolean *expandableRows);
// Wraps call to function 'GetDataBrowserColumnViewPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserColumnViewPath(ewg_param_browser, ewg_param_path) GetDataBrowserColumnViewPath ((ControlRef)ewg_param_browser, (Handle)ewg_param_path)

OSStatus  ewg_function_GetDataBrowserColumnViewPath (ControlRef browser, Handle path);
// Wraps call to function 'GetDataBrowserColumnViewPathLength' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserColumnViewPathLength(ewg_param_browser, ewg_param_pathLength) GetDataBrowserColumnViewPathLength ((ControlRef)ewg_param_browser, (UInt32*)ewg_param_pathLength)

OSStatus  ewg_function_GetDataBrowserColumnViewPathLength (ControlRef browser, UInt32 *pathLength);
// Wraps call to function 'SetDataBrowserColumnViewPath' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserColumnViewPath(ewg_param_browser, ewg_param_length, ewg_param_path) SetDataBrowserColumnViewPath ((ControlRef)ewg_param_browser, (UInt32)ewg_param_length, (DataBrowserItemID const*)ewg_param_path)

OSStatus  ewg_function_SetDataBrowserColumnViewPath (ControlRef browser, UInt32 length, DataBrowserItemID const *path);
// Wraps call to function 'SetDataBrowserColumnViewDisplayType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SetDataBrowserColumnViewDisplayType(ewg_param_browser, ewg_param_propertyType) SetDataBrowserColumnViewDisplayType ((ControlRef)ewg_param_browser, (DataBrowserPropertyType)ewg_param_propertyType)

OSStatus  ewg_function_SetDataBrowserColumnViewDisplayType (ControlRef browser, DataBrowserPropertyType propertyType);
// Wraps call to function 'GetDataBrowserColumnViewDisplayType' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetDataBrowserColumnViewDisplayType(ewg_param_browser, ewg_param_propertyType) GetDataBrowserColumnViewDisplayType ((ControlRef)ewg_param_browser, (DataBrowserPropertyType*)ewg_param_propertyType)

OSStatus  ewg_function_GetDataBrowserColumnViewDisplayType (ControlRef browser, DataBrowserPropertyType *propertyType);
// Wraps call to function 'AXUIElementGetDataBrowserItemInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXUIElementGetDataBrowserItemInfo(ewg_param_inElement, ewg_param_inDataBrowser, ewg_param_inDesiredInfoVersion, ewg_param_outInfo) AXUIElementGetDataBrowserItemInfo ((AXUIElementRef)ewg_param_inElement, (ControlRef)ewg_param_inDataBrowser, (UInt32)ewg_param_inDesiredInfoVersion, (DataBrowserAccessibilityItemInfo*)ewg_param_outInfo)

OSStatus  ewg_function_AXUIElementGetDataBrowserItemInfo (AXUIElementRef inElement, ControlRef inDataBrowser, UInt32 inDesiredInfoVersion, DataBrowserAccessibilityItemInfo *outInfo);
// Wraps call to function 'AXUIElementCreateWithDataBrowserAndItemInfo' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_AXUIElementCreateWithDataBrowserAndItemInfo(ewg_param_inDataBrowser, ewg_param_inInfo) AXUIElementCreateWithDataBrowserAndItemInfo ((ControlRef)ewg_param_inDataBrowser, (DataBrowserAccessibilityItemInfo const*)ewg_param_inInfo)

AXUIElementRef  ewg_function_AXUIElementCreateWithDataBrowserAndItemInfo (ControlRef inDataBrowser, DataBrowserAccessibilityItemInfo const *inInfo);
// Wraps call to function 'NewEditUnicodePostUpdateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewEditUnicodePostUpdateUPP(ewg_param_userRoutine) NewEditUnicodePostUpdateUPP ((EditUnicodePostUpdateProcPtr)ewg_param_userRoutine)

EditUnicodePostUpdateUPP  ewg_function_NewEditUnicodePostUpdateUPP (EditUnicodePostUpdateProcPtr userRoutine);
// Wraps call to function 'DisposeEditUnicodePostUpdateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeEditUnicodePostUpdateUPP(ewg_param_userUPP) DisposeEditUnicodePostUpdateUPP ((EditUnicodePostUpdateUPP)ewg_param_userUPP)

void  ewg_function_DisposeEditUnicodePostUpdateUPP (EditUnicodePostUpdateUPP userUPP);
// Wraps call to function 'InvokeEditUnicodePostUpdateUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeEditUnicodePostUpdateUPP(ewg_param_uniText, ewg_param_uniTextLength, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_refcon, ewg_param_userUPP) InvokeEditUnicodePostUpdateUPP ((UniCharArrayHandle)ewg_param_uniText, (UniCharCount)ewg_param_uniTextLength, (UniCharArrayOffset)ewg_param_iStartOffset, (UniCharArrayOffset)ewg_param_iEndOffset, (void*)ewg_param_refcon, (EditUnicodePostUpdateUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeEditUnicodePostUpdateUPP (UniCharArrayHandle uniText, UniCharCount uniTextLength, UniCharArrayOffset iStartOffset, UniCharArrayOffset iEndOffset, void *refcon, EditUnicodePostUpdateUPP userUPP);
// Wraps call to function 'CreateEditUnicodeTextControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CreateEditUnicodeTextControl(ewg_param_window, ewg_param_boundsRect, ewg_param_text, ewg_param_isPassword, ewg_param_style, ewg_param_outControl) CreateEditUnicodeTextControl ((WindowRef)ewg_param_window, (Rect const*)ewg_param_boundsRect, (CFStringRef)ewg_param_text, (Boolean)ewg_param_isPassword, (ControlFontStyleRec const*)ewg_param_style, (ControlRef*)ewg_param_outControl)

OSStatus  ewg_function_CreateEditUnicodeTextControl (WindowRef window, Rect const *boundsRect, CFStringRef text, Boolean isPassword, ControlFontStyleRec const *style, ControlRef *outControl);
// Wraps call to function 'NewNavEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewNavEventUPP(ewg_param_userRoutine) NewNavEventUPP ((NavEventProcPtr)ewg_param_userRoutine)

NavEventUPP  ewg_function_NewNavEventUPP (NavEventProcPtr userRoutine);
// Wraps call to function 'NewNavPreviewUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewNavPreviewUPP(ewg_param_userRoutine) NewNavPreviewUPP ((NavPreviewProcPtr)ewg_param_userRoutine)

NavPreviewUPP  ewg_function_NewNavPreviewUPP (NavPreviewProcPtr userRoutine);
// Wraps call to function 'NewNavObjectFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewNavObjectFilterUPP(ewg_param_userRoutine) NewNavObjectFilterUPP ((NavObjectFilterProcPtr)ewg_param_userRoutine)

NavObjectFilterUPP  ewg_function_NewNavObjectFilterUPP (NavObjectFilterProcPtr userRoutine);
// Wraps call to function 'DisposeNavEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeNavEventUPP(ewg_param_userUPP) DisposeNavEventUPP ((NavEventUPP)ewg_param_userUPP)

void  ewg_function_DisposeNavEventUPP (NavEventUPP userUPP);
// Wraps call to function 'DisposeNavPreviewUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeNavPreviewUPP(ewg_param_userUPP) DisposeNavPreviewUPP ((NavPreviewUPP)ewg_param_userUPP)

void  ewg_function_DisposeNavPreviewUPP (NavPreviewUPP userUPP);
// Wraps call to function 'DisposeNavObjectFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeNavObjectFilterUPP(ewg_param_userUPP) DisposeNavObjectFilterUPP ((NavObjectFilterUPP)ewg_param_userUPP)

void  ewg_function_DisposeNavObjectFilterUPP (NavObjectFilterUPP userUPP);
// Wraps call to function 'InvokeNavEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeNavEventUPP(ewg_param_callBackSelector, ewg_param_callBackParms, ewg_param_callBackUD, ewg_param_userUPP) InvokeNavEventUPP ((NavEventCallbackMessage)ewg_param_callBackSelector, (NavCBRecPtr)ewg_param_callBackParms, (void*)ewg_param_callBackUD, (NavEventUPP)ewg_param_userUPP)

void  ewg_function_InvokeNavEventUPP (NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD, NavEventUPP userUPP);
// Wraps call to function 'InvokeNavPreviewUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeNavPreviewUPP(ewg_param_callBackParms, ewg_param_callBackUD, ewg_param_userUPP) InvokeNavPreviewUPP ((NavCBRecPtr)ewg_param_callBackParms, (void*)ewg_param_callBackUD, (NavPreviewUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeNavPreviewUPP (NavCBRecPtr callBackParms, void *callBackUD, NavPreviewUPP userUPP);
// Wraps call to function 'InvokeNavObjectFilterUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeNavObjectFilterUPP(ewg_param_theItem, ewg_param_info, ewg_param_callBackUD, ewg_param_filterMode, ewg_param_userUPP) InvokeNavObjectFilterUPP ((AEDesc*)ewg_param_theItem, (void*)ewg_param_info, (void*)ewg_param_callBackUD, (NavFilterModes)ewg_param_filterMode, (NavObjectFilterUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeNavObjectFilterUPP (AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode, NavObjectFilterUPP userUPP);
// Wraps call to function 'NavLoad' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavLoad NavLoad ()

OSErr  ewg_function_NavLoad (void);
// Wraps call to function 'NavUnload' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavUnload NavUnload ()

OSErr  ewg_function_NavUnload (void);
// Wraps call to function 'NavLibraryVersion' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavLibraryVersion NavLibraryVersion ()

UInt32  ewg_function_NavLibraryVersion (void);
// Wraps call to function 'NavGetDefaultDialogOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavGetDefaultDialogOptions(ewg_param_dialogOptions) NavGetDefaultDialogOptions ((NavDialogOptions*)ewg_param_dialogOptions)

OSErr  ewg_function_NavGetDefaultDialogOptions (NavDialogOptions *dialogOptions);
// Wraps call to function 'NavGetFile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavGetFile(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_previewProc, ewg_param_filterProc, ewg_param_typeList, ewg_param_callBackUD) NavGetFile ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (NavPreviewUPP)ewg_param_previewProc, (NavObjectFilterUPP)ewg_param_filterProc, (NavTypeListHandle)ewg_param_typeList, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavGetFile (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, NavPreviewUPP previewProc, NavObjectFilterUPP filterProc, NavTypeListHandle typeList, void *callBackUD);
// Wraps call to function 'NavPutFile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavPutFile(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_fileType, ewg_param_fileCreator, ewg_param_callBackUD) NavPutFile ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (OSType)ewg_param_fileType, (OSType)ewg_param_fileCreator, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavPutFile (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, OSType fileType, OSType fileCreator, void *callBackUD);
// Wraps call to function 'NavAskSaveChanges' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavAskSaveChanges(ewg_param_dialogOptions, ewg_param_action, ewg_param_reply, ewg_param_eventProc, ewg_param_callBackUD) NavAskSaveChanges ((NavDialogOptions*)ewg_param_dialogOptions, (NavAskSaveChangesAction)ewg_param_action, (NavAskSaveChangesResult*)ewg_param_reply, (NavEventUPP)ewg_param_eventProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavAskSaveChanges (NavDialogOptions *dialogOptions, NavAskSaveChangesAction action, NavAskSaveChangesResult *reply, NavEventUPP eventProc, void *callBackUD);
// Wraps call to function 'NavCustomAskSaveChanges' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCustomAskSaveChanges(ewg_param_dialogOptions, ewg_param_reply, ewg_param_eventProc, ewg_param_callBackUD) NavCustomAskSaveChanges ((NavDialogOptions*)ewg_param_dialogOptions, (NavAskSaveChangesResult*)ewg_param_reply, (NavEventUPP)ewg_param_eventProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavCustomAskSaveChanges (NavDialogOptions *dialogOptions, NavAskSaveChangesResult *reply, NavEventUPP eventProc, void *callBackUD);
// Wraps call to function 'NavAskDiscardChanges' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavAskDiscardChanges(ewg_param_dialogOptions, ewg_param_reply, ewg_param_eventProc, ewg_param_callBackUD) NavAskDiscardChanges ((NavDialogOptions*)ewg_param_dialogOptions, (NavAskDiscardChangesResult*)ewg_param_reply, (NavEventUPP)ewg_param_eventProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavAskDiscardChanges (NavDialogOptions *dialogOptions, NavAskDiscardChangesResult *reply, NavEventUPP eventProc, void *callBackUD);
// Wraps call to function 'NavChooseFile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavChooseFile(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_previewProc, ewg_param_filterProc, ewg_param_typeList, ewg_param_callBackUD) NavChooseFile ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (NavPreviewUPP)ewg_param_previewProc, (NavObjectFilterUPP)ewg_param_filterProc, (NavTypeListHandle)ewg_param_typeList, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavChooseFile (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, NavPreviewUPP previewProc, NavObjectFilterUPP filterProc, NavTypeListHandle typeList, void *callBackUD);
// Wraps call to function 'NavChooseFolder' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavChooseFolder(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_filterProc, ewg_param_callBackUD) NavChooseFolder ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (NavObjectFilterUPP)ewg_param_filterProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavChooseFolder (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, NavObjectFilterUPP filterProc, void *callBackUD);
// Wraps call to function 'NavChooseVolume' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavChooseVolume(ewg_param_defaultSelection, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_filterProc, ewg_param_callBackUD) NavChooseVolume ((AEDesc*)ewg_param_defaultSelection, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (NavObjectFilterUPP)ewg_param_filterProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavChooseVolume (AEDesc *defaultSelection, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, NavObjectFilterUPP filterProc, void *callBackUD);
// Wraps call to function 'NavChooseObject' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavChooseObject(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_filterProc, ewg_param_callBackUD) NavChooseObject ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (NavObjectFilterUPP)ewg_param_filterProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavChooseObject (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, NavObjectFilterUPP filterProc, void *callBackUD);
// Wraps call to function 'NavNewFolder' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavNewFolder(ewg_param_defaultLocation, ewg_param_reply, ewg_param_dialogOptions, ewg_param_eventProc, ewg_param_callBackUD) NavNewFolder ((AEDesc*)ewg_param_defaultLocation, (NavReplyRecord*)ewg_param_reply, (NavDialogOptions*)ewg_param_dialogOptions, (NavEventUPP)ewg_param_eventProc, (void*)ewg_param_callBackUD)

OSErr  ewg_function_NavNewFolder (AEDesc *defaultLocation, NavReplyRecord *reply, NavDialogOptions *dialogOptions, NavEventUPP eventProc, void *callBackUD);
// Wraps call to function 'NavTranslateFile' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavTranslateFile(ewg_param_reply, ewg_param_howToTranslate) NavTranslateFile ((NavReplyRecord*)ewg_param_reply, (NavTranslationOptions)ewg_param_howToTranslate)

OSErr  ewg_function_NavTranslateFile (NavReplyRecord *reply, NavTranslationOptions howToTranslate);
// Wraps call to function 'NavCompleteSave' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCompleteSave(ewg_param_reply, ewg_param_howToTranslate) NavCompleteSave ((NavReplyRecord*)ewg_param_reply, (NavTranslationOptions)ewg_param_howToTranslate)

OSErr  ewg_function_NavCompleteSave (NavReplyRecord *reply, NavTranslationOptions howToTranslate);
// Wraps call to function 'NavCustomControl' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCustomControl(ewg_param_dialog, ewg_param_selector, ewg_param_parms) NavCustomControl ((NavDialogRef)ewg_param_dialog, (NavCustomControlMessage)ewg_param_selector, (void*)ewg_param_parms)

OSErr  ewg_function_NavCustomControl (NavDialogRef dialog, NavCustomControlMessage selector, void *parms);
// Wraps call to function 'NavCreatePreview' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreatePreview(ewg_param_theObject, ewg_param_previewDataType, ewg_param_previewData, ewg_param_previewDataSize) NavCreatePreview ((AEDesc*)ewg_param_theObject, (OSType)ewg_param_previewDataType, (void const*)ewg_param_previewData, (Size)ewg_param_previewDataSize)

OSErr  ewg_function_NavCreatePreview (AEDesc *theObject, OSType previewDataType, void const *previewData, Size previewDataSize);
// Wraps call to function 'NavDisposeReply' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDisposeReply(ewg_param_reply) NavDisposeReply ((NavReplyRecord*)ewg_param_reply)

OSErr  ewg_function_NavDisposeReply (NavReplyRecord *reply);
// Wraps call to function 'NavServicesCanRun' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavServicesCanRun NavServicesCanRun ()

Boolean  ewg_function_NavServicesCanRun (void);
// Wraps call to function 'NavGetDefaultDialogCreationOptions' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavGetDefaultDialogCreationOptions(ewg_param_outOptions) NavGetDefaultDialogCreationOptions ((NavDialogCreationOptions*)ewg_param_outOptions)

OSStatus  ewg_function_NavGetDefaultDialogCreationOptions (NavDialogCreationOptions *outOptions);
// Wraps call to function 'NavCreateGetFileDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateGetFileDialog(ewg_param_inOptions, ewg_param_inTypeList, ewg_param_inEventProc, ewg_param_inPreviewProc, ewg_param_inFilterProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateGetFileDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavTypeListHandle)ewg_param_inTypeList, (NavEventUPP)ewg_param_inEventProc, (NavPreviewUPP)ewg_param_inPreviewProc, (NavObjectFilterUPP)ewg_param_inFilterProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateGetFileDialog (NavDialogCreationOptions const *inOptions, NavTypeListHandle inTypeList, NavEventUPP inEventProc, NavPreviewUPP inPreviewProc, NavObjectFilterUPP inFilterProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreatePutFileDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreatePutFileDialog(ewg_param_inOptions, ewg_param_inFileType, ewg_param_inFileCreator, ewg_param_inEventProc, ewg_param_inClientData, ewg_param_outDialog) NavCreatePutFileDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (OSType)ewg_param_inFileType, (OSType)ewg_param_inFileCreator, (NavEventUPP)ewg_param_inEventProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreatePutFileDialog (NavDialogCreationOptions const *inOptions, OSType inFileType, OSType inFileCreator, NavEventUPP inEventProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateAskReviewDocumentsDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateAskReviewDocumentsDialog(ewg_param_inOptions, ewg_param_inDocumentCount, ewg_param_inEventProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateAskReviewDocumentsDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (UInt32)ewg_param_inDocumentCount, (NavEventUPP)ewg_param_inEventProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateAskReviewDocumentsDialog (NavDialogCreationOptions const *inOptions, UInt32 inDocumentCount, NavEventUPP inEventProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateAskSaveChangesDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateAskSaveChangesDialog(ewg_param_inOptions, ewg_param_inAction, ewg_param_inEventProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateAskSaveChangesDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavAskSaveChangesAction)ewg_param_inAction, (NavEventUPP)ewg_param_inEventProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateAskSaveChangesDialog (NavDialogCreationOptions const *inOptions, NavAskSaveChangesAction inAction, NavEventUPP inEventProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateAskDiscardChangesDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateAskDiscardChangesDialog(ewg_param_inOptions, ewg_param_inEventProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateAskDiscardChangesDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavEventUPP)ewg_param_inEventProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateAskDiscardChangesDialog (NavDialogCreationOptions const *inOptions, NavEventUPP inEventProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateChooseFileDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateChooseFileDialog(ewg_param_inOptions, ewg_param_inTypeList, ewg_param_inEventProc, ewg_param_inPreviewProc, ewg_param_inFilterProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateChooseFileDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavTypeListHandle)ewg_param_inTypeList, (NavEventUPP)ewg_param_inEventProc, (NavPreviewUPP)ewg_param_inPreviewProc, (NavObjectFilterUPP)ewg_param_inFilterProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateChooseFileDialog (NavDialogCreationOptions const *inOptions, NavTypeListHandle inTypeList, NavEventUPP inEventProc, NavPreviewUPP inPreviewProc, NavObjectFilterUPP inFilterProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateChooseFolderDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateChooseFolderDialog(ewg_param_inOptions, ewg_param_inEventProc, ewg_param_inFilterProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateChooseFolderDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavEventUPP)ewg_param_inEventProc, (NavObjectFilterUPP)ewg_param_inFilterProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateChooseFolderDialog (NavDialogCreationOptions const *inOptions, NavEventUPP inEventProc, NavObjectFilterUPP inFilterProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateChooseVolumeDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateChooseVolumeDialog(ewg_param_inOptions, ewg_param_inEventProc, ewg_param_inFilterProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateChooseVolumeDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavEventUPP)ewg_param_inEventProc, (NavObjectFilterUPP)ewg_param_inFilterProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateChooseVolumeDialog (NavDialogCreationOptions const *inOptions, NavEventUPP inEventProc, NavObjectFilterUPP inFilterProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateChooseObjectDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateChooseObjectDialog(ewg_param_inOptions, ewg_param_inEventProc, ewg_param_inPreviewProc, ewg_param_inFilterProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateChooseObjectDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavEventUPP)ewg_param_inEventProc, (NavPreviewUPP)ewg_param_inPreviewProc, (NavObjectFilterUPP)ewg_param_inFilterProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateChooseObjectDialog (NavDialogCreationOptions const *inOptions, NavEventUPP inEventProc, NavPreviewUPP inPreviewProc, NavObjectFilterUPP inFilterProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavCreateNewFolderDialog' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavCreateNewFolderDialog(ewg_param_inOptions, ewg_param_inEventProc, ewg_param_inClientData, ewg_param_outDialog) NavCreateNewFolderDialog ((NavDialogCreationOptions const*)ewg_param_inOptions, (NavEventUPP)ewg_param_inEventProc, (void*)ewg_param_inClientData, (NavDialogRef*)ewg_param_outDialog)

OSStatus  ewg_function_NavCreateNewFolderDialog (NavDialogCreationOptions const *inOptions, NavEventUPP inEventProc, void *inClientData, NavDialogRef *outDialog);
// Wraps call to function 'NavDialogRun' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogRun(ewg_param_inDialog) NavDialogRun ((NavDialogRef)ewg_param_inDialog)

OSStatus  ewg_function_NavDialogRun (NavDialogRef inDialog);
// Wraps call to function 'NavDialogDispose' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogDispose(ewg_param_inDialog) NavDialogDispose ((NavDialogRef)ewg_param_inDialog)

void  ewg_function_NavDialogDispose (NavDialogRef inDialog);
// Wraps call to function 'NavDialogGetWindow' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogGetWindow(ewg_param_inDialog) NavDialogGetWindow ((NavDialogRef)ewg_param_inDialog)

WindowRef  ewg_function_NavDialogGetWindow (NavDialogRef inDialog);
// Wraps call to function 'NavDialogGetUserAction' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogGetUserAction(ewg_param_inDialog) NavDialogGetUserAction ((NavDialogRef)ewg_param_inDialog)

NavUserAction  ewg_function_NavDialogGetUserAction (NavDialogRef inDialog);
// Wraps call to function 'NavDialogGetReply' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogGetReply(ewg_param_inDialog, ewg_param_outReply) NavDialogGetReply ((NavDialogRef)ewg_param_inDialog, (NavReplyRecord*)ewg_param_outReply)

OSStatus  ewg_function_NavDialogGetReply (NavDialogRef inDialog, NavReplyRecord *outReply);
// Wraps call to function 'NavDialogGetSaveFileName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogGetSaveFileName(ewg_param_inPutFileDialog) NavDialogGetSaveFileName ((NavDialogRef)ewg_param_inPutFileDialog)

CFStringRef  ewg_function_NavDialogGetSaveFileName (NavDialogRef inPutFileDialog);
// Wraps call to function 'NavDialogSetSaveFileName' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogSetSaveFileName(ewg_param_inPutFileDialog, ewg_param_inFileName) NavDialogSetSaveFileName ((NavDialogRef)ewg_param_inPutFileDialog, (CFStringRef)ewg_param_inFileName)

OSStatus  ewg_function_NavDialogSetSaveFileName (NavDialogRef inPutFileDialog, CFStringRef inFileName);
// Wraps call to function 'NavDialogGetSaveFileExtensionHidden' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogGetSaveFileExtensionHidden(ewg_param_inPutFileDialog) NavDialogGetSaveFileExtensionHidden ((NavDialogRef)ewg_param_inPutFileDialog)

Boolean  ewg_function_NavDialogGetSaveFileExtensionHidden (NavDialogRef inPutFileDialog);
// Wraps call to function 'NavDialogSetSaveFileExtensionHidden' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogSetSaveFileExtensionHidden(ewg_param_inPutFileDialog, ewg_param_inHidden) NavDialogSetSaveFileExtensionHidden ((NavDialogRef)ewg_param_inPutFileDialog, (Boolean)ewg_param_inHidden)

OSStatus  ewg_function_NavDialogSetSaveFileExtensionHidden (NavDialogRef inPutFileDialog, Boolean inHidden);
// Wraps call to function 'NavDialogSetFilterTypeIdentifiers' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NavDialogSetFilterTypeIdentifiers(ewg_param_inGetFileDialog, ewg_param_inTypeIdentifiers) NavDialogSetFilterTypeIdentifiers ((NavDialogRef)ewg_param_inGetFileDialog, (CFArrayRef)ewg_param_inTypeIdentifiers)

OSStatus  ewg_function_NavDialogSetFilterTypeIdentifiers (NavDialogRef inGetFileDialog, CFArrayRef inTypeIdentifiers);
// Wraps call to function 'Fix2SmallFract' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_Fix2SmallFract(ewg_param_f) Fix2SmallFract ((Fixed)ewg_param_f)

SmallFract  ewg_function_Fix2SmallFract (Fixed f);
// Wraps call to function 'SmallFract2Fix' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_SmallFract2Fix(ewg_param_s) SmallFract2Fix ((SmallFract)ewg_param_s)

Fixed  ewg_function_SmallFract2Fix (SmallFract s);
// Wraps call to function 'CMY2RGB' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_CMY2RGB(ewg_param_cColor, ewg_param_rColor) CMY2RGB ((CMYColor const*)ewg_param_cColor, (RGBColor*)ewg_param_rColor)

void  ewg_function_CMY2RGB (CMYColor const *cColor, RGBColor *rColor);
// Wraps call to function 'RGB2CMY' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RGB2CMY(ewg_param_rColor, ewg_param_cColor) RGB2CMY ((RGBColor const*)ewg_param_rColor, (CMYColor*)ewg_param_cColor)

void  ewg_function_RGB2CMY (RGBColor const *rColor, CMYColor *cColor);
// Wraps call to function 'HSL2RGB' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HSL2RGB(ewg_param_hColor, ewg_param_rColor) HSL2RGB ((HSLColor const*)ewg_param_hColor, (RGBColor*)ewg_param_rColor)

void  ewg_function_HSL2RGB (HSLColor const *hColor, RGBColor *rColor);
// Wraps call to function 'RGB2HSL' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RGB2HSL(ewg_param_rColor, ewg_param_hColor) RGB2HSL ((RGBColor const*)ewg_param_rColor, (HSLColor*)ewg_param_hColor)

void  ewg_function_RGB2HSL (RGBColor const *rColor, HSLColor *hColor);
// Wraps call to function 'HSV2RGB' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_HSV2RGB(ewg_param_hColor, ewg_param_rColor) HSV2RGB ((HSVColor const*)ewg_param_hColor, (RGBColor*)ewg_param_rColor)

void  ewg_function_HSV2RGB (HSVColor const *hColor, RGBColor *rColor);
// Wraps call to function 'RGB2HSV' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_RGB2HSV(ewg_param_rColor, ewg_param_hColor) RGB2HSV ((RGBColor const*)ewg_param_rColor, (HSVColor*)ewg_param_hColor)

void  ewg_function_RGB2HSV (RGBColor const *rColor, HSVColor *hColor);
// Wraps call to function 'GetColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_GetColor(ewg_param_where, ewg_param_prompt, ewg_param_inColor, ewg_param_outColor) GetColor (*(Point*)ewg_param_where, (ConstStr255Param)ewg_param_prompt, (RGBColor const*)ewg_param_inColor, (RGBColor*)ewg_param_outColor)

Boolean  ewg_function_GetColor (Point *where, ConstStr255Param prompt, RGBColor const *inColor, RGBColor *outColor);
// Wraps call to function 'PickColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_PickColor(ewg_param_theColorInfo) PickColor ((ColorPickerInfo*)ewg_param_theColorInfo)

OSErr  ewg_function_PickColor (ColorPickerInfo *theColorInfo);
// Wraps call to function 'NPickColor' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NPickColor(ewg_param_theColorInfo) NPickColor ((NColorPickerInfo*)ewg_param_theColorInfo)

OSErr  ewg_function_NPickColor (NColorPickerInfo *theColorInfo);
// Wraps call to function 'NewColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewColorChangedUPP(ewg_param_userRoutine) NewColorChangedUPP ((ColorChangedProcPtr)ewg_param_userRoutine)

ColorChangedUPP  ewg_function_NewColorChangedUPP (ColorChangedProcPtr userRoutine);
// Wraps call to function 'NewNColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewNColorChangedUPP(ewg_param_userRoutine) NewNColorChangedUPP ((NColorChangedProcPtr)ewg_param_userRoutine)

NColorChangedUPP  ewg_function_NewNColorChangedUPP (NColorChangedProcPtr userRoutine);
// Wraps call to function 'NewUserEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_NewUserEventUPP(ewg_param_userRoutine) NewUserEventUPP ((UserEventProcPtr)ewg_param_userRoutine)

UserEventUPP  ewg_function_NewUserEventUPP (UserEventProcPtr userRoutine);
// Wraps call to function 'DisposeColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeColorChangedUPP(ewg_param_userUPP) DisposeColorChangedUPP ((ColorChangedUPP)ewg_param_userUPP)

void  ewg_function_DisposeColorChangedUPP (ColorChangedUPP userUPP);
// Wraps call to function 'DisposeNColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeNColorChangedUPP(ewg_param_userUPP) DisposeNColorChangedUPP ((NColorChangedUPP)ewg_param_userUPP)

void  ewg_function_DisposeNColorChangedUPP (NColorChangedUPP userUPP);
// Wraps call to function 'DisposeUserEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_DisposeUserEventUPP(ewg_param_userUPP) DisposeUserEventUPP ((UserEventUPP)ewg_param_userUPP)

void  ewg_function_DisposeUserEventUPP (UserEventUPP userUPP);
// Wraps call to function 'InvokeColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeColorChangedUPP(ewg_param_userData, ewg_param_newColor, ewg_param_userUPP) InvokeColorChangedUPP ((long)ewg_param_userData, (PMColor*)ewg_param_newColor, (ColorChangedUPP)ewg_param_userUPP)

void  ewg_function_InvokeColorChangedUPP (long userData, PMColor *newColor, ColorChangedUPP userUPP);
// Wraps call to function 'InvokeNColorChangedUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeNColorChangedUPP(ewg_param_userData, ewg_param_newColor, ewg_param_userUPP) InvokeNColorChangedUPP ((long)ewg_param_userData, (NPMColor*)ewg_param_newColor, (NColorChangedUPP)ewg_param_userUPP)

void  ewg_function_InvokeNColorChangedUPP (long userData, NPMColor *newColor, NColorChangedUPP userUPP);
// Wraps call to function 'InvokeUserEventUPP' in a macro
#include <Carbon/Carbon.h>

#define ewg_function_macro_InvokeUserEventUPP(ewg_param_event, ewg_param_userUPP) InvokeUserEventUPP ((EventRecord*)ewg_param_event, (UserEventUPP)ewg_param_userUPP)

Boolean  ewg_function_InvokeUserEventUPP (EventRecord *event, UserEventUPP userUPP);
// Wraps call to function 'get_cgdata_provider_release_data_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_release_data_callback_stub get_cgdata_provider_release_data_callback_stub ()

void * ewg_function_get_cgdata_provider_release_data_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_release_data_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_release_data_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_release_data_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_release_data_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_release_data_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_release_data_callback(ewg_param_a_function, ewg_param_info, ewg_param_data, ewg_param_size) call_cgdata_provider_release_data_callback ((void*)ewg_param_a_function, (void*)ewg_param_info, (void const*)ewg_param_data, (size_t)ewg_param_size)

void  ewg_function_call_cgdata_provider_release_data_callback (void *a_function, void *info, void const *data, size_t size);
// Wraps call to function 'get_cgpath_applier_function_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgpath_applier_function_stub get_cgpath_applier_function_stub ()

void * ewg_function_get_cgpath_applier_function_stub (void);
// Wraps call to function 'set_cgpath_applier_function_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgpath_applier_function_entry(ewg_param_a_class, ewg_param_a_feature) set_cgpath_applier_function_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgpath_applier_function_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgpath_applier_function' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgpath_applier_function(ewg_param_a_function, ewg_param_info, ewg_param_element) call_cgpath_applier_function ((void*)ewg_param_a_function, (void*)ewg_param_info, (CGPathElement const*)ewg_param_element)

void  ewg_function_call_cgpath_applier_function (void *a_function, void *info, CGPathElement const *element);
// Wraps call to function 'get_aecoerce_desc_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_aecoerce_desc_proc_ptr_stub get_aecoerce_desc_proc_ptr_stub ()

void * ewg_function_get_aecoerce_desc_proc_ptr_stub (void);
// Wraps call to function 'set_aecoerce_desc_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_aecoerce_desc_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_aecoerce_desc_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_aecoerce_desc_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_aecoerce_desc_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_aecoerce_desc_proc_ptr(ewg_param_a_function, ewg_param_fromDesc, ewg_param_toType, ewg_param_handlerRefcon, ewg_param_toDesc) call_aecoerce_desc_proc_ptr ((void*)ewg_param_a_function, (AEDesc const*)ewg_param_fromDesc, (DescType)ewg_param_toType, (long)ewg_param_handlerRefcon, (AEDesc*)ewg_param_toDesc)

OSErr  ewg_function_call_aecoerce_desc_proc_ptr (void *a_function, AEDesc const *fromDesc, DescType toType, long handlerRefcon, AEDesc *toDesc);
// Wraps call to function 'get_aecoerce_ptr_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_aecoerce_ptr_proc_ptr_stub get_aecoerce_ptr_proc_ptr_stub ()

void * ewg_function_get_aecoerce_ptr_proc_ptr_stub (void);
// Wraps call to function 'set_aecoerce_ptr_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_aecoerce_ptr_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_aecoerce_ptr_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_aecoerce_ptr_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_aecoerce_ptr_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_aecoerce_ptr_proc_ptr(ewg_param_a_function, ewg_param_typeCode, ewg_param_dataPtr, ewg_param_dataSize, ewg_param_toType, ewg_param_handlerRefcon, ewg_param_result) call_aecoerce_ptr_proc_ptr ((void*)ewg_param_a_function, (DescType)ewg_param_typeCode, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataSize, (DescType)ewg_param_toType, (long)ewg_param_handlerRefcon, (AEDesc*)ewg_param_result)

OSErr  ewg_function_call_aecoerce_ptr_proc_ptr (void *a_function, DescType typeCode, void const *dataPtr, Size dataSize, DescType toType, long handlerRefcon, AEDesc *result);
// Wraps call to function 'get_aedispose_external_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_aedispose_external_proc_ptr_stub get_aedispose_external_proc_ptr_stub ()

void * ewg_function_get_aedispose_external_proc_ptr_stub (void);
// Wraps call to function 'set_aedispose_external_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_aedispose_external_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_aedispose_external_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_aedispose_external_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_aedispose_external_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_aedispose_external_proc_ptr(ewg_param_a_function, ewg_param_dataPtr, ewg_param_dataLength, ewg_param_refcon) call_aedispose_external_proc_ptr ((void*)ewg_param_a_function, (void const*)ewg_param_dataPtr, (Size)ewg_param_dataLength, (long)ewg_param_refcon)

void  ewg_function_call_aedispose_external_proc_ptr (void *a_function, void const *dataPtr, Size dataLength, long refcon);
// Wraps call to function 'get_aeevent_handler_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_aeevent_handler_proc_ptr_stub get_aeevent_handler_proc_ptr_stub ()

void * ewg_function_get_aeevent_handler_proc_ptr_stub (void);
// Wraps call to function 'set_aeevent_handler_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_aeevent_handler_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_aeevent_handler_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_aeevent_handler_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_aeevent_handler_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_aeevent_handler_proc_ptr(ewg_param_a_function, ewg_param_theAppleEvent, ewg_param_reply, ewg_param_handlerRefcon) call_aeevent_handler_proc_ptr ((void*)ewg_param_a_function, (AppleEvent const*)ewg_param_theAppleEvent, (AppleEvent*)ewg_param_reply, (long)ewg_param_handlerRefcon)

OSErr  ewg_function_call_aeevent_handler_proc_ptr (void *a_function, AppleEvent const *theAppleEvent, AppleEvent *reply, long handlerRefcon);
// Wraps call to function 'get_aeremote_process_resolver_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_aeremote_process_resolver_callback_stub get_aeremote_process_resolver_callback_stub ()

void * ewg_function_get_aeremote_process_resolver_callback_stub (void);
// Wraps call to function 'set_aeremote_process_resolver_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_aeremote_process_resolver_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_aeremote_process_resolver_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_aeremote_process_resolver_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_aeremote_process_resolver_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_aeremote_process_resolver_callback(ewg_param_a_function, ewg_param_ref, ewg_param_info) call_aeremote_process_resolver_callback ((void*)ewg_param_a_function, (AERemoteProcessResolverRef)ewg_param_ref, (void*)ewg_param_info)

void  ewg_function_call_aeremote_process_resolver_callback (void *a_function, AERemoteProcessResolverRef ref, void *info);
// Wraps call to function 'get_event_comparator_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_event_comparator_proc_ptr_stub get_event_comparator_proc_ptr_stub ()

void * ewg_function_get_event_comparator_proc_ptr_stub (void);
// Wraps call to function 'set_event_comparator_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_event_comparator_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_event_comparator_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_event_comparator_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_event_comparator_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_event_comparator_proc_ptr(ewg_param_a_function, ewg_param_inEvent, ewg_param_inCompareData) call_event_comparator_proc_ptr ((void*)ewg_param_a_function, (EventRef)ewg_param_inEvent, (void*)ewg_param_inCompareData)

Boolean  ewg_function_call_event_comparator_proc_ptr (void *a_function, EventRef inEvent, void *inCompareData);
// Wraps call to function 'get_event_loop_timer_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_event_loop_timer_proc_ptr_stub get_event_loop_timer_proc_ptr_stub ()

void * ewg_function_get_event_loop_timer_proc_ptr_stub (void);
// Wraps call to function 'set_event_loop_timer_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_event_loop_timer_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_event_loop_timer_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_event_loop_timer_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_event_loop_timer_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_event_loop_timer_proc_ptr(ewg_param_a_function, ewg_param_inTimer, ewg_param_inUserData) call_event_loop_timer_proc_ptr ((void*)ewg_param_a_function, (EventLoopTimerRef)ewg_param_inTimer, (void*)ewg_param_inUserData)

void  ewg_function_call_event_loop_timer_proc_ptr (void *a_function, EventLoopTimerRef inTimer, void *inUserData);
// Wraps call to function 'get_event_loop_idle_timer_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_event_loop_idle_timer_proc_ptr_stub get_event_loop_idle_timer_proc_ptr_stub ()

void * ewg_function_get_event_loop_idle_timer_proc_ptr_stub (void);
// Wraps call to function 'set_event_loop_idle_timer_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_event_loop_idle_timer_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_event_loop_idle_timer_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_event_loop_idle_timer_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_event_loop_idle_timer_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_event_loop_idle_timer_proc_ptr(ewg_param_a_function, ewg_param_inTimer, ewg_param_inState, ewg_param_inUserData) call_event_loop_idle_timer_proc_ptr ((void*)ewg_param_a_function, (EventLoopTimerRef)ewg_param_inTimer, (EventLoopIdleTimerMessage)ewg_param_inState, (void*)ewg_param_inUserData)

void  ewg_function_call_event_loop_idle_timer_proc_ptr (void *a_function, EventLoopTimerRef inTimer, EventLoopIdleTimerMessage inState, void *inUserData);
// Wraps call to function 'get_event_handler_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_event_handler_proc_ptr_stub get_event_handler_proc_ptr_stub ()

void * ewg_function_get_event_handler_proc_ptr_stub (void);
// Wraps call to function 'set_event_handler_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_event_handler_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_event_handler_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_event_handler_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_event_handler_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_event_handler_proc_ptr(ewg_param_a_function, ewg_param_inHandlerCallRef, ewg_param_inEvent, ewg_param_inUserData) call_event_handler_proc_ptr ((void*)ewg_param_a_function, (EventHandlerCallRef)ewg_param_inHandlerCallRef, (EventRef)ewg_param_inEvent, (void*)ewg_param_inUserData)

OSStatus  ewg_function_call_event_handler_proc_ptr (void *a_function, EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData);
// Wraps call to function 'get_menu_def_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_menu_def_proc_ptr_stub get_menu_def_proc_ptr_stub ()

void * ewg_function_get_menu_def_proc_ptr_stub (void);
// Wraps call to function 'set_menu_def_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_menu_def_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_menu_def_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_menu_def_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_menu_def_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_menu_def_proc_ptr(ewg_param_a_function, ewg_param_message, ewg_param_theMenu, ewg_param_menuRect, ewg_param_hitPt, ewg_param_whichItem) call_menu_def_proc_ptr ((void*)ewg_param_a_function, (short)ewg_param_message, (MenuRef)ewg_param_theMenu, (Rect*)ewg_param_menuRect, *(Point*)ewg_param_hitPt, (short*)ewg_param_whichItem)

void  ewg_function_call_menu_def_proc_ptr (void *a_function, short message, MenuRef theMenu, Rect *menuRect, Point *hitPt, short *whichItem);
// Wraps call to function 'get_control_action_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_action_proc_ptr_stub get_control_action_proc_ptr_stub ()

void * ewg_function_get_control_action_proc_ptr_stub (void);
// Wraps call to function 'set_control_action_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_action_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_action_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_action_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_action_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_action_proc_ptr(ewg_param_a_function, ewg_param_theControl, ewg_param_partCode) call_control_action_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_theControl, (ControlPartCode)ewg_param_partCode)

void  ewg_function_call_control_action_proc_ptr (void *a_function, ControlRef theControl, ControlPartCode partCode);
// Wraps call to function 'get_control_def_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_def_proc_ptr_stub get_control_def_proc_ptr_stub ()

void * ewg_function_get_control_def_proc_ptr_stub (void);
// Wraps call to function 'set_control_def_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_def_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_def_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_def_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_def_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_def_proc_ptr(ewg_param_a_function, ewg_param_varCode, ewg_param_theControl, ewg_param_message, ewg_param_param) call_control_def_proc_ptr ((void*)ewg_param_a_function, (SInt16)ewg_param_varCode, (ControlRef)ewg_param_theControl, (ControlDefProcMessage)ewg_param_message, (SInt32)ewg_param_param)

SInt32  ewg_function_call_control_def_proc_ptr (void *a_function, SInt16 varCode, ControlRef theControl, ControlDefProcMessage message, SInt32 param);
// Wraps call to function 'get_control_key_filter_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_key_filter_proc_ptr_stub get_control_key_filter_proc_ptr_stub ()

void * ewg_function_get_control_key_filter_proc_ptr_stub (void);
// Wraps call to function 'set_control_key_filter_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_key_filter_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_key_filter_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_key_filter_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_key_filter_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_key_filter_proc_ptr(ewg_param_a_function, ewg_param_theControl, ewg_param_keyCode, ewg_param_charCode, ewg_param_modifiers) call_control_key_filter_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_theControl, (SInt16*)ewg_param_keyCode, (SInt16*)ewg_param_charCode, (EventModifiers*)ewg_param_modifiers)

ControlKeyFilterResult  ewg_function_call_control_key_filter_proc_ptr (void *a_function, ControlRef theControl, SInt16 *keyCode, SInt16 *charCode, EventModifiers *modifiers);
// Wraps call to function 'get_control_cntlto_collection_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_cntlto_collection_proc_ptr_stub get_control_cntlto_collection_proc_ptr_stub ()

void * ewg_function_get_control_cntlto_collection_proc_ptr_stub (void);
// Wraps call to function 'set_control_cntlto_collection_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_cntlto_collection_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_cntlto_collection_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_cntlto_collection_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_cntlto_collection_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_cntlto_collection_proc_ptr(ewg_param_a_function, ewg_param_bounds, ewg_param_value, ewg_param_visible, ewg_param_max, ewg_param_min, ewg_param_procID, ewg_param_refCon, ewg_param_title, ewg_param_collection) call_control_cntlto_collection_proc_ptr ((void*)ewg_param_a_function, (Rect const*)ewg_param_bounds, (SInt16)ewg_param_value, (Boolean)ewg_param_visible, (SInt16)ewg_param_max, (SInt16)ewg_param_min, (SInt16)ewg_param_procID, (SInt32)ewg_param_refCon, (ConstStr255Param)ewg_param_title, (Collection)ewg_param_collection)

OSStatus  ewg_function_call_control_cntlto_collection_proc_ptr (void *a_function, Rect const *bounds, SInt16 value, Boolean visible, SInt16 max, SInt16 min, SInt16 procID, SInt32 refCon, ConstStr255Param title, Collection collection);
// Wraps call to function 'get_control_color_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_color_proc_ptr_stub get_control_color_proc_ptr_stub ()

void * ewg_function_get_control_color_proc_ptr_stub (void);
// Wraps call to function 'set_control_color_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_color_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_color_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_color_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_color_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_color_proc_ptr(ewg_param_a_function, ewg_param_inControl, ewg_param_inMessage, ewg_param_inDrawDepth, ewg_param_inDrawInColor) call_control_color_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_inControl, (SInt16)ewg_param_inMessage, (SInt16)ewg_param_inDrawDepth, (Boolean)ewg_param_inDrawInColor)

OSStatus  ewg_function_call_control_color_proc_ptr (void *a_function, ControlRef inControl, SInt16 inMessage, SInt16 inDrawDepth, Boolean inDrawInColor);
// Wraps call to function 'get_window_def_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_window_def_proc_ptr_stub get_window_def_proc_ptr_stub ()

void * ewg_function_get_window_def_proc_ptr_stub (void);
// Wraps call to function 'set_window_def_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_window_def_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_window_def_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_window_def_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_window_def_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_window_def_proc_ptr(ewg_param_a_function, ewg_param_varCode, ewg_param_window, ewg_param_message, ewg_param_param) call_window_def_proc_ptr ((void*)ewg_param_a_function, (short)ewg_param_varCode, (WindowRef)ewg_param_window, (short)ewg_param_message, (long)ewg_param_param)

long  ewg_function_call_window_def_proc_ptr (void *a_function, short varCode, WindowRef window, short message, long param);
// Wraps call to function 'get_window_paint_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_window_paint_proc_ptr_stub get_window_paint_proc_ptr_stub ()

void * ewg_function_get_window_paint_proc_ptr_stub (void);
// Wraps call to function 'set_window_paint_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_window_paint_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_window_paint_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_window_paint_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_window_paint_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_window_paint_proc_ptr(ewg_param_a_function, ewg_param_device, ewg_param_qdContext, ewg_param_window, ewg_param_inClientPaintRgn, ewg_param_outSystemPaintRgn, ewg_param_refCon) call_window_paint_proc_ptr ((void*)ewg_param_a_function, (GDHandle)ewg_param_device, (GrafPtr)ewg_param_qdContext, (WindowRef)ewg_param_window, (RgnHandle)ewg_param_inClientPaintRgn, (RgnHandle)ewg_param_outSystemPaintRgn, (void*)ewg_param_refCon)

OSStatus  ewg_function_call_window_paint_proc_ptr (void *a_function, GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon);
// Wraps call to function 'get_txnfind_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_txnfind_proc_ptr_stub get_txnfind_proc_ptr_stub ()

void * ewg_function_get_txnfind_proc_ptr_stub (void);
// Wraps call to function 'set_txnfind_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_txnfind_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_txnfind_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_txnfind_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_txnfind_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_txnfind_proc_ptr(ewg_param_a_function, ewg_param_matchData, ewg_param_iDataType, ewg_param_iMatchOptions, ewg_param_iSearchTextPtr, ewg_param_encoding, ewg_param_absStartOffset, ewg_param_searchTextLength, ewg_param_oStartMatch, ewg_param_oEndMatch, ewg_param_ofound, ewg_param_refCon) call_txnfind_proc_ptr ((void*)ewg_param_a_function, (TXNMatchTextRecord const*)ewg_param_matchData, (TXNDataType)ewg_param_iDataType, (TXNMatchOptions)ewg_param_iMatchOptions, (void const*)ewg_param_iSearchTextPtr, (TextEncoding)ewg_param_encoding, (TXNOffset)ewg_param_absStartOffset, (ByteCount)ewg_param_searchTextLength, (TXNOffset*)ewg_param_oStartMatch, (TXNOffset*)ewg_param_oEndMatch, (Boolean*)ewg_param_ofound, (UInt32)ewg_param_refCon)

OSStatus  ewg_function_call_txnfind_proc_ptr (void *a_function, TXNMatchTextRecord const *matchData, TXNDataType iDataType, TXNMatchOptions iMatchOptions, void const *iSearchTextPtr, TextEncoding encoding, TXNOffset absStartOffset, ByteCount searchTextLength, TXNOffset *oStartMatch, TXNOffset *oEndMatch, Boolean *ofound, UInt32 refCon);
// Wraps call to function 'get_txnaction_name_mapper_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_txnaction_name_mapper_proc_ptr_stub get_txnaction_name_mapper_proc_ptr_stub ()

void * ewg_function_get_txnaction_name_mapper_proc_ptr_stub (void);
// Wraps call to function 'set_txnaction_name_mapper_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_txnaction_name_mapper_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_txnaction_name_mapper_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_txnaction_name_mapper_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_txnaction_name_mapper_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_txnaction_name_mapper_proc_ptr(ewg_param_a_function, ewg_param_actionName, ewg_param_commandID, ewg_param_inUserData) call_txnaction_name_mapper_proc_ptr ((void*)ewg_param_a_function, (CFStringRef)ewg_param_actionName, (UInt32)ewg_param_commandID, (void*)ewg_param_inUserData)

CFStringRef  ewg_function_call_txnaction_name_mapper_proc_ptr (void *a_function, CFStringRef actionName, UInt32 commandID, void *inUserData);
// Wraps call to function 'get_txncontextual_menu_setup_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_txncontextual_menu_setup_proc_ptr_stub get_txncontextual_menu_setup_proc_ptr_stub ()

void * ewg_function_get_txncontextual_menu_setup_proc_ptr_stub (void);
// Wraps call to function 'set_txncontextual_menu_setup_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_txncontextual_menu_setup_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_txncontextual_menu_setup_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_txncontextual_menu_setup_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_txncontextual_menu_setup_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_txncontextual_menu_setup_proc_ptr(ewg_param_a_function, ewg_param_iContextualMenu, ewg_param_object, ewg_param_inUserData) call_txncontextual_menu_setup_proc_ptr ((void*)ewg_param_a_function, (MenuRef)ewg_param_iContextualMenu, (TXNObject)ewg_param_object, (void*)ewg_param_inUserData)

void  ewg_function_call_txncontextual_menu_setup_proc_ptr (void *a_function, MenuRef iContextualMenu, TXNObject object, void *inUserData);
// Wraps call to function 'get_txnscroll_info_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_txnscroll_info_proc_ptr_stub get_txnscroll_info_proc_ptr_stub ()

void * ewg_function_get_txnscroll_info_proc_ptr_stub (void);
// Wraps call to function 'set_txnscroll_info_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_txnscroll_info_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_txnscroll_info_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_txnscroll_info_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_txnscroll_info_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_txnscroll_info_proc_ptr(ewg_param_a_function, ewg_param_iValue, ewg_param_iMaximumValue, ewg_param_iScrollBarOrientation, ewg_param_iRefCon) call_txnscroll_info_proc_ptr ((void*)ewg_param_a_function, (SInt32)ewg_param_iValue, (SInt32)ewg_param_iMaximumValue, (TXNScrollBarOrientation)ewg_param_iScrollBarOrientation, (SInt32)ewg_param_iRefCon)

void  ewg_function_call_txnscroll_info_proc_ptr (void *a_function, SInt32 iValue, SInt32 iMaximumValue, TXNScrollBarOrientation iScrollBarOrientation, SInt32 iRefCon);
// Wraps call to function 'get_txnaction_key_mapper_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_txnaction_key_mapper_proc_ptr_stub get_txnaction_key_mapper_proc_ptr_stub ()

void * ewg_function_get_txnaction_key_mapper_proc_ptr_stub (void);
// Wraps call to function 'set_txnaction_key_mapper_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_txnaction_key_mapper_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_txnaction_key_mapper_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_txnaction_key_mapper_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_txnaction_key_mapper_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_txnaction_key_mapper_proc_ptr(ewg_param_a_function, ewg_param_actionKey, ewg_param_commandID) call_txnaction_key_mapper_proc_ptr ((void*)ewg_param_a_function, (TXNActionKey)ewg_param_actionKey, (UInt32)ewg_param_commandID)

CFStringRef  ewg_function_call_txnaction_key_mapper_proc_ptr (void *a_function, TXNActionKey actionKey, UInt32 commandID);
// Wraps call to function 'get_hmcontrol_content_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_hmcontrol_content_proc_ptr_stub get_hmcontrol_content_proc_ptr_stub ()

void * ewg_function_get_hmcontrol_content_proc_ptr_stub (void);
// Wraps call to function 'set_hmcontrol_content_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_hmcontrol_content_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_hmcontrol_content_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_hmcontrol_content_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_hmcontrol_content_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_hmcontrol_content_proc_ptr(ewg_param_a_function, ewg_param_inControl, ewg_param_inGlobalMouse, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent) call_hmcontrol_content_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_inControl, *(Point*)ewg_param_inGlobalMouse, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent)

OSStatus  ewg_function_call_hmcontrol_content_proc_ptr (void *a_function, ControlRef inControl, Point *inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent);
// Wraps call to function 'get_hmwindow_content_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_hmwindow_content_proc_ptr_stub get_hmwindow_content_proc_ptr_stub ()

void * ewg_function_get_hmwindow_content_proc_ptr_stub (void);
// Wraps call to function 'set_hmwindow_content_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_hmwindow_content_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_hmwindow_content_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_hmwindow_content_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_hmwindow_content_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_hmwindow_content_proc_ptr(ewg_param_a_function, ewg_param_inWindow, ewg_param_inGlobalMouse, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent) call_hmwindow_content_proc_ptr ((void*)ewg_param_a_function, (WindowRef)ewg_param_inWindow, *(Point*)ewg_param_inGlobalMouse, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent)

OSStatus  ewg_function_call_hmwindow_content_proc_ptr (void *a_function, WindowRef inWindow, Point *inGlobalMouse, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent);
// Wraps call to function 'get_hmmenu_title_content_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_hmmenu_title_content_proc_ptr_stub get_hmmenu_title_content_proc_ptr_stub ()

void * ewg_function_get_hmmenu_title_content_proc_ptr_stub (void);
// Wraps call to function 'set_hmmenu_title_content_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_hmmenu_title_content_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_hmmenu_title_content_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_hmmenu_title_content_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_hmmenu_title_content_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_hmmenu_title_content_proc_ptr(ewg_param_a_function, ewg_param_inMenu, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent) call_hmmenu_title_content_proc_ptr ((void*)ewg_param_a_function, (MenuRef)ewg_param_inMenu, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent)

OSStatus  ewg_function_call_hmmenu_title_content_proc_ptr (void *a_function, MenuRef inMenu, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent);
// Wraps call to function 'get_hmmenu_item_content_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_hmmenu_item_content_proc_ptr_stub get_hmmenu_item_content_proc_ptr_stub ()

void * ewg_function_get_hmmenu_item_content_proc_ptr_stub (void);
// Wraps call to function 'set_hmmenu_item_content_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_hmmenu_item_content_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_hmmenu_item_content_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_hmmenu_item_content_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_hmmenu_item_content_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_hmmenu_item_content_proc_ptr(ewg_param_a_function, ewg_param_inTrackingData, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent) call_hmmenu_item_content_proc_ptr ((void*)ewg_param_a_function, (MenuTrackingData const*)ewg_param_inTrackingData, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent)

OSStatus  ewg_function_call_hmmenu_item_content_proc_ptr (void *a_function, MenuTrackingData const *inTrackingData, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent);
// Wraps call to function 'get_control_user_pane_draw_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_draw_proc_ptr_stub get_control_user_pane_draw_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_draw_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_draw_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_draw_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_draw_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_draw_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_draw_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_draw_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_part) call_control_user_pane_draw_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, (SInt16)ewg_param_part)

void  ewg_function_call_control_user_pane_draw_proc_ptr (void *a_function, ControlRef control, SInt16 part);
// Wraps call to function 'get_control_user_pane_hit_test_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_hit_test_proc_ptr_stub get_control_user_pane_hit_test_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_hit_test_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_hit_test_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_hit_test_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_hit_test_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_hit_test_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_hit_test_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_hit_test_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_where) call_control_user_pane_hit_test_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, *(Point*)ewg_param_where)

ControlPartCode  ewg_function_call_control_user_pane_hit_test_proc_ptr (void *a_function, ControlRef control, Point *where);
// Wraps call to function 'get_control_user_pane_tracking_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_tracking_proc_ptr_stub get_control_user_pane_tracking_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_tracking_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_tracking_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_tracking_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_tracking_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_tracking_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_tracking_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_tracking_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_startPt, ewg_param_actionProc) call_control_user_pane_tracking_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, *(Point*)ewg_param_startPt, (ControlActionUPP)ewg_param_actionProc)

ControlPartCode  ewg_function_call_control_user_pane_tracking_proc_ptr (void *a_function, ControlRef control, Point *startPt, ControlActionUPP actionProc);
// Wraps call to function 'get_control_user_pane_idle_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_idle_proc_ptr_stub get_control_user_pane_idle_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_idle_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_idle_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_idle_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_idle_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_idle_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_idle_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_idle_proc_ptr(ewg_param_a_function, ewg_param_control) call_control_user_pane_idle_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control)

void  ewg_function_call_control_user_pane_idle_proc_ptr (void *a_function, ControlRef control);
// Wraps call to function 'get_control_user_pane_key_down_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_key_down_proc_ptr_stub get_control_user_pane_key_down_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_key_down_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_key_down_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_key_down_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_key_down_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_key_down_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_key_down_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_key_down_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_keyCode, ewg_param_charCode, ewg_param_modifiers) call_control_user_pane_key_down_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, (SInt16)ewg_param_keyCode, (SInt16)ewg_param_charCode, (SInt16)ewg_param_modifiers)

ControlPartCode  ewg_function_call_control_user_pane_key_down_proc_ptr (void *a_function, ControlRef control, SInt16 keyCode, SInt16 charCode, SInt16 modifiers);
// Wraps call to function 'get_control_user_pane_activate_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_activate_proc_ptr_stub get_control_user_pane_activate_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_activate_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_activate_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_activate_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_activate_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_activate_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_activate_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_activate_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_activating) call_control_user_pane_activate_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, (Boolean)ewg_param_activating)

void  ewg_function_call_control_user_pane_activate_proc_ptr (void *a_function, ControlRef control, Boolean activating);
// Wraps call to function 'get_control_user_pane_focus_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_focus_proc_ptr_stub get_control_user_pane_focus_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_focus_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_focus_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_focus_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_focus_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_focus_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_focus_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_focus_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_action) call_control_user_pane_focus_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, (ControlFocusPart)ewg_param_action)

ControlPartCode  ewg_function_call_control_user_pane_focus_proc_ptr (void *a_function, ControlRef control, ControlFocusPart action);
// Wraps call to function 'get_control_user_pane_background_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_control_user_pane_background_proc_ptr_stub get_control_user_pane_background_proc_ptr_stub ()

void * ewg_function_get_control_user_pane_background_proc_ptr_stub (void);
// Wraps call to function 'set_control_user_pane_background_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_control_user_pane_background_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_control_user_pane_background_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_control_user_pane_background_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_control_user_pane_background_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_control_user_pane_background_proc_ptr(ewg_param_a_function, ewg_param_control, ewg_param_info) call_control_user_pane_background_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_control, (ControlBackgroundPtr)ewg_param_info)

void  ewg_function_call_control_user_pane_background_proc_ptr (void *a_function, ControlRef control, ControlBackgroundPtr info);
// Wraps call to function 'get_data_browser_item_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_proc_ptr_stub get_data_browser_item_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_proc_ptr(ewg_param_a_function, ewg_param_item, ewg_param_state, ewg_param_clientData) call_data_browser_item_proc_ptr ((void*)ewg_param_a_function, (DataBrowserItemID)ewg_param_item, (DataBrowserItemState)ewg_param_state, (void*)ewg_param_clientData)

void  ewg_function_call_data_browser_item_proc_ptr (void *a_function, DataBrowserItemID item, DataBrowserItemState state, void *clientData);
// Wraps call to function 'get_data_browser_item_data_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_data_proc_ptr_stub get_data_browser_item_data_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_data_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_data_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_data_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_data_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_data_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_data_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_data_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_itemData, ewg_param_setValue) call_data_browser_item_data_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (DataBrowserItemDataRef)ewg_param_itemData, (Boolean)ewg_param_setValue)

OSStatus  ewg_function_call_data_browser_item_data_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemDataRef itemData, Boolean setValue);
// Wraps call to function 'get_data_browser_item_compare_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_compare_proc_ptr_stub get_data_browser_item_compare_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_compare_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_compare_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_compare_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_compare_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_compare_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_compare_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_compare_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemOne, ewg_param_itemTwo, ewg_param_sortProperty) call_data_browser_item_compare_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemOne, (DataBrowserItemID)ewg_param_itemTwo, (DataBrowserPropertyID)ewg_param_sortProperty)

Boolean  ewg_function_call_data_browser_item_compare_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemOne, DataBrowserItemID itemTwo, DataBrowserPropertyID sortProperty);
// Wraps call to function 'get_data_browser_item_notification_with_item_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_notification_with_item_proc_ptr_stub get_data_browser_item_notification_with_item_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_notification_with_item_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_notification_with_item_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_notification_with_item_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_notification_with_item_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_notification_with_item_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_notification_with_item_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_notification_with_item_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_message, ewg_param_itemData) call_data_browser_item_notification_with_item_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserItemNotification)ewg_param_message, (DataBrowserItemDataRef)ewg_param_itemData)

void  ewg_function_call_data_browser_item_notification_with_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message, DataBrowserItemDataRef itemData);
// Wraps call to function 'get_data_browser_item_notification_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_notification_proc_ptr_stub get_data_browser_item_notification_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_notification_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_notification_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_notification_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_notification_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_notification_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_notification_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_notification_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_message) call_data_browser_item_notification_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserItemNotification)ewg_param_message)

void  ewg_function_call_data_browser_item_notification_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserItemNotification message);
// Wraps call to function 'get_data_browser_add_drag_item_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_add_drag_item_proc_ptr_stub get_data_browser_add_drag_item_proc_ptr_stub ()

void * ewg_function_get_data_browser_add_drag_item_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_add_drag_item_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_add_drag_item_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_add_drag_item_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_add_drag_item_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_add_drag_item_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_add_drag_item_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_theDrag, ewg_param_item, ewg_param_itemRef) call_data_browser_add_drag_item_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (DataBrowserItemID)ewg_param_item, (ItemReference*)ewg_param_itemRef)

Boolean  ewg_function_call_data_browser_add_drag_item_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, DataBrowserItemID item, ItemReference *itemRef);
// Wraps call to function 'get_data_browser_accept_drag_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_accept_drag_proc_ptr_stub get_data_browser_accept_drag_proc_ptr_stub ()

void * ewg_function_get_data_browser_accept_drag_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_accept_drag_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_accept_drag_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_accept_drag_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_accept_drag_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_accept_drag_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_accept_drag_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_theDrag, ewg_param_item) call_data_browser_accept_drag_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (DataBrowserItemID)ewg_param_item)

Boolean  ewg_function_call_data_browser_accept_drag_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, DataBrowserItemID item);
// Wraps call to function 'get_data_browser_post_process_drag_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_post_process_drag_proc_ptr_stub get_data_browser_post_process_drag_proc_ptr_stub ()

void * ewg_function_get_data_browser_post_process_drag_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_post_process_drag_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_post_process_drag_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_post_process_drag_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_post_process_drag_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_post_process_drag_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_post_process_drag_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_theDrag, ewg_param_trackDragResult) call_data_browser_post_process_drag_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DragReference)ewg_param_theDrag, (OSStatus)ewg_param_trackDragResult)

void  ewg_function_call_data_browser_post_process_drag_proc_ptr (void *a_function, ControlRef browser, DragReference theDrag, OSStatus trackDragResult);
// Wraps call to function 'get_data_browser_get_contextual_menu_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_get_contextual_menu_proc_ptr_stub get_data_browser_get_contextual_menu_proc_ptr_stub ()

void * ewg_function_get_data_browser_get_contextual_menu_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_get_contextual_menu_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_get_contextual_menu_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_get_contextual_menu_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_get_contextual_menu_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_get_contextual_menu_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_get_contextual_menu_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_menu, ewg_param_helpType, ewg_param_helpItemString, ewg_param_selection) call_data_browser_get_contextual_menu_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (MenuRef*)ewg_param_menu, (UInt32*)ewg_param_helpType, (CFStringRef*)ewg_param_helpItemString, (AEDesc*)ewg_param_selection)

void  ewg_function_call_data_browser_get_contextual_menu_proc_ptr (void *a_function, ControlRef browser, MenuRef *menu, UInt32 *helpType, CFStringRef *helpItemString, AEDesc *selection);
// Wraps call to function 'get_data_browser_select_contextual_menu_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_select_contextual_menu_proc_ptr_stub get_data_browser_select_contextual_menu_proc_ptr_stub ()

void * ewg_function_get_data_browser_select_contextual_menu_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_select_contextual_menu_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_select_contextual_menu_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_select_contextual_menu_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_select_contextual_menu_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_select_contextual_menu_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_select_contextual_menu_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_menu, ewg_param_selectionType, ewg_param_menuID, ewg_param_menuItem) call_data_browser_select_contextual_menu_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (MenuRef)ewg_param_menu, (UInt32)ewg_param_selectionType, (SInt16)ewg_param_menuID, (MenuItemIndex)ewg_param_menuItem)

void  ewg_function_call_data_browser_select_contextual_menu_proc_ptr (void *a_function, ControlRef browser, MenuRef menu, UInt32 selectionType, SInt16 menuID, MenuItemIndex menuItem);
// Wraps call to function 'get_data_browser_item_help_content_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_help_content_proc_ptr_stub get_data_browser_item_help_content_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_help_content_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_help_content_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_help_content_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_help_content_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_help_content_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_help_content_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_help_content_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_inRequest, ewg_param_outContentProvided, ewg_param_ioHelpContent) call_data_browser_item_help_content_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (HMContentRequest)ewg_param_inRequest, (HMContentProvidedType*)ewg_param_outContentProvided, (HMHelpContentPtr)ewg_param_ioHelpContent)

void  ewg_function_call_data_browser_item_help_content_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, HMContentRequest inRequest, HMContentProvidedType *outContentProvided, HMHelpContentPtr ioHelpContent);
// Wraps call to function 'get_data_browser_draw_item_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_draw_item_proc_ptr_stub get_data_browser_draw_item_proc_ptr_stub ()

void * ewg_function_get_data_browser_draw_item_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_draw_item_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_draw_item_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_draw_item_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_draw_item_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_draw_item_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_draw_item_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_itemState, ewg_param_theRect, ewg_param_gdDepth, ewg_param_colorDevice) call_data_browser_draw_item_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (DataBrowserItemState)ewg_param_itemState, (Rect const*)ewg_param_theRect, (SInt16)ewg_param_gdDepth, (Boolean)ewg_param_colorDevice)

void  ewg_function_call_data_browser_draw_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, DataBrowserItemState itemState, Rect const *theRect, SInt16 gdDepth, Boolean colorDevice);
// Wraps call to function 'get_data_browser_edit_item_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_edit_item_proc_ptr_stub get_data_browser_edit_item_proc_ptr_stub ()

void * ewg_function_get_data_browser_edit_item_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_edit_item_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_edit_item_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_edit_item_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_edit_item_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_edit_item_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_edit_item_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_item, ewg_param_property, ewg_param_theString, ewg_param_maxEditTextRect, ewg_param_shrinkToFit) call_data_browser_edit_item_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_item, (DataBrowserPropertyID)ewg_param_property, (CFStringRef)ewg_param_theString, (Rect*)ewg_param_maxEditTextRect, (Boolean*)ewg_param_shrinkToFit)

Boolean  ewg_function_call_data_browser_edit_item_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID item, DataBrowserPropertyID property, CFStringRef theString, Rect *maxEditTextRect, Boolean *shrinkToFit);
// Wraps call to function 'get_data_browser_hit_test_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_hit_test_proc_ptr_stub get_data_browser_hit_test_proc_ptr_stub ()

void * ewg_function_get_data_browser_hit_test_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_hit_test_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_hit_test_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_hit_test_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_hit_test_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_hit_test_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_hit_test_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_mouseRect) call_data_browser_hit_test_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (Rect const*)ewg_param_mouseRect)

Boolean  ewg_function_call_data_browser_hit_test_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Rect const *mouseRect);
// Wraps call to function 'get_data_browser_tracking_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_tracking_proc_ptr_stub get_data_browser_tracking_proc_ptr_stub ()

void * ewg_function_get_data_browser_tracking_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_tracking_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_tracking_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_tracking_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_tracking_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_tracking_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_tracking_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_startPt, ewg_param_modifiers) call_data_browser_tracking_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, *(Point*)ewg_param_startPt, (EventModifiers)ewg_param_modifiers)

DataBrowserTrackingResult  ewg_function_call_data_browser_tracking_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, Point *startPt, EventModifiers modifiers);
// Wraps call to function 'get_data_browser_item_drag_rgn_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_drag_rgn_proc_ptr_stub get_data_browser_item_drag_rgn_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_drag_rgn_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_drag_rgn_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_drag_rgn_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_drag_rgn_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_drag_rgn_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_drag_rgn_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_drag_rgn_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_dragRgn) call_data_browser_item_drag_rgn_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (RgnHandle)ewg_param_dragRgn)

void  ewg_function_call_data_browser_item_drag_rgn_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, RgnHandle dragRgn);
// Wraps call to function 'get_data_browser_item_accept_drag_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_accept_drag_proc_ptr_stub get_data_browser_item_accept_drag_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_accept_drag_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_accept_drag_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_accept_drag_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_accept_drag_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_accept_drag_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_accept_drag_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_accept_drag_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_theRect, ewg_param_theDrag) call_data_browser_item_accept_drag_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (Rect const*)ewg_param_theRect, (DragReference)ewg_param_theDrag)

DataBrowserDragFlags  ewg_function_call_data_browser_item_accept_drag_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, Rect const *theRect, DragReference theDrag);
// Wraps call to function 'get_data_browser_item_receive_drag_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_data_browser_item_receive_drag_proc_ptr_stub get_data_browser_item_receive_drag_proc_ptr_stub ()

void * ewg_function_get_data_browser_item_receive_drag_proc_ptr_stub (void);
// Wraps call to function 'set_data_browser_item_receive_drag_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_data_browser_item_receive_drag_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_data_browser_item_receive_drag_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_data_browser_item_receive_drag_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_data_browser_item_receive_drag_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_data_browser_item_receive_drag_proc_ptr(ewg_param_a_function, ewg_param_browser, ewg_param_itemID, ewg_param_property, ewg_param_dragFlags, ewg_param_theDrag) call_data_browser_item_receive_drag_proc_ptr ((void*)ewg_param_a_function, (ControlRef)ewg_param_browser, (DataBrowserItemID)ewg_param_itemID, (DataBrowserPropertyID)ewg_param_property, (DataBrowserDragFlags)ewg_param_dragFlags, (DragReference)ewg_param_theDrag)

Boolean  ewg_function_call_data_browser_item_receive_drag_proc_ptr (void *a_function, ControlRef browser, DataBrowserItemID itemID, DataBrowserPropertyID property, DataBrowserDragFlags dragFlags, DragReference theDrag);
// Wraps call to function 'get_edit_unicode_post_update_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_edit_unicode_post_update_proc_ptr_stub get_edit_unicode_post_update_proc_ptr_stub ()

void * ewg_function_get_edit_unicode_post_update_proc_ptr_stub (void);
// Wraps call to function 'set_edit_unicode_post_update_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_edit_unicode_post_update_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_edit_unicode_post_update_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_edit_unicode_post_update_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_edit_unicode_post_update_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_edit_unicode_post_update_proc_ptr(ewg_param_a_function, ewg_param_uniText, ewg_param_uniTextLength, ewg_param_iStartOffset, ewg_param_iEndOffset, ewg_param_refcon) call_edit_unicode_post_update_proc_ptr ((void*)ewg_param_a_function, (UniCharArrayHandle)ewg_param_uniText, (UniCharCount)ewg_param_uniTextLength, (UniCharArrayOffset)ewg_param_iStartOffset, (UniCharArrayOffset)ewg_param_iEndOffset, (void*)ewg_param_refcon)

Boolean  ewg_function_call_edit_unicode_post_update_proc_ptr (void *a_function, UniCharArrayHandle uniText, UniCharCount uniTextLength, UniCharArrayOffset iStartOffset, UniCharArrayOffset iEndOffset, void *refcon);
// Wraps call to function 'get_nav_event_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_nav_event_proc_ptr_stub get_nav_event_proc_ptr_stub ()

void * ewg_function_get_nav_event_proc_ptr_stub (void);
// Wraps call to function 'set_nav_event_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_nav_event_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_nav_event_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_nav_event_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_nav_event_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_nav_event_proc_ptr(ewg_param_a_function, ewg_param_callBackSelector, ewg_param_callBackParms, ewg_param_callBackUD) call_nav_event_proc_ptr ((void*)ewg_param_a_function, (NavEventCallbackMessage)ewg_param_callBackSelector, (NavCBRecPtr)ewg_param_callBackParms, (void*)ewg_param_callBackUD)

void  ewg_function_call_nav_event_proc_ptr (void *a_function, NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void *callBackUD);
// Wraps call to function 'get_nav_preview_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_nav_preview_proc_ptr_stub get_nav_preview_proc_ptr_stub ()

void * ewg_function_get_nav_preview_proc_ptr_stub (void);
// Wraps call to function 'set_nav_preview_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_nav_preview_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_nav_preview_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_nav_preview_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_nav_preview_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_nav_preview_proc_ptr(ewg_param_a_function, ewg_param_callBackParms, ewg_param_callBackUD) call_nav_preview_proc_ptr ((void*)ewg_param_a_function, (NavCBRecPtr)ewg_param_callBackParms, (void*)ewg_param_callBackUD)

Boolean  ewg_function_call_nav_preview_proc_ptr (void *a_function, NavCBRecPtr callBackParms, void *callBackUD);
// Wraps call to function 'get_nav_object_filter_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_nav_object_filter_proc_ptr_stub get_nav_object_filter_proc_ptr_stub ()

void * ewg_function_get_nav_object_filter_proc_ptr_stub (void);
// Wraps call to function 'set_nav_object_filter_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_nav_object_filter_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_nav_object_filter_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_nav_object_filter_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_nav_object_filter_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_nav_object_filter_proc_ptr(ewg_param_a_function, ewg_param_theItem, ewg_param_info, ewg_param_callBackUD, ewg_param_filterMode) call_nav_object_filter_proc_ptr ((void*)ewg_param_a_function, (AEDesc*)ewg_param_theItem, (void*)ewg_param_info, (void*)ewg_param_callBackUD, (NavFilterModes)ewg_param_filterMode)

Boolean  ewg_function_call_nav_object_filter_proc_ptr (void *a_function, AEDesc *theItem, void *info, void *callBackUD, NavFilterModes filterMode);
// Wraps call to function 'get_color_changed_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_color_changed_proc_ptr_stub get_color_changed_proc_ptr_stub ()

void * ewg_function_get_color_changed_proc_ptr_stub (void);
// Wraps call to function 'set_color_changed_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_color_changed_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_color_changed_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_color_changed_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_color_changed_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_color_changed_proc_ptr(ewg_param_a_function, ewg_param_userData, ewg_param_newColor) call_color_changed_proc_ptr ((void*)ewg_param_a_function, (long)ewg_param_userData, (PMColor*)ewg_param_newColor)

void  ewg_function_call_color_changed_proc_ptr (void *a_function, long userData, PMColor *newColor);
// Wraps call to function 'get_ncolor_changed_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_ncolor_changed_proc_ptr_stub get_ncolor_changed_proc_ptr_stub ()

void * ewg_function_get_ncolor_changed_proc_ptr_stub (void);
// Wraps call to function 'set_ncolor_changed_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_ncolor_changed_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_ncolor_changed_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_ncolor_changed_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_ncolor_changed_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_ncolor_changed_proc_ptr(ewg_param_a_function, ewg_param_userData, ewg_param_newColor) call_ncolor_changed_proc_ptr ((void*)ewg_param_a_function, (long)ewg_param_userData, (NPMColor*)ewg_param_newColor)

void  ewg_function_call_ncolor_changed_proc_ptr (void *a_function, long userData, NPMColor *newColor);
// Wraps call to function 'get_user_event_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_user_event_proc_ptr_stub get_user_event_proc_ptr_stub ()

void * ewg_function_get_user_event_proc_ptr_stub (void);
// Wraps call to function 'set_user_event_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_user_event_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_user_event_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_user_event_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_user_event_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_user_event_proc_ptr(ewg_param_a_function, ewg_param_event) call_user_event_proc_ptr ((void*)ewg_param_a_function, (EventRecord*)ewg_param_event)

Boolean  ewg_function_call_user_event_proc_ptr (void *a_function, EventRecord *event);
// Wraps call to function 'get_cfcomparator_function_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfcomparator_function_stub get_cfcomparator_function_stub ()

void * ewg_function_get_cfcomparator_function_stub (void);
// Wraps call to function 'set_cfcomparator_function_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfcomparator_function_entry(ewg_param_a_class, ewg_param_a_feature) set_cfcomparator_function_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfcomparator_function_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfcomparator_function' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfcomparator_function(ewg_param_a_function, ewg_param_val1, ewg_param_val2, ewg_param_context) call_cfcomparator_function ((void*)ewg_param_a_function, (void const*)ewg_param_val1, (void const*)ewg_param_val2, (void*)ewg_param_context)

CFComparisonResult  ewg_function_call_cfcomparator_function (void *a_function, void const *val1, void const *val2, void *context);
// Wraps call to function 'get_cfallocator_retain_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_retain_call_back_stub get_cfallocator_retain_call_back_stub ()

void * ewg_function_get_cfallocator_retain_call_back_stub (void);
// Wraps call to function 'set_cfallocator_retain_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_retain_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_retain_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_retain_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_retain_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_retain_call_back(ewg_param_a_function, ewg_param_info) call_cfallocator_retain_call_back ((void*)ewg_param_a_function, (void const*)ewg_param_info)

void const * ewg_function_call_cfallocator_retain_call_back (void *a_function, void const *info);
// Wraps call to function 'get_cfallocator_release_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_release_call_back_stub get_cfallocator_release_call_back_stub ()

void * ewg_function_get_cfallocator_release_call_back_stub (void);
// Wraps call to function 'set_cfallocator_release_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_release_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_release_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_release_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_release_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_release_call_back(ewg_param_a_function, ewg_param_info) call_cfallocator_release_call_back ((void*)ewg_param_a_function, (void const*)ewg_param_info)

void  ewg_function_call_cfallocator_release_call_back (void *a_function, void const *info);
// Wraps call to function 'get_cfallocator_copy_description_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_copy_description_call_back_stub get_cfallocator_copy_description_call_back_stub ()

void * ewg_function_get_cfallocator_copy_description_call_back_stub (void);
// Wraps call to function 'set_cfallocator_copy_description_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_copy_description_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_copy_description_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_copy_description_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_copy_description_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_copy_description_call_back(ewg_param_a_function, ewg_param_info) call_cfallocator_copy_description_call_back ((void*)ewg_param_a_function, (void const*)ewg_param_info)

CFStringRef  ewg_function_call_cfallocator_copy_description_call_back (void *a_function, void const *info);
// Wraps call to function 'get_cfallocator_allocate_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_allocate_call_back_stub get_cfallocator_allocate_call_back_stub ()

void * ewg_function_get_cfallocator_allocate_call_back_stub (void);
// Wraps call to function 'set_cfallocator_allocate_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_allocate_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_allocate_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_allocate_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_allocate_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_allocate_call_back(ewg_param_a_function, ewg_param_allocSize, ewg_param_hint, ewg_param_info) call_cfallocator_allocate_call_back ((void*)ewg_param_a_function, (CFIndex)ewg_param_allocSize, (CFOptionFlags)ewg_param_hint, (void*)ewg_param_info)

void * ewg_function_call_cfallocator_allocate_call_back (void *a_function, CFIndex allocSize, CFOptionFlags hint, void *info);
// Wraps call to function 'get_cfallocator_reallocate_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_reallocate_call_back_stub get_cfallocator_reallocate_call_back_stub ()

void * ewg_function_get_cfallocator_reallocate_call_back_stub (void);
// Wraps call to function 'set_cfallocator_reallocate_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_reallocate_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_reallocate_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_reallocate_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_reallocate_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_reallocate_call_back(ewg_param_a_function, ewg_param_ptr, ewg_param_newsize, ewg_param_hint, ewg_param_info) call_cfallocator_reallocate_call_back ((void*)ewg_param_a_function, (void*)ewg_param_ptr, (CFIndex)ewg_param_newsize, (CFOptionFlags)ewg_param_hint, (void*)ewg_param_info)

void * ewg_function_call_cfallocator_reallocate_call_back (void *a_function, void *ptr, CFIndex newsize, CFOptionFlags hint, void *info);
// Wraps call to function 'get_cfallocator_deallocate_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_deallocate_call_back_stub get_cfallocator_deallocate_call_back_stub ()

void * ewg_function_get_cfallocator_deallocate_call_back_stub (void);
// Wraps call to function 'set_cfallocator_deallocate_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_deallocate_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_deallocate_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_deallocate_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_deallocate_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_deallocate_call_back(ewg_param_a_function, ewg_param_ptr, ewg_param_info) call_cfallocator_deallocate_call_back ((void*)ewg_param_a_function, (void*)ewg_param_ptr, (void*)ewg_param_info)

void  ewg_function_call_cfallocator_deallocate_call_back (void *a_function, void *ptr, void *info);
// Wraps call to function 'get_cfallocator_preferred_size_call_back_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfallocator_preferred_size_call_back_stub get_cfallocator_preferred_size_call_back_stub ()

void * ewg_function_get_cfallocator_preferred_size_call_back_stub (void);
// Wraps call to function 'set_cfallocator_preferred_size_call_back_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfallocator_preferred_size_call_back_entry(ewg_param_a_class, ewg_param_a_feature) set_cfallocator_preferred_size_call_back_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfallocator_preferred_size_call_back_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfallocator_preferred_size_call_back' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfallocator_preferred_size_call_back(ewg_param_a_function, ewg_param_size, ewg_param_hint, ewg_param_info) call_cfallocator_preferred_size_call_back ((void*)ewg_param_a_function, (CFIndex)ewg_param_size, (CFOptionFlags)ewg_param_hint, (void*)ewg_param_info)

CFIndex  ewg_function_call_cfallocator_preferred_size_call_back (void *a_function, CFIndex size, CFOptionFlags hint, void *info);
// Wraps call to function 'get_cgdata_provider_get_bytes_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_get_bytes_callback_stub get_cgdata_provider_get_bytes_callback_stub ()

void * ewg_function_get_cgdata_provider_get_bytes_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_get_bytes_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_get_bytes_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_get_bytes_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_get_bytes_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_get_bytes_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_get_bytes_callback(ewg_param_a_function, ewg_param_info, ewg_param_buffer, ewg_param_count) call_cgdata_provider_get_bytes_callback ((void*)ewg_param_a_function, (void*)ewg_param_info, (void*)ewg_param_buffer, (size_t)ewg_param_count)

size_t  ewg_function_call_cgdata_provider_get_bytes_callback (void *a_function, void *info, void *buffer, size_t count);
// Wraps call to function 'get_cgdata_provider_skip_bytes_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_skip_bytes_callback_stub get_cgdata_provider_skip_bytes_callback_stub ()

void * ewg_function_get_cgdata_provider_skip_bytes_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_skip_bytes_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_skip_bytes_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_skip_bytes_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_skip_bytes_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_skip_bytes_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_skip_bytes_callback(ewg_param_a_function, ewg_param_info, ewg_param_count) call_cgdata_provider_skip_bytes_callback ((void*)ewg_param_a_function, (void*)ewg_param_info, (size_t)ewg_param_count)

void  ewg_function_call_cgdata_provider_skip_bytes_callback (void *a_function, void *info, size_t count);
// Wraps call to function 'get_wsclient_context_release_call_back_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_wsclient_context_release_call_back_proc_ptr_stub get_wsclient_context_release_call_back_proc_ptr_stub ()

void * ewg_function_get_wsclient_context_release_call_back_proc_ptr_stub (void);
// Wraps call to function 'set_wsclient_context_release_call_back_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_wsclient_context_release_call_back_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_wsclient_context_release_call_back_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_wsclient_context_release_call_back_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_wsclient_context_release_call_back_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_wsclient_context_release_call_back_proc_ptr(ewg_param_a_function, ewg_param_info) call_wsclient_context_release_call_back_proc_ptr ((void*)ewg_param_a_function, (void*)ewg_param_info)

void  ewg_function_call_wsclient_context_release_call_back_proc_ptr (void *a_function, void *info);
// Wraps call to function 'get_cgdata_provider_get_byte_pointer_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_get_byte_pointer_callback_stub get_cgdata_provider_get_byte_pointer_callback_stub ()

void * ewg_function_get_cgdata_provider_get_byte_pointer_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_get_byte_pointer_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_get_byte_pointer_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_get_byte_pointer_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_get_byte_pointer_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_get_byte_pointer_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_get_byte_pointer_callback(ewg_param_a_function, ewg_param_info) call_cgdata_provider_get_byte_pointer_callback ((void*)ewg_param_a_function, (void*)ewg_param_info)

void const * ewg_function_call_cgdata_provider_get_byte_pointer_callback (void *a_function, void *info);
// Wraps call to function 'get_cgdata_provider_release_byte_pointer_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_release_byte_pointer_callback_stub get_cgdata_provider_release_byte_pointer_callback_stub ()

void * ewg_function_get_cgdata_provider_release_byte_pointer_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_release_byte_pointer_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_release_byte_pointer_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_release_byte_pointer_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_release_byte_pointer_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_release_byte_pointer_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_release_byte_pointer_callback(ewg_param_a_function, ewg_param_info, ewg_param_pointer) call_cgdata_provider_release_byte_pointer_callback ((void*)ewg_param_a_function, (void*)ewg_param_info, (void const*)ewg_param_pointer)

void  ewg_function_call_cgdata_provider_release_byte_pointer_callback (void *a_function, void *info, void const *pointer);
// Wraps call to function 'get_cgdata_provider_get_bytes_at_offset_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cgdata_provider_get_bytes_at_offset_callback_stub get_cgdata_provider_get_bytes_at_offset_callback_stub ()

void * ewg_function_get_cgdata_provider_get_bytes_at_offset_callback_stub (void);
// Wraps call to function 'set_cgdata_provider_get_bytes_at_offset_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cgdata_provider_get_bytes_at_offset_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_cgdata_provider_get_bytes_at_offset_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cgdata_provider_get_bytes_at_offset_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cgdata_provider_get_bytes_at_offset_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cgdata_provider_get_bytes_at_offset_callback(ewg_param_a_function, ewg_param_info, ewg_param_buffer, ewg_param_offset, ewg_param_count) call_cgdata_provider_get_bytes_at_offset_callback ((void*)ewg_param_a_function, (void*)ewg_param_info, (void*)ewg_param_buffer, (size_t)ewg_param_offset, (size_t)ewg_param_count)

size_t  ewg_function_call_cgdata_provider_get_bytes_at_offset_callback (void *a_function, void *info, void *buffer, size_t offset, size_t count);
// Wraps call to function 'get_cfrag_term_procedure_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_cfrag_term_procedure_stub get_cfrag_term_procedure_stub ()

void * ewg_function_get_cfrag_term_procedure_stub (void);
// Wraps call to function 'set_cfrag_term_procedure_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_cfrag_term_procedure_entry(ewg_param_a_class, ewg_param_a_feature) set_cfrag_term_procedure_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_cfrag_term_procedure_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_cfrag_term_procedure' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_cfrag_term_procedure(ewg_param_a_function) call_cfrag_term_procedure ((void*)ewg_param_a_function)

void  ewg_function_call_cfrag_term_procedure (void *a_function);
// Wraps call to function 'get_get_next_event_filter_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_get_next_event_filter_proc_ptr_stub get_get_next_event_filter_proc_ptr_stub ()

void * ewg_function_get_get_next_event_filter_proc_ptr_stub (void);
// Wraps call to function 'set_get_next_event_filter_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_get_next_event_filter_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_get_next_event_filter_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_get_next_event_filter_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_get_next_event_filter_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_get_next_event_filter_proc_ptr(ewg_param_a_function, ewg_param_theEvent, ewg_param_result) call_get_next_event_filter_proc_ptr ((void*)ewg_param_a_function, (EventRecord*)ewg_param_theEvent, (Boolean*)ewg_param_result)

void  ewg_function_call_get_next_event_filter_proc_ptr (void *a_function, EventRecord *theEvent, Boolean *result);
// Wraps call to function 'get_menu_bar_def_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_menu_bar_def_proc_ptr_stub get_menu_bar_def_proc_ptr_stub ()

void * ewg_function_get_menu_bar_def_proc_ptr_stub (void);
// Wraps call to function 'set_menu_bar_def_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_menu_bar_def_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_menu_bar_def_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_menu_bar_def_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_menu_bar_def_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_menu_bar_def_proc_ptr(ewg_param_a_function, ewg_param_selector, ewg_param_message, ewg_param_parameter1, ewg_param_parameter2) call_menu_bar_def_proc_ptr ((void*)ewg_param_a_function, (short)ewg_param_selector, (short)ewg_param_message, (short)ewg_param_parameter1, (long)ewg_param_parameter2)

long  ewg_function_call_menu_bar_def_proc_ptr (void *a_function, short selector, short message, short parameter1, long parameter2);
// Wraps call to function 'get_mbar_hook_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_mbar_hook_proc_ptr_stub get_mbar_hook_proc_ptr_stub ()

void * ewg_function_get_mbar_hook_proc_ptr_stub (void);
// Wraps call to function 'set_mbar_hook_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_mbar_hook_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_mbar_hook_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_mbar_hook_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_mbar_hook_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_mbar_hook_proc_ptr(ewg_param_a_function, ewg_param_menuRect) call_mbar_hook_proc_ptr ((void*)ewg_param_a_function, (Rect*)ewg_param_menuRect)

short  ewg_function_call_mbar_hook_proc_ptr (void *a_function, Rect *menuRect);
// Wraps call to function 'get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub ()

void * ewg_function_get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub (void);
// Wraps call to function 'set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback(ewg_param_a_function, ewg_param_thisPointer, ewg_param_iid, ewg_param_ppv) call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback ((void*)ewg_param_a_function, (void*)ewg_param_thisPointer, *(CFUUIDBytes*)ewg_param_iid, (void**)ewg_param_ppv)

SInt32  ewg_function_call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback (void *a_function, void *thisPointer, CFUUIDBytes *iid, void **ppv);
// Wraps call to function 'get_uint32_voidp_anonymous_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_uint32_voidp_anonymous_callback_stub get_uint32_voidp_anonymous_callback_stub ()

void * ewg_function_get_uint32_voidp_anonymous_callback_stub (void);
// Wraps call to function 'set_uint32_voidp_anonymous_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_uint32_voidp_anonymous_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_uint32_voidp_anonymous_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_uint32_voidp_anonymous_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_uint32_voidp_anonymous_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_uint32_voidp_anonymous_callback(ewg_param_a_function, ewg_param_thisPointer) call_uint32_voidp_anonymous_callback ((void*)ewg_param_a_function, (void*)ewg_param_thisPointer)

UInt32  ewg_function_call_uint32_voidp_anonymous_callback (void *a_function, void *thisPointer);
// Wraps call to function 'get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub ()

void * ewg_function_get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub (void);
// Wraps call to function 'set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback(ewg_param_a_function, ewg_param_thisInstance, ewg_param_inContext, ewg_param_outCommandPairs) call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback ((void*)ewg_param_a_function, (void*)ewg_param_thisInstance, (AEDesc const*)ewg_param_inContext, (AEDescList*)ewg_param_outCommandPairs)

OSStatus  ewg_function_call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback (void *a_function, void *thisInstance, AEDesc const *inContext, AEDescList *outCommandPairs);
// Wraps call to function 'get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub ()

void * ewg_function_get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub (void);
// Wraps call to function 'set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_osstatus_voidp_aedescp_sint32_anonymous_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_osstatus_voidp_aedescp_sint32_anonymous_callback(ewg_param_a_function, ewg_param_thisInstance, ewg_param_inContext, ewg_param_inCommandID) call_osstatus_voidp_aedescp_sint32_anonymous_callback ((void*)ewg_param_a_function, (void*)ewg_param_thisInstance, (AEDesc*)ewg_param_inContext, (SInt32)ewg_param_inCommandID)

OSStatus  ewg_function_call_osstatus_voidp_aedescp_sint32_anonymous_callback (void *a_function, void *thisInstance, AEDesc *inContext, SInt32 inCommandID);
// Wraps call to function 'get_void_voidp_anonymous_callback_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_void_voidp_anonymous_callback_stub get_void_voidp_anonymous_callback_stub ()

void * ewg_function_get_void_voidp_anonymous_callback_stub (void);
// Wraps call to function 'set_void_voidp_anonymous_callback_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_void_voidp_anonymous_callback_entry(ewg_param_a_class, ewg_param_a_feature) set_void_voidp_anonymous_callback_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_void_voidp_anonymous_callback_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_void_voidp_anonymous_callback' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_void_voidp_anonymous_callback(ewg_param_a_function, ewg_param_thisInstance) call_void_voidp_anonymous_callback ((void*)ewg_param_a_function, (void*)ewg_param_thisInstance)

void  ewg_function_call_void_voidp_anonymous_callback (void *a_function, void *thisInstance);
// Wraps call to function 'get_desk_hook_proc_ptr_stub' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_get_desk_hook_proc_ptr_stub get_desk_hook_proc_ptr_stub ()

void * ewg_function_get_desk_hook_proc_ptr_stub (void);
// Wraps call to function 'set_desk_hook_proc_ptr_entry' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_set_desk_hook_proc_ptr_entry(ewg_param_a_class, ewg_param_a_feature) set_desk_hook_proc_ptr_entry ((void*)ewg_param_a_class, (void*)ewg_param_a_feature)

void  ewg_function_set_desk_hook_proc_ptr_entry (void *a_class, void *a_feature);
// Wraps call to function 'call_desk_hook_proc_ptr' in a macro
#include <ewg_carbon_callback_c_glue_code.h>

#define ewg_function_macro_call_desk_hook_proc_ptr(ewg_param_a_function, ewg_param_mouseClick, ewg_param_theEvent) call_desk_hook_proc_ptr ((void*)ewg_param_a_function, (Boolean)ewg_param_mouseClick, (EventRecord*)ewg_param_theEvent)

void  ewg_function_call_desk_hook_proc_ptr (void *a_function, Boolean mouseClick, EventRecord *theEvent);
