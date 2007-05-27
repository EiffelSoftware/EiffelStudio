#include <Carbon/Carbon.h>

// Wraps call to function '__CFRangeMake'
// For ise
CFRange * ewg_function___CFRangeMake (CFIndex ewg_loc, CFIndex ewg_len)
{
	CFRange *result = (CFRange*) malloc (sizeof(CFRange));
	*result = __CFRangeMake ((CFIndex)ewg_loc, (CFIndex)ewg_len);
	return result;
}

// Return address of function '__CFRangeMake'
void* ewg_get_function_address___CFRangeMake (void)
{
	return (void*) __CFRangeMake;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFNullGetTypeID'
// For ise
CFTypeID  ewg_function_CFNullGetTypeID (void)
{
	return CFNullGetTypeID ();
}

// Return address of function 'CFNullGetTypeID'
void* ewg_get_function_address_CFNullGetTypeID (void)
{
	return (void*) CFNullGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorGetTypeID'
// For ise
CFTypeID  ewg_function_CFAllocatorGetTypeID (void)
{
	return CFAllocatorGetTypeID ();
}

// Return address of function 'CFAllocatorGetTypeID'
void* ewg_get_function_address_CFAllocatorGetTypeID (void)
{
	return (void*) CFAllocatorGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorSetDefault'
// For ise
void  ewg_function_CFAllocatorSetDefault (CFAllocatorRef ewg_allocator)
{
	CFAllocatorSetDefault ((CFAllocatorRef)ewg_allocator);
}

// Return address of function 'CFAllocatorSetDefault'
void* ewg_get_function_address_CFAllocatorSetDefault (void)
{
	return (void*) CFAllocatorSetDefault;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorGetDefault'
// For ise
CFAllocatorRef  ewg_function_CFAllocatorGetDefault (void)
{
	return CFAllocatorGetDefault ();
}

// Return address of function 'CFAllocatorGetDefault'
void* ewg_get_function_address_CFAllocatorGetDefault (void)
{
	return (void*) CFAllocatorGetDefault;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorCreate'
// For ise
CFAllocatorRef  ewg_function_CFAllocatorCreate (CFAllocatorRef ewg_allocator, CFAllocatorContext *ewg_context)
{
	return CFAllocatorCreate ((CFAllocatorRef)ewg_allocator, (CFAllocatorContext*)ewg_context);
}

// Return address of function 'CFAllocatorCreate'
void* ewg_get_function_address_CFAllocatorCreate (void)
{
	return (void*) CFAllocatorCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorAllocate'
// For ise
void * ewg_function_CFAllocatorAllocate (CFAllocatorRef ewg_allocator, CFIndex ewg_size, CFOptionFlags ewg_hint)
{
	return CFAllocatorAllocate ((CFAllocatorRef)ewg_allocator, (CFIndex)ewg_size, (CFOptionFlags)ewg_hint);
}

// Return address of function 'CFAllocatorAllocate'
void* ewg_get_function_address_CFAllocatorAllocate (void)
{
	return (void*) CFAllocatorAllocate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorReallocate'
// For ise
void * ewg_function_CFAllocatorReallocate (CFAllocatorRef ewg_allocator, void *ewg_ptr, CFIndex ewg_newsize, CFOptionFlags ewg_hint)
{
	return CFAllocatorReallocate ((CFAllocatorRef)ewg_allocator, (void*)ewg_ptr, (CFIndex)ewg_newsize, (CFOptionFlags)ewg_hint);
}

// Return address of function 'CFAllocatorReallocate'
void* ewg_get_function_address_CFAllocatorReallocate (void)
{
	return (void*) CFAllocatorReallocate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorDeallocate'
// For ise
void  ewg_function_CFAllocatorDeallocate (CFAllocatorRef ewg_allocator, void *ewg_ptr)
{
	CFAllocatorDeallocate ((CFAllocatorRef)ewg_allocator, (void*)ewg_ptr);
}

// Return address of function 'CFAllocatorDeallocate'
void* ewg_get_function_address_CFAllocatorDeallocate (void)
{
	return (void*) CFAllocatorDeallocate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorGetPreferredSizeForSize'
// For ise
CFIndex  ewg_function_CFAllocatorGetPreferredSizeForSize (CFAllocatorRef ewg_allocator, CFIndex ewg_size, CFOptionFlags ewg_hint)
{
	return CFAllocatorGetPreferredSizeForSize ((CFAllocatorRef)ewg_allocator, (CFIndex)ewg_size, (CFOptionFlags)ewg_hint);
}

// Return address of function 'CFAllocatorGetPreferredSizeForSize'
void* ewg_get_function_address_CFAllocatorGetPreferredSizeForSize (void)
{
	return (void*) CFAllocatorGetPreferredSizeForSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFAllocatorGetContext'
// For ise
void  ewg_function_CFAllocatorGetContext (CFAllocatorRef ewg_allocator, CFAllocatorContext *ewg_context)
{
	CFAllocatorGetContext ((CFAllocatorRef)ewg_allocator, (CFAllocatorContext*)ewg_context);
}

// Return address of function 'CFAllocatorGetContext'
void* ewg_get_function_address_CFAllocatorGetContext (void)
{
	return (void*) CFAllocatorGetContext;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFGetTypeID'
// For ise
CFTypeID  ewg_function_CFGetTypeID (CFTypeRef ewg_cf)
{
	return CFGetTypeID ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFGetTypeID'
void* ewg_get_function_address_CFGetTypeID (void)
{
	return (void*) CFGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFCopyTypeIDDescription'
// For ise
CFStringRef  ewg_function_CFCopyTypeIDDescription (CFTypeID ewg_type_id)
{
	return CFCopyTypeIDDescription ((CFTypeID)ewg_type_id);
}

// Return address of function 'CFCopyTypeIDDescription'
void* ewg_get_function_address_CFCopyTypeIDDescription (void)
{
	return (void*) CFCopyTypeIDDescription;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFRetain'
// For ise
CFTypeRef  ewg_function_CFRetain (CFTypeRef ewg_cf)
{
	return CFRetain ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFRetain'
void* ewg_get_function_address_CFRetain (void)
{
	return (void*) CFRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFRelease'
// For ise
void  ewg_function_CFRelease (CFTypeRef ewg_cf)
{
	CFRelease ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFRelease'
void* ewg_get_function_address_CFRelease (void)
{
	return (void*) CFRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFGetRetainCount'
// For ise
CFIndex  ewg_function_CFGetRetainCount (CFTypeRef ewg_cf)
{
	return CFGetRetainCount ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFGetRetainCount'
void* ewg_get_function_address_CFGetRetainCount (void)
{
	return (void*) CFGetRetainCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFMakeCollectable'
// For ise
CFTypeRef  ewg_function_CFMakeCollectable (CFTypeRef ewg_cf)
{
	return CFMakeCollectable ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFMakeCollectable'
void* ewg_get_function_address_CFMakeCollectable (void)
{
	return (void*) CFMakeCollectable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFEqual'
// For ise
Boolean  ewg_function_CFEqual (CFTypeRef ewg_cf1, CFTypeRef ewg_cf2)
{
	return CFEqual ((CFTypeRef)ewg_cf1, (CFTypeRef)ewg_cf2);
}

// Return address of function 'CFEqual'
void* ewg_get_function_address_CFEqual (void)
{
	return (void*) CFEqual;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFHash'
// For ise
CFHashCode  ewg_function_CFHash (CFTypeRef ewg_cf)
{
	return CFHash ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFHash'
void* ewg_get_function_address_CFHash (void)
{
	return (void*) CFHash;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFCopyDescription'
// For ise
CFStringRef  ewg_function_CFCopyDescription (CFTypeRef ewg_cf)
{
	return CFCopyDescription ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFCopyDescription'
void* ewg_get_function_address_CFCopyDescription (void)
{
	return (void*) CFCopyDescription;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFGetAllocator'
// For ise
CFAllocatorRef  ewg_function_CFGetAllocator (CFTypeRef ewg_cf)
{
	return CFGetAllocator ((CFTypeRef)ewg_cf);
}

// Return address of function 'CFGetAllocator'
void* ewg_get_function_address_CFGetAllocator (void)
{
	return (void*) CFGetAllocator;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetTypeID'
// For ise
CFTypeID  ewg_function_CFStringGetTypeID (void)
{
	return CFStringGetTypeID ();
}

// Return address of function 'CFStringGetTypeID'
void* ewg_get_function_address_CFStringGetTypeID (void)
{
	return (void*) CFStringGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithPascalString'
// For ise
CFStringRef  ewg_function_CFStringCreateWithPascalString (CFAllocatorRef ewg_alloc, ConstStr255Param ewg_pStr, CFStringEncoding ewg_encoding)
{
	return CFStringCreateWithPascalString ((CFAllocatorRef)ewg_alloc, (ConstStr255Param)ewg_pStr, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringCreateWithPascalString'
void* ewg_get_function_address_CFStringCreateWithPascalString (void)
{
	return (void*) CFStringCreateWithPascalString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithCString'
// For ise
CFStringRef  ewg_function_CFStringCreateWithCString (CFAllocatorRef ewg_alloc, char const *ewg_cStr, CFStringEncoding ewg_encoding)
{
	return CFStringCreateWithCString ((CFAllocatorRef)ewg_alloc, (char const*)ewg_cStr, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringCreateWithCString'
void* ewg_get_function_address_CFStringCreateWithCString (void)
{
	return (void*) CFStringCreateWithCString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithCharacters'
// For ise
CFStringRef  ewg_function_CFStringCreateWithCharacters (CFAllocatorRef ewg_alloc, UniChar const *ewg_chars, CFIndex ewg_numChars)
{
	return CFStringCreateWithCharacters ((CFAllocatorRef)ewg_alloc, (UniChar const*)ewg_chars, (CFIndex)ewg_numChars);
}

// Return address of function 'CFStringCreateWithCharacters'
void* ewg_get_function_address_CFStringCreateWithCharacters (void)
{
	return (void*) CFStringCreateWithCharacters;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithPascalStringNoCopy'
// For ise
CFStringRef  ewg_function_CFStringCreateWithPascalStringNoCopy (CFAllocatorRef ewg_alloc, ConstStr255Param ewg_pStr, CFStringEncoding ewg_encoding, CFAllocatorRef ewg_contentsDeallocator)
{
	return CFStringCreateWithPascalStringNoCopy ((CFAllocatorRef)ewg_alloc, (ConstStr255Param)ewg_pStr, (CFStringEncoding)ewg_encoding, (CFAllocatorRef)ewg_contentsDeallocator);
}

// Return address of function 'CFStringCreateWithPascalStringNoCopy'
void* ewg_get_function_address_CFStringCreateWithPascalStringNoCopy (void)
{
	return (void*) CFStringCreateWithPascalStringNoCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithCStringNoCopy'
// For ise
CFStringRef  ewg_function_CFStringCreateWithCStringNoCopy (CFAllocatorRef ewg_alloc, char const *ewg_cStr, CFStringEncoding ewg_encoding, CFAllocatorRef ewg_contentsDeallocator)
{
	return CFStringCreateWithCStringNoCopy ((CFAllocatorRef)ewg_alloc, (char const*)ewg_cStr, (CFStringEncoding)ewg_encoding, (CFAllocatorRef)ewg_contentsDeallocator);
}

// Return address of function 'CFStringCreateWithCStringNoCopy'
void* ewg_get_function_address_CFStringCreateWithCStringNoCopy (void)
{
	return (void*) CFStringCreateWithCStringNoCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithCharactersNoCopy'
// For ise
CFStringRef  ewg_function_CFStringCreateWithCharactersNoCopy (CFAllocatorRef ewg_alloc, UniChar const *ewg_chars, CFIndex ewg_numChars, CFAllocatorRef ewg_contentsDeallocator)
{
	return CFStringCreateWithCharactersNoCopy ((CFAllocatorRef)ewg_alloc, (UniChar const*)ewg_chars, (CFIndex)ewg_numChars, (CFAllocatorRef)ewg_contentsDeallocator);
}

// Return address of function 'CFStringCreateWithCharactersNoCopy'
void* ewg_get_function_address_CFStringCreateWithCharactersNoCopy (void)
{
	return (void*) CFStringCreateWithCharactersNoCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithSubstring'
// For ise
CFStringRef  ewg_function_CFStringCreateWithSubstring (CFAllocatorRef ewg_alloc, CFStringRef ewg_str, CFRange *ewg_range)
{
	return CFStringCreateWithSubstring ((CFAllocatorRef)ewg_alloc, (CFStringRef)ewg_str, *(CFRange*)ewg_range);
}

// Return address of function 'CFStringCreateWithSubstring'
void* ewg_get_function_address_CFStringCreateWithSubstring (void)
{
	return (void*) CFStringCreateWithSubstring;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateCopy'
// For ise
CFStringRef  ewg_function_CFStringCreateCopy (CFAllocatorRef ewg_alloc, CFStringRef ewg_theString)
{
	return CFStringCreateCopy ((CFAllocatorRef)ewg_alloc, (CFStringRef)ewg_theString);
}

// Return address of function 'CFStringCreateCopy'
void* ewg_get_function_address_CFStringCreateCopy (void)
{
	return (void*) CFStringCreateCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithFormat'
// For ise
CFStringRef  ewg_function_CFStringCreateWithFormat (CFAllocatorRef ewg_alloc, CFDictionaryRef ewg_formatOptions, CFStringRef ewg_format)
{
	return CFStringCreateWithFormat ((CFAllocatorRef)ewg_alloc, (CFDictionaryRef)ewg_formatOptions, (CFStringRef)ewg_format);
}

// Return address of function 'CFStringCreateWithFormat'
void* ewg_get_function_address_CFStringCreateWithFormat (void)
{
	return (void*) CFStringCreateWithFormat;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateMutable'
// For ise
CFMutableStringRef  ewg_function_CFStringCreateMutable (CFAllocatorRef ewg_alloc, CFIndex ewg_maxLength)
{
	return CFStringCreateMutable ((CFAllocatorRef)ewg_alloc, (CFIndex)ewg_maxLength);
}

// Return address of function 'CFStringCreateMutable'
void* ewg_get_function_address_CFStringCreateMutable (void)
{
	return (void*) CFStringCreateMutable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateMutableCopy'
// For ise
CFMutableStringRef  ewg_function_CFStringCreateMutableCopy (CFAllocatorRef ewg_alloc, CFIndex ewg_maxLength, CFStringRef ewg_theString)
{
	return CFStringCreateMutableCopy ((CFAllocatorRef)ewg_alloc, (CFIndex)ewg_maxLength, (CFStringRef)ewg_theString);
}

// Return address of function 'CFStringCreateMutableCopy'
void* ewg_get_function_address_CFStringCreateMutableCopy (void)
{
	return (void*) CFStringCreateMutableCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateMutableWithExternalCharactersNoCopy'
// For ise
CFMutableStringRef  ewg_function_CFStringCreateMutableWithExternalCharactersNoCopy (CFAllocatorRef ewg_alloc, UniChar *ewg_chars, CFIndex ewg_numChars, CFIndex ewg_capacity, CFAllocatorRef ewg_externalCharactersAllocator)
{
	return CFStringCreateMutableWithExternalCharactersNoCopy ((CFAllocatorRef)ewg_alloc, (UniChar*)ewg_chars, (CFIndex)ewg_numChars, (CFIndex)ewg_capacity, (CFAllocatorRef)ewg_externalCharactersAllocator);
}

// Return address of function 'CFStringCreateMutableWithExternalCharactersNoCopy'
void* ewg_get_function_address_CFStringCreateMutableWithExternalCharactersNoCopy (void)
{
	return (void*) CFStringCreateMutableWithExternalCharactersNoCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetLength'
// For ise
CFIndex  ewg_function_CFStringGetLength (CFStringRef ewg_theString)
{
	return CFStringGetLength ((CFStringRef)ewg_theString);
}

// Return address of function 'CFStringGetLength'
void* ewg_get_function_address_CFStringGetLength (void)
{
	return (void*) CFStringGetLength;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetCharacterAtIndex'
// For ise
UniChar  ewg_function_CFStringGetCharacterAtIndex (CFStringRef ewg_theString, CFIndex ewg_idx)
{
	return CFStringGetCharacterAtIndex ((CFStringRef)ewg_theString, (CFIndex)ewg_idx);
}

// Return address of function 'CFStringGetCharacterAtIndex'
void* ewg_get_function_address_CFStringGetCharacterAtIndex (void)
{
	return (void*) CFStringGetCharacterAtIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetCharacters'
// For ise
void  ewg_function_CFStringGetCharacters (CFStringRef ewg_theString, CFRange *ewg_range, UniChar *ewg_buffer)
{
	CFStringGetCharacters ((CFStringRef)ewg_theString, *(CFRange*)ewg_range, (UniChar*)ewg_buffer);
}

// Return address of function 'CFStringGetCharacters'
void* ewg_get_function_address_CFStringGetCharacters (void)
{
	return (void*) CFStringGetCharacters;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetPascalString'
// For ise
Boolean  ewg_function_CFStringGetPascalString (CFStringRef ewg_theString, StringPtr ewg_buffer, CFIndex ewg_bufferSize, CFStringEncoding ewg_encoding)
{
	return CFStringGetPascalString ((CFStringRef)ewg_theString, (StringPtr)ewg_buffer, (CFIndex)ewg_bufferSize, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetPascalString'
void* ewg_get_function_address_CFStringGetPascalString (void)
{
	return (void*) CFStringGetPascalString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetCString'
// For ise
Boolean  ewg_function_CFStringGetCString (CFStringRef ewg_theString, char *ewg_buffer, CFIndex ewg_bufferSize, CFStringEncoding ewg_encoding)
{
	return CFStringGetCString ((CFStringRef)ewg_theString, (char*)ewg_buffer, (CFIndex)ewg_bufferSize, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetCString'
void* ewg_get_function_address_CFStringGetCString (void)
{
	return (void*) CFStringGetCString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetPascalStringPtr'
// For ise
ConstStringPtr  ewg_function_CFStringGetPascalStringPtr (CFStringRef ewg_theString, CFStringEncoding ewg_encoding)
{
	return CFStringGetPascalStringPtr ((CFStringRef)ewg_theString, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetPascalStringPtr'
void* ewg_get_function_address_CFStringGetPascalStringPtr (void)
{
	return (void*) CFStringGetPascalStringPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetCStringPtr'
// For ise
char const * ewg_function_CFStringGetCStringPtr (CFStringRef ewg_theString, CFStringEncoding ewg_encoding)
{
	return CFStringGetCStringPtr ((CFStringRef)ewg_theString, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetCStringPtr'
void* ewg_get_function_address_CFStringGetCStringPtr (void)
{
	return (void*) CFStringGetCStringPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetCharactersPtr'
// For ise
UniChar const * ewg_function_CFStringGetCharactersPtr (CFStringRef ewg_theString)
{
	return CFStringGetCharactersPtr ((CFStringRef)ewg_theString);
}

// Return address of function 'CFStringGetCharactersPtr'
void* ewg_get_function_address_CFStringGetCharactersPtr (void)
{
	return (void*) CFStringGetCharactersPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetBytes'
// For ise
CFIndex  ewg_function_CFStringGetBytes (CFStringRef ewg_theString, CFRange *ewg_range, CFStringEncoding ewg_encoding, UInt8 ewg_lossByte, Boolean ewg_isExternalRepresentation, UInt8 *ewg_buffer, CFIndex ewg_maxBufLen, CFIndex *ewg_usedBufLen)
{
	return CFStringGetBytes ((CFStringRef)ewg_theString, *(CFRange*)ewg_range, (CFStringEncoding)ewg_encoding, (UInt8)ewg_lossByte, (Boolean)ewg_isExternalRepresentation, (UInt8*)ewg_buffer, (CFIndex)ewg_maxBufLen, (CFIndex*)ewg_usedBufLen);
}

// Return address of function 'CFStringGetBytes'
void* ewg_get_function_address_CFStringGetBytes (void)
{
	return (void*) CFStringGetBytes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithBytes'
// For ise
CFStringRef  ewg_function_CFStringCreateWithBytes (CFAllocatorRef ewg_alloc, UInt8 const *ewg_bytes, CFIndex ewg_numBytes, CFStringEncoding ewg_encoding, Boolean ewg_isExternalRepresentation)
{
	return CFStringCreateWithBytes ((CFAllocatorRef)ewg_alloc, (UInt8 const*)ewg_bytes, (CFIndex)ewg_numBytes, (CFStringEncoding)ewg_encoding, (Boolean)ewg_isExternalRepresentation);
}

// Return address of function 'CFStringCreateWithBytes'
void* ewg_get_function_address_CFStringCreateWithBytes (void)
{
	return (void*) CFStringCreateWithBytes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateFromExternalRepresentation'
// For ise
CFStringRef  ewg_function_CFStringCreateFromExternalRepresentation (CFAllocatorRef ewg_alloc, CFDataRef ewg_data, CFStringEncoding ewg_encoding)
{
	return CFStringCreateFromExternalRepresentation ((CFAllocatorRef)ewg_alloc, (CFDataRef)ewg_data, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringCreateFromExternalRepresentation'
void* ewg_get_function_address_CFStringCreateFromExternalRepresentation (void)
{
	return (void*) CFStringCreateFromExternalRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateExternalRepresentation'
// For ise
CFDataRef  ewg_function_CFStringCreateExternalRepresentation (CFAllocatorRef ewg_alloc, CFStringRef ewg_theString, CFStringEncoding ewg_encoding, UInt8 ewg_lossByte)
{
	return CFStringCreateExternalRepresentation ((CFAllocatorRef)ewg_alloc, (CFStringRef)ewg_theString, (CFStringEncoding)ewg_encoding, (UInt8)ewg_lossByte);
}

// Return address of function 'CFStringCreateExternalRepresentation'
void* ewg_get_function_address_CFStringCreateExternalRepresentation (void)
{
	return (void*) CFStringCreateExternalRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetSmallestEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringGetSmallestEncoding (CFStringRef ewg_theString)
{
	return CFStringGetSmallestEncoding ((CFStringRef)ewg_theString);
}

// Return address of function 'CFStringGetSmallestEncoding'
void* ewg_get_function_address_CFStringGetSmallestEncoding (void)
{
	return (void*) CFStringGetSmallestEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetFastestEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringGetFastestEncoding (CFStringRef ewg_theString)
{
	return CFStringGetFastestEncoding ((CFStringRef)ewg_theString);
}

// Return address of function 'CFStringGetFastestEncoding'
void* ewg_get_function_address_CFStringGetFastestEncoding (void)
{
	return (void*) CFStringGetFastestEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetSystemEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringGetSystemEncoding (void)
{
	return CFStringGetSystemEncoding ();
}

// Return address of function 'CFStringGetSystemEncoding'
void* ewg_get_function_address_CFStringGetSystemEncoding (void)
{
	return (void*) CFStringGetSystemEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetMaximumSizeForEncoding'
// For ise
CFIndex  ewg_function_CFStringGetMaximumSizeForEncoding (CFIndex ewg_length, CFStringEncoding ewg_encoding)
{
	return CFStringGetMaximumSizeForEncoding ((CFIndex)ewg_length, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetMaximumSizeForEncoding'
void* ewg_get_function_address_CFStringGetMaximumSizeForEncoding (void)
{
	return (void*) CFStringGetMaximumSizeForEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetFileSystemRepresentation'
// For ise
Boolean  ewg_function_CFStringGetFileSystemRepresentation (CFStringRef ewg_string, char *ewg_buffer, CFIndex ewg_maxBufLen)
{
	return CFStringGetFileSystemRepresentation ((CFStringRef)ewg_string, (char*)ewg_buffer, (CFIndex)ewg_maxBufLen);
}

// Return address of function 'CFStringGetFileSystemRepresentation'
void* ewg_get_function_address_CFStringGetFileSystemRepresentation (void)
{
	return (void*) CFStringGetFileSystemRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetMaximumSizeOfFileSystemRepresentation'
// For ise
CFIndex  ewg_function_CFStringGetMaximumSizeOfFileSystemRepresentation (CFStringRef ewg_string)
{
	return CFStringGetMaximumSizeOfFileSystemRepresentation ((CFStringRef)ewg_string);
}

// Return address of function 'CFStringGetMaximumSizeOfFileSystemRepresentation'
void* ewg_get_function_address_CFStringGetMaximumSizeOfFileSystemRepresentation (void)
{
	return (void*) CFStringGetMaximumSizeOfFileSystemRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateWithFileSystemRepresentation'
// For ise
CFStringRef  ewg_function_CFStringCreateWithFileSystemRepresentation (CFAllocatorRef ewg_alloc, char const *ewg_buffer)
{
	return CFStringCreateWithFileSystemRepresentation ((CFAllocatorRef)ewg_alloc, (char const*)ewg_buffer);
}

// Return address of function 'CFStringCreateWithFileSystemRepresentation'
void* ewg_get_function_address_CFStringCreateWithFileSystemRepresentation (void)
{
	return (void*) CFStringCreateWithFileSystemRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCompareWithOptions'
// For ise
CFComparisonResult  ewg_function_CFStringCompareWithOptions (CFStringRef ewg_theString1, CFStringRef ewg_theString2, CFRange *ewg_rangeToCompare, CFOptionFlags ewg_compareOptions)
{
	return CFStringCompareWithOptions ((CFStringRef)ewg_theString1, (CFStringRef)ewg_theString2, *(CFRange*)ewg_rangeToCompare, (CFOptionFlags)ewg_compareOptions);
}

// Return address of function 'CFStringCompareWithOptions'
void* ewg_get_function_address_CFStringCompareWithOptions (void)
{
	return (void*) CFStringCompareWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCompare'
// For ise
CFComparisonResult  ewg_function_CFStringCompare (CFStringRef ewg_theString1, CFStringRef ewg_theString2, CFOptionFlags ewg_compareOptions)
{
	return CFStringCompare ((CFStringRef)ewg_theString1, (CFStringRef)ewg_theString2, (CFOptionFlags)ewg_compareOptions);
}

// Return address of function 'CFStringCompare'
void* ewg_get_function_address_CFStringCompare (void)
{
	return (void*) CFStringCompare;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringFindWithOptions'
// For ise
Boolean  ewg_function_CFStringFindWithOptions (CFStringRef ewg_theString, CFStringRef ewg_stringToFind, CFRange *ewg_rangeToSearch, CFOptionFlags ewg_searchOptions, CFRange *ewg_result)
{
	return CFStringFindWithOptions ((CFStringRef)ewg_theString, (CFStringRef)ewg_stringToFind, *(CFRange*)ewg_rangeToSearch, (CFOptionFlags)ewg_searchOptions, (CFRange*)ewg_result);
}

// Return address of function 'CFStringFindWithOptions'
void* ewg_get_function_address_CFStringFindWithOptions (void)
{
	return (void*) CFStringFindWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateArrayWithFindResults'
// For ise
CFArrayRef  ewg_function_CFStringCreateArrayWithFindResults (CFAllocatorRef ewg_alloc, CFStringRef ewg_theString, CFStringRef ewg_stringToFind, CFRange *ewg_rangeToSearch, CFOptionFlags ewg_compareOptions)
{
	return CFStringCreateArrayWithFindResults ((CFAllocatorRef)ewg_alloc, (CFStringRef)ewg_theString, (CFStringRef)ewg_stringToFind, *(CFRange*)ewg_rangeToSearch, (CFOptionFlags)ewg_compareOptions);
}

// Return address of function 'CFStringCreateArrayWithFindResults'
void* ewg_get_function_address_CFStringCreateArrayWithFindResults (void)
{
	return (void*) CFStringCreateArrayWithFindResults;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringFind'
// For ise
CFRange * ewg_function_CFStringFind (CFStringRef ewg_theString, CFStringRef ewg_stringToFind, CFOptionFlags ewg_compareOptions)
{
	CFRange *result = (CFRange*) malloc (sizeof(CFRange));
	*result = CFStringFind ((CFStringRef)ewg_theString, (CFStringRef)ewg_stringToFind, (CFOptionFlags)ewg_compareOptions);
	return result;
}

// Return address of function 'CFStringFind'
void* ewg_get_function_address_CFStringFind (void)
{
	return (void*) CFStringFind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringHasPrefix'
// For ise
Boolean  ewg_function_CFStringHasPrefix (CFStringRef ewg_theString, CFStringRef ewg_prefix)
{
	return CFStringHasPrefix ((CFStringRef)ewg_theString, (CFStringRef)ewg_prefix);
}

// Return address of function 'CFStringHasPrefix'
void* ewg_get_function_address_CFStringHasPrefix (void)
{
	return (void*) CFStringHasPrefix;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringHasSuffix'
// For ise
Boolean  ewg_function_CFStringHasSuffix (CFStringRef ewg_theString, CFStringRef ewg_suffix)
{
	return CFStringHasSuffix ((CFStringRef)ewg_theString, (CFStringRef)ewg_suffix);
}

// Return address of function 'CFStringHasSuffix'
void* ewg_get_function_address_CFStringHasSuffix (void)
{
	return (void*) CFStringHasSuffix;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetRangeOfComposedCharactersAtIndex'
// For ise
CFRange * ewg_function_CFStringGetRangeOfComposedCharactersAtIndex (CFStringRef ewg_theString, CFIndex ewg_theIndex)
{
	CFRange *result = (CFRange*) malloc (sizeof(CFRange));
	*result = CFStringGetRangeOfComposedCharactersAtIndex ((CFStringRef)ewg_theString, (CFIndex)ewg_theIndex);
	return result;
}

// Return address of function 'CFStringGetRangeOfComposedCharactersAtIndex'
void* ewg_get_function_address_CFStringGetRangeOfComposedCharactersAtIndex (void)
{
	return (void*) CFStringGetRangeOfComposedCharactersAtIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringFindCharacterFromSet'
// For ise
Boolean  ewg_function_CFStringFindCharacterFromSet (CFStringRef ewg_theString, CFCharacterSetRef ewg_theSet, CFRange *ewg_rangeToSearch, CFOptionFlags ewg_searchOptions, CFRange *ewg_result)
{
	return CFStringFindCharacterFromSet ((CFStringRef)ewg_theString, (CFCharacterSetRef)ewg_theSet, *(CFRange*)ewg_rangeToSearch, (CFOptionFlags)ewg_searchOptions, (CFRange*)ewg_result);
}

// Return address of function 'CFStringFindCharacterFromSet'
void* ewg_get_function_address_CFStringFindCharacterFromSet (void)
{
	return (void*) CFStringFindCharacterFromSet;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetLineBounds'
// For ise
void  ewg_function_CFStringGetLineBounds (CFStringRef ewg_theString, CFRange *ewg_range, CFIndex *ewg_lineBeginIndex, CFIndex *ewg_lineEndIndex, CFIndex *ewg_contentsEndIndex)
{
	CFStringGetLineBounds ((CFStringRef)ewg_theString, *(CFRange*)ewg_range, (CFIndex*)ewg_lineBeginIndex, (CFIndex*)ewg_lineEndIndex, (CFIndex*)ewg_contentsEndIndex);
}

// Return address of function 'CFStringGetLineBounds'
void* ewg_get_function_address_CFStringGetLineBounds (void)
{
	return (void*) CFStringGetLineBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateByCombiningStrings'
// For ise
CFStringRef  ewg_function_CFStringCreateByCombiningStrings (CFAllocatorRef ewg_alloc, CFArrayRef ewg_theArray, CFStringRef ewg_separatorString)
{
	return CFStringCreateByCombiningStrings ((CFAllocatorRef)ewg_alloc, (CFArrayRef)ewg_theArray, (CFStringRef)ewg_separatorString);
}

// Return address of function 'CFStringCreateByCombiningStrings'
void* ewg_get_function_address_CFStringCreateByCombiningStrings (void)
{
	return (void*) CFStringCreateByCombiningStrings;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCreateArrayBySeparatingStrings'
// For ise
CFArrayRef  ewg_function_CFStringCreateArrayBySeparatingStrings (CFAllocatorRef ewg_alloc, CFStringRef ewg_theString, CFStringRef ewg_separatorString)
{
	return CFStringCreateArrayBySeparatingStrings ((CFAllocatorRef)ewg_alloc, (CFStringRef)ewg_theString, (CFStringRef)ewg_separatorString);
}

// Return address of function 'CFStringCreateArrayBySeparatingStrings'
void* ewg_get_function_address_CFStringCreateArrayBySeparatingStrings (void)
{
	return (void*) CFStringCreateArrayBySeparatingStrings;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetIntValue'
// For ise
SInt32  ewg_function_CFStringGetIntValue (CFStringRef ewg_str)
{
	return CFStringGetIntValue ((CFStringRef)ewg_str);
}

// Return address of function 'CFStringGetIntValue'
void* ewg_get_function_address_CFStringGetIntValue (void)
{
	return (void*) CFStringGetIntValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetDoubleValue'
// For ise
double  ewg_function_CFStringGetDoubleValue (CFStringRef ewg_str)
{
	return CFStringGetDoubleValue ((CFStringRef)ewg_str);
}

// Return address of function 'CFStringGetDoubleValue'
void* ewg_get_function_address_CFStringGetDoubleValue (void)
{
	return (void*) CFStringGetDoubleValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringAppend'
// For ise
void  ewg_function_CFStringAppend (CFMutableStringRef ewg_theString, CFStringRef ewg_appendedString)
{
	CFStringAppend ((CFMutableStringRef)ewg_theString, (CFStringRef)ewg_appendedString);
}

// Return address of function 'CFStringAppend'
void* ewg_get_function_address_CFStringAppend (void)
{
	return (void*) CFStringAppend;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringAppendCharacters'
// For ise
void  ewg_function_CFStringAppendCharacters (CFMutableStringRef ewg_theString, UniChar const *ewg_chars, CFIndex ewg_numChars)
{
	CFStringAppendCharacters ((CFMutableStringRef)ewg_theString, (UniChar const*)ewg_chars, (CFIndex)ewg_numChars);
}

// Return address of function 'CFStringAppendCharacters'
void* ewg_get_function_address_CFStringAppendCharacters (void)
{
	return (void*) CFStringAppendCharacters;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringAppendPascalString'
// For ise
void  ewg_function_CFStringAppendPascalString (CFMutableStringRef ewg_theString, ConstStr255Param ewg_pStr, CFStringEncoding ewg_encoding)
{
	CFStringAppendPascalString ((CFMutableStringRef)ewg_theString, (ConstStr255Param)ewg_pStr, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringAppendPascalString'
void* ewg_get_function_address_CFStringAppendPascalString (void)
{
	return (void*) CFStringAppendPascalString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringAppendCString'
// For ise
void  ewg_function_CFStringAppendCString (CFMutableStringRef ewg_theString, char const *ewg_cStr, CFStringEncoding ewg_encoding)
{
	CFStringAppendCString ((CFMutableStringRef)ewg_theString, (char const*)ewg_cStr, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringAppendCString'
void* ewg_get_function_address_CFStringAppendCString (void)
{
	return (void*) CFStringAppendCString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringAppendFormat'
// For ise
void  ewg_function_CFStringAppendFormat (CFMutableStringRef ewg_theString, CFDictionaryRef ewg_formatOptions, CFStringRef ewg_format)
{
	CFStringAppendFormat ((CFMutableStringRef)ewg_theString, (CFDictionaryRef)ewg_formatOptions, (CFStringRef)ewg_format);
}

// Return address of function 'CFStringAppendFormat'
void* ewg_get_function_address_CFStringAppendFormat (void)
{
	return (void*) CFStringAppendFormat;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringInsert'
// For ise
void  ewg_function_CFStringInsert (CFMutableStringRef ewg_str, CFIndex ewg_idx, CFStringRef ewg_insertedStr)
{
	CFStringInsert ((CFMutableStringRef)ewg_str, (CFIndex)ewg_idx, (CFStringRef)ewg_insertedStr);
}

// Return address of function 'CFStringInsert'
void* ewg_get_function_address_CFStringInsert (void)
{
	return (void*) CFStringInsert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringDelete'
// For ise
void  ewg_function_CFStringDelete (CFMutableStringRef ewg_theString, CFRange *ewg_range)
{
	CFStringDelete ((CFMutableStringRef)ewg_theString, *(CFRange*)ewg_range);
}

// Return address of function 'CFStringDelete'
void* ewg_get_function_address_CFStringDelete (void)
{
	return (void*) CFStringDelete;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringReplace'
// For ise
void  ewg_function_CFStringReplace (CFMutableStringRef ewg_theString, CFRange *ewg_range, CFStringRef ewg_replacement)
{
	CFStringReplace ((CFMutableStringRef)ewg_theString, *(CFRange*)ewg_range, (CFStringRef)ewg_replacement);
}

// Return address of function 'CFStringReplace'
void* ewg_get_function_address_CFStringReplace (void)
{
	return (void*) CFStringReplace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringReplaceAll'
// For ise
void  ewg_function_CFStringReplaceAll (CFMutableStringRef ewg_theString, CFStringRef ewg_replacement)
{
	CFStringReplaceAll ((CFMutableStringRef)ewg_theString, (CFStringRef)ewg_replacement);
}

// Return address of function 'CFStringReplaceAll'
void* ewg_get_function_address_CFStringReplaceAll (void)
{
	return (void*) CFStringReplaceAll;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringFindAndReplace'
// For ise
CFIndex  ewg_function_CFStringFindAndReplace (CFMutableStringRef ewg_theString, CFStringRef ewg_stringToFind, CFStringRef ewg_replacementString, CFRange *ewg_rangeToSearch, CFOptionFlags ewg_compareOptions)
{
	return CFStringFindAndReplace ((CFMutableStringRef)ewg_theString, (CFStringRef)ewg_stringToFind, (CFStringRef)ewg_replacementString, *(CFRange*)ewg_rangeToSearch, (CFOptionFlags)ewg_compareOptions);
}

// Return address of function 'CFStringFindAndReplace'
void* ewg_get_function_address_CFStringFindAndReplace (void)
{
	return (void*) CFStringFindAndReplace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringSetExternalCharactersNoCopy'
// For ise
void  ewg_function_CFStringSetExternalCharactersNoCopy (CFMutableStringRef ewg_theString, UniChar *ewg_chars, CFIndex ewg_length, CFIndex ewg_capacity)
{
	CFStringSetExternalCharactersNoCopy ((CFMutableStringRef)ewg_theString, (UniChar*)ewg_chars, (CFIndex)ewg_length, (CFIndex)ewg_capacity);
}

// Return address of function 'CFStringSetExternalCharactersNoCopy'
void* ewg_get_function_address_CFStringSetExternalCharactersNoCopy (void)
{
	return (void*) CFStringSetExternalCharactersNoCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringPad'
// For ise
void  ewg_function_CFStringPad (CFMutableStringRef ewg_theString, CFStringRef ewg_padString, CFIndex ewg_length, CFIndex ewg_indexIntoPad)
{
	CFStringPad ((CFMutableStringRef)ewg_theString, (CFStringRef)ewg_padString, (CFIndex)ewg_length, (CFIndex)ewg_indexIntoPad);
}

// Return address of function 'CFStringPad'
void* ewg_get_function_address_CFStringPad (void)
{
	return (void*) CFStringPad;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringTrim'
// For ise
void  ewg_function_CFStringTrim (CFMutableStringRef ewg_theString, CFStringRef ewg_trimString)
{
	CFStringTrim ((CFMutableStringRef)ewg_theString, (CFStringRef)ewg_trimString);
}

// Return address of function 'CFStringTrim'
void* ewg_get_function_address_CFStringTrim (void)
{
	return (void*) CFStringTrim;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringTrimWhitespace'
// For ise
void  ewg_function_CFStringTrimWhitespace (CFMutableStringRef ewg_theString)
{
	CFStringTrimWhitespace ((CFMutableStringRef)ewg_theString);
}

// Return address of function 'CFStringTrimWhitespace'
void* ewg_get_function_address_CFStringTrimWhitespace (void)
{
	return (void*) CFStringTrimWhitespace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringLowercase'
// For ise
void  ewg_function_CFStringLowercase (CFMutableStringRef ewg_theString, CFLocaleRef ewg_locale)
{
	CFStringLowercase ((CFMutableStringRef)ewg_theString, (CFLocaleRef)ewg_locale);
}

// Return address of function 'CFStringLowercase'
void* ewg_get_function_address_CFStringLowercase (void)
{
	return (void*) CFStringLowercase;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringUppercase'
// For ise
void  ewg_function_CFStringUppercase (CFMutableStringRef ewg_theString, CFLocaleRef ewg_locale)
{
	CFStringUppercase ((CFMutableStringRef)ewg_theString, (CFLocaleRef)ewg_locale);
}

// Return address of function 'CFStringUppercase'
void* ewg_get_function_address_CFStringUppercase (void)
{
	return (void*) CFStringUppercase;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringCapitalize'
// For ise
void  ewg_function_CFStringCapitalize (CFMutableStringRef ewg_theString, CFLocaleRef ewg_locale)
{
	CFStringCapitalize ((CFMutableStringRef)ewg_theString, (CFLocaleRef)ewg_locale);
}

// Return address of function 'CFStringCapitalize'
void* ewg_get_function_address_CFStringCapitalize (void)
{
	return (void*) CFStringCapitalize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringNormalize'
// For ise
void  ewg_function_CFStringNormalize (CFMutableStringRef ewg_theString, CFStringNormalizationForm ewg_theForm)
{
	CFStringNormalize ((CFMutableStringRef)ewg_theString, (CFStringNormalizationForm)ewg_theForm);
}

// Return address of function 'CFStringNormalize'
void* ewg_get_function_address_CFStringNormalize (void)
{
	return (void*) CFStringNormalize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringTransform'
// For ise
Boolean  ewg_function_CFStringTransform (CFMutableStringRef ewg_string, CFRange *ewg_range, CFStringRef ewg_transform, Boolean ewg_reverse)
{
	return CFStringTransform ((CFMutableStringRef)ewg_string, (CFRange*)ewg_range, (CFStringRef)ewg_transform, (Boolean)ewg_reverse);
}

// Return address of function 'CFStringTransform'
void* ewg_get_function_address_CFStringTransform (void)
{
	return (void*) CFStringTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringIsEncodingAvailable'
// For ise
Boolean  ewg_function_CFStringIsEncodingAvailable (CFStringEncoding ewg_encoding)
{
	return CFStringIsEncodingAvailable ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringIsEncodingAvailable'
void* ewg_get_function_address_CFStringIsEncodingAvailable (void)
{
	return (void*) CFStringIsEncodingAvailable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetListOfAvailableEncodings'
// For ise
CFStringEncoding const * ewg_function_CFStringGetListOfAvailableEncodings (void)
{
	return CFStringGetListOfAvailableEncodings ();
}

// Return address of function 'CFStringGetListOfAvailableEncodings'
void* ewg_get_function_address_CFStringGetListOfAvailableEncodings (void)
{
	return (void*) CFStringGetListOfAvailableEncodings;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetNameOfEncoding'
// For ise
CFStringRef  ewg_function_CFStringGetNameOfEncoding (CFStringEncoding ewg_encoding)
{
	return CFStringGetNameOfEncoding ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetNameOfEncoding'
void* ewg_get_function_address_CFStringGetNameOfEncoding (void)
{
	return (void*) CFStringGetNameOfEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertEncodingToNSStringEncoding'
// For ise
UInt32  ewg_function_CFStringConvertEncodingToNSStringEncoding (CFStringEncoding ewg_encoding)
{
	return CFStringConvertEncodingToNSStringEncoding ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringConvertEncodingToNSStringEncoding'
void* ewg_get_function_address_CFStringConvertEncodingToNSStringEncoding (void)
{
	return (void*) CFStringConvertEncodingToNSStringEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertNSStringEncodingToEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringConvertNSStringEncodingToEncoding (UInt32 ewg_encoding)
{
	return CFStringConvertNSStringEncodingToEncoding ((UInt32)ewg_encoding);
}

// Return address of function 'CFStringConvertNSStringEncodingToEncoding'
void* ewg_get_function_address_CFStringConvertNSStringEncodingToEncoding (void)
{
	return (void*) CFStringConvertNSStringEncodingToEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertEncodingToWindowsCodepage'
// For ise
UInt32  ewg_function_CFStringConvertEncodingToWindowsCodepage (CFStringEncoding ewg_encoding)
{
	return CFStringConvertEncodingToWindowsCodepage ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringConvertEncodingToWindowsCodepage'
void* ewg_get_function_address_CFStringConvertEncodingToWindowsCodepage (void)
{
	return (void*) CFStringConvertEncodingToWindowsCodepage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertWindowsCodepageToEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringConvertWindowsCodepageToEncoding (UInt32 ewg_codepage)
{
	return CFStringConvertWindowsCodepageToEncoding ((UInt32)ewg_codepage);
}

// Return address of function 'CFStringConvertWindowsCodepageToEncoding'
void* ewg_get_function_address_CFStringConvertWindowsCodepageToEncoding (void)
{
	return (void*) CFStringConvertWindowsCodepageToEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertIANACharSetNameToEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringConvertIANACharSetNameToEncoding (CFStringRef ewg_theString)
{
	return CFStringConvertIANACharSetNameToEncoding ((CFStringRef)ewg_theString);
}

// Return address of function 'CFStringConvertIANACharSetNameToEncoding'
void* ewg_get_function_address_CFStringConvertIANACharSetNameToEncoding (void)
{
	return (void*) CFStringConvertIANACharSetNameToEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringConvertEncodingToIANACharSetName'
// For ise
CFStringRef  ewg_function_CFStringConvertEncodingToIANACharSetName (CFStringEncoding ewg_encoding)
{
	return CFStringConvertEncodingToIANACharSetName ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringConvertEncodingToIANACharSetName'
void* ewg_get_function_address_CFStringConvertEncodingToIANACharSetName (void)
{
	return (void*) CFStringConvertEncodingToIANACharSetName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFStringGetMostCompatibleMacStringEncoding'
// For ise
CFStringEncoding  ewg_function_CFStringGetMostCompatibleMacStringEncoding (CFStringEncoding ewg_encoding)
{
	return CFStringGetMostCompatibleMacStringEncoding ((CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFStringGetMostCompatibleMacStringEncoding'
void* ewg_get_function_address_CFStringGetMostCompatibleMacStringEncoding (void)
{
	return (void*) CFStringGetMostCompatibleMacStringEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFShow'
// For ise
void  ewg_function_CFShow (CFTypeRef ewg_obj)
{
	CFShow ((CFTypeRef)ewg_obj);
}

// Return address of function 'CFShow'
void* ewg_get_function_address_CFShow (void)
{
	return (void*) CFShow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFShowStr'
// For ise
void  ewg_function_CFShowStr (CFStringRef ewg_str)
{
	CFShowStr ((CFStringRef)ewg_str);
}

// Return address of function 'CFShowStr'
void* ewg_get_function_address_CFShowStr (void)
{
	return (void*) CFShowStr;
}

#include <Carbon/Carbon.h>

// Wraps call to function '__CFStringMakeConstantString'
// For ise
CFStringRef  ewg_function___CFStringMakeConstantString (char const *ewg_cStr)
{
	return __CFStringMakeConstantString ((char const*)ewg_cStr);
}

// Return address of function '__CFStringMakeConstantString'
void* ewg_get_function_address___CFStringMakeConstantString (void)
{
	return (void*) __CFStringMakeConstantString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetTypeID'
// For ise
CFTypeID  ewg_function_CFURLGetTypeID (void)
{
	return CFURLGetTypeID ();
}

// Return address of function 'CFURLGetTypeID'
void* ewg_get_function_address_CFURLGetTypeID (void)
{
	return (void*) CFURLGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateWithBytes'
// For ise
CFURLRef  ewg_function_CFURLCreateWithBytes (CFAllocatorRef ewg_allocator, UInt8 const *ewg_URLBytes, CFIndex ewg_length, CFStringEncoding ewg_encoding, CFURLRef ewg_baseURL)
{
	return CFURLCreateWithBytes ((CFAllocatorRef)ewg_allocator, (UInt8 const*)ewg_URLBytes, (CFIndex)ewg_length, (CFStringEncoding)ewg_encoding, (CFURLRef)ewg_baseURL);
}

// Return address of function 'CFURLCreateWithBytes'
void* ewg_get_function_address_CFURLCreateWithBytes (void)
{
	return (void*) CFURLCreateWithBytes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateData'
// For ise
CFDataRef  ewg_function_CFURLCreateData (CFAllocatorRef ewg_allocator, CFURLRef ewg_url, CFStringEncoding ewg_encoding, Boolean ewg_escapeWhitespace)
{
	return CFURLCreateData ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url, (CFStringEncoding)ewg_encoding, (Boolean)ewg_escapeWhitespace);
}

// Return address of function 'CFURLCreateData'
void* ewg_get_function_address_CFURLCreateData (void)
{
	return (void*) CFURLCreateData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateWithString'
// For ise
CFURLRef  ewg_function_CFURLCreateWithString (CFAllocatorRef ewg_allocator, CFStringRef ewg_URLString, CFURLRef ewg_baseURL)
{
	return CFURLCreateWithString ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_URLString, (CFURLRef)ewg_baseURL);
}

// Return address of function 'CFURLCreateWithString'
void* ewg_get_function_address_CFURLCreateWithString (void)
{
	return (void*) CFURLCreateWithString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateAbsoluteURLWithBytes'
// For ise
CFURLRef  ewg_function_CFURLCreateAbsoluteURLWithBytes (CFAllocatorRef ewg_alloc, UInt8 const *ewg_relativeURLBytes, CFIndex ewg_length, CFStringEncoding ewg_encoding, CFURLRef ewg_baseURL, Boolean ewg_useCompatibilityMode)
{
	return CFURLCreateAbsoluteURLWithBytes ((CFAllocatorRef)ewg_alloc, (UInt8 const*)ewg_relativeURLBytes, (CFIndex)ewg_length, (CFStringEncoding)ewg_encoding, (CFURLRef)ewg_baseURL, (Boolean)ewg_useCompatibilityMode);
}

// Return address of function 'CFURLCreateAbsoluteURLWithBytes'
void* ewg_get_function_address_CFURLCreateAbsoluteURLWithBytes (void)
{
	return (void*) CFURLCreateAbsoluteURLWithBytes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateWithFileSystemPath'
// For ise
CFURLRef  ewg_function_CFURLCreateWithFileSystemPath (CFAllocatorRef ewg_allocator, CFStringRef ewg_filePath, CFURLPathStyle ewg_pathStyle, Boolean ewg_isDirectory)
{
	return CFURLCreateWithFileSystemPath ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_filePath, (CFURLPathStyle)ewg_pathStyle, (Boolean)ewg_isDirectory);
}

// Return address of function 'CFURLCreateWithFileSystemPath'
void* ewg_get_function_address_CFURLCreateWithFileSystemPath (void)
{
	return (void*) CFURLCreateWithFileSystemPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateFromFileSystemRepresentation'
// For ise
CFURLRef  ewg_function_CFURLCreateFromFileSystemRepresentation (CFAllocatorRef ewg_allocator, UInt8 const *ewg_buffer, CFIndex ewg_bufLen, Boolean ewg_isDirectory)
{
	return CFURLCreateFromFileSystemRepresentation ((CFAllocatorRef)ewg_allocator, (UInt8 const*)ewg_buffer, (CFIndex)ewg_bufLen, (Boolean)ewg_isDirectory);
}

// Return address of function 'CFURLCreateFromFileSystemRepresentation'
void* ewg_get_function_address_CFURLCreateFromFileSystemRepresentation (void)
{
	return (void*) CFURLCreateFromFileSystemRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateWithFileSystemPathRelativeToBase'
// For ise
CFURLRef  ewg_function_CFURLCreateWithFileSystemPathRelativeToBase (CFAllocatorRef ewg_allocator, CFStringRef ewg_filePath, CFURLPathStyle ewg_pathStyle, Boolean ewg_isDirectory, CFURLRef ewg_baseURL)
{
	return CFURLCreateWithFileSystemPathRelativeToBase ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_filePath, (CFURLPathStyle)ewg_pathStyle, (Boolean)ewg_isDirectory, (CFURLRef)ewg_baseURL);
}

// Return address of function 'CFURLCreateWithFileSystemPathRelativeToBase'
void* ewg_get_function_address_CFURLCreateWithFileSystemPathRelativeToBase (void)
{
	return (void*) CFURLCreateWithFileSystemPathRelativeToBase;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateFromFileSystemRepresentationRelativeToBase'
// For ise
CFURLRef  ewg_function_CFURLCreateFromFileSystemRepresentationRelativeToBase (CFAllocatorRef ewg_allocator, UInt8 const *ewg_buffer, CFIndex ewg_bufLen, Boolean ewg_isDirectory, CFURLRef ewg_baseURL)
{
	return CFURLCreateFromFileSystemRepresentationRelativeToBase ((CFAllocatorRef)ewg_allocator, (UInt8 const*)ewg_buffer, (CFIndex)ewg_bufLen, (Boolean)ewg_isDirectory, (CFURLRef)ewg_baseURL);
}

// Return address of function 'CFURLCreateFromFileSystemRepresentationRelativeToBase'
void* ewg_get_function_address_CFURLCreateFromFileSystemRepresentationRelativeToBase (void)
{
	return (void*) CFURLCreateFromFileSystemRepresentationRelativeToBase;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetFileSystemRepresentation'
// For ise
Boolean  ewg_function_CFURLGetFileSystemRepresentation (CFURLRef ewg_url, Boolean ewg_resolveAgainstBase, UInt8 *ewg_buffer, CFIndex ewg_maxBufLen)
{
	return CFURLGetFileSystemRepresentation ((CFURLRef)ewg_url, (Boolean)ewg_resolveAgainstBase, (UInt8*)ewg_buffer, (CFIndex)ewg_maxBufLen);
}

// Return address of function 'CFURLGetFileSystemRepresentation'
void* ewg_get_function_address_CFURLGetFileSystemRepresentation (void)
{
	return (void*) CFURLGetFileSystemRepresentation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyAbsoluteURL'
// For ise
CFURLRef  ewg_function_CFURLCopyAbsoluteURL (CFURLRef ewg_relativeURL)
{
	return CFURLCopyAbsoluteURL ((CFURLRef)ewg_relativeURL);
}

// Return address of function 'CFURLCopyAbsoluteURL'
void* ewg_get_function_address_CFURLCopyAbsoluteURL (void)
{
	return (void*) CFURLCopyAbsoluteURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetString'
// For ise
CFStringRef  ewg_function_CFURLGetString (CFURLRef ewg_anURL)
{
	return CFURLGetString ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLGetString'
void* ewg_get_function_address_CFURLGetString (void)
{
	return (void*) CFURLGetString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetBaseURL'
// For ise
CFURLRef  ewg_function_CFURLGetBaseURL (CFURLRef ewg_anURL)
{
	return CFURLGetBaseURL ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLGetBaseURL'
void* ewg_get_function_address_CFURLGetBaseURL (void)
{
	return (void*) CFURLGetBaseURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCanBeDecomposed'
// For ise
Boolean  ewg_function_CFURLCanBeDecomposed (CFURLRef ewg_anURL)
{
	return CFURLCanBeDecomposed ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCanBeDecomposed'
void* ewg_get_function_address_CFURLCanBeDecomposed (void)
{
	return (void*) CFURLCanBeDecomposed;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyScheme'
// For ise
CFStringRef  ewg_function_CFURLCopyScheme (CFURLRef ewg_anURL)
{
	return CFURLCopyScheme ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyScheme'
void* ewg_get_function_address_CFURLCopyScheme (void)
{
	return (void*) CFURLCopyScheme;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyNetLocation'
// For ise
CFStringRef  ewg_function_CFURLCopyNetLocation (CFURLRef ewg_anURL)
{
	return CFURLCopyNetLocation ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyNetLocation'
void* ewg_get_function_address_CFURLCopyNetLocation (void)
{
	return (void*) CFURLCopyNetLocation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyPath'
// For ise
CFStringRef  ewg_function_CFURLCopyPath (CFURLRef ewg_anURL)
{
	return CFURLCopyPath ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyPath'
void* ewg_get_function_address_CFURLCopyPath (void)
{
	return (void*) CFURLCopyPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyStrictPath'
// For ise
CFStringRef  ewg_function_CFURLCopyStrictPath (CFURLRef ewg_anURL, Boolean *ewg_isAbsolute)
{
	return CFURLCopyStrictPath ((CFURLRef)ewg_anURL, (Boolean*)ewg_isAbsolute);
}

// Return address of function 'CFURLCopyStrictPath'
void* ewg_get_function_address_CFURLCopyStrictPath (void)
{
	return (void*) CFURLCopyStrictPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyFileSystemPath'
// For ise
CFStringRef  ewg_function_CFURLCopyFileSystemPath (CFURLRef ewg_anURL, CFURLPathStyle ewg_pathStyle)
{
	return CFURLCopyFileSystemPath ((CFURLRef)ewg_anURL, (CFURLPathStyle)ewg_pathStyle);
}

// Return address of function 'CFURLCopyFileSystemPath'
void* ewg_get_function_address_CFURLCopyFileSystemPath (void)
{
	return (void*) CFURLCopyFileSystemPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLHasDirectoryPath'
// For ise
Boolean  ewg_function_CFURLHasDirectoryPath (CFURLRef ewg_anURL)
{
	return CFURLHasDirectoryPath ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLHasDirectoryPath'
void* ewg_get_function_address_CFURLHasDirectoryPath (void)
{
	return (void*) CFURLHasDirectoryPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyResourceSpecifier'
// For ise
CFStringRef  ewg_function_CFURLCopyResourceSpecifier (CFURLRef ewg_anURL)
{
	return CFURLCopyResourceSpecifier ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyResourceSpecifier'
void* ewg_get_function_address_CFURLCopyResourceSpecifier (void)
{
	return (void*) CFURLCopyResourceSpecifier;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyHostName'
// For ise
CFStringRef  ewg_function_CFURLCopyHostName (CFURLRef ewg_anURL)
{
	return CFURLCopyHostName ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyHostName'
void* ewg_get_function_address_CFURLCopyHostName (void)
{
	return (void*) CFURLCopyHostName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetPortNumber'
// For ise
SInt32  ewg_function_CFURLGetPortNumber (CFURLRef ewg_anURL)
{
	return CFURLGetPortNumber ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLGetPortNumber'
void* ewg_get_function_address_CFURLGetPortNumber (void)
{
	return (void*) CFURLGetPortNumber;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyUserName'
// For ise
CFStringRef  ewg_function_CFURLCopyUserName (CFURLRef ewg_anURL)
{
	return CFURLCopyUserName ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyUserName'
void* ewg_get_function_address_CFURLCopyUserName (void)
{
	return (void*) CFURLCopyUserName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyPassword'
// For ise
CFStringRef  ewg_function_CFURLCopyPassword (CFURLRef ewg_anURL)
{
	return CFURLCopyPassword ((CFURLRef)ewg_anURL);
}

// Return address of function 'CFURLCopyPassword'
void* ewg_get_function_address_CFURLCopyPassword (void)
{
	return (void*) CFURLCopyPassword;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyParameterString'
// For ise
CFStringRef  ewg_function_CFURLCopyParameterString (CFURLRef ewg_anURL, CFStringRef ewg_charactersToLeaveEscaped)
{
	return CFURLCopyParameterString ((CFURLRef)ewg_anURL, (CFStringRef)ewg_charactersToLeaveEscaped);
}

// Return address of function 'CFURLCopyParameterString'
void* ewg_get_function_address_CFURLCopyParameterString (void)
{
	return (void*) CFURLCopyParameterString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyQueryString'
// For ise
CFStringRef  ewg_function_CFURLCopyQueryString (CFURLRef ewg_anURL, CFStringRef ewg_charactersToLeaveEscaped)
{
	return CFURLCopyQueryString ((CFURLRef)ewg_anURL, (CFStringRef)ewg_charactersToLeaveEscaped);
}

// Return address of function 'CFURLCopyQueryString'
void* ewg_get_function_address_CFURLCopyQueryString (void)
{
	return (void*) CFURLCopyQueryString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyFragment'
// For ise
CFStringRef  ewg_function_CFURLCopyFragment (CFURLRef ewg_anURL, CFStringRef ewg_charactersToLeaveEscaped)
{
	return CFURLCopyFragment ((CFURLRef)ewg_anURL, (CFStringRef)ewg_charactersToLeaveEscaped);
}

// Return address of function 'CFURLCopyFragment'
void* ewg_get_function_address_CFURLCopyFragment (void)
{
	return (void*) CFURLCopyFragment;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyLastPathComponent'
// For ise
CFStringRef  ewg_function_CFURLCopyLastPathComponent (CFURLRef ewg_url)
{
	return CFURLCopyLastPathComponent ((CFURLRef)ewg_url);
}

// Return address of function 'CFURLCopyLastPathComponent'
void* ewg_get_function_address_CFURLCopyLastPathComponent (void)
{
	return (void*) CFURLCopyLastPathComponent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCopyPathExtension'
// For ise
CFStringRef  ewg_function_CFURLCopyPathExtension (CFURLRef ewg_url)
{
	return CFURLCopyPathExtension ((CFURLRef)ewg_url);
}

// Return address of function 'CFURLCopyPathExtension'
void* ewg_get_function_address_CFURLCopyPathExtension (void)
{
	return (void*) CFURLCopyPathExtension;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateCopyAppendingPathComponent'
// For ise
CFURLRef  ewg_function_CFURLCreateCopyAppendingPathComponent (CFAllocatorRef ewg_allocator, CFURLRef ewg_url, CFStringRef ewg_pathComponent, Boolean ewg_isDirectory)
{
	return CFURLCreateCopyAppendingPathComponent ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url, (CFStringRef)ewg_pathComponent, (Boolean)ewg_isDirectory);
}

// Return address of function 'CFURLCreateCopyAppendingPathComponent'
void* ewg_get_function_address_CFURLCreateCopyAppendingPathComponent (void)
{
	return (void*) CFURLCreateCopyAppendingPathComponent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateCopyDeletingLastPathComponent'
// For ise
CFURLRef  ewg_function_CFURLCreateCopyDeletingLastPathComponent (CFAllocatorRef ewg_allocator, CFURLRef ewg_url)
{
	return CFURLCreateCopyDeletingLastPathComponent ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url);
}

// Return address of function 'CFURLCreateCopyDeletingLastPathComponent'
void* ewg_get_function_address_CFURLCreateCopyDeletingLastPathComponent (void)
{
	return (void*) CFURLCreateCopyDeletingLastPathComponent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateCopyAppendingPathExtension'
// For ise
CFURLRef  ewg_function_CFURLCreateCopyAppendingPathExtension (CFAllocatorRef ewg_allocator, CFURLRef ewg_url, CFStringRef ewg_extension)
{
	return CFURLCreateCopyAppendingPathExtension ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url, (CFStringRef)ewg_extension);
}

// Return address of function 'CFURLCreateCopyAppendingPathExtension'
void* ewg_get_function_address_CFURLCreateCopyAppendingPathExtension (void)
{
	return (void*) CFURLCreateCopyAppendingPathExtension;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateCopyDeletingPathExtension'
// For ise
CFURLRef  ewg_function_CFURLCreateCopyDeletingPathExtension (CFAllocatorRef ewg_allocator, CFURLRef ewg_url)
{
	return CFURLCreateCopyDeletingPathExtension ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url);
}

// Return address of function 'CFURLCreateCopyDeletingPathExtension'
void* ewg_get_function_address_CFURLCreateCopyDeletingPathExtension (void)
{
	return (void*) CFURLCreateCopyDeletingPathExtension;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetBytes'
// For ise
CFIndex  ewg_function_CFURLGetBytes (CFURLRef ewg_url, UInt8 *ewg_buffer, CFIndex ewg_bufferLength)
{
	return CFURLGetBytes ((CFURLRef)ewg_url, (UInt8*)ewg_buffer, (CFIndex)ewg_bufferLength);
}

// Return address of function 'CFURLGetBytes'
void* ewg_get_function_address_CFURLGetBytes (void)
{
	return (void*) CFURLGetBytes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetByteRangeForComponent'
// For ise
CFRange * ewg_function_CFURLGetByteRangeForComponent (CFURLRef ewg_url, CFURLComponentType ewg_component, CFRange *ewg_rangeIncludingSeparators)
{
	CFRange *result = (CFRange*) malloc (sizeof(CFRange));
	*result = CFURLGetByteRangeForComponent ((CFURLRef)ewg_url, (CFURLComponentType)ewg_component, (CFRange*)ewg_rangeIncludingSeparators);
	return result;
}

// Return address of function 'CFURLGetByteRangeForComponent'
void* ewg_get_function_address_CFURLGetByteRangeForComponent (void)
{
	return (void*) CFURLGetByteRangeForComponent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateStringByReplacingPercentEscapes'
// For ise
CFStringRef  ewg_function_CFURLCreateStringByReplacingPercentEscapes (CFAllocatorRef ewg_allocator, CFStringRef ewg_originalString, CFStringRef ewg_charactersToLeaveEscaped)
{
	return CFURLCreateStringByReplacingPercentEscapes ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_originalString, (CFStringRef)ewg_charactersToLeaveEscaped);
}

// Return address of function 'CFURLCreateStringByReplacingPercentEscapes'
void* ewg_get_function_address_CFURLCreateStringByReplacingPercentEscapes (void)
{
	return (void*) CFURLCreateStringByReplacingPercentEscapes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateStringByReplacingPercentEscapesUsingEncoding'
// For ise
CFStringRef  ewg_function_CFURLCreateStringByReplacingPercentEscapesUsingEncoding (CFAllocatorRef ewg_allocator, CFStringRef ewg_origString, CFStringRef ewg_charsToLeaveEscaped, CFStringEncoding ewg_encoding)
{
	return CFURLCreateStringByReplacingPercentEscapesUsingEncoding ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_origString, (CFStringRef)ewg_charsToLeaveEscaped, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFURLCreateStringByReplacingPercentEscapesUsingEncoding'
void* ewg_get_function_address_CFURLCreateStringByReplacingPercentEscapesUsingEncoding (void)
{
	return (void*) CFURLCreateStringByReplacingPercentEscapesUsingEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateStringByAddingPercentEscapes'
// For ise
CFStringRef  ewg_function_CFURLCreateStringByAddingPercentEscapes (CFAllocatorRef ewg_allocator, CFStringRef ewg_originalString, CFStringRef ewg_charactersToLeaveUnescaped, CFStringRef ewg_legalURLCharactersToBeEscaped, CFStringEncoding ewg_encoding)
{
	return CFURLCreateStringByAddingPercentEscapes ((CFAllocatorRef)ewg_allocator, (CFStringRef)ewg_originalString, (CFStringRef)ewg_charactersToLeaveUnescaped, (CFStringRef)ewg_legalURLCharactersToBeEscaped, (CFStringEncoding)ewg_encoding);
}

// Return address of function 'CFURLCreateStringByAddingPercentEscapes'
void* ewg_get_function_address_CFURLCreateStringByAddingPercentEscapes (void)
{
	return (void*) CFURLCreateStringByAddingPercentEscapes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLCreateFromFSRef'
// For ise
CFURLRef  ewg_function_CFURLCreateFromFSRef (CFAllocatorRef ewg_allocator, struct FSRef const *ewg_fsRef)
{
	return CFURLCreateFromFSRef ((CFAllocatorRef)ewg_allocator, (struct FSRef const*)ewg_fsRef);
}

// Return address of function 'CFURLCreateFromFSRef'
void* ewg_get_function_address_CFURLCreateFromFSRef (void)
{
	return (void*) CFURLCreateFromFSRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFURLGetFSRef'
// For ise
Boolean  ewg_function_CFURLGetFSRef (CFURLRef ewg_url, struct FSRef *ewg_fsRef)
{
	return CFURLGetFSRef ((CFURLRef)ewg_url, (struct FSRef*)ewg_fsRef);
}

// Return address of function 'CFURLGetFSRef'
void* ewg_get_function_address_CFURLGetFSRef (void)
{
	return (void*) CFURLGetFSRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetMainBundle'
// For ise
CFBundleRef  ewg_function_CFBundleGetMainBundle (void)
{
	return CFBundleGetMainBundle ();
}

// Return address of function 'CFBundleGetMainBundle'
void* ewg_get_function_address_CFBundleGetMainBundle (void)
{
	return (void*) CFBundleGetMainBundle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetBundleWithIdentifier'
// For ise
CFBundleRef  ewg_function_CFBundleGetBundleWithIdentifier (CFStringRef ewg_bundleID)
{
	return CFBundleGetBundleWithIdentifier ((CFStringRef)ewg_bundleID);
}

// Return address of function 'CFBundleGetBundleWithIdentifier'
void* ewg_get_function_address_CFBundleGetBundleWithIdentifier (void)
{
	return (void*) CFBundleGetBundleWithIdentifier;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetAllBundles'
// For ise
CFArrayRef  ewg_function_CFBundleGetAllBundles (void)
{
	return CFBundleGetAllBundles ();
}

// Return address of function 'CFBundleGetAllBundles'
void* ewg_get_function_address_CFBundleGetAllBundles (void)
{
	return (void*) CFBundleGetAllBundles;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetTypeID'
// For ise
UInt32  ewg_function_CFBundleGetTypeID (void)
{
	return CFBundleGetTypeID ();
}

// Return address of function 'CFBundleGetTypeID'
void* ewg_get_function_address_CFBundleGetTypeID (void)
{
	return (void*) CFBundleGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCreate'
// For ise
CFBundleRef  ewg_function_CFBundleCreate (CFAllocatorRef ewg_allocator, CFURLRef ewg_bundleURL)
{
	return CFBundleCreate ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_bundleURL);
}

// Return address of function 'CFBundleCreate'
void* ewg_get_function_address_CFBundleCreate (void)
{
	return (void*) CFBundleCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCreateBundlesFromDirectory'
// For ise
CFArrayRef  ewg_function_CFBundleCreateBundlesFromDirectory (CFAllocatorRef ewg_allocator, CFURLRef ewg_directoryURL, CFStringRef ewg_bundleType)
{
	return CFBundleCreateBundlesFromDirectory ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_directoryURL, (CFStringRef)ewg_bundleType);
}

// Return address of function 'CFBundleCreateBundlesFromDirectory'
void* ewg_get_function_address_CFBundleCreateBundlesFromDirectory (void)
{
	return (void*) CFBundleCreateBundlesFromDirectory;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyBundleURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyBundleURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopyBundleURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyBundleURL'
void* ewg_get_function_address_CFBundleCopyBundleURL (void)
{
	return (void*) CFBundleCopyBundleURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetValueForInfoDictionaryKey'
// For ise
CFTypeRef  ewg_function_CFBundleGetValueForInfoDictionaryKey (CFBundleRef ewg_bundle, CFStringRef ewg_key)
{
	return CFBundleGetValueForInfoDictionaryKey ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_key);
}

// Return address of function 'CFBundleGetValueForInfoDictionaryKey'
void* ewg_get_function_address_CFBundleGetValueForInfoDictionaryKey (void)
{
	return (void*) CFBundleGetValueForInfoDictionaryKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetInfoDictionary'
// For ise
CFDictionaryRef  ewg_function_CFBundleGetInfoDictionary (CFBundleRef ewg_bundle)
{
	return CFBundleGetInfoDictionary ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetInfoDictionary'
void* ewg_get_function_address_CFBundleGetInfoDictionary (void)
{
	return (void*) CFBundleGetInfoDictionary;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetLocalInfoDictionary'
// For ise
CFDictionaryRef  ewg_function_CFBundleGetLocalInfoDictionary (CFBundleRef ewg_bundle)
{
	return CFBundleGetLocalInfoDictionary ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetLocalInfoDictionary'
void* ewg_get_function_address_CFBundleGetLocalInfoDictionary (void)
{
	return (void*) CFBundleGetLocalInfoDictionary;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetPackageInfo'
// For ise
void  ewg_function_CFBundleGetPackageInfo (CFBundleRef ewg_bundle, UInt32 *ewg_packageType, UInt32 *ewg_packageCreator)
{
	CFBundleGetPackageInfo ((CFBundleRef)ewg_bundle, (UInt32*)ewg_packageType, (UInt32*)ewg_packageCreator);
}

// Return address of function 'CFBundleGetPackageInfo'
void* ewg_get_function_address_CFBundleGetPackageInfo (void)
{
	return (void*) CFBundleGetPackageInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetIdentifier'
// For ise
CFStringRef  ewg_function_CFBundleGetIdentifier (CFBundleRef ewg_bundle)
{
	return CFBundleGetIdentifier ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetIdentifier'
void* ewg_get_function_address_CFBundleGetIdentifier (void)
{
	return (void*) CFBundleGetIdentifier;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetVersionNumber'
// For ise
UInt32  ewg_function_CFBundleGetVersionNumber (CFBundleRef ewg_bundle)
{
	return CFBundleGetVersionNumber ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetVersionNumber'
void* ewg_get_function_address_CFBundleGetVersionNumber (void)
{
	return (void*) CFBundleGetVersionNumber;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetDevelopmentRegion'
// For ise
CFStringRef  ewg_function_CFBundleGetDevelopmentRegion (CFBundleRef ewg_bundle)
{
	return CFBundleGetDevelopmentRegion ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetDevelopmentRegion'
void* ewg_get_function_address_CFBundleGetDevelopmentRegion (void)
{
	return (void*) CFBundleGetDevelopmentRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopySupportFilesDirectoryURL'
// For ise
CFURLRef  ewg_function_CFBundleCopySupportFilesDirectoryURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopySupportFilesDirectoryURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopySupportFilesDirectoryURL'
void* ewg_get_function_address_CFBundleCopySupportFilesDirectoryURL (void)
{
	return (void*) CFBundleCopySupportFilesDirectoryURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourcesDirectoryURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyResourcesDirectoryURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopyResourcesDirectoryURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyResourcesDirectoryURL'
void* ewg_get_function_address_CFBundleCopyResourcesDirectoryURL (void)
{
	return (void*) CFBundleCopyResourcesDirectoryURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyPrivateFrameworksURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyPrivateFrameworksURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopyPrivateFrameworksURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyPrivateFrameworksURL'
void* ewg_get_function_address_CFBundleCopyPrivateFrameworksURL (void)
{
	return (void*) CFBundleCopyPrivateFrameworksURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopySharedFrameworksURL'
// For ise
CFURLRef  ewg_function_CFBundleCopySharedFrameworksURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopySharedFrameworksURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopySharedFrameworksURL'
void* ewg_get_function_address_CFBundleCopySharedFrameworksURL (void)
{
	return (void*) CFBundleCopySharedFrameworksURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopySharedSupportURL'
// For ise
CFURLRef  ewg_function_CFBundleCopySharedSupportURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopySharedSupportURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopySharedSupportURL'
void* ewg_get_function_address_CFBundleCopySharedSupportURL (void)
{
	return (void*) CFBundleCopySharedSupportURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyBuiltInPlugInsURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyBuiltInPlugInsURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopyBuiltInPlugInsURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyBuiltInPlugInsURL'
void* ewg_get_function_address_CFBundleCopyBuiltInPlugInsURL (void)
{
	return (void*) CFBundleCopyBuiltInPlugInsURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyInfoDictionaryInDirectory'
// For ise
CFDictionaryRef  ewg_function_CFBundleCopyInfoDictionaryInDirectory (CFURLRef ewg_bundleURL)
{
	return CFBundleCopyInfoDictionaryInDirectory ((CFURLRef)ewg_bundleURL);
}

// Return address of function 'CFBundleCopyInfoDictionaryInDirectory'
void* ewg_get_function_address_CFBundleCopyInfoDictionaryInDirectory (void)
{
	return (void*) CFBundleCopyInfoDictionaryInDirectory;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetPackageInfoInDirectory'
// For ise
Boolean  ewg_function_CFBundleGetPackageInfoInDirectory (CFURLRef ewg_url, UInt32 *ewg_packageType, UInt32 *ewg_packageCreator)
{
	return CFBundleGetPackageInfoInDirectory ((CFURLRef)ewg_url, (UInt32*)ewg_packageType, (UInt32*)ewg_packageCreator);
}

// Return address of function 'CFBundleGetPackageInfoInDirectory'
void* ewg_get_function_address_CFBundleGetPackageInfoInDirectory (void)
{
	return (void*) CFBundleGetPackageInfoInDirectory;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyResourceURL (CFBundleRef ewg_bundle, CFStringRef ewg_resourceName, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName)
{
	return CFBundleCopyResourceURL ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_resourceName, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName);
}

// Return address of function 'CFBundleCopyResourceURL'
void* ewg_get_function_address_CFBundleCopyResourceURL (void)
{
	return (void*) CFBundleCopyResourceURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURLsOfType'
// For ise
CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfType (CFBundleRef ewg_bundle, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName)
{
	return CFBundleCopyResourceURLsOfType ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName);
}

// Return address of function 'CFBundleCopyResourceURLsOfType'
void* ewg_get_function_address_CFBundleCopyResourceURLsOfType (void)
{
	return (void*) CFBundleCopyResourceURLsOfType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyLocalizedString'
// For ise
CFStringRef  ewg_function_CFBundleCopyLocalizedString (CFBundleRef ewg_bundle, CFStringRef ewg_key, CFStringRef ewg_value, CFStringRef ewg_tableName)
{
	return CFBundleCopyLocalizedString ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_key, (CFStringRef)ewg_value, (CFStringRef)ewg_tableName);
}

// Return address of function 'CFBundleCopyLocalizedString'
void* ewg_get_function_address_CFBundleCopyLocalizedString (void)
{
	return (void*) CFBundleCopyLocalizedString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURLInDirectory'
// For ise
CFURLRef  ewg_function_CFBundleCopyResourceURLInDirectory (CFURLRef ewg_bundleURL, CFStringRef ewg_resourceName, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName)
{
	return CFBundleCopyResourceURLInDirectory ((CFURLRef)ewg_bundleURL, (CFStringRef)ewg_resourceName, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName);
}

// Return address of function 'CFBundleCopyResourceURLInDirectory'
void* ewg_get_function_address_CFBundleCopyResourceURLInDirectory (void)
{
	return (void*) CFBundleCopyResourceURLInDirectory;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURLsOfTypeInDirectory'
// For ise
CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfTypeInDirectory (CFURLRef ewg_bundleURL, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName)
{
	return CFBundleCopyResourceURLsOfTypeInDirectory ((CFURLRef)ewg_bundleURL, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName);
}

// Return address of function 'CFBundleCopyResourceURLsOfTypeInDirectory'
void* ewg_get_function_address_CFBundleCopyResourceURLsOfTypeInDirectory (void)
{
	return (void*) CFBundleCopyResourceURLsOfTypeInDirectory;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyBundleLocalizations'
// For ise
CFArrayRef  ewg_function_CFBundleCopyBundleLocalizations (CFBundleRef ewg_bundle)
{
	return CFBundleCopyBundleLocalizations ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyBundleLocalizations'
void* ewg_get_function_address_CFBundleCopyBundleLocalizations (void)
{
	return (void*) CFBundleCopyBundleLocalizations;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyPreferredLocalizationsFromArray'
// For ise
CFArrayRef  ewg_function_CFBundleCopyPreferredLocalizationsFromArray (CFArrayRef ewg_locArray)
{
	return CFBundleCopyPreferredLocalizationsFromArray ((CFArrayRef)ewg_locArray);
}

// Return address of function 'CFBundleCopyPreferredLocalizationsFromArray'
void* ewg_get_function_address_CFBundleCopyPreferredLocalizationsFromArray (void)
{
	return (void*) CFBundleCopyPreferredLocalizationsFromArray;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyLocalizationsForPreferences'
// For ise
CFArrayRef  ewg_function_CFBundleCopyLocalizationsForPreferences (CFArrayRef ewg_locArray, CFArrayRef ewg_prefArray)
{
	return CFBundleCopyLocalizationsForPreferences ((CFArrayRef)ewg_locArray, (CFArrayRef)ewg_prefArray);
}

// Return address of function 'CFBundleCopyLocalizationsForPreferences'
void* ewg_get_function_address_CFBundleCopyLocalizationsForPreferences (void)
{
	return (void*) CFBundleCopyLocalizationsForPreferences;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURLForLocalization'
// For ise
CFURLRef  ewg_function_CFBundleCopyResourceURLForLocalization (CFBundleRef ewg_bundle, CFStringRef ewg_resourceName, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName, CFStringRef ewg_localizationName)
{
	return CFBundleCopyResourceURLForLocalization ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_resourceName, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName, (CFStringRef)ewg_localizationName);
}

// Return address of function 'CFBundleCopyResourceURLForLocalization'
void* ewg_get_function_address_CFBundleCopyResourceURLForLocalization (void)
{
	return (void*) CFBundleCopyResourceURLForLocalization;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyResourceURLsOfTypeForLocalization'
// For ise
CFArrayRef  ewg_function_CFBundleCopyResourceURLsOfTypeForLocalization (CFBundleRef ewg_bundle, CFStringRef ewg_resourceType, CFStringRef ewg_subDirName, CFStringRef ewg_localizationName)
{
	return CFBundleCopyResourceURLsOfTypeForLocalization ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_resourceType, (CFStringRef)ewg_subDirName, (CFStringRef)ewg_localizationName);
}

// Return address of function 'CFBundleCopyResourceURLsOfTypeForLocalization'
void* ewg_get_function_address_CFBundleCopyResourceURLsOfTypeForLocalization (void)
{
	return (void*) CFBundleCopyResourceURLsOfTypeForLocalization;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyInfoDictionaryForURL'
// For ise
CFDictionaryRef  ewg_function_CFBundleCopyInfoDictionaryForURL (CFURLRef ewg_url)
{
	return CFBundleCopyInfoDictionaryForURL ((CFURLRef)ewg_url);
}

// Return address of function 'CFBundleCopyInfoDictionaryForURL'
void* ewg_get_function_address_CFBundleCopyInfoDictionaryForURL (void)
{
	return (void*) CFBundleCopyInfoDictionaryForURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyLocalizationsForURL'
// For ise
CFArrayRef  ewg_function_CFBundleCopyLocalizationsForURL (CFURLRef ewg_url)
{
	return CFBundleCopyLocalizationsForURL ((CFURLRef)ewg_url);
}

// Return address of function 'CFBundleCopyLocalizationsForURL'
void* ewg_get_function_address_CFBundleCopyLocalizationsForURL (void)
{
	return (void*) CFBundleCopyLocalizationsForURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyExecutableURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyExecutableURL (CFBundleRef ewg_bundle)
{
	return CFBundleCopyExecutableURL ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleCopyExecutableURL'
void* ewg_get_function_address_CFBundleCopyExecutableURL (void)
{
	return (void*) CFBundleCopyExecutableURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleIsExecutableLoaded'
// For ise
Boolean  ewg_function_CFBundleIsExecutableLoaded (CFBundleRef ewg_bundle)
{
	return CFBundleIsExecutableLoaded ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleIsExecutableLoaded'
void* ewg_get_function_address_CFBundleIsExecutableLoaded (void)
{
	return (void*) CFBundleIsExecutableLoaded;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleLoadExecutable'
// For ise
Boolean  ewg_function_CFBundleLoadExecutable (CFBundleRef ewg_bundle)
{
	return CFBundleLoadExecutable ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleLoadExecutable'
void* ewg_get_function_address_CFBundleLoadExecutable (void)
{
	return (void*) CFBundleLoadExecutable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleUnloadExecutable'
// For ise
void  ewg_function_CFBundleUnloadExecutable (CFBundleRef ewg_bundle)
{
	CFBundleUnloadExecutable ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleUnloadExecutable'
void* ewg_get_function_address_CFBundleUnloadExecutable (void)
{
	return (void*) CFBundleUnloadExecutable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetFunctionPointerForName'
// For ise
void * ewg_function_CFBundleGetFunctionPointerForName (CFBundleRef ewg_bundle, CFStringRef ewg_functionName)
{
	return CFBundleGetFunctionPointerForName ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_functionName);
}

// Return address of function 'CFBundleGetFunctionPointerForName'
void* ewg_get_function_address_CFBundleGetFunctionPointerForName (void)
{
	return (void*) CFBundleGetFunctionPointerForName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetFunctionPointersForNames'
// For ise
void  ewg_function_CFBundleGetFunctionPointersForNames (CFBundleRef ewg_bundle, CFArrayRef ewg_functionNames, void *ewg_ftbl)
{
	CFBundleGetFunctionPointersForNames ((CFBundleRef)ewg_bundle, (CFArrayRef)ewg_functionNames, ewg_ftbl);
}

// Return address of function 'CFBundleGetFunctionPointersForNames'
void* ewg_get_function_address_CFBundleGetFunctionPointersForNames (void)
{
	return (void*) CFBundleGetFunctionPointersForNames;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetDataPointerForName'
// For ise
void * ewg_function_CFBundleGetDataPointerForName (CFBundleRef ewg_bundle, CFStringRef ewg_symbolName)
{
	return CFBundleGetDataPointerForName ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_symbolName);
}

// Return address of function 'CFBundleGetDataPointerForName'
void* ewg_get_function_address_CFBundleGetDataPointerForName (void)
{
	return (void*) CFBundleGetDataPointerForName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetDataPointersForNames'
// For ise
void  ewg_function_CFBundleGetDataPointersForNames (CFBundleRef ewg_bundle, CFArrayRef ewg_symbolNames, void *ewg_stbl)
{
	CFBundleGetDataPointersForNames ((CFBundleRef)ewg_bundle, (CFArrayRef)ewg_symbolNames, ewg_stbl);
}

// Return address of function 'CFBundleGetDataPointersForNames'
void* ewg_get_function_address_CFBundleGetDataPointersForNames (void)
{
	return (void*) CFBundleGetDataPointersForNames;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCopyAuxiliaryExecutableURL'
// For ise
CFURLRef  ewg_function_CFBundleCopyAuxiliaryExecutableURL (CFBundleRef ewg_bundle, CFStringRef ewg_executableName)
{
	return CFBundleCopyAuxiliaryExecutableURL ((CFBundleRef)ewg_bundle, (CFStringRef)ewg_executableName);
}

// Return address of function 'CFBundleCopyAuxiliaryExecutableURL'
void* ewg_get_function_address_CFBundleCopyAuxiliaryExecutableURL (void)
{
	return (void*) CFBundleCopyAuxiliaryExecutableURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleGetPlugIn'
// For ise
CFPlugInRef  ewg_function_CFBundleGetPlugIn (CFBundleRef ewg_bundle)
{
	return CFBundleGetPlugIn ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleGetPlugIn'
void* ewg_get_function_address_CFBundleGetPlugIn (void)
{
	return (void*) CFBundleGetPlugIn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleOpenBundleResourceMap'
// For ise
short  ewg_function_CFBundleOpenBundleResourceMap (CFBundleRef ewg_bundle)
{
	return CFBundleOpenBundleResourceMap ((CFBundleRef)ewg_bundle);
}

// Return address of function 'CFBundleOpenBundleResourceMap'
void* ewg_get_function_address_CFBundleOpenBundleResourceMap (void)
{
	return (void*) CFBundleOpenBundleResourceMap;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleOpenBundleResourceFiles'
// For ise
SInt32  ewg_function_CFBundleOpenBundleResourceFiles (CFBundleRef ewg_bundle, short *ewg_refNum, short *ewg_localizedRefNum)
{
	return CFBundleOpenBundleResourceFiles ((CFBundleRef)ewg_bundle, (short*)ewg_refNum, (short*)ewg_localizedRefNum);
}

// Return address of function 'CFBundleOpenBundleResourceFiles'
void* ewg_get_function_address_CFBundleOpenBundleResourceFiles (void)
{
	return (void*) CFBundleOpenBundleResourceFiles;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CFBundleCloseBundleResourceMap'
// For ise
void  ewg_function_CFBundleCloseBundleResourceMap (CFBundleRef ewg_bundle, short ewg_refNum)
{
	CFBundleCloseBundleResourceMap ((CFBundleRef)ewg_bundle, (short)ewg_refNum);
}

// Return address of function 'CFBundleCloseBundleResourceMap'
void* ewg_get_function_address_CFBundleCloseBundleResourceMap (void)
{
	return (void*) CFBundleCloseBundleResourceMap;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPointMake'
// For ise
CGPoint * ewg_function_CGPointMake (float ewg_x, float ewg_y)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGPointMake ((float)ewg_x, (float)ewg_y);
	return result;
}

// Return address of function 'CGPointMake'
void* ewg_get_function_address_CGPointMake (void)
{
	return (void*) CGPointMake;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGSizeMake'
// For ise
CGSize * ewg_function_CGSizeMake (float ewg_width, float ewg_height)
{
	CGSize *result = (CGSize*) malloc (sizeof(CGSize));
	*result = CGSizeMake ((float)ewg_width, (float)ewg_height);
	return result;
}

// Return address of function 'CGSizeMake'
void* ewg_get_function_address_CGSizeMake (void)
{
	return (void*) CGSizeMake;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectMake'
// For ise
CGRect * ewg_function_CGRectMake (float ewg_x, float ewg_y, float ewg_width, float ewg_height)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectMake ((float)ewg_x, (float)ewg_y, (float)ewg_width, (float)ewg_height);
	return result;
}

// Return address of function 'CGRectMake'
void* ewg_get_function_address_CGRectMake (void)
{
	return (void*) CGRectMake;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMinX'
// For ise
float  ewg_function_CGRectGetMinX (CGRect *ewg_rect)
{
	return CGRectGetMinX (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMinX'
void* ewg_get_function_address_CGRectGetMinX (void)
{
	return (void*) CGRectGetMinX;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMidX'
// For ise
float  ewg_function_CGRectGetMidX (CGRect *ewg_rect)
{
	return CGRectGetMidX (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMidX'
void* ewg_get_function_address_CGRectGetMidX (void)
{
	return (void*) CGRectGetMidX;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMaxX'
// For ise
float  ewg_function_CGRectGetMaxX (CGRect *ewg_rect)
{
	return CGRectGetMaxX (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMaxX'
void* ewg_get_function_address_CGRectGetMaxX (void)
{
	return (void*) CGRectGetMaxX;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMinY'
// For ise
float  ewg_function_CGRectGetMinY (CGRect *ewg_rect)
{
	return CGRectGetMinY (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMinY'
void* ewg_get_function_address_CGRectGetMinY (void)
{
	return (void*) CGRectGetMinY;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMidY'
// For ise
float  ewg_function_CGRectGetMidY (CGRect *ewg_rect)
{
	return CGRectGetMidY (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMidY'
void* ewg_get_function_address_CGRectGetMidY (void)
{
	return (void*) CGRectGetMidY;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetMaxY'
// For ise
float  ewg_function_CGRectGetMaxY (CGRect *ewg_rect)
{
	return CGRectGetMaxY (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetMaxY'
void* ewg_get_function_address_CGRectGetMaxY (void)
{
	return (void*) CGRectGetMaxY;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetWidth'
// For ise
float  ewg_function_CGRectGetWidth (CGRect *ewg_rect)
{
	return CGRectGetWidth (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetWidth'
void* ewg_get_function_address_CGRectGetWidth (void)
{
	return (void*) CGRectGetWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectGetHeight'
// For ise
float  ewg_function_CGRectGetHeight (CGRect *ewg_rect)
{
	return CGRectGetHeight (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectGetHeight'
void* ewg_get_function_address_CGRectGetHeight (void)
{
	return (void*) CGRectGetHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPointEqualToPoint'
// For ise
int  ewg_function_CGPointEqualToPoint (CGPoint *ewg_point1, CGPoint *ewg_point2)
{
	return CGPointEqualToPoint (*(CGPoint*)ewg_point1, *(CGPoint*)ewg_point2);
}

// Return address of function 'CGPointEqualToPoint'
void* ewg_get_function_address_CGPointEqualToPoint (void)
{
	return (void*) CGPointEqualToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGSizeEqualToSize'
// For ise
int  ewg_function_CGSizeEqualToSize (CGSize *ewg_size1, CGSize *ewg_size2)
{
	return CGSizeEqualToSize (*(CGSize*)ewg_size1, *(CGSize*)ewg_size2);
}

// Return address of function 'CGSizeEqualToSize'
void* ewg_get_function_address_CGSizeEqualToSize (void)
{
	return (void*) CGSizeEqualToSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectEqualToRect'
// For ise
int  ewg_function_CGRectEqualToRect (CGRect *ewg_rect1, CGRect *ewg_rect2)
{
	return CGRectEqualToRect (*(CGRect*)ewg_rect1, *(CGRect*)ewg_rect2);
}

// Return address of function 'CGRectEqualToRect'
void* ewg_get_function_address_CGRectEqualToRect (void)
{
	return (void*) CGRectEqualToRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectStandardize'
// For ise
CGRect * ewg_function_CGRectStandardize (CGRect *ewg_rect)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectStandardize (*(CGRect*)ewg_rect);
	return result;
}

// Return address of function 'CGRectStandardize'
void* ewg_get_function_address_CGRectStandardize (void)
{
	return (void*) CGRectStandardize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIsEmpty'
// For ise
int  ewg_function_CGRectIsEmpty (CGRect *ewg_rect)
{
	return CGRectIsEmpty (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectIsEmpty'
void* ewg_get_function_address_CGRectIsEmpty (void)
{
	return (void*) CGRectIsEmpty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIsNull'
// For ise
int  ewg_function_CGRectIsNull (CGRect *ewg_rect)
{
	return CGRectIsNull (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectIsNull'
void* ewg_get_function_address_CGRectIsNull (void)
{
	return (void*) CGRectIsNull;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIsInfinite'
// For ise
_Bool  ewg_function_CGRectIsInfinite (CGRect *ewg_rect)
{
	return CGRectIsInfinite (*(CGRect*)ewg_rect);
}

// Return address of function 'CGRectIsInfinite'
void* ewg_get_function_address_CGRectIsInfinite (void)
{
	return (void*) CGRectIsInfinite;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectInset'
// For ise
CGRect * ewg_function_CGRectInset (CGRect *ewg_rect, float ewg_dx, float ewg_dy)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectInset (*(CGRect*)ewg_rect, (float)ewg_dx, (float)ewg_dy);
	return result;
}

// Return address of function 'CGRectInset'
void* ewg_get_function_address_CGRectInset (void)
{
	return (void*) CGRectInset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIntegral'
// For ise
CGRect * ewg_function_CGRectIntegral (CGRect *ewg_rect)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectIntegral (*(CGRect*)ewg_rect);
	return result;
}

// Return address of function 'CGRectIntegral'
void* ewg_get_function_address_CGRectIntegral (void)
{
	return (void*) CGRectIntegral;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectUnion'
// For ise
CGRect * ewg_function_CGRectUnion (CGRect *ewg_r1, CGRect *ewg_r2)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectUnion (*(CGRect*)ewg_r1, *(CGRect*)ewg_r2);
	return result;
}

// Return address of function 'CGRectUnion'
void* ewg_get_function_address_CGRectUnion (void)
{
	return (void*) CGRectUnion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIntersection'
// For ise
CGRect * ewg_function_CGRectIntersection (CGRect *ewg_r1, CGRect *ewg_r2)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectIntersection (*(CGRect*)ewg_r1, *(CGRect*)ewg_r2);
	return result;
}

// Return address of function 'CGRectIntersection'
void* ewg_get_function_address_CGRectIntersection (void)
{
	return (void*) CGRectIntersection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectOffset'
// For ise
CGRect * ewg_function_CGRectOffset (CGRect *ewg_rect, float ewg_dx, float ewg_dy)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectOffset (*(CGRect*)ewg_rect, (float)ewg_dx, (float)ewg_dy);
	return result;
}

// Return address of function 'CGRectOffset'
void* ewg_get_function_address_CGRectOffset (void)
{
	return (void*) CGRectOffset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectDivide'
// For ise
void  ewg_function_CGRectDivide (CGRect *ewg_rect, CGRect *ewg_slice, CGRect *ewg_remainder, float ewg_amount, CGRectEdge ewg_edge)
{
	CGRectDivide (*(CGRect*)ewg_rect, (CGRect*)ewg_slice, (CGRect*)ewg_remainder, (float)ewg_amount, (CGRectEdge)ewg_edge);
}

// Return address of function 'CGRectDivide'
void* ewg_get_function_address_CGRectDivide (void)
{
	return (void*) CGRectDivide;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectContainsPoint'
// For ise
int  ewg_function_CGRectContainsPoint (CGRect *ewg_rect, CGPoint *ewg_point)
{
	return CGRectContainsPoint (*(CGRect*)ewg_rect, *(CGPoint*)ewg_point);
}

// Return address of function 'CGRectContainsPoint'
void* ewg_get_function_address_CGRectContainsPoint (void)
{
	return (void*) CGRectContainsPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectContainsRect'
// For ise
int  ewg_function_CGRectContainsRect (CGRect *ewg_rect1, CGRect *ewg_rect2)
{
	return CGRectContainsRect (*(CGRect*)ewg_rect1, *(CGRect*)ewg_rect2);
}

// Return address of function 'CGRectContainsRect'
void* ewg_get_function_address_CGRectContainsRect (void)
{
	return (void*) CGRectContainsRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectIntersectsRect'
// For ise
int  ewg_function_CGRectIntersectsRect (CGRect *ewg_rect1, CGRect *ewg_rect2)
{
	return CGRectIntersectsRect (*(CGRect*)ewg_rect1, *(CGRect*)ewg_rect2);
}

// Return address of function 'CGRectIntersectsRect'
void* ewg_get_function_address_CGRectIntersectsRect (void)
{
	return (void*) CGRectIntersectsRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformMake'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformMake (float ewg_a, float ewg_b, float ewg_c, float ewg_d, float ewg_tx, float ewg_ty)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformMake ((float)ewg_a, (float)ewg_b, (float)ewg_c, (float)ewg_d, (float)ewg_tx, (float)ewg_ty);
	return result;
}

// Return address of function 'CGAffineTransformMake'
void* ewg_get_function_address_CGAffineTransformMake (void)
{
	return (void*) CGAffineTransformMake;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformMakeTranslation'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformMakeTranslation (float ewg_tx, float ewg_ty)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformMakeTranslation ((float)ewg_tx, (float)ewg_ty);
	return result;
}

// Return address of function 'CGAffineTransformMakeTranslation'
void* ewg_get_function_address_CGAffineTransformMakeTranslation (void)
{
	return (void*) CGAffineTransformMakeTranslation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformMakeScale'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformMakeScale (float ewg_sx, float ewg_sy)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformMakeScale ((float)ewg_sx, (float)ewg_sy);
	return result;
}

// Return address of function 'CGAffineTransformMakeScale'
void* ewg_get_function_address_CGAffineTransformMakeScale (void)
{
	return (void*) CGAffineTransformMakeScale;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformMakeRotation'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformMakeRotation (float ewg_angle)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformMakeRotation ((float)ewg_angle);
	return result;
}

// Return address of function 'CGAffineTransformMakeRotation'
void* ewg_get_function_address_CGAffineTransformMakeRotation (void)
{
	return (void*) CGAffineTransformMakeRotation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformIsIdentity'
// For ise
_Bool  ewg_function_CGAffineTransformIsIdentity (CGAffineTransform *ewg_t)
{
	return CGAffineTransformIsIdentity (*(CGAffineTransform*)ewg_t);
}

// Return address of function 'CGAffineTransformIsIdentity'
void* ewg_get_function_address_CGAffineTransformIsIdentity (void)
{
	return (void*) CGAffineTransformIsIdentity;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformTranslate'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformTranslate (CGAffineTransform *ewg_t, float ewg_tx, float ewg_ty)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformTranslate (*(CGAffineTransform*)ewg_t, (float)ewg_tx, (float)ewg_ty);
	return result;
}

// Return address of function 'CGAffineTransformTranslate'
void* ewg_get_function_address_CGAffineTransformTranslate (void)
{
	return (void*) CGAffineTransformTranslate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformScale'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformScale (CGAffineTransform *ewg_t, float ewg_sx, float ewg_sy)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformScale (*(CGAffineTransform*)ewg_t, (float)ewg_sx, (float)ewg_sy);
	return result;
}

// Return address of function 'CGAffineTransformScale'
void* ewg_get_function_address_CGAffineTransformScale (void)
{
	return (void*) CGAffineTransformScale;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformRotate'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformRotate (CGAffineTransform *ewg_t, float ewg_angle)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformRotate (*(CGAffineTransform*)ewg_t, (float)ewg_angle);
	return result;
}

// Return address of function 'CGAffineTransformRotate'
void* ewg_get_function_address_CGAffineTransformRotate (void)
{
	return (void*) CGAffineTransformRotate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformInvert'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformInvert (CGAffineTransform *ewg_t)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformInvert (*(CGAffineTransform*)ewg_t);
	return result;
}

// Return address of function 'CGAffineTransformInvert'
void* ewg_get_function_address_CGAffineTransformInvert (void)
{
	return (void*) CGAffineTransformInvert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformConcat'
// For ise
CGAffineTransform * ewg_function_CGAffineTransformConcat (CGAffineTransform *ewg_t1, CGAffineTransform *ewg_t2)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGAffineTransformConcat (*(CGAffineTransform*)ewg_t1, *(CGAffineTransform*)ewg_t2);
	return result;
}

// Return address of function 'CGAffineTransformConcat'
void* ewg_get_function_address_CGAffineTransformConcat (void)
{
	return (void*) CGAffineTransformConcat;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGAffineTransformEqualToTransform'
// For ise
_Bool  ewg_function_CGAffineTransformEqualToTransform (CGAffineTransform *ewg_t1, CGAffineTransform *ewg_t2)
{
	return CGAffineTransformEqualToTransform (*(CGAffineTransform*)ewg_t1, *(CGAffineTransform*)ewg_t2);
}

// Return address of function 'CGAffineTransformEqualToTransform'
void* ewg_get_function_address_CGAffineTransformEqualToTransform (void)
{
	return (void*) CGAffineTransformEqualToTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPointApplyAffineTransform'
// For ise
CGPoint * ewg_function_CGPointApplyAffineTransform (CGPoint *ewg_point, CGAffineTransform *ewg_t)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGPointApplyAffineTransform (*(CGPoint*)ewg_point, *(CGAffineTransform*)ewg_t);
	return result;
}

// Return address of function 'CGPointApplyAffineTransform'
void* ewg_get_function_address_CGPointApplyAffineTransform (void)
{
	return (void*) CGPointApplyAffineTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGSizeApplyAffineTransform'
// For ise
CGSize * ewg_function_CGSizeApplyAffineTransform (CGSize *ewg_size, CGAffineTransform *ewg_t)
{
	CGSize *result = (CGSize*) malloc (sizeof(CGSize));
	*result = CGSizeApplyAffineTransform (*(CGSize*)ewg_size, *(CGAffineTransform*)ewg_t);
	return result;
}

// Return address of function 'CGSizeApplyAffineTransform'
void* ewg_get_function_address_CGSizeApplyAffineTransform (void)
{
	return (void*) CGSizeApplyAffineTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGRectApplyAffineTransform'
// For ise
CGRect * ewg_function_CGRectApplyAffineTransform (CGRect *ewg_rect, CGAffineTransform *ewg_t)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGRectApplyAffineTransform (*(CGRect*)ewg_rect, *(CGAffineTransform*)ewg_t);
	return result;
}

// Return address of function 'CGRectApplyAffineTransform'
void* ewg_get_function_address_CGRectApplyAffineTransform (void)
{
	return (void*) CGRectApplyAffineTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderGetTypeID'
// For ise
CFTypeID  ewg_function_CGDataProviderGetTypeID (void)
{
	return CGDataProviderGetTypeID ();
}

// Return address of function 'CGDataProviderGetTypeID'
void* ewg_get_function_address_CGDataProviderGetTypeID (void)
{
	return (void*) CGDataProviderGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreate'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreate (void *ewg_info, CGDataProviderCallbacks const *ewg_callbacks)
{
	return CGDataProviderCreate ((void*)ewg_info, (CGDataProviderCallbacks const*)ewg_callbacks);
}

// Return address of function 'CGDataProviderCreate'
void* ewg_get_function_address_CGDataProviderCreate (void)
{
	return (void*) CGDataProviderCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreateDirectAccess'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreateDirectAccess (void *ewg_info, size_t ewg_size, CGDataProviderDirectAccessCallbacks const *ewg_callbacks)
{
	return CGDataProviderCreateDirectAccess ((void*)ewg_info, (size_t)ewg_size, (CGDataProviderDirectAccessCallbacks const*)ewg_callbacks);
}

// Return address of function 'CGDataProviderCreateDirectAccess'
void* ewg_get_function_address_CGDataProviderCreateDirectAccess (void)
{
	return (void*) CGDataProviderCreateDirectAccess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreateWithData'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreateWithData (void *ewg_info, void const *ewg_data, size_t ewg_size, CGDataProviderReleaseDataCallback ewg_releaseData)
{
	return CGDataProviderCreateWithData ((void*)ewg_info, (void const*)ewg_data, (size_t)ewg_size, (CGDataProviderReleaseDataCallback)ewg_releaseData);
}

// Return address of function 'CGDataProviderCreateWithData'
void* ewg_get_function_address_CGDataProviderCreateWithData (void)
{
	return (void*) CGDataProviderCreateWithData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreateWithCFData'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreateWithCFData (CFDataRef ewg_data)
{
	return CGDataProviderCreateWithCFData ((CFDataRef)ewg_data);
}

// Return address of function 'CGDataProviderCreateWithCFData'
void* ewg_get_function_address_CGDataProviderCreateWithCFData (void)
{
	return (void*) CGDataProviderCreateWithCFData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreateWithURL'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreateWithURL (CFURLRef ewg_url)
{
	return CGDataProviderCreateWithURL ((CFURLRef)ewg_url);
}

// Return address of function 'CGDataProviderCreateWithURL'
void* ewg_get_function_address_CGDataProviderCreateWithURL (void)
{
	return (void*) CGDataProviderCreateWithURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderRetain'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderRetain (CGDataProviderRef ewg_provider)
{
	return CGDataProviderRetain ((CGDataProviderRef)ewg_provider);
}

// Return address of function 'CGDataProviderRetain'
void* ewg_get_function_address_CGDataProviderRetain (void)
{
	return (void*) CGDataProviderRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderRelease'
// For ise
void  ewg_function_CGDataProviderRelease (CGDataProviderRef ewg_provider)
{
	CGDataProviderRelease ((CGDataProviderRef)ewg_provider);
}

// Return address of function 'CGDataProviderRelease'
void* ewg_get_function_address_CGDataProviderRelease (void)
{
	return (void*) CGDataProviderRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGDataProviderCreateWithFilename'
// For ise
CGDataProviderRef  ewg_function_CGDataProviderCreateWithFilename (char const *ewg_filename)
{
	return CGDataProviderCreateWithFilename ((char const*)ewg_filename);
}

// Return address of function 'CGDataProviderCreateWithFilename'
void* ewg_get_function_address_CGDataProviderCreateWithFilename (void)
{
	return (void*) CGDataProviderCreateWithFilename;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetTypeID'
// For ise
CFTypeID  ewg_function_CGImageGetTypeID (void)
{
	return CGImageGetTypeID ();
}

// Return address of function 'CGImageGetTypeID'
void* ewg_get_function_address_CGImageGetTypeID (void)
{
	return (void*) CGImageGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreate'
// For ise
CGImageRef  ewg_function_CGImageCreate (size_t ewg_width, size_t ewg_height, size_t ewg_bitsPerComponent, size_t ewg_bitsPerPixel, size_t ewg_bytesPerRow, CGColorSpaceRef ewg_colorspace, CGBitmapInfo ewg_bitmapInfo, CGDataProviderRef ewg_provider, void *ewg_decode, _Bool ewg_shouldInterpolate, CGColorRenderingIntent ewg_intent)
{
	return CGImageCreate ((size_t)ewg_width, (size_t)ewg_height, (size_t)ewg_bitsPerComponent, (size_t)ewg_bitsPerPixel, (size_t)ewg_bytesPerRow, (CGColorSpaceRef)ewg_colorspace, (CGBitmapInfo)ewg_bitmapInfo, (CGDataProviderRef)ewg_provider, ewg_decode, (_Bool)ewg_shouldInterpolate, (CGColorRenderingIntent)ewg_intent);
}

// Return address of function 'CGImageCreate'
void* ewg_get_function_address_CGImageCreate (void)
{
	return (void*) CGImageCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageMaskCreate'
// For ise
CGImageRef  ewg_function_CGImageMaskCreate (size_t ewg_width, size_t ewg_height, size_t ewg_bitsPerComponent, size_t ewg_bitsPerPixel, size_t ewg_bytesPerRow, CGDataProviderRef ewg_provider, void *ewg_decode, _Bool ewg_shouldInterpolate)
{
	return CGImageMaskCreate ((size_t)ewg_width, (size_t)ewg_height, (size_t)ewg_bitsPerComponent, (size_t)ewg_bitsPerPixel, (size_t)ewg_bytesPerRow, (CGDataProviderRef)ewg_provider, ewg_decode, (_Bool)ewg_shouldInterpolate);
}

// Return address of function 'CGImageMaskCreate'
void* ewg_get_function_address_CGImageMaskCreate (void)
{
	return (void*) CGImageMaskCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateCopy'
// For ise
CGImageRef  ewg_function_CGImageCreateCopy (CGImageRef ewg_image)
{
	return CGImageCreateCopy ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageCreateCopy'
void* ewg_get_function_address_CGImageCreateCopy (void)
{
	return (void*) CGImageCreateCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateWithJPEGDataProvider'
// For ise
CGImageRef  ewg_function_CGImageCreateWithJPEGDataProvider (CGDataProviderRef ewg_source, void *ewg_decode, _Bool ewg_shouldInterpolate, CGColorRenderingIntent ewg_intent)
{
	return CGImageCreateWithJPEGDataProvider ((CGDataProviderRef)ewg_source, ewg_decode, (_Bool)ewg_shouldInterpolate, (CGColorRenderingIntent)ewg_intent);
}

// Return address of function 'CGImageCreateWithJPEGDataProvider'
void* ewg_get_function_address_CGImageCreateWithJPEGDataProvider (void)
{
	return (void*) CGImageCreateWithJPEGDataProvider;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateWithPNGDataProvider'
// For ise
CGImageRef  ewg_function_CGImageCreateWithPNGDataProvider (CGDataProviderRef ewg_source, void *ewg_decode, _Bool ewg_shouldInterpolate, CGColorRenderingIntent ewg_intent)
{
	return CGImageCreateWithPNGDataProvider ((CGDataProviderRef)ewg_source, ewg_decode, (_Bool)ewg_shouldInterpolate, (CGColorRenderingIntent)ewg_intent);
}

// Return address of function 'CGImageCreateWithPNGDataProvider'
void* ewg_get_function_address_CGImageCreateWithPNGDataProvider (void)
{
	return (void*) CGImageCreateWithPNGDataProvider;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateWithImageInRect'
// For ise
CGImageRef  ewg_function_CGImageCreateWithImageInRect (CGImageRef ewg_image, CGRect *ewg_rect)
{
	return CGImageCreateWithImageInRect ((CGImageRef)ewg_image, *(CGRect*)ewg_rect);
}

// Return address of function 'CGImageCreateWithImageInRect'
void* ewg_get_function_address_CGImageCreateWithImageInRect (void)
{
	return (void*) CGImageCreateWithImageInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateWithMask'
// For ise
CGImageRef  ewg_function_CGImageCreateWithMask (CGImageRef ewg_image, CGImageRef ewg_mask)
{
	return CGImageCreateWithMask ((CGImageRef)ewg_image, (CGImageRef)ewg_mask);
}

// Return address of function 'CGImageCreateWithMask'
void* ewg_get_function_address_CGImageCreateWithMask (void)
{
	return (void*) CGImageCreateWithMask;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateWithMaskingColors'
// For ise
CGImageRef  ewg_function_CGImageCreateWithMaskingColors (CGImageRef ewg_image, void *ewg_components)
{
	return CGImageCreateWithMaskingColors ((CGImageRef)ewg_image, ewg_components);
}

// Return address of function 'CGImageCreateWithMaskingColors'
void* ewg_get_function_address_CGImageCreateWithMaskingColors (void)
{
	return (void*) CGImageCreateWithMaskingColors;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageCreateCopyWithColorSpace'
// For ise
CGImageRef  ewg_function_CGImageCreateCopyWithColorSpace (CGImageRef ewg_image, CGColorSpaceRef ewg_colorspace)
{
	return CGImageCreateCopyWithColorSpace ((CGImageRef)ewg_image, (CGColorSpaceRef)ewg_colorspace);
}

// Return address of function 'CGImageCreateCopyWithColorSpace'
void* ewg_get_function_address_CGImageCreateCopyWithColorSpace (void)
{
	return (void*) CGImageCreateCopyWithColorSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageRetain'
// For ise
CGImageRef  ewg_function_CGImageRetain (CGImageRef ewg_image)
{
	return CGImageRetain ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageRetain'
void* ewg_get_function_address_CGImageRetain (void)
{
	return (void*) CGImageRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageRelease'
// For ise
void  ewg_function_CGImageRelease (CGImageRef ewg_image)
{
	CGImageRelease ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageRelease'
void* ewg_get_function_address_CGImageRelease (void)
{
	return (void*) CGImageRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageIsMask'
// For ise
_Bool  ewg_function_CGImageIsMask (CGImageRef ewg_image)
{
	return CGImageIsMask ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageIsMask'
void* ewg_get_function_address_CGImageIsMask (void)
{
	return (void*) CGImageIsMask;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetWidth'
// For ise
size_t  ewg_function_CGImageGetWidth (CGImageRef ewg_image)
{
	return CGImageGetWidth ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetWidth'
void* ewg_get_function_address_CGImageGetWidth (void)
{
	return (void*) CGImageGetWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetHeight'
// For ise
size_t  ewg_function_CGImageGetHeight (CGImageRef ewg_image)
{
	return CGImageGetHeight ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetHeight'
void* ewg_get_function_address_CGImageGetHeight (void)
{
	return (void*) CGImageGetHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetBitsPerComponent'
// For ise
size_t  ewg_function_CGImageGetBitsPerComponent (CGImageRef ewg_image)
{
	return CGImageGetBitsPerComponent ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetBitsPerComponent'
void* ewg_get_function_address_CGImageGetBitsPerComponent (void)
{
	return (void*) CGImageGetBitsPerComponent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetBitsPerPixel'
// For ise
size_t  ewg_function_CGImageGetBitsPerPixel (CGImageRef ewg_image)
{
	return CGImageGetBitsPerPixel ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetBitsPerPixel'
void* ewg_get_function_address_CGImageGetBitsPerPixel (void)
{
	return (void*) CGImageGetBitsPerPixel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetBytesPerRow'
// For ise
size_t  ewg_function_CGImageGetBytesPerRow (CGImageRef ewg_image)
{
	return CGImageGetBytesPerRow ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetBytesPerRow'
void* ewg_get_function_address_CGImageGetBytesPerRow (void)
{
	return (void*) CGImageGetBytesPerRow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetColorSpace'
// For ise
CGColorSpaceRef  ewg_function_CGImageGetColorSpace (CGImageRef ewg_image)
{
	return CGImageGetColorSpace ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetColorSpace'
void* ewg_get_function_address_CGImageGetColorSpace (void)
{
	return (void*) CGImageGetColorSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetAlphaInfo'
// For ise
CGImageAlphaInfo  ewg_function_CGImageGetAlphaInfo (CGImageRef ewg_image)
{
	return CGImageGetAlphaInfo ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetAlphaInfo'
void* ewg_get_function_address_CGImageGetAlphaInfo (void)
{
	return (void*) CGImageGetAlphaInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetDataProvider'
// For ise
CGDataProviderRef  ewg_function_CGImageGetDataProvider (CGImageRef ewg_image)
{
	return CGImageGetDataProvider ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetDataProvider'
void* ewg_get_function_address_CGImageGetDataProvider (void)
{
	return (void*) CGImageGetDataProvider;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetDecode'
// For ise
float const * ewg_function_CGImageGetDecode (CGImageRef ewg_image)
{
	return CGImageGetDecode ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetDecode'
void* ewg_get_function_address_CGImageGetDecode (void)
{
	return (void*) CGImageGetDecode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetShouldInterpolate'
// For ise
_Bool  ewg_function_CGImageGetShouldInterpolate (CGImageRef ewg_image)
{
	return CGImageGetShouldInterpolate ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetShouldInterpolate'
void* ewg_get_function_address_CGImageGetShouldInterpolate (void)
{
	return (void*) CGImageGetShouldInterpolate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetRenderingIntent'
// For ise
CGColorRenderingIntent  ewg_function_CGImageGetRenderingIntent (CGImageRef ewg_image)
{
	return CGImageGetRenderingIntent ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetRenderingIntent'
void* ewg_get_function_address_CGImageGetRenderingIntent (void)
{
	return (void*) CGImageGetRenderingIntent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGImageGetBitmapInfo'
// For ise
CGBitmapInfo  ewg_function_CGImageGetBitmapInfo (CGImageRef ewg_image)
{
	return CGImageGetBitmapInfo ((CGImageRef)ewg_image);
}

// Return address of function 'CGImageGetBitmapInfo'
void* ewg_get_function_address_CGImageGetBitmapInfo (void)
{
	return (void*) CGImageGetBitmapInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathGetTypeID'
// For ise
CFTypeID  ewg_function_CGPathGetTypeID (void)
{
	return CGPathGetTypeID ();
}

// Return address of function 'CGPathGetTypeID'
void* ewg_get_function_address_CGPathGetTypeID (void)
{
	return (void*) CGPathGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathCreateMutable'
// For ise
CGMutablePathRef  ewg_function_CGPathCreateMutable (void)
{
	return CGPathCreateMutable ();
}

// Return address of function 'CGPathCreateMutable'
void* ewg_get_function_address_CGPathCreateMutable (void)
{
	return (void*) CGPathCreateMutable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathCreateCopy'
// For ise
CGPathRef  ewg_function_CGPathCreateCopy (CGPathRef ewg_path)
{
	return CGPathCreateCopy ((CGPathRef)ewg_path);
}

// Return address of function 'CGPathCreateCopy'
void* ewg_get_function_address_CGPathCreateCopy (void)
{
	return (void*) CGPathCreateCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathCreateMutableCopy'
// For ise
CGMutablePathRef  ewg_function_CGPathCreateMutableCopy (CGPathRef ewg_path)
{
	return CGPathCreateMutableCopy ((CGPathRef)ewg_path);
}

// Return address of function 'CGPathCreateMutableCopy'
void* ewg_get_function_address_CGPathCreateMutableCopy (void)
{
	return (void*) CGPathCreateMutableCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathRetain'
// For ise
CGPathRef  ewg_function_CGPathRetain (CGPathRef ewg_path)
{
	return CGPathRetain ((CGPathRef)ewg_path);
}

// Return address of function 'CGPathRetain'
void* ewg_get_function_address_CGPathRetain (void)
{
	return (void*) CGPathRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathRelease'
// For ise
void  ewg_function_CGPathRelease (CGPathRef ewg_path)
{
	CGPathRelease ((CGPathRef)ewg_path);
}

// Return address of function 'CGPathRelease'
void* ewg_get_function_address_CGPathRelease (void)
{
	return (void*) CGPathRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathEqualToPath'
// For ise
_Bool  ewg_function_CGPathEqualToPath (CGPathRef ewg_path1, CGPathRef ewg_path2)
{
	return CGPathEqualToPath ((CGPathRef)ewg_path1, (CGPathRef)ewg_path2);
}

// Return address of function 'CGPathEqualToPath'
void* ewg_get_function_address_CGPathEqualToPath (void)
{
	return (void*) CGPathEqualToPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathMoveToPoint'
// For ise
void  ewg_function_CGPathMoveToPoint (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_x, float ewg_y)
{
	CGPathMoveToPoint ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGPathMoveToPoint'
void* ewg_get_function_address_CGPathMoveToPoint (void)
{
	return (void*) CGPathMoveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddLineToPoint'
// For ise
void  ewg_function_CGPathAddLineToPoint (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_x, float ewg_y)
{
	CGPathAddLineToPoint ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGPathAddLineToPoint'
void* ewg_get_function_address_CGPathAddLineToPoint (void)
{
	return (void*) CGPathAddLineToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddQuadCurveToPoint'
// For ise
void  ewg_function_CGPathAddQuadCurveToPoint (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_cpx, float ewg_cpy, float ewg_x, float ewg_y)
{
	CGPathAddQuadCurveToPoint ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_cpx, (float)ewg_cpy, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGPathAddQuadCurveToPoint'
void* ewg_get_function_address_CGPathAddQuadCurveToPoint (void)
{
	return (void*) CGPathAddQuadCurveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddCurveToPoint'
// For ise
void  ewg_function_CGPathAddCurveToPoint (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_cp1x, float ewg_cp1y, float ewg_cp2x, float ewg_cp2y, float ewg_x, float ewg_y)
{
	CGPathAddCurveToPoint ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_cp1x, (float)ewg_cp1y, (float)ewg_cp2x, (float)ewg_cp2y, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGPathAddCurveToPoint'
void* ewg_get_function_address_CGPathAddCurveToPoint (void)
{
	return (void*) CGPathAddCurveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathCloseSubpath'
// For ise
void  ewg_function_CGPathCloseSubpath (CGMutablePathRef ewg_path)
{
	CGPathCloseSubpath ((CGMutablePathRef)ewg_path);
}

// Return address of function 'CGPathCloseSubpath'
void* ewg_get_function_address_CGPathCloseSubpath (void)
{
	return (void*) CGPathCloseSubpath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddRect'
// For ise
void  ewg_function_CGPathAddRect (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, CGRect *ewg_rect)
{
	CGPathAddRect ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, *(CGRect*)ewg_rect);
}

// Return address of function 'CGPathAddRect'
void* ewg_get_function_address_CGPathAddRect (void)
{
	return (void*) CGPathAddRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddRects'
// For ise
void  ewg_function_CGPathAddRects (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, void *ewg_rects, size_t ewg_count)
{
	CGPathAddRects ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, ewg_rects, (size_t)ewg_count);
}

// Return address of function 'CGPathAddRects'
void* ewg_get_function_address_CGPathAddRects (void)
{
	return (void*) CGPathAddRects;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddLines'
// For ise
void  ewg_function_CGPathAddLines (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, void *ewg_points, size_t ewg_count)
{
	CGPathAddLines ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, ewg_points, (size_t)ewg_count);
}

// Return address of function 'CGPathAddLines'
void* ewg_get_function_address_CGPathAddLines (void)
{
	return (void*) CGPathAddLines;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddEllipseInRect'
// For ise
void  ewg_function_CGPathAddEllipseInRect (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, CGRect *ewg_rect)
{
	CGPathAddEllipseInRect ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, *(CGRect*)ewg_rect);
}

// Return address of function 'CGPathAddEllipseInRect'
void* ewg_get_function_address_CGPathAddEllipseInRect (void)
{
	return (void*) CGPathAddEllipseInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddArc'
// For ise
void  ewg_function_CGPathAddArc (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_x, float ewg_y, float ewg_radius, float ewg_startAngle, float ewg_endAngle, _Bool ewg_clockwise)
{
	CGPathAddArc ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_x, (float)ewg_y, (float)ewg_radius, (float)ewg_startAngle, (float)ewg_endAngle, (_Bool)ewg_clockwise);
}

// Return address of function 'CGPathAddArc'
void* ewg_get_function_address_CGPathAddArc (void)
{
	return (void*) CGPathAddArc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddArcToPoint'
// For ise
void  ewg_function_CGPathAddArcToPoint (CGMutablePathRef ewg_path, CGAffineTransform const *ewg_m, float ewg_x1, float ewg_y1, float ewg_x2, float ewg_y2, float ewg_radius)
{
	CGPathAddArcToPoint ((CGMutablePathRef)ewg_path, (CGAffineTransform const*)ewg_m, (float)ewg_x1, (float)ewg_y1, (float)ewg_x2, (float)ewg_y2, (float)ewg_radius);
}

// Return address of function 'CGPathAddArcToPoint'
void* ewg_get_function_address_CGPathAddArcToPoint (void)
{
	return (void*) CGPathAddArcToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathAddPath'
// For ise
void  ewg_function_CGPathAddPath (CGMutablePathRef ewg_path1, CGAffineTransform const *ewg_m, CGPathRef ewg_path2)
{
	CGPathAddPath ((CGMutablePathRef)ewg_path1, (CGAffineTransform const*)ewg_m, (CGPathRef)ewg_path2);
}

// Return address of function 'CGPathAddPath'
void* ewg_get_function_address_CGPathAddPath (void)
{
	return (void*) CGPathAddPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathIsEmpty'
// For ise
_Bool  ewg_function_CGPathIsEmpty (CGPathRef ewg_path)
{
	return CGPathIsEmpty ((CGPathRef)ewg_path);
}

// Return address of function 'CGPathIsEmpty'
void* ewg_get_function_address_CGPathIsEmpty (void)
{
	return (void*) CGPathIsEmpty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathIsRect'
// For ise
_Bool  ewg_function_CGPathIsRect (CGPathRef ewg_path, CGRect *ewg_rect)
{
	return CGPathIsRect ((CGPathRef)ewg_path, (CGRect*)ewg_rect);
}

// Return address of function 'CGPathIsRect'
void* ewg_get_function_address_CGPathIsRect (void)
{
	return (void*) CGPathIsRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathGetCurrentPoint'
// For ise
CGPoint * ewg_function_CGPathGetCurrentPoint (CGPathRef ewg_path)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGPathGetCurrentPoint ((CGPathRef)ewg_path);
	return result;
}

// Return address of function 'CGPathGetCurrentPoint'
void* ewg_get_function_address_CGPathGetCurrentPoint (void)
{
	return (void*) CGPathGetCurrentPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathGetBoundingBox'
// For ise
CGRect * ewg_function_CGPathGetBoundingBox (CGPathRef ewg_path)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGPathGetBoundingBox ((CGPathRef)ewg_path);
	return result;
}

// Return address of function 'CGPathGetBoundingBox'
void* ewg_get_function_address_CGPathGetBoundingBox (void)
{
	return (void*) CGPathGetBoundingBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathContainsPoint'
// For ise
_Bool  ewg_function_CGPathContainsPoint (CGPathRef ewg_path, CGAffineTransform const *ewg_m, CGPoint *ewg_point, _Bool ewg_eoFill)
{
	return CGPathContainsPoint ((CGPathRef)ewg_path, (CGAffineTransform const*)ewg_m, *(CGPoint*)ewg_point, (_Bool)ewg_eoFill);
}

// Return address of function 'CGPathContainsPoint'
void* ewg_get_function_address_CGPathContainsPoint (void)
{
	return (void*) CGPathContainsPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGPathApply'
// For ise
void  ewg_function_CGPathApply (CGPathRef ewg_path, void *ewg_info, CGPathApplierFunction ewg_function)
{
	CGPathApply ((CGPathRef)ewg_path, (void*)ewg_info, (CGPathApplierFunction)ewg_function);
}

// Return address of function 'CGPathApply'
void* ewg_get_function_address_CGPathApply (void)
{
	return (void*) CGPathApply;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetTypeID'
// For ise
CFTypeID  ewg_function_CGContextGetTypeID (void)
{
	return CGContextGetTypeID ();
}

// Return address of function 'CGContextGetTypeID'
void* ewg_get_function_address_CGContextGetTypeID (void)
{
	return (void*) CGContextGetTypeID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSaveGState'
// For ise
void  ewg_function_CGContextSaveGState (CGContextRef ewg_c)
{
	CGContextSaveGState ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextSaveGState'
void* ewg_get_function_address_CGContextSaveGState (void)
{
	return (void*) CGContextSaveGState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextRestoreGState'
// For ise
void  ewg_function_CGContextRestoreGState (CGContextRef ewg_c)
{
	CGContextRestoreGState ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextRestoreGState'
void* ewg_get_function_address_CGContextRestoreGState (void)
{
	return (void*) CGContextRestoreGState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextScaleCTM'
// For ise
void  ewg_function_CGContextScaleCTM (CGContextRef ewg_c, float ewg_sx, float ewg_sy)
{
	CGContextScaleCTM ((CGContextRef)ewg_c, (float)ewg_sx, (float)ewg_sy);
}

// Return address of function 'CGContextScaleCTM'
void* ewg_get_function_address_CGContextScaleCTM (void)
{
	return (void*) CGContextScaleCTM;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextTranslateCTM'
// For ise
void  ewg_function_CGContextTranslateCTM (CGContextRef ewg_c, float ewg_tx, float ewg_ty)
{
	CGContextTranslateCTM ((CGContextRef)ewg_c, (float)ewg_tx, (float)ewg_ty);
}

// Return address of function 'CGContextTranslateCTM'
void* ewg_get_function_address_CGContextTranslateCTM (void)
{
	return (void*) CGContextTranslateCTM;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextRotateCTM'
// For ise
void  ewg_function_CGContextRotateCTM (CGContextRef ewg_c, float ewg_angle)
{
	CGContextRotateCTM ((CGContextRef)ewg_c, (float)ewg_angle);
}

// Return address of function 'CGContextRotateCTM'
void* ewg_get_function_address_CGContextRotateCTM (void)
{
	return (void*) CGContextRotateCTM;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConcatCTM'
// For ise
void  ewg_function_CGContextConcatCTM (CGContextRef ewg_c, CGAffineTransform *ewg_transform)
{
	CGContextConcatCTM ((CGContextRef)ewg_c, *(CGAffineTransform*)ewg_transform);
}

// Return address of function 'CGContextConcatCTM'
void* ewg_get_function_address_CGContextConcatCTM (void)
{
	return (void*) CGContextConcatCTM;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetCTM'
// For ise
CGAffineTransform * ewg_function_CGContextGetCTM (CGContextRef ewg_c)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGContextGetCTM ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetCTM'
void* ewg_get_function_address_CGContextGetCTM (void)
{
	return (void*) CGContextGetCTM;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetLineWidth'
// For ise
void  ewg_function_CGContextSetLineWidth (CGContextRef ewg_c, float ewg_width)
{
	CGContextSetLineWidth ((CGContextRef)ewg_c, (float)ewg_width);
}

// Return address of function 'CGContextSetLineWidth'
void* ewg_get_function_address_CGContextSetLineWidth (void)
{
	return (void*) CGContextSetLineWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetLineCap'
// For ise
void  ewg_function_CGContextSetLineCap (CGContextRef ewg_c, CGLineCap ewg_cap)
{
	CGContextSetLineCap ((CGContextRef)ewg_c, (CGLineCap)ewg_cap);
}

// Return address of function 'CGContextSetLineCap'
void* ewg_get_function_address_CGContextSetLineCap (void)
{
	return (void*) CGContextSetLineCap;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetLineJoin'
// For ise
void  ewg_function_CGContextSetLineJoin (CGContextRef ewg_c, CGLineJoin ewg_join)
{
	CGContextSetLineJoin ((CGContextRef)ewg_c, (CGLineJoin)ewg_join);
}

// Return address of function 'CGContextSetLineJoin'
void* ewg_get_function_address_CGContextSetLineJoin (void)
{
	return (void*) CGContextSetLineJoin;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetMiterLimit'
// For ise
void  ewg_function_CGContextSetMiterLimit (CGContextRef ewg_c, float ewg_limit)
{
	CGContextSetMiterLimit ((CGContextRef)ewg_c, (float)ewg_limit);
}

// Return address of function 'CGContextSetMiterLimit'
void* ewg_get_function_address_CGContextSetMiterLimit (void)
{
	return (void*) CGContextSetMiterLimit;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetLineDash'
// For ise
void  ewg_function_CGContextSetLineDash (CGContextRef ewg_c, float ewg_phase, void *ewg_lengths, size_t ewg_count)
{
	CGContextSetLineDash ((CGContextRef)ewg_c, (float)ewg_phase, ewg_lengths, (size_t)ewg_count);
}

// Return address of function 'CGContextSetLineDash'
void* ewg_get_function_address_CGContextSetLineDash (void)
{
	return (void*) CGContextSetLineDash;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFlatness'
// For ise
void  ewg_function_CGContextSetFlatness (CGContextRef ewg_c, float ewg_flatness)
{
	CGContextSetFlatness ((CGContextRef)ewg_c, (float)ewg_flatness);
}

// Return address of function 'CGContextSetFlatness'
void* ewg_get_function_address_CGContextSetFlatness (void)
{
	return (void*) CGContextSetFlatness;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetAlpha'
// For ise
void  ewg_function_CGContextSetAlpha (CGContextRef ewg_c, float ewg_alpha)
{
	CGContextSetAlpha ((CGContextRef)ewg_c, (float)ewg_alpha);
}

// Return address of function 'CGContextSetAlpha'
void* ewg_get_function_address_CGContextSetAlpha (void)
{
	return (void*) CGContextSetAlpha;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetBlendMode'
// For ise
void  ewg_function_CGContextSetBlendMode (CGContextRef ewg_context, CGBlendMode ewg_mode)
{
	CGContextSetBlendMode ((CGContextRef)ewg_context, (CGBlendMode)ewg_mode);
}

// Return address of function 'CGContextSetBlendMode'
void* ewg_get_function_address_CGContextSetBlendMode (void)
{
	return (void*) CGContextSetBlendMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextBeginPath'
// For ise
void  ewg_function_CGContextBeginPath (CGContextRef ewg_c)
{
	CGContextBeginPath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextBeginPath'
void* ewg_get_function_address_CGContextBeginPath (void)
{
	return (void*) CGContextBeginPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextMoveToPoint'
// For ise
void  ewg_function_CGContextMoveToPoint (CGContextRef ewg_c, float ewg_x, float ewg_y)
{
	CGContextMoveToPoint ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGContextMoveToPoint'
void* ewg_get_function_address_CGContextMoveToPoint (void)
{
	return (void*) CGContextMoveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddLineToPoint'
// For ise
void  ewg_function_CGContextAddLineToPoint (CGContextRef ewg_c, float ewg_x, float ewg_y)
{
	CGContextAddLineToPoint ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGContextAddLineToPoint'
void* ewg_get_function_address_CGContextAddLineToPoint (void)
{
	return (void*) CGContextAddLineToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddCurveToPoint'
// For ise
void  ewg_function_CGContextAddCurveToPoint (CGContextRef ewg_c, float ewg_cp1x, float ewg_cp1y, float ewg_cp2x, float ewg_cp2y, float ewg_x, float ewg_y)
{
	CGContextAddCurveToPoint ((CGContextRef)ewg_c, (float)ewg_cp1x, (float)ewg_cp1y, (float)ewg_cp2x, (float)ewg_cp2y, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGContextAddCurveToPoint'
void* ewg_get_function_address_CGContextAddCurveToPoint (void)
{
	return (void*) CGContextAddCurveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddQuadCurveToPoint'
// For ise
void  ewg_function_CGContextAddQuadCurveToPoint (CGContextRef ewg_c, float ewg_cpx, float ewg_cpy, float ewg_x, float ewg_y)
{
	CGContextAddQuadCurveToPoint ((CGContextRef)ewg_c, (float)ewg_cpx, (float)ewg_cpy, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGContextAddQuadCurveToPoint'
void* ewg_get_function_address_CGContextAddQuadCurveToPoint (void)
{
	return (void*) CGContextAddQuadCurveToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClosePath'
// For ise
void  ewg_function_CGContextClosePath (CGContextRef ewg_c)
{
	CGContextClosePath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextClosePath'
void* ewg_get_function_address_CGContextClosePath (void)
{
	return (void*) CGContextClosePath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddRect'
// For ise
void  ewg_function_CGContextAddRect (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGContextAddRect ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextAddRect'
void* ewg_get_function_address_CGContextAddRect (void)
{
	return (void*) CGContextAddRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddRects'
// For ise
void  ewg_function_CGContextAddRects (CGContextRef ewg_c, void *ewg_rects, size_t ewg_count)
{
	CGContextAddRects ((CGContextRef)ewg_c, ewg_rects, (size_t)ewg_count);
}

// Return address of function 'CGContextAddRects'
void* ewg_get_function_address_CGContextAddRects (void)
{
	return (void*) CGContextAddRects;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddLines'
// For ise
void  ewg_function_CGContextAddLines (CGContextRef ewg_c, void *ewg_points, size_t ewg_count)
{
	CGContextAddLines ((CGContextRef)ewg_c, ewg_points, (size_t)ewg_count);
}

// Return address of function 'CGContextAddLines'
void* ewg_get_function_address_CGContextAddLines (void)
{
	return (void*) CGContextAddLines;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddEllipseInRect'
// For ise
void  ewg_function_CGContextAddEllipseInRect (CGContextRef ewg_context, CGRect *ewg_rect)
{
	CGContextAddEllipseInRect ((CGContextRef)ewg_context, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextAddEllipseInRect'
void* ewg_get_function_address_CGContextAddEllipseInRect (void)
{
	return (void*) CGContextAddEllipseInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddArc'
// For ise
void  ewg_function_CGContextAddArc (CGContextRef ewg_c, float ewg_x, float ewg_y, float ewg_radius, float ewg_startAngle, float ewg_endAngle, int ewg_clockwise)
{
	CGContextAddArc ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y, (float)ewg_radius, (float)ewg_startAngle, (float)ewg_endAngle, (int)ewg_clockwise);
}

// Return address of function 'CGContextAddArc'
void* ewg_get_function_address_CGContextAddArc (void)
{
	return (void*) CGContextAddArc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddArcToPoint'
// For ise
void  ewg_function_CGContextAddArcToPoint (CGContextRef ewg_c, float ewg_x1, float ewg_y1, float ewg_x2, float ewg_y2, float ewg_radius)
{
	CGContextAddArcToPoint ((CGContextRef)ewg_c, (float)ewg_x1, (float)ewg_y1, (float)ewg_x2, (float)ewg_y2, (float)ewg_radius);
}

// Return address of function 'CGContextAddArcToPoint'
void* ewg_get_function_address_CGContextAddArcToPoint (void)
{
	return (void*) CGContextAddArcToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextAddPath'
// For ise
void  ewg_function_CGContextAddPath (CGContextRef ewg_context, CGPathRef ewg_path)
{
	CGContextAddPath ((CGContextRef)ewg_context, (CGPathRef)ewg_path);
}

// Return address of function 'CGContextAddPath'
void* ewg_get_function_address_CGContextAddPath (void)
{
	return (void*) CGContextAddPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextReplacePathWithStrokedPath'
// For ise
void  ewg_function_CGContextReplacePathWithStrokedPath (CGContextRef ewg_c)
{
	CGContextReplacePathWithStrokedPath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextReplacePathWithStrokedPath'
void* ewg_get_function_address_CGContextReplacePathWithStrokedPath (void)
{
	return (void*) CGContextReplacePathWithStrokedPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextIsPathEmpty'
// For ise
_Bool  ewg_function_CGContextIsPathEmpty (CGContextRef ewg_c)
{
	return CGContextIsPathEmpty ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextIsPathEmpty'
void* ewg_get_function_address_CGContextIsPathEmpty (void)
{
	return (void*) CGContextIsPathEmpty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetPathCurrentPoint'
// For ise
CGPoint * ewg_function_CGContextGetPathCurrentPoint (CGContextRef ewg_c)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGContextGetPathCurrentPoint ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetPathCurrentPoint'
void* ewg_get_function_address_CGContextGetPathCurrentPoint (void)
{
	return (void*) CGContextGetPathCurrentPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetPathBoundingBox'
// For ise
CGRect * ewg_function_CGContextGetPathBoundingBox (CGContextRef ewg_c)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGContextGetPathBoundingBox ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetPathBoundingBox'
void* ewg_get_function_address_CGContextGetPathBoundingBox (void)
{
	return (void*) CGContextGetPathBoundingBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextPathContainsPoint'
// For ise
_Bool  ewg_function_CGContextPathContainsPoint (CGContextRef ewg_context, CGPoint *ewg_point, CGPathDrawingMode ewg_mode)
{
	return CGContextPathContainsPoint ((CGContextRef)ewg_context, *(CGPoint*)ewg_point, (CGPathDrawingMode)ewg_mode);
}

// Return address of function 'CGContextPathContainsPoint'
void* ewg_get_function_address_CGContextPathContainsPoint (void)
{
	return (void*) CGContextPathContainsPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextDrawPath'
// For ise
void  ewg_function_CGContextDrawPath (CGContextRef ewg_c, CGPathDrawingMode ewg_mode)
{
	CGContextDrawPath ((CGContextRef)ewg_c, (CGPathDrawingMode)ewg_mode);
}

// Return address of function 'CGContextDrawPath'
void* ewg_get_function_address_CGContextDrawPath (void)
{
	return (void*) CGContextDrawPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextFillPath'
// For ise
void  ewg_function_CGContextFillPath (CGContextRef ewg_c)
{
	CGContextFillPath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextFillPath'
void* ewg_get_function_address_CGContextFillPath (void)
{
	return (void*) CGContextFillPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextEOFillPath'
// For ise
void  ewg_function_CGContextEOFillPath (CGContextRef ewg_c)
{
	CGContextEOFillPath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextEOFillPath'
void* ewg_get_function_address_CGContextEOFillPath (void)
{
	return (void*) CGContextEOFillPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextStrokePath'
// For ise
void  ewg_function_CGContextStrokePath (CGContextRef ewg_c)
{
	CGContextStrokePath ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextStrokePath'
void* ewg_get_function_address_CGContextStrokePath (void)
{
	return (void*) CGContextStrokePath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextFillRect'
// For ise
void  ewg_function_CGContextFillRect (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGContextFillRect ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextFillRect'
void* ewg_get_function_address_CGContextFillRect (void)
{
	return (void*) CGContextFillRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextFillRects'
// For ise
void  ewg_function_CGContextFillRects (CGContextRef ewg_c, void *ewg_rects, size_t ewg_count)
{
	CGContextFillRects ((CGContextRef)ewg_c, ewg_rects, (size_t)ewg_count);
}

// Return address of function 'CGContextFillRects'
void* ewg_get_function_address_CGContextFillRects (void)
{
	return (void*) CGContextFillRects;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextStrokeRect'
// For ise
void  ewg_function_CGContextStrokeRect (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGContextStrokeRect ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextStrokeRect'
void* ewg_get_function_address_CGContextStrokeRect (void)
{
	return (void*) CGContextStrokeRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextStrokeRectWithWidth'
// For ise
void  ewg_function_CGContextStrokeRectWithWidth (CGContextRef ewg_c, CGRect *ewg_rect, float ewg_width)
{
	CGContextStrokeRectWithWidth ((CGContextRef)ewg_c, *(CGRect*)ewg_rect, (float)ewg_width);
}

// Return address of function 'CGContextStrokeRectWithWidth'
void* ewg_get_function_address_CGContextStrokeRectWithWidth (void)
{
	return (void*) CGContextStrokeRectWithWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClearRect'
// For ise
void  ewg_function_CGContextClearRect (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGContextClearRect ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextClearRect'
void* ewg_get_function_address_CGContextClearRect (void)
{
	return (void*) CGContextClearRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextFillEllipseInRect'
// For ise
void  ewg_function_CGContextFillEllipseInRect (CGContextRef ewg_context, CGRect *ewg_rect)
{
	CGContextFillEllipseInRect ((CGContextRef)ewg_context, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextFillEllipseInRect'
void* ewg_get_function_address_CGContextFillEllipseInRect (void)
{
	return (void*) CGContextFillEllipseInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextStrokeEllipseInRect'
// For ise
void  ewg_function_CGContextStrokeEllipseInRect (CGContextRef ewg_context, CGRect *ewg_rect)
{
	CGContextStrokeEllipseInRect ((CGContextRef)ewg_context, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextStrokeEllipseInRect'
void* ewg_get_function_address_CGContextStrokeEllipseInRect (void)
{
	return (void*) CGContextStrokeEllipseInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextStrokeLineSegments'
// For ise
void  ewg_function_CGContextStrokeLineSegments (CGContextRef ewg_c, void *ewg_points, size_t ewg_count)
{
	CGContextStrokeLineSegments ((CGContextRef)ewg_c, ewg_points, (size_t)ewg_count);
}

// Return address of function 'CGContextStrokeLineSegments'
void* ewg_get_function_address_CGContextStrokeLineSegments (void)
{
	return (void*) CGContextStrokeLineSegments;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClip'
// For ise
void  ewg_function_CGContextClip (CGContextRef ewg_c)
{
	CGContextClip ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextClip'
void* ewg_get_function_address_CGContextClip (void)
{
	return (void*) CGContextClip;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextEOClip'
// For ise
void  ewg_function_CGContextEOClip (CGContextRef ewg_c)
{
	CGContextEOClip ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextEOClip'
void* ewg_get_function_address_CGContextEOClip (void)
{
	return (void*) CGContextEOClip;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClipToMask'
// For ise
void  ewg_function_CGContextClipToMask (CGContextRef ewg_c, CGRect *ewg_rect, CGImageRef ewg_mask)
{
	CGContextClipToMask ((CGContextRef)ewg_c, *(CGRect*)ewg_rect, (CGImageRef)ewg_mask);
}

// Return address of function 'CGContextClipToMask'
void* ewg_get_function_address_CGContextClipToMask (void)
{
	return (void*) CGContextClipToMask;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetClipBoundingBox'
// For ise
CGRect * ewg_function_CGContextGetClipBoundingBox (CGContextRef ewg_c)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGContextGetClipBoundingBox ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetClipBoundingBox'
void* ewg_get_function_address_CGContextGetClipBoundingBox (void)
{
	return (void*) CGContextGetClipBoundingBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClipToRect'
// For ise
void  ewg_function_CGContextClipToRect (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGContextClipToRect ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
}

// Return address of function 'CGContextClipToRect'
void* ewg_get_function_address_CGContextClipToRect (void)
{
	return (void*) CGContextClipToRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextClipToRects'
// For ise
void  ewg_function_CGContextClipToRects (CGContextRef ewg_c, void *ewg_rects, size_t ewg_count)
{
	CGContextClipToRects ((CGContextRef)ewg_c, ewg_rects, (size_t)ewg_count);
}

// Return address of function 'CGContextClipToRects'
void* ewg_get_function_address_CGContextClipToRects (void)
{
	return (void*) CGContextClipToRects;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFillColorWithColor'
// For ise
void  ewg_function_CGContextSetFillColorWithColor (CGContextRef ewg_c, CGColorRef ewg_color)
{
	CGContextSetFillColorWithColor ((CGContextRef)ewg_c, (CGColorRef)ewg_color);
}

// Return address of function 'CGContextSetFillColorWithColor'
void* ewg_get_function_address_CGContextSetFillColorWithColor (void)
{
	return (void*) CGContextSetFillColorWithColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetStrokeColorWithColor'
// For ise
void  ewg_function_CGContextSetStrokeColorWithColor (CGContextRef ewg_c, CGColorRef ewg_color)
{
	CGContextSetStrokeColorWithColor ((CGContextRef)ewg_c, (CGColorRef)ewg_color);
}

// Return address of function 'CGContextSetStrokeColorWithColor'
void* ewg_get_function_address_CGContextSetStrokeColorWithColor (void)
{
	return (void*) CGContextSetStrokeColorWithColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFillColorSpace'
// For ise
void  ewg_function_CGContextSetFillColorSpace (CGContextRef ewg_c, CGColorSpaceRef ewg_colorspace)
{
	CGContextSetFillColorSpace ((CGContextRef)ewg_c, (CGColorSpaceRef)ewg_colorspace);
}

// Return address of function 'CGContextSetFillColorSpace'
void* ewg_get_function_address_CGContextSetFillColorSpace (void)
{
	return (void*) CGContextSetFillColorSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetStrokeColorSpace'
// For ise
void  ewg_function_CGContextSetStrokeColorSpace (CGContextRef ewg_c, CGColorSpaceRef ewg_colorspace)
{
	CGContextSetStrokeColorSpace ((CGContextRef)ewg_c, (CGColorSpaceRef)ewg_colorspace);
}

// Return address of function 'CGContextSetStrokeColorSpace'
void* ewg_get_function_address_CGContextSetStrokeColorSpace (void)
{
	return (void*) CGContextSetStrokeColorSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFillColor'
// For ise
void  ewg_function_CGContextSetFillColor (CGContextRef ewg_c, void *ewg_components)
{
	CGContextSetFillColor ((CGContextRef)ewg_c, ewg_components);
}

// Return address of function 'CGContextSetFillColor'
void* ewg_get_function_address_CGContextSetFillColor (void)
{
	return (void*) CGContextSetFillColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetStrokeColor'
// For ise
void  ewg_function_CGContextSetStrokeColor (CGContextRef ewg_c, void *ewg_components)
{
	CGContextSetStrokeColor ((CGContextRef)ewg_c, ewg_components);
}

// Return address of function 'CGContextSetStrokeColor'
void* ewg_get_function_address_CGContextSetStrokeColor (void)
{
	return (void*) CGContextSetStrokeColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFillPattern'
// For ise
void  ewg_function_CGContextSetFillPattern (CGContextRef ewg_c, CGPatternRef ewg_pattern, void *ewg_components)
{
	CGContextSetFillPattern ((CGContextRef)ewg_c, (CGPatternRef)ewg_pattern, ewg_components);
}

// Return address of function 'CGContextSetFillPattern'
void* ewg_get_function_address_CGContextSetFillPattern (void)
{
	return (void*) CGContextSetFillPattern;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetStrokePattern'
// For ise
void  ewg_function_CGContextSetStrokePattern (CGContextRef ewg_c, CGPatternRef ewg_pattern, void *ewg_components)
{
	CGContextSetStrokePattern ((CGContextRef)ewg_c, (CGPatternRef)ewg_pattern, ewg_components);
}

// Return address of function 'CGContextSetStrokePattern'
void* ewg_get_function_address_CGContextSetStrokePattern (void)
{
	return (void*) CGContextSetStrokePattern;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetPatternPhase'
// For ise
void  ewg_function_CGContextSetPatternPhase (CGContextRef ewg_c, CGSize *ewg_phase)
{
	CGContextSetPatternPhase ((CGContextRef)ewg_c, *(CGSize*)ewg_phase);
}

// Return address of function 'CGContextSetPatternPhase'
void* ewg_get_function_address_CGContextSetPatternPhase (void)
{
	return (void*) CGContextSetPatternPhase;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetGrayFillColor'
// For ise
void  ewg_function_CGContextSetGrayFillColor (CGContextRef ewg_c, float ewg_gray, float ewg_alpha)
{
	CGContextSetGrayFillColor ((CGContextRef)ewg_c, (float)ewg_gray, (float)ewg_alpha);
}

// Return address of function 'CGContextSetGrayFillColor'
void* ewg_get_function_address_CGContextSetGrayFillColor (void)
{
	return (void*) CGContextSetGrayFillColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetGrayStrokeColor'
// For ise
void  ewg_function_CGContextSetGrayStrokeColor (CGContextRef ewg_c, float ewg_gray, float ewg_alpha)
{
	CGContextSetGrayStrokeColor ((CGContextRef)ewg_c, (float)ewg_gray, (float)ewg_alpha);
}

// Return address of function 'CGContextSetGrayStrokeColor'
void* ewg_get_function_address_CGContextSetGrayStrokeColor (void)
{
	return (void*) CGContextSetGrayStrokeColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetRGBFillColor'
// For ise
void  ewg_function_CGContextSetRGBFillColor (CGContextRef ewg_c, float ewg_red, float ewg_green, float ewg_blue, float ewg_alpha)
{
	CGContextSetRGBFillColor ((CGContextRef)ewg_c, (float)ewg_red, (float)ewg_green, (float)ewg_blue, (float)ewg_alpha);
}

// Return address of function 'CGContextSetRGBFillColor'
void* ewg_get_function_address_CGContextSetRGBFillColor (void)
{
	return (void*) CGContextSetRGBFillColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetRGBStrokeColor'
// For ise
void  ewg_function_CGContextSetRGBStrokeColor (CGContextRef ewg_c, float ewg_red, float ewg_green, float ewg_blue, float ewg_alpha)
{
	CGContextSetRGBStrokeColor ((CGContextRef)ewg_c, (float)ewg_red, (float)ewg_green, (float)ewg_blue, (float)ewg_alpha);
}

// Return address of function 'CGContextSetRGBStrokeColor'
void* ewg_get_function_address_CGContextSetRGBStrokeColor (void)
{
	return (void*) CGContextSetRGBStrokeColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetCMYKFillColor'
// For ise
void  ewg_function_CGContextSetCMYKFillColor (CGContextRef ewg_c, float ewg_cyan, float ewg_magenta, float ewg_yellow, float ewg_black, float ewg_alpha)
{
	CGContextSetCMYKFillColor ((CGContextRef)ewg_c, (float)ewg_cyan, (float)ewg_magenta, (float)ewg_yellow, (float)ewg_black, (float)ewg_alpha);
}

// Return address of function 'CGContextSetCMYKFillColor'
void* ewg_get_function_address_CGContextSetCMYKFillColor (void)
{
	return (void*) CGContextSetCMYKFillColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetCMYKStrokeColor'
// For ise
void  ewg_function_CGContextSetCMYKStrokeColor (CGContextRef ewg_c, float ewg_cyan, float ewg_magenta, float ewg_yellow, float ewg_black, float ewg_alpha)
{
	CGContextSetCMYKStrokeColor ((CGContextRef)ewg_c, (float)ewg_cyan, (float)ewg_magenta, (float)ewg_yellow, (float)ewg_black, (float)ewg_alpha);
}

// Return address of function 'CGContextSetCMYKStrokeColor'
void* ewg_get_function_address_CGContextSetCMYKStrokeColor (void)
{
	return (void*) CGContextSetCMYKStrokeColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetRenderingIntent'
// For ise
void  ewg_function_CGContextSetRenderingIntent (CGContextRef ewg_c, CGColorRenderingIntent ewg_intent)
{
	CGContextSetRenderingIntent ((CGContextRef)ewg_c, (CGColorRenderingIntent)ewg_intent);
}

// Return address of function 'CGContextSetRenderingIntent'
void* ewg_get_function_address_CGContextSetRenderingIntent (void)
{
	return (void*) CGContextSetRenderingIntent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextDrawImage'
// For ise
void  ewg_function_CGContextDrawImage (CGContextRef ewg_c, CGRect *ewg_rect, CGImageRef ewg_image)
{
	CGContextDrawImage ((CGContextRef)ewg_c, *(CGRect*)ewg_rect, (CGImageRef)ewg_image);
}

// Return address of function 'CGContextDrawImage'
void* ewg_get_function_address_CGContextDrawImage (void)
{
	return (void*) CGContextDrawImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetInterpolationQuality'
// For ise
CGInterpolationQuality  ewg_function_CGContextGetInterpolationQuality (CGContextRef ewg_c)
{
	return CGContextGetInterpolationQuality ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextGetInterpolationQuality'
void* ewg_get_function_address_CGContextGetInterpolationQuality (void)
{
	return (void*) CGContextGetInterpolationQuality;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetInterpolationQuality'
// For ise
void  ewg_function_CGContextSetInterpolationQuality (CGContextRef ewg_c, CGInterpolationQuality ewg_quality)
{
	CGContextSetInterpolationQuality ((CGContextRef)ewg_c, (CGInterpolationQuality)ewg_quality);
}

// Return address of function 'CGContextSetInterpolationQuality'
void* ewg_get_function_address_CGContextSetInterpolationQuality (void)
{
	return (void*) CGContextSetInterpolationQuality;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetShadowWithColor'
// For ise
void  ewg_function_CGContextSetShadowWithColor (CGContextRef ewg_context, CGSize *ewg_offset, float ewg_blur, CGColorRef ewg_color)
{
	CGContextSetShadowWithColor ((CGContextRef)ewg_context, *(CGSize*)ewg_offset, (float)ewg_blur, (CGColorRef)ewg_color);
}

// Return address of function 'CGContextSetShadowWithColor'
void* ewg_get_function_address_CGContextSetShadowWithColor (void)
{
	return (void*) CGContextSetShadowWithColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetShadow'
// For ise
void  ewg_function_CGContextSetShadow (CGContextRef ewg_context, CGSize *ewg_offset, float ewg_blur)
{
	CGContextSetShadow ((CGContextRef)ewg_context, *(CGSize*)ewg_offset, (float)ewg_blur);
}

// Return address of function 'CGContextSetShadow'
void* ewg_get_function_address_CGContextSetShadow (void)
{
	return (void*) CGContextSetShadow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextDrawShading'
// For ise
void  ewg_function_CGContextDrawShading (CGContextRef ewg_c, CGShadingRef ewg_shading)
{
	CGContextDrawShading ((CGContextRef)ewg_c, (CGShadingRef)ewg_shading);
}

// Return address of function 'CGContextDrawShading'
void* ewg_get_function_address_CGContextDrawShading (void)
{
	return (void*) CGContextDrawShading;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetCharacterSpacing'
// For ise
void  ewg_function_CGContextSetCharacterSpacing (CGContextRef ewg_c, float ewg_spacing)
{
	CGContextSetCharacterSpacing ((CGContextRef)ewg_c, (float)ewg_spacing);
}

// Return address of function 'CGContextSetCharacterSpacing'
void* ewg_get_function_address_CGContextSetCharacterSpacing (void)
{
	return (void*) CGContextSetCharacterSpacing;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetTextPosition'
// For ise
void  ewg_function_CGContextSetTextPosition (CGContextRef ewg_c, float ewg_x, float ewg_y)
{
	CGContextSetTextPosition ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y);
}

// Return address of function 'CGContextSetTextPosition'
void* ewg_get_function_address_CGContextSetTextPosition (void)
{
	return (void*) CGContextSetTextPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetTextPosition'
// For ise
CGPoint * ewg_function_CGContextGetTextPosition (CGContextRef ewg_c)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGContextGetTextPosition ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetTextPosition'
void* ewg_get_function_address_CGContextGetTextPosition (void)
{
	return (void*) CGContextGetTextPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetTextMatrix'
// For ise
void  ewg_function_CGContextSetTextMatrix (CGContextRef ewg_c, CGAffineTransform *ewg_t)
{
	CGContextSetTextMatrix ((CGContextRef)ewg_c, *(CGAffineTransform*)ewg_t);
}

// Return address of function 'CGContextSetTextMatrix'
void* ewg_get_function_address_CGContextSetTextMatrix (void)
{
	return (void*) CGContextSetTextMatrix;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetTextMatrix'
// For ise
CGAffineTransform * ewg_function_CGContextGetTextMatrix (CGContextRef ewg_c)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGContextGetTextMatrix ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetTextMatrix'
void* ewg_get_function_address_CGContextGetTextMatrix (void)
{
	return (void*) CGContextGetTextMatrix;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetTextDrawingMode'
// For ise
void  ewg_function_CGContextSetTextDrawingMode (CGContextRef ewg_c, CGTextDrawingMode ewg_mode)
{
	CGContextSetTextDrawingMode ((CGContextRef)ewg_c, (CGTextDrawingMode)ewg_mode);
}

// Return address of function 'CGContextSetTextDrawingMode'
void* ewg_get_function_address_CGContextSetTextDrawingMode (void)
{
	return (void*) CGContextSetTextDrawingMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFont'
// For ise
void  ewg_function_CGContextSetFont (CGContextRef ewg_c, CGFontRef ewg_font)
{
	CGContextSetFont ((CGContextRef)ewg_c, (CGFontRef)ewg_font);
}

// Return address of function 'CGContextSetFont'
void* ewg_get_function_address_CGContextSetFont (void)
{
	return (void*) CGContextSetFont;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetFontSize'
// For ise
void  ewg_function_CGContextSetFontSize (CGContextRef ewg_c, float ewg_size)
{
	CGContextSetFontSize ((CGContextRef)ewg_c, (float)ewg_size);
}

// Return address of function 'CGContextSetFontSize'
void* ewg_get_function_address_CGContextSetFontSize (void)
{
	return (void*) CGContextSetFontSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSelectFont'
// For ise
void  ewg_function_CGContextSelectFont (CGContextRef ewg_c, char const *ewg_name, float ewg_size, CGTextEncoding ewg_textEncoding)
{
	CGContextSelectFont ((CGContextRef)ewg_c, (char const*)ewg_name, (float)ewg_size, (CGTextEncoding)ewg_textEncoding);
}

// Return address of function 'CGContextSelectFont'
void* ewg_get_function_address_CGContextSelectFont (void)
{
	return (void*) CGContextSelectFont;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextShowText'
// For ise
void  ewg_function_CGContextShowText (CGContextRef ewg_c, char const *ewg_string, size_t ewg_length)
{
	CGContextShowText ((CGContextRef)ewg_c, (char const*)ewg_string, (size_t)ewg_length);
}

// Return address of function 'CGContextShowText'
void* ewg_get_function_address_CGContextShowText (void)
{
	return (void*) CGContextShowText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextShowGlyphs'
// For ise
void  ewg_function_CGContextShowGlyphs (CGContextRef ewg_c, void *ewg_g, size_t ewg_count)
{
	CGContextShowGlyphs ((CGContextRef)ewg_c, ewg_g, (size_t)ewg_count);
}

// Return address of function 'CGContextShowGlyphs'
void* ewg_get_function_address_CGContextShowGlyphs (void)
{
	return (void*) CGContextShowGlyphs;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextShowGlyphsWithAdvances'
// For ise
void  ewg_function_CGContextShowGlyphsWithAdvances (CGContextRef ewg_c, void *ewg_glyphs, void *ewg_advances, size_t ewg_count)
{
	CGContextShowGlyphsWithAdvances ((CGContextRef)ewg_c, ewg_glyphs, ewg_advances, (size_t)ewg_count);
}

// Return address of function 'CGContextShowGlyphsWithAdvances'
void* ewg_get_function_address_CGContextShowGlyphsWithAdvances (void)
{
	return (void*) CGContextShowGlyphsWithAdvances;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextShowTextAtPoint'
// For ise
void  ewg_function_CGContextShowTextAtPoint (CGContextRef ewg_c, float ewg_x, float ewg_y, char const *ewg_string, size_t ewg_length)
{
	CGContextShowTextAtPoint ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y, (char const*)ewg_string, (size_t)ewg_length);
}

// Return address of function 'CGContextShowTextAtPoint'
void* ewg_get_function_address_CGContextShowTextAtPoint (void)
{
	return (void*) CGContextShowTextAtPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextShowGlyphsAtPoint'
// For ise
void  ewg_function_CGContextShowGlyphsAtPoint (CGContextRef ewg_c, float ewg_x, float ewg_y, void *ewg_glyphs, size_t ewg_count)
{
	CGContextShowGlyphsAtPoint ((CGContextRef)ewg_c, (float)ewg_x, (float)ewg_y, ewg_glyphs, (size_t)ewg_count);
}

// Return address of function 'CGContextShowGlyphsAtPoint'
void* ewg_get_function_address_CGContextShowGlyphsAtPoint (void)
{
	return (void*) CGContextShowGlyphsAtPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextDrawPDFPage'
// For ise
void  ewg_function_CGContextDrawPDFPage (CGContextRef ewg_c, CGPDFPageRef ewg_page)
{
	CGContextDrawPDFPage ((CGContextRef)ewg_c, (CGPDFPageRef)ewg_page);
}

// Return address of function 'CGContextDrawPDFPage'
void* ewg_get_function_address_CGContextDrawPDFPage (void)
{
	return (void*) CGContextDrawPDFPage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextDrawPDFDocument'
// For ise
void  ewg_function_CGContextDrawPDFDocument (CGContextRef ewg_c, CGRect *ewg_rect, CGPDFDocumentRef ewg_document, int ewg_page)
{
	CGContextDrawPDFDocument ((CGContextRef)ewg_c, *(CGRect*)ewg_rect, (CGPDFDocumentRef)ewg_document, (int)ewg_page);
}

// Return address of function 'CGContextDrawPDFDocument'
void* ewg_get_function_address_CGContextDrawPDFDocument (void)
{
	return (void*) CGContextDrawPDFDocument;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextBeginPage'
// For ise
void  ewg_function_CGContextBeginPage (CGContextRef ewg_c, CGRect const *ewg_mediaBox)
{
	CGContextBeginPage ((CGContextRef)ewg_c, (CGRect const*)ewg_mediaBox);
}

// Return address of function 'CGContextBeginPage'
void* ewg_get_function_address_CGContextBeginPage (void)
{
	return (void*) CGContextBeginPage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextEndPage'
// For ise
void  ewg_function_CGContextEndPage (CGContextRef ewg_c)
{
	CGContextEndPage ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextEndPage'
void* ewg_get_function_address_CGContextEndPage (void)
{
	return (void*) CGContextEndPage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextRetain'
// For ise
CGContextRef  ewg_function_CGContextRetain (CGContextRef ewg_c)
{
	return CGContextRetain ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextRetain'
void* ewg_get_function_address_CGContextRetain (void)
{
	return (void*) CGContextRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextRelease'
// For ise
void  ewg_function_CGContextRelease (CGContextRef ewg_c)
{
	CGContextRelease ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextRelease'
void* ewg_get_function_address_CGContextRelease (void)
{
	return (void*) CGContextRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextFlush'
// For ise
void  ewg_function_CGContextFlush (CGContextRef ewg_c)
{
	CGContextFlush ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextFlush'
void* ewg_get_function_address_CGContextFlush (void)
{
	return (void*) CGContextFlush;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSynchronize'
// For ise
void  ewg_function_CGContextSynchronize (CGContextRef ewg_c)
{
	CGContextSynchronize ((CGContextRef)ewg_c);
}

// Return address of function 'CGContextSynchronize'
void* ewg_get_function_address_CGContextSynchronize (void)
{
	return (void*) CGContextSynchronize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetShouldAntialias'
// For ise
void  ewg_function_CGContextSetShouldAntialias (CGContextRef ewg_c, _Bool ewg_shouldAntialias)
{
	CGContextSetShouldAntialias ((CGContextRef)ewg_c, (_Bool)ewg_shouldAntialias);
}

// Return address of function 'CGContextSetShouldAntialias'
void* ewg_get_function_address_CGContextSetShouldAntialias (void)
{
	return (void*) CGContextSetShouldAntialias;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetAllowsAntialiasing'
// For ise
void  ewg_function_CGContextSetAllowsAntialiasing (CGContextRef ewg_context, _Bool ewg_allowsAntialiasing)
{
	CGContextSetAllowsAntialiasing ((CGContextRef)ewg_context, (_Bool)ewg_allowsAntialiasing);
}

// Return address of function 'CGContextSetAllowsAntialiasing'
void* ewg_get_function_address_CGContextSetAllowsAntialiasing (void)
{
	return (void*) CGContextSetAllowsAntialiasing;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextSetShouldSmoothFonts'
// For ise
void  ewg_function_CGContextSetShouldSmoothFonts (CGContextRef ewg_c, _Bool ewg_shouldSmoothFonts)
{
	CGContextSetShouldSmoothFonts ((CGContextRef)ewg_c, (_Bool)ewg_shouldSmoothFonts);
}

// Return address of function 'CGContextSetShouldSmoothFonts'
void* ewg_get_function_address_CGContextSetShouldSmoothFonts (void)
{
	return (void*) CGContextSetShouldSmoothFonts;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextBeginTransparencyLayer'
// For ise
void  ewg_function_CGContextBeginTransparencyLayer (CGContextRef ewg_context, CFDictionaryRef ewg_auxiliaryInfo)
{
	CGContextBeginTransparencyLayer ((CGContextRef)ewg_context, (CFDictionaryRef)ewg_auxiliaryInfo);
}

// Return address of function 'CGContextBeginTransparencyLayer'
void* ewg_get_function_address_CGContextBeginTransparencyLayer (void)
{
	return (void*) CGContextBeginTransparencyLayer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextEndTransparencyLayer'
// For ise
void  ewg_function_CGContextEndTransparencyLayer (CGContextRef ewg_context)
{
	CGContextEndTransparencyLayer ((CGContextRef)ewg_context);
}

// Return address of function 'CGContextEndTransparencyLayer'
void* ewg_get_function_address_CGContextEndTransparencyLayer (void)
{
	return (void*) CGContextEndTransparencyLayer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextGetUserSpaceToDeviceSpaceTransform'
// For ise
CGAffineTransform * ewg_function_CGContextGetUserSpaceToDeviceSpaceTransform (CGContextRef ewg_c)
{
	CGAffineTransform *result = (CGAffineTransform*) malloc (sizeof(CGAffineTransform));
	*result = CGContextGetUserSpaceToDeviceSpaceTransform ((CGContextRef)ewg_c);
	return result;
}

// Return address of function 'CGContextGetUserSpaceToDeviceSpaceTransform'
void* ewg_get_function_address_CGContextGetUserSpaceToDeviceSpaceTransform (void)
{
	return (void*) CGContextGetUserSpaceToDeviceSpaceTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertPointToDeviceSpace'
// For ise
CGPoint * ewg_function_CGContextConvertPointToDeviceSpace (CGContextRef ewg_c, CGPoint *ewg_point)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGContextConvertPointToDeviceSpace ((CGContextRef)ewg_c, *(CGPoint*)ewg_point);
	return result;
}

// Return address of function 'CGContextConvertPointToDeviceSpace'
void* ewg_get_function_address_CGContextConvertPointToDeviceSpace (void)
{
	return (void*) CGContextConvertPointToDeviceSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertPointToUserSpace'
// For ise
CGPoint * ewg_function_CGContextConvertPointToUserSpace (CGContextRef ewg_c, CGPoint *ewg_point)
{
	CGPoint *result = (CGPoint*) malloc (sizeof(CGPoint));
	*result = CGContextConvertPointToUserSpace ((CGContextRef)ewg_c, *(CGPoint*)ewg_point);
	return result;
}

// Return address of function 'CGContextConvertPointToUserSpace'
void* ewg_get_function_address_CGContextConvertPointToUserSpace (void)
{
	return (void*) CGContextConvertPointToUserSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertSizeToDeviceSpace'
// For ise
CGSize * ewg_function_CGContextConvertSizeToDeviceSpace (CGContextRef ewg_c, CGSize *ewg_size)
{
	CGSize *result = (CGSize*) malloc (sizeof(CGSize));
	*result = CGContextConvertSizeToDeviceSpace ((CGContextRef)ewg_c, *(CGSize*)ewg_size);
	return result;
}

// Return address of function 'CGContextConvertSizeToDeviceSpace'
void* ewg_get_function_address_CGContextConvertSizeToDeviceSpace (void)
{
	return (void*) CGContextConvertSizeToDeviceSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertSizeToUserSpace'
// For ise
CGSize * ewg_function_CGContextConvertSizeToUserSpace (CGContextRef ewg_c, CGSize *ewg_size)
{
	CGSize *result = (CGSize*) malloc (sizeof(CGSize));
	*result = CGContextConvertSizeToUserSpace ((CGContextRef)ewg_c, *(CGSize*)ewg_size);
	return result;
}

// Return address of function 'CGContextConvertSizeToUserSpace'
void* ewg_get_function_address_CGContextConvertSizeToUserSpace (void)
{
	return (void*) CGContextConvertSizeToUserSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertRectToDeviceSpace'
// For ise
CGRect * ewg_function_CGContextConvertRectToDeviceSpace (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGContextConvertRectToDeviceSpace ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
	return result;
}

// Return address of function 'CGContextConvertRectToDeviceSpace'
void* ewg_get_function_address_CGContextConvertRectToDeviceSpace (void)
{
	return (void*) CGContextConvertRectToDeviceSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CGContextConvertRectToUserSpace'
// For ise
CGRect * ewg_function_CGContextConvertRectToUserSpace (CGContextRef ewg_c, CGRect *ewg_rect)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = CGContextConvertRectToUserSpace ((CGContextRef)ewg_c, *(CGRect*)ewg_rect);
	return result;
}

// Return address of function 'CGContextConvertRectToUserSpace'
void* ewg_get_function_address_CGContextConvertRectToUserSpace (void)
{
	return (void*) CGContextConvertRectToUserSpace;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewAECoerceDescUPP'
// For ise
AECoerceDescUPP  ewg_function_NewAECoerceDescUPP (AECoerceDescProcPtr ewg_userRoutine)
{
	return NewAECoerceDescUPP ((AECoerceDescProcPtr)ewg_userRoutine);
}

// Return address of function 'NewAECoerceDescUPP'
void* ewg_get_function_address_NewAECoerceDescUPP (void)
{
	return (void*) NewAECoerceDescUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewAECoercePtrUPP'
// For ise
AECoercePtrUPP  ewg_function_NewAECoercePtrUPP (AECoercePtrProcPtr ewg_userRoutine)
{
	return NewAECoercePtrUPP ((AECoercePtrProcPtr)ewg_userRoutine);
}

// Return address of function 'NewAECoercePtrUPP'
void* ewg_get_function_address_NewAECoercePtrUPP (void)
{
	return (void*) NewAECoercePtrUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeAECoerceDescUPP'
// For ise
void  ewg_function_DisposeAECoerceDescUPP (AECoerceDescUPP ewg_userUPP)
{
	DisposeAECoerceDescUPP ((AECoerceDescUPP)ewg_userUPP);
}

// Return address of function 'DisposeAECoerceDescUPP'
void* ewg_get_function_address_DisposeAECoerceDescUPP (void)
{
	return (void*) DisposeAECoerceDescUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeAECoercePtrUPP'
// For ise
void  ewg_function_DisposeAECoercePtrUPP (AECoercePtrUPP ewg_userUPP)
{
	DisposeAECoercePtrUPP ((AECoercePtrUPP)ewg_userUPP);
}

// Return address of function 'DisposeAECoercePtrUPP'
void* ewg_get_function_address_DisposeAECoercePtrUPP (void)
{
	return (void*) DisposeAECoercePtrUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeAECoerceDescUPP'
// For ise
OSErr  ewg_function_InvokeAECoerceDescUPP (AEDesc const *ewg_fromDesc, DescType ewg_toType, long ewg_handlerRefcon, AEDesc *ewg_toDesc, AECoerceDescUPP ewg_userUPP)
{
	return InvokeAECoerceDescUPP ((AEDesc const*)ewg_fromDesc, (DescType)ewg_toType, (long)ewg_handlerRefcon, (AEDesc*)ewg_toDesc, (AECoerceDescUPP)ewg_userUPP);
}

// Return address of function 'InvokeAECoerceDescUPP'
void* ewg_get_function_address_InvokeAECoerceDescUPP (void)
{
	return (void*) InvokeAECoerceDescUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeAECoercePtrUPP'
// For ise
OSErr  ewg_function_InvokeAECoercePtrUPP (DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize, DescType ewg_toType, long ewg_handlerRefcon, AEDesc *ewg_result, AECoercePtrUPP ewg_userUPP)
{
	return InvokeAECoercePtrUPP ((DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize, (DescType)ewg_toType, (long)ewg_handlerRefcon, (AEDesc*)ewg_result, (AECoercePtrUPP)ewg_userUPP);
}

// Return address of function 'InvokeAECoercePtrUPP'
void* ewg_get_function_address_InvokeAECoercePtrUPP (void)
{
	return (void*) InvokeAECoercePtrUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEInstallCoercionHandler'
// For ise
OSErr  ewg_function_AEInstallCoercionHandler (DescType ewg_fromType, DescType ewg_toType, AECoercionHandlerUPP ewg_handler, long ewg_handlerRefcon, Boolean ewg_fromTypeIsDesc, Boolean ewg_isSysHandler)
{
	return AEInstallCoercionHandler ((DescType)ewg_fromType, (DescType)ewg_toType, (AECoercionHandlerUPP)ewg_handler, (long)ewg_handlerRefcon, (Boolean)ewg_fromTypeIsDesc, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEInstallCoercionHandler'
void* ewg_get_function_address_AEInstallCoercionHandler (void)
{
	return (void*) AEInstallCoercionHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AERemoveCoercionHandler'
// For ise
OSErr  ewg_function_AERemoveCoercionHandler (DescType ewg_fromType, DescType ewg_toType, AECoercionHandlerUPP ewg_handler, Boolean ewg_isSysHandler)
{
	return AERemoveCoercionHandler ((DescType)ewg_fromType, (DescType)ewg_toType, (AECoercionHandlerUPP)ewg_handler, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AERemoveCoercionHandler'
void* ewg_get_function_address_AERemoveCoercionHandler (void)
{
	return (void*) AERemoveCoercionHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetCoercionHandler'
// For ise
OSErr  ewg_function_AEGetCoercionHandler (DescType ewg_fromType, DescType ewg_toType, AECoercionHandlerUPP *ewg_handler, long *ewg_handlerRefcon, Boolean *ewg_fromTypeIsDesc, Boolean ewg_isSysHandler)
{
	return AEGetCoercionHandler ((DescType)ewg_fromType, (DescType)ewg_toType, (AECoercionHandlerUPP*)ewg_handler, (long*)ewg_handlerRefcon, (Boolean*)ewg_fromTypeIsDesc, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEGetCoercionHandler'
void* ewg_get_function_address_AEGetCoercionHandler (void)
{
	return (void*) AEGetCoercionHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECoercePtr'
// For ise
OSErr  ewg_function_AECoercePtr (DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize, DescType ewg_toType, AEDesc *ewg_result)
{
	return AECoercePtr ((DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize, (DescType)ewg_toType, (AEDesc*)ewg_result);
}

// Return address of function 'AECoercePtr'
void* ewg_get_function_address_AECoercePtr (void)
{
	return (void*) AECoercePtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECoerceDesc'
// For ise
OSErr  ewg_function_AECoerceDesc (AEDesc const *ewg_theAEDesc, DescType ewg_toType, AEDesc *ewg_result)
{
	return AECoerceDesc ((AEDesc const*)ewg_theAEDesc, (DescType)ewg_toType, (AEDesc*)ewg_result);
}

// Return address of function 'AECoerceDesc'
void* ewg_get_function_address_AECoerceDesc (void)
{
	return (void*) AECoerceDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEInitializeDesc'
// For ise
void  ewg_function_AEInitializeDesc (AEDesc *ewg_desc)
{
	AEInitializeDesc ((AEDesc*)ewg_desc);
}

// Return address of function 'AEInitializeDesc'
void* ewg_get_function_address_AEInitializeDesc (void)
{
	return (void*) AEInitializeDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECreateDesc'
// For ise
OSErr  ewg_function_AECreateDesc (DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize, AEDesc *ewg_result)
{
	return AECreateDesc ((DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize, (AEDesc*)ewg_result);
}

// Return address of function 'AECreateDesc'
void* ewg_get_function_address_AECreateDesc (void)
{
	return (void*) AECreateDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEDisposeDesc'
// For ise
OSErr  ewg_function_AEDisposeDesc (AEDesc *ewg_theAEDesc)
{
	return AEDisposeDesc ((AEDesc*)ewg_theAEDesc);
}

// Return address of function 'AEDisposeDesc'
void* ewg_get_function_address_AEDisposeDesc (void)
{
	return (void*) AEDisposeDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEDuplicateDesc'
// For ise
OSErr  ewg_function_AEDuplicateDesc (AEDesc const *ewg_theAEDesc, AEDesc *ewg_result)
{
	return AEDuplicateDesc ((AEDesc const*)ewg_theAEDesc, (AEDesc*)ewg_result);
}

// Return address of function 'AEDuplicateDesc'
void* ewg_get_function_address_AEDuplicateDesc (void)
{
	return (void*) AEDuplicateDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECreateDescFromExternalPtr'
// For ise
OSStatus  ewg_function_AECreateDescFromExternalPtr (OSType ewg_descriptorType, void const *ewg_dataPtr, Size ewg_dataLength, AEDisposeExternalUPP ewg_disposeCallback, long ewg_disposeRefcon, AEDesc *ewg_theDesc)
{
	return AECreateDescFromExternalPtr ((OSType)ewg_descriptorType, (void const*)ewg_dataPtr, (Size)ewg_dataLength, (AEDisposeExternalUPP)ewg_disposeCallback, (long)ewg_disposeRefcon, (AEDesc*)ewg_theDesc);
}

// Return address of function 'AECreateDescFromExternalPtr'
void* ewg_get_function_address_AECreateDescFromExternalPtr (void)
{
	return (void*) AECreateDescFromExternalPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECreateList'
// For ise
OSErr  ewg_function_AECreateList (void const *ewg_factoringPtr, Size ewg_factoredSize, Boolean ewg_isRecord, AEDescList *ewg_resultList)
{
	return AECreateList ((void const*)ewg_factoringPtr, (Size)ewg_factoredSize, (Boolean)ewg_isRecord, (AEDescList*)ewg_resultList);
}

// Return address of function 'AECreateList'
void* ewg_get_function_address_AECreateList (void)
{
	return (void*) AECreateList;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECountItems'
// For ise
OSErr  ewg_function_AECountItems (AEDescList const *ewg_theAEDescList, long *ewg_theCount)
{
	return AECountItems ((AEDescList const*)ewg_theAEDescList, (long*)ewg_theCount);
}

// Return address of function 'AECountItems'
void* ewg_get_function_address_AECountItems (void)
{
	return (void*) AECountItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutPtr'
// For ise
OSErr  ewg_function_AEPutPtr (AEDescList *ewg_theAEDescList, long ewg_index, DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize)
{
	return AEPutPtr ((AEDescList*)ewg_theAEDescList, (long)ewg_index, (DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize);
}

// Return address of function 'AEPutPtr'
void* ewg_get_function_address_AEPutPtr (void)
{
	return (void*) AEPutPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutDesc'
// For ise
OSErr  ewg_function_AEPutDesc (AEDescList *ewg_theAEDescList, long ewg_index, AEDesc const *ewg_theAEDesc)
{
	return AEPutDesc ((AEDescList*)ewg_theAEDescList, (long)ewg_index, (AEDesc const*)ewg_theAEDesc);
}

// Return address of function 'AEPutDesc'
void* ewg_get_function_address_AEPutDesc (void)
{
	return (void*) AEPutDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetNthPtr'
// For ise
OSErr  ewg_function_AEGetNthPtr (AEDescList const *ewg_theAEDescList, long ewg_index, DescType ewg_desiredType, AEKeyword *ewg_theAEKeyword, DescType *ewg_typeCode, void *ewg_dataPtr, Size ewg_maximumSize, Size *ewg_actualSize)
{
	return AEGetNthPtr ((AEDescList const*)ewg_theAEDescList, (long)ewg_index, (DescType)ewg_desiredType, (AEKeyword*)ewg_theAEKeyword, (DescType*)ewg_typeCode, (void*)ewg_dataPtr, (Size)ewg_maximumSize, (Size*)ewg_actualSize);
}

// Return address of function 'AEGetNthPtr'
void* ewg_get_function_address_AEGetNthPtr (void)
{
	return (void*) AEGetNthPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetNthDesc'
// For ise
OSErr  ewg_function_AEGetNthDesc (AEDescList const *ewg_theAEDescList, long ewg_index, DescType ewg_desiredType, AEKeyword *ewg_theAEKeyword, AEDesc *ewg_result)
{
	return AEGetNthDesc ((AEDescList const*)ewg_theAEDescList, (long)ewg_index, (DescType)ewg_desiredType, (AEKeyword*)ewg_theAEKeyword, (AEDesc*)ewg_result);
}

// Return address of function 'AEGetNthDesc'
void* ewg_get_function_address_AEGetNthDesc (void)
{
	return (void*) AEGetNthDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AESizeOfNthItem'
// For ise
OSErr  ewg_function_AESizeOfNthItem (AEDescList const *ewg_theAEDescList, long ewg_index, DescType *ewg_typeCode, Size *ewg_dataSize)
{
	return AESizeOfNthItem ((AEDescList const*)ewg_theAEDescList, (long)ewg_index, (DescType*)ewg_typeCode, (Size*)ewg_dataSize);
}

// Return address of function 'AESizeOfNthItem'
void* ewg_get_function_address_AESizeOfNthItem (void)
{
	return (void*) AESizeOfNthItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetArray'
// For ise
OSErr  ewg_function_AEGetArray (AEDescList const *ewg_theAEDescList, AEArrayType ewg_arrayType, AEArrayDataPointer ewg_arrayPtr, Size ewg_maximumSize, DescType *ewg_itemType, Size *ewg_itemSize, long *ewg_itemCount)
{
	return AEGetArray ((AEDescList const*)ewg_theAEDescList, (AEArrayType)ewg_arrayType, (AEArrayDataPointer)ewg_arrayPtr, (Size)ewg_maximumSize, (DescType*)ewg_itemType, (Size*)ewg_itemSize, (long*)ewg_itemCount);
}

// Return address of function 'AEGetArray'
void* ewg_get_function_address_AEGetArray (void)
{
	return (void*) AEGetArray;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutArray'
// For ise
OSErr  ewg_function_AEPutArray (AEDescList *ewg_theAEDescList, AEArrayType ewg_arrayType, AEArrayData const *ewg_arrayPtr, DescType ewg_itemType, Size ewg_itemSize, long ewg_itemCount)
{
	return AEPutArray ((AEDescList*)ewg_theAEDescList, (AEArrayType)ewg_arrayType, (AEArrayData const*)ewg_arrayPtr, (DescType)ewg_itemType, (Size)ewg_itemSize, (long)ewg_itemCount);
}

// Return address of function 'AEPutArray'
void* ewg_get_function_address_AEPutArray (void)
{
	return (void*) AEPutArray;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEDeleteItem'
// For ise
OSErr  ewg_function_AEDeleteItem (AEDescList *ewg_theAEDescList, long ewg_index)
{
	return AEDeleteItem ((AEDescList*)ewg_theAEDescList, (long)ewg_index);
}

// Return address of function 'AEDeleteItem'
void* ewg_get_function_address_AEDeleteItem (void)
{
	return (void*) AEDeleteItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECheckIsRecord'
// For ise
Boolean  ewg_function_AECheckIsRecord (AEDesc const *ewg_theDesc)
{
	return AECheckIsRecord ((AEDesc const*)ewg_theDesc);
}

// Return address of function 'AECheckIsRecord'
void* ewg_get_function_address_AECheckIsRecord (void)
{
	return (void*) AECheckIsRecord;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECreateAppleEvent'
// For ise
OSErr  ewg_function_AECreateAppleEvent (AEEventClass ewg_theAEEventClass, AEEventID ewg_theAEEventID, AEAddressDesc const *ewg_target, AEReturnID ewg_returnID, AETransactionID ewg_transactionID, AppleEvent *ewg_result)
{
	return AECreateAppleEvent ((AEEventClass)ewg_theAEEventClass, (AEEventID)ewg_theAEEventID, (AEAddressDesc const*)ewg_target, (AEReturnID)ewg_returnID, (AETransactionID)ewg_transactionID, (AppleEvent*)ewg_result);
}

// Return address of function 'AECreateAppleEvent'
void* ewg_get_function_address_AECreateAppleEvent (void)
{
	return (void*) AECreateAppleEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutParamPtr'
// For ise
OSErr  ewg_function_AEPutParamPtr (AppleEvent *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize)
{
	return AEPutParamPtr ((AppleEvent*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize);
}

// Return address of function 'AEPutParamPtr'
void* ewg_get_function_address_AEPutParamPtr (void)
{
	return (void*) AEPutParamPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutParamDesc'
// For ise
OSErr  ewg_function_AEPutParamDesc (AppleEvent *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, AEDesc const *ewg_theAEDesc)
{
	return AEPutParamDesc ((AppleEvent*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (AEDesc const*)ewg_theAEDesc);
}

// Return address of function 'AEPutParamDesc'
void* ewg_get_function_address_AEPutParamDesc (void)
{
	return (void*) AEPutParamDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetParamPtr'
// For ise
OSErr  ewg_function_AEGetParamPtr (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_desiredType, DescType *ewg_actualType, void *ewg_dataPtr, Size ewg_maximumSize, Size *ewg_actualSize)
{
	return AEGetParamPtr ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_desiredType, (DescType*)ewg_actualType, (void*)ewg_dataPtr, (Size)ewg_maximumSize, (Size*)ewg_actualSize);
}

// Return address of function 'AEGetParamPtr'
void* ewg_get_function_address_AEGetParamPtr (void)
{
	return (void*) AEGetParamPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetParamDesc'
// For ise
OSErr  ewg_function_AEGetParamDesc (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_desiredType, AEDesc *ewg_result)
{
	return AEGetParamDesc ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_desiredType, (AEDesc*)ewg_result);
}

// Return address of function 'AEGetParamDesc'
void* ewg_get_function_address_AEGetParamDesc (void)
{
	return (void*) AEGetParamDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AESizeOfParam'
// For ise
OSErr  ewg_function_AESizeOfParam (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType *ewg_typeCode, Size *ewg_dataSize)
{
	return AESizeOfParam ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType*)ewg_typeCode, (Size*)ewg_dataSize);
}

// Return address of function 'AESizeOfParam'
void* ewg_get_function_address_AESizeOfParam (void)
{
	return (void*) AESizeOfParam;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEDeleteParam'
// For ise
OSErr  ewg_function_AEDeleteParam (AppleEvent *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword)
{
	return AEDeleteParam ((AppleEvent*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword);
}

// Return address of function 'AEDeleteParam'
void* ewg_get_function_address_AEDeleteParam (void)
{
	return (void*) AEDeleteParam;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetAttributePtr'
// For ise
OSErr  ewg_function_AEGetAttributePtr (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_desiredType, DescType *ewg_typeCode, void *ewg_dataPtr, Size ewg_maximumSize, Size *ewg_actualSize)
{
	return AEGetAttributePtr ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_desiredType, (DescType*)ewg_typeCode, (void*)ewg_dataPtr, (Size)ewg_maximumSize, (Size*)ewg_actualSize);
}

// Return address of function 'AEGetAttributePtr'
void* ewg_get_function_address_AEGetAttributePtr (void)
{
	return (void*) AEGetAttributePtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetAttributeDesc'
// For ise
OSErr  ewg_function_AEGetAttributeDesc (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_desiredType, AEDesc *ewg_result)
{
	return AEGetAttributeDesc ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_desiredType, (AEDesc*)ewg_result);
}

// Return address of function 'AEGetAttributeDesc'
void* ewg_get_function_address_AEGetAttributeDesc (void)
{
	return (void*) AEGetAttributeDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AESizeOfAttribute'
// For ise
OSErr  ewg_function_AESizeOfAttribute (AppleEvent const *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType *ewg_typeCode, Size *ewg_dataSize)
{
	return AESizeOfAttribute ((AppleEvent const*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType*)ewg_typeCode, (Size*)ewg_dataSize);
}

// Return address of function 'AESizeOfAttribute'
void* ewg_get_function_address_AESizeOfAttribute (void)
{
	return (void*) AESizeOfAttribute;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutAttributePtr'
// For ise
OSErr  ewg_function_AEPutAttributePtr (AppleEvent *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize)
{
	return AEPutAttributePtr ((AppleEvent*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize);
}

// Return address of function 'AEPutAttributePtr'
void* ewg_get_function_address_AEPutAttributePtr (void)
{
	return (void*) AEPutAttributePtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEPutAttributeDesc'
// For ise
OSErr  ewg_function_AEPutAttributeDesc (AppleEvent *ewg_theAppleEvent, AEKeyword ewg_theAEKeyword, AEDesc const *ewg_theAEDesc)
{
	return AEPutAttributeDesc ((AppleEvent*)ewg_theAppleEvent, (AEKeyword)ewg_theAEKeyword, (AEDesc const*)ewg_theAEDesc);
}

// Return address of function 'AEPutAttributeDesc'
void* ewg_get_function_address_AEPutAttributeDesc (void)
{
	return (void*) AEPutAttributeDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AESizeOfFlattenedDesc'
// For ise
Size  ewg_function_AESizeOfFlattenedDesc (AEDesc const *ewg_theAEDesc)
{
	return AESizeOfFlattenedDesc ((AEDesc const*)ewg_theAEDesc);
}

// Return address of function 'AESizeOfFlattenedDesc'
void* ewg_get_function_address_AESizeOfFlattenedDesc (void)
{
	return (void*) AESizeOfFlattenedDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEFlattenDesc'
// For ise
OSStatus  ewg_function_AEFlattenDesc (AEDesc const *ewg_theAEDesc, Ptr ewg_buffer, Size ewg_bufferSize, Size *ewg_actualSize)
{
	return AEFlattenDesc ((AEDesc const*)ewg_theAEDesc, (Ptr)ewg_buffer, (Size)ewg_bufferSize, (Size*)ewg_actualSize);
}

// Return address of function 'AEFlattenDesc'
void* ewg_get_function_address_AEFlattenDesc (void)
{
	return (void*) AEFlattenDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEUnflattenDesc'
// For ise
OSStatus  ewg_function_AEUnflattenDesc (void const *ewg_buffer, AEDesc *ewg_result)
{
	return AEUnflattenDesc ((void const*)ewg_buffer, (AEDesc*)ewg_result);
}

// Return address of function 'AEUnflattenDesc'
void* ewg_get_function_address_AEUnflattenDesc (void)
{
	return (void*) AEUnflattenDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetDescData'
// For ise
OSErr  ewg_function_AEGetDescData (AEDesc const *ewg_theAEDesc, void *ewg_dataPtr, Size ewg_maximumSize)
{
	return AEGetDescData ((AEDesc const*)ewg_theAEDesc, (void*)ewg_dataPtr, (Size)ewg_maximumSize);
}

// Return address of function 'AEGetDescData'
void* ewg_get_function_address_AEGetDescData (void)
{
	return (void*) AEGetDescData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetDescDataSize'
// For ise
Size  ewg_function_AEGetDescDataSize (AEDesc const *ewg_theAEDesc)
{
	return AEGetDescDataSize ((AEDesc const*)ewg_theAEDesc);
}

// Return address of function 'AEGetDescDataSize'
void* ewg_get_function_address_AEGetDescDataSize (void)
{
	return (void*) AEGetDescDataSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEReplaceDescData'
// For ise
OSErr  ewg_function_AEReplaceDescData (DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize, AEDesc *ewg_theAEDesc)
{
	return AEReplaceDescData ((DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize, (AEDesc*)ewg_theAEDesc);
}

// Return address of function 'AEReplaceDescData'
void* ewg_get_function_address_AEReplaceDescData (void)
{
	return (void*) AEReplaceDescData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetDescDataRange'
// For ise
OSStatus  ewg_function_AEGetDescDataRange (AEDesc const *ewg_dataDesc, void *ewg_buffer, Size ewg_offset, Size ewg_length)
{
	return AEGetDescDataRange ((AEDesc const*)ewg_dataDesc, (void*)ewg_buffer, (Size)ewg_offset, (Size)ewg_length);
}

// Return address of function 'AEGetDescDataRange'
void* ewg_get_function_address_AEGetDescDataRange (void)
{
	return (void*) AEGetDescDataRange;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewAEDisposeExternalUPP'
// For ise
AEDisposeExternalUPP  ewg_function_NewAEDisposeExternalUPP (AEDisposeExternalProcPtr ewg_userRoutine)
{
	return NewAEDisposeExternalUPP ((AEDisposeExternalProcPtr)ewg_userRoutine);
}

// Return address of function 'NewAEDisposeExternalUPP'
void* ewg_get_function_address_NewAEDisposeExternalUPP (void)
{
	return (void*) NewAEDisposeExternalUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewAEEventHandlerUPP'
// For ise
AEEventHandlerUPP  ewg_function_NewAEEventHandlerUPP (AEEventHandlerProcPtr ewg_userRoutine)
{
	return NewAEEventHandlerUPP ((AEEventHandlerProcPtr)ewg_userRoutine);
}

// Return address of function 'NewAEEventHandlerUPP'
void* ewg_get_function_address_NewAEEventHandlerUPP (void)
{
	return (void*) NewAEEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeAEDisposeExternalUPP'
// For ise
void  ewg_function_DisposeAEDisposeExternalUPP (AEDisposeExternalUPP ewg_userUPP)
{
	DisposeAEDisposeExternalUPP ((AEDisposeExternalUPP)ewg_userUPP);
}

// Return address of function 'DisposeAEDisposeExternalUPP'
void* ewg_get_function_address_DisposeAEDisposeExternalUPP (void)
{
	return (void*) DisposeAEDisposeExternalUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeAEEventHandlerUPP'
// For ise
void  ewg_function_DisposeAEEventHandlerUPP (AEEventHandlerUPP ewg_userUPP)
{
	DisposeAEEventHandlerUPP ((AEEventHandlerUPP)ewg_userUPP);
}

// Return address of function 'DisposeAEEventHandlerUPP'
void* ewg_get_function_address_DisposeAEEventHandlerUPP (void)
{
	return (void*) DisposeAEEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeAEDisposeExternalUPP'
// For ise
void  ewg_function_InvokeAEDisposeExternalUPP (void const *ewg_dataPtr, Size ewg_dataLength, long ewg_refcon, AEDisposeExternalUPP ewg_userUPP)
{
	InvokeAEDisposeExternalUPP ((void const*)ewg_dataPtr, (Size)ewg_dataLength, (long)ewg_refcon, (AEDisposeExternalUPP)ewg_userUPP);
}

// Return address of function 'InvokeAEDisposeExternalUPP'
void* ewg_get_function_address_InvokeAEDisposeExternalUPP (void)
{
	return (void*) InvokeAEDisposeExternalUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeAEEventHandlerUPP'
// For ise
OSErr  ewg_function_InvokeAEEventHandlerUPP (AppleEvent const *ewg_theAppleEvent, AppleEvent *ewg_reply, long ewg_handlerRefcon, AEEventHandlerUPP ewg_userUPP)
{
	return InvokeAEEventHandlerUPP ((AppleEvent const*)ewg_theAppleEvent, (AppleEvent*)ewg_reply, (long)ewg_handlerRefcon, (AEEventHandlerUPP)ewg_userUPP);
}

// Return address of function 'InvokeAEEventHandlerUPP'
void* ewg_get_function_address_InvokeAEEventHandlerUPP (void)
{
	return (void*) InvokeAEEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEInstallEventHandler'
// For ise
OSErr  ewg_function_AEInstallEventHandler (AEEventClass ewg_theAEEventClass, AEEventID ewg_theAEEventID, AEEventHandlerUPP ewg_handler, long ewg_handlerRefcon, Boolean ewg_isSysHandler)
{
	return AEInstallEventHandler ((AEEventClass)ewg_theAEEventClass, (AEEventID)ewg_theAEEventID, (AEEventHandlerUPP)ewg_handler, (long)ewg_handlerRefcon, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEInstallEventHandler'
void* ewg_get_function_address_AEInstallEventHandler (void)
{
	return (void*) AEInstallEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AERemoveEventHandler'
// For ise
OSErr  ewg_function_AERemoveEventHandler (AEEventClass ewg_theAEEventClass, AEEventID ewg_theAEEventID, AEEventHandlerUPP ewg_handler, Boolean ewg_isSysHandler)
{
	return AERemoveEventHandler ((AEEventClass)ewg_theAEEventClass, (AEEventID)ewg_theAEEventID, (AEEventHandlerUPP)ewg_handler, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AERemoveEventHandler'
void* ewg_get_function_address_AERemoveEventHandler (void)
{
	return (void*) AERemoveEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetEventHandler'
// For ise
OSErr  ewg_function_AEGetEventHandler (AEEventClass ewg_theAEEventClass, AEEventID ewg_theAEEventID, AEEventHandlerUPP *ewg_handler, long *ewg_handlerRefcon, Boolean ewg_isSysHandler)
{
	return AEGetEventHandler ((AEEventClass)ewg_theAEEventClass, (AEEventID)ewg_theAEEventID, (AEEventHandlerUPP*)ewg_handler, (long*)ewg_handlerRefcon, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEGetEventHandler'
void* ewg_get_function_address_AEGetEventHandler (void)
{
	return (void*) AEGetEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEInstallSpecialHandler'
// For ise
OSErr  ewg_function_AEInstallSpecialHandler (AEKeyword ewg_functionClass, AEEventHandlerUPP ewg_handler, Boolean ewg_isSysHandler)
{
	return AEInstallSpecialHandler ((AEKeyword)ewg_functionClass, (AEEventHandlerUPP)ewg_handler, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEInstallSpecialHandler'
void* ewg_get_function_address_AEInstallSpecialHandler (void)
{
	return (void*) AEInstallSpecialHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AERemoveSpecialHandler'
// For ise
OSErr  ewg_function_AERemoveSpecialHandler (AEKeyword ewg_functionClass, AEEventHandlerUPP ewg_handler, Boolean ewg_isSysHandler)
{
	return AERemoveSpecialHandler ((AEKeyword)ewg_functionClass, (AEEventHandlerUPP)ewg_handler, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AERemoveSpecialHandler'
void* ewg_get_function_address_AERemoveSpecialHandler (void)
{
	return (void*) AERemoveSpecialHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEGetSpecialHandler'
// For ise
OSErr  ewg_function_AEGetSpecialHandler (AEKeyword ewg_functionClass, AEEventHandlerUPP *ewg_handler, Boolean ewg_isSysHandler)
{
	return AEGetSpecialHandler ((AEKeyword)ewg_functionClass, (AEEventHandlerUPP*)ewg_handler, (Boolean)ewg_isSysHandler);
}

// Return address of function 'AEGetSpecialHandler'
void* ewg_get_function_address_AEGetSpecialHandler (void)
{
	return (void*) AEGetSpecialHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEManagerInfo'
// For ise
OSErr  ewg_function_AEManagerInfo (AEKeyword ewg_keyWord, long *ewg_result)
{
	return AEManagerInfo ((AEKeyword)ewg_keyWord, (long*)ewg_result);
}

// Return address of function 'AEManagerInfo'
void* ewg_get_function_address_AEManagerInfo (void)
{
	return (void*) AEManagerInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AECreateRemoteProcessResolver'
// For ise
AERemoteProcessResolverRef  ewg_function_AECreateRemoteProcessResolver (CFAllocatorRef ewg_allocator, CFURLRef ewg_url)
{
	return AECreateRemoteProcessResolver ((CFAllocatorRef)ewg_allocator, (CFURLRef)ewg_url);
}

// Return address of function 'AECreateRemoteProcessResolver'
void* ewg_get_function_address_AECreateRemoteProcessResolver (void)
{
	return (void*) AECreateRemoteProcessResolver;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AEDisposeRemoteProcessResolver'
// For ise
void  ewg_function_AEDisposeRemoteProcessResolver (AERemoteProcessResolverRef ewg_ref)
{
	AEDisposeRemoteProcessResolver ((AERemoteProcessResolverRef)ewg_ref);
}

// Return address of function 'AEDisposeRemoteProcessResolver'
void* ewg_get_function_address_AEDisposeRemoteProcessResolver (void)
{
	return (void*) AEDisposeRemoteProcessResolver;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AERemoteProcessResolverGetProcesses'
// For ise
CFArrayRef  ewg_function_AERemoteProcessResolverGetProcesses (AERemoteProcessResolverRef ewg_ref, CFStreamError *ewg_outError)
{
	return AERemoteProcessResolverGetProcesses ((AERemoteProcessResolverRef)ewg_ref, (CFStreamError*)ewg_outError);
}

// Return address of function 'AERemoteProcessResolverGetProcesses'
void* ewg_get_function_address_AERemoteProcessResolverGetProcesses (void)
{
	return (void*) AERemoteProcessResolverGetProcesses;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AERemoteProcessResolverScheduleWithRunLoop'
// For ise
void  ewg_function_AERemoteProcessResolverScheduleWithRunLoop (AERemoteProcessResolverRef ewg_ref, CFRunLoopRef ewg_runLoop, CFStringRef ewg_runLoopMode, AERemoteProcessResolverCallback ewg_callback, AERemoteProcessResolverContext const *ewg_ctx)
{
	AERemoteProcessResolverScheduleWithRunLoop ((AERemoteProcessResolverRef)ewg_ref, (CFRunLoopRef)ewg_runLoop, (CFStringRef)ewg_runLoopMode, (AERemoteProcessResolverCallback)ewg_callback, (AERemoteProcessResolverContext const*)ewg_ctx);
}

// Return address of function 'AERemoteProcessResolverScheduleWithRunLoop'
void* ewg_get_function_address_AERemoteProcessResolverScheduleWithRunLoop (void)
{
	return (void*) AERemoteProcessResolverScheduleWithRunLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictCreateWithProvider'
// For ise
QDPictRef  ewg_function_QDPictCreateWithProvider (CGDataProviderRef ewg_provider)
{
	return QDPictCreateWithProvider ((CGDataProviderRef)ewg_provider);
}

// Return address of function 'QDPictCreateWithProvider'
void* ewg_get_function_address_QDPictCreateWithProvider (void)
{
	return (void*) QDPictCreateWithProvider;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictCreateWithURL'
// For ise
QDPictRef  ewg_function_QDPictCreateWithURL (CFURLRef ewg_url)
{
	return QDPictCreateWithURL ((CFURLRef)ewg_url);
}

// Return address of function 'QDPictCreateWithURL'
void* ewg_get_function_address_QDPictCreateWithURL (void)
{
	return (void*) QDPictCreateWithURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictRetain'
// For ise
QDPictRef  ewg_function_QDPictRetain (QDPictRef ewg_pictRef)
{
	return QDPictRetain ((QDPictRef)ewg_pictRef);
}

// Return address of function 'QDPictRetain'
void* ewg_get_function_address_QDPictRetain (void)
{
	return (void*) QDPictRetain;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictRelease'
// For ise
void  ewg_function_QDPictRelease (QDPictRef ewg_pictRef)
{
	QDPictRelease ((QDPictRef)ewg_pictRef);
}

// Return address of function 'QDPictRelease'
void* ewg_get_function_address_QDPictRelease (void)
{
	return (void*) QDPictRelease;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictGetBounds'
// For ise
CGRect * ewg_function_QDPictGetBounds (QDPictRef ewg_pictRef)
{
	CGRect *result = (CGRect*) malloc (sizeof(CGRect));
	*result = QDPictGetBounds ((QDPictRef)ewg_pictRef);
	return result;
}

// Return address of function 'QDPictGetBounds'
void* ewg_get_function_address_QDPictGetBounds (void)
{
	return (void*) QDPictGetBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictGetResolution'
// For ise
void  ewg_function_QDPictGetResolution (QDPictRef ewg_pictRef, float *ewg_xRes, float *ewg_yRes)
{
	QDPictGetResolution ((QDPictRef)ewg_pictRef, (float*)ewg_xRes, (float*)ewg_yRes);
}

// Return address of function 'QDPictGetResolution'
void* ewg_get_function_address_QDPictGetResolution (void)
{
	return (void*) QDPictGetResolution;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QDPictDrawToCGContext'
// For ise
OSStatus  ewg_function_QDPictDrawToCGContext (CGContextRef ewg_ctx, CGRect *ewg_rect, QDPictRef ewg_pictRef)
{
	return QDPictDrawToCGContext ((CGContextRef)ewg_ctx, *(CGRect*)ewg_rect, (QDPictRef)ewg_pictRef);
}

// Return address of function 'QDPictDrawToCGContext'
void* ewg_get_function_address_QDPictDrawToCGContext (void)
{
	return (void*) QDPictDrawToCGContext;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LaunchApplication'
// For ise
OSErr  ewg_function_LaunchApplication (LaunchPBPtr ewg_LaunchParams)
{
	return LaunchApplication ((LaunchPBPtr)ewg_LaunchParams);
}

// Return address of function 'LaunchApplication'
void* ewg_get_function_address_LaunchApplication (void)
{
	return (void*) LaunchApplication;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentProcess'
// For ise
OSErr  ewg_function_GetCurrentProcess (ProcessSerialNumber *ewg_PSN)
{
	return GetCurrentProcess ((ProcessSerialNumber*)ewg_PSN);
}

// Return address of function 'GetCurrentProcess'
void* ewg_get_function_address_GetCurrentProcess (void)
{
	return (void*) GetCurrentProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetFrontProcess'
// For ise
OSErr  ewg_function_GetFrontProcess (ProcessSerialNumber *ewg_PSN)
{
	return GetFrontProcess ((ProcessSerialNumber*)ewg_PSN);
}

// Return address of function 'GetFrontProcess'
void* ewg_get_function_address_GetFrontProcess (void)
{
	return (void*) GetFrontProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNextProcess'
// For ise
OSErr  ewg_function_GetNextProcess (ProcessSerialNumber *ewg_PSN)
{
	return GetNextProcess ((ProcessSerialNumber*)ewg_PSN);
}

// Return address of function 'GetNextProcess'
void* ewg_get_function_address_GetNextProcess (void)
{
	return (void*) GetNextProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetProcessInformation'
// For ise
OSErr  ewg_function_GetProcessInformation (ProcessSerialNumber const *ewg_PSN, ProcessInfoRec *ewg_info)
{
	return GetProcessInformation ((ProcessSerialNumber const*)ewg_PSN, (ProcessInfoRec*)ewg_info);
}

// Return address of function 'GetProcessInformation'
void* ewg_get_function_address_GetProcessInformation (void)
{
	return (void*) GetProcessInformation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ProcessInformationCopyDictionary'
// For ise
CFDictionaryRef  ewg_function_ProcessInformationCopyDictionary (ProcessSerialNumber const *ewg_PSN, UInt32 ewg_infoToReturn)
{
	return ProcessInformationCopyDictionary ((ProcessSerialNumber const*)ewg_PSN, (UInt32)ewg_infoToReturn);
}

// Return address of function 'ProcessInformationCopyDictionary'
void* ewg_get_function_address_ProcessInformationCopyDictionary (void)
{
	return (void*) ProcessInformationCopyDictionary;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetFrontProcess'
// For ise
OSErr  ewg_function_SetFrontProcess (ProcessSerialNumber const *ewg_PSN)
{
	return SetFrontProcess ((ProcessSerialNumber const*)ewg_PSN);
}

// Return address of function 'SetFrontProcess'
void* ewg_get_function_address_SetFrontProcess (void)
{
	return (void*) SetFrontProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetFrontProcessWithOptions'
// For ise
OSStatus  ewg_function_SetFrontProcessWithOptions (ProcessSerialNumber const *ewg_inProcess, OptionBits ewg_inOptions)
{
	return SetFrontProcessWithOptions ((ProcessSerialNumber const*)ewg_inProcess, (OptionBits)ewg_inOptions);
}

// Return address of function 'SetFrontProcessWithOptions'
void* ewg_get_function_address_SetFrontProcessWithOptions (void)
{
	return (void*) SetFrontProcessWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'WakeUpProcess'
// For ise
OSErr  ewg_function_WakeUpProcess (ProcessSerialNumber const *ewg_PSN)
{
	return WakeUpProcess ((ProcessSerialNumber const*)ewg_PSN);
}

// Return address of function 'WakeUpProcess'
void* ewg_get_function_address_WakeUpProcess (void)
{
	return (void*) WakeUpProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SameProcess'
// For ise
OSErr  ewg_function_SameProcess (ProcessSerialNumber const *ewg_PSN1, ProcessSerialNumber const *ewg_PSN2, Boolean *ewg_result)
{
	return SameProcess ((ProcessSerialNumber const*)ewg_PSN1, (ProcessSerialNumber const*)ewg_PSN2, (Boolean*)ewg_result);
}

// Return address of function 'SameProcess'
void* ewg_get_function_address_SameProcess (void)
{
	return (void*) SameProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ExitToShell'
// For ise
void  ewg_function_ExitToShell (void)
{
	ExitToShell ();
}

// Return address of function 'ExitToShell'
void* ewg_get_function_address_ExitToShell (void)
{
	return (void*) ExitToShell;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'KillProcess'
// For ise
OSErr  ewg_function_KillProcess (ProcessSerialNumber const *ewg_inProcess)
{
	return KillProcess ((ProcessSerialNumber const*)ewg_inProcess);
}

// Return address of function 'KillProcess'
void* ewg_get_function_address_KillProcess (void)
{
	return (void*) KillProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetProcessBundleLocation'
// For ise
OSStatus  ewg_function_GetProcessBundleLocation (ProcessSerialNumber const *ewg_psn, FSRef *ewg_location)
{
	return GetProcessBundleLocation ((ProcessSerialNumber const*)ewg_psn, (FSRef*)ewg_location);
}

// Return address of function 'GetProcessBundleLocation'
void* ewg_get_function_address_GetProcessBundleLocation (void)
{
	return (void*) GetProcessBundleLocation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyProcessName'
// For ise
OSStatus  ewg_function_CopyProcessName (ProcessSerialNumber const *ewg_psn, CFStringRef *ewg_name)
{
	return CopyProcessName ((ProcessSerialNumber const*)ewg_psn, (CFStringRef*)ewg_name);
}

// Return address of function 'CopyProcessName'
void* ewg_get_function_address_CopyProcessName (void)
{
	return (void*) CopyProcessName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetProcessPID'
// For ise
OSStatus  ewg_function_GetProcessPID (ProcessSerialNumber const *ewg_psn, pid_t *ewg_pid)
{
	return GetProcessPID ((ProcessSerialNumber const*)ewg_psn, (pid_t*)ewg_pid);
}

// Return address of function 'GetProcessPID'
void* ewg_get_function_address_GetProcessPID (void)
{
	return (void*) GetProcessPID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetProcessForPID'
// For ise
OSStatus  ewg_function_GetProcessForPID (pid_t ewg_pid, ProcessSerialNumber *ewg_psn)
{
	return GetProcessForPID ((pid_t)ewg_pid, (ProcessSerialNumber*)ewg_psn);
}

// Return address of function 'GetProcessForPID'
void* ewg_get_function_address_GetProcessForPID (void)
{
	return (void*) GetProcessForPID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsProcessVisible'
// For ise
Boolean  ewg_function_IsProcessVisible (ProcessSerialNumber const *ewg_psn)
{
	return IsProcessVisible ((ProcessSerialNumber const*)ewg_psn);
}

// Return address of function 'IsProcessVisible'
void* ewg_get_function_address_IsProcessVisible (void)
{
	return (void*) IsProcessVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowHideProcess'
// For ise
OSErr  ewg_function_ShowHideProcess (ProcessSerialNumber const *ewg_psn, Boolean ewg_visible)
{
	return ShowHideProcess ((ProcessSerialNumber const*)ewg_psn, (Boolean)ewg_visible);
}

// Return address of function 'ShowHideProcess'
void* ewg_get_function_address_ShowHideProcess (void)
{
	return (void*) ShowHideProcess;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TransformProcessType'
// For ise
OSStatus  ewg_function_TransformProcessType (ProcessSerialNumber const *ewg_psn, ProcessApplicationTransformState ewg_transformState)
{
	return TransformProcessType ((ProcessSerialNumber const*)ewg_psn, (ProcessApplicationTransformState)ewg_transformState);
}

// Return address of function 'TransformProcessType'
void* ewg_get_function_address_TransformProcessType (void)
{
	return (void*) TransformProcessType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEventLoop'
// For ise
EventLoopRef  ewg_function_GetCurrentEventLoop (void)
{
	return GetCurrentEventLoop ();
}

// Return address of function 'GetCurrentEventLoop'
void* ewg_get_function_address_GetCurrentEventLoop (void)
{
	return (void*) GetCurrentEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMainEventLoop'
// For ise
EventLoopRef  ewg_function_GetMainEventLoop (void)
{
	return GetMainEventLoop ();
}

// Return address of function 'GetMainEventLoop'
void* ewg_get_function_address_GetMainEventLoop (void)
{
	return (void*) GetMainEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RunCurrentEventLoop'
// For ise
OSStatus  ewg_function_RunCurrentEventLoop (EventTimeout ewg_inTimeout)
{
	return RunCurrentEventLoop ((EventTimeout)ewg_inTimeout);
}

// Return address of function 'RunCurrentEventLoop'
void* ewg_get_function_address_RunCurrentEventLoop (void)
{
	return (void*) RunCurrentEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QuitEventLoop'
// For ise
OSStatus  ewg_function_QuitEventLoop (EventLoopRef ewg_inEventLoop)
{
	return QuitEventLoop ((EventLoopRef)ewg_inEventLoop);
}

// Return address of function 'QuitEventLoop'
void* ewg_get_function_address_QuitEventLoop (void)
{
	return (void*) QuitEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCFRunLoopFromEventLoop'
// For ise
CFTypeRef  ewg_function_GetCFRunLoopFromEventLoop (EventLoopRef ewg_inEventLoop)
{
	return GetCFRunLoopFromEventLoop ((EventLoopRef)ewg_inEventLoop);
}

// Return address of function 'GetCFRunLoopFromEventLoop'
void* ewg_get_function_address_GetCFRunLoopFromEventLoop (void)
{
	return (void*) GetCFRunLoopFromEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReceiveNextEvent'
// For ise
OSStatus  ewg_function_ReceiveNextEvent (UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList, EventTimeout ewg_inTimeout, Boolean ewg_inPullEvent, EventRef *ewg_outEvent)
{
	return ReceiveNextEvent ((UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList, (EventTimeout)ewg_inTimeout, (Boolean)ewg_inPullEvent, (EventRef*)ewg_outEvent);
}

// Return address of function 'ReceiveNextEvent'
void* ewg_get_function_address_ReceiveNextEvent (void)
{
	return (void*) ReceiveNextEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateEvent'
// For ise
OSStatus  ewg_function_CreateEvent (CFAllocatorRef ewg_inAllocator, UInt32 ewg_inClassID, UInt32 ewg_inKind, EventTime ewg_inWhen, EventAttributes ewg_inAttributes, EventRef *ewg_outEvent)
{
	return CreateEvent ((CFAllocatorRef)ewg_inAllocator, (UInt32)ewg_inClassID, (UInt32)ewg_inKind, (EventTime)ewg_inWhen, (EventAttributes)ewg_inAttributes, (EventRef*)ewg_outEvent);
}

// Return address of function 'CreateEvent'
void* ewg_get_function_address_CreateEvent (void)
{
	return (void*) CreateEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyEvent'
// For ise
EventRef  ewg_function_CopyEvent (EventRef ewg_inOther)
{
	return CopyEvent ((EventRef)ewg_inOther);
}

// Return address of function 'CopyEvent'
void* ewg_get_function_address_CopyEvent (void)
{
	return (void*) CopyEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyEventAs'
// For ise
EventRef  ewg_function_CopyEventAs (CFAllocatorRef ewg_inAllocator, EventRef ewg_inOther, UInt32 ewg_inEventClass, UInt32 ewg_inEventKind)
{
	return CopyEventAs ((CFAllocatorRef)ewg_inAllocator, (EventRef)ewg_inOther, (UInt32)ewg_inEventClass, (UInt32)ewg_inEventKind);
}

// Return address of function 'CopyEventAs'
void* ewg_get_function_address_CopyEventAs (void)
{
	return (void*) CopyEventAs;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RetainEvent'
// For ise
EventRef  ewg_function_RetainEvent (EventRef ewg_inEvent)
{
	return RetainEvent ((EventRef)ewg_inEvent);
}

// Return address of function 'RetainEvent'
void* ewg_get_function_address_RetainEvent (void)
{
	return (void*) RetainEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventRetainCount'
// For ise
UInt32  ewg_function_GetEventRetainCount (EventRef ewg_inEvent)
{
	return GetEventRetainCount ((EventRef)ewg_inEvent);
}

// Return address of function 'GetEventRetainCount'
void* ewg_get_function_address_GetEventRetainCount (void)
{
	return (void*) GetEventRetainCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseEvent'
// For ise
void  ewg_function_ReleaseEvent (EventRef ewg_inEvent)
{
	ReleaseEvent ((EventRef)ewg_inEvent);
}

// Return address of function 'ReleaseEvent'
void* ewg_get_function_address_ReleaseEvent (void)
{
	return (void*) ReleaseEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetEventParameter'
// For ise
OSStatus  ewg_function_SetEventParameter (EventRef ewg_inEvent, EventParamName ewg_inName, EventParamType ewg_inType, UInt32 ewg_inSize, void const *ewg_inDataPtr)
{
	return SetEventParameter ((EventRef)ewg_inEvent, (EventParamName)ewg_inName, (EventParamType)ewg_inType, (UInt32)ewg_inSize, (void const*)ewg_inDataPtr);
}

// Return address of function 'SetEventParameter'
void* ewg_get_function_address_SetEventParameter (void)
{
	return (void*) SetEventParameter;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventParameter'
// For ise
OSStatus  ewg_function_GetEventParameter (EventRef ewg_inEvent, EventParamName ewg_inName, EventParamType ewg_inDesiredType, EventParamType *ewg_outActualType, UInt32 ewg_inBufferSize, UInt32 *ewg_outActualSize, void *ewg_outData)
{
	return GetEventParameter ((EventRef)ewg_inEvent, (EventParamName)ewg_inName, (EventParamType)ewg_inDesiredType, (EventParamType*)ewg_outActualType, (UInt32)ewg_inBufferSize, (UInt32*)ewg_outActualSize, (void*)ewg_outData);
}

// Return address of function 'GetEventParameter'
void* ewg_get_function_address_GetEventParameter (void)
{
	return (void*) GetEventParameter;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventClass'
// For ise
UInt32  ewg_function_GetEventClass (EventRef ewg_inEvent)
{
	return GetEventClass ((EventRef)ewg_inEvent);
}

// Return address of function 'GetEventClass'
void* ewg_get_function_address_GetEventClass (void)
{
	return (void*) GetEventClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventKind'
// For ise
UInt32  ewg_function_GetEventKind (EventRef ewg_inEvent)
{
	return GetEventKind ((EventRef)ewg_inEvent);
}

// Return address of function 'GetEventKind'
void* ewg_get_function_address_GetEventKind (void)
{
	return (void*) GetEventKind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventTime'
// For ise
EventTime  ewg_function_GetEventTime (EventRef ewg_inEvent)
{
	return GetEventTime ((EventRef)ewg_inEvent);
}

// Return address of function 'GetEventTime'
void* ewg_get_function_address_GetEventTime (void)
{
	return (void*) GetEventTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetEventTime'
// For ise
OSStatus  ewg_function_SetEventTime (EventRef ewg_inEvent, EventTime ewg_inTime)
{
	return SetEventTime ((EventRef)ewg_inEvent, (EventTime)ewg_inTime);
}

// Return address of function 'SetEventTime'
void* ewg_get_function_address_SetEventTime (void)
{
	return (void*) SetEventTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEventQueue'
// For ise
EventQueueRef  ewg_function_GetCurrentEventQueue (void)
{
	return GetCurrentEventQueue ();
}

// Return address of function 'GetCurrentEventQueue'
void* ewg_get_function_address_GetCurrentEventQueue (void)
{
	return (void*) GetCurrentEventQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMainEventQueue'
// For ise
EventQueueRef  ewg_function_GetMainEventQueue (void)
{
	return GetMainEventQueue ();
}

// Return address of function 'GetMainEventQueue'
void* ewg_get_function_address_GetMainEventQueue (void)
{
	return (void*) GetMainEventQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewEventComparatorUPP'
// For ise
EventComparatorUPP  ewg_function_NewEventComparatorUPP (EventComparatorProcPtr ewg_userRoutine)
{
	return NewEventComparatorUPP ((EventComparatorProcPtr)ewg_userRoutine);
}

// Return address of function 'NewEventComparatorUPP'
void* ewg_get_function_address_NewEventComparatorUPP (void)
{
	return (void*) NewEventComparatorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeEventComparatorUPP'
// For ise
void  ewg_function_DisposeEventComparatorUPP (EventComparatorUPP ewg_userUPP)
{
	DisposeEventComparatorUPP ((EventComparatorUPP)ewg_userUPP);
}

// Return address of function 'DisposeEventComparatorUPP'
void* ewg_get_function_address_DisposeEventComparatorUPP (void)
{
	return (void*) DisposeEventComparatorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeEventComparatorUPP'
// For ise
Boolean  ewg_function_InvokeEventComparatorUPP (EventRef ewg_inEvent, void *ewg_inCompareData, EventComparatorUPP ewg_userUPP)
{
	return InvokeEventComparatorUPP ((EventRef)ewg_inEvent, (void*)ewg_inCompareData, (EventComparatorUPP)ewg_userUPP);
}

// Return address of function 'InvokeEventComparatorUPP'
void* ewg_get_function_address_InvokeEventComparatorUPP (void)
{
	return (void*) InvokeEventComparatorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PostEventToQueue'
// For ise
OSStatus  ewg_function_PostEventToQueue (EventQueueRef ewg_inQueue, EventRef ewg_inEvent, EventPriority ewg_inPriority)
{
	return PostEventToQueue ((EventQueueRef)ewg_inQueue, (EventRef)ewg_inEvent, (EventPriority)ewg_inPriority);
}

// Return address of function 'PostEventToQueue'
void* ewg_get_function_address_PostEventToQueue (void)
{
	return (void*) PostEventToQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FlushEventsMatchingListFromQueue'
// For ise
OSStatus  ewg_function_FlushEventsMatchingListFromQueue (EventQueueRef ewg_inQueue, UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList)
{
	return FlushEventsMatchingListFromQueue ((EventQueueRef)ewg_inQueue, (UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList);
}

// Return address of function 'FlushEventsMatchingListFromQueue'
void* ewg_get_function_address_FlushEventsMatchingListFromQueue (void)
{
	return (void*) FlushEventsMatchingListFromQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FlushSpecificEventsFromQueue'
// For ise
OSStatus  ewg_function_FlushSpecificEventsFromQueue (EventQueueRef ewg_inQueue, EventComparatorUPP ewg_inComparator, void *ewg_inCompareData)
{
	return FlushSpecificEventsFromQueue ((EventQueueRef)ewg_inQueue, (EventComparatorUPP)ewg_inComparator, (void*)ewg_inCompareData);
}

// Return address of function 'FlushSpecificEventsFromQueue'
void* ewg_get_function_address_FlushSpecificEventsFromQueue (void)
{
	return (void*) FlushSpecificEventsFromQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FlushEventQueue'
// For ise
OSStatus  ewg_function_FlushEventQueue (EventQueueRef ewg_inQueue)
{
	return FlushEventQueue ((EventQueueRef)ewg_inQueue);
}

// Return address of function 'FlushEventQueue'
void* ewg_get_function_address_FlushEventQueue (void)
{
	return (void*) FlushEventQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FindSpecificEventInQueue'
// For ise
EventRef  ewg_function_FindSpecificEventInQueue (EventQueueRef ewg_inQueue, EventComparatorUPP ewg_inComparator, void *ewg_inCompareData)
{
	return FindSpecificEventInQueue ((EventQueueRef)ewg_inQueue, (EventComparatorUPP)ewg_inComparator, (void*)ewg_inCompareData);
}

// Return address of function 'FindSpecificEventInQueue'
void* ewg_get_function_address_FindSpecificEventInQueue (void)
{
	return (void*) FindSpecificEventInQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNumEventsInQueue'
// For ise
UInt32  ewg_function_GetNumEventsInQueue (EventQueueRef ewg_inQueue)
{
	return GetNumEventsInQueue ((EventQueueRef)ewg_inQueue);
}

// Return address of function 'GetNumEventsInQueue'
void* ewg_get_function_address_GetNumEventsInQueue (void)
{
	return (void*) GetNumEventsInQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveEventFromQueue'
// For ise
OSStatus  ewg_function_RemoveEventFromQueue (EventQueueRef ewg_inQueue, EventRef ewg_inEvent)
{
	return RemoveEventFromQueue ((EventQueueRef)ewg_inQueue, (EventRef)ewg_inEvent);
}

// Return address of function 'RemoveEventFromQueue'
void* ewg_get_function_address_RemoveEventFromQueue (void)
{
	return (void*) RemoveEventFromQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsEventInQueue'
// For ise
Boolean  ewg_function_IsEventInQueue (EventQueueRef ewg_inQueue, EventRef ewg_inEvent)
{
	return IsEventInQueue ((EventQueueRef)ewg_inQueue, (EventRef)ewg_inEvent);
}

// Return address of function 'IsEventInQueue'
void* ewg_get_function_address_IsEventInQueue (void)
{
	return (void*) IsEventInQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AcquireFirstMatchingEventInQueue'
// For ise
EventRef  ewg_function_AcquireFirstMatchingEventInQueue (EventQueueRef ewg_inQueue, UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList, OptionBits ewg_inOptions)
{
	return AcquireFirstMatchingEventInQueue ((EventQueueRef)ewg_inQueue, (UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList, (OptionBits)ewg_inOptions);
}

// Return address of function 'AcquireFirstMatchingEventInQueue'
void* ewg_get_function_address_AcquireFirstMatchingEventInQueue (void)
{
	return (void*) AcquireFirstMatchingEventInQueue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEvent'
// For ise
EventRef  ewg_function_GetCurrentEvent (void)
{
	return GetCurrentEvent ();
}

// Return address of function 'GetCurrentEvent'
void* ewg_get_function_address_GetCurrentEvent (void)
{
	return (void*) GetCurrentEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEventButtonState'
// For ise
UInt32  ewg_function_GetCurrentEventButtonState (void)
{
	return GetCurrentEventButtonState ();
}

// Return address of function 'GetCurrentEventButtonState'
void* ewg_get_function_address_GetCurrentEventButtonState (void)
{
	return (void*) GetCurrentEventButtonState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEventKeyModifiers'
// For ise
UInt32  ewg_function_GetCurrentEventKeyModifiers (void)
{
	return GetCurrentEventKeyModifiers ();
}

// Return address of function 'GetCurrentEventKeyModifiers'
void* ewg_get_function_address_GetCurrentEventKeyModifiers (void)
{
	return (void*) GetCurrentEventKeyModifiers;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentButtonState'
// For ise
UInt32  ewg_function_GetCurrentButtonState (void)
{
	return GetCurrentButtonState ();
}

// Return address of function 'GetCurrentButtonState'
void* ewg_get_function_address_GetCurrentButtonState (void)
{
	return (void*) GetCurrentButtonState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentEventTime'
// For ise
EventTime  ewg_function_GetCurrentEventTime (void)
{
	return GetCurrentEventTime ();
}

// Return address of function 'GetCurrentEventTime'
void* ewg_get_function_address_GetCurrentEventTime (void)
{
	return (void*) GetCurrentEventTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewEventLoopTimerUPP'
// For ise
EventLoopTimerUPP  ewg_function_NewEventLoopTimerUPP (EventLoopTimerProcPtr ewg_userRoutine)
{
	return NewEventLoopTimerUPP ((EventLoopTimerProcPtr)ewg_userRoutine);
}

// Return address of function 'NewEventLoopTimerUPP'
void* ewg_get_function_address_NewEventLoopTimerUPP (void)
{
	return (void*) NewEventLoopTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewEventLoopIdleTimerUPP'
// For ise
EventLoopIdleTimerUPP  ewg_function_NewEventLoopIdleTimerUPP (EventLoopIdleTimerProcPtr ewg_userRoutine)
{
	return NewEventLoopIdleTimerUPP ((EventLoopIdleTimerProcPtr)ewg_userRoutine);
}

// Return address of function 'NewEventLoopIdleTimerUPP'
void* ewg_get_function_address_NewEventLoopIdleTimerUPP (void)
{
	return (void*) NewEventLoopIdleTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeEventLoopTimerUPP'
// For ise
void  ewg_function_DisposeEventLoopTimerUPP (EventLoopTimerUPP ewg_userUPP)
{
	DisposeEventLoopTimerUPP ((EventLoopTimerUPP)ewg_userUPP);
}

// Return address of function 'DisposeEventLoopTimerUPP'
void* ewg_get_function_address_DisposeEventLoopTimerUPP (void)
{
	return (void*) DisposeEventLoopTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeEventLoopIdleTimerUPP'
// For ise
void  ewg_function_DisposeEventLoopIdleTimerUPP (EventLoopIdleTimerUPP ewg_userUPP)
{
	DisposeEventLoopIdleTimerUPP ((EventLoopIdleTimerUPP)ewg_userUPP);
}

// Return address of function 'DisposeEventLoopIdleTimerUPP'
void* ewg_get_function_address_DisposeEventLoopIdleTimerUPP (void)
{
	return (void*) DisposeEventLoopIdleTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeEventLoopTimerUPP'
// For ise
void  ewg_function_InvokeEventLoopTimerUPP (EventLoopTimerRef ewg_inTimer, void *ewg_inUserData, EventLoopTimerUPP ewg_userUPP)
{
	InvokeEventLoopTimerUPP ((EventLoopTimerRef)ewg_inTimer, (void*)ewg_inUserData, (EventLoopTimerUPP)ewg_userUPP);
}

// Return address of function 'InvokeEventLoopTimerUPP'
void* ewg_get_function_address_InvokeEventLoopTimerUPP (void)
{
	return (void*) InvokeEventLoopTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeEventLoopIdleTimerUPP'
// For ise
void  ewg_function_InvokeEventLoopIdleTimerUPP (EventLoopTimerRef ewg_inTimer, EventLoopIdleTimerMessage ewg_inState, void *ewg_inUserData, EventLoopIdleTimerUPP ewg_userUPP)
{
	InvokeEventLoopIdleTimerUPP ((EventLoopTimerRef)ewg_inTimer, (EventLoopIdleTimerMessage)ewg_inState, (void*)ewg_inUserData, (EventLoopIdleTimerUPP)ewg_userUPP);
}

// Return address of function 'InvokeEventLoopIdleTimerUPP'
void* ewg_get_function_address_InvokeEventLoopIdleTimerUPP (void)
{
	return (void*) InvokeEventLoopIdleTimerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InstallEventLoopTimer'
// For ise
OSStatus  ewg_function_InstallEventLoopTimer (EventLoopRef ewg_inEventLoop, EventTimerInterval ewg_inFireDelay, EventTimerInterval ewg_inInterval, EventLoopTimerUPP ewg_inTimerProc, void *ewg_inTimerData, EventLoopTimerRef *ewg_outTimer)
{
	return InstallEventLoopTimer ((EventLoopRef)ewg_inEventLoop, (EventTimerInterval)ewg_inFireDelay, (EventTimerInterval)ewg_inInterval, (EventLoopTimerUPP)ewg_inTimerProc, (void*)ewg_inTimerData, (EventLoopTimerRef*)ewg_outTimer);
}

// Return address of function 'InstallEventLoopTimer'
void* ewg_get_function_address_InstallEventLoopTimer (void)
{
	return (void*) InstallEventLoopTimer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InstallEventLoopIdleTimer'
// For ise
OSStatus  ewg_function_InstallEventLoopIdleTimer (EventLoopRef ewg_inEventLoop, EventTimerInterval ewg_inDelay, EventTimerInterval ewg_inInterval, EventLoopIdleTimerUPP ewg_inTimerProc, void *ewg_inTimerData, EventLoopTimerRef *ewg_outTimer)
{
	return InstallEventLoopIdleTimer ((EventLoopRef)ewg_inEventLoop, (EventTimerInterval)ewg_inDelay, (EventTimerInterval)ewg_inInterval, (EventLoopIdleTimerUPP)ewg_inTimerProc, (void*)ewg_inTimerData, (EventLoopTimerRef*)ewg_outTimer);
}

// Return address of function 'InstallEventLoopIdleTimer'
void* ewg_get_function_address_InstallEventLoopIdleTimer (void)
{
	return (void*) InstallEventLoopIdleTimer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveEventLoopTimer'
// For ise
OSStatus  ewg_function_RemoveEventLoopTimer (EventLoopTimerRef ewg_inTimer)
{
	return RemoveEventLoopTimer ((EventLoopTimerRef)ewg_inTimer);
}

// Return address of function 'RemoveEventLoopTimer'
void* ewg_get_function_address_RemoveEventLoopTimer (void)
{
	return (void*) RemoveEventLoopTimer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetEventLoopTimerNextFireTime'
// For ise
OSStatus  ewg_function_SetEventLoopTimerNextFireTime (EventLoopTimerRef ewg_inTimer, EventTimerInterval ewg_inNextFire)
{
	return SetEventLoopTimerNextFireTime ((EventLoopTimerRef)ewg_inTimer, (EventTimerInterval)ewg_inNextFire);
}

// Return address of function 'SetEventLoopTimerNextFireTime'
void* ewg_get_function_address_SetEventLoopTimerNextFireTime (void)
{
	return (void*) SetEventLoopTimerNextFireTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewEventHandlerUPP'
// For ise
EventHandlerUPP  ewg_function_NewEventHandlerUPP (EventHandlerProcPtr ewg_userRoutine)
{
	return NewEventHandlerUPP ((EventHandlerProcPtr)ewg_userRoutine);
}

// Return address of function 'NewEventHandlerUPP'
void* ewg_get_function_address_NewEventHandlerUPP (void)
{
	return (void*) NewEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeEventHandlerUPP'
// For ise
void  ewg_function_DisposeEventHandlerUPP (EventHandlerUPP ewg_userUPP)
{
	DisposeEventHandlerUPP ((EventHandlerUPP)ewg_userUPP);
}

// Return address of function 'DisposeEventHandlerUPP'
void* ewg_get_function_address_DisposeEventHandlerUPP (void)
{
	return (void*) DisposeEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeEventHandlerUPP'
// For ise
OSStatus  ewg_function_InvokeEventHandlerUPP (EventHandlerCallRef ewg_inHandlerCallRef, EventRef ewg_inEvent, void *ewg_inUserData, EventHandlerUPP ewg_userUPP)
{
	return InvokeEventHandlerUPP ((EventHandlerCallRef)ewg_inHandlerCallRef, (EventRef)ewg_inEvent, (void*)ewg_inUserData, (EventHandlerUPP)ewg_userUPP);
}

// Return address of function 'InvokeEventHandlerUPP'
void* ewg_get_function_address_InvokeEventHandlerUPP (void)
{
	return (void*) InvokeEventHandlerUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InstallEventHandler'
// For ise
OSStatus  ewg_function_InstallEventHandler (EventTargetRef ewg_inTarget, EventHandlerUPP ewg_inHandler, UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList, void *ewg_inUserData, EventHandlerRef *ewg_outRef)
{
	return InstallEventHandler ((EventTargetRef)ewg_inTarget, (EventHandlerUPP)ewg_inHandler, (UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList, (void*)ewg_inUserData, (EventHandlerRef*)ewg_outRef);
}

// Return address of function 'InstallEventHandler'
void* ewg_get_function_address_InstallEventHandler (void)
{
	return (void*) InstallEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InstallStandardEventHandler'
// For ise
OSStatus  ewg_function_InstallStandardEventHandler (EventTargetRef ewg_inTarget)
{
	return InstallStandardEventHandler ((EventTargetRef)ewg_inTarget);
}

// Return address of function 'InstallStandardEventHandler'
void* ewg_get_function_address_InstallStandardEventHandler (void)
{
	return (void*) InstallStandardEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveEventHandler'
// For ise
OSStatus  ewg_function_RemoveEventHandler (EventHandlerRef ewg_inHandlerRef)
{
	return RemoveEventHandler ((EventHandlerRef)ewg_inHandlerRef);
}

// Return address of function 'RemoveEventHandler'
void* ewg_get_function_address_RemoveEventHandler (void)
{
	return (void*) RemoveEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AddEventTypesToHandler'
// For ise
OSStatus  ewg_function_AddEventTypesToHandler (EventHandlerRef ewg_inHandlerRef, UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList)
{
	return AddEventTypesToHandler ((EventHandlerRef)ewg_inHandlerRef, (UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList);
}

// Return address of function 'AddEventTypesToHandler'
void* ewg_get_function_address_AddEventTypesToHandler (void)
{
	return (void*) AddEventTypesToHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveEventTypesFromHandler'
// For ise
OSStatus  ewg_function_RemoveEventTypesFromHandler (EventHandlerRef ewg_inHandlerRef, UInt32 ewg_inNumTypes, EventTypeSpec const *ewg_inList)
{
	return RemoveEventTypesFromHandler ((EventHandlerRef)ewg_inHandlerRef, (UInt32)ewg_inNumTypes, (EventTypeSpec const*)ewg_inList);
}

// Return address of function 'RemoveEventTypesFromHandler'
void* ewg_get_function_address_RemoveEventTypesFromHandler (void)
{
	return (void*) RemoveEventTypesFromHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CallNextEventHandler'
// For ise
OSStatus  ewg_function_CallNextEventHandler (EventHandlerCallRef ewg_inCallRef, EventRef ewg_inEvent)
{
	return CallNextEventHandler ((EventHandlerCallRef)ewg_inCallRef, (EventRef)ewg_inEvent);
}

// Return address of function 'CallNextEventHandler'
void* ewg_get_function_address_CallNextEventHandler (void)
{
	return (void*) CallNextEventHandler;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SendEventToEventTarget'
// For ise
OSStatus  ewg_function_SendEventToEventTarget (EventRef ewg_inEvent, EventTargetRef ewg_inTarget)
{
	return SendEventToEventTarget ((EventRef)ewg_inEvent, (EventTargetRef)ewg_inTarget);
}

// Return address of function 'SendEventToEventTarget'
void* ewg_get_function_address_SendEventToEventTarget (void)
{
	return (void*) SendEventToEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SendEventToEventTargetWithOptions'
// For ise
OSStatus  ewg_function_SendEventToEventTargetWithOptions (EventRef ewg_inEvent, EventTargetRef ewg_inTarget, OptionBits ewg_inOptions)
{
	return SendEventToEventTargetWithOptions ((EventRef)ewg_inEvent, (EventTargetRef)ewg_inTarget, (OptionBits)ewg_inOptions);
}

// Return address of function 'SendEventToEventTargetWithOptions'
void* ewg_get_function_address_SendEventToEventTargetWithOptions (void)
{
	return (void*) SendEventToEventTargetWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableSecureEventInput'
// For ise
OSStatus  ewg_function_EnableSecureEventInput (void)
{
	return EnableSecureEventInput ();
}

// Return address of function 'EnableSecureEventInput'
void* ewg_get_function_address_EnableSecureEventInput (void)
{
	return (void*) EnableSecureEventInput;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableSecureEventInput'
// For ise
OSStatus  ewg_function_DisableSecureEventInput (void)
{
	return DisableSecureEventInput ();
}

// Return address of function 'DisableSecureEventInput'
void* ewg_get_function_address_DisableSecureEventInput (void)
{
	return (void*) DisableSecureEventInput;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsSecureEventInputEnabled'
// For ise
Boolean  ewg_function_IsSecureEventInputEnabled (void)
{
	return IsSecureEventInputEnabled ();
}

// Return address of function 'IsSecureEventInputEnabled'
void* ewg_get_function_address_IsSecureEventInputEnabled (void)
{
	return (void*) IsSecureEventInputEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectRegisterSubclass'
// For ise
OSStatus  ewg_function_HIObjectRegisterSubclass (CFStringRef ewg_inClassID, CFStringRef ewg_inBaseClassID, OptionBits ewg_inOptions, EventHandlerUPP ewg_inConstructProc, UInt32 ewg_inNumEvents, EventTypeSpec const *ewg_inEventList, void *ewg_inConstructData, HIObjectClassRef *ewg_outClassRef)
{
	return HIObjectRegisterSubclass ((CFStringRef)ewg_inClassID, (CFStringRef)ewg_inBaseClassID, (OptionBits)ewg_inOptions, (EventHandlerUPP)ewg_inConstructProc, (UInt32)ewg_inNumEvents, (EventTypeSpec const*)ewg_inEventList, (void*)ewg_inConstructData, (HIObjectClassRef*)ewg_outClassRef);
}

// Return address of function 'HIObjectRegisterSubclass'
void* ewg_get_function_address_HIObjectRegisterSubclass (void)
{
	return (void*) HIObjectRegisterSubclass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectUnregisterClass'
// For ise
OSStatus  ewg_function_HIObjectUnregisterClass (HIObjectClassRef ewg_inClassRef)
{
	return HIObjectUnregisterClass ((HIObjectClassRef)ewg_inClassRef);
}

// Return address of function 'HIObjectUnregisterClass'
void* ewg_get_function_address_HIObjectUnregisterClass (void)
{
	return (void*) HIObjectUnregisterClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectCreate'
// For ise
OSStatus  ewg_function_HIObjectCreate (CFStringRef ewg_inClassID, EventRef ewg_inConstructData, HIObjectRef *ewg_outObject)
{
	return HIObjectCreate ((CFStringRef)ewg_inClassID, (EventRef)ewg_inConstructData, (HIObjectRef*)ewg_outObject);
}

// Return address of function 'HIObjectCreate'
void* ewg_get_function_address_HIObjectCreate (void)
{
	return (void*) HIObjectCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectGetEventTarget'
// For ise
EventTargetRef  ewg_function_HIObjectGetEventTarget (HIObjectRef ewg_inObject)
{
	return HIObjectGetEventTarget ((HIObjectRef)ewg_inObject);
}

// Return address of function 'HIObjectGetEventTarget'
void* ewg_get_function_address_HIObjectGetEventTarget (void)
{
	return (void*) HIObjectGetEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectPrintDebugInfo'
// For ise
void  ewg_function_HIObjectPrintDebugInfo (HIObjectRef ewg_inObject)
{
	HIObjectPrintDebugInfo ((HIObjectRef)ewg_inObject);
}

// Return address of function 'HIObjectPrintDebugInfo'
void* ewg_get_function_address_HIObjectPrintDebugInfo (void)
{
	return (void*) HIObjectPrintDebugInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectCopyClassID'
// For ise
CFStringRef  ewg_function_HIObjectCopyClassID (HIObjectRef ewg_inObject)
{
	return HIObjectCopyClassID ((HIObjectRef)ewg_inObject);
}

// Return address of function 'HIObjectCopyClassID'
void* ewg_get_function_address_HIObjectCopyClassID (void)
{
	return (void*) HIObjectCopyClassID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectIsOfClass'
// For ise
Boolean  ewg_function_HIObjectIsOfClass (HIObjectRef ewg_inObject, CFStringRef ewg_inObjectClassID)
{
	return HIObjectIsOfClass ((HIObjectRef)ewg_inObject, (CFStringRef)ewg_inObjectClassID);
}

// Return address of function 'HIObjectIsOfClass'
void* ewg_get_function_address_HIObjectIsOfClass (void)
{
	return (void*) HIObjectIsOfClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectDynamicCast'
// For ise
void * ewg_function_HIObjectDynamicCast (HIObjectRef ewg_inObject, CFStringRef ewg_inClassID)
{
	return HIObjectDynamicCast ((HIObjectRef)ewg_inObject, (CFStringRef)ewg_inClassID);
}

// Return address of function 'HIObjectDynamicCast'
void* ewg_get_function_address_HIObjectDynamicCast (void)
{
	return (void*) HIObjectDynamicCast;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectCreateFromBundle'
// For ise
OSStatus  ewg_function_HIObjectCreateFromBundle (CFBundleRef ewg_inBundle, HIObjectRef *ewg_outObject)
{
	return HIObjectCreateFromBundle ((CFBundleRef)ewg_inBundle, (HIObjectRef*)ewg_outObject);
}

// Return address of function 'HIObjectCreateFromBundle'
void* ewg_get_function_address_HIObjectCreateFromBundle (void)
{
	return (void*) HIObjectCreateFromBundle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectIsAccessibilityIgnored'
// For ise
Boolean  ewg_function_HIObjectIsAccessibilityIgnored (HIObjectRef ewg_inObject)
{
	return HIObjectIsAccessibilityIgnored ((HIObjectRef)ewg_inObject);
}

// Return address of function 'HIObjectIsAccessibilityIgnored'
void* ewg_get_function_address_HIObjectIsAccessibilityIgnored (void)
{
	return (void*) HIObjectIsAccessibilityIgnored;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectSetAccessibilityIgnored'
// For ise
OSStatus  ewg_function_HIObjectSetAccessibilityIgnored (HIObjectRef ewg_inObject, Boolean ewg_inIgnored)
{
	return HIObjectSetAccessibilityIgnored ((HIObjectRef)ewg_inObject, (Boolean)ewg_inIgnored);
}

// Return address of function 'HIObjectSetAccessibilityIgnored'
void* ewg_get_function_address_HIObjectSetAccessibilityIgnored (void)
{
	return (void*) HIObjectSetAccessibilityIgnored;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectSetAuxiliaryAccessibilityAttribute'
// For ise
OSStatus  ewg_function_HIObjectSetAuxiliaryAccessibilityAttribute (HIObjectRef ewg_inHIObject, UInt64 ewg_inIdentifier, CFStringRef ewg_inAttributeName, CFTypeRef ewg_inAttributeData)
{
	return HIObjectSetAuxiliaryAccessibilityAttribute ((HIObjectRef)ewg_inHIObject, (UInt64)ewg_inIdentifier, (CFStringRef)ewg_inAttributeName, (CFTypeRef)ewg_inAttributeData);
}

// Return address of function 'HIObjectSetAuxiliaryAccessibilityAttribute'
void* ewg_get_function_address_HIObjectSetAuxiliaryAccessibilityAttribute (void)
{
	return (void*) HIObjectSetAuxiliaryAccessibilityAttribute;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectOverrideAccessibilityContainment'
// For ise
OSStatus  ewg_function_HIObjectOverrideAccessibilityContainment (HIObjectRef ewg_inHIObject, AXUIElementRef ewg_inDesiredParent, AXUIElementRef ewg_inDesiredWindow, AXUIElementRef ewg_inDesiredTopLevelUIElement)
{
	return HIObjectOverrideAccessibilityContainment ((HIObjectRef)ewg_inHIObject, (AXUIElementRef)ewg_inDesiredParent, (AXUIElementRef)ewg_inDesiredWindow, (AXUIElementRef)ewg_inDesiredTopLevelUIElement);
}

// Return address of function 'HIObjectOverrideAccessibilityContainment'
void* ewg_get_function_address_HIObjectOverrideAccessibilityContainment (void)
{
	return (void*) HIObjectOverrideAccessibilityContainment;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectIsArchivingIgnored'
// For ise
Boolean  ewg_function_HIObjectIsArchivingIgnored (HIObjectRef ewg_inObject)
{
	return HIObjectIsArchivingIgnored ((HIObjectRef)ewg_inObject);
}

// Return address of function 'HIObjectIsArchivingIgnored'
void* ewg_get_function_address_HIObjectIsArchivingIgnored (void)
{
	return (void*) HIObjectIsArchivingIgnored;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectSetArchivingIgnored'
// For ise
OSStatus  ewg_function_HIObjectSetArchivingIgnored (HIObjectRef ewg_inObject, Boolean ewg_inIgnored)
{
	return HIObjectSetArchivingIgnored ((HIObjectRef)ewg_inObject, (Boolean)ewg_inIgnored);
}

// Return address of function 'HIObjectSetArchivingIgnored'
void* ewg_get_function_address_HIObjectSetArchivingIgnored (void)
{
	return (void*) HIObjectSetArchivingIgnored;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectCopyCustomArchiveData'
// For ise
OSStatus  ewg_function_HIObjectCopyCustomArchiveData (HIObjectRef ewg_inObject, CFDictionaryRef *ewg_outCustomData)
{
	return HIObjectCopyCustomArchiveData ((HIObjectRef)ewg_inObject, (CFDictionaryRef*)ewg_outCustomData);
}

// Return address of function 'HIObjectCopyCustomArchiveData'
void* ewg_get_function_address_HIObjectCopyCustomArchiveData (void)
{
	return (void*) HIObjectCopyCustomArchiveData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIObjectSetCustomArchiveData'
// For ise
OSStatus  ewg_function_HIObjectSetCustomArchiveData (HIObjectRef ewg_inObject, CFDictionaryRef ewg_inCustomData)
{
	return HIObjectSetCustomArchiveData ((HIObjectRef)ewg_inObject, (CFDictionaryRef)ewg_inCustomData);
}

// Return address of function 'HIObjectSetCustomArchiveData'
void* ewg_get_function_address_HIObjectSetCustomArchiveData (void)
{
	return (void*) HIObjectSetCustomArchiveData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIGetScaleFactor'
// For ise
float  ewg_function_HIGetScaleFactor (void)
{
	return HIGetScaleFactor ();
}

// Return address of function 'HIGetScaleFactor'
void* ewg_get_function_address_HIGetScaleFactor (void)
{
	return (void*) HIGetScaleFactor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIPointConvert'
// For ise
void  ewg_function_HIPointConvert (HIPoint *ewg_ioPoint, HICoordinateSpace ewg_inSourceSpace, void *ewg_inSourceObject, HICoordinateSpace ewg_inDestinationSpace, void *ewg_inDestinationObject)
{
	HIPointConvert ((HIPoint*)ewg_ioPoint, (HICoordinateSpace)ewg_inSourceSpace, (void*)ewg_inSourceObject, (HICoordinateSpace)ewg_inDestinationSpace, (void*)ewg_inDestinationObject);
}

// Return address of function 'HIPointConvert'
void* ewg_get_function_address_HIPointConvert (void)
{
	return (void*) HIPointConvert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIRectConvert'
// For ise
void  ewg_function_HIRectConvert (HIRect *ewg_ioRect, HICoordinateSpace ewg_inSourceSpace, void *ewg_inSourceObject, HICoordinateSpace ewg_inDestinationSpace, void *ewg_inDestinationObject)
{
	HIRectConvert ((HIRect*)ewg_ioRect, (HICoordinateSpace)ewg_inSourceSpace, (void*)ewg_inSourceObject, (HICoordinateSpace)ewg_inDestinationSpace, (void*)ewg_inDestinationObject);
}

// Return address of function 'HIRectConvert'
void* ewg_get_function_address_HIRectConvert (void)
{
	return (void*) HIRectConvert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISizeConvert'
// For ise
void  ewg_function_HISizeConvert (HISize *ewg_ioSize, HICoordinateSpace ewg_inSourceSpace, void *ewg_inSourceObject, HICoordinateSpace ewg_inDestinationSpace, void *ewg_inDestinationObject)
{
	HISizeConvert ((HISize*)ewg_ioSize, (HICoordinateSpace)ewg_inSourceSpace, (void*)ewg_inSourceObject, (HICoordinateSpace)ewg_inDestinationSpace, (void*)ewg_inDestinationObject);
}

// Return address of function 'HISizeConvert'
void* ewg_get_function_address_HISizeConvert (void)
{
	return (void*) HISizeConvert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMouse'
// For ise
void  ewg_function_GetMouse (Point *ewg_mouseLoc)
{
	GetMouse ((Point*)ewg_mouseLoc);
}

// Return address of function 'GetMouse'
void* ewg_get_function_address_GetMouse (void)
{
	return (void*) GetMouse;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'Button'
// For ise
Boolean  ewg_function_Button (void)
{
	return Button ();
}

// Return address of function 'Button'
void* ewg_get_function_address_Button (void)
{
	return (void*) Button;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'StillDown'
// For ise
Boolean  ewg_function_StillDown (void)
{
	return StillDown ();
}

// Return address of function 'StillDown'
void* ewg_get_function_address_StillDown (void)
{
	return (void*) StillDown;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'WaitMouseUp'
// For ise
Boolean  ewg_function_WaitMouseUp (void)
{
	return WaitMouseUp ();
}

// Return address of function 'WaitMouseUp'
void* ewg_get_function_address_WaitMouseUp (void)
{
	return (void*) WaitMouseUp;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'KeyTranslate'
// For ise
UInt32  ewg_function_KeyTranslate (void const *ewg_transData, UInt16 ewg_keycode, UInt32 *ewg_state)
{
	return KeyTranslate ((void const*)ewg_transData, (UInt16)ewg_keycode, (UInt32*)ewg_state);
}

// Return address of function 'KeyTranslate'
void* ewg_get_function_address_KeyTranslate (void)
{
	return (void*) KeyTranslate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCaretTime'
// For ise
UInt32  ewg_function_GetCaretTime (void)
{
	return GetCaretTime ();
}

// Return address of function 'GetCaretTime'
void* ewg_get_function_address_GetCaretTime (void)
{
	return (void*) GetCaretTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetKeys'
// For ise
void  ewg_function_GetKeys (void *ewg_theKeys)
{
	GetKeys (ewg_theKeys);
}

// Return address of function 'GetKeys'
void* ewg_get_function_address_GetKeys (void)
{
	return (void*) GetKeys;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDblTime'
// For ise
UInt32  ewg_function_GetDblTime (void)
{
	return GetDblTime ();
}

// Return address of function 'GetDblTime'
void* ewg_get_function_address_GetDblTime (void)
{
	return (void*) GetDblTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetEventMask'
// For ise
void  ewg_function_SetEventMask (EventMask ewg_value)
{
	SetEventMask ((EventMask)ewg_value);
}

// Return address of function 'SetEventMask'
void* ewg_get_function_address_SetEventMask (void)
{
	return (void*) SetEventMask;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNextEvent'
// For ise
Boolean  ewg_function_GetNextEvent (EventMask ewg_eventMask, EventRecord *ewg_theEvent)
{
	return GetNextEvent ((EventMask)ewg_eventMask, (EventRecord*)ewg_theEvent);
}

// Return address of function 'GetNextEvent'
void* ewg_get_function_address_GetNextEvent (void)
{
	return (void*) GetNextEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'WaitNextEvent'
// For ise
Boolean  ewg_function_WaitNextEvent (EventMask ewg_eventMask, EventRecord *ewg_theEvent, UInt32 ewg_sleep, RgnHandle ewg_mouseRgn)
{
	return WaitNextEvent ((EventMask)ewg_eventMask, (EventRecord*)ewg_theEvent, (UInt32)ewg_sleep, (RgnHandle)ewg_mouseRgn);
}

// Return address of function 'WaitNextEvent'
void* ewg_get_function_address_WaitNextEvent (void)
{
	return (void*) WaitNextEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EventAvail'
// For ise
Boolean  ewg_function_EventAvail (EventMask ewg_eventMask, EventRecord *ewg_theEvent)
{
	return EventAvail ((EventMask)ewg_eventMask, (EventRecord*)ewg_theEvent);
}

// Return address of function 'EventAvail'
void* ewg_get_function_address_EventAvail (void)
{
	return (void*) EventAvail;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PostEvent'
// For ise
OSErr  ewg_function_PostEvent (EventKind ewg_eventNum, UInt32 ewg_eventMsg)
{
	return PostEvent ((EventKind)ewg_eventNum, (UInt32)ewg_eventMsg);
}

// Return address of function 'PostEvent'
void* ewg_get_function_address_PostEvent (void)
{
	return (void*) PostEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FlushEvents'
// For ise
void  ewg_function_FlushEvents (EventMask ewg_whichMask, EventMask ewg_stopMask)
{
	FlushEvents ((EventMask)ewg_whichMask, (EventMask)ewg_stopMask);
}

// Return address of function 'FlushEvents'
void* ewg_get_function_address_FlushEvents (void)
{
	return (void*) FlushEvents;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetGlobalMouse'
// For ise
void  ewg_function_GetGlobalMouse (Point *ewg_globalMouse)
{
	GetGlobalMouse ((Point*)ewg_globalMouse);
}

// Return address of function 'GetGlobalMouse'
void* ewg_get_function_address_GetGlobalMouse (void)
{
	return (void*) GetGlobalMouse;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetCurrentKeyModifiers'
// For ise
UInt32  ewg_function_GetCurrentKeyModifiers (void)
{
	return GetCurrentKeyModifiers ();
}

// Return address of function 'GetCurrentKeyModifiers'
void* ewg_get_function_address_GetCurrentKeyModifiers (void)
{
	return (void*) GetCurrentKeyModifiers;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CheckEventQueueForUserCancel'
// For ise
Boolean  ewg_function_CheckEventQueueForUserCancel (void)
{
	return CheckEventQueueForUserCancel ();
}

// Return address of function 'CheckEventQueueForUserCancel'
void* ewg_get_function_address_CheckEventQueueForUserCancel (void)
{
	return (void*) CheckEventQueueForUserCancel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'KeyScript'
// For ise
void  ewg_function_KeyScript (short ewg_code)
{
	KeyScript ((short)ewg_code);
}

// Return address of function 'KeyScript'
void* ewg_get_function_address_KeyScript (void)
{
	return (void*) KeyScript;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsCmdChar'
// For ise
Boolean  ewg_function_IsCmdChar (EventRecord const *ewg_event, short ewg_test)
{
	return IsCmdChar ((EventRecord const*)ewg_event, (short)ewg_test);
}

// Return address of function 'IsCmdChar'
void* ewg_get_function_address_IsCmdChar (void)
{
	return (void*) IsCmdChar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMGetKeyThresh'
// For ise
SInt16  ewg_function_LMGetKeyThresh (void)
{
	return LMGetKeyThresh ();
}

// Return address of function 'LMGetKeyThresh'
void* ewg_get_function_address_LMGetKeyThresh (void)
{
	return (void*) LMGetKeyThresh;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMSetKeyThresh'
// For ise
void  ewg_function_LMSetKeyThresh (SInt16 ewg_value)
{
	LMSetKeyThresh ((SInt16)ewg_value);
}

// Return address of function 'LMSetKeyThresh'
void* ewg_get_function_address_LMSetKeyThresh (void)
{
	return (void*) LMSetKeyThresh;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMGetKeyRepThresh'
// For ise
SInt16  ewg_function_LMGetKeyRepThresh (void)
{
	return LMGetKeyRepThresh ();
}

// Return address of function 'LMGetKeyRepThresh'
void* ewg_get_function_address_LMGetKeyRepThresh (void)
{
	return (void*) LMGetKeyRepThresh;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMSetKeyRepThresh'
// For ise
void  ewg_function_LMSetKeyRepThresh (SInt16 ewg_value)
{
	LMSetKeyRepThresh ((SInt16)ewg_value);
}

// Return address of function 'LMSetKeyRepThresh'
void* ewg_get_function_address_LMSetKeyRepThresh (void)
{
	return (void*) LMSetKeyRepThresh;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMGetKbdLast'
// For ise
UInt8  ewg_function_LMGetKbdLast (void)
{
	return LMGetKbdLast ();
}

// Return address of function 'LMGetKbdLast'
void* ewg_get_function_address_LMGetKbdLast (void)
{
	return (void*) LMGetKbdLast;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMSetKbdLast'
// For ise
void  ewg_function_LMSetKbdLast (UInt8 ewg_value)
{
	LMSetKbdLast ((UInt8)ewg_value);
}

// Return address of function 'LMSetKbdLast'
void* ewg_get_function_address_LMSetKbdLast (void)
{
	return (void*) LMSetKbdLast;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMGetKbdType'
// For ise
UInt8  ewg_function_LMGetKbdType (void)
{
	return LMGetKbdType ();
}

// Return address of function 'LMGetKbdType'
void* ewg_get_function_address_LMGetKbdType (void)
{
	return (void*) LMGetKbdType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMSetKbdType'
// For ise
void  ewg_function_LMSetKbdType (UInt8 ewg_value)
{
	LMSetKbdType ((UInt8)ewg_value);
}

// Return address of function 'LMSetKbdType'
void* ewg_get_function_address_LMSetKbdType (void)
{
	return (void*) LMSetKbdType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewMenuDefUPP'
// For ise
MenuDefUPP  ewg_function_NewMenuDefUPP (MenuDefProcPtr ewg_userRoutine)
{
	return NewMenuDefUPP ((MenuDefProcPtr)ewg_userRoutine);
}

// Return address of function 'NewMenuDefUPP'
void* ewg_get_function_address_NewMenuDefUPP (void)
{
	return (void*) NewMenuDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeMenuDefUPP'
// For ise
void  ewg_function_DisposeMenuDefUPP (MenuDefUPP ewg_userUPP)
{
	DisposeMenuDefUPP ((MenuDefUPP)ewg_userUPP);
}

// Return address of function 'DisposeMenuDefUPP'
void* ewg_get_function_address_DisposeMenuDefUPP (void)
{
	return (void*) DisposeMenuDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeMenuDefUPP'
// For ise
void  ewg_function_InvokeMenuDefUPP (short ewg_message, MenuRef ewg_theMenu, Rect *ewg_menuRect, Point *ewg_hitPt, short *ewg_whichItem, MenuDefUPP ewg_userUPP)
{
	InvokeMenuDefUPP ((short)ewg_message, (MenuRef)ewg_theMenu, (Rect*)ewg_menuRect, *(Point*)ewg_hitPt, (short*)ewg_whichItem, (MenuDefUPP)ewg_userUPP);
}

// Return address of function 'InvokeMenuDefUPP'
void* ewg_get_function_address_InvokeMenuDefUPP (void)
{
	return (void*) InvokeMenuDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewMenu'
// For ise
MenuRef  ewg_function_NewMenu (MenuID ewg_menuID, ConstStr255Param ewg_menuTitle)
{
	return NewMenu ((MenuID)ewg_menuID, (ConstStr255Param)ewg_menuTitle);
}

// Return address of function 'NewMenu'
void* ewg_get_function_address_NewMenu (void)
{
	return (void*) NewMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenu'
// For ise
MenuRef  ewg_function_GetMenu (short ewg_resourceID)
{
	return GetMenu ((short)ewg_resourceID);
}

// Return address of function 'GetMenu'
void* ewg_get_function_address_GetMenu (void)
{
	return (void*) GetMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeMenu'
// For ise
void  ewg_function_DisposeMenu (MenuRef ewg_theMenu)
{
	DisposeMenu ((MenuRef)ewg_theMenu);
}

// Return address of function 'DisposeMenu'
void* ewg_get_function_address_DisposeMenu (void)
{
	return (void*) DisposeMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CalcMenuSize'
// For ise
void  ewg_function_CalcMenuSize (MenuRef ewg_theMenu)
{
	CalcMenuSize ((MenuRef)ewg_theMenu);
}

// Return address of function 'CalcMenuSize'
void* ewg_get_function_address_CalcMenuSize (void)
{
	return (void*) CalcMenuSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CountMenuItems'
// For ise
UInt16  ewg_function_CountMenuItems (MenuRef ewg_theMenu)
{
	return CountMenuItems ((MenuRef)ewg_theMenu);
}

// Return address of function 'CountMenuItems'
void* ewg_get_function_address_CountMenuItems (void)
{
	return (void*) CountMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuFont'
// For ise
OSStatus  ewg_function_GetMenuFont (MenuRef ewg_menu, SInt16 *ewg_outFontID, UInt16 *ewg_outFontSize)
{
	return GetMenuFont ((MenuRef)ewg_menu, (SInt16*)ewg_outFontID, (UInt16*)ewg_outFontSize);
}

// Return address of function 'GetMenuFont'
void* ewg_get_function_address_GetMenuFont (void)
{
	return (void*) GetMenuFont;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuFont'
// For ise
OSStatus  ewg_function_SetMenuFont (MenuRef ewg_menu, SInt16 ewg_inFontID, UInt16 ewg_inFontSize)
{
	return SetMenuFont ((MenuRef)ewg_menu, (SInt16)ewg_inFontID, (UInt16)ewg_inFontSize);
}

// Return address of function 'SetMenuFont'
void* ewg_get_function_address_SetMenuFont (void)
{
	return (void*) SetMenuFont;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuExcludesMarkColumn'
// For ise
Boolean  ewg_function_GetMenuExcludesMarkColumn (MenuRef ewg_menu)
{
	return GetMenuExcludesMarkColumn ((MenuRef)ewg_menu);
}

// Return address of function 'GetMenuExcludesMarkColumn'
void* ewg_get_function_address_GetMenuExcludesMarkColumn (void)
{
	return (void*) GetMenuExcludesMarkColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuExcludesMarkColumn'
// For ise
OSStatus  ewg_function_SetMenuExcludesMarkColumn (MenuRef ewg_menu, Boolean ewg_excludesMark)
{
	return SetMenuExcludesMarkColumn ((MenuRef)ewg_menu, (Boolean)ewg_excludesMark);
}

// Return address of function 'SetMenuExcludesMarkColumn'
void* ewg_get_function_address_SetMenuExcludesMarkColumn (void)
{
	return (void*) SetMenuExcludesMarkColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RegisterMenuDefinition'
// For ise
OSStatus  ewg_function_RegisterMenuDefinition (SInt16 ewg_inResID, MenuDefSpecPtr ewg_inDefSpec)
{
	return RegisterMenuDefinition ((SInt16)ewg_inResID, (MenuDefSpecPtr)ewg_inDefSpec);
}

// Return address of function 'RegisterMenuDefinition'
void* ewg_get_function_address_RegisterMenuDefinition (void)
{
	return (void*) RegisterMenuDefinition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateNewMenu'
// For ise
OSStatus  ewg_function_CreateNewMenu (MenuID ewg_inMenuID, MenuAttributes ewg_inMenuAttributes, MenuRef *ewg_outMenuRef)
{
	return CreateNewMenu ((MenuID)ewg_inMenuID, (MenuAttributes)ewg_inMenuAttributes, (MenuRef*)ewg_outMenuRef);
}

// Return address of function 'CreateNewMenu'
void* ewg_get_function_address_CreateNewMenu (void)
{
	return (void*) CreateNewMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateCustomMenu'
// For ise
OSStatus  ewg_function_CreateCustomMenu (MenuDefSpec const *ewg_inDefSpec, MenuID ewg_inMenuID, MenuAttributes ewg_inMenuAttributes, MenuRef *ewg_outMenuRef)
{
	return CreateCustomMenu ((MenuDefSpec const*)ewg_inDefSpec, (MenuID)ewg_inMenuID, (MenuAttributes)ewg_inMenuAttributes, (MenuRef*)ewg_outMenuRef);
}

// Return address of function 'CreateCustomMenu'
void* ewg_get_function_address_CreateCustomMenu (void)
{
	return (void*) CreateCustomMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsValidMenu'
// For ise
Boolean  ewg_function_IsValidMenu (MenuRef ewg_inMenu)
{
	return IsValidMenu ((MenuRef)ewg_inMenu);
}

// Return address of function 'IsValidMenu'
void* ewg_get_function_address_IsValidMenu (void)
{
	return (void*) IsValidMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuRetainCount'
// For ise
ItemCount  ewg_function_GetMenuRetainCount (MenuRef ewg_inMenu)
{
	return GetMenuRetainCount ((MenuRef)ewg_inMenu);
}

// Return address of function 'GetMenuRetainCount'
void* ewg_get_function_address_GetMenuRetainCount (void)
{
	return (void*) GetMenuRetainCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RetainMenu'
// For ise
OSStatus  ewg_function_RetainMenu (MenuRef ewg_inMenu)
{
	return RetainMenu ((MenuRef)ewg_inMenu);
}

// Return address of function 'RetainMenu'
void* ewg_get_function_address_RetainMenu (void)
{
	return (void*) RetainMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseMenu'
// For ise
OSStatus  ewg_function_ReleaseMenu (MenuRef ewg_inMenu)
{
	return ReleaseMenu ((MenuRef)ewg_inMenu);
}

// Return address of function 'ReleaseMenu'
void* ewg_get_function_address_ReleaseMenu (void)
{
	return (void*) ReleaseMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DuplicateMenu'
// For ise
OSStatus  ewg_function_DuplicateMenu (MenuRef ewg_inSourceMenu, MenuRef *ewg_outMenu)
{
	return DuplicateMenu ((MenuRef)ewg_inSourceMenu, (MenuRef*)ewg_outMenu);
}

// Return address of function 'DuplicateMenu'
void* ewg_get_function_address_DuplicateMenu (void)
{
	return (void*) DuplicateMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyMenuTitleAsCFString'
// For ise
OSStatus  ewg_function_CopyMenuTitleAsCFString (MenuRef ewg_inMenu, CFStringRef *ewg_outString)
{
	return CopyMenuTitleAsCFString ((MenuRef)ewg_inMenu, (CFStringRef*)ewg_outString);
}

// Return address of function 'CopyMenuTitleAsCFString'
void* ewg_get_function_address_CopyMenuTitleAsCFString (void)
{
	return (void*) CopyMenuTitleAsCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuTitleWithCFString'
// For ise
OSStatus  ewg_function_SetMenuTitleWithCFString (MenuRef ewg_inMenu, CFStringRef ewg_inString)
{
	return SetMenuTitleWithCFString ((MenuRef)ewg_inMenu, (CFStringRef)ewg_inString);
}

// Return address of function 'SetMenuTitleWithCFString'
void* ewg_get_function_address_SetMenuTitleWithCFString (void)
{
	return (void*) SetMenuTitleWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuTitleIcon'
// For ise
OSStatus  ewg_function_SetMenuTitleIcon (MenuRef ewg_inMenu, UInt32 ewg_inType, void *ewg_inIcon)
{
	return SetMenuTitleIcon ((MenuRef)ewg_inMenu, (UInt32)ewg_inType, (void*)ewg_inIcon);
}

// Return address of function 'SetMenuTitleIcon'
void* ewg_get_function_address_SetMenuTitleIcon (void)
{
	return (void*) SetMenuTitleIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuTitleIcon'
// For ise
OSStatus  ewg_function_GetMenuTitleIcon (MenuRef ewg_inMenu, UInt32 *ewg_outType, void **ewg_outIcon)
{
	return GetMenuTitleIcon ((MenuRef)ewg_inMenu, (UInt32*)ewg_outType, (void**)ewg_outIcon);
}

// Return address of function 'GetMenuTitleIcon'
void* ewg_get_function_address_GetMenuTitleIcon (void)
{
	return (void*) GetMenuTitleIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalidateMenuSize'
// For ise
OSStatus  ewg_function_InvalidateMenuSize (MenuRef ewg_inMenu)
{
	return InvalidateMenuSize ((MenuRef)ewg_inMenu);
}

// Return address of function 'InvalidateMenuSize'
void* ewg_get_function_address_InvalidateMenuSize (void)
{
	return (void*) InvalidateMenuSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuSizeInvalid'
// For ise
Boolean  ewg_function_IsMenuSizeInvalid (MenuRef ewg_inMenu)
{
	return IsMenuSizeInvalid ((MenuRef)ewg_inMenu);
}

// Return address of function 'IsMenuSizeInvalid'
void* ewg_get_function_address_IsMenuSizeInvalid (void)
{
	return (void*) IsMenuSizeInvalid;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EraseMenuBackground'
// For ise
OSStatus  ewg_function_EraseMenuBackground (MenuRef ewg_inMenu, Rect const *ewg_inEraseRect, CGContextRef ewg_inContext)
{
	return EraseMenuBackground ((MenuRef)ewg_inMenu, (Rect const*)ewg_inEraseRect, (CGContextRef)ewg_inContext);
}

// Return address of function 'EraseMenuBackground'
void* ewg_get_function_address_EraseMenuBackground (void)
{
	return (void*) EraseMenuBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ScrollMenuImage'
// For ise
OSStatus  ewg_function_ScrollMenuImage (MenuRef ewg_inMenu, Rect const *ewg_inScrollRect, int ewg_inHScroll, int ewg_inVScroll, CGContextRef ewg_inContext)
{
	return ScrollMenuImage ((MenuRef)ewg_inMenu, (Rect const*)ewg_inScrollRect, (int)ewg_inHScroll, (int)ewg_inVScroll, (CGContextRef)ewg_inContext);
}

// Return address of function 'ScrollMenuImage'
void* ewg_get_function_address_ScrollMenuImage (void)
{
	return (void*) ScrollMenuImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AppendMenu'
// For ise
void  ewg_function_AppendMenu (MenuRef ewg_menu, ConstStr255Param ewg_data)
{
	AppendMenu ((MenuRef)ewg_menu, (ConstStr255Param)ewg_data);
}

// Return address of function 'AppendMenu'
void* ewg_get_function_address_AppendMenu (void)
{
	return (void*) AppendMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertResMenu'
// For ise
void  ewg_function_InsertResMenu (MenuRef ewg_theMenu, ResType ewg_theType, MenuItemIndex ewg_afterItem)
{
	InsertResMenu ((MenuRef)ewg_theMenu, (ResType)ewg_theType, (MenuItemIndex)ewg_afterItem);
}

// Return address of function 'InsertResMenu'
void* ewg_get_function_address_InsertResMenu (void)
{
	return (void*) InsertResMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AppendResMenu'
// For ise
void  ewg_function_AppendResMenu (MenuRef ewg_theMenu, ResType ewg_theType)
{
	AppendResMenu ((MenuRef)ewg_theMenu, (ResType)ewg_theType);
}

// Return address of function 'AppendResMenu'
void* ewg_get_function_address_AppendResMenu (void)
{
	return (void*) AppendResMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertMenuItem'
// For ise
void  ewg_function_InsertMenuItem (MenuRef ewg_theMenu, ConstStr255Param ewg_itemString, MenuItemIndex ewg_afterItem)
{
	InsertMenuItem ((MenuRef)ewg_theMenu, (ConstStr255Param)ewg_itemString, (MenuItemIndex)ewg_afterItem);
}

// Return address of function 'InsertMenuItem'
void* ewg_get_function_address_InsertMenuItem (void)
{
	return (void*) InsertMenuItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DeleteMenuItem'
// For ise
void  ewg_function_DeleteMenuItem (MenuRef ewg_theMenu, MenuItemIndex ewg_item)
{
	DeleteMenuItem ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item);
}

// Return address of function 'DeleteMenuItem'
void* ewg_get_function_address_DeleteMenuItem (void)
{
	return (void*) DeleteMenuItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertFontResMenu'
// For ise
void  ewg_function_InsertFontResMenu (MenuRef ewg_theMenu, MenuItemIndex ewg_afterItem, short ewg_scriptFilter)
{
	InsertFontResMenu ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_afterItem, (short)ewg_scriptFilter);
}

// Return address of function 'InsertFontResMenu'
void* ewg_get_function_address_InsertFontResMenu (void)
{
	return (void*) InsertFontResMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertIntlResMenu'
// For ise
void  ewg_function_InsertIntlResMenu (MenuRef ewg_theMenu, ResType ewg_theType, MenuItemIndex ewg_afterItem, short ewg_scriptFilter)
{
	InsertIntlResMenu ((MenuRef)ewg_theMenu, (ResType)ewg_theType, (MenuItemIndex)ewg_afterItem, (short)ewg_scriptFilter);
}

// Return address of function 'InsertIntlResMenu'
void* ewg_get_function_address_InsertIntlResMenu (void)
{
	return (void*) InsertIntlResMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AppendMenuItemText'
// For ise
OSStatus  ewg_function_AppendMenuItemText (MenuRef ewg_menu, ConstStr255Param ewg_inString)
{
	return AppendMenuItemText ((MenuRef)ewg_menu, (ConstStr255Param)ewg_inString);
}

// Return address of function 'AppendMenuItemText'
void* ewg_get_function_address_AppendMenuItemText (void)
{
	return (void*) AppendMenuItemText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertMenuItemText'
// For ise
OSStatus  ewg_function_InsertMenuItemText (MenuRef ewg_menu, ConstStr255Param ewg_inString, MenuItemIndex ewg_afterItem)
{
	return InsertMenuItemText ((MenuRef)ewg_menu, (ConstStr255Param)ewg_inString, (MenuItemIndex)ewg_afterItem);
}

// Return address of function 'InsertMenuItemText'
void* ewg_get_function_address_InsertMenuItemText (void)
{
	return (void*) InsertMenuItemText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyMenuItems'
// For ise
OSStatus  ewg_function_CopyMenuItems (MenuRef ewg_inSourceMenu, MenuItemIndex ewg_inFirstItem, ItemCount ewg_inNumItems, MenuRef ewg_inDestMenu, MenuItemIndex ewg_inInsertAfter)
{
	return CopyMenuItems ((MenuRef)ewg_inSourceMenu, (MenuItemIndex)ewg_inFirstItem, (ItemCount)ewg_inNumItems, (MenuRef)ewg_inDestMenu, (MenuItemIndex)ewg_inInsertAfter);
}

// Return address of function 'CopyMenuItems'
void* ewg_get_function_address_CopyMenuItems (void)
{
	return (void*) CopyMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DeleteMenuItems'
// For ise
OSStatus  ewg_function_DeleteMenuItems (MenuRef ewg_inMenu, MenuItemIndex ewg_inFirstItem, ItemCount ewg_inNumItems)
{
	return DeleteMenuItems ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inFirstItem, (ItemCount)ewg_inNumItems);
}

// Return address of function 'DeleteMenuItems'
void* ewg_get_function_address_DeleteMenuItems (void)
{
	return (void*) DeleteMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AppendMenuItemTextWithCFString'
// For ise
OSStatus  ewg_function_AppendMenuItemTextWithCFString (MenuRef ewg_inMenu, CFStringRef ewg_inString, MenuItemAttributes ewg_inAttributes, MenuCommand ewg_inCommandID, MenuItemIndex *ewg_outNewItem)
{
	return AppendMenuItemTextWithCFString ((MenuRef)ewg_inMenu, (CFStringRef)ewg_inString, (MenuItemAttributes)ewg_inAttributes, (MenuCommand)ewg_inCommandID, (MenuItemIndex*)ewg_outNewItem);
}

// Return address of function 'AppendMenuItemTextWithCFString'
void* ewg_get_function_address_AppendMenuItemTextWithCFString (void)
{
	return (void*) AppendMenuItemTextWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertMenuItemTextWithCFString'
// For ise
OSStatus  ewg_function_InsertMenuItemTextWithCFString (MenuRef ewg_inMenu, CFStringRef ewg_inString, MenuItemIndex ewg_inAfterItem, MenuItemAttributes ewg_inAttributes, MenuCommand ewg_inCommandID)
{
	return InsertMenuItemTextWithCFString ((MenuRef)ewg_inMenu, (CFStringRef)ewg_inString, (MenuItemIndex)ewg_inAfterItem, (MenuItemAttributes)ewg_inAttributes, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'InsertMenuItemTextWithCFString'
void* ewg_get_function_address_InsertMenuItemTextWithCFString (void)
{
	return (void*) InsertMenuItemTextWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MenuKey'
// For ise
long  ewg_function_MenuKey (CharParameter ewg_ch)
{
	return MenuKey ((CharParameter)ewg_ch);
}

// Return address of function 'MenuKey'
void* ewg_get_function_address_MenuKey (void)
{
	return (void*) MenuKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MenuSelect'
// For ise
long  ewg_function_MenuSelect (Point *ewg_startPt)
{
	return MenuSelect (*(Point*)ewg_startPt);
}

// Return address of function 'MenuSelect'
void* ewg_get_function_address_MenuSelect (void)
{
	return (void*) MenuSelect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PopUpMenuSelect'
// For ise
long  ewg_function_PopUpMenuSelect (MenuRef ewg_menu, short ewg_top, short ewg_left, MenuItemIndex ewg_popUpItem)
{
	return PopUpMenuSelect ((MenuRef)ewg_menu, (short)ewg_top, (short)ewg_left, (MenuItemIndex)ewg_popUpItem);
}

// Return address of function 'PopUpMenuSelect'
void* ewg_get_function_address_PopUpMenuSelect (void)
{
	return (void*) PopUpMenuSelect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MenuChoice'
// For ise
long  ewg_function_MenuChoice (void)
{
	return MenuChoice ();
}

// Return address of function 'MenuChoice'
void* ewg_get_function_address_MenuChoice (void)
{
	return (void*) MenuChoice;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MenuEvent'
// For ise
UInt32  ewg_function_MenuEvent (EventRecord const *ewg_inEvent)
{
	return MenuEvent ((EventRecord const*)ewg_inEvent);
}

// Return address of function 'MenuEvent'
void* ewg_get_function_address_MenuEvent (void)
{
	return (void*) MenuEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuKeyEvent'
// For ise
Boolean  ewg_function_IsMenuKeyEvent (MenuRef ewg_inStartMenu, EventRef ewg_inEvent, MenuEventOptions ewg_inOptions, MenuRef *ewg_outMenu, MenuItemIndex *ewg_outMenuItem)
{
	return IsMenuKeyEvent ((MenuRef)ewg_inStartMenu, (EventRef)ewg_inEvent, (MenuEventOptions)ewg_inOptions, (MenuRef*)ewg_outMenu, (MenuItemIndex*)ewg_outMenuItem);
}

// Return address of function 'IsMenuKeyEvent'
void* ewg_get_function_address_IsMenuKeyEvent (void)
{
	return (void*) IsMenuKeyEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalidateMenuEnabling'
// For ise
OSStatus  ewg_function_InvalidateMenuEnabling (MenuRef ewg_inMenu)
{
	return InvalidateMenuEnabling ((MenuRef)ewg_inMenu);
}

// Return address of function 'InvalidateMenuEnabling'
void* ewg_get_function_address_InvalidateMenuEnabling (void)
{
	return (void*) InvalidateMenuEnabling;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CancelMenuTracking'
// For ise
OSStatus  ewg_function_CancelMenuTracking (MenuRef ewg_inRootMenu, Boolean ewg_inImmediate, UInt32 ewg_inDismissalReason)
{
	return CancelMenuTracking ((MenuRef)ewg_inRootMenu, (Boolean)ewg_inImmediate, (UInt32)ewg_inDismissalReason);
}

// Return address of function 'CancelMenuTracking'
void* ewg_get_function_address_CancelMenuTracking (void)
{
	return (void*) CancelMenuTracking;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMBarHeight'
// For ise
short  ewg_function_GetMBarHeight (void)
{
	return GetMBarHeight ();
}

// Return address of function 'GetMBarHeight'
void* ewg_get_function_address_GetMBarHeight (void)
{
	return (void*) GetMBarHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DrawMenuBar'
// For ise
void  ewg_function_DrawMenuBar (void)
{
	DrawMenuBar ();
}

// Return address of function 'DrawMenuBar'
void* ewg_get_function_address_DrawMenuBar (void)
{
	return (void*) DrawMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalMenuBar'
// For ise
void  ewg_function_InvalMenuBar (void)
{
	InvalMenuBar ();
}

// Return address of function 'InvalMenuBar'
void* ewg_get_function_address_InvalMenuBar (void)
{
	return (void*) InvalMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuBarInvalid'
// For ise
Boolean  ewg_function_IsMenuBarInvalid (MenuRef ewg_rootMenu)
{
	return IsMenuBarInvalid ((MenuRef)ewg_rootMenu);
}

// Return address of function 'IsMenuBarInvalid'
void* ewg_get_function_address_IsMenuBarInvalid (void)
{
	return (void*) IsMenuBarInvalid;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HiliteMenu'
// For ise
void  ewg_function_HiliteMenu (MenuID ewg_menuID)
{
	HiliteMenu ((MenuID)ewg_menuID);
}

// Return address of function 'HiliteMenu'
void* ewg_get_function_address_HiliteMenu (void)
{
	return (void*) HiliteMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNewMBar'
// For ise
MenuBarHandle  ewg_function_GetNewMBar (short ewg_menuBarID)
{
	return GetNewMBar ((short)ewg_menuBarID);
}

// Return address of function 'GetNewMBar'
void* ewg_get_function_address_GetNewMBar (void)
{
	return (void*) GetNewMBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuBar'
// For ise
MenuBarHandle  ewg_function_GetMenuBar (void)
{
	return GetMenuBar ();
}

// Return address of function 'GetMenuBar'
void* ewg_get_function_address_GetMenuBar (void)
{
	return (void*) GetMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuBar'
// For ise
void  ewg_function_SetMenuBar (MenuBarHandle ewg_mbar)
{
	SetMenuBar ((MenuBarHandle)ewg_mbar);
}

// Return address of function 'SetMenuBar'
void* ewg_get_function_address_SetMenuBar (void)
{
	return (void*) SetMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DuplicateMenuBar'
// For ise
OSStatus  ewg_function_DuplicateMenuBar (MenuBarHandle ewg_inMbar, MenuBarHandle *ewg_outMbar)
{
	return DuplicateMenuBar ((MenuBarHandle)ewg_inMbar, (MenuBarHandle*)ewg_outMbar);
}

// Return address of function 'DuplicateMenuBar'
void* ewg_get_function_address_DuplicateMenuBar (void)
{
	return (void*) DuplicateMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeMenuBar'
// For ise
OSStatus  ewg_function_DisposeMenuBar (MenuBarHandle ewg_inMbar)
{
	return DisposeMenuBar ((MenuBarHandle)ewg_inMbar);
}

// Return address of function 'DisposeMenuBar'
void* ewg_get_function_address_DisposeMenuBar (void)
{
	return (void*) DisposeMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuHandle'
// For ise
MenuRef  ewg_function_GetMenuHandle (MenuID ewg_menuID)
{
	return GetMenuHandle ((MenuID)ewg_menuID);
}

// Return address of function 'GetMenuHandle'
void* ewg_get_function_address_GetMenuHandle (void)
{
	return (void*) GetMenuHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InsertMenu'
// For ise
void  ewg_function_InsertMenu (MenuRef ewg_theMenu, MenuID ewg_beforeID)
{
	InsertMenu ((MenuRef)ewg_theMenu, (MenuID)ewg_beforeID);
}

// Return address of function 'InsertMenu'
void* ewg_get_function_address_InsertMenu (void)
{
	return (void*) InsertMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DeleteMenu'
// For ise
void  ewg_function_DeleteMenu (MenuID ewg_menuID)
{
	DeleteMenu ((MenuID)ewg_menuID);
}

// Return address of function 'DeleteMenu'
void* ewg_get_function_address_DeleteMenu (void)
{
	return (void*) DeleteMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ClearMenuBar'
// For ise
void  ewg_function_ClearMenuBar (void)
{
	ClearMenuBar ();
}

// Return address of function 'ClearMenuBar'
void* ewg_get_function_address_ClearMenuBar (void)
{
	return (void*) ClearMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuFlashCount'
// For ise
void  ewg_function_SetMenuFlashCount (short ewg_count)
{
	SetMenuFlashCount ((short)ewg_count);
}

// Return address of function 'SetMenuFlashCount'
void* ewg_get_function_address_SetMenuFlashCount (void)
{
	return (void*) SetMenuFlashCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FlashMenuBar'
// For ise
void  ewg_function_FlashMenuBar (MenuID ewg_menuID)
{
	FlashMenuBar ((MenuID)ewg_menuID);
}

// Return address of function 'FlashMenuBar'
void* ewg_get_function_address_FlashMenuBar (void)
{
	return (void*) FlashMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuBarVisible'
// For ise
Boolean  ewg_function_IsMenuBarVisible (void)
{
	return IsMenuBarVisible ();
}

// Return address of function 'IsMenuBarVisible'
void* ewg_get_function_address_IsMenuBarVisible (void)
{
	return (void*) IsMenuBarVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowMenuBar'
// For ise
void  ewg_function_ShowMenuBar (void)
{
	ShowMenuBar ();
}

// Return address of function 'ShowMenuBar'
void* ewg_get_function_address_ShowMenuBar (void)
{
	return (void*) ShowMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HideMenuBar'
// For ise
void  ewg_function_HideMenuBar (void)
{
	HideMenuBar ();
}

// Return address of function 'HideMenuBar'
void* ewg_get_function_address_HideMenuBar (void)
{
	return (void*) HideMenuBar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AcquireRootMenu'
// For ise
MenuRef  ewg_function_AcquireRootMenu (void)
{
	return AcquireRootMenu ();
}

// Return address of function 'AcquireRootMenu'
void* ewg_get_function_address_AcquireRootMenu (void)
{
	return (void*) AcquireRootMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetRootMenu'
// For ise
OSStatus  ewg_function_SetRootMenu (MenuRef ewg_inMenu)
{
	return SetRootMenu ((MenuRef)ewg_inMenu);
}

// Return address of function 'SetRootMenu'
void* ewg_get_function_address_SetRootMenu (void)
{
	return (void*) SetRootMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CheckMenuItem'
// For ise
void  ewg_function_CheckMenuItem (MenuRef ewg_theMenu, MenuItemIndex ewg_item, Boolean ewg_checked)
{
	CheckMenuItem ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (Boolean)ewg_checked);
}

// Return address of function 'CheckMenuItem'
void* ewg_get_function_address_CheckMenuItem (void)
{
	return (void*) CheckMenuItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemText'
// For ise
void  ewg_function_SetMenuItemText (MenuRef ewg_theMenu, MenuItemIndex ewg_item, ConstStr255Param ewg_itemString)
{
	SetMenuItemText ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (ConstStr255Param)ewg_itemString);
}

// Return address of function 'SetMenuItemText'
void* ewg_get_function_address_SetMenuItemText (void)
{
	return (void*) SetMenuItemText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemText'
// For ise
void  ewg_function_GetMenuItemText (MenuRef ewg_theMenu, MenuItemIndex ewg_item, void *ewg_itemString)
{
	GetMenuItemText ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, ewg_itemString);
}

// Return address of function 'GetMenuItemText'
void* ewg_get_function_address_GetMenuItemText (void)
{
	return (void*) GetMenuItemText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetItemMark'
// For ise
void  ewg_function_SetItemMark (MenuRef ewg_theMenu, MenuItemIndex ewg_item, CharParameter ewg_markChar)
{
	SetItemMark ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (CharParameter)ewg_markChar);
}

// Return address of function 'SetItemMark'
void* ewg_get_function_address_SetItemMark (void)
{
	return (void*) SetItemMark;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetItemMark'
// For ise
void  ewg_function_GetItemMark (MenuRef ewg_theMenu, MenuItemIndex ewg_item, CharParameter *ewg_markChar)
{
	GetItemMark ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (CharParameter*)ewg_markChar);
}

// Return address of function 'GetItemMark'
void* ewg_get_function_address_GetItemMark (void)
{
	return (void*) GetItemMark;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetItemCmd'
// For ise
void  ewg_function_SetItemCmd (MenuRef ewg_theMenu, MenuItemIndex ewg_item, CharParameter ewg_cmdChar)
{
	SetItemCmd ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (CharParameter)ewg_cmdChar);
}

// Return address of function 'SetItemCmd'
void* ewg_get_function_address_SetItemCmd (void)
{
	return (void*) SetItemCmd;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetItemCmd'
// For ise
void  ewg_function_GetItemCmd (MenuRef ewg_theMenu, MenuItemIndex ewg_item, CharParameter *ewg_cmdChar)
{
	GetItemCmd ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (CharParameter*)ewg_cmdChar);
}

// Return address of function 'GetItemCmd'
void* ewg_get_function_address_GetItemCmd (void)
{
	return (void*) GetItemCmd;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetItemIcon'
// For ise
void  ewg_function_SetItemIcon (MenuRef ewg_theMenu, MenuItemIndex ewg_item, short ewg_iconIndex)
{
	SetItemIcon ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (short)ewg_iconIndex);
}

// Return address of function 'SetItemIcon'
void* ewg_get_function_address_SetItemIcon (void)
{
	return (void*) SetItemIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetItemIcon'
// For ise
void  ewg_function_GetItemIcon (MenuRef ewg_theMenu, MenuItemIndex ewg_item, short *ewg_iconIndex)
{
	GetItemIcon ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (short*)ewg_iconIndex);
}

// Return address of function 'GetItemIcon'
void* ewg_get_function_address_GetItemIcon (void)
{
	return (void*) GetItemIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetItemStyle'
// For ise
void  ewg_function_SetItemStyle (MenuRef ewg_theMenu, MenuItemIndex ewg_item, StyleParameter ewg_chStyle)
{
	SetItemStyle ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (StyleParameter)ewg_chStyle);
}

// Return address of function 'SetItemStyle'
void* ewg_get_function_address_SetItemStyle (void)
{
	return (void*) SetItemStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetItemStyle'
// For ise
void  ewg_function_GetItemStyle (MenuRef ewg_theMenu, MenuItemIndex ewg_item, Style *ewg_chStyle)
{
	GetItemStyle ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item, (Style*)ewg_chStyle);
}

// Return address of function 'GetItemStyle'
void* ewg_get_function_address_GetItemStyle (void)
{
	return (void*) GetItemStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemCommandID'
// For ise
OSErr  ewg_function_SetMenuItemCommandID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuCommand ewg_inCommandID)
{
	return SetMenuItemCommandID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'SetMenuItemCommandID'
void* ewg_get_function_address_SetMenuItemCommandID (void)
{
	return (void*) SetMenuItemCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemCommandID'
// For ise
OSErr  ewg_function_GetMenuItemCommandID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuCommand *ewg_outCommandID)
{
	return GetMenuItemCommandID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuCommand*)ewg_outCommandID);
}

// Return address of function 'GetMenuItemCommandID'
void* ewg_get_function_address_GetMenuItemCommandID (void)
{
	return (void*) GetMenuItemCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemModifiers'
// For ise
OSErr  ewg_function_SetMenuItemModifiers (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt8 ewg_inModifiers)
{
	return SetMenuItemModifiers ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt8)ewg_inModifiers);
}

// Return address of function 'SetMenuItemModifiers'
void* ewg_get_function_address_SetMenuItemModifiers (void)
{
	return (void*) SetMenuItemModifiers;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemModifiers'
// For ise
OSErr  ewg_function_GetMenuItemModifiers (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt8 *ewg_outModifiers)
{
	return GetMenuItemModifiers ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt8*)ewg_outModifiers);
}

// Return address of function 'GetMenuItemModifiers'
void* ewg_get_function_address_GetMenuItemModifiers (void)
{
	return (void*) GetMenuItemModifiers;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemIconHandle'
// For ise
OSErr  ewg_function_SetMenuItemIconHandle (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt8 ewg_inIconType, Handle ewg_inIconHandle)
{
	return SetMenuItemIconHandle ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt8)ewg_inIconType, (Handle)ewg_inIconHandle);
}

// Return address of function 'SetMenuItemIconHandle'
void* ewg_get_function_address_SetMenuItemIconHandle (void)
{
	return (void*) SetMenuItemIconHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemIconHandle'
// For ise
OSErr  ewg_function_GetMenuItemIconHandle (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt8 *ewg_outIconType, Handle *ewg_outIconHandle)
{
	return GetMenuItemIconHandle ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt8*)ewg_outIconType, (Handle*)ewg_outIconHandle);
}

// Return address of function 'GetMenuItemIconHandle'
void* ewg_get_function_address_GetMenuItemIconHandle (void)
{
	return (void*) GetMenuItemIconHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemTextEncoding'
// For ise
OSErr  ewg_function_SetMenuItemTextEncoding (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, TextEncoding ewg_inScriptID)
{
	return SetMenuItemTextEncoding ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (TextEncoding)ewg_inScriptID);
}

// Return address of function 'SetMenuItemTextEncoding'
void* ewg_get_function_address_SetMenuItemTextEncoding (void)
{
	return (void*) SetMenuItemTextEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemTextEncoding'
// For ise
OSErr  ewg_function_GetMenuItemTextEncoding (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, TextEncoding *ewg_outScriptID)
{
	return GetMenuItemTextEncoding ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (TextEncoding*)ewg_outScriptID);
}

// Return address of function 'GetMenuItemTextEncoding'
void* ewg_get_function_address_GetMenuItemTextEncoding (void)
{
	return (void*) GetMenuItemTextEncoding;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemHierarchicalID'
// For ise
OSErr  ewg_function_SetMenuItemHierarchicalID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuID ewg_inHierID)
{
	return SetMenuItemHierarchicalID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuID)ewg_inHierID);
}

// Return address of function 'SetMenuItemHierarchicalID'
void* ewg_get_function_address_SetMenuItemHierarchicalID (void)
{
	return (void*) SetMenuItemHierarchicalID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemHierarchicalID'
// For ise
OSErr  ewg_function_GetMenuItemHierarchicalID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuID *ewg_outHierID)
{
	return GetMenuItemHierarchicalID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuID*)ewg_outHierID);
}

// Return address of function 'GetMenuItemHierarchicalID'
void* ewg_get_function_address_GetMenuItemHierarchicalID (void)
{
	return (void*) GetMenuItemHierarchicalID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemFontID'
// For ise
OSErr  ewg_function_SetMenuItemFontID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, SInt16 ewg_inFontID)
{
	return SetMenuItemFontID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (SInt16)ewg_inFontID);
}

// Return address of function 'SetMenuItemFontID'
void* ewg_get_function_address_SetMenuItemFontID (void)
{
	return (void*) SetMenuItemFontID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemFontID'
// For ise
OSErr  ewg_function_GetMenuItemFontID (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, SInt16 *ewg_outFontID)
{
	return GetMenuItemFontID ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (SInt16*)ewg_outFontID);
}

// Return address of function 'GetMenuItemFontID'
void* ewg_get_function_address_GetMenuItemFontID (void)
{
	return (void*) GetMenuItemFontID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemRefCon'
// For ise
OSErr  ewg_function_SetMenuItemRefCon (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt32 ewg_inRefCon)
{
	return SetMenuItemRefCon ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt32)ewg_inRefCon);
}

// Return address of function 'SetMenuItemRefCon'
void* ewg_get_function_address_SetMenuItemRefCon (void)
{
	return (void*) SetMenuItemRefCon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemRefCon'
// For ise
OSErr  ewg_function_GetMenuItemRefCon (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt32 *ewg_outRefCon)
{
	return GetMenuItemRefCon ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt32*)ewg_outRefCon);
}

// Return address of function 'GetMenuItemRefCon'
void* ewg_get_function_address_GetMenuItemRefCon (void)
{
	return (void*) GetMenuItemRefCon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemKeyGlyph'
// For ise
OSErr  ewg_function_SetMenuItemKeyGlyph (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, SInt16 ewg_inGlyph)
{
	return SetMenuItemKeyGlyph ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (SInt16)ewg_inGlyph);
}

// Return address of function 'SetMenuItemKeyGlyph'
void* ewg_get_function_address_SetMenuItemKeyGlyph (void)
{
	return (void*) SetMenuItemKeyGlyph;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemKeyGlyph'
// For ise
OSErr  ewg_function_GetMenuItemKeyGlyph (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, SInt16 *ewg_outGlyph)
{
	return GetMenuItemKeyGlyph ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (SInt16*)ewg_outGlyph);
}

// Return address of function 'GetMenuItemKeyGlyph'
void* ewg_get_function_address_GetMenuItemKeyGlyph (void)
{
	return (void*) GetMenuItemKeyGlyph;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableMenuItem'
// For ise
void  ewg_function_EnableMenuItem (MenuRef ewg_theMenu, MenuItemIndex ewg_item)
{
	EnableMenuItem ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item);
}

// Return address of function 'EnableMenuItem'
void* ewg_get_function_address_EnableMenuItem (void)
{
	return (void*) EnableMenuItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableMenuItem'
// For ise
void  ewg_function_DisableMenuItem (MenuRef ewg_theMenu, MenuItemIndex ewg_item)
{
	DisableMenuItem ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item);
}

// Return address of function 'DisableMenuItem'
void* ewg_get_function_address_DisableMenuItem (void)
{
	return (void*) DisableMenuItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuItemEnabled'
// For ise
Boolean  ewg_function_IsMenuItemEnabled (MenuRef ewg_menu, MenuItemIndex ewg_item)
{
	return IsMenuItemEnabled ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item);
}

// Return address of function 'IsMenuItemEnabled'
void* ewg_get_function_address_IsMenuItemEnabled (void)
{
	return (void*) IsMenuItemEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableMenuItemIcon'
// For ise
void  ewg_function_EnableMenuItemIcon (MenuRef ewg_theMenu, MenuItemIndex ewg_item)
{
	EnableMenuItemIcon ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item);
}

// Return address of function 'EnableMenuItemIcon'
void* ewg_get_function_address_EnableMenuItemIcon (void)
{
	return (void*) EnableMenuItemIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableMenuItemIcon'
// For ise
void  ewg_function_DisableMenuItemIcon (MenuRef ewg_theMenu, MenuItemIndex ewg_item)
{
	DisableMenuItemIcon ((MenuRef)ewg_theMenu, (MenuItemIndex)ewg_item);
}

// Return address of function 'DisableMenuItemIcon'
void* ewg_get_function_address_DisableMenuItemIcon (void)
{
	return (void*) DisableMenuItemIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuItemIconEnabled'
// For ise
Boolean  ewg_function_IsMenuItemIconEnabled (MenuRef ewg_menu, MenuItemIndex ewg_item)
{
	return IsMenuItemIconEnabled ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item);
}

// Return address of function 'IsMenuItemIconEnabled'
void* ewg_get_function_address_IsMenuItemIconEnabled (void)
{
	return (void*) IsMenuItemIconEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemHierarchicalMenu'
// For ise
OSStatus  ewg_function_SetMenuItemHierarchicalMenu (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuRef ewg_inHierMenu)
{
	return SetMenuItemHierarchicalMenu ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuRef)ewg_inHierMenu);
}

// Return address of function 'SetMenuItemHierarchicalMenu'
void* ewg_get_function_address_SetMenuItemHierarchicalMenu (void)
{
	return (void*) SetMenuItemHierarchicalMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemHierarchicalMenu'
// For ise
OSStatus  ewg_function_GetMenuItemHierarchicalMenu (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, MenuRef *ewg_outHierMenu)
{
	return GetMenuItemHierarchicalMenu ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (MenuRef*)ewg_outHierMenu);
}

// Return address of function 'GetMenuItemHierarchicalMenu'
void* ewg_get_function_address_GetMenuItemHierarchicalMenu (void)
{
	return (void*) GetMenuItemHierarchicalMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyMenuItemTextAsCFString'
// For ise
OSStatus  ewg_function_CopyMenuItemTextAsCFString (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, CFStringRef *ewg_outString)
{
	return CopyMenuItemTextAsCFString ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (CFStringRef*)ewg_outString);
}

// Return address of function 'CopyMenuItemTextAsCFString'
void* ewg_get_function_address_CopyMenuItemTextAsCFString (void)
{
	return (void*) CopyMenuItemTextAsCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemTextWithCFString'
// For ise
OSStatus  ewg_function_SetMenuItemTextWithCFString (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, CFStringRef ewg_inString)
{
	return SetMenuItemTextWithCFString ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (CFStringRef)ewg_inString);
}

// Return address of function 'SetMenuItemTextWithCFString'
void* ewg_get_function_address_SetMenuItemTextWithCFString (void)
{
	return (void*) SetMenuItemTextWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemIndent'
// For ise
OSStatus  ewg_function_GetMenuItemIndent (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt32 *ewg_outIndent)
{
	return GetMenuItemIndent ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt32*)ewg_outIndent);
}

// Return address of function 'GetMenuItemIndent'
void* ewg_get_function_address_GetMenuItemIndent (void)
{
	return (void*) GetMenuItemIndent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemIndent'
// For ise
OSStatus  ewg_function_SetMenuItemIndent (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, UInt32 ewg_inIndent)
{
	return SetMenuItemIndent ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (UInt32)ewg_inIndent);
}

// Return address of function 'SetMenuItemIndent'
void* ewg_get_function_address_SetMenuItemIndent (void)
{
	return (void*) SetMenuItemIndent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemCommandKey'
// For ise
OSStatus  ewg_function_GetMenuItemCommandKey (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, Boolean ewg_inGetVirtualKey, UInt16 *ewg_outKey)
{
	return GetMenuItemCommandKey ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (Boolean)ewg_inGetVirtualKey, (UInt16*)ewg_outKey);
}

// Return address of function 'GetMenuItemCommandKey'
void* ewg_get_function_address_GetMenuItemCommandKey (void)
{
	return (void*) GetMenuItemCommandKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemCommandKey'
// For ise
OSStatus  ewg_function_SetMenuItemCommandKey (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, Boolean ewg_inSetVirtualKey, UInt16 ewg_inKey)
{
	return SetMenuItemCommandKey ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (Boolean)ewg_inSetVirtualKey, (UInt16)ewg_inKey);
}

// Return address of function 'SetMenuItemCommandKey'
void* ewg_get_function_address_SetMenuItemCommandKey (void)
{
	return (void*) SetMenuItemCommandKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DeleteMCEntries'
// For ise
void  ewg_function_DeleteMCEntries (MenuID ewg_menuID, short ewg_menuItem)
{
	DeleteMCEntries ((MenuID)ewg_menuID, (short)ewg_menuItem);
}

// Return address of function 'DeleteMCEntries'
void* ewg_get_function_address_DeleteMCEntries (void)
{
	return (void*) DeleteMCEntries;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMCInfo'
// For ise
MCTableHandle  ewg_function_GetMCInfo (void)
{
	return GetMCInfo ();
}

// Return address of function 'GetMCInfo'
void* ewg_get_function_address_GetMCInfo (void)
{
	return (void*) GetMCInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMCInfo'
// For ise
void  ewg_function_SetMCInfo (MCTableHandle ewg_menuCTbl)
{
	SetMCInfo ((MCTableHandle)ewg_menuCTbl);
}

// Return address of function 'SetMCInfo'
void* ewg_get_function_address_SetMCInfo (void)
{
	return (void*) SetMCInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeMCInfo'
// For ise
void  ewg_function_DisposeMCInfo (MCTableHandle ewg_menuCTbl)
{
	DisposeMCInfo ((MCTableHandle)ewg_menuCTbl);
}

// Return address of function 'DisposeMCInfo'
void* ewg_get_function_address_DisposeMCInfo (void)
{
	return (void*) DisposeMCInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMCEntry'
// For ise
MCEntryPtr  ewg_function_GetMCEntry (MenuID ewg_menuID, short ewg_menuItem)
{
	return GetMCEntry ((MenuID)ewg_menuID, (short)ewg_menuItem);
}

// Return address of function 'GetMCEntry'
void* ewg_get_function_address_GetMCEntry (void)
{
	return (void*) GetMCEntry;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMCEntries'
// For ise
void  ewg_function_SetMCEntries (short ewg_numEntries, MCTablePtr ewg_menuCEntries)
{
	SetMCEntries ((short)ewg_numEntries, (MCTablePtr)ewg_menuCEntries);
}

// Return address of function 'SetMCEntries'
void* ewg_get_function_address_SetMCEntries (void)
{
	return (void*) SetMCEntries;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemProperty'
// For ise
OSStatus  ewg_function_GetMenuItemProperty (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_bufferSize, UInt32 *ewg_actualSize, void *ewg_propertyBuffer)
{
	return GetMenuItemProperty ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_bufferSize, (UInt32*)ewg_actualSize, (void*)ewg_propertyBuffer);
}

// Return address of function 'GetMenuItemProperty'
void* ewg_get_function_address_GetMenuItemProperty (void)
{
	return (void*) GetMenuItemProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemPropertySize'
// For ise
OSStatus  ewg_function_GetMenuItemPropertySize (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 *ewg_size)
{
	return GetMenuItemPropertySize ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32*)ewg_size);
}

// Return address of function 'GetMenuItemPropertySize'
void* ewg_get_function_address_GetMenuItemPropertySize (void)
{
	return (void*) GetMenuItemPropertySize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemProperty'
// For ise
OSStatus  ewg_function_SetMenuItemProperty (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_propertySize, void const *ewg_propertyData)
{
	return SetMenuItemProperty ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_propertySize, (void const*)ewg_propertyData);
}

// Return address of function 'SetMenuItemProperty'
void* ewg_get_function_address_SetMenuItemProperty (void)
{
	return (void*) SetMenuItemProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveMenuItemProperty'
// For ise
OSStatus  ewg_function_RemoveMenuItemProperty (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag)
{
	return RemoveMenuItemProperty ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag);
}

// Return address of function 'RemoveMenuItemProperty'
void* ewg_get_function_address_RemoveMenuItemProperty (void)
{
	return (void*) RemoveMenuItemProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemPropertyAttributes'
// For ise
OSStatus  ewg_function_GetMenuItemPropertyAttributes (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 *ewg_attributes)
{
	return GetMenuItemPropertyAttributes ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32*)ewg_attributes);
}

// Return address of function 'GetMenuItemPropertyAttributes'
void* ewg_get_function_address_GetMenuItemPropertyAttributes (void)
{
	return (void*) GetMenuItemPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeMenuItemPropertyAttributes'
// For ise
OSStatus  ewg_function_ChangeMenuItemPropertyAttributes (MenuRef ewg_menu, MenuItemIndex ewg_item, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_attributesToSet, UInt32 ewg_attributesToClear)
{
	return ChangeMenuItemPropertyAttributes ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_attributesToSet, (UInt32)ewg_attributesToClear);
}

// Return address of function 'ChangeMenuItemPropertyAttributes'
void* ewg_get_function_address_ChangeMenuItemPropertyAttributes (void)
{
	return (void*) ChangeMenuItemPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuAttributes'
// For ise
OSStatus  ewg_function_GetMenuAttributes (MenuRef ewg_menu, MenuAttributes *ewg_outAttributes)
{
	return GetMenuAttributes ((MenuRef)ewg_menu, (MenuAttributes*)ewg_outAttributes);
}

// Return address of function 'GetMenuAttributes'
void* ewg_get_function_address_GetMenuAttributes (void)
{
	return (void*) GetMenuAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeMenuAttributes'
// For ise
OSStatus  ewg_function_ChangeMenuAttributes (MenuRef ewg_menu, MenuAttributes ewg_setTheseAttributes, MenuAttributes ewg_clearTheseAttributes)
{
	return ChangeMenuAttributes ((MenuRef)ewg_menu, (MenuAttributes)ewg_setTheseAttributes, (MenuAttributes)ewg_clearTheseAttributes);
}

// Return address of function 'ChangeMenuAttributes'
void* ewg_get_function_address_ChangeMenuAttributes (void)
{
	return (void*) ChangeMenuAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuItemAttributes'
// For ise
OSStatus  ewg_function_GetMenuItemAttributes (MenuRef ewg_menu, MenuItemIndex ewg_item, MenuItemAttributes *ewg_outAttributes)
{
	return GetMenuItemAttributes ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (MenuItemAttributes*)ewg_outAttributes);
}

// Return address of function 'GetMenuItemAttributes'
void* ewg_get_function_address_GetMenuItemAttributes (void)
{
	return (void*) GetMenuItemAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeMenuItemAttributes'
// For ise
OSStatus  ewg_function_ChangeMenuItemAttributes (MenuRef ewg_menu, MenuItemIndex ewg_item, MenuItemAttributes ewg_setTheseAttributes, MenuItemAttributes ewg_clearTheseAttributes)
{
	return ChangeMenuItemAttributes ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (MenuItemAttributes)ewg_setTheseAttributes, (MenuItemAttributes)ewg_clearTheseAttributes);
}

// Return address of function 'ChangeMenuItemAttributes'
void* ewg_get_function_address_ChangeMenuItemAttributes (void)
{
	return (void*) ChangeMenuItemAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableAllMenuItems'
// For ise
void  ewg_function_DisableAllMenuItems (MenuRef ewg_theMenu)
{
	DisableAllMenuItems ((MenuRef)ewg_theMenu);
}

// Return address of function 'DisableAllMenuItems'
void* ewg_get_function_address_DisableAllMenuItems (void)
{
	return (void*) DisableAllMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableAllMenuItems'
// For ise
void  ewg_function_EnableAllMenuItems (MenuRef ewg_theMenu)
{
	EnableAllMenuItems ((MenuRef)ewg_theMenu);
}

// Return address of function 'EnableAllMenuItems'
void* ewg_get_function_address_EnableAllMenuItems (void)
{
	return (void*) EnableAllMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MenuHasEnabledItems'
// For ise
Boolean  ewg_function_MenuHasEnabledItems (MenuRef ewg_theMenu)
{
	return MenuHasEnabledItems ((MenuRef)ewg_theMenu);
}

// Return address of function 'MenuHasEnabledItems'
void* ewg_get_function_address_MenuHasEnabledItems (void)
{
	return (void*) MenuHasEnabledItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuTrackingData'
// For ise
OSStatus  ewg_function_GetMenuTrackingData (MenuRef ewg_theMenu, MenuTrackingData *ewg_outData)
{
	return GetMenuTrackingData ((MenuRef)ewg_theMenu, (MenuTrackingData*)ewg_outData);
}

// Return address of function 'GetMenuTrackingData'
void* ewg_get_function_address_GetMenuTrackingData (void)
{
	return (void*) GetMenuTrackingData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuType'
// For ise
OSStatus  ewg_function_GetMenuType (MenuRef ewg_theMenu, UInt16 *ewg_outType)
{
	return GetMenuType ((MenuRef)ewg_theMenu, (UInt16*)ewg_outType);
}

// Return address of function 'GetMenuType'
void* ewg_get_function_address_GetMenuType (void)
{
	return (void*) GetMenuType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CountMenuItemsWithCommandID'
// For ise
ItemCount  ewg_function_CountMenuItemsWithCommandID (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID)
{
	return CountMenuItemsWithCommandID ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'CountMenuItemsWithCommandID'
void* ewg_get_function_address_CountMenuItemsWithCommandID (void)
{
	return (void*) CountMenuItemsWithCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetIndMenuItemWithCommandID'
// For ise
OSStatus  ewg_function_GetIndMenuItemWithCommandID (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, UInt32 ewg_inItemIndex, MenuRef *ewg_outMenu, MenuItemIndex *ewg_outIndex)
{
	return GetIndMenuItemWithCommandID ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (UInt32)ewg_inItemIndex, (MenuRef*)ewg_outMenu, (MenuItemIndex*)ewg_outIndex);
}

// Return address of function 'GetIndMenuItemWithCommandID'
void* ewg_get_function_address_GetIndMenuItemWithCommandID (void)
{
	return (void*) GetIndMenuItemWithCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableMenuCommand'
// For ise
void  ewg_function_EnableMenuCommand (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID)
{
	EnableMenuCommand ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'EnableMenuCommand'
void* ewg_get_function_address_EnableMenuCommand (void)
{
	return (void*) EnableMenuCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableMenuCommand'
// For ise
void  ewg_function_DisableMenuCommand (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID)
{
	DisableMenuCommand ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'DisableMenuCommand'
void* ewg_get_function_address_DisableMenuCommand (void)
{
	return (void*) DisableMenuCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuCommandEnabled'
// For ise
Boolean  ewg_function_IsMenuCommandEnabled (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID)
{
	return IsMenuCommandEnabled ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID);
}

// Return address of function 'IsMenuCommandEnabled'
void* ewg_get_function_address_IsMenuCommandEnabled (void)
{
	return (void*) IsMenuCommandEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuCommandMark'
// For ise
OSStatus  ewg_function_SetMenuCommandMark (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, UniChar ewg_inMark)
{
	return SetMenuCommandMark ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (UniChar)ewg_inMark);
}

// Return address of function 'SetMenuCommandMark'
void* ewg_get_function_address_SetMenuCommandMark (void)
{
	return (void*) SetMenuCommandMark;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuCommandMark'
// For ise
OSStatus  ewg_function_GetMenuCommandMark (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, UniChar *ewg_outMark)
{
	return GetMenuCommandMark ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (UniChar*)ewg_outMark);
}

// Return address of function 'GetMenuCommandMark'
void* ewg_get_function_address_GetMenuCommandMark (void)
{
	return (void*) GetMenuCommandMark;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuCommandProperty'
// For ise
OSStatus  ewg_function_GetMenuCommandProperty (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, OSType ewg_inPropertyCreator, OSType ewg_inPropertyTag, ByteCount ewg_inBufferSize, ByteCount *ewg_outActualSize, void *ewg_inPropertyBuffer)
{
	return GetMenuCommandProperty ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (OSType)ewg_inPropertyCreator, (OSType)ewg_inPropertyTag, (ByteCount)ewg_inBufferSize, (ByteCount*)ewg_outActualSize, (void*)ewg_inPropertyBuffer);
}

// Return address of function 'GetMenuCommandProperty'
void* ewg_get_function_address_GetMenuCommandProperty (void)
{
	return (void*) GetMenuCommandProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuCommandPropertySize'
// For ise
OSStatus  ewg_function_GetMenuCommandPropertySize (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, OSType ewg_inPropertyCreator, OSType ewg_inPropertyTag, ByteCount *ewg_outSize)
{
	return GetMenuCommandPropertySize ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (OSType)ewg_inPropertyCreator, (OSType)ewg_inPropertyTag, (ByteCount*)ewg_outSize);
}

// Return address of function 'GetMenuCommandPropertySize'
void* ewg_get_function_address_GetMenuCommandPropertySize (void)
{
	return (void*) GetMenuCommandPropertySize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuCommandProperty'
// For ise
OSStatus  ewg_function_SetMenuCommandProperty (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, OSType ewg_inPropertyCreator, OSType ewg_inPropertyTag, ByteCount ewg_inPropertySize, void const *ewg_inPropertyData)
{
	return SetMenuCommandProperty ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (OSType)ewg_inPropertyCreator, (OSType)ewg_inPropertyTag, (ByteCount)ewg_inPropertySize, (void const*)ewg_inPropertyData);
}

// Return address of function 'SetMenuCommandProperty'
void* ewg_get_function_address_SetMenuCommandProperty (void)
{
	return (void*) SetMenuCommandProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveMenuCommandProperty'
// For ise
OSStatus  ewg_function_RemoveMenuCommandProperty (MenuRef ewg_inMenu, MenuCommand ewg_inCommandID, OSType ewg_inPropertyCreator, OSType ewg_inPropertyTag)
{
	return RemoveMenuCommandProperty ((MenuRef)ewg_inMenu, (MenuCommand)ewg_inCommandID, (OSType)ewg_inPropertyCreator, (OSType)ewg_inPropertyTag);
}

// Return address of function 'RemoveMenuCommandProperty'
void* ewg_get_function_address_RemoveMenuCommandProperty (void)
{
	return (void*) RemoveMenuCommandProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyMenuItemData'
// For ise
OSStatus  ewg_function_CopyMenuItemData (MenuRef ewg_inMenu, MenuItemID ewg_inItem, Boolean ewg_inIsCommandID, MenuItemDataPtr ewg_ioData)
{
	return CopyMenuItemData ((MenuRef)ewg_inMenu, (MenuItemID)ewg_inItem, (Boolean)ewg_inIsCommandID, (MenuItemDataPtr)ewg_ioData);
}

// Return address of function 'CopyMenuItemData'
void* ewg_get_function_address_CopyMenuItemData (void)
{
	return (void*) CopyMenuItemData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuItemData'
// For ise
OSStatus  ewg_function_SetMenuItemData (MenuRef ewg_inMenu, MenuItemID ewg_inItem, Boolean ewg_inIsCommandID, MenuItemDataRec const *ewg_inData)
{
	return SetMenuItemData ((MenuRef)ewg_inMenu, (MenuItemID)ewg_inItem, (Boolean)ewg_inIsCommandID, (MenuItemDataRec const*)ewg_inData);
}

// Return address of function 'SetMenuItemData'
void* ewg_get_function_address_SetMenuItemData (void)
{
	return (void*) SetMenuItemData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMenuItemInvalid'
// For ise
Boolean  ewg_function_IsMenuItemInvalid (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem)
{
	return IsMenuItemInvalid ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem);
}

// Return address of function 'IsMenuItemInvalid'
void* ewg_get_function_address_IsMenuItemInvalid (void)
{
	return (void*) IsMenuItemInvalid;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalidateMenuItems'
// For ise
OSStatus  ewg_function_InvalidateMenuItems (MenuRef ewg_inMenu, MenuItemIndex ewg_inFirstItem, ItemCount ewg_inNumItems)
{
	return InvalidateMenuItems ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inFirstItem, (ItemCount)ewg_inNumItems);
}

// Return address of function 'InvalidateMenuItems'
void* ewg_get_function_address_InvalidateMenuItems (void)
{
	return (void*) InvalidateMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UpdateInvalidMenuItems'
// For ise
OSStatus  ewg_function_UpdateInvalidMenuItems (MenuRef ewg_inMenu)
{
	return UpdateInvalidMenuItems ((MenuRef)ewg_inMenu);
}

// Return address of function 'UpdateInvalidMenuItems'
void* ewg_get_function_address_UpdateInvalidMenuItems (void)
{
	return (void*) UpdateInvalidMenuItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateStandardFontMenu'
// For ise
OSStatus  ewg_function_CreateStandardFontMenu (MenuRef ewg_menu, MenuItemIndex ewg_afterItem, MenuID ewg_firstHierMenuID, OptionBits ewg_options, ItemCount *ewg_outHierMenuCount)
{
	return CreateStandardFontMenu ((MenuRef)ewg_menu, (MenuItemIndex)ewg_afterItem, (MenuID)ewg_firstHierMenuID, (OptionBits)ewg_options, (ItemCount*)ewg_outHierMenuCount);
}

// Return address of function 'CreateStandardFontMenu'
void* ewg_get_function_address_CreateStandardFontMenu (void)
{
	return (void*) CreateStandardFontMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UpdateStandardFontMenu'
// For ise
OSStatus  ewg_function_UpdateStandardFontMenu (MenuRef ewg_menu, ItemCount *ewg_outHierMenuCount)
{
	return UpdateStandardFontMenu ((MenuRef)ewg_menu, (ItemCount*)ewg_outHierMenuCount);
}

// Return address of function 'UpdateStandardFontMenu'
void* ewg_get_function_address_UpdateStandardFontMenu (void)
{
	return (void*) UpdateStandardFontMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetFontFamilyFromMenuSelection'
// For ise
OSStatus  ewg_function_GetFontFamilyFromMenuSelection (MenuRef ewg_menu, MenuItemIndex ewg_item, FMFontFamily *ewg_outFontFamily, FMFontStyle *ewg_outStyle)
{
	return GetFontFamilyFromMenuSelection ((MenuRef)ewg_menu, (MenuItemIndex)ewg_item, (FMFontFamily*)ewg_outFontFamily, (FMFontStyle*)ewg_outStyle);
}

// Return address of function 'GetFontFamilyFromMenuSelection'
void* ewg_get_function_address_GetFontFamilyFromMenuSelection (void)
{
	return (void*) GetFontFamilyFromMenuSelection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InitContextualMenus'
// For ise
OSStatus  ewg_function_InitContextualMenus (void)
{
	return InitContextualMenus ();
}

// Return address of function 'InitContextualMenus'
void* ewg_get_function_address_InitContextualMenus (void)
{
	return (void*) InitContextualMenus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsShowContextualMenuClick'
// For ise
Boolean  ewg_function_IsShowContextualMenuClick (EventRecord const *ewg_inEvent)
{
	return IsShowContextualMenuClick ((EventRecord const*)ewg_inEvent);
}

// Return address of function 'IsShowContextualMenuClick'
void* ewg_get_function_address_IsShowContextualMenuClick (void)
{
	return (void*) IsShowContextualMenuClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsShowContextualMenuEvent'
// For ise
Boolean  ewg_function_IsShowContextualMenuEvent (EventRef ewg_inEvent)
{
	return IsShowContextualMenuEvent ((EventRef)ewg_inEvent);
}

// Return address of function 'IsShowContextualMenuEvent'
void* ewg_get_function_address_IsShowContextualMenuEvent (void)
{
	return (void*) IsShowContextualMenuEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ContextualMenuSelect'
// For ise
OSStatus  ewg_function_ContextualMenuSelect (MenuRef ewg_inMenu, Point *ewg_inGlobalLocation, Boolean ewg_inReserved, UInt32 ewg_inHelpType, ConstStr255Param ewg_inHelpItemString, AEDesc const *ewg_inSelection, UInt32 *ewg_outUserSelectionType, MenuID *ewg_outMenuID, MenuItemIndex *ewg_outMenuItem)
{
	return ContextualMenuSelect ((MenuRef)ewg_inMenu, *(Point*)ewg_inGlobalLocation, (Boolean)ewg_inReserved, (UInt32)ewg_inHelpType, (ConstStr255Param)ewg_inHelpItemString, (AEDesc const*)ewg_inSelection, (UInt32*)ewg_outUserSelectionType, (MenuID*)ewg_outMenuID, (MenuItemIndex*)ewg_outMenuItem);
}

// Return address of function 'ContextualMenuSelect'
void* ewg_get_function_address_ContextualMenuSelect (void)
{
	return (void*) ContextualMenuSelect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ProcessIsContextualMenuClient'
// For ise
Boolean  ewg_function_ProcessIsContextualMenuClient (ProcessSerialNumber *ewg_inPSN)
{
	return ProcessIsContextualMenuClient ((ProcessSerialNumber*)ewg_inPSN);
}

// Return address of function 'ProcessIsContextualMenuClient'
void* ewg_get_function_address_ProcessIsContextualMenuClient (void)
{
	return (void*) ProcessIsContextualMenuClient;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'LMGetTheMenu'
// For ise
MenuID  ewg_function_LMGetTheMenu (void)
{
	return LMGetTheMenu ();
}

// Return address of function 'LMGetTheMenu'
void* ewg_get_function_address_LMGetTheMenu (void)
{
	return (void*) LMGetTheMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuID'
// For ise
MenuID  ewg_function_GetMenuID (MenuRef ewg_menu)
{
	return GetMenuID ((MenuRef)ewg_menu);
}

// Return address of function 'GetMenuID'
void* ewg_get_function_address_GetMenuID (void)
{
	return (void*) GetMenuID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuWidth'
// For ise
SInt16  ewg_function_GetMenuWidth (MenuRef ewg_menu)
{
	return GetMenuWidth ((MenuRef)ewg_menu);
}

// Return address of function 'GetMenuWidth'
void* ewg_get_function_address_GetMenuWidth (void)
{
	return (void*) GetMenuWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuHeight'
// For ise
SInt16  ewg_function_GetMenuHeight (MenuRef ewg_menu)
{
	return GetMenuHeight ((MenuRef)ewg_menu);
}

// Return address of function 'GetMenuHeight'
void* ewg_get_function_address_GetMenuHeight (void)
{
	return (void*) GetMenuHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuTitle'
// For ise
StringPtr  ewg_function_GetMenuTitle (MenuRef ewg_menu, void *ewg_title)
{
	return GetMenuTitle ((MenuRef)ewg_menu, ewg_title);
}

// Return address of function 'GetMenuTitle'
void* ewg_get_function_address_GetMenuTitle (void)
{
	return (void*) GetMenuTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuDefinition'
// For ise
OSStatus  ewg_function_GetMenuDefinition (MenuRef ewg_menu, MenuDefSpecPtr ewg_outDefSpec)
{
	return GetMenuDefinition ((MenuRef)ewg_menu, (MenuDefSpecPtr)ewg_outDefSpec);
}

// Return address of function 'GetMenuDefinition'
void* ewg_get_function_address_GetMenuDefinition (void)
{
	return (void*) GetMenuDefinition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuID'
// For ise
void  ewg_function_SetMenuID (MenuRef ewg_menu, MenuID ewg_menuID)
{
	SetMenuID ((MenuRef)ewg_menu, (MenuID)ewg_menuID);
}

// Return address of function 'SetMenuID'
void* ewg_get_function_address_SetMenuID (void)
{
	return (void*) SetMenuID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuWidth'
// For ise
void  ewg_function_SetMenuWidth (MenuRef ewg_menu, SInt16 ewg_width)
{
	SetMenuWidth ((MenuRef)ewg_menu, (SInt16)ewg_width);
}

// Return address of function 'SetMenuWidth'
void* ewg_get_function_address_SetMenuWidth (void)
{
	return (void*) SetMenuWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuHeight'
// For ise
void  ewg_function_SetMenuHeight (MenuRef ewg_menu, SInt16 ewg_height)
{
	SetMenuHeight ((MenuRef)ewg_menu, (SInt16)ewg_height);
}

// Return address of function 'SetMenuHeight'
void* ewg_get_function_address_SetMenuHeight (void)
{
	return (void*) SetMenuHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuTitle'
// For ise
OSStatus  ewg_function_SetMenuTitle (MenuRef ewg_menu, ConstStr255Param ewg_title)
{
	return SetMenuTitle ((MenuRef)ewg_menu, (ConstStr255Param)ewg_title);
}

// Return address of function 'SetMenuTitle'
void* ewg_get_function_address_SetMenuTitle (void)
{
	return (void*) SetMenuTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMenuDefinition'
// For ise
OSStatus  ewg_function_SetMenuDefinition (MenuRef ewg_menu, MenuDefSpec const *ewg_defSpec)
{
	return SetMenuDefinition ((MenuRef)ewg_menu, (MenuDefSpec const*)ewg_defSpec);
}

// Return address of function 'SetMenuDefinition'
void* ewg_get_function_address_SetMenuDefinition (void)
{
	return (void*) SetMenuDefinition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlActionUPP'
// For ise
ControlActionUPP  ewg_function_NewControlActionUPP (ControlActionProcPtr ewg_userRoutine)
{
	return NewControlActionUPP ((ControlActionProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlActionUPP'
void* ewg_get_function_address_NewControlActionUPP (void)
{
	return (void*) NewControlActionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlActionUPP'
// For ise
void  ewg_function_DisposeControlActionUPP (ControlActionUPP ewg_userUPP)
{
	DisposeControlActionUPP ((ControlActionUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlActionUPP'
void* ewg_get_function_address_DisposeControlActionUPP (void)
{
	return (void*) DisposeControlActionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlActionUPP'
// For ise
void  ewg_function_InvokeControlActionUPP (ControlRef ewg_theControl, ControlPartCode ewg_partCode, ControlActionUPP ewg_userUPP)
{
	InvokeControlActionUPP ((ControlRef)ewg_theControl, (ControlPartCode)ewg_partCode, (ControlActionUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlActionUPP'
void* ewg_get_function_address_InvokeControlActionUPP (void)
{
	return (void*) InvokeControlActionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlDefUPP'
// For ise
ControlDefUPP  ewg_function_NewControlDefUPP (ControlDefProcPtr ewg_userRoutine)
{
	return NewControlDefUPP ((ControlDefProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlDefUPP'
void* ewg_get_function_address_NewControlDefUPP (void)
{
	return (void*) NewControlDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlDefUPP'
// For ise
void  ewg_function_DisposeControlDefUPP (ControlDefUPP ewg_userUPP)
{
	DisposeControlDefUPP ((ControlDefUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlDefUPP'
void* ewg_get_function_address_DisposeControlDefUPP (void)
{
	return (void*) DisposeControlDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlDefUPP'
// For ise
SInt32  ewg_function_InvokeControlDefUPP (SInt16 ewg_varCode, ControlRef ewg_theControl, ControlDefProcMessage ewg_message, SInt32 ewg_param, ControlDefUPP ewg_userUPP)
{
	return InvokeControlDefUPP ((SInt16)ewg_varCode, (ControlRef)ewg_theControl, (ControlDefProcMessage)ewg_message, (SInt32)ewg_param, (ControlDefUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlDefUPP'
void* ewg_get_function_address_InvokeControlDefUPP (void)
{
	return (void*) InvokeControlDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlKeyFilterUPP'
// For ise
ControlKeyFilterUPP  ewg_function_NewControlKeyFilterUPP (ControlKeyFilterProcPtr ewg_userRoutine)
{
	return NewControlKeyFilterUPP ((ControlKeyFilterProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlKeyFilterUPP'
void* ewg_get_function_address_NewControlKeyFilterUPP (void)
{
	return (void*) NewControlKeyFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlKeyFilterUPP'
// For ise
void  ewg_function_DisposeControlKeyFilterUPP (ControlKeyFilterUPP ewg_userUPP)
{
	DisposeControlKeyFilterUPP ((ControlKeyFilterUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlKeyFilterUPP'
void* ewg_get_function_address_DisposeControlKeyFilterUPP (void)
{
	return (void*) DisposeControlKeyFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlKeyFilterUPP'
// For ise
ControlKeyFilterResult  ewg_function_InvokeControlKeyFilterUPP (ControlRef ewg_theControl, SInt16 *ewg_keyCode, SInt16 *ewg_charCode, EventModifiers *ewg_modifiers, ControlKeyFilterUPP ewg_userUPP)
{
	return InvokeControlKeyFilterUPP ((ControlRef)ewg_theControl, (SInt16*)ewg_keyCode, (SInt16*)ewg_charCode, (EventModifiers*)ewg_modifiers, (ControlKeyFilterUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlKeyFilterUPP'
void* ewg_get_function_address_InvokeControlKeyFilterUPP (void)
{
	return (void*) InvokeControlKeyFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateCustomControl'
// For ise
OSStatus  ewg_function_CreateCustomControl (WindowRef ewg_owningWindow, Rect const *ewg_contBounds, ControlDefSpec const *ewg_def, Collection ewg_initData, ControlRef *ewg_outControl)
{
	return CreateCustomControl ((WindowRef)ewg_owningWindow, (Rect const*)ewg_contBounds, (ControlDefSpec const*)ewg_def, (Collection)ewg_initData, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateCustomControl'
void* ewg_get_function_address_CreateCustomControl (void)
{
	return (void*) CreateCustomControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControl'
// For ise
ControlRef  ewg_function_NewControl (WindowRef ewg_owningWindow, Rect const *ewg_boundsRect, ConstStr255Param ewg_controlTitle, Boolean ewg_initiallyVisible, SInt16 ewg_initialValue, SInt16 ewg_minimumValue, SInt16 ewg_maximumValue, SInt16 ewg_procID, SInt32 ewg_controlReference)
{
	return NewControl ((WindowRef)ewg_owningWindow, (Rect const*)ewg_boundsRect, (ConstStr255Param)ewg_controlTitle, (Boolean)ewg_initiallyVisible, (SInt16)ewg_initialValue, (SInt16)ewg_minimumValue, (SInt16)ewg_maximumValue, (SInt16)ewg_procID, (SInt32)ewg_controlReference);
}

// Return address of function 'NewControl'
void* ewg_get_function_address_NewControl (void)
{
	return (void*) NewControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNewControl'
// For ise
ControlRef  ewg_function_GetNewControl (SInt16 ewg_resourceID, WindowRef ewg_owningWindow)
{
	return GetNewControl ((SInt16)ewg_resourceID, (WindowRef)ewg_owningWindow);
}

// Return address of function 'GetNewControl'
void* ewg_get_function_address_GetNewControl (void)
{
	return (void*) GetNewControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControl'
// For ise
void  ewg_function_DisposeControl (ControlRef ewg_theControl)
{
	DisposeControl ((ControlRef)ewg_theControl);
}

// Return address of function 'DisposeControl'
void* ewg_get_function_address_DisposeControl (void)
{
	return (void*) DisposeControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'KillControls'
// For ise
void  ewg_function_KillControls (WindowRef ewg_theWindow)
{
	KillControls ((WindowRef)ewg_theWindow);
}

// Return address of function 'KillControls'
void* ewg_get_function_address_KillControls (void)
{
	return (void*) KillControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlCNTLToCollectionUPP'
// For ise
ControlCNTLToCollectionUPP  ewg_function_NewControlCNTLToCollectionUPP (ControlCNTLToCollectionProcPtr ewg_userRoutine)
{
	return NewControlCNTLToCollectionUPP ((ControlCNTLToCollectionProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlCNTLToCollectionUPP'
void* ewg_get_function_address_NewControlCNTLToCollectionUPP (void)
{
	return (void*) NewControlCNTLToCollectionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlCNTLToCollectionUPP'
// For ise
void  ewg_function_DisposeControlCNTLToCollectionUPP (ControlCNTLToCollectionUPP ewg_userUPP)
{
	DisposeControlCNTLToCollectionUPP ((ControlCNTLToCollectionUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlCNTLToCollectionUPP'
void* ewg_get_function_address_DisposeControlCNTLToCollectionUPP (void)
{
	return (void*) DisposeControlCNTLToCollectionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlCNTLToCollectionUPP'
// For ise
OSStatus  ewg_function_InvokeControlCNTLToCollectionUPP (Rect const *ewg_bounds, SInt16 ewg_value, Boolean ewg_visible, SInt16 ewg_max, SInt16 ewg_min, SInt16 ewg_procID, SInt32 ewg_refCon, ConstStr255Param ewg_title, Collection ewg_collection, ControlCNTLToCollectionUPP ewg_userUPP)
{
	return InvokeControlCNTLToCollectionUPP ((Rect const*)ewg_bounds, (SInt16)ewg_value, (Boolean)ewg_visible, (SInt16)ewg_max, (SInt16)ewg_min, (SInt16)ewg_procID, (SInt32)ewg_refCon, (ConstStr255Param)ewg_title, (Collection)ewg_collection, (ControlCNTLToCollectionUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlCNTLToCollectionUPP'
void* ewg_get_function_address_InvokeControlCNTLToCollectionUPP (void)
{
	return (void*) InvokeControlCNTLToCollectionUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RegisterControlDefinition'
// For ise
OSStatus  ewg_function_RegisterControlDefinition (SInt16 ewg_inCDEFResID, ControlDefSpec const *ewg_inControlDef, ControlCNTLToCollectionUPP ewg_inConversionProc)
{
	return RegisterControlDefinition ((SInt16)ewg_inCDEFResID, (ControlDefSpec const*)ewg_inControlDef, (ControlCNTLToCollectionUPP)ewg_inConversionProc);
}

// Return address of function 'RegisterControlDefinition'
void* ewg_get_function_address_RegisterControlDefinition (void)
{
	return (void*) RegisterControlDefinition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HiliteControl'
// For ise
void  ewg_function_HiliteControl (ControlRef ewg_theControl, ControlPartCode ewg_hiliteState)
{
	HiliteControl ((ControlRef)ewg_theControl, (ControlPartCode)ewg_hiliteState);
}

// Return address of function 'HiliteControl'
void* ewg_get_function_address_HiliteControl (void)
{
	return (void*) HiliteControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowControl'
// For ise
void  ewg_function_ShowControl (ControlRef ewg_theControl)
{
	ShowControl ((ControlRef)ewg_theControl);
}

// Return address of function 'ShowControl'
void* ewg_get_function_address_ShowControl (void)
{
	return (void*) ShowControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HideControl'
// For ise
void  ewg_function_HideControl (ControlRef ewg_theControl)
{
	HideControl ((ControlRef)ewg_theControl);
}

// Return address of function 'HideControl'
void* ewg_get_function_address_HideControl (void)
{
	return (void*) HideControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsControlActive'
// For ise
Boolean  ewg_function_IsControlActive (ControlRef ewg_inControl)
{
	return IsControlActive ((ControlRef)ewg_inControl);
}

// Return address of function 'IsControlActive'
void* ewg_get_function_address_IsControlActive (void)
{
	return (void*) IsControlActive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsControlVisible'
// For ise
Boolean  ewg_function_IsControlVisible (ControlRef ewg_inControl)
{
	return IsControlVisible ((ControlRef)ewg_inControl);
}

// Return address of function 'IsControlVisible'
void* ewg_get_function_address_IsControlVisible (void)
{
	return (void*) IsControlVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ActivateControl'
// For ise
OSErr  ewg_function_ActivateControl (ControlRef ewg_inControl)
{
	return ActivateControl ((ControlRef)ewg_inControl);
}

// Return address of function 'ActivateControl'
void* ewg_get_function_address_ActivateControl (void)
{
	return (void*) ActivateControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DeactivateControl'
// For ise
OSErr  ewg_function_DeactivateControl (ControlRef ewg_inControl)
{
	return DeactivateControl ((ControlRef)ewg_inControl);
}

// Return address of function 'DeactivateControl'
void* ewg_get_function_address_DeactivateControl (void)
{
	return (void*) DeactivateControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlVisibility'
// For ise
OSErr  ewg_function_SetControlVisibility (ControlRef ewg_inControl, Boolean ewg_inIsVisible, Boolean ewg_inDoDraw)
{
	return SetControlVisibility ((ControlRef)ewg_inControl, (Boolean)ewg_inIsVisible, (Boolean)ewg_inDoDraw);
}

// Return address of function 'SetControlVisibility'
void* ewg_get_function_address_SetControlVisibility (void)
{
	return (void*) SetControlVisibility;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsControlEnabled'
// For ise
Boolean  ewg_function_IsControlEnabled (ControlRef ewg_inControl)
{
	return IsControlEnabled ((ControlRef)ewg_inControl);
}

// Return address of function 'IsControlEnabled'
void* ewg_get_function_address_IsControlEnabled (void)
{
	return (void*) IsControlEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableControl'
// For ise
OSStatus  ewg_function_EnableControl (ControlRef ewg_inControl)
{
	return EnableControl ((ControlRef)ewg_inControl);
}

// Return address of function 'EnableControl'
void* ewg_get_function_address_EnableControl (void)
{
	return (void*) EnableControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableControl'
// For ise
OSStatus  ewg_function_DisableControl (ControlRef ewg_inControl)
{
	return DisableControl ((ControlRef)ewg_inControl);
}

// Return address of function 'DisableControl'
void* ewg_get_function_address_DisableControl (void)
{
	return (void*) DisableControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DrawControls'
// For ise
void  ewg_function_DrawControls (WindowRef ewg_theWindow)
{
	DrawControls ((WindowRef)ewg_theWindow);
}

// Return address of function 'DrawControls'
void* ewg_get_function_address_DrawControls (void)
{
	return (void*) DrawControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'Draw1Control'
// For ise
void  ewg_function_Draw1Control (ControlRef ewg_theControl)
{
	Draw1Control ((ControlRef)ewg_theControl);
}

// Return address of function 'Draw1Control'
void* ewg_get_function_address_Draw1Control (void)
{
	return (void*) Draw1Control;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UpdateControls'
// For ise
void  ewg_function_UpdateControls (WindowRef ewg_inWindow, RgnHandle ewg_inUpdateRegion)
{
	UpdateControls ((WindowRef)ewg_inWindow, (RgnHandle)ewg_inUpdateRegion);
}

// Return address of function 'UpdateControls'
void* ewg_get_function_address_UpdateControls (void)
{
	return (void*) UpdateControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetBestControlRect'
// For ise
OSErr  ewg_function_GetBestControlRect (ControlRef ewg_inControl, Rect *ewg_outRect, SInt16 *ewg_outBaseLineOffset)
{
	return GetBestControlRect ((ControlRef)ewg_inControl, (Rect*)ewg_outRect, (SInt16*)ewg_outBaseLineOffset);
}

// Return address of function 'GetBestControlRect'
void* ewg_get_function_address_GetBestControlRect (void)
{
	return (void*) GetBestControlRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlFontStyle'
// For ise
OSErr  ewg_function_SetControlFontStyle (ControlRef ewg_inControl, ControlFontStyleRec const *ewg_inStyle)
{
	return SetControlFontStyle ((ControlRef)ewg_inControl, (ControlFontStyleRec const*)ewg_inStyle);
}

// Return address of function 'SetControlFontStyle'
void* ewg_get_function_address_SetControlFontStyle (void)
{
	return (void*) SetControlFontStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DrawControlInCurrentPort'
// For ise
void  ewg_function_DrawControlInCurrentPort (ControlRef ewg_inControl)
{
	DrawControlInCurrentPort ((ControlRef)ewg_inControl);
}

// Return address of function 'DrawControlInCurrentPort'
void* ewg_get_function_address_DrawControlInCurrentPort (void)
{
	return (void*) DrawControlInCurrentPort;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetUpControlBackground'
// For ise
OSErr  ewg_function_SetUpControlBackground (ControlRef ewg_inControl, SInt16 ewg_inDepth, Boolean ewg_inIsColorDevice)
{
	return SetUpControlBackground ((ControlRef)ewg_inControl, (SInt16)ewg_inDepth, (Boolean)ewg_inIsColorDevice);
}

// Return address of function 'SetUpControlBackground'
void* ewg_get_function_address_SetUpControlBackground (void)
{
	return (void*) SetUpControlBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetUpControlTextColor'
// For ise
OSErr  ewg_function_SetUpControlTextColor (ControlRef ewg_inControl, SInt16 ewg_inDepth, Boolean ewg_inIsColorDevice)
{
	return SetUpControlTextColor ((ControlRef)ewg_inControl, (SInt16)ewg_inDepth, (Boolean)ewg_inIsColorDevice);
}

// Return address of function 'SetUpControlTextColor'
void* ewg_get_function_address_SetUpControlTextColor (void)
{
	return (void*) SetUpControlTextColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlColorUPP'
// For ise
ControlColorUPP  ewg_function_NewControlColorUPP (ControlColorProcPtr ewg_userRoutine)
{
	return NewControlColorUPP ((ControlColorProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlColorUPP'
void* ewg_get_function_address_NewControlColorUPP (void)
{
	return (void*) NewControlColorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlColorUPP'
// For ise
void  ewg_function_DisposeControlColorUPP (ControlColorUPP ewg_userUPP)
{
	DisposeControlColorUPP ((ControlColorUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlColorUPP'
void* ewg_get_function_address_DisposeControlColorUPP (void)
{
	return (void*) DisposeControlColorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlColorUPP'
// For ise
OSStatus  ewg_function_InvokeControlColorUPP (ControlRef ewg_inControl, SInt16 ewg_inMessage, SInt16 ewg_inDrawDepth, Boolean ewg_inDrawInColor, ControlColorUPP ewg_userUPP)
{
	return InvokeControlColorUPP ((ControlRef)ewg_inControl, (SInt16)ewg_inMessage, (SInt16)ewg_inDrawDepth, (Boolean)ewg_inDrawInColor, (ControlColorUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlColorUPP'
void* ewg_get_function_address_InvokeControlColorUPP (void)
{
	return (void*) InvokeControlColorUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlColorProc'
// For ise
OSStatus  ewg_function_SetControlColorProc (ControlRef ewg_inControl, ControlColorUPP ewg_inProc)
{
	return SetControlColorProc ((ControlRef)ewg_inControl, (ControlColorUPP)ewg_inProc);
}

// Return address of function 'SetControlColorProc'
void* ewg_get_function_address_SetControlColorProc (void)
{
	return (void*) SetControlColorProc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackControl'
// For ise
ControlPartCode  ewg_function_TrackControl (ControlRef ewg_theControl, Point *ewg_startPoint, ControlActionUPP ewg_actionProc)
{
	return TrackControl ((ControlRef)ewg_theControl, *(Point*)ewg_startPoint, (ControlActionUPP)ewg_actionProc);
}

// Return address of function 'TrackControl'
void* ewg_get_function_address_TrackControl (void)
{
	return (void*) TrackControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DragControl'
// For ise
void  ewg_function_DragControl (ControlRef ewg_theControl, Point *ewg_startPoint, Rect const *ewg_limitRect, Rect const *ewg_slopRect, DragConstraint ewg_axis)
{
	DragControl ((ControlRef)ewg_theControl, *(Point*)ewg_startPoint, (Rect const*)ewg_limitRect, (Rect const*)ewg_slopRect, (DragConstraint)ewg_axis);
}

// Return address of function 'DragControl'
void* ewg_get_function_address_DragControl (void)
{
	return (void*) DragControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TestControl'
// For ise
ControlPartCode  ewg_function_TestControl (ControlRef ewg_theControl, Point *ewg_testPoint)
{
	return TestControl ((ControlRef)ewg_theControl, *(Point*)ewg_testPoint);
}

// Return address of function 'TestControl'
void* ewg_get_function_address_TestControl (void)
{
	return (void*) TestControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FindControl'
// For ise
ControlPartCode  ewg_function_FindControl (Point *ewg_testPoint, WindowRef ewg_theWindow, ControlRef *ewg_theControl)
{
	return FindControl (*(Point*)ewg_testPoint, (WindowRef)ewg_theWindow, (ControlRef*)ewg_theControl);
}

// Return address of function 'FindControl'
void* ewg_get_function_address_FindControl (void)
{
	return (void*) FindControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FindControlUnderMouse'
// For ise
ControlRef  ewg_function_FindControlUnderMouse (Point *ewg_inWhere, WindowRef ewg_inWindow, ControlPartCode *ewg_outPart)
{
	return FindControlUnderMouse (*(Point*)ewg_inWhere, (WindowRef)ewg_inWindow, (ControlPartCode*)ewg_outPart);
}

// Return address of function 'FindControlUnderMouse'
void* ewg_get_function_address_FindControlUnderMouse (void)
{
	return (void*) FindControlUnderMouse;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlClick'
// For ise
ControlPartCode  ewg_function_HandleControlClick (ControlRef ewg_inControl, Point *ewg_inWhere, EventModifiers ewg_inModifiers, ControlActionUPP ewg_inAction)
{
	return HandleControlClick ((ControlRef)ewg_inControl, *(Point*)ewg_inWhere, (EventModifiers)ewg_inModifiers, (ControlActionUPP)ewg_inAction);
}

// Return address of function 'HandleControlClick'
void* ewg_get_function_address_HandleControlClick (void)
{
	return (void*) HandleControlClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlContextualMenuClick'
// For ise
OSStatus  ewg_function_HandleControlContextualMenuClick (ControlRef ewg_inControl, Point *ewg_inWhere, Boolean *ewg_menuDisplayed)
{
	return HandleControlContextualMenuClick ((ControlRef)ewg_inControl, *(Point*)ewg_inWhere, (Boolean*)ewg_menuDisplayed);
}

// Return address of function 'HandleControlContextualMenuClick'
void* ewg_get_function_address_HandleControlContextualMenuClick (void)
{
	return (void*) HandleControlContextualMenuClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlClickActivation'
// For ise
OSStatus  ewg_function_GetControlClickActivation (ControlRef ewg_inControl, Point *ewg_inWhere, EventModifiers ewg_inModifiers, ClickActivationResult *ewg_outResult)
{
	return GetControlClickActivation ((ControlRef)ewg_inControl, *(Point*)ewg_inWhere, (EventModifiers)ewg_inModifiers, (ClickActivationResult*)ewg_outResult);
}

// Return address of function 'GetControlClickActivation'
void* ewg_get_function_address_GetControlClickActivation (void)
{
	return (void*) GetControlClickActivation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlKey'
// For ise
ControlPartCode  ewg_function_HandleControlKey (ControlRef ewg_inControl, SInt16 ewg_inKeyCode, SInt16 ewg_inCharCode, EventModifiers ewg_inModifiers)
{
	return HandleControlKey ((ControlRef)ewg_inControl, (SInt16)ewg_inKeyCode, (SInt16)ewg_inCharCode, (EventModifiers)ewg_inModifiers);
}

// Return address of function 'HandleControlKey'
void* ewg_get_function_address_HandleControlKey (void)
{
	return (void*) HandleControlKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlSetCursor'
// For ise
OSStatus  ewg_function_HandleControlSetCursor (ControlRef ewg_control, Point *ewg_localPoint, EventModifiers ewg_modifiers, Boolean *ewg_cursorWasSet)
{
	return HandleControlSetCursor ((ControlRef)ewg_control, *(Point*)ewg_localPoint, (EventModifiers)ewg_modifiers, (Boolean*)ewg_cursorWasSet);
}

// Return address of function 'HandleControlSetCursor'
void* ewg_get_function_address_HandleControlSetCursor (void)
{
	return (void*) HandleControlSetCursor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveControl'
// For ise
void  ewg_function_MoveControl (ControlRef ewg_theControl, SInt16 ewg_h, SInt16 ewg_v)
{
	MoveControl ((ControlRef)ewg_theControl, (SInt16)ewg_h, (SInt16)ewg_v);
}

// Return address of function 'MoveControl'
void* ewg_get_function_address_MoveControl (void)
{
	return (void*) MoveControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SizeControl'
// For ise
void  ewg_function_SizeControl (ControlRef ewg_theControl, SInt16 ewg_w, SInt16 ewg_h)
{
	SizeControl ((ControlRef)ewg_theControl, (SInt16)ewg_w, (SInt16)ewg_h);
}

// Return address of function 'SizeControl'
void* ewg_get_function_address_SizeControl (void)
{
	return (void*) SizeControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlTitle'
// For ise
void  ewg_function_SetControlTitle (ControlRef ewg_theControl, ConstStr255Param ewg_title)
{
	SetControlTitle ((ControlRef)ewg_theControl, (ConstStr255Param)ewg_title);
}

// Return address of function 'SetControlTitle'
void* ewg_get_function_address_SetControlTitle (void)
{
	return (void*) SetControlTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlTitle'
// For ise
void  ewg_function_GetControlTitle (ControlRef ewg_theControl, void *ewg_title)
{
	GetControlTitle ((ControlRef)ewg_theControl, ewg_title);
}

// Return address of function 'GetControlTitle'
void* ewg_get_function_address_GetControlTitle (void)
{
	return (void*) GetControlTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlTitleWithCFString'
// For ise
OSStatus  ewg_function_SetControlTitleWithCFString (ControlRef ewg_inControl, CFStringRef ewg_inString)
{
	return SetControlTitleWithCFString ((ControlRef)ewg_inControl, (CFStringRef)ewg_inString);
}

// Return address of function 'SetControlTitleWithCFString'
void* ewg_get_function_address_SetControlTitleWithCFString (void)
{
	return (void*) SetControlTitleWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyControlTitleAsCFString'
// For ise
OSStatus  ewg_function_CopyControlTitleAsCFString (ControlRef ewg_inControl, CFStringRef *ewg_outString)
{
	return CopyControlTitleAsCFString ((ControlRef)ewg_inControl, (CFStringRef*)ewg_outString);
}

// Return address of function 'CopyControlTitleAsCFString'
void* ewg_get_function_address_CopyControlTitleAsCFString (void)
{
	return (void*) CopyControlTitleAsCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlValue'
// For ise
SInt16  ewg_function_GetControlValue (ControlRef ewg_theControl)
{
	return GetControlValue ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlValue'
void* ewg_get_function_address_GetControlValue (void)
{
	return (void*) GetControlValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlValue'
// For ise
void  ewg_function_SetControlValue (ControlRef ewg_theControl, SInt16 ewg_newValue)
{
	SetControlValue ((ControlRef)ewg_theControl, (SInt16)ewg_newValue);
}

// Return address of function 'SetControlValue'
void* ewg_get_function_address_SetControlValue (void)
{
	return (void*) SetControlValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlMinimum'
// For ise
SInt16  ewg_function_GetControlMinimum (ControlRef ewg_theControl)
{
	return GetControlMinimum ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlMinimum'
void* ewg_get_function_address_GetControlMinimum (void)
{
	return (void*) GetControlMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlMinimum'
// For ise
void  ewg_function_SetControlMinimum (ControlRef ewg_theControl, SInt16 ewg_newMinimum)
{
	SetControlMinimum ((ControlRef)ewg_theControl, (SInt16)ewg_newMinimum);
}

// Return address of function 'SetControlMinimum'
void* ewg_get_function_address_SetControlMinimum (void)
{
	return (void*) SetControlMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlMaximum'
// For ise
SInt16  ewg_function_GetControlMaximum (ControlRef ewg_theControl)
{
	return GetControlMaximum ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlMaximum'
void* ewg_get_function_address_GetControlMaximum (void)
{
	return (void*) GetControlMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlMaximum'
// For ise
void  ewg_function_SetControlMaximum (ControlRef ewg_theControl, SInt16 ewg_newMaximum)
{
	SetControlMaximum ((ControlRef)ewg_theControl, (SInt16)ewg_newMaximum);
}

// Return address of function 'SetControlMaximum'
void* ewg_get_function_address_SetControlMaximum (void)
{
	return (void*) SetControlMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlViewSize'
// For ise
SInt32  ewg_function_GetControlViewSize (ControlRef ewg_theControl)
{
	return GetControlViewSize ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlViewSize'
void* ewg_get_function_address_GetControlViewSize (void)
{
	return (void*) GetControlViewSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlViewSize'
// For ise
void  ewg_function_SetControlViewSize (ControlRef ewg_theControl, SInt32 ewg_newViewSize)
{
	SetControlViewSize ((ControlRef)ewg_theControl, (SInt32)ewg_newViewSize);
}

// Return address of function 'SetControlViewSize'
void* ewg_get_function_address_SetControlViewSize (void)
{
	return (void*) SetControlViewSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControl32BitValue'
// For ise
SInt32  ewg_function_GetControl32BitValue (ControlRef ewg_theControl)
{
	return GetControl32BitValue ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControl32BitValue'
void* ewg_get_function_address_GetControl32BitValue (void)
{
	return (void*) GetControl32BitValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControl32BitValue'
// For ise
void  ewg_function_SetControl32BitValue (ControlRef ewg_theControl, SInt32 ewg_newValue)
{
	SetControl32BitValue ((ControlRef)ewg_theControl, (SInt32)ewg_newValue);
}

// Return address of function 'SetControl32BitValue'
void* ewg_get_function_address_SetControl32BitValue (void)
{
	return (void*) SetControl32BitValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControl32BitMaximum'
// For ise
SInt32  ewg_function_GetControl32BitMaximum (ControlRef ewg_theControl)
{
	return GetControl32BitMaximum ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControl32BitMaximum'
void* ewg_get_function_address_GetControl32BitMaximum (void)
{
	return (void*) GetControl32BitMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControl32BitMaximum'
// For ise
void  ewg_function_SetControl32BitMaximum (ControlRef ewg_theControl, SInt32 ewg_newMaximum)
{
	SetControl32BitMaximum ((ControlRef)ewg_theControl, (SInt32)ewg_newMaximum);
}

// Return address of function 'SetControl32BitMaximum'
void* ewg_get_function_address_SetControl32BitMaximum (void)
{
	return (void*) SetControl32BitMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControl32BitMinimum'
// For ise
SInt32  ewg_function_GetControl32BitMinimum (ControlRef ewg_theControl)
{
	return GetControl32BitMinimum ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControl32BitMinimum'
void* ewg_get_function_address_GetControl32BitMinimum (void)
{
	return (void*) GetControl32BitMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControl32BitMinimum'
// For ise
void  ewg_function_SetControl32BitMinimum (ControlRef ewg_theControl, SInt32 ewg_newMinimum)
{
	SetControl32BitMinimum ((ControlRef)ewg_theControl, (SInt32)ewg_newMinimum);
}

// Return address of function 'SetControl32BitMinimum'
void* ewg_get_function_address_SetControl32BitMinimum (void)
{
	return (void*) SetControl32BitMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsValidControlHandle'
// For ise
Boolean  ewg_function_IsValidControlHandle (ControlRef ewg_theControl)
{
	return IsValidControlHandle ((ControlRef)ewg_theControl);
}

// Return address of function 'IsValidControlHandle'
void* ewg_get_function_address_IsValidControlHandle (void)
{
	return (void*) IsValidControlHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlID'
// For ise
OSStatus  ewg_function_SetControlID (ControlRef ewg_inControl, ControlID const *ewg_inID)
{
	return SetControlID ((ControlRef)ewg_inControl, (ControlID const*)ewg_inID);
}

// Return address of function 'SetControlID'
void* ewg_get_function_address_SetControlID (void)
{
	return (void*) SetControlID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlID'
// For ise
OSStatus  ewg_function_GetControlID (ControlRef ewg_inControl, ControlID *ewg_outID)
{
	return GetControlID ((ControlRef)ewg_inControl, (ControlID*)ewg_outID);
}

// Return address of function 'GetControlID'
void* ewg_get_function_address_GetControlID (void)
{
	return (void*) GetControlID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlByID'
// For ise
OSStatus  ewg_function_GetControlByID (WindowRef ewg_inWindow, ControlID const *ewg_inID, ControlRef *ewg_outControl)
{
	return GetControlByID ((WindowRef)ewg_inWindow, (ControlID const*)ewg_inID, (ControlRef*)ewg_outControl);
}

// Return address of function 'GetControlByID'
void* ewg_get_function_address_GetControlByID (void)
{
	return (void*) GetControlByID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlCommandID'
// For ise
OSStatus  ewg_function_SetControlCommandID (ControlRef ewg_inControl, UInt32 ewg_inCommandID)
{
	return SetControlCommandID ((ControlRef)ewg_inControl, (UInt32)ewg_inCommandID);
}

// Return address of function 'SetControlCommandID'
void* ewg_get_function_address_SetControlCommandID (void)
{
	return (void*) SetControlCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlCommandID'
// For ise
OSStatus  ewg_function_GetControlCommandID (ControlRef ewg_inControl, UInt32 *ewg_outCommandID)
{
	return GetControlCommandID ((ControlRef)ewg_inControl, (UInt32*)ewg_outCommandID);
}

// Return address of function 'GetControlCommandID'
void* ewg_get_function_address_GetControlCommandID (void)
{
	return (void*) GetControlCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlKind'
// For ise
OSStatus  ewg_function_GetControlKind (ControlRef ewg_inControl, ControlKind *ewg_outControlKind)
{
	return GetControlKind ((ControlRef)ewg_inControl, (ControlKind*)ewg_outControlKind);
}

// Return address of function 'GetControlKind'
void* ewg_get_function_address_GetControlKind (void)
{
	return (void*) GetControlKind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlProperty'
// For ise
OSStatus  ewg_function_GetControlProperty (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_bufferSize, UInt32 *ewg_actualSize, void *ewg_propertyBuffer)
{
	return GetControlProperty ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_bufferSize, (UInt32*)ewg_actualSize, (void*)ewg_propertyBuffer);
}

// Return address of function 'GetControlProperty'
void* ewg_get_function_address_GetControlProperty (void)
{
	return (void*) GetControlProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlPropertySize'
// For ise
OSStatus  ewg_function_GetControlPropertySize (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 *ewg_size)
{
	return GetControlPropertySize ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32*)ewg_size);
}

// Return address of function 'GetControlPropertySize'
void* ewg_get_function_address_GetControlPropertySize (void)
{
	return (void*) GetControlPropertySize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlProperty'
// For ise
OSStatus  ewg_function_SetControlProperty (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_propertySize, void const *ewg_propertyData)
{
	return SetControlProperty ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_propertySize, (void const*)ewg_propertyData);
}

// Return address of function 'SetControlProperty'
void* ewg_get_function_address_SetControlProperty (void)
{
	return (void*) SetControlProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveControlProperty'
// For ise
OSStatus  ewg_function_RemoveControlProperty (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag)
{
	return RemoveControlProperty ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag);
}

// Return address of function 'RemoveControlProperty'
void* ewg_get_function_address_RemoveControlProperty (void)
{
	return (void*) RemoveControlProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlPropertyAttributes'
// For ise
OSStatus  ewg_function_GetControlPropertyAttributes (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 *ewg_attributes)
{
	return GetControlPropertyAttributes ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32*)ewg_attributes);
}

// Return address of function 'GetControlPropertyAttributes'
void* ewg_get_function_address_GetControlPropertyAttributes (void)
{
	return (void*) GetControlPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeControlPropertyAttributes'
// For ise
OSStatus  ewg_function_ChangeControlPropertyAttributes (ControlRef ewg_control, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_attributesToSet, UInt32 ewg_attributesToClear)
{
	return ChangeControlPropertyAttributes ((ControlRef)ewg_control, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_attributesToSet, (UInt32)ewg_attributesToClear);
}

// Return address of function 'ChangeControlPropertyAttributes'
void* ewg_get_function_address_ChangeControlPropertyAttributes (void)
{
	return (void*) ChangeControlPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlRegion'
// For ise
OSStatus  ewg_function_GetControlRegion (ControlRef ewg_inControl, ControlPartCode ewg_inPart, RgnHandle ewg_outRegion)
{
	return GetControlRegion ((ControlRef)ewg_inControl, (ControlPartCode)ewg_inPart, (RgnHandle)ewg_outRegion);
}

// Return address of function 'GetControlRegion'
void* ewg_get_function_address_GetControlRegion (void)
{
	return (void*) GetControlRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlVariant'
// For ise
ControlVariant  ewg_function_GetControlVariant (ControlRef ewg_theControl)
{
	return GetControlVariant ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlVariant'
void* ewg_get_function_address_GetControlVariant (void)
{
	return (void*) GetControlVariant;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlAction'
// For ise
void  ewg_function_SetControlAction (ControlRef ewg_theControl, ControlActionUPP ewg_actionProc)
{
	SetControlAction ((ControlRef)ewg_theControl, (ControlActionUPP)ewg_actionProc);
}

// Return address of function 'SetControlAction'
void* ewg_get_function_address_SetControlAction (void)
{
	return (void*) SetControlAction;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlAction'
// For ise
ControlActionUPP  ewg_function_GetControlAction (ControlRef ewg_theControl)
{
	return GetControlAction ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlAction'
void* ewg_get_function_address_GetControlAction (void)
{
	return (void*) GetControlAction;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlReference'
// For ise
void  ewg_function_SetControlReference (ControlRef ewg_theControl, SInt32 ewg_data)
{
	SetControlReference ((ControlRef)ewg_theControl, (SInt32)ewg_data);
}

// Return address of function 'SetControlReference'
void* ewg_get_function_address_SetControlReference (void)
{
	return (void*) SetControlReference;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlReference'
// For ise
SInt32  ewg_function_GetControlReference (ControlRef ewg_theControl)
{
	return GetControlReference ((ControlRef)ewg_theControl);
}

// Return address of function 'GetControlReference'
void* ewg_get_function_address_GetControlReference (void)
{
	return (void*) GetControlReference;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SendControlMessage'
// For ise
SInt32  ewg_function_SendControlMessage (ControlRef ewg_inControl, SInt16 ewg_inMessage, void *ewg_inParam)
{
	return SendControlMessage ((ControlRef)ewg_inControl, (SInt16)ewg_inMessage, (void*)ewg_inParam);
}

// Return address of function 'SendControlMessage'
void* ewg_get_function_address_SendControlMessage (void)
{
	return (void*) SendControlMessage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DumpControlHierarchy'
// For ise
OSErr  ewg_function_DumpControlHierarchy (WindowRef ewg_inWindow, FSSpec const *ewg_inDumpFile)
{
	return DumpControlHierarchy ((WindowRef)ewg_inWindow, (FSSpec const*)ewg_inDumpFile);
}

// Return address of function 'DumpControlHierarchy'
void* ewg_get_function_address_DumpControlHierarchy (void)
{
	return (void*) DumpControlHierarchy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateRootControl'
// For ise
OSErr  ewg_function_CreateRootControl (WindowRef ewg_inWindow, ControlRef *ewg_outControl)
{
	return CreateRootControl ((WindowRef)ewg_inWindow, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateRootControl'
void* ewg_get_function_address_CreateRootControl (void)
{
	return (void*) CreateRootControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetRootControl'
// For ise
OSErr  ewg_function_GetRootControl (WindowRef ewg_inWindow, ControlRef *ewg_outControl)
{
	return GetRootControl ((WindowRef)ewg_inWindow, (ControlRef*)ewg_outControl);
}

// Return address of function 'GetRootControl'
void* ewg_get_function_address_GetRootControl (void)
{
	return (void*) GetRootControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EmbedControl'
// For ise
OSErr  ewg_function_EmbedControl (ControlRef ewg_inControl, ControlRef ewg_inContainer)
{
	return EmbedControl ((ControlRef)ewg_inControl, (ControlRef)ewg_inContainer);
}

// Return address of function 'EmbedControl'
void* ewg_get_function_address_EmbedControl (void)
{
	return (void*) EmbedControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AutoEmbedControl'
// For ise
OSErr  ewg_function_AutoEmbedControl (ControlRef ewg_inControl, WindowRef ewg_inWindow)
{
	return AutoEmbedControl ((ControlRef)ewg_inControl, (WindowRef)ewg_inWindow);
}

// Return address of function 'AutoEmbedControl'
void* ewg_get_function_address_AutoEmbedControl (void)
{
	return (void*) AutoEmbedControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetSuperControl'
// For ise
OSErr  ewg_function_GetSuperControl (ControlRef ewg_inControl, ControlRef *ewg_outParent)
{
	return GetSuperControl ((ControlRef)ewg_inControl, (ControlRef*)ewg_outParent);
}

// Return address of function 'GetSuperControl'
void* ewg_get_function_address_GetSuperControl (void)
{
	return (void*) GetSuperControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CountSubControls'
// For ise
OSErr  ewg_function_CountSubControls (ControlRef ewg_inControl, UInt16 *ewg_outNumChildren)
{
	return CountSubControls ((ControlRef)ewg_inControl, (UInt16*)ewg_outNumChildren);
}

// Return address of function 'CountSubControls'
void* ewg_get_function_address_CountSubControls (void)
{
	return (void*) CountSubControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetIndexedSubControl'
// For ise
OSErr  ewg_function_GetIndexedSubControl (ControlRef ewg_inControl, UInt16 ewg_inIndex, ControlRef *ewg_outSubControl)
{
	return GetIndexedSubControl ((ControlRef)ewg_inControl, (UInt16)ewg_inIndex, (ControlRef*)ewg_outSubControl);
}

// Return address of function 'GetIndexedSubControl'
void* ewg_get_function_address_GetIndexedSubControl (void)
{
	return (void*) GetIndexedSubControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlSupervisor'
// For ise
OSErr  ewg_function_SetControlSupervisor (ControlRef ewg_inControl, ControlRef ewg_inBoss)
{
	return SetControlSupervisor ((ControlRef)ewg_inControl, (ControlRef)ewg_inBoss);
}

// Return address of function 'SetControlSupervisor'
void* ewg_get_function_address_SetControlSupervisor (void)
{
	return (void*) SetControlSupervisor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetKeyboardFocus'
// For ise
OSErr  ewg_function_GetKeyboardFocus (WindowRef ewg_inWindow, ControlRef *ewg_outControl)
{
	return GetKeyboardFocus ((WindowRef)ewg_inWindow, (ControlRef*)ewg_outControl);
}

// Return address of function 'GetKeyboardFocus'
void* ewg_get_function_address_GetKeyboardFocus (void)
{
	return (void*) GetKeyboardFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetKeyboardFocus'
// For ise
OSErr  ewg_function_SetKeyboardFocus (WindowRef ewg_inWindow, ControlRef ewg_inControl, ControlFocusPart ewg_inPart)
{
	return SetKeyboardFocus ((WindowRef)ewg_inWindow, (ControlRef)ewg_inControl, (ControlFocusPart)ewg_inPart);
}

// Return address of function 'SetKeyboardFocus'
void* ewg_get_function_address_SetKeyboardFocus (void)
{
	return (void*) SetKeyboardFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AdvanceKeyboardFocus'
// For ise
OSErr  ewg_function_AdvanceKeyboardFocus (WindowRef ewg_inWindow)
{
	return AdvanceKeyboardFocus ((WindowRef)ewg_inWindow);
}

// Return address of function 'AdvanceKeyboardFocus'
void* ewg_get_function_address_AdvanceKeyboardFocus (void)
{
	return (void*) AdvanceKeyboardFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReverseKeyboardFocus'
// For ise
OSErr  ewg_function_ReverseKeyboardFocus (WindowRef ewg_inWindow)
{
	return ReverseKeyboardFocus ((WindowRef)ewg_inWindow);
}

// Return address of function 'ReverseKeyboardFocus'
void* ewg_get_function_address_ReverseKeyboardFocus (void)
{
	return (void*) ReverseKeyboardFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ClearKeyboardFocus'
// For ise
OSErr  ewg_function_ClearKeyboardFocus (WindowRef ewg_inWindow)
{
	return ClearKeyboardFocus ((WindowRef)ewg_inWindow);
}

// Return address of function 'ClearKeyboardFocus'
void* ewg_get_function_address_ClearKeyboardFocus (void)
{
	return (void*) ClearKeyboardFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlFeatures'
// For ise
OSErr  ewg_function_GetControlFeatures (ControlRef ewg_inControl, UInt32 *ewg_outFeatures)
{
	return GetControlFeatures ((ControlRef)ewg_inControl, (UInt32*)ewg_outFeatures);
}

// Return address of function 'GetControlFeatures'
void* ewg_get_function_address_GetControlFeatures (void)
{
	return (void*) GetControlFeatures;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlData'
// For ise
OSErr  ewg_function_SetControlData (ControlRef ewg_inControl, ControlPartCode ewg_inPart, ResType ewg_inTagName, Size ewg_inSize, void const *ewg_inData)
{
	return SetControlData ((ControlRef)ewg_inControl, (ControlPartCode)ewg_inPart, (ResType)ewg_inTagName, (Size)ewg_inSize, (void const*)ewg_inData);
}

// Return address of function 'SetControlData'
void* ewg_get_function_address_SetControlData (void)
{
	return (void*) SetControlData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlData'
// For ise
OSErr  ewg_function_GetControlData (ControlRef ewg_inControl, ControlPartCode ewg_inPart, ResType ewg_inTagName, Size ewg_inBufferSize, void *ewg_inBuffer, Size *ewg_outActualSize)
{
	return GetControlData ((ControlRef)ewg_inControl, (ControlPartCode)ewg_inPart, (ResType)ewg_inTagName, (Size)ewg_inBufferSize, (void*)ewg_inBuffer, (Size*)ewg_outActualSize);
}

// Return address of function 'GetControlData'
void* ewg_get_function_address_GetControlData (void)
{
	return (void*) GetControlData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlDataSize'
// For ise
OSErr  ewg_function_GetControlDataSize (ControlRef ewg_inControl, ControlPartCode ewg_inPart, ResType ewg_inTagName, Size *ewg_outMaxSize)
{
	return GetControlDataSize ((ControlRef)ewg_inControl, (ControlPartCode)ewg_inPart, (ResType)ewg_inTagName, (Size*)ewg_outMaxSize);
}

// Return address of function 'GetControlDataSize'
void* ewg_get_function_address_GetControlDataSize (void)
{
	return (void*) GetControlDataSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlDragTracking'
// For ise
OSStatus  ewg_function_HandleControlDragTracking (ControlRef ewg_inControl, DragTrackingMessage ewg_inMessage, DragReference ewg_inDrag, Boolean *ewg_outLikesDrag)
{
	return HandleControlDragTracking ((ControlRef)ewg_inControl, (DragTrackingMessage)ewg_inMessage, (DragReference)ewg_inDrag, (Boolean*)ewg_outLikesDrag);
}

// Return address of function 'HandleControlDragTracking'
void* ewg_get_function_address_HandleControlDragTracking (void)
{
	return (void*) HandleControlDragTracking;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HandleControlDragReceive'
// For ise
OSStatus  ewg_function_HandleControlDragReceive (ControlRef ewg_inControl, DragReference ewg_inDrag)
{
	return HandleControlDragReceive ((ControlRef)ewg_inControl, (DragReference)ewg_inDrag);
}

// Return address of function 'HandleControlDragReceive'
void* ewg_get_function_address_HandleControlDragReceive (void)
{
	return (void*) HandleControlDragReceive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlDragTrackingEnabled'
// For ise
OSStatus  ewg_function_SetControlDragTrackingEnabled (ControlRef ewg_inControl, Boolean ewg_inTracks)
{
	return SetControlDragTrackingEnabled ((ControlRef)ewg_inControl, (Boolean)ewg_inTracks);
}

// Return address of function 'SetControlDragTrackingEnabled'
void* ewg_get_function_address_SetControlDragTrackingEnabled (void)
{
	return (void*) SetControlDragTrackingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsControlDragTrackingEnabled'
// For ise
OSStatus  ewg_function_IsControlDragTrackingEnabled (ControlRef ewg_inControl, Boolean *ewg_outTracks)
{
	return IsControlDragTrackingEnabled ((ControlRef)ewg_inControl, (Boolean*)ewg_outTracks);
}

// Return address of function 'IsControlDragTrackingEnabled'
void* ewg_get_function_address_IsControlDragTrackingEnabled (void)
{
	return (void*) IsControlDragTrackingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetAutomaticControlDragTrackingEnabledForWindow'
// For ise
OSStatus  ewg_function_SetAutomaticControlDragTrackingEnabledForWindow (WindowRef ewg_inWindow, Boolean ewg_inTracks)
{
	return SetAutomaticControlDragTrackingEnabledForWindow ((WindowRef)ewg_inWindow, (Boolean)ewg_inTracks);
}

// Return address of function 'SetAutomaticControlDragTrackingEnabledForWindow'
void* ewg_get_function_address_SetAutomaticControlDragTrackingEnabledForWindow (void)
{
	return (void*) SetAutomaticControlDragTrackingEnabledForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsAutomaticControlDragTrackingEnabledForWindow'
// For ise
OSStatus  ewg_function_IsAutomaticControlDragTrackingEnabledForWindow (WindowRef ewg_inWindow, Boolean *ewg_outTracks)
{
	return IsAutomaticControlDragTrackingEnabledForWindow ((WindowRef)ewg_inWindow, (Boolean*)ewg_outTracks);
}

// Return address of function 'IsAutomaticControlDragTrackingEnabledForWindow'
void* ewg_get_function_address_IsAutomaticControlDragTrackingEnabledForWindow (void)
{
	return (void*) IsAutomaticControlDragTrackingEnabledForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlBounds'
// For ise
Rect * ewg_function_GetControlBounds (ControlRef ewg_control, Rect *ewg_bounds)
{
	return GetControlBounds ((ControlRef)ewg_control, (Rect*)ewg_bounds);
}

// Return address of function 'GetControlBounds'
void* ewg_get_function_address_GetControlBounds (void)
{
	return (void*) GetControlBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsControlHilited'
// For ise
Boolean  ewg_function_IsControlHilited (ControlRef ewg_control)
{
	return IsControlHilited ((ControlRef)ewg_control);
}

// Return address of function 'IsControlHilited'
void* ewg_get_function_address_IsControlHilited (void)
{
	return (void*) IsControlHilited;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlHilite'
// For ise
UInt16  ewg_function_GetControlHilite (ControlRef ewg_control)
{
	return GetControlHilite ((ControlRef)ewg_control);
}

// Return address of function 'GetControlHilite'
void* ewg_get_function_address_GetControlHilite (void)
{
	return (void*) GetControlHilite;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlOwner'
// For ise
WindowRef  ewg_function_GetControlOwner (ControlRef ewg_control)
{
	return GetControlOwner ((ControlRef)ewg_control);
}

// Return address of function 'GetControlOwner'
void* ewg_get_function_address_GetControlOwner (void)
{
	return (void*) GetControlOwner;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlDataHandle'
// For ise
Handle  ewg_function_GetControlDataHandle (ControlRef ewg_control)
{
	return GetControlDataHandle ((ControlRef)ewg_control);
}

// Return address of function 'GetControlDataHandle'
void* ewg_get_function_address_GetControlDataHandle (void)
{
	return (void*) GetControlDataHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlPopupMenuHandle'
// For ise
MenuRef  ewg_function_GetControlPopupMenuHandle (ControlRef ewg_control)
{
	return GetControlPopupMenuHandle ((ControlRef)ewg_control);
}

// Return address of function 'GetControlPopupMenuHandle'
void* ewg_get_function_address_GetControlPopupMenuHandle (void)
{
	return (void*) GetControlPopupMenuHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlPopupMenuID'
// For ise
short  ewg_function_GetControlPopupMenuID (ControlRef ewg_control)
{
	return GetControlPopupMenuID ((ControlRef)ewg_control);
}

// Return address of function 'GetControlPopupMenuID'
void* ewg_get_function_address_GetControlPopupMenuID (void)
{
	return (void*) GetControlPopupMenuID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlDataHandle'
// For ise
void  ewg_function_SetControlDataHandle (ControlRef ewg_control, Handle ewg_dataHandle)
{
	SetControlDataHandle ((ControlRef)ewg_control, (Handle)ewg_dataHandle);
}

// Return address of function 'SetControlDataHandle'
void* ewg_get_function_address_SetControlDataHandle (void)
{
	return (void*) SetControlDataHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlBounds'
// For ise
void  ewg_function_SetControlBounds (ControlRef ewg_control, Rect const *ewg_bounds)
{
	SetControlBounds ((ControlRef)ewg_control, (Rect const*)ewg_bounds);
}

// Return address of function 'SetControlBounds'
void* ewg_get_function_address_SetControlBounds (void)
{
	return (void*) SetControlBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlPopupMenuHandle'
// For ise
void  ewg_function_SetControlPopupMenuHandle (ControlRef ewg_control, MenuRef ewg_popupMenu)
{
	SetControlPopupMenuHandle ((ControlRef)ewg_control, (MenuRef)ewg_popupMenu);
}

// Return address of function 'SetControlPopupMenuHandle'
void* ewg_get_function_address_SetControlPopupMenuHandle (void)
{
	return (void*) SetControlPopupMenuHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetControlPopupMenuID'
// For ise
void  ewg_function_SetControlPopupMenuID (ControlRef ewg_control, short ewg_menuID)
{
	SetControlPopupMenuID ((ControlRef)ewg_control, (short)ewg_menuID);
}

// Return address of function 'SetControlPopupMenuID'
void* ewg_get_function_address_SetControlPopupMenuID (void)
{
	return (void*) SetControlPopupMenuID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IdleControls'
// For ise
void  ewg_function_IdleControls (WindowRef ewg_inWindow)
{
	IdleControls ((WindowRef)ewg_inWindow);
}

// Return address of function 'IdleControls'
void* ewg_get_function_address_IdleControls (void)
{
	return (void*) IdleControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewWindowDefUPP'
// For ise
WindowDefUPP  ewg_function_NewWindowDefUPP (WindowDefProcPtr ewg_userRoutine)
{
	return NewWindowDefUPP ((WindowDefProcPtr)ewg_userRoutine);
}

// Return address of function 'NewWindowDefUPP'
void* ewg_get_function_address_NewWindowDefUPP (void)
{
	return (void*) NewWindowDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewWindowPaintUPP'
// For ise
WindowPaintUPP  ewg_function_NewWindowPaintUPP (WindowPaintProcPtr ewg_userRoutine)
{
	return NewWindowPaintUPP ((WindowPaintProcPtr)ewg_userRoutine);
}

// Return address of function 'NewWindowPaintUPP'
void* ewg_get_function_address_NewWindowPaintUPP (void)
{
	return (void*) NewWindowPaintUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeWindowDefUPP'
// For ise
void  ewg_function_DisposeWindowDefUPP (WindowDefUPP ewg_userUPP)
{
	DisposeWindowDefUPP ((WindowDefUPP)ewg_userUPP);
}

// Return address of function 'DisposeWindowDefUPP'
void* ewg_get_function_address_DisposeWindowDefUPP (void)
{
	return (void*) DisposeWindowDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeWindowPaintUPP'
// For ise
void  ewg_function_DisposeWindowPaintUPP (WindowPaintUPP ewg_userUPP)
{
	DisposeWindowPaintUPP ((WindowPaintUPP)ewg_userUPP);
}

// Return address of function 'DisposeWindowPaintUPP'
void* ewg_get_function_address_DisposeWindowPaintUPP (void)
{
	return (void*) DisposeWindowPaintUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeWindowDefUPP'
// For ise
long  ewg_function_InvokeWindowDefUPP (short ewg_varCode, WindowRef ewg_window, short ewg_message, long ewg_param, WindowDefUPP ewg_userUPP)
{
	return InvokeWindowDefUPP ((short)ewg_varCode, (WindowRef)ewg_window, (short)ewg_message, (long)ewg_param, (WindowDefUPP)ewg_userUPP);
}

// Return address of function 'InvokeWindowDefUPP'
void* ewg_get_function_address_InvokeWindowDefUPP (void)
{
	return (void*) InvokeWindowDefUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeWindowPaintUPP'
// For ise
OSStatus  ewg_function_InvokeWindowPaintUPP (GDHandle ewg_device, GrafPtr ewg_qdContext, WindowRef ewg_window, RgnHandle ewg_inClientPaintRgn, RgnHandle ewg_outSystemPaintRgn, void *ewg_refCon, WindowPaintUPP ewg_userUPP)
{
	return InvokeWindowPaintUPP ((GDHandle)ewg_device, (GrafPtr)ewg_qdContext, (WindowRef)ewg_window, (RgnHandle)ewg_inClientPaintRgn, (RgnHandle)ewg_outSystemPaintRgn, (void*)ewg_refCon, (WindowPaintUPP)ewg_userUPP);
}

// Return address of function 'InvokeWindowPaintUPP'
void* ewg_get_function_address_InvokeWindowPaintUPP (void)
{
	return (void*) InvokeWindowPaintUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNewCWindow'
// For ise
WindowRef  ewg_function_GetNewCWindow (short ewg_windowID, void *ewg_wStorage, WindowRef ewg_behind)
{
	return GetNewCWindow ((short)ewg_windowID, (void*)ewg_wStorage, (WindowRef)ewg_behind);
}

// Return address of function 'GetNewCWindow'
void* ewg_get_function_address_GetNewCWindow (void)
{
	return (void*) GetNewCWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewWindow'
// For ise
WindowRef  ewg_function_NewWindow (void *ewg_wStorage, Rect const *ewg_boundsRect, ConstStr255Param ewg_title, Boolean ewg_visible, short ewg_theProc, WindowRef ewg_behind, Boolean ewg_goAwayFlag, long ewg_refCon)
{
	return NewWindow ((void*)ewg_wStorage, (Rect const*)ewg_boundsRect, (ConstStr255Param)ewg_title, (Boolean)ewg_visible, (short)ewg_theProc, (WindowRef)ewg_behind, (Boolean)ewg_goAwayFlag, (long)ewg_refCon);
}

// Return address of function 'NewWindow'
void* ewg_get_function_address_NewWindow (void)
{
	return (void*) NewWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNewWindow'
// For ise
WindowRef  ewg_function_GetNewWindow (short ewg_windowID, void *ewg_wStorage, WindowRef ewg_behind)
{
	return GetNewWindow ((short)ewg_windowID, (void*)ewg_wStorage, (WindowRef)ewg_behind);
}

// Return address of function 'GetNewWindow'
void* ewg_get_function_address_GetNewWindow (void)
{
	return (void*) GetNewWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewCWindow'
// For ise
WindowRef  ewg_function_NewCWindow (void *ewg_wStorage, Rect const *ewg_boundsRect, ConstStr255Param ewg_title, Boolean ewg_visible, short ewg_procID, WindowRef ewg_behind, Boolean ewg_goAwayFlag, long ewg_refCon)
{
	return NewCWindow ((void*)ewg_wStorage, (Rect const*)ewg_boundsRect, (ConstStr255Param)ewg_title, (Boolean)ewg_visible, (short)ewg_procID, (WindowRef)ewg_behind, (Boolean)ewg_goAwayFlag, (long)ewg_refCon);
}

// Return address of function 'NewCWindow'
void* ewg_get_function_address_NewCWindow (void)
{
	return (void*) NewCWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeWindow'
// For ise
void  ewg_function_DisposeWindow (WindowRef ewg_window)
{
	DisposeWindow ((WindowRef)ewg_window);
}

// Return address of function 'DisposeWindow'
void* ewg_get_function_address_DisposeWindow (void)
{
	return (void*) DisposeWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateNewWindow'
// For ise
OSStatus  ewg_function_CreateNewWindow (WindowClass ewg_windowClass, WindowAttributes ewg_attributes, Rect const *ewg_contentBounds, WindowRef *ewg_outWindow)
{
	return CreateNewWindow ((WindowClass)ewg_windowClass, (WindowAttributes)ewg_attributes, (Rect const*)ewg_contentBounds, (WindowRef*)ewg_outWindow);
}

// Return address of function 'CreateNewWindow'
void* ewg_get_function_address_CreateNewWindow (void)
{
	return (void*) CreateNewWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateWindowFromResource'
// For ise
OSStatus  ewg_function_CreateWindowFromResource (SInt16 ewg_resID, WindowRef *ewg_outWindow)
{
	return CreateWindowFromResource ((SInt16)ewg_resID, (WindowRef*)ewg_outWindow);
}

// Return address of function 'CreateWindowFromResource'
void* ewg_get_function_address_CreateWindowFromResource (void)
{
	return (void*) CreateWindowFromResource;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'StoreWindowIntoCollection'
// For ise
OSStatus  ewg_function_StoreWindowIntoCollection (WindowRef ewg_window, Collection ewg_collection)
{
	return StoreWindowIntoCollection ((WindowRef)ewg_window, (Collection)ewg_collection);
}

// Return address of function 'StoreWindowIntoCollection'
void* ewg_get_function_address_StoreWindowIntoCollection (void)
{
	return (void*) StoreWindowIntoCollection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateWindowFromCollection'
// For ise
OSStatus  ewg_function_CreateWindowFromCollection (Collection ewg_collection, WindowRef *ewg_outWindow)
{
	return CreateWindowFromCollection ((Collection)ewg_collection, (WindowRef*)ewg_outWindow);
}

// Return address of function 'CreateWindowFromCollection'
void* ewg_get_function_address_CreateWindowFromCollection (void)
{
	return (void*) CreateWindowFromCollection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowOwnerCount'
// For ise
OSStatus  ewg_function_GetWindowOwnerCount (WindowRef ewg_window, UInt32 *ewg_outCount)
{
	return GetWindowOwnerCount ((WindowRef)ewg_window, (UInt32*)ewg_outCount);
}

// Return address of function 'GetWindowOwnerCount'
void* ewg_get_function_address_GetWindowOwnerCount (void)
{
	return (void*) GetWindowOwnerCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CloneWindow'
// For ise
OSStatus  ewg_function_CloneWindow (WindowRef ewg_window)
{
	return CloneWindow ((WindowRef)ewg_window);
}

// Return address of function 'CloneWindow'
void* ewg_get_function_address_CloneWindow (void)
{
	return (void*) CloneWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowRetainCount'
// For ise
ItemCount  ewg_function_GetWindowRetainCount (WindowRef ewg_inWindow)
{
	return GetWindowRetainCount ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetWindowRetainCount'
void* ewg_get_function_address_GetWindowRetainCount (void)
{
	return (void*) GetWindowRetainCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RetainWindow'
// For ise
OSStatus  ewg_function_RetainWindow (WindowRef ewg_inWindow)
{
	return RetainWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'RetainWindow'
void* ewg_get_function_address_RetainWindow (void)
{
	return (void*) RetainWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseWindow'
// For ise
OSStatus  ewg_function_ReleaseWindow (WindowRef ewg_inWindow)
{
	return ReleaseWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'ReleaseWindow'
void* ewg_get_function_address_ReleaseWindow (void)
{
	return (void*) ReleaseWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateCustomWindow'
// For ise
OSStatus  ewg_function_CreateCustomWindow (WindowDefSpec const *ewg_def, WindowClass ewg_windowClass, WindowAttributes ewg_attributes, Rect const *ewg_contentBounds, WindowRef *ewg_outWindow)
{
	return CreateCustomWindow ((WindowDefSpec const*)ewg_def, (WindowClass)ewg_windowClass, (WindowAttributes)ewg_attributes, (Rect const*)ewg_contentBounds, (WindowRef*)ewg_outWindow);
}

// Return address of function 'CreateCustomWindow'
void* ewg_get_function_address_CreateCustomWindow (void)
{
	return (void*) CreateCustomWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReshapeCustomWindow'
// For ise
OSStatus  ewg_function_ReshapeCustomWindow (WindowRef ewg_window)
{
	return ReshapeCustomWindow ((WindowRef)ewg_window);
}

// Return address of function 'ReshapeCustomWindow'
void* ewg_get_function_address_ReshapeCustomWindow (void)
{
	return (void*) ReshapeCustomWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RegisterWindowDefinition'
// For ise
OSStatus  ewg_function_RegisterWindowDefinition (SInt16 ewg_inResID, WindowDefSpec const *ewg_inDefSpec)
{
	return RegisterWindowDefinition ((SInt16)ewg_inResID, (WindowDefSpec const*)ewg_inDefSpec);
}

// Return address of function 'RegisterWindowDefinition'
void* ewg_get_function_address_RegisterWindowDefinition (void)
{
	return (void*) RegisterWindowDefinition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowWidgetHilite'
// For ise
OSStatus  ewg_function_GetWindowWidgetHilite (WindowRef ewg_inWindow, WindowDefPartCode *ewg_outHilite)
{
	return GetWindowWidgetHilite ((WindowRef)ewg_inWindow, (WindowDefPartCode*)ewg_outHilite);
}

// Return address of function 'GetWindowWidgetHilite'
void* ewg_get_function_address_GetWindowWidgetHilite (void)
{
	return (void*) GetWindowWidgetHilite;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsValidWindowClass'
// For ise
Boolean  ewg_function_IsValidWindowClass (WindowClass ewg_inClass)
{
	return IsValidWindowClass ((WindowClass)ewg_inClass);
}

// Return address of function 'IsValidWindowClass'
void* ewg_get_function_address_IsValidWindowClass (void)
{
	return (void*) IsValidWindowClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetAvailableWindowAttributes'
// For ise
WindowAttributes  ewg_function_GetAvailableWindowAttributes (WindowClass ewg_inClass)
{
	return GetAvailableWindowAttributes ((WindowClass)ewg_inClass);
}

// Return address of function 'GetAvailableWindowAttributes'
void* ewg_get_function_address_GetAvailableWindowAttributes (void)
{
	return (void*) GetAvailableWindowAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowClass'
// For ise
OSStatus  ewg_function_GetWindowClass (WindowRef ewg_window, WindowClass *ewg_outClass)
{
	return GetWindowClass ((WindowRef)ewg_window, (WindowClass*)ewg_outClass);
}

// Return address of function 'GetWindowClass'
void* ewg_get_function_address_GetWindowClass (void)
{
	return (void*) GetWindowClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowAttributes'
// For ise
OSStatus  ewg_function_GetWindowAttributes (WindowRef ewg_window, WindowAttributes *ewg_outAttributes)
{
	return GetWindowAttributes ((WindowRef)ewg_window, (WindowAttributes*)ewg_outAttributes);
}

// Return address of function 'GetWindowAttributes'
void* ewg_get_function_address_GetWindowAttributes (void)
{
	return (void*) GetWindowAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeWindowAttributes'
// For ise
OSStatus  ewg_function_ChangeWindowAttributes (WindowRef ewg_window, WindowAttributes ewg_setTheseAttributes, WindowAttributes ewg_clearTheseAttributes)
{
	return ChangeWindowAttributes ((WindowRef)ewg_window, (WindowAttributes)ewg_setTheseAttributes, (WindowAttributes)ewg_clearTheseAttributes);
}

// Return address of function 'ChangeWindowAttributes'
void* ewg_get_function_address_ChangeWindowAttributes (void)
{
	return (void*) ChangeWindowAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowClass'
// For ise
OSStatus  ewg_function_SetWindowClass (WindowRef ewg_inWindow, WindowClass ewg_inWindowClass)
{
	return SetWindowClass ((WindowRef)ewg_inWindow, (WindowClass)ewg_inWindowClass);
}

// Return address of function 'SetWindowClass'
void* ewg_get_function_address_SetWindowClass (void)
{
	return (void*) SetWindowClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowChangeClass'
// For ise
OSStatus  ewg_function_HIWindowChangeClass (HIWindowRef ewg_inWindow, WindowClass ewg_inWindowClass)
{
	return HIWindowChangeClass ((HIWindowRef)ewg_inWindow, (WindowClass)ewg_inWindowClass);
}

// Return address of function 'HIWindowChangeClass'
void* ewg_get_function_address_HIWindowChangeClass (void)
{
	return (void*) HIWindowChangeClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowFlush'
// For ise
OSStatus  ewg_function_HIWindowFlush (HIWindowRef ewg_inWindow)
{
	return HIWindowFlush ((HIWindowRef)ewg_inWindow);
}

// Return address of function 'HIWindowFlush'
void* ewg_get_function_address_HIWindowFlush (void)
{
	return (void*) HIWindowFlush;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowModality'
// For ise
OSStatus  ewg_function_SetWindowModality (WindowRef ewg_inWindow, WindowModality ewg_inModalKind, WindowRef ewg_inUnavailableWindow)
{
	return SetWindowModality ((WindowRef)ewg_inWindow, (WindowModality)ewg_inModalKind, (WindowRef)ewg_inUnavailableWindow);
}

// Return address of function 'SetWindowModality'
void* ewg_get_function_address_SetWindowModality (void)
{
	return (void*) SetWindowModality;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowModality'
// For ise
OSStatus  ewg_function_GetWindowModality (WindowRef ewg_inWindow, WindowModality *ewg_outModalKind, WindowRef *ewg_outUnavailableWindow)
{
	return GetWindowModality ((WindowRef)ewg_inWindow, (WindowModality*)ewg_outModalKind, (WindowRef*)ewg_outUnavailableWindow);
}

// Return address of function 'GetWindowModality'
void* ewg_get_function_address_GetWindowModality (void)
{
	return (void*) GetWindowModality;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowIsDocumentModalTarget'
// For ise
Boolean  ewg_function_HIWindowIsDocumentModalTarget (HIWindowRef ewg_inWindow, HIWindowRef *ewg_outOwner)
{
	return HIWindowIsDocumentModalTarget ((HIWindowRef)ewg_inWindow, (HIWindowRef*)ewg_outOwner);
}

// Return address of function 'HIWindowIsDocumentModalTarget'
void* ewg_get_function_address_HIWindowIsDocumentModalTarget (void)
{
	return (void*) HIWindowIsDocumentModalTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowFloatingWindows'
// For ise
OSStatus  ewg_function_ShowFloatingWindows (void)
{
	return ShowFloatingWindows ();
}

// Return address of function 'ShowFloatingWindows'
void* ewg_get_function_address_ShowFloatingWindows (void)
{
	return (void*) ShowFloatingWindows;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HideFloatingWindows'
// For ise
OSStatus  ewg_function_HideFloatingWindows (void)
{
	return HideFloatingWindows ();
}

// Return address of function 'HideFloatingWindows'
void* ewg_get_function_address_HideFloatingWindows (void)
{
	return (void*) HideFloatingWindows;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AreFloatingWindowsVisible'
// For ise
Boolean  ewg_function_AreFloatingWindowsVisible (void)
{
	return AreFloatingWindowsVisible ();
}

// Return address of function 'AreFloatingWindowsVisible'
void* ewg_get_function_address_AreFloatingWindowsVisible (void)
{
	return (void*) AreFloatingWindowsVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateWindowGroup'
// For ise
OSStatus  ewg_function_CreateWindowGroup (WindowGroupAttributes ewg_inAttributes, WindowGroupRef *ewg_outGroup)
{
	return CreateWindowGroup ((WindowGroupAttributes)ewg_inAttributes, (WindowGroupRef*)ewg_outGroup);
}

// Return address of function 'CreateWindowGroup'
void* ewg_get_function_address_CreateWindowGroup (void)
{
	return (void*) CreateWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RetainWindowGroup'
// For ise
OSStatus  ewg_function_RetainWindowGroup (WindowGroupRef ewg_inGroup)
{
	return RetainWindowGroup ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'RetainWindowGroup'
void* ewg_get_function_address_RetainWindowGroup (void)
{
	return (void*) RetainWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseWindowGroup'
// For ise
OSStatus  ewg_function_ReleaseWindowGroup (WindowGroupRef ewg_inGroup)
{
	return ReleaseWindowGroup ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'ReleaseWindowGroup'
void* ewg_get_function_address_ReleaseWindowGroup (void)
{
	return (void*) ReleaseWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupRetainCount'
// For ise
ItemCount  ewg_function_GetWindowGroupRetainCount (WindowGroupRef ewg_inGroup)
{
	return GetWindowGroupRetainCount ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'GetWindowGroupRetainCount'
void* ewg_get_function_address_GetWindowGroupRetainCount (void)
{
	return (void*) GetWindowGroupRetainCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupOfClass'
// For ise
WindowGroupRef  ewg_function_GetWindowGroupOfClass (WindowClass ewg_windowClass)
{
	return GetWindowGroupOfClass ((WindowClass)ewg_windowClass);
}

// Return address of function 'GetWindowGroupOfClass'
void* ewg_get_function_address_GetWindowGroupOfClass (void)
{
	return (void*) GetWindowGroupOfClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroupName'
// For ise
OSStatus  ewg_function_SetWindowGroupName (WindowGroupRef ewg_inGroup, CFStringRef ewg_inName)
{
	return SetWindowGroupName ((WindowGroupRef)ewg_inGroup, (CFStringRef)ewg_inName);
}

// Return address of function 'SetWindowGroupName'
void* ewg_get_function_address_SetWindowGroupName (void)
{
	return (void*) SetWindowGroupName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyWindowGroupName'
// For ise
OSStatus  ewg_function_CopyWindowGroupName (WindowGroupRef ewg_inGroup, CFStringRef *ewg_outName)
{
	return CopyWindowGroupName ((WindowGroupRef)ewg_inGroup, (CFStringRef*)ewg_outName);
}

// Return address of function 'CopyWindowGroupName'
void* ewg_get_function_address_CopyWindowGroupName (void)
{
	return (void*) CopyWindowGroupName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupAttributes'
// For ise
OSStatus  ewg_function_GetWindowGroupAttributes (WindowGroupRef ewg_inGroup, WindowGroupAttributes *ewg_outAttributes)
{
	return GetWindowGroupAttributes ((WindowGroupRef)ewg_inGroup, (WindowGroupAttributes*)ewg_outAttributes);
}

// Return address of function 'GetWindowGroupAttributes'
void* ewg_get_function_address_GetWindowGroupAttributes (void)
{
	return (void*) GetWindowGroupAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeWindowGroupAttributes'
// For ise
OSStatus  ewg_function_ChangeWindowGroupAttributes (WindowGroupRef ewg_inGroup, WindowGroupAttributes ewg_setTheseAttributes, WindowGroupAttributes ewg_clearTheseAttributes)
{
	return ChangeWindowGroupAttributes ((WindowGroupRef)ewg_inGroup, (WindowGroupAttributes)ewg_setTheseAttributes, (WindowGroupAttributes)ewg_clearTheseAttributes);
}

// Return address of function 'ChangeWindowGroupAttributes'
void* ewg_get_function_address_ChangeWindowGroupAttributes (void)
{
	return (void*) ChangeWindowGroupAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroupLevel'
// For ise
OSStatus  ewg_function_SetWindowGroupLevel (WindowGroupRef ewg_inGroup, SInt32 ewg_inLevel)
{
	return SetWindowGroupLevel ((WindowGroupRef)ewg_inGroup, (SInt32)ewg_inLevel);
}

// Return address of function 'SetWindowGroupLevel'
void* ewg_get_function_address_SetWindowGroupLevel (void)
{
	return (void*) SetWindowGroupLevel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupLevel'
// For ise
OSStatus  ewg_function_GetWindowGroupLevel (WindowGroupRef ewg_inGroup, SInt32 *ewg_outLevel)
{
	return GetWindowGroupLevel ((WindowGroupRef)ewg_inGroup, (SInt32*)ewg_outLevel);
}

// Return address of function 'GetWindowGroupLevel'
void* ewg_get_function_address_GetWindowGroupLevel (void)
{
	return (void*) GetWindowGroupLevel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroupLevelOfType'
// For ise
OSStatus  ewg_function_SetWindowGroupLevelOfType (WindowGroupRef ewg_inGroup, UInt32 ewg_inLevelType, CGWindowLevel ewg_inLevel)
{
	return SetWindowGroupLevelOfType ((WindowGroupRef)ewg_inGroup, (UInt32)ewg_inLevelType, (CGWindowLevel)ewg_inLevel);
}

// Return address of function 'SetWindowGroupLevelOfType'
void* ewg_get_function_address_SetWindowGroupLevelOfType (void)
{
	return (void*) SetWindowGroupLevelOfType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupLevelOfType'
// For ise
OSStatus  ewg_function_GetWindowGroupLevelOfType (WindowGroupRef ewg_inGroup, UInt32 ewg_inLevelType, CGWindowLevel *ewg_outLevel)
{
	return GetWindowGroupLevelOfType ((WindowGroupRef)ewg_inGroup, (UInt32)ewg_inLevelType, (CGWindowLevel*)ewg_outLevel);
}

// Return address of function 'GetWindowGroupLevelOfType'
void* ewg_get_function_address_GetWindowGroupLevelOfType (void)
{
	return (void*) GetWindowGroupLevelOfType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SendWindowGroupBehind'
// For ise
OSStatus  ewg_function_SendWindowGroupBehind (WindowGroupRef ewg_inGroup, WindowGroupRef ewg_behindGroup)
{
	return SendWindowGroupBehind ((WindowGroupRef)ewg_inGroup, (WindowGroupRef)ewg_behindGroup);
}

// Return address of function 'SendWindowGroupBehind'
void* ewg_get_function_address_SendWindowGroupBehind (void)
{
	return (void*) SendWindowGroupBehind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroup'
// For ise
WindowGroupRef  ewg_function_GetWindowGroup (WindowRef ewg_inWindow)
{
	return GetWindowGroup ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetWindowGroup'
void* ewg_get_function_address_GetWindowGroup (void)
{
	return (void*) GetWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroup'
// For ise
OSStatus  ewg_function_SetWindowGroup (WindowRef ewg_inWindow, WindowGroupRef ewg_inNewGroup)
{
	return SetWindowGroup ((WindowRef)ewg_inWindow, (WindowGroupRef)ewg_inNewGroup);
}

// Return address of function 'SetWindowGroup'
void* ewg_get_function_address_SetWindowGroup (void)
{
	return (void*) SetWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowContainedInGroup'
// For ise
Boolean  ewg_function_IsWindowContainedInGroup (WindowRef ewg_inWindow, WindowGroupRef ewg_inGroup)
{
	return IsWindowContainedInGroup ((WindowRef)ewg_inWindow, (WindowGroupRef)ewg_inGroup);
}

// Return address of function 'IsWindowContainedInGroup'
void* ewg_get_function_address_IsWindowContainedInGroup (void)
{
	return (void*) IsWindowContainedInGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupParent'
// For ise
WindowGroupRef  ewg_function_GetWindowGroupParent (WindowGroupRef ewg_inGroup)
{
	return GetWindowGroupParent ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'GetWindowGroupParent'
void* ewg_get_function_address_GetWindowGroupParent (void)
{
	return (void*) GetWindowGroupParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroupParent'
// For ise
OSStatus  ewg_function_SetWindowGroupParent (WindowGroupRef ewg_inGroup, WindowGroupRef ewg_inNewGroup)
{
	return SetWindowGroupParent ((WindowGroupRef)ewg_inGroup, (WindowGroupRef)ewg_inNewGroup);
}

// Return address of function 'SetWindowGroupParent'
void* ewg_get_function_address_SetWindowGroupParent (void)
{
	return (void*) SetWindowGroupParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupSibling'
// For ise
WindowGroupRef  ewg_function_GetWindowGroupSibling (WindowGroupRef ewg_inGroup, Boolean ewg_inNextGroup)
{
	return GetWindowGroupSibling ((WindowGroupRef)ewg_inGroup, (Boolean)ewg_inNextGroup);
}

// Return address of function 'GetWindowGroupSibling'
void* ewg_get_function_address_GetWindowGroupSibling (void)
{
	return (void*) GetWindowGroupSibling;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupOwner'
// For ise
WindowRef  ewg_function_GetWindowGroupOwner (WindowGroupRef ewg_inGroup)
{
	return GetWindowGroupOwner ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'GetWindowGroupOwner'
void* ewg_get_function_address_GetWindowGroupOwner (void)
{
	return (void*) GetWindowGroupOwner;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowGroupOwner'
// For ise
OSStatus  ewg_function_SetWindowGroupOwner (WindowGroupRef ewg_inGroup, WindowRef ewg_inWindow)
{
	return SetWindowGroupOwner ((WindowGroupRef)ewg_inGroup, (WindowRef)ewg_inWindow);
}

// Return address of function 'SetWindowGroupOwner'
void* ewg_get_function_address_SetWindowGroupOwner (void)
{
	return (void*) SetWindowGroupOwner;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CountWindowGroupContents'
// For ise
ItemCount  ewg_function_CountWindowGroupContents (WindowGroupRef ewg_inGroup, WindowGroupContentOptions ewg_inOptions)
{
	return CountWindowGroupContents ((WindowGroupRef)ewg_inGroup, (WindowGroupContentOptions)ewg_inOptions);
}

// Return address of function 'CountWindowGroupContents'
void* ewg_get_function_address_CountWindowGroupContents (void)
{
	return (void*) CountWindowGroupContents;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGroupContents'
// For ise
OSStatus  ewg_function_GetWindowGroupContents (WindowGroupRef ewg_inGroup, WindowGroupContentOptions ewg_inOptions, ItemCount ewg_inAllowedItems, ItemCount *ewg_outNumItems, void **ewg_outItems)
{
	return GetWindowGroupContents ((WindowGroupRef)ewg_inGroup, (WindowGroupContentOptions)ewg_inOptions, (ItemCount)ewg_inAllowedItems, (ItemCount*)ewg_outNumItems, (void**)ewg_outItems);
}

// Return address of function 'GetWindowGroupContents'
void* ewg_get_function_address_GetWindowGroupContents (void)
{
	return (void*) GetWindowGroupContents;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetIndexedWindow'
// For ise
OSStatus  ewg_function_GetIndexedWindow (WindowGroupRef ewg_inGroup, UInt32 ewg_inIndex, WindowGroupContentOptions ewg_inOptions, WindowRef *ewg_outWindow)
{
	return GetIndexedWindow ((WindowGroupRef)ewg_inGroup, (UInt32)ewg_inIndex, (WindowGroupContentOptions)ewg_inOptions, (WindowRef*)ewg_outWindow);
}

// Return address of function 'GetIndexedWindow'
void* ewg_get_function_address_GetIndexedWindow (void)
{
	return (void*) GetIndexedWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowIndex'
// For ise
OSStatus  ewg_function_GetWindowIndex (WindowRef ewg_inWindow, WindowGroupRef ewg_inStartGroup, WindowGroupContentOptions ewg_inOptions, UInt32 *ewg_outIndex)
{
	return GetWindowIndex ((WindowRef)ewg_inWindow, (WindowGroupRef)ewg_inStartGroup, (WindowGroupContentOptions)ewg_inOptions, (UInt32*)ewg_outIndex);
}

// Return address of function 'GetWindowIndex'
void* ewg_get_function_address_GetWindowIndex (void)
{
	return (void*) GetWindowIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ActiveNonFloatingWindow'
// For ise
WindowRef  ewg_function_ActiveNonFloatingWindow (void)
{
	return ActiveNonFloatingWindow ();
}

// Return address of function 'ActiveNonFloatingWindow'
void* ewg_get_function_address_ActiveNonFloatingWindow (void)
{
	return (void*) ActiveNonFloatingWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowActive'
// For ise
Boolean  ewg_function_IsWindowActive (WindowRef ewg_inWindow)
{
	return IsWindowActive ((WindowRef)ewg_inWindow);
}

// Return address of function 'IsWindowActive'
void* ewg_get_function_address_IsWindowActive (void)
{
	return (void*) IsWindowActive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ActivateWindow'
// For ise
OSStatus  ewg_function_ActivateWindow (WindowRef ewg_inWindow, Boolean ewg_inActivate)
{
	return ActivateWindow ((WindowRef)ewg_inWindow, (Boolean)ewg_inActivate);
}

// Return address of function 'ActivateWindow'
void* ewg_get_function_address_ActivateWindow (void)
{
	return (void*) ActivateWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowActivationScope'
// For ise
OSStatus  ewg_function_GetWindowActivationScope (WindowRef ewg_inWindow, WindowActivationScope *ewg_outScope)
{
	return GetWindowActivationScope ((WindowRef)ewg_inWindow, (WindowActivationScope*)ewg_outScope);
}

// Return address of function 'GetWindowActivationScope'
void* ewg_get_function_address_GetWindowActivationScope (void)
{
	return (void*) GetWindowActivationScope;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowActivationScope'
// For ise
OSStatus  ewg_function_SetWindowActivationScope (WindowRef ewg_inWindow, WindowActivationScope ewg_inScope)
{
	return SetWindowActivationScope ((WindowRef)ewg_inWindow, (WindowActivationScope)ewg_inScope);
}

// Return address of function 'SetWindowActivationScope'
void* ewg_get_function_address_SetWindowActivationScope (void)
{
	return (void*) SetWindowActivationScope;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DebugPrintWindowGroup'
// For ise
void  ewg_function_DebugPrintWindowGroup (WindowGroupRef ewg_inGroup)
{
	DebugPrintWindowGroup ((WindowGroupRef)ewg_inGroup);
}

// Return address of function 'DebugPrintWindowGroup'
void* ewg_get_function_address_DebugPrintWindowGroup (void)
{
	return (void*) DebugPrintWindowGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DebugPrintAllWindowGroups'
// For ise
void  ewg_function_DebugPrintAllWindowGroups (void)
{
	DebugPrintAllWindowGroups ();
}

// Return address of function 'DebugPrintAllWindowGroups'
void* ewg_get_function_address_DebugPrintAllWindowGroups (void)
{
	return (void*) DebugPrintAllWindowGroups;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetThemeWindowBackground'
// For ise
OSStatus  ewg_function_SetThemeWindowBackground (WindowRef ewg_inWindow, ThemeBrush ewg_inBrush, Boolean ewg_inUpdate)
{
	return SetThemeWindowBackground ((WindowRef)ewg_inWindow, (ThemeBrush)ewg_inBrush, (Boolean)ewg_inUpdate);
}

// Return address of function 'SetThemeWindowBackground'
void* ewg_get_function_address_SetThemeWindowBackground (void)
{
	return (void*) SetThemeWindowBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetThemeTextColorForWindow'
// For ise
OSStatus  ewg_function_SetThemeTextColorForWindow (WindowRef ewg_inWindow, Boolean ewg_inActive, SInt16 ewg_inDepth, Boolean ewg_inColorDev)
{
	return SetThemeTextColorForWindow ((WindowRef)ewg_inWindow, (Boolean)ewg_inActive, (SInt16)ewg_inDepth, (Boolean)ewg_inColorDev);
}

// Return address of function 'SetThemeTextColorForWindow'
void* ewg_get_function_address_SetThemeTextColorForWindow (void)
{
	return (void*) SetThemeTextColorForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowContentColor'
// For ise
OSStatus  ewg_function_SetWindowContentColor (WindowRef ewg_window, RGBColor const *ewg_color)
{
	return SetWindowContentColor ((WindowRef)ewg_window, (RGBColor const*)ewg_color);
}

// Return address of function 'SetWindowContentColor'
void* ewg_get_function_address_SetWindowContentColor (void)
{
	return (void*) SetWindowContentColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowContentColor'
// For ise
OSStatus  ewg_function_GetWindowContentColor (WindowRef ewg_window, RGBColor *ewg_color)
{
	return GetWindowContentColor ((WindowRef)ewg_window, (RGBColor*)ewg_color);
}

// Return address of function 'GetWindowContentColor'
void* ewg_get_function_address_GetWindowContentColor (void)
{
	return (void*) GetWindowContentColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowContentPattern'
// For ise
OSStatus  ewg_function_GetWindowContentPattern (WindowRef ewg_window, PixPatHandle ewg_outPixPat)
{
	return GetWindowContentPattern ((WindowRef)ewg_window, (PixPatHandle)ewg_outPixPat);
}

// Return address of function 'GetWindowContentPattern'
void* ewg_get_function_address_GetWindowContentPattern (void)
{
	return (void*) GetWindowContentPattern;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowContentPattern'
// For ise
OSStatus  ewg_function_SetWindowContentPattern (WindowRef ewg_window, PixPatHandle ewg_pixPat)
{
	return SetWindowContentPattern ((WindowRef)ewg_window, (PixPatHandle)ewg_pixPat);
}

// Return address of function 'SetWindowContentPattern'
void* ewg_get_function_address_SetWindowContentPattern (void)
{
	return (void*) SetWindowContentPattern;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InstallWindowContentPaintProc'
// For ise
OSStatus  ewg_function_InstallWindowContentPaintProc (WindowRef ewg_window, WindowPaintUPP ewg_paintProc, WindowPaintProcOptions ewg_options, void *ewg_refCon)
{
	return InstallWindowContentPaintProc ((WindowRef)ewg_window, (WindowPaintUPP)ewg_paintProc, (WindowPaintProcOptions)ewg_options, (void*)ewg_refCon);
}

// Return address of function 'InstallWindowContentPaintProc'
void* ewg_get_function_address_InstallWindowContentPaintProc (void)
{
	return (void*) InstallWindowContentPaintProc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ScrollWindowRect'
// For ise
OSStatus  ewg_function_ScrollWindowRect (WindowRef ewg_inWindow, Rect const *ewg_inScrollRect, SInt16 ewg_inHPixels, SInt16 ewg_inVPixels, ScrollWindowOptions ewg_inOptions, RgnHandle ewg_outExposedRgn)
{
	return ScrollWindowRect ((WindowRef)ewg_inWindow, (Rect const*)ewg_inScrollRect, (SInt16)ewg_inHPixels, (SInt16)ewg_inVPixels, (ScrollWindowOptions)ewg_inOptions, (RgnHandle)ewg_outExposedRgn);
}

// Return address of function 'ScrollWindowRect'
void* ewg_get_function_address_ScrollWindowRect (void)
{
	return (void*) ScrollWindowRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ScrollWindowRegion'
// For ise
OSStatus  ewg_function_ScrollWindowRegion (WindowRef ewg_inWindow, RgnHandle ewg_inScrollRgn, SInt16 ewg_inHPixels, SInt16 ewg_inVPixels, ScrollWindowOptions ewg_inOptions, RgnHandle ewg_outExposedRgn)
{
	return ScrollWindowRegion ((WindowRef)ewg_inWindow, (RgnHandle)ewg_inScrollRgn, (SInt16)ewg_inHPixels, (SInt16)ewg_inVPixels, (ScrollWindowOptions)ewg_inOptions, (RgnHandle)ewg_outExposedRgn);
}

// Return address of function 'ScrollWindowRegion'
void* ewg_get_function_address_ScrollWindowRegion (void)
{
	return (void*) ScrollWindowRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ClipAbove'
// For ise
void  ewg_function_ClipAbove (WindowRef ewg_window)
{
	ClipAbove ((WindowRef)ewg_window);
}

// Return address of function 'ClipAbove'
void* ewg_get_function_address_ClipAbove (void)
{
	return (void*) ClipAbove;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PaintOne'
// For ise
void  ewg_function_PaintOne (WindowRef ewg_window, RgnHandle ewg_clobberedRgn)
{
	PaintOne ((WindowRef)ewg_window, (RgnHandle)ewg_clobberedRgn);
}

// Return address of function 'PaintOne'
void* ewg_get_function_address_PaintOne (void)
{
	return (void*) PaintOne;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PaintBehind'
// For ise
void  ewg_function_PaintBehind (WindowRef ewg_startWindow, RgnHandle ewg_clobberedRgn)
{
	PaintBehind ((WindowRef)ewg_startWindow, (RgnHandle)ewg_clobberedRgn);
}

// Return address of function 'PaintBehind'
void* ewg_get_function_address_PaintBehind (void)
{
	return (void*) PaintBehind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CalcVis'
// For ise
void  ewg_function_CalcVis (WindowRef ewg_window)
{
	CalcVis ((WindowRef)ewg_window);
}

// Return address of function 'CalcVis'
void* ewg_get_function_address_CalcVis (void)
{
	return (void*) CalcVis;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CalcVisBehind'
// For ise
void  ewg_function_CalcVisBehind (WindowRef ewg_startWindow, RgnHandle ewg_clobberedRgn)
{
	CalcVisBehind ((WindowRef)ewg_startWindow, (RgnHandle)ewg_clobberedRgn);
}

// Return address of function 'CalcVisBehind'
void* ewg_get_function_address_CalcVisBehind (void)
{
	return (void*) CalcVisBehind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CheckUpdate'
// For ise
Boolean  ewg_function_CheckUpdate (EventRecord *ewg_theEvent)
{
	return CheckUpdate ((EventRecord*)ewg_theEvent);
}

// Return address of function 'CheckUpdate'
void* ewg_get_function_address_CheckUpdate (void)
{
	return (void*) CheckUpdate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FindWindow'
// For ise
WindowPartCode  ewg_function_FindWindow (Point *ewg_thePoint, WindowRef *ewg_window)
{
	return FindWindow (*(Point*)ewg_thePoint, (WindowRef*)ewg_window);
}

// Return address of function 'FindWindow'
void* ewg_get_function_address_FindWindow (void)
{
	return (void*) FindWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FrontWindow'
// For ise
WindowRef  ewg_function_FrontWindow (void)
{
	return FrontWindow ();
}

// Return address of function 'FrontWindow'
void* ewg_get_function_address_FrontWindow (void)
{
	return (void*) FrontWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'BringToFront'
// For ise
void  ewg_function_BringToFront (WindowRef ewg_window)
{
	BringToFront ((WindowRef)ewg_window);
}

// Return address of function 'BringToFront'
void* ewg_get_function_address_BringToFront (void)
{
	return (void*) BringToFront;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SendBehind'
// For ise
void  ewg_function_SendBehind (WindowRef ewg_window, WindowRef ewg_behindWindow)
{
	SendBehind ((WindowRef)ewg_window, (WindowRef)ewg_behindWindow);
}

// Return address of function 'SendBehind'
void* ewg_get_function_address_SendBehind (void)
{
	return (void*) SendBehind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SelectWindow'
// For ise
void  ewg_function_SelectWindow (WindowRef ewg_window)
{
	SelectWindow ((WindowRef)ewg_window);
}

// Return address of function 'SelectWindow'
void* ewg_get_function_address_SelectWindow (void)
{
	return (void*) SelectWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FrontNonFloatingWindow'
// For ise
WindowRef  ewg_function_FrontNonFloatingWindow (void)
{
	return FrontNonFloatingWindow ();
}

// Return address of function 'FrontNonFloatingWindow'
void* ewg_get_function_address_FrontNonFloatingWindow (void)
{
	return (void*) FrontNonFloatingWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNextWindowOfClass'
// For ise
WindowRef  ewg_function_GetNextWindowOfClass (WindowRef ewg_inWindow, WindowClass ewg_inWindowClass, Boolean ewg_mustBeVisible)
{
	return GetNextWindowOfClass ((WindowRef)ewg_inWindow, (WindowClass)ewg_inWindowClass, (Boolean)ewg_mustBeVisible);
}

// Return address of function 'GetNextWindowOfClass'
void* ewg_get_function_address_GetNextWindowOfClass (void)
{
	return (void*) GetNextWindowOfClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetFrontWindowOfClass'
// For ise
WindowRef  ewg_function_GetFrontWindowOfClass (WindowClass ewg_inWindowClass, Boolean ewg_mustBeVisible)
{
	return GetFrontWindowOfClass ((WindowClass)ewg_inWindowClass, (Boolean)ewg_mustBeVisible);
}

// Return address of function 'GetFrontWindowOfClass'
void* ewg_get_function_address_GetFrontWindowOfClass (void)
{
	return (void*) GetFrontWindowOfClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'FindWindowOfClass'
// For ise
OSStatus  ewg_function_FindWindowOfClass (Point const *ewg_where, WindowClass ewg_inWindowClass, WindowRef *ewg_outWindow, WindowPartCode *ewg_outWindowPart)
{
	return FindWindowOfClass ((Point const*)ewg_where, (WindowClass)ewg_inWindowClass, (WindowRef*)ewg_outWindow, (WindowPartCode*)ewg_outWindowPart);
}

// Return address of function 'FindWindowOfClass'
void* ewg_get_function_address_FindWindowOfClass (void)
{
	return (void*) FindWindowOfClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateStandardWindowMenu'
// For ise
OSStatus  ewg_function_CreateStandardWindowMenu (OptionBits ewg_inOptions, MenuRef *ewg_outMenu)
{
	return CreateStandardWindowMenu ((OptionBits)ewg_inOptions, (MenuRef*)ewg_outMenu);
}

// Return address of function 'CreateStandardWindowMenu'
void* ewg_get_function_address_CreateStandardWindowMenu (void)
{
	return (void*) CreateStandardWindowMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowAlternateTitle'
// For ise
OSStatus  ewg_function_SetWindowAlternateTitle (WindowRef ewg_inWindow, CFStringRef ewg_inTitle)
{
	return SetWindowAlternateTitle ((WindowRef)ewg_inWindow, (CFStringRef)ewg_inTitle);
}

// Return address of function 'SetWindowAlternateTitle'
void* ewg_get_function_address_SetWindowAlternateTitle (void)
{
	return (void*) SetWindowAlternateTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyWindowAlternateTitle'
// For ise
OSStatus  ewg_function_CopyWindowAlternateTitle (WindowRef ewg_inWindow, CFStringRef *ewg_outTitle)
{
	return CopyWindowAlternateTitle ((WindowRef)ewg_inWindow, (CFStringRef*)ewg_outTitle);
}

// Return address of function 'CopyWindowAlternateTitle'
void* ewg_get_function_address_CopyWindowAlternateTitle (void)
{
	return (void*) CopyWindowAlternateTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsValidWindowPtr'
// For ise
Boolean  ewg_function_IsValidWindowPtr (WindowRef ewg_possibleWindow)
{
	return IsValidWindowPtr ((WindowRef)ewg_possibleWindow);
}

// Return address of function 'IsValidWindowPtr'
void* ewg_get_function_address_IsValidWindowPtr (void)
{
	return (void*) IsValidWindowPtr;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HiliteWindow'
// For ise
void  ewg_function_HiliteWindow (WindowRef ewg_window, Boolean ewg_fHilite)
{
	HiliteWindow ((WindowRef)ewg_window, (Boolean)ewg_fHilite);
}

// Return address of function 'HiliteWindow'
void* ewg_get_function_address_HiliteWindow (void)
{
	return (void*) HiliteWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWRefCon'
// For ise
void  ewg_function_SetWRefCon (WindowRef ewg_window, long ewg_data)
{
	SetWRefCon ((WindowRef)ewg_window, (long)ewg_data);
}

// Return address of function 'SetWRefCon'
void* ewg_get_function_address_SetWRefCon (void)
{
	return (void*) SetWRefCon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWRefCon'
// For ise
long  ewg_function_GetWRefCon (WindowRef ewg_window)
{
	return GetWRefCon ((WindowRef)ewg_window);
}

// Return address of function 'GetWRefCon'
void* ewg_get_function_address_GetWRefCon (void)
{
	return (void*) GetWRefCon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowPic'
// For ise
void  ewg_function_SetWindowPic (WindowRef ewg_window, PicHandle ewg_pic)
{
	SetWindowPic ((WindowRef)ewg_window, (PicHandle)ewg_pic);
}

// Return address of function 'SetWindowPic'
void* ewg_get_function_address_SetWindowPic (void)
{
	return (void*) SetWindowPic;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowPic'
// For ise
PicHandle  ewg_function_GetWindowPic (WindowRef ewg_window)
{
	return GetWindowPic ((WindowRef)ewg_window);
}

// Return address of function 'GetWindowPic'
void* ewg_get_function_address_GetWindowPic (void)
{
	return (void*) GetWindowPic;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWVariant'
// For ise
short  ewg_function_GetWVariant (WindowRef ewg_window)
{
	return GetWVariant ((WindowRef)ewg_window);
}

// Return address of function 'GetWVariant'
void* ewg_get_function_address_GetWVariant (void)
{
	return (void*) GetWVariant;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowFeatures'
// For ise
OSStatus  ewg_function_GetWindowFeatures (WindowRef ewg_window, UInt32 *ewg_outFeatures)
{
	return GetWindowFeatures ((WindowRef)ewg_window, (UInt32*)ewg_outFeatures);
}

// Return address of function 'GetWindowFeatures'
void* ewg_get_function_address_GetWindowFeatures (void)
{
	return (void*) GetWindowFeatures;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowRegion'
// For ise
OSStatus  ewg_function_GetWindowRegion (WindowRef ewg_window, WindowRegionCode ewg_inRegionCode, RgnHandle ewg_ioWinRgn)
{
	return GetWindowRegion ((WindowRef)ewg_window, (WindowRegionCode)ewg_inRegionCode, (RgnHandle)ewg_ioWinRgn);
}

// Return address of function 'GetWindowRegion'
void* ewg_get_function_address_GetWindowRegion (void)
{
	return (void*) GetWindowRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowStructureWidths'
// For ise
OSStatus  ewg_function_GetWindowStructureWidths (WindowRef ewg_inWindow, Rect *ewg_outRect)
{
	return GetWindowStructureWidths ((WindowRef)ewg_inWindow, (Rect*)ewg_outRect);
}

// Return address of function 'GetWindowStructureWidths'
void* ewg_get_function_address_GetWindowStructureWidths (void)
{
	return (void*) GetWindowStructureWidths;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowChangeFeatures'
// For ise
OSStatus  ewg_function_HIWindowChangeFeatures (WindowRef ewg_inWindow, UInt64 ewg_inSetThese, UInt64 ewg_inClearThese)
{
	return HIWindowChangeFeatures ((WindowRef)ewg_inWindow, (UInt64)ewg_inSetThese, (UInt64)ewg_inClearThese);
}

// Return address of function 'HIWindowChangeFeatures'
void* ewg_get_function_address_HIWindowChangeFeatures (void)
{
	return (void*) HIWindowChangeFeatures;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'BeginUpdate'
// For ise
void  ewg_function_BeginUpdate (WindowRef ewg_window)
{
	BeginUpdate ((WindowRef)ewg_window);
}

// Return address of function 'BeginUpdate'
void* ewg_get_function_address_BeginUpdate (void)
{
	return (void*) BeginUpdate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EndUpdate'
// For ise
void  ewg_function_EndUpdate (WindowRef ewg_window)
{
	EndUpdate ((WindowRef)ewg_window);
}

// Return address of function 'EndUpdate'
void* ewg_get_function_address_EndUpdate (void)
{
	return (void*) EndUpdate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalWindowRgn'
// For ise
OSStatus  ewg_function_InvalWindowRgn (WindowRef ewg_window, RgnHandle ewg_region)
{
	return InvalWindowRgn ((WindowRef)ewg_window, (RgnHandle)ewg_region);
}

// Return address of function 'InvalWindowRgn'
void* ewg_get_function_address_InvalWindowRgn (void)
{
	return (void*) InvalWindowRgn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvalWindowRect'
// For ise
OSStatus  ewg_function_InvalWindowRect (WindowRef ewg_window, Rect const *ewg_bounds)
{
	return InvalWindowRect ((WindowRef)ewg_window, (Rect const*)ewg_bounds);
}

// Return address of function 'InvalWindowRect'
void* ewg_get_function_address_InvalWindowRect (void)
{
	return (void*) InvalWindowRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ValidWindowRgn'
// For ise
OSStatus  ewg_function_ValidWindowRgn (WindowRef ewg_window, RgnHandle ewg_region)
{
	return ValidWindowRgn ((WindowRef)ewg_window, (RgnHandle)ewg_region);
}

// Return address of function 'ValidWindowRgn'
void* ewg_get_function_address_ValidWindowRgn (void)
{
	return (void*) ValidWindowRgn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ValidWindowRect'
// For ise
OSStatus  ewg_function_ValidWindowRect (WindowRef ewg_window, Rect const *ewg_bounds)
{
	return ValidWindowRect ((WindowRef)ewg_window, (Rect const*)ewg_bounds);
}

// Return address of function 'ValidWindowRect'
void* ewg_get_function_address_ValidWindowRect (void)
{
	return (void*) ValidWindowRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DrawGrowIcon'
// For ise
void  ewg_function_DrawGrowIcon (WindowRef ewg_window)
{
	DrawGrowIcon ((WindowRef)ewg_window);
}

// Return address of function 'DrawGrowIcon'
void* ewg_get_function_address_DrawGrowIcon (void)
{
	return (void*) DrawGrowIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWTitle'
// For ise
void  ewg_function_SetWTitle (WindowRef ewg_window, ConstStr255Param ewg_title)
{
	SetWTitle ((WindowRef)ewg_window, (ConstStr255Param)ewg_title);
}

// Return address of function 'SetWTitle'
void* ewg_get_function_address_SetWTitle (void)
{
	return (void*) SetWTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWTitle'
// For ise
void  ewg_function_GetWTitle (WindowRef ewg_window, void *ewg_title)
{
	GetWTitle ((WindowRef)ewg_window, ewg_title);
}

// Return address of function 'GetWTitle'
void* ewg_get_function_address_GetWTitle (void)
{
	return (void*) GetWTitle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowTitleWithCFString'
// For ise
OSStatus  ewg_function_SetWindowTitleWithCFString (WindowRef ewg_inWindow, CFStringRef ewg_inString)
{
	return SetWindowTitleWithCFString ((WindowRef)ewg_inWindow, (CFStringRef)ewg_inString);
}

// Return address of function 'SetWindowTitleWithCFString'
void* ewg_get_function_address_SetWindowTitleWithCFString (void)
{
	return (void*) SetWindowTitleWithCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyWindowTitleAsCFString'
// For ise
OSStatus  ewg_function_CopyWindowTitleAsCFString (WindowRef ewg_inWindow, CFStringRef *ewg_outString)
{
	return CopyWindowTitleAsCFString ((WindowRef)ewg_inWindow, (CFStringRef*)ewg_outString);
}

// Return address of function 'CopyWindowTitleAsCFString'
void* ewg_get_function_address_CopyWindowTitleAsCFString (void)
{
	return (void*) CopyWindowTitleAsCFString;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowProxyFSSpec'
// For ise
OSStatus  ewg_function_SetWindowProxyFSSpec (WindowRef ewg_window, FSSpec const *ewg_inFile)
{
	return SetWindowProxyFSSpec ((WindowRef)ewg_window, (FSSpec const*)ewg_inFile);
}

// Return address of function 'SetWindowProxyFSSpec'
void* ewg_get_function_address_SetWindowProxyFSSpec (void)
{
	return (void*) SetWindowProxyFSSpec;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowProxyFSSpec'
// For ise
OSStatus  ewg_function_GetWindowProxyFSSpec (WindowRef ewg_window, FSSpec *ewg_outFile)
{
	return GetWindowProxyFSSpec ((WindowRef)ewg_window, (FSSpec*)ewg_outFile);
}

// Return address of function 'GetWindowProxyFSSpec'
void* ewg_get_function_address_GetWindowProxyFSSpec (void)
{
	return (void*) GetWindowProxyFSSpec;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowSetProxyFSRef'
// For ise
OSStatus  ewg_function_HIWindowSetProxyFSRef (WindowRef ewg_window, FSRef const *ewg_inRef)
{
	return HIWindowSetProxyFSRef ((WindowRef)ewg_window, (FSRef const*)ewg_inRef);
}

// Return address of function 'HIWindowSetProxyFSRef'
void* ewg_get_function_address_HIWindowSetProxyFSRef (void)
{
	return (void*) HIWindowSetProxyFSRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowGetProxyFSRef'
// For ise
OSStatus  ewg_function_HIWindowGetProxyFSRef (WindowRef ewg_window, FSRef *ewg_outRef)
{
	return HIWindowGetProxyFSRef ((WindowRef)ewg_window, (FSRef*)ewg_outRef);
}

// Return address of function 'HIWindowGetProxyFSRef'
void* ewg_get_function_address_HIWindowGetProxyFSRef (void)
{
	return (void*) HIWindowGetProxyFSRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowProxyAlias'
// For ise
OSStatus  ewg_function_SetWindowProxyAlias (WindowRef ewg_inWindow, AliasHandle ewg_inAlias)
{
	return SetWindowProxyAlias ((WindowRef)ewg_inWindow, (AliasHandle)ewg_inAlias);
}

// Return address of function 'SetWindowProxyAlias'
void* ewg_get_function_address_SetWindowProxyAlias (void)
{
	return (void*) SetWindowProxyAlias;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowProxyAlias'
// For ise
OSStatus  ewg_function_GetWindowProxyAlias (WindowRef ewg_window, AliasHandle *ewg_alias)
{
	return GetWindowProxyAlias ((WindowRef)ewg_window, (AliasHandle*)ewg_alias);
}

// Return address of function 'GetWindowProxyAlias'
void* ewg_get_function_address_GetWindowProxyAlias (void)
{
	return (void*) GetWindowProxyAlias;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowProxyCreatorAndType'
// For ise
OSStatus  ewg_function_SetWindowProxyCreatorAndType (WindowRef ewg_window, OSType ewg_fileCreator, OSType ewg_fileType, SInt16 ewg_vRefNum)
{
	return SetWindowProxyCreatorAndType ((WindowRef)ewg_window, (OSType)ewg_fileCreator, (OSType)ewg_fileType, (SInt16)ewg_vRefNum);
}

// Return address of function 'SetWindowProxyCreatorAndType'
void* ewg_get_function_address_SetWindowProxyCreatorAndType (void)
{
	return (void*) SetWindowProxyCreatorAndType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowProxyIcon'
// For ise
OSStatus  ewg_function_GetWindowProxyIcon (WindowRef ewg_window, IconRef *ewg_outIcon)
{
	return GetWindowProxyIcon ((WindowRef)ewg_window, (IconRef*)ewg_outIcon);
}

// Return address of function 'GetWindowProxyIcon'
void* ewg_get_function_address_GetWindowProxyIcon (void)
{
	return (void*) GetWindowProxyIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowProxyIcon'
// For ise
OSStatus  ewg_function_SetWindowProxyIcon (WindowRef ewg_window, IconRef ewg_icon)
{
	return SetWindowProxyIcon ((WindowRef)ewg_window, (IconRef)ewg_icon);
}

// Return address of function 'SetWindowProxyIcon'
void* ewg_get_function_address_SetWindowProxyIcon (void)
{
	return (void*) SetWindowProxyIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveWindowProxy'
// For ise
OSStatus  ewg_function_RemoveWindowProxy (WindowRef ewg_window)
{
	return RemoveWindowProxy ((WindowRef)ewg_window);
}

// Return address of function 'RemoveWindowProxy'
void* ewg_get_function_address_RemoveWindowProxy (void)
{
	return (void*) RemoveWindowProxy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'BeginWindowProxyDrag'
// For ise
OSStatus  ewg_function_BeginWindowProxyDrag (WindowRef ewg_window, DragReference *ewg_outNewDrag, RgnHandle ewg_outDragOutlineRgn)
{
	return BeginWindowProxyDrag ((WindowRef)ewg_window, (DragReference*)ewg_outNewDrag, (RgnHandle)ewg_outDragOutlineRgn);
}

// Return address of function 'BeginWindowProxyDrag'
void* ewg_get_function_address_BeginWindowProxyDrag (void)
{
	return (void*) BeginWindowProxyDrag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EndWindowProxyDrag'
// For ise
OSStatus  ewg_function_EndWindowProxyDrag (WindowRef ewg_window, DragReference ewg_theDrag)
{
	return EndWindowProxyDrag ((WindowRef)ewg_window, (DragReference)ewg_theDrag);
}

// Return address of function 'EndWindowProxyDrag'
void* ewg_get_function_address_EndWindowProxyDrag (void)
{
	return (void*) EndWindowProxyDrag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackWindowProxyFromExistingDrag'
// For ise
OSStatus  ewg_function_TrackWindowProxyFromExistingDrag (WindowRef ewg_window, Point *ewg_startPt, DragReference ewg_drag, RgnHandle ewg_inDragOutlineRgn)
{
	return TrackWindowProxyFromExistingDrag ((WindowRef)ewg_window, *(Point*)ewg_startPt, (DragReference)ewg_drag, (RgnHandle)ewg_inDragOutlineRgn);
}

// Return address of function 'TrackWindowProxyFromExistingDrag'
void* ewg_get_function_address_TrackWindowProxyFromExistingDrag (void)
{
	return (void*) TrackWindowProxyFromExistingDrag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackWindowProxyDrag'
// For ise
OSStatus  ewg_function_TrackWindowProxyDrag (WindowRef ewg_window, Point *ewg_startPt)
{
	return TrackWindowProxyDrag ((WindowRef)ewg_window, *(Point*)ewg_startPt);
}

// Return address of function 'TrackWindowProxyDrag'
void* ewg_get_function_address_TrackWindowProxyDrag (void)
{
	return (void*) TrackWindowProxyDrag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowModified'
// For ise
Boolean  ewg_function_IsWindowModified (WindowRef ewg_window)
{
	return IsWindowModified ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowModified'
void* ewg_get_function_address_IsWindowModified (void)
{
	return (void*) IsWindowModified;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowModified'
// For ise
OSStatus  ewg_function_SetWindowModified (WindowRef ewg_window, Boolean ewg_modified)
{
	return SetWindowModified ((WindowRef)ewg_window, (Boolean)ewg_modified);
}

// Return address of function 'SetWindowModified'
void* ewg_get_function_address_SetWindowModified (void)
{
	return (void*) SetWindowModified;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowPathSelectClick'
// For ise
Boolean  ewg_function_IsWindowPathSelectClick (WindowRef ewg_window, EventRecord const *ewg_event)
{
	return IsWindowPathSelectClick ((WindowRef)ewg_window, (EventRecord const*)ewg_event);
}

// Return address of function 'IsWindowPathSelectClick'
void* ewg_get_function_address_IsWindowPathSelectClick (void)
{
	return (void*) IsWindowPathSelectClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowPathSelectEvent'
// For ise
Boolean  ewg_function_IsWindowPathSelectEvent (WindowRef ewg_window, EventRef ewg_inEvent)
{
	return IsWindowPathSelectEvent ((WindowRef)ewg_window, (EventRef)ewg_inEvent);
}

// Return address of function 'IsWindowPathSelectEvent'
void* ewg_get_function_address_IsWindowPathSelectEvent (void)
{
	return (void*) IsWindowPathSelectEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'WindowPathSelect'
// For ise
OSStatus  ewg_function_WindowPathSelect (WindowRef ewg_window, MenuRef ewg_menu, SInt32 *ewg_outMenuResult)
{
	return WindowPathSelect ((WindowRef)ewg_window, (MenuRef)ewg_menu, (SInt32*)ewg_outMenuResult);
}

// Return address of function 'WindowPathSelect'
void* ewg_get_function_address_WindowPathSelect (void)
{
	return (void*) WindowPathSelect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HiliteWindowFrameForDrag'
// For ise
OSStatus  ewg_function_HiliteWindowFrameForDrag (WindowRef ewg_window, Boolean ewg_hilited)
{
	return HiliteWindowFrameForDrag ((WindowRef)ewg_window, (Boolean)ewg_hilited);
}

// Return address of function 'HiliteWindowFrameForDrag'
void* ewg_get_function_address_HiliteWindowFrameForDrag (void)
{
	return (void*) HiliteWindowFrameForDrag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TransitionWindow'
// For ise
OSStatus  ewg_function_TransitionWindow (WindowRef ewg_inWindow, WindowTransitionEffect ewg_inEffect, WindowTransitionAction ewg_inAction, Rect const *ewg_inRect)
{
	return TransitionWindow ((WindowRef)ewg_inWindow, (WindowTransitionEffect)ewg_inEffect, (WindowTransitionAction)ewg_inAction, (Rect const*)ewg_inRect);
}

// Return address of function 'TransitionWindow'
void* ewg_get_function_address_TransitionWindow (void)
{
	return (void*) TransitionWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TransitionWindowAndParent'
// For ise
OSStatus  ewg_function_TransitionWindowAndParent (WindowRef ewg_inWindow, WindowRef ewg_inParentWindow, WindowTransitionEffect ewg_inEffect, WindowTransitionAction ewg_inAction, Rect const *ewg_inRect)
{
	return TransitionWindowAndParent ((WindowRef)ewg_inWindow, (WindowRef)ewg_inParentWindow, (WindowTransitionEffect)ewg_inEffect, (WindowTransitionAction)ewg_inAction, (Rect const*)ewg_inRect);
}

// Return address of function 'TransitionWindowAndParent'
void* ewg_get_function_address_TransitionWindowAndParent (void)
{
	return (void*) TransitionWindowAndParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TransitionWindowWithOptions'
// For ise
OSStatus  ewg_function_TransitionWindowWithOptions (WindowRef ewg_inWindow, WindowTransitionEffect ewg_inEffect, WindowTransitionAction ewg_inAction, HIRect const *ewg_inBounds, Boolean ewg_inAsync, TransitionWindowOptions *ewg_inOptions)
{
	return TransitionWindowWithOptions ((WindowRef)ewg_inWindow, (WindowTransitionEffect)ewg_inEffect, (WindowTransitionAction)ewg_inAction, (HIRect const*)ewg_inBounds, (Boolean)ewg_inAsync, (TransitionWindowOptions*)ewg_inOptions);
}

// Return address of function 'TransitionWindowWithOptions'
void* ewg_get_function_address_TransitionWindowWithOptions (void)
{
	return (void*) TransitionWindowWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveWindow'
// For ise
void  ewg_function_MoveWindow (WindowRef ewg_window, short ewg_hGlobal, short ewg_vGlobal, Boolean ewg_front)
{
	MoveWindow ((WindowRef)ewg_window, (short)ewg_hGlobal, (short)ewg_vGlobal, (Boolean)ewg_front);
}

// Return address of function 'MoveWindow'
void* ewg_get_function_address_MoveWindow (void)
{
	return (void*) MoveWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SizeWindow'
// For ise
void  ewg_function_SizeWindow (WindowRef ewg_window, short ewg_w, short ewg_h, Boolean ewg_fUpdate)
{
	SizeWindow ((WindowRef)ewg_window, (short)ewg_w, (short)ewg_h, (Boolean)ewg_fUpdate);
}

// Return address of function 'SizeWindow'
void* ewg_get_function_address_SizeWindow (void)
{
	return (void*) SizeWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GrowWindow'
// For ise
long  ewg_function_GrowWindow (WindowRef ewg_window, Point *ewg_startPt, Rect const *ewg_bBox)
{
	return GrowWindow ((WindowRef)ewg_window, *(Point*)ewg_startPt, (Rect const*)ewg_bBox);
}

// Return address of function 'GrowWindow'
void* ewg_get_function_address_GrowWindow (void)
{
	return (void*) GrowWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DragWindow'
// For ise
void  ewg_function_DragWindow (WindowRef ewg_window, Point *ewg_startPt, Rect const *ewg_boundsRect)
{
	DragWindow ((WindowRef)ewg_window, *(Point*)ewg_startPt, (Rect const*)ewg_boundsRect);
}

// Return address of function 'DragWindow'
void* ewg_get_function_address_DragWindow (void)
{
	return (void*) DragWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ZoomWindow'
// For ise
void  ewg_function_ZoomWindow (WindowRef ewg_window, WindowPartCode ewg_partCode, Boolean ewg_front)
{
	ZoomWindow ((WindowRef)ewg_window, (WindowPartCode)ewg_partCode, (Boolean)ewg_front);
}

// Return address of function 'ZoomWindow'
void* ewg_get_function_address_ZoomWindow (void)
{
	return (void*) ZoomWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowCollapsable'
// For ise
Boolean  ewg_function_IsWindowCollapsable (WindowRef ewg_window)
{
	return IsWindowCollapsable ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowCollapsable'
void* ewg_get_function_address_IsWindowCollapsable (void)
{
	return (void*) IsWindowCollapsable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowCollapsed'
// For ise
Boolean  ewg_function_IsWindowCollapsed (WindowRef ewg_window)
{
	return IsWindowCollapsed ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowCollapsed'
void* ewg_get_function_address_IsWindowCollapsed (void)
{
	return (void*) IsWindowCollapsed;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CollapseWindow'
// For ise
OSStatus  ewg_function_CollapseWindow (WindowRef ewg_window, Boolean ewg_collapse)
{
	return CollapseWindow ((WindowRef)ewg_window, (Boolean)ewg_collapse);
}

// Return address of function 'CollapseWindow'
void* ewg_get_function_address_CollapseWindow (void)
{
	return (void*) CollapseWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CollapseAllWindows'
// For ise
OSStatus  ewg_function_CollapseAllWindows (Boolean ewg_collapse)
{
	return CollapseAllWindows ((Boolean)ewg_collapse);
}

// Return address of function 'CollapseAllWindows'
void* ewg_get_function_address_CollapseAllWindows (void)
{
	return (void*) CollapseAllWindows;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateQDContextForCollapsedWindowDockTile'
// For ise
OSStatus  ewg_function_CreateQDContextForCollapsedWindowDockTile (WindowRef ewg_inWindow, CGrafPtr *ewg_outContext)
{
	return CreateQDContextForCollapsedWindowDockTile ((WindowRef)ewg_inWindow, (CGrafPtr*)ewg_outContext);
}

// Return address of function 'CreateQDContextForCollapsedWindowDockTile'
void* ewg_get_function_address_CreateQDContextForCollapsedWindowDockTile (void)
{
	return (void*) CreateQDContextForCollapsedWindowDockTile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseQDContextForCollapsedWindowDockTile'
// For ise
OSStatus  ewg_function_ReleaseQDContextForCollapsedWindowDockTile (WindowRef ewg_inWindow, CGrafPtr ewg_inContext)
{
	return ReleaseQDContextForCollapsedWindowDockTile ((WindowRef)ewg_inWindow, (CGrafPtr)ewg_inContext);
}

// Return address of function 'ReleaseQDContextForCollapsedWindowDockTile'
void* ewg_get_function_address_ReleaseQDContextForCollapsedWindowDockTile (void)
{
	return (void*) ReleaseQDContextForCollapsedWindowDockTile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UpdateCollapsedWindowDockTile'
// For ise
OSStatus  ewg_function_UpdateCollapsedWindowDockTile (WindowRef ewg_inWindow)
{
	return UpdateCollapsedWindowDockTile ((WindowRef)ewg_inWindow);
}

// Return address of function 'UpdateCollapsedWindowDockTile'
void* ewg_get_function_address_UpdateCollapsedWindowDockTile (void)
{
	return (void*) UpdateCollapsedWindowDockTile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowDockTileMenu'
// For ise
OSStatus  ewg_function_SetWindowDockTileMenu (WindowRef ewg_inWindow, MenuRef ewg_inMenu)
{
	return SetWindowDockTileMenu ((WindowRef)ewg_inWindow, (MenuRef)ewg_inMenu);
}

// Return address of function 'SetWindowDockTileMenu'
void* ewg_get_function_address_SetWindowDockTileMenu (void)
{
	return (void*) SetWindowDockTileMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowDockTileMenu'
// For ise
MenuRef  ewg_function_GetWindowDockTileMenu (WindowRef ewg_inWindow)
{
	return GetWindowDockTileMenu ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetWindowDockTileMenu'
void* ewg_get_function_address_GetWindowDockTileMenu (void)
{
	return (void*) GetWindowDockTileMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowBounds'
// For ise
OSStatus  ewg_function_GetWindowBounds (WindowRef ewg_window, WindowRegionCode ewg_regionCode, Rect *ewg_globalBounds)
{
	return GetWindowBounds ((WindowRef)ewg_window, (WindowRegionCode)ewg_regionCode, (Rect*)ewg_globalBounds);
}

// Return address of function 'GetWindowBounds'
void* ewg_get_function_address_GetWindowBounds (void)
{
	return (void*) GetWindowBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowResizeLimits'
// For ise
OSStatus  ewg_function_SetWindowResizeLimits (WindowRef ewg_inWindow, HISize const *ewg_inMinLimits, HISize const *ewg_inMaxLimits)
{
	return SetWindowResizeLimits ((WindowRef)ewg_inWindow, (HISize const*)ewg_inMinLimits, (HISize const*)ewg_inMaxLimits);
}

// Return address of function 'SetWindowResizeLimits'
void* ewg_get_function_address_SetWindowResizeLimits (void)
{
	return (void*) SetWindowResizeLimits;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowResizeLimits'
// For ise
OSStatus  ewg_function_GetWindowResizeLimits (WindowRef ewg_inWindow, HISize *ewg_outMinLimits, HISize *ewg_outMaxLimits)
{
	return GetWindowResizeLimits ((WindowRef)ewg_inWindow, (HISize*)ewg_outMinLimits, (HISize*)ewg_outMaxLimits);
}

// Return address of function 'GetWindowResizeLimits'
void* ewg_get_function_address_GetWindowResizeLimits (void)
{
	return (void*) GetWindowResizeLimits;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ResizeWindow'
// For ise
Boolean  ewg_function_ResizeWindow (WindowRef ewg_inWindow, Point *ewg_inStartPoint, Rect const *ewg_inSizeConstraints, Rect *ewg_outNewContentRect)
{
	return ResizeWindow ((WindowRef)ewg_inWindow, *(Point*)ewg_inStartPoint, (Rect const*)ewg_inSizeConstraints, (Rect*)ewg_outNewContentRect);
}

// Return address of function 'ResizeWindow'
void* ewg_get_function_address_ResizeWindow (void)
{
	return (void*) ResizeWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowBounds'
// For ise
OSStatus  ewg_function_SetWindowBounds (WindowRef ewg_window, WindowRegionCode ewg_regionCode, Rect const *ewg_globalBounds)
{
	return SetWindowBounds ((WindowRef)ewg_window, (WindowRegionCode)ewg_regionCode, (Rect const*)ewg_globalBounds);
}

// Return address of function 'SetWindowBounds'
void* ewg_get_function_address_SetWindowBounds (void)
{
	return (void*) SetWindowBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RepositionWindow'
// For ise
OSStatus  ewg_function_RepositionWindow (WindowRef ewg_window, WindowRef ewg_parentWindow, WindowPositionMethod ewg_method)
{
	return RepositionWindow ((WindowRef)ewg_window, (WindowRef)ewg_parentWindow, (WindowPositionMethod)ewg_method);
}

// Return address of function 'RepositionWindow'
void* ewg_get_function_address_RepositionWindow (void)
{
	return (void*) RepositionWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveWindowStructure'
// For ise
OSStatus  ewg_function_MoveWindowStructure (WindowRef ewg_window, short ewg_hGlobal, short ewg_vGlobal)
{
	return MoveWindowStructure ((WindowRef)ewg_window, (short)ewg_hGlobal, (short)ewg_vGlobal);
}

// Return address of function 'MoveWindowStructure'
void* ewg_get_function_address_MoveWindowStructure (void)
{
	return (void*) MoveWindowStructure;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowInStandardState'
// For ise
Boolean  ewg_function_IsWindowInStandardState (WindowRef ewg_inWindow, Point const *ewg_inIdealSize, Rect *ewg_outIdealStandardState)
{
	return IsWindowInStandardState ((WindowRef)ewg_inWindow, (Point const*)ewg_inIdealSize, (Rect*)ewg_outIdealStandardState);
}

// Return address of function 'IsWindowInStandardState'
void* ewg_get_function_address_IsWindowInStandardState (void)
{
	return (void*) IsWindowInStandardState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ZoomWindowIdeal'
// For ise
OSStatus  ewg_function_ZoomWindowIdeal (WindowRef ewg_inWindow, WindowPartCode ewg_inPartCode, Point *ewg_ioIdealSize)
{
	return ZoomWindowIdeal ((WindowRef)ewg_inWindow, (WindowPartCode)ewg_inPartCode, (Point*)ewg_ioIdealSize);
}

// Return address of function 'ZoomWindowIdeal'
void* ewg_get_function_address_ZoomWindowIdeal (void)
{
	return (void*) ZoomWindowIdeal;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowIdealUserState'
// For ise
OSStatus  ewg_function_GetWindowIdealUserState (WindowRef ewg_inWindow, Rect *ewg_outUserState)
{
	return GetWindowIdealUserState ((WindowRef)ewg_inWindow, (Rect*)ewg_outUserState);
}

// Return address of function 'GetWindowIdealUserState'
void* ewg_get_function_address_GetWindowIdealUserState (void)
{
	return (void*) GetWindowIdealUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowIdealUserState'
// For ise
OSStatus  ewg_function_SetWindowIdealUserState (WindowRef ewg_inWindow, Rect const *ewg_inUserState)
{
	return SetWindowIdealUserState ((WindowRef)ewg_inWindow, (Rect const*)ewg_inUserState);
}

// Return address of function 'SetWindowIdealUserState'
void* ewg_get_function_address_SetWindowIdealUserState (void)
{
	return (void*) SetWindowIdealUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowGreatestAreaDevice'
// For ise
OSStatus  ewg_function_GetWindowGreatestAreaDevice (WindowRef ewg_inWindow, WindowRegionCode ewg_inRegion, GDHandle *ewg_outGreatestDevice, Rect *ewg_outGreatestDeviceRect)
{
	return GetWindowGreatestAreaDevice ((WindowRef)ewg_inWindow, (WindowRegionCode)ewg_inRegion, (GDHandle*)ewg_outGreatestDevice, (Rect*)ewg_outGreatestDeviceRect);
}

// Return address of function 'GetWindowGreatestAreaDevice'
void* ewg_get_function_address_GetWindowGreatestAreaDevice (void)
{
	return (void*) GetWindowGreatestAreaDevice;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ConstrainWindowToScreen'
// For ise
OSStatus  ewg_function_ConstrainWindowToScreen (WindowRef ewg_inWindowRef, WindowRegionCode ewg_inRegionCode, WindowConstrainOptions ewg_inOptions, Rect const *ewg_inScreenRect, Rect *ewg_outStructure)
{
	return ConstrainWindowToScreen ((WindowRef)ewg_inWindowRef, (WindowRegionCode)ewg_inRegionCode, (WindowConstrainOptions)ewg_inOptions, (Rect const*)ewg_inScreenRect, (Rect*)ewg_outStructure);
}

// Return address of function 'ConstrainWindowToScreen'
void* ewg_get_function_address_ConstrainWindowToScreen (void)
{
	return (void*) ConstrainWindowToScreen;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetAvailableWindowPositioningBounds'
// For ise
OSStatus  ewg_function_GetAvailableWindowPositioningBounds (GDHandle ewg_inDevice, Rect *ewg_outAvailableRect)
{
	return GetAvailableWindowPositioningBounds ((GDHandle)ewg_inDevice, (Rect*)ewg_outAvailableRect);
}

// Return address of function 'GetAvailableWindowPositioningBounds'
void* ewg_get_function_address_GetAvailableWindowPositioningBounds (void)
{
	return (void*) GetAvailableWindowPositioningBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetAvailableWindowPositioningRegion'
// For ise
OSStatus  ewg_function_GetAvailableWindowPositioningRegion (GDHandle ewg_inDevice, RgnHandle ewg_ioRgn)
{
	return GetAvailableWindowPositioningRegion ((GDHandle)ewg_inDevice, (RgnHandle)ewg_ioRgn);
}

// Return address of function 'GetAvailableWindowPositioningRegion'
void* ewg_get_function_address_GetAvailableWindowPositioningRegion (void)
{
	return (void*) GetAvailableWindowPositioningRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HideWindow'
// For ise
void  ewg_function_HideWindow (WindowRef ewg_window)
{
	HideWindow ((WindowRef)ewg_window);
}

// Return address of function 'HideWindow'
void* ewg_get_function_address_HideWindow (void)
{
	return (void*) HideWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowWindow'
// For ise
void  ewg_function_ShowWindow (WindowRef ewg_window)
{
	ShowWindow ((WindowRef)ewg_window);
}

// Return address of function 'ShowWindow'
void* ewg_get_function_address_ShowWindow (void)
{
	return (void*) ShowWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowHide'
// For ise
void  ewg_function_ShowHide (WindowRef ewg_window, Boolean ewg_showFlag)
{
	ShowHide ((WindowRef)ewg_window, (Boolean)ewg_showFlag);
}

// Return address of function 'ShowHide'
void* ewg_get_function_address_ShowHide (void)
{
	return (void*) ShowHide;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowVisible'
// For ise
Boolean  ewg_function_IsWindowVisible (WindowRef ewg_window)
{
	return IsWindowVisible ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowVisible'
void* ewg_get_function_address_IsWindowVisible (void)
{
	return (void*) IsWindowVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowLatentVisible'
// For ise
Boolean  ewg_function_IsWindowLatentVisible (WindowRef ewg_inWindow, WindowLatentVisibility *ewg_outLatentVisible)
{
	return IsWindowLatentVisible ((WindowRef)ewg_inWindow, (WindowLatentVisibility*)ewg_outLatentVisible);
}

// Return address of function 'IsWindowLatentVisible'
void* ewg_get_function_address_IsWindowLatentVisible (void)
{
	return (void*) IsWindowLatentVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowGetAvailability'
// For ise
OSStatus  ewg_function_HIWindowGetAvailability (HIWindowRef ewg_inWindow, HIWindowAvailability *ewg_outAvailability)
{
	return HIWindowGetAvailability ((HIWindowRef)ewg_inWindow, (HIWindowAvailability*)ewg_outAvailability);
}

// Return address of function 'HIWindowGetAvailability'
void* ewg_get_function_address_HIWindowGetAvailability (void)
{
	return (void*) HIWindowGetAvailability;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowChangeAvailability'
// For ise
OSStatus  ewg_function_HIWindowChangeAvailability (HIWindowRef ewg_inWindow, HIWindowAvailability ewg_inSetAvailability, HIWindowAvailability ewg_inClearAvailability)
{
	return HIWindowChangeAvailability ((HIWindowRef)ewg_inWindow, (HIWindowAvailability)ewg_inSetAvailability, (HIWindowAvailability)ewg_inClearAvailability);
}

// Return address of function 'HIWindowChangeAvailability'
void* ewg_get_function_address_HIWindowChangeAvailability (void)
{
	return (void*) HIWindowChangeAvailability;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowSheetWindow'
// For ise
OSStatus  ewg_function_ShowSheetWindow (WindowRef ewg_inSheet, WindowRef ewg_inParentWindow)
{
	return ShowSheetWindow ((WindowRef)ewg_inSheet, (WindowRef)ewg_inParentWindow);
}

// Return address of function 'ShowSheetWindow'
void* ewg_get_function_address_ShowSheetWindow (void)
{
	return (void*) ShowSheetWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HideSheetWindow'
// For ise
OSStatus  ewg_function_HideSheetWindow (WindowRef ewg_inSheet)
{
	return HideSheetWindow ((WindowRef)ewg_inSheet);
}

// Return address of function 'HideSheetWindow'
void* ewg_get_function_address_HideSheetWindow (void)
{
	return (void*) HideSheetWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DetachSheetWindow'
// For ise
OSStatus  ewg_function_DetachSheetWindow (WindowRef ewg_inSheet)
{
	return DetachSheetWindow ((WindowRef)ewg_inSheet);
}

// Return address of function 'DetachSheetWindow'
void* ewg_get_function_address_DetachSheetWindow (void)
{
	return (void*) DetachSheetWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetSheetWindowParent'
// For ise
OSStatus  ewg_function_GetSheetWindowParent (WindowRef ewg_inSheet, WindowRef *ewg_outParentWindow)
{
	return GetSheetWindowParent ((WindowRef)ewg_inSheet, (WindowRef*)ewg_outParentWindow);
}

// Return address of function 'GetSheetWindowParent'
void* ewg_get_function_address_GetSheetWindowParent (void)
{
	return (void*) GetSheetWindowParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDrawerPreferredEdge'
// For ise
OptionBits  ewg_function_GetDrawerPreferredEdge (WindowRef ewg_inDrawerWindow)
{
	return GetDrawerPreferredEdge ((WindowRef)ewg_inDrawerWindow);
}

// Return address of function 'GetDrawerPreferredEdge'
void* ewg_get_function_address_GetDrawerPreferredEdge (void)
{
	return (void*) GetDrawerPreferredEdge;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDrawerPreferredEdge'
// For ise
OSStatus  ewg_function_SetDrawerPreferredEdge (WindowRef ewg_inDrawerWindow, OptionBits ewg_inEdge)
{
	return SetDrawerPreferredEdge ((WindowRef)ewg_inDrawerWindow, (OptionBits)ewg_inEdge);
}

// Return address of function 'SetDrawerPreferredEdge'
void* ewg_get_function_address_SetDrawerPreferredEdge (void)
{
	return (void*) SetDrawerPreferredEdge;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDrawerCurrentEdge'
// For ise
OptionBits  ewg_function_GetDrawerCurrentEdge (WindowRef ewg_inDrawerWindow)
{
	return GetDrawerCurrentEdge ((WindowRef)ewg_inDrawerWindow);
}

// Return address of function 'GetDrawerCurrentEdge'
void* ewg_get_function_address_GetDrawerCurrentEdge (void)
{
	return (void*) GetDrawerCurrentEdge;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDrawerState'
// For ise
WindowDrawerState  ewg_function_GetDrawerState (WindowRef ewg_inDrawerWindow)
{
	return GetDrawerState ((WindowRef)ewg_inDrawerWindow);
}

// Return address of function 'GetDrawerState'
void* ewg_get_function_address_GetDrawerState (void)
{
	return (void*) GetDrawerState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDrawerParent'
// For ise
WindowRef  ewg_function_GetDrawerParent (WindowRef ewg_inDrawerWindow)
{
	return GetDrawerParent ((WindowRef)ewg_inDrawerWindow);
}

// Return address of function 'GetDrawerParent'
void* ewg_get_function_address_GetDrawerParent (void)
{
	return (void*) GetDrawerParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDrawerParent'
// For ise
OSStatus  ewg_function_SetDrawerParent (WindowRef ewg_inDrawerWindow, WindowRef ewg_inParent)
{
	return SetDrawerParent ((WindowRef)ewg_inDrawerWindow, (WindowRef)ewg_inParent);
}

// Return address of function 'SetDrawerParent'
void* ewg_get_function_address_SetDrawerParent (void)
{
	return (void*) SetDrawerParent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDrawerOffsets'
// For ise
OSStatus  ewg_function_SetDrawerOffsets (WindowRef ewg_inDrawerWindow, float ewg_inLeadingOffset, float ewg_inTrailingOffset)
{
	return SetDrawerOffsets ((WindowRef)ewg_inDrawerWindow, (float)ewg_inLeadingOffset, (float)ewg_inTrailingOffset);
}

// Return address of function 'SetDrawerOffsets'
void* ewg_get_function_address_SetDrawerOffsets (void)
{
	return (void*) SetDrawerOffsets;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDrawerOffsets'
// For ise
OSStatus  ewg_function_GetDrawerOffsets (WindowRef ewg_inDrawerWindow, float *ewg_outLeadingOffset, float *ewg_outTrailingOffset)
{
	return GetDrawerOffsets ((WindowRef)ewg_inDrawerWindow, (float*)ewg_outLeadingOffset, (float*)ewg_outTrailingOffset);
}

// Return address of function 'GetDrawerOffsets'
void* ewg_get_function_address_GetDrawerOffsets (void)
{
	return (void*) GetDrawerOffsets;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ToggleDrawer'
// For ise
OSStatus  ewg_function_ToggleDrawer (WindowRef ewg_inDrawerWindow)
{
	return ToggleDrawer ((WindowRef)ewg_inDrawerWindow);
}

// Return address of function 'ToggleDrawer'
void* ewg_get_function_address_ToggleDrawer (void)
{
	return (void*) ToggleDrawer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'OpenDrawer'
// For ise
OSStatus  ewg_function_OpenDrawer (WindowRef ewg_inDrawerWindow, OptionBits ewg_inEdge, Boolean ewg_inAsync)
{
	return OpenDrawer ((WindowRef)ewg_inDrawerWindow, (OptionBits)ewg_inEdge, (Boolean)ewg_inAsync);
}

// Return address of function 'OpenDrawer'
void* ewg_get_function_address_OpenDrawer (void)
{
	return (void*) OpenDrawer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CloseDrawer'
// For ise
OSStatus  ewg_function_CloseDrawer (WindowRef ewg_inDrawerWindow, Boolean ewg_inAsync)
{
	return CloseDrawer ((WindowRef)ewg_inDrawerWindow, (Boolean)ewg_inAsync);
}

// Return address of function 'CloseDrawer'
void* ewg_get_function_address_CloseDrawer (void)
{
	return (void*) CloseDrawer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisableScreenUpdates'
// For ise
OSStatus  ewg_function_DisableScreenUpdates (void)
{
	return DisableScreenUpdates ();
}

// Return address of function 'DisableScreenUpdates'
void* ewg_get_function_address_DisableScreenUpdates (void)
{
	return (void*) DisableScreenUpdates;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableScreenUpdates'
// For ise
OSStatus  ewg_function_EnableScreenUpdates (void)
{
	return EnableScreenUpdates ();
}

// Return address of function 'EnableScreenUpdates'
void* ewg_get_function_address_EnableScreenUpdates (void)
{
	return (void*) EnableScreenUpdates;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowToolbar'
// For ise
OSStatus  ewg_function_SetWindowToolbar (WindowRef ewg_inWindow, HIToolbarRef ewg_inToolbar)
{
	return SetWindowToolbar ((WindowRef)ewg_inWindow, (HIToolbarRef)ewg_inToolbar);
}

// Return address of function 'SetWindowToolbar'
void* ewg_get_function_address_SetWindowToolbar (void)
{
	return (void*) SetWindowToolbar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowToolbar'
// For ise
OSStatus  ewg_function_GetWindowToolbar (WindowRef ewg_inWindow, HIToolbarRef *ewg_outToolbar)
{
	return GetWindowToolbar ((WindowRef)ewg_inWindow, (HIToolbarRef*)ewg_outToolbar);
}

// Return address of function 'GetWindowToolbar'
void* ewg_get_function_address_GetWindowToolbar (void)
{
	return (void*) GetWindowToolbar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ShowHideWindowToolbar'
// For ise
OSStatus  ewg_function_ShowHideWindowToolbar (WindowRef ewg_inWindow, Boolean ewg_inShow, Boolean ewg_inAnimate)
{
	return ShowHideWindowToolbar ((WindowRef)ewg_inWindow, (Boolean)ewg_inShow, (Boolean)ewg_inAnimate);
}

// Return address of function 'ShowHideWindowToolbar'
void* ewg_get_function_address_ShowHideWindowToolbar (void)
{
	return (void*) ShowHideWindowToolbar;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowToolbarVisible'
// For ise
Boolean  ewg_function_IsWindowToolbarVisible (WindowRef ewg_inWindow)
{
	return IsWindowToolbarVisible ((WindowRef)ewg_inWindow);
}

// Return address of function 'IsWindowToolbarVisible'
void* ewg_get_function_address_IsWindowToolbarVisible (void)
{
	return (void*) IsWindowToolbarVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowAlpha'
// For ise
OSStatus  ewg_function_SetWindowAlpha (WindowRef ewg_inWindow, float ewg_inAlpha)
{
	return SetWindowAlpha ((WindowRef)ewg_inWindow, (float)ewg_inAlpha);
}

// Return address of function 'SetWindowAlpha'
void* ewg_get_function_address_SetWindowAlpha (void)
{
	return (void*) SetWindowAlpha;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowAlpha'
// For ise
OSStatus  ewg_function_GetWindowAlpha (WindowRef ewg_inWindow, float *ewg_outAlpha)
{
	return GetWindowAlpha ((WindowRef)ewg_inWindow, (float*)ewg_outAlpha);
}

// Return address of function 'GetWindowAlpha'
void* ewg_get_function_address_GetWindowAlpha (void)
{
	return (void*) GetWindowAlpha;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowInvalidateShadow'
// For ise
OSStatus  ewg_function_HIWindowInvalidateShadow (HIWindowRef ewg_inWindow)
{
	return HIWindowInvalidateShadow ((HIWindowRef)ewg_inWindow);
}

// Return address of function 'HIWindowInvalidateShadow'
void* ewg_get_function_address_HIWindowInvalidateShadow (void)
{
	return (void*) HIWindowInvalidateShadow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIWindowGetScaleMode'
// For ise
OSStatus  ewg_function_HIWindowGetScaleMode (HIWindowRef ewg_inWindow, HIWindowScaleMode *ewg_outMode, float *ewg_outScaleFactor)
{
	return HIWindowGetScaleMode ((HIWindowRef)ewg_inWindow, (HIWindowScaleMode*)ewg_outMode, (float*)ewg_outScaleFactor);
}

// Return address of function 'HIWindowGetScaleMode'
void* ewg_get_function_address_HIWindowGetScaleMode (void)
{
	return (void*) HIWindowGetScaleMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowProperty'
// For ise
OSStatus  ewg_function_GetWindowProperty (WindowRef ewg_window, PropertyCreator ewg_propertyCreator, PropertyTag ewg_propertyTag, UInt32 ewg_bufferSize, UInt32 *ewg_actualSize, void *ewg_propertyBuffer)
{
	return GetWindowProperty ((WindowRef)ewg_window, (PropertyCreator)ewg_propertyCreator, (PropertyTag)ewg_propertyTag, (UInt32)ewg_bufferSize, (UInt32*)ewg_actualSize, (void*)ewg_propertyBuffer);
}

// Return address of function 'GetWindowProperty'
void* ewg_get_function_address_GetWindowProperty (void)
{
	return (void*) GetWindowProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowPropertySize'
// For ise
OSStatus  ewg_function_GetWindowPropertySize (WindowRef ewg_window, PropertyCreator ewg_creator, PropertyTag ewg_tag, UInt32 *ewg_size)
{
	return GetWindowPropertySize ((WindowRef)ewg_window, (PropertyCreator)ewg_creator, (PropertyTag)ewg_tag, (UInt32*)ewg_size);
}

// Return address of function 'GetWindowPropertySize'
void* ewg_get_function_address_GetWindowPropertySize (void)
{
	return (void*) GetWindowPropertySize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowProperty'
// For ise
OSStatus  ewg_function_SetWindowProperty (WindowRef ewg_window, PropertyCreator ewg_propertyCreator, PropertyTag ewg_propertyTag, UInt32 ewg_propertySize, void const *ewg_propertyBuffer)
{
	return SetWindowProperty ((WindowRef)ewg_window, (PropertyCreator)ewg_propertyCreator, (PropertyTag)ewg_propertyTag, (UInt32)ewg_propertySize, (void const*)ewg_propertyBuffer);
}

// Return address of function 'SetWindowProperty'
void* ewg_get_function_address_SetWindowProperty (void)
{
	return (void*) SetWindowProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveWindowProperty'
// For ise
OSStatus  ewg_function_RemoveWindowProperty (WindowRef ewg_window, PropertyCreator ewg_propertyCreator, PropertyTag ewg_propertyTag)
{
	return RemoveWindowProperty ((WindowRef)ewg_window, (PropertyCreator)ewg_propertyCreator, (PropertyTag)ewg_propertyTag);
}

// Return address of function 'RemoveWindowProperty'
void* ewg_get_function_address_RemoveWindowProperty (void)
{
	return (void*) RemoveWindowProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowPropertyAttributes'
// For ise
OSStatus  ewg_function_GetWindowPropertyAttributes (WindowRef ewg_window, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 *ewg_attributes)
{
	return GetWindowPropertyAttributes ((WindowRef)ewg_window, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32*)ewg_attributes);
}

// Return address of function 'GetWindowPropertyAttributes'
void* ewg_get_function_address_GetWindowPropertyAttributes (void)
{
	return (void*) GetWindowPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeWindowPropertyAttributes'
// For ise
OSStatus  ewg_function_ChangeWindowPropertyAttributes (WindowRef ewg_window, OSType ewg_propertyCreator, OSType ewg_propertyTag, UInt32 ewg_attributesToSet, UInt32 ewg_attributesToClear)
{
	return ChangeWindowPropertyAttributes ((WindowRef)ewg_window, (OSType)ewg_propertyCreator, (OSType)ewg_propertyTag, (UInt32)ewg_attributesToSet, (UInt32)ewg_attributesToClear);
}

// Return address of function 'ChangeWindowPropertyAttributes'
void* ewg_get_function_address_ChangeWindowPropertyAttributes (void)
{
	return (void*) ChangeWindowPropertyAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PinRect'
// For ise
long  ewg_function_PinRect (Rect const *ewg_theRect, Point *ewg_thePt)
{
	return PinRect ((Rect const*)ewg_theRect, *(Point*)ewg_thePt);
}

// Return address of function 'PinRect'
void* ewg_get_function_address_PinRect (void)
{
	return (void*) PinRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetGrayRgn'
// For ise
RgnHandle  ewg_function_GetGrayRgn (void)
{
	return GetGrayRgn ();
}

// Return address of function 'GetGrayRgn'
void* ewg_get_function_address_GetGrayRgn (void)
{
	return (void*) GetGrayRgn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackBox'
// For ise
Boolean  ewg_function_TrackBox (WindowRef ewg_window, Point *ewg_thePt, WindowPartCode ewg_partCode)
{
	return TrackBox ((WindowRef)ewg_window, *(Point*)ewg_thePt, (WindowPartCode)ewg_partCode);
}

// Return address of function 'TrackBox'
void* ewg_get_function_address_TrackBox (void)
{
	return (void*) TrackBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackGoAway'
// For ise
Boolean  ewg_function_TrackGoAway (WindowRef ewg_window, Point *ewg_thePt)
{
	return TrackGoAway ((WindowRef)ewg_window, *(Point*)ewg_thePt);
}

// Return address of function 'TrackGoAway'
void* ewg_get_function_address_TrackGoAway (void)
{
	return (void*) TrackGoAway;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DragGrayRgn'
// For ise
long  ewg_function_DragGrayRgn (RgnHandle ewg_theRgn, Point *ewg_startPt, Rect const *ewg_limitRect, Rect const *ewg_slopRect, short ewg_axis, DragGrayRgnUPP ewg_actionProc)
{
	return DragGrayRgn ((RgnHandle)ewg_theRgn, *(Point*)ewg_startPt, (Rect const*)ewg_limitRect, (Rect const*)ewg_slopRect, (short)ewg_axis, (DragGrayRgnUPP)ewg_actionProc);
}

// Return address of function 'DragGrayRgn'
void* ewg_get_function_address_DragGrayRgn (void)
{
	return (void*) DragGrayRgn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DragTheRgn'
// For ise
long  ewg_function_DragTheRgn (RgnHandle ewg_theRgn, Point *ewg_startPt, Rect const *ewg_limitRect, Rect const *ewg_slopRect, short ewg_axis, DragGrayRgnUPP ewg_actionProc)
{
	return DragTheRgn ((RgnHandle)ewg_theRgn, *(Point*)ewg_startPt, (Rect const*)ewg_limitRect, (Rect const*)ewg_slopRect, (short)ewg_axis, (DragGrayRgnUPP)ewg_actionProc);
}

// Return address of function 'DragTheRgn'
void* ewg_get_function_address_DragTheRgn (void)
{
	return (void*) DragTheRgn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowList'
// For ise
WindowRef  ewg_function_GetWindowList (void)
{
	return GetWindowList ();
}

// Return address of function 'GetWindowList'
void* ewg_get_function_address_GetWindowList (void)
{
	return (void*) GetWindowList;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowPort'
// For ise
CGrafPtr  ewg_function_GetWindowPort (WindowRef ewg_window)
{
	return GetWindowPort ((WindowRef)ewg_window);
}

// Return address of function 'GetWindowPort'
void* ewg_get_function_address_GetWindowPort (void)
{
	return (void*) GetWindowPort;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowStructurePort'
// For ise
CGrafPtr  ewg_function_GetWindowStructurePort (WindowRef ewg_inWindow)
{
	return GetWindowStructurePort ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetWindowStructurePort'
void* ewg_get_function_address_GetWindowStructurePort (void)
{
	return (void*) GetWindowStructurePort;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowKind'
// For ise
short  ewg_function_GetWindowKind (WindowRef ewg_window)
{
	return GetWindowKind ((WindowRef)ewg_window);
}

// Return address of function 'GetWindowKind'
void* ewg_get_function_address_GetWindowKind (void)
{
	return (void*) GetWindowKind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowHilited'
// For ise
Boolean  ewg_function_IsWindowHilited (WindowRef ewg_window)
{
	return IsWindowHilited ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowHilited'
void* ewg_get_function_address_IsWindowHilited (void)
{
	return (void*) IsWindowHilited;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsWindowUpdatePending'
// For ise
Boolean  ewg_function_IsWindowUpdatePending (WindowRef ewg_window)
{
	return IsWindowUpdatePending ((WindowRef)ewg_window);
}

// Return address of function 'IsWindowUpdatePending'
void* ewg_get_function_address_IsWindowUpdatePending (void)
{
	return (void*) IsWindowUpdatePending;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetNextWindow'
// For ise
WindowRef  ewg_function_GetNextWindow (WindowRef ewg_window)
{
	return GetNextWindow ((WindowRef)ewg_window);
}

// Return address of function 'GetNextWindow'
void* ewg_get_function_address_GetNextWindow (void)
{
	return (void*) GetNextWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetPreviousWindow'
// For ise
WindowRef  ewg_function_GetPreviousWindow (WindowRef ewg_inWindow)
{
	return GetPreviousWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetPreviousWindow'
void* ewg_get_function_address_GetPreviousWindow (void)
{
	return (void*) GetPreviousWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowStandardState'
// For ise
Rect * ewg_function_GetWindowStandardState (WindowRef ewg_window, Rect *ewg_rect)
{
	return GetWindowStandardState ((WindowRef)ewg_window, (Rect*)ewg_rect);
}

// Return address of function 'GetWindowStandardState'
void* ewg_get_function_address_GetWindowStandardState (void)
{
	return (void*) GetWindowStandardState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowUserState'
// For ise
Rect * ewg_function_GetWindowUserState (WindowRef ewg_window, Rect *ewg_rect)
{
	return GetWindowUserState ((WindowRef)ewg_window, (Rect*)ewg_rect);
}

// Return address of function 'GetWindowUserState'
void* ewg_get_function_address_GetWindowUserState (void)
{
	return (void*) GetWindowUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowKind'
// For ise
void  ewg_function_SetWindowKind (WindowRef ewg_window, short ewg_kind)
{
	SetWindowKind ((WindowRef)ewg_window, (short)ewg_kind);
}

// Return address of function 'SetWindowKind'
void* ewg_get_function_address_SetWindowKind (void)
{
	return (void*) SetWindowKind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowStandardState'
// For ise
void  ewg_function_SetWindowStandardState (WindowRef ewg_window, Rect const *ewg_rect)
{
	SetWindowStandardState ((WindowRef)ewg_window, (Rect const*)ewg_rect);
}

// Return address of function 'SetWindowStandardState'
void* ewg_get_function_address_SetWindowStandardState (void)
{
	return (void*) SetWindowStandardState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowUserState'
// For ise
void  ewg_function_SetWindowUserState (WindowRef ewg_window, Rect const *ewg_rect)
{
	SetWindowUserState ((WindowRef)ewg_window, (Rect const*)ewg_rect);
}

// Return address of function 'SetWindowUserState'
void* ewg_get_function_address_SetWindowUserState (void)
{
	return (void*) SetWindowUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetPortWindowPort'
// For ise
void  ewg_function_SetPortWindowPort (WindowRef ewg_window)
{
	SetPortWindowPort ((WindowRef)ewg_window);
}

// Return address of function 'SetPortWindowPort'
void* ewg_get_function_address_SetPortWindowPort (void)
{
	return (void*) SetPortWindowPort;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowPortBounds'
// For ise
Rect * ewg_function_GetWindowPortBounds (WindowRef ewg_window, Rect *ewg_bounds)
{
	return GetWindowPortBounds ((WindowRef)ewg_window, (Rect*)ewg_bounds);
}

// Return address of function 'GetWindowPortBounds'
void* ewg_get_function_address_GetWindowPortBounds (void)
{
	return (void*) GetWindowPortBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowFromPort'
// For ise
WindowRef  ewg_function_GetWindowFromPort (CGrafPtr ewg_port)
{
	return GetWindowFromPort ((CGrafPtr)ewg_port);
}

// Return address of function 'GetWindowFromPort'
void* ewg_get_function_address_GetWindowFromPort (void)
{
	return (void*) GetWindowFromPort;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsUserCancelEventRef'
// For ise
Boolean  ewg_function_IsUserCancelEventRef (EventRef ewg_event)
{
	return IsUserCancelEventRef ((EventRef)ewg_event);
}

// Return address of function 'IsUserCancelEventRef'
void* ewg_get_function_address_IsUserCancelEventRef (void)
{
	return (void*) IsUserCancelEventRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackMouseLocation'
// For ise
OSStatus  ewg_function_TrackMouseLocation (GrafPtr ewg_inPort, Point *ewg_outPt, MouseTrackingResult *ewg_outResult)
{
	return TrackMouseLocation ((GrafPtr)ewg_inPort, (Point*)ewg_outPt, (MouseTrackingResult*)ewg_outResult);
}

// Return address of function 'TrackMouseLocation'
void* ewg_get_function_address_TrackMouseLocation (void)
{
	return (void*) TrackMouseLocation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackMouseLocationWithOptions'
// For ise
OSStatus  ewg_function_TrackMouseLocationWithOptions (GrafPtr ewg_inPort, OptionBits ewg_inOptions, EventTimeout ewg_inTimeout, Point *ewg_outPt, UInt32 *ewg_outModifiers, MouseTrackingResult *ewg_outResult)
{
	return TrackMouseLocationWithOptions ((GrafPtr)ewg_inPort, (OptionBits)ewg_inOptions, (EventTimeout)ewg_inTimeout, (Point*)ewg_outPt, (UInt32*)ewg_outModifiers, (MouseTrackingResult*)ewg_outResult);
}

// Return address of function 'TrackMouseLocationWithOptions'
void* ewg_get_function_address_TrackMouseLocationWithOptions (void)
{
	return (void*) TrackMouseLocationWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TrackMouseRegion'
// For ise
OSStatus  ewg_function_TrackMouseRegion (GrafPtr ewg_inPort, RgnHandle ewg_inRegion, Boolean *ewg_ioWasInRgn, MouseTrackingResult *ewg_outResult)
{
	return TrackMouseRegion ((GrafPtr)ewg_inPort, (RgnHandle)ewg_inRegion, (Boolean*)ewg_ioWasInRgn, (MouseTrackingResult*)ewg_outResult);
}

// Return address of function 'TrackMouseRegion'
void* ewg_get_function_address_TrackMouseRegion (void)
{
	return (void*) TrackMouseRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIMouseTrackingGetParameters'
// For ise
OSStatus  ewg_function_HIMouseTrackingGetParameters (OSType ewg_inSelector, EventTime *ewg_outTime, HISize *ewg_outDistance)
{
	return HIMouseTrackingGetParameters ((OSType)ewg_inSelector, (EventTime*)ewg_outTime, (HISize*)ewg_outDistance);
}

// Return address of function 'HIMouseTrackingGetParameters'
void* ewg_get_function_address_HIMouseTrackingGetParameters (void)
{
	return (void*) HIMouseTrackingGetParameters;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ConvertEventRefToEventRecord'
// For ise
Boolean  ewg_function_ConvertEventRefToEventRecord (EventRef ewg_inEvent, EventRecord *ewg_outEvent)
{
	return ConvertEventRefToEventRecord ((EventRef)ewg_inEvent, (EventRecord*)ewg_outEvent);
}

// Return address of function 'ConvertEventRefToEventRecord'
void* ewg_get_function_address_ConvertEventRefToEventRecord (void)
{
	return (void*) ConvertEventRefToEventRecord;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsEventInMask'
// For ise
Boolean  ewg_function_IsEventInMask (EventRef ewg_inEvent, EventMask ewg_inMask)
{
	return IsEventInMask ((EventRef)ewg_inEvent, (EventMask)ewg_inMask);
}

// Return address of function 'IsEventInMask'
void* ewg_get_function_address_IsEventInMask (void)
{
	return (void*) IsEventInMask;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetLastUserEventTime'
// For ise
EventTime  ewg_function_GetLastUserEventTime (void)
{
	return GetLastUserEventTime ();
}

// Return address of function 'GetLastUserEventTime'
void* ewg_get_function_address_GetLastUserEventTime (void)
{
	return (void*) GetLastUserEventTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsMouseCoalescingEnabled'
// For ise
Boolean  ewg_function_IsMouseCoalescingEnabled (void)
{
	return IsMouseCoalescingEnabled ();
}

// Return address of function 'IsMouseCoalescingEnabled'
void* ewg_get_function_address_IsMouseCoalescingEnabled (void)
{
	return (void*) IsMouseCoalescingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMouseCoalescingEnabled'
// For ise
OSStatus  ewg_function_SetMouseCoalescingEnabled (Boolean ewg_inNewState, Boolean *ewg_outOldState)
{
	return SetMouseCoalescingEnabled ((Boolean)ewg_inNewState, (Boolean*)ewg_outOldState);
}

// Return address of function 'SetMouseCoalescingEnabled'
void* ewg_get_function_address_SetMouseCoalescingEnabled (void)
{
	return (void*) SetMouseCoalescingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateTypeStringWithOSType'
// For ise
CFStringRef  ewg_function_CreateTypeStringWithOSType (OSType ewg_inType)
{
	return CreateTypeStringWithOSType ((OSType)ewg_inType);
}

// Return address of function 'CreateTypeStringWithOSType'
void* ewg_get_function_address_CreateTypeStringWithOSType (void)
{
	return (void*) CreateTypeStringWithOSType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyServicesMenuCommandKeys'
// For ise
OSStatus  ewg_function_CopyServicesMenuCommandKeys (CFArrayRef *ewg_outCommandKeyArray)
{
	return CopyServicesMenuCommandKeys ((CFArrayRef*)ewg_outCommandKeyArray);
}

// Return address of function 'CopyServicesMenuCommandKeys'
void* ewg_get_function_address_CopyServicesMenuCommandKeys (void)
{
	return (void*) CopyServicesMenuCommandKeys;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXUIElementCreateWithHIObjectAndIdentifier'
// For ise
AXUIElementRef  ewg_function_AXUIElementCreateWithHIObjectAndIdentifier (HIObjectRef ewg_inHIObject, UInt64 ewg_inIdentifier)
{
	return AXUIElementCreateWithHIObjectAndIdentifier ((HIObjectRef)ewg_inHIObject, (UInt64)ewg_inIdentifier);
}

// Return address of function 'AXUIElementCreateWithHIObjectAndIdentifier'
void* ewg_get_function_address_AXUIElementCreateWithHIObjectAndIdentifier (void)
{
	return (void*) AXUIElementCreateWithHIObjectAndIdentifier;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXUIElementGetHIObject'
// For ise
HIObjectRef  ewg_function_AXUIElementGetHIObject (AXUIElementRef ewg_inUIElement)
{
	return AXUIElementGetHIObject ((AXUIElementRef)ewg_inUIElement);
}

// Return address of function 'AXUIElementGetHIObject'
void* ewg_get_function_address_AXUIElementGetHIObject (void)
{
	return (void*) AXUIElementGetHIObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXUIElementGetIdentifier'
// For ise
void  ewg_function_AXUIElementGetIdentifier (AXUIElementRef ewg_inUIElement, UInt64 *ewg_outIdentifier)
{
	AXUIElementGetIdentifier ((AXUIElementRef)ewg_inUIElement, (UInt64*)ewg_outIdentifier);
}

// Return address of function 'AXUIElementGetIdentifier'
void* ewg_get_function_address_AXUIElementGetIdentifier (void)
{
	return (void*) AXUIElementGetIdentifier;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXNotificationHIObjectNotify'
// For ise
void  ewg_function_AXNotificationHIObjectNotify (CFStringRef ewg_inNotification, HIObjectRef ewg_inHIObject, UInt64 ewg_inIdentifier)
{
	AXNotificationHIObjectNotify ((CFStringRef)ewg_inNotification, (HIObjectRef)ewg_inHIObject, (UInt64)ewg_inIdentifier);
}

// Return address of function 'AXNotificationHIObjectNotify'
void* ewg_get_function_address_AXNotificationHIObjectNotify (void)
{
	return (void*) AXNotificationHIObjectNotify;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HICopyAccessibilityRoleDescription'
// For ise
CFStringRef  ewg_function_HICopyAccessibilityRoleDescription (CFStringRef ewg_inRole, CFStringRef ewg_inSubrole)
{
	return HICopyAccessibilityRoleDescription ((CFStringRef)ewg_inRole, (CFStringRef)ewg_inSubrole);
}

// Return address of function 'HICopyAccessibilityRoleDescription'
void* ewg_get_function_address_HICopyAccessibilityRoleDescription (void)
{
	return (void*) HICopyAccessibilityRoleDescription;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HICopyAccessibilityActionDescription'
// For ise
CFStringRef  ewg_function_HICopyAccessibilityActionDescription (CFStringRef ewg_inAction)
{
	return HICopyAccessibilityActionDescription ((CFStringRef)ewg_inAction);
}

// Return address of function 'HICopyAccessibilityActionDescription'
void* ewg_get_function_address_HICopyAccessibilityActionDescription (void)
{
	return (void*) HICopyAccessibilityActionDescription;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowEventTarget'
// For ise
EventTargetRef  ewg_function_GetWindowEventTarget (WindowRef ewg_inWindow)
{
	return GetWindowEventTarget ((WindowRef)ewg_inWindow);
}

// Return address of function 'GetWindowEventTarget'
void* ewg_get_function_address_GetWindowEventTarget (void)
{
	return (void*) GetWindowEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetControlEventTarget'
// For ise
EventTargetRef  ewg_function_GetControlEventTarget (ControlRef ewg_inControl)
{
	return GetControlEventTarget ((ControlRef)ewg_inControl);
}

// Return address of function 'GetControlEventTarget'
void* ewg_get_function_address_GetControlEventTarget (void)
{
	return (void*) GetControlEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMenuEventTarget'
// For ise
EventTargetRef  ewg_function_GetMenuEventTarget (MenuRef ewg_inMenu)
{
	return GetMenuEventTarget ((MenuRef)ewg_inMenu);
}

// Return address of function 'GetMenuEventTarget'
void* ewg_get_function_address_GetMenuEventTarget (void)
{
	return (void*) GetMenuEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetApplicationEventTarget'
// For ise
EventTargetRef  ewg_function_GetApplicationEventTarget (void)
{
	return GetApplicationEventTarget ();
}

// Return address of function 'GetApplicationEventTarget'
void* ewg_get_function_address_GetApplicationEventTarget (void)
{
	return (void*) GetApplicationEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetUserFocusEventTarget'
// For ise
EventTargetRef  ewg_function_GetUserFocusEventTarget (void)
{
	return GetUserFocusEventTarget ();
}

// Return address of function 'GetUserFocusEventTarget'
void* ewg_get_function_address_GetUserFocusEventTarget (void)
{
	return (void*) GetUserFocusEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventDispatcherTarget'
// For ise
EventTargetRef  ewg_function_GetEventDispatcherTarget (void)
{
	return GetEventDispatcherTarget ();
}

// Return address of function 'GetEventDispatcherTarget'
void* ewg_get_function_address_GetEventDispatcherTarget (void)
{
	return (void*) GetEventDispatcherTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetEventMonitorTarget'
// For ise
EventTargetRef  ewg_function_GetEventMonitorTarget (void)
{
	return GetEventMonitorTarget ();
}

// Return address of function 'GetEventMonitorTarget'
void* ewg_get_function_address_GetEventMonitorTarget (void)
{
	return (void*) GetEventMonitorTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ProcessHICommand'
// For ise
OSStatus  ewg_function_ProcessHICommand (HICommand const *ewg_inCommand)
{
	return ProcessHICommand ((HICommand const*)ewg_inCommand);
}

// Return address of function 'ProcessHICommand'
void* ewg_get_function_address_ProcessHICommand (void)
{
	return (void*) ProcessHICommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RunApplicationEventLoop'
// For ise
void  ewg_function_RunApplicationEventLoop (void)
{
	RunApplicationEventLoop ();
}

// Return address of function 'RunApplicationEventLoop'
void* ewg_get_function_address_RunApplicationEventLoop (void)
{
	return (void*) RunApplicationEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QuitApplicationEventLoop'
// For ise
void  ewg_function_QuitApplicationEventLoop (void)
{
	QuitApplicationEventLoop ();
}

// Return address of function 'QuitApplicationEventLoop'
void* ewg_get_function_address_QuitApplicationEventLoop (void)
{
	return (void*) QuitApplicationEventLoop;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RunAppModalLoopForWindow'
// For ise
OSStatus  ewg_function_RunAppModalLoopForWindow (WindowRef ewg_inWindow)
{
	return RunAppModalLoopForWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'RunAppModalLoopForWindow'
void* ewg_get_function_address_RunAppModalLoopForWindow (void)
{
	return (void*) RunAppModalLoopForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'QuitAppModalLoopForWindow'
// For ise
OSStatus  ewg_function_QuitAppModalLoopForWindow (WindowRef ewg_inWindow)
{
	return QuitAppModalLoopForWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'QuitAppModalLoopForWindow'
void* ewg_get_function_address_QuitAppModalLoopForWindow (void)
{
	return (void*) QuitAppModalLoopForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'BeginAppModalStateForWindow'
// For ise
OSStatus  ewg_function_BeginAppModalStateForWindow (WindowRef ewg_inWindow)
{
	return BeginAppModalStateForWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'BeginAppModalStateForWindow'
void* ewg_get_function_address_BeginAppModalStateForWindow (void)
{
	return (void*) BeginAppModalStateForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EndAppModalStateForWindow'
// For ise
OSStatus  ewg_function_EndAppModalStateForWindow (WindowRef ewg_inWindow)
{
	return EndAppModalStateForWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'EndAppModalStateForWindow'
void* ewg_get_function_address_EndAppModalStateForWindow (void)
{
	return (void*) EndAppModalStateForWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetUserFocusWindow'
// For ise
OSStatus  ewg_function_SetUserFocusWindow (WindowRef ewg_inWindow)
{
	return SetUserFocusWindow ((WindowRef)ewg_inWindow);
}

// Return address of function 'SetUserFocusWindow'
void* ewg_get_function_address_SetUserFocusWindow (void)
{
	return (void*) SetUserFocusWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetUserFocusWindow'
// For ise
WindowRef  ewg_function_GetUserFocusWindow (void)
{
	return GetUserFocusWindow ();
}

// Return address of function 'GetUserFocusWindow'
void* ewg_get_function_address_GetUserFocusWindow (void)
{
	return (void*) GetUserFocusWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowDefaultButton'
// For ise
OSStatus  ewg_function_SetWindowDefaultButton (WindowRef ewg_inWindow, ControlRef ewg_inControl)
{
	return SetWindowDefaultButton ((WindowRef)ewg_inWindow, (ControlRef)ewg_inControl);
}

// Return address of function 'SetWindowDefaultButton'
void* ewg_get_function_address_SetWindowDefaultButton (void)
{
	return (void*) SetWindowDefaultButton;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowCancelButton'
// For ise
OSStatus  ewg_function_SetWindowCancelButton (WindowRef ewg_inWindow, ControlRef ewg_inControl)
{
	return SetWindowCancelButton ((WindowRef)ewg_inWindow, (ControlRef)ewg_inControl);
}

// Return address of function 'SetWindowCancelButton'
void* ewg_get_function_address_SetWindowCancelButton (void)
{
	return (void*) SetWindowCancelButton;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowDefaultButton'
// For ise
OSStatus  ewg_function_GetWindowDefaultButton (WindowRef ewg_inWindow, ControlRef *ewg_outControl)
{
	return GetWindowDefaultButton ((WindowRef)ewg_inWindow, (ControlRef*)ewg_outControl);
}

// Return address of function 'GetWindowDefaultButton'
void* ewg_get_function_address_GetWindowDefaultButton (void)
{
	return (void*) GetWindowDefaultButton;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetWindowCancelButton'
// For ise
OSStatus  ewg_function_GetWindowCancelButton (WindowRef ewg_inWindow, ControlRef *ewg_outControl)
{
	return GetWindowCancelButton ((WindowRef)ewg_inWindow, (ControlRef*)ewg_outControl);
}

// Return address of function 'GetWindowCancelButton'
void* ewg_get_function_address_GetWindowCancelButton (void)
{
	return (void*) GetWindowCancelButton;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RegisterEventHotKey'
// For ise
OSStatus  ewg_function_RegisterEventHotKey (UInt32 ewg_inHotKeyCode, UInt32 ewg_inHotKeyModifiers, EventHotKeyID *ewg_inHotKeyID, EventTargetRef ewg_inTarget, OptionBits ewg_inOptions, EventHotKeyRef *ewg_outRef)
{
	return RegisterEventHotKey ((UInt32)ewg_inHotKeyCode, (UInt32)ewg_inHotKeyModifiers, *(EventHotKeyID*)ewg_inHotKeyID, (EventTargetRef)ewg_inTarget, (OptionBits)ewg_inOptions, (EventHotKeyRef*)ewg_outRef);
}

// Return address of function 'RegisterEventHotKey'
void* ewg_get_function_address_RegisterEventHotKey (void)
{
	return (void*) RegisterEventHotKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UnregisterEventHotKey'
// For ise
OSStatus  ewg_function_UnregisterEventHotKey (EventHotKeyRef ewg_inHotKey)
{
	return UnregisterEventHotKey ((EventHotKeyRef)ewg_inHotKey);
}

// Return address of function 'UnregisterEventHotKey'
void* ewg_get_function_address_UnregisterEventHotKey (void)
{
	return (void*) UnregisterEventHotKey;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopySymbolicHotKeys'
// For ise
OSStatus  ewg_function_CopySymbolicHotKeys (CFArrayRef *ewg_outHotKeyArray)
{
	return CopySymbolicHotKeys ((CFArrayRef*)ewg_outHotKeyArray);
}

// Return address of function 'CopySymbolicHotKeys'
void* ewg_get_function_address_CopySymbolicHotKeys (void)
{
	return (void*) CopySymbolicHotKeys;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PushSymbolicHotKeyMode'
// For ise
void * ewg_function_PushSymbolicHotKeyMode (OptionBits ewg_inOptions)
{
	return PushSymbolicHotKeyMode ((OptionBits)ewg_inOptions);
}

// Return address of function 'PushSymbolicHotKeyMode'
void* ewg_get_function_address_PushSymbolicHotKeyMode (void)
{
	return (void*) PushSymbolicHotKeyMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PopSymbolicHotKeyMode'
// For ise
void  ewg_function_PopSymbolicHotKeyMode (void *ewg_inToken)
{
	PopSymbolicHotKeyMode ((void*)ewg_inToken);
}

// Return address of function 'PopSymbolicHotKeyMode'
void* ewg_get_function_address_PopSymbolicHotKeyMode (void)
{
	return (void*) PopSymbolicHotKeyMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetSymbolicHotKeyMode'
// For ise
OptionBits  ewg_function_GetSymbolicHotKeyMode (void)
{
	return GetSymbolicHotKeyMode ();
}

// Return address of function 'GetSymbolicHotKeyMode'
void* ewg_get_function_address_GetSymbolicHotKeyMode (void)
{
	return (void*) GetSymbolicHotKeyMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateMouseTrackingRegion'
// For ise
OSStatus  ewg_function_CreateMouseTrackingRegion (WindowRef ewg_inWindow, RgnHandle ewg_inRegion, RgnHandle ewg_inClip, MouseTrackingOptions ewg_inOptions, MouseTrackingRegionID *ewg_inID, void *ewg_inRefCon, EventTargetRef ewg_inTargetToNotify, MouseTrackingRef *ewg_outTrackingRef)
{
	return CreateMouseTrackingRegion ((WindowRef)ewg_inWindow, (RgnHandle)ewg_inRegion, (RgnHandle)ewg_inClip, (MouseTrackingOptions)ewg_inOptions, *(MouseTrackingRegionID*)ewg_inID, (void*)ewg_inRefCon, (EventTargetRef)ewg_inTargetToNotify, (MouseTrackingRef*)ewg_outTrackingRef);
}

// Return address of function 'CreateMouseTrackingRegion'
void* ewg_get_function_address_CreateMouseTrackingRegion (void)
{
	return (void*) CreateMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RetainMouseTrackingRegion'
// For ise
OSStatus  ewg_function_RetainMouseTrackingRegion (MouseTrackingRef ewg_inMouseRef)
{
	return RetainMouseTrackingRegion ((MouseTrackingRef)ewg_inMouseRef);
}

// Return address of function 'RetainMouseTrackingRegion'
void* ewg_get_function_address_RetainMouseTrackingRegion (void)
{
	return (void*) RetainMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseMouseTrackingRegion'
// For ise
OSStatus  ewg_function_ReleaseMouseTrackingRegion (MouseTrackingRef ewg_inMouseRef)
{
	return ReleaseMouseTrackingRegion ((MouseTrackingRef)ewg_inMouseRef);
}

// Return address of function 'ReleaseMouseTrackingRegion'
void* ewg_get_function_address_ReleaseMouseTrackingRegion (void)
{
	return (void*) ReleaseMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ChangeMouseTrackingRegion'
// For ise
OSStatus  ewg_function_ChangeMouseTrackingRegion (MouseTrackingRef ewg_inMouseRef, RgnHandle ewg_inRegion, RgnHandle ewg_inClip)
{
	return ChangeMouseTrackingRegion ((MouseTrackingRef)ewg_inMouseRef, (RgnHandle)ewg_inRegion, (RgnHandle)ewg_inClip);
}

// Return address of function 'ChangeMouseTrackingRegion'
void* ewg_get_function_address_ChangeMouseTrackingRegion (void)
{
	return (void*) ChangeMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ClipMouseTrackingRegion'
// For ise
OSStatus  ewg_function_ClipMouseTrackingRegion (MouseTrackingRef ewg_inMouseRef, RgnHandle ewg_inRegion)
{
	return ClipMouseTrackingRegion ((MouseTrackingRef)ewg_inMouseRef, (RgnHandle)ewg_inRegion);
}

// Return address of function 'ClipMouseTrackingRegion'
void* ewg_get_function_address_ClipMouseTrackingRegion (void)
{
	return (void*) ClipMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMouseTrackingRegionID'
// For ise
OSStatus  ewg_function_GetMouseTrackingRegionID (MouseTrackingRef ewg_inMouseRef, MouseTrackingRegionID *ewg_outID)
{
	return GetMouseTrackingRegionID ((MouseTrackingRef)ewg_inMouseRef, (MouseTrackingRegionID*)ewg_outID);
}

// Return address of function 'GetMouseTrackingRegionID'
void* ewg_get_function_address_GetMouseTrackingRegionID (void)
{
	return (void*) GetMouseTrackingRegionID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetMouseTrackingRegionRefCon'
// For ise
OSStatus  ewg_function_GetMouseTrackingRegionRefCon (MouseTrackingRef ewg_inMouseRef, void **ewg_outRefCon)
{
	return GetMouseTrackingRegionRefCon ((MouseTrackingRef)ewg_inMouseRef, (void**)ewg_outRefCon);
}

// Return address of function 'GetMouseTrackingRegionRefCon'
void* ewg_get_function_address_GetMouseTrackingRegionRefCon (void)
{
	return (void*) GetMouseTrackingRegionRefCon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveMouseTrackingRegion'
// For ise
OSStatus  ewg_function_MoveMouseTrackingRegion (MouseTrackingRef ewg_inMouseRef, SInt16 ewg_deltaH, SInt16 ewg_deltaV, RgnHandle ewg_inClip)
{
	return MoveMouseTrackingRegion ((MouseTrackingRef)ewg_inMouseRef, (SInt16)ewg_deltaH, (SInt16)ewg_deltaV, (RgnHandle)ewg_inClip);
}

// Return address of function 'MoveMouseTrackingRegion'
void* ewg_get_function_address_MoveMouseTrackingRegion (void)
{
	return (void*) MoveMouseTrackingRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetMouseTrackingRegionEnabled'
// For ise
OSStatus  ewg_function_SetMouseTrackingRegionEnabled (MouseTrackingRef ewg_inMouseRef, Boolean ewg_inEnabled)
{
	return SetMouseTrackingRegionEnabled ((MouseTrackingRef)ewg_inMouseRef, (Boolean)ewg_inEnabled);
}

// Return address of function 'SetMouseTrackingRegionEnabled'
void* ewg_get_function_address_SetMouseTrackingRegionEnabled (void)
{
	return (void*) SetMouseTrackingRegionEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ClipWindowMouseTrackingRegions'
// For ise
OSStatus  ewg_function_ClipWindowMouseTrackingRegions (WindowRef ewg_inWindow, OSType ewg_inSignature, RgnHandle ewg_inClip)
{
	return ClipWindowMouseTrackingRegions ((WindowRef)ewg_inWindow, (OSType)ewg_inSignature, (RgnHandle)ewg_inClip);
}

// Return address of function 'ClipWindowMouseTrackingRegions'
void* ewg_get_function_address_ClipWindowMouseTrackingRegions (void)
{
	return (void*) ClipWindowMouseTrackingRegions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveWindowMouseTrackingRegions'
// For ise
OSStatus  ewg_function_MoveWindowMouseTrackingRegions (WindowRef ewg_inWindow, OSType ewg_inSignature, SInt16 ewg_deltaH, SInt16 ewg_deltaV, RgnHandle ewg_inClip)
{
	return MoveWindowMouseTrackingRegions ((WindowRef)ewg_inWindow, (OSType)ewg_inSignature, (SInt16)ewg_deltaH, (SInt16)ewg_deltaV, (RgnHandle)ewg_inClip);
}

// Return address of function 'MoveWindowMouseTrackingRegions'
void* ewg_get_function_address_MoveWindowMouseTrackingRegions (void)
{
	return (void*) MoveWindowMouseTrackingRegions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetWindowMouseTrackingRegionsEnabled'
// For ise
OSStatus  ewg_function_SetWindowMouseTrackingRegionsEnabled (WindowRef ewg_inWindow, OSType ewg_inSignature, Boolean ewg_inEnabled)
{
	return SetWindowMouseTrackingRegionsEnabled ((WindowRef)ewg_inWindow, (OSType)ewg_inSignature, (Boolean)ewg_inEnabled);
}

// Return address of function 'SetWindowMouseTrackingRegionsEnabled'
void* ewg_get_function_address_SetWindowMouseTrackingRegionsEnabled (void)
{
	return (void*) SetWindowMouseTrackingRegionsEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ReleaseWindowMouseTrackingRegions'
// For ise
OSStatus  ewg_function_ReleaseWindowMouseTrackingRegions (WindowRef ewg_inWindow, OSType ewg_inSignature)
{
	return ReleaseWindowMouseTrackingRegions ((WindowRef)ewg_inWindow, (OSType)ewg_inSignature);
}

// Return address of function 'ReleaseWindowMouseTrackingRegions'
void* ewg_get_function_address_ReleaseWindowMouseTrackingRegions (void)
{
	return (void*) ReleaseWindowMouseTrackingRegions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RegisterToolboxObjectClass'
// For ise
OSStatus  ewg_function_RegisterToolboxObjectClass (CFStringRef ewg_inClassID, ToolboxObjectClassRef ewg_inBaseClass, UInt32 ewg_inNumEvents, EventTypeSpec const *ewg_inEventList, EventHandlerUPP ewg_inEventHandler, void *ewg_inEventHandlerData, ToolboxObjectClassRef *ewg_outClassRef)
{
	return RegisterToolboxObjectClass ((CFStringRef)ewg_inClassID, (ToolboxObjectClassRef)ewg_inBaseClass, (UInt32)ewg_inNumEvents, (EventTypeSpec const*)ewg_inEventList, (EventHandlerUPP)ewg_inEventHandler, (void*)ewg_inEventHandlerData, (ToolboxObjectClassRef*)ewg_outClassRef);
}

// Return address of function 'RegisterToolboxObjectClass'
void* ewg_get_function_address_RegisterToolboxObjectClass (void)
{
	return (void*) RegisterToolboxObjectClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UnregisterToolboxObjectClass'
// For ise
OSStatus  ewg_function_UnregisterToolboxObjectClass (ToolboxObjectClassRef ewg_inClassRef)
{
	return UnregisterToolboxObjectClass ((ToolboxObjectClassRef)ewg_inClassRef);
}

// Return address of function 'UnregisterToolboxObjectClass'
void* ewg_get_function_address_UnregisterToolboxObjectClass (void)
{
	return (void*) UnregisterToolboxObjectClass;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetRoot'
// For ise
HIViewRef  ewg_function_HIViewGetRoot (WindowRef ewg_inWindow)
{
	return HIViewGetRoot ((WindowRef)ewg_inWindow);
}

// Return address of function 'HIViewGetRoot'
void* ewg_get_function_address_HIViewGetRoot (void)
{
	return (void*) HIViewGetRoot;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewAddSubview'
// For ise
OSStatus  ewg_function_HIViewAddSubview (HIViewRef ewg_inParent, HIViewRef ewg_inNewChild)
{
	return HIViewAddSubview ((HIViewRef)ewg_inParent, (HIViewRef)ewg_inNewChild);
}

// Return address of function 'HIViewAddSubview'
void* ewg_get_function_address_HIViewAddSubview (void)
{
	return (void*) HIViewAddSubview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewRemoveFromSuperview'
// For ise
OSStatus  ewg_function_HIViewRemoveFromSuperview (HIViewRef ewg_inView)
{
	return HIViewRemoveFromSuperview ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewRemoveFromSuperview'
void* ewg_get_function_address_HIViewRemoveFromSuperview (void)
{
	return (void*) HIViewRemoveFromSuperview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetSuperview'
// For ise
HIViewRef  ewg_function_HIViewGetSuperview (HIViewRef ewg_inView)
{
	return HIViewGetSuperview ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetSuperview'
void* ewg_get_function_address_HIViewGetSuperview (void)
{
	return (void*) HIViewGetSuperview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetFirstSubview'
// For ise
HIViewRef  ewg_function_HIViewGetFirstSubview (HIViewRef ewg_inView)
{
	return HIViewGetFirstSubview ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetFirstSubview'
void* ewg_get_function_address_HIViewGetFirstSubview (void)
{
	return (void*) HIViewGetFirstSubview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetLastSubview'
// For ise
HIViewRef  ewg_function_HIViewGetLastSubview (HIViewRef ewg_inView)
{
	return HIViewGetLastSubview ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetLastSubview'
void* ewg_get_function_address_HIViewGetLastSubview (void)
{
	return (void*) HIViewGetLastSubview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetNextView'
// For ise
HIViewRef  ewg_function_HIViewGetNextView (HIViewRef ewg_inView)
{
	return HIViewGetNextView ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetNextView'
void* ewg_get_function_address_HIViewGetNextView (void)
{
	return (void*) HIViewGetNextView;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetPreviousView'
// For ise
HIViewRef  ewg_function_HIViewGetPreviousView (HIViewRef ewg_inView)
{
	return HIViewGetPreviousView ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetPreviousView'
void* ewg_get_function_address_HIViewGetPreviousView (void)
{
	return (void*) HIViewGetPreviousView;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewCountSubviews'
// For ise
CFIndex  ewg_function_HIViewCountSubviews (HIViewRef ewg_inView)
{
	return HIViewCountSubviews ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewCountSubviews'
void* ewg_get_function_address_HIViewCountSubviews (void)
{
	return (void*) HIViewCountSubviews;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetIndexedSubview'
// For ise
OSStatus  ewg_function_HIViewGetIndexedSubview (HIViewRef ewg_inView, CFIndex ewg_inSubviewIndex, HIViewRef *ewg_outSubview)
{
	return HIViewGetIndexedSubview ((HIViewRef)ewg_inView, (CFIndex)ewg_inSubviewIndex, (HIViewRef*)ewg_outSubview);
}

// Return address of function 'HIViewGetIndexedSubview'
void* ewg_get_function_address_HIViewGetIndexedSubview (void)
{
	return (void*) HIViewGetIndexedSubview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetZOrder'
// For ise
OSStatus  ewg_function_HIViewSetZOrder (HIViewRef ewg_inView, HIViewZOrderOp ewg_inOp, HIViewRef ewg_inOther)
{
	return HIViewSetZOrder ((HIViewRef)ewg_inView, (HIViewZOrderOp)ewg_inOp, (HIViewRef)ewg_inOther);
}

// Return address of function 'HIViewSetZOrder'
void* ewg_get_function_address_HIViewSetZOrder (void)
{
	return (void*) HIViewSetZOrder;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetVisible'
// For ise
OSStatus  ewg_function_HIViewSetVisible (HIViewRef ewg_inView, Boolean ewg_inVisible)
{
	return HIViewSetVisible ((HIViewRef)ewg_inView, (Boolean)ewg_inVisible);
}

// Return address of function 'HIViewSetVisible'
void* ewg_get_function_address_HIViewSetVisible (void)
{
	return (void*) HIViewSetVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsVisible'
// For ise
Boolean  ewg_function_HIViewIsVisible (HIViewRef ewg_inView)
{
	return HIViewIsVisible ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsVisible'
void* ewg_get_function_address_HIViewIsVisible (void)
{
	return (void*) HIViewIsVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsLatentlyVisible'
// For ise
Boolean  ewg_function_HIViewIsLatentlyVisible (HIViewRef ewg_inView)
{
	return HIViewIsLatentlyVisible ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsLatentlyVisible'
void* ewg_get_function_address_HIViewIsLatentlyVisible (void)
{
	return (void*) HIViewIsLatentlyVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetHilite'
// For ise
OSStatus  ewg_function_HIViewSetHilite (HIViewRef ewg_inView, HIViewPartCode ewg_inHilitePart)
{
	return HIViewSetHilite ((HIViewRef)ewg_inView, (HIViewPartCode)ewg_inHilitePart);
}

// Return address of function 'HIViewSetHilite'
void* ewg_get_function_address_HIViewSetHilite (void)
{
	return (void*) HIViewSetHilite;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsActive'
// For ise
Boolean  ewg_function_HIViewIsActive (HIViewRef ewg_inView, Boolean *ewg_outIsLatentActive)
{
	return HIViewIsActive ((HIViewRef)ewg_inView, (Boolean*)ewg_outIsLatentActive);
}

// Return address of function 'HIViewIsActive'
void* ewg_get_function_address_HIViewIsActive (void)
{
	return (void*) HIViewIsActive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetActivated'
// For ise
OSStatus  ewg_function_HIViewSetActivated (HIViewRef ewg_inView, Boolean ewg_inSetActivated)
{
	return HIViewSetActivated ((HIViewRef)ewg_inView, (Boolean)ewg_inSetActivated);
}

// Return address of function 'HIViewSetActivated'
void* ewg_get_function_address_HIViewSetActivated (void)
{
	return (void*) HIViewSetActivated;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsEnabled'
// For ise
Boolean  ewg_function_HIViewIsEnabled (HIViewRef ewg_inView, Boolean *ewg_outIsLatentEnabled)
{
	return HIViewIsEnabled ((HIViewRef)ewg_inView, (Boolean*)ewg_outIsLatentEnabled);
}

// Return address of function 'HIViewIsEnabled'
void* ewg_get_function_address_HIViewIsEnabled (void)
{
	return (void*) HIViewIsEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetEnabled'
// For ise
OSStatus  ewg_function_HIViewSetEnabled (HIViewRef ewg_inView, Boolean ewg_inSetEnabled)
{
	return HIViewSetEnabled ((HIViewRef)ewg_inView, (Boolean)ewg_inSetEnabled);
}

// Return address of function 'HIViewSetEnabled'
void* ewg_get_function_address_HIViewSetEnabled (void)
{
	return (void*) HIViewSetEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsCompositingEnabled'
// For ise
Boolean  ewg_function_HIViewIsCompositingEnabled (HIViewRef ewg_inView)
{
	return HIViewIsCompositingEnabled ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsCompositingEnabled'
void* ewg_get_function_address_HIViewIsCompositingEnabled (void)
{
	return (void*) HIViewIsCompositingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetText'
// For ise
OSStatus  ewg_function_HIViewSetText (HIViewRef ewg_inView, CFStringRef ewg_inText)
{
	return HIViewSetText ((HIViewRef)ewg_inView, (CFStringRef)ewg_inText);
}

// Return address of function 'HIViewSetText'
void* ewg_get_function_address_HIViewSetText (void)
{
	return (void*) HIViewSetText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewCopyText'
// For ise
CFStringRef  ewg_function_HIViewCopyText (HIViewRef ewg_inView)
{
	return HIViewCopyText ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewCopyText'
void* ewg_get_function_address_HIViewCopyText (void)
{
	return (void*) HIViewCopyText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetValue'
// For ise
SInt32  ewg_function_HIViewGetValue (HIViewRef ewg_inView)
{
	return HIViewGetValue ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetValue'
void* ewg_get_function_address_HIViewGetValue (void)
{
	return (void*) HIViewGetValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetValue'
// For ise
OSStatus  ewg_function_HIViewSetValue (HIViewRef ewg_inView, SInt32 ewg_inValue)
{
	return HIViewSetValue ((HIViewRef)ewg_inView, (SInt32)ewg_inValue);
}

// Return address of function 'HIViewSetValue'
void* ewg_get_function_address_HIViewSetValue (void)
{
	return (void*) HIViewSetValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetMinimum'
// For ise
SInt32  ewg_function_HIViewGetMinimum (HIViewRef ewg_inView)
{
	return HIViewGetMinimum ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetMinimum'
void* ewg_get_function_address_HIViewGetMinimum (void)
{
	return (void*) HIViewGetMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetMinimum'
// For ise
OSStatus  ewg_function_HIViewSetMinimum (HIViewRef ewg_inView, SInt32 ewg_inMinimum)
{
	return HIViewSetMinimum ((HIViewRef)ewg_inView, (SInt32)ewg_inMinimum);
}

// Return address of function 'HIViewSetMinimum'
void* ewg_get_function_address_HIViewSetMinimum (void)
{
	return (void*) HIViewSetMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetMaximum'
// For ise
SInt32  ewg_function_HIViewGetMaximum (HIViewRef ewg_inView)
{
	return HIViewGetMaximum ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetMaximum'
void* ewg_get_function_address_HIViewGetMaximum (void)
{
	return (void*) HIViewGetMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetMaximum'
// For ise
OSStatus  ewg_function_HIViewSetMaximum (HIViewRef ewg_inView, SInt32 ewg_inMaximum)
{
	return HIViewSetMaximum ((HIViewRef)ewg_inView, (SInt32)ewg_inMaximum);
}

// Return address of function 'HIViewSetMaximum'
void* ewg_get_function_address_HIViewSetMaximum (void)
{
	return (void*) HIViewSetMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetViewSize'
// For ise
SInt32  ewg_function_HIViewGetViewSize (HIViewRef ewg_inView)
{
	return HIViewGetViewSize ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetViewSize'
void* ewg_get_function_address_HIViewGetViewSize (void)
{
	return (void*) HIViewGetViewSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetViewSize'
// For ise
OSStatus  ewg_function_HIViewSetViewSize (HIViewRef ewg_inView, SInt32 ewg_inViewSize)
{
	return HIViewSetViewSize ((HIViewRef)ewg_inView, (SInt32)ewg_inViewSize);
}

// Return address of function 'HIViewSetViewSize'
void* ewg_get_function_address_HIViewSetViewSize (void)
{
	return (void*) HIViewSetViewSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsValid'
// For ise
Boolean  ewg_function_HIViewIsValid (HIViewRef ewg_inView)
{
	return HIViewIsValid ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsValid'
void* ewg_get_function_address_HIViewIsValid (void)
{
	return (void*) HIViewIsValid;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetID'
// For ise
OSStatus  ewg_function_HIViewSetID (HIViewRef ewg_inView, HIViewID *ewg_inID)
{
	return HIViewSetID ((HIViewRef)ewg_inView, *(HIViewID*)ewg_inID);
}

// Return address of function 'HIViewSetID'
void* ewg_get_function_address_HIViewSetID (void)
{
	return (void*) HIViewSetID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetID'
// For ise
OSStatus  ewg_function_HIViewGetID (HIViewRef ewg_inView, HIViewID *ewg_outID)
{
	return HIViewGetID ((HIViewRef)ewg_inView, (HIViewID*)ewg_outID);
}

// Return address of function 'HIViewGetID'
void* ewg_get_function_address_HIViewGetID (void)
{
	return (void*) HIViewGetID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetCommandID'
// For ise
OSStatus  ewg_function_HIViewSetCommandID (HIViewRef ewg_inView, UInt32 ewg_inCommandID)
{
	return HIViewSetCommandID ((HIViewRef)ewg_inView, (UInt32)ewg_inCommandID);
}

// Return address of function 'HIViewSetCommandID'
void* ewg_get_function_address_HIViewSetCommandID (void)
{
	return (void*) HIViewSetCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetCommandID'
// For ise
OSStatus  ewg_function_HIViewGetCommandID (HIViewRef ewg_inView, UInt32 *ewg_outCommandID)
{
	return HIViewGetCommandID ((HIViewRef)ewg_inView, (UInt32*)ewg_outCommandID);
}

// Return address of function 'HIViewGetCommandID'
void* ewg_get_function_address_HIViewGetCommandID (void)
{
	return (void*) HIViewGetCommandID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetKind'
// For ise
OSStatus  ewg_function_HIViewGetKind (HIViewRef ewg_inView, HIViewKind *ewg_outViewKind)
{
	return HIViewGetKind ((HIViewRef)ewg_inView, (HIViewKind*)ewg_outViewKind);
}

// Return address of function 'HIViewGetKind'
void* ewg_get_function_address_HIViewGetKind (void)
{
	return (void*) HIViewGetKind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetBounds'
// For ise
OSStatus  ewg_function_HIViewGetBounds (HIViewRef ewg_inView, HIRect *ewg_outRect)
{
	return HIViewGetBounds ((HIViewRef)ewg_inView, (HIRect*)ewg_outRect);
}

// Return address of function 'HIViewGetBounds'
void* ewg_get_function_address_HIViewGetBounds (void)
{
	return (void*) HIViewGetBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetFrame'
// For ise
OSStatus  ewg_function_HIViewGetFrame (HIViewRef ewg_inView, HIRect *ewg_outRect)
{
	return HIViewGetFrame ((HIViewRef)ewg_inView, (HIRect*)ewg_outRect);
}

// Return address of function 'HIViewGetFrame'
void* ewg_get_function_address_HIViewGetFrame (void)
{
	return (void*) HIViewGetFrame;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetFrame'
// For ise
OSStatus  ewg_function_HIViewSetFrame (HIViewRef ewg_inView, HIRect const *ewg_inRect)
{
	return HIViewSetFrame ((HIViewRef)ewg_inView, (HIRect const*)ewg_inRect);
}

// Return address of function 'HIViewSetFrame'
void* ewg_get_function_address_HIViewSetFrame (void)
{
	return (void*) HIViewSetFrame;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewMoveBy'
// For ise
OSStatus  ewg_function_HIViewMoveBy (HIViewRef ewg_inView, float ewg_inDX, float ewg_inDY)
{
	return HIViewMoveBy ((HIViewRef)ewg_inView, (float)ewg_inDX, (float)ewg_inDY);
}

// Return address of function 'HIViewMoveBy'
void* ewg_get_function_address_HIViewMoveBy (void)
{
	return (void*) HIViewMoveBy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewPlaceInSuperviewAt'
// For ise
OSStatus  ewg_function_HIViewPlaceInSuperviewAt (HIViewRef ewg_inView, float ewg_inX, float ewg_inY)
{
	return HIViewPlaceInSuperviewAt ((HIViewRef)ewg_inView, (float)ewg_inX, (float)ewg_inY);
}

// Return address of function 'HIViewPlaceInSuperviewAt'
void* ewg_get_function_address_HIViewPlaceInSuperviewAt (void)
{
	return (void*) HIViewPlaceInSuperviewAt;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewReshapeStructure'
// For ise
OSStatus  ewg_function_HIViewReshapeStructure (HIViewRef ewg_inView)
{
	return HIViewReshapeStructure ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewReshapeStructure'
void* ewg_get_function_address_HIViewReshapeStructure (void)
{
	return (void*) HIViewReshapeStructure;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewRegionChanged'
// For ise
OSStatus  ewg_function_HIViewRegionChanged (HIViewRef ewg_inView, HIViewPartCode ewg_inRegionCode)
{
	return HIViewRegionChanged ((HIViewRef)ewg_inView, (HIViewPartCode)ewg_inRegionCode);
}

// Return address of function 'HIViewRegionChanged'
void* ewg_get_function_address_HIViewRegionChanged (void)
{
	return (void*) HIViewRegionChanged;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewCopyShape'
// For ise
OSStatus  ewg_function_HIViewCopyShape (HIViewRef ewg_inView, HIViewPartCode ewg_inPart, HIShapeRef *ewg_outShape)
{
	return HIViewCopyShape ((HIViewRef)ewg_inView, (HIViewPartCode)ewg_inPart, (HIShapeRef*)ewg_outShape);
}

// Return address of function 'HIViewCopyShape'
void* ewg_get_function_address_HIViewCopyShape (void)
{
	return (void*) HIViewCopyShape;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetOptimalBounds'
// For ise
OSStatus  ewg_function_HIViewGetOptimalBounds (HIViewRef ewg_inView, HIRect *ewg_outBounds, float *ewg_outBaseLineOffset)
{
	return HIViewGetOptimalBounds ((HIViewRef)ewg_inView, (HIRect*)ewg_outBounds, (float*)ewg_outBaseLineOffset);
}

// Return address of function 'HIViewGetOptimalBounds'
void* ewg_get_function_address_HIViewGetOptimalBounds (void)
{
	return (void*) HIViewGetOptimalBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetViewForMouseEvent'
// For ise
OSStatus  ewg_function_HIViewGetViewForMouseEvent (HIViewRef ewg_inView, EventRef ewg_inEvent, HIViewRef *ewg_outView)
{
	return HIViewGetViewForMouseEvent ((HIViewRef)ewg_inView, (EventRef)ewg_inEvent, (HIViewRef*)ewg_outView);
}

// Return address of function 'HIViewGetViewForMouseEvent'
void* ewg_get_function_address_HIViewGetViewForMouseEvent (void)
{
	return (void*) HIViewGetViewForMouseEvent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewClick'
// For ise
OSStatus  ewg_function_HIViewClick (HIViewRef ewg_inView, EventRef ewg_inEvent)
{
	return HIViewClick ((HIViewRef)ewg_inView, (EventRef)ewg_inEvent);
}

// Return address of function 'HIViewClick'
void* ewg_get_function_address_HIViewClick (void)
{
	return (void*) HIViewClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSimulateClick'
// For ise
OSStatus  ewg_function_HIViewSimulateClick (HIViewRef ewg_inView, HIViewPartCode ewg_inPartToClick, UInt32 ewg_inModifiers, HIViewPartCode *ewg_outPartClicked)
{
	return HIViewSimulateClick ((HIViewRef)ewg_inView, (HIViewPartCode)ewg_inPartToClick, (UInt32)ewg_inModifiers, (HIViewPartCode*)ewg_outPartClicked);
}

// Return address of function 'HIViewSimulateClick'
void* ewg_get_function_address_HIViewSimulateClick (void)
{
	return (void*) HIViewSimulateClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetPartHit'
// For ise
OSStatus  ewg_function_HIViewGetPartHit (HIViewRef ewg_inView, HIPoint const *ewg_inPoint, HIViewPartCode *ewg_outPart)
{
	return HIViewGetPartHit ((HIViewRef)ewg_inView, (HIPoint const*)ewg_inPoint, (HIViewPartCode*)ewg_outPart);
}

// Return address of function 'HIViewGetPartHit'
void* ewg_get_function_address_HIViewGetPartHit (void)
{
	return (void*) HIViewGetPartHit;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetSubviewHit'
// For ise
OSStatus  ewg_function_HIViewGetSubviewHit (HIViewRef ewg_inView, HIPoint const *ewg_inPoint, Boolean ewg_inDeep, HIViewRef *ewg_outView)
{
	return HIViewGetSubviewHit ((HIViewRef)ewg_inView, (HIPoint const*)ewg_inPoint, (Boolean)ewg_inDeep, (HIViewRef*)ewg_outView);
}

// Return address of function 'HIViewGetSubviewHit'
void* ewg_get_function_address_HIViewGetSubviewHit (void)
{
	return (void*) HIViewGetSubviewHit;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewNewTrackingArea'
// For ise
OSStatus  ewg_function_HIViewNewTrackingArea (HIViewRef ewg_inView, HIShapeRef ewg_inShape, HIViewTrackingAreaID ewg_inID, HIViewTrackingAreaRef *ewg_outRef)
{
	return HIViewNewTrackingArea ((HIViewRef)ewg_inView, (HIShapeRef)ewg_inShape, (HIViewTrackingAreaID)ewg_inID, (HIViewTrackingAreaRef*)ewg_outRef);
}

// Return address of function 'HIViewNewTrackingArea'
void* ewg_get_function_address_HIViewNewTrackingArea (void)
{
	return (void*) HIViewNewTrackingArea;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewChangeTrackingArea'
// For ise
OSStatus  ewg_function_HIViewChangeTrackingArea (HIViewTrackingAreaRef ewg_inArea, HIShapeRef ewg_inShape)
{
	return HIViewChangeTrackingArea ((HIViewTrackingAreaRef)ewg_inArea, (HIShapeRef)ewg_inShape);
}

// Return address of function 'HIViewChangeTrackingArea'
void* ewg_get_function_address_HIViewChangeTrackingArea (void)
{
	return (void*) HIViewChangeTrackingArea;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetTrackingAreaID'
// For ise
OSStatus  ewg_function_HIViewGetTrackingAreaID (HIViewTrackingAreaRef ewg_inArea, HIViewTrackingAreaID *ewg_outID)
{
	return HIViewGetTrackingAreaID ((HIViewTrackingAreaRef)ewg_inArea, (HIViewTrackingAreaID*)ewg_outID);
}

// Return address of function 'HIViewGetTrackingAreaID'
void* ewg_get_function_address_HIViewGetTrackingAreaID (void)
{
	return (void*) HIViewGetTrackingAreaID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewDisposeTrackingArea'
// For ise
OSStatus  ewg_function_HIViewDisposeTrackingArea (HIViewTrackingAreaRef ewg_inArea)
{
	return HIViewDisposeTrackingArea ((HIViewTrackingAreaRef)ewg_inArea);
}

// Return address of function 'HIViewDisposeTrackingArea'
void* ewg_get_function_address_HIViewDisposeTrackingArea (void)
{
	return (void*) HIViewDisposeTrackingArea;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetNeedsDisplay'
// For ise
Boolean  ewg_function_HIViewGetNeedsDisplay (HIViewRef ewg_inView)
{
	return HIViewGetNeedsDisplay ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetNeedsDisplay'
void* ewg_get_function_address_HIViewGetNeedsDisplay (void)
{
	return (void*) HIViewGetNeedsDisplay;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetNeedsDisplay'
// For ise
OSStatus  ewg_function_HIViewSetNeedsDisplay (HIViewRef ewg_inView, Boolean ewg_inNeedsDisplay)
{
	return HIViewSetNeedsDisplay ((HIViewRef)ewg_inView, (Boolean)ewg_inNeedsDisplay);
}

// Return address of function 'HIViewSetNeedsDisplay'
void* ewg_get_function_address_HIViewSetNeedsDisplay (void)
{
	return (void*) HIViewSetNeedsDisplay;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetNeedsDisplayInRect'
// For ise
OSStatus  ewg_function_HIViewSetNeedsDisplayInRect (HIViewRef ewg_inView, HIRect const *ewg_inRect, Boolean ewg_inNeedsDisplay)
{
	return HIViewSetNeedsDisplayInRect ((HIViewRef)ewg_inView, (HIRect const*)ewg_inRect, (Boolean)ewg_inNeedsDisplay);
}

// Return address of function 'HIViewSetNeedsDisplayInRect'
void* ewg_get_function_address_HIViewSetNeedsDisplayInRect (void)
{
	return (void*) HIViewSetNeedsDisplayInRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetNeedsDisplayInShape'
// For ise
OSStatus  ewg_function_HIViewSetNeedsDisplayInShape (HIViewRef ewg_inView, HIShapeRef ewg_inArea, Boolean ewg_inNeedsDisplay)
{
	return HIViewSetNeedsDisplayInShape ((HIViewRef)ewg_inView, (HIShapeRef)ewg_inArea, (Boolean)ewg_inNeedsDisplay);
}

// Return address of function 'HIViewSetNeedsDisplayInShape'
void* ewg_get_function_address_HIViewSetNeedsDisplayInShape (void)
{
	return (void*) HIViewSetNeedsDisplayInShape;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetNeedsDisplayInRegion'
// For ise
OSStatus  ewg_function_HIViewSetNeedsDisplayInRegion (HIViewRef ewg_inView, RgnHandle ewg_inRgn, Boolean ewg_inNeedsDisplay)
{
	return HIViewSetNeedsDisplayInRegion ((HIViewRef)ewg_inView, (RgnHandle)ewg_inRgn, (Boolean)ewg_inNeedsDisplay);
}

// Return address of function 'HIViewSetNeedsDisplayInRegion'
void* ewg_get_function_address_HIViewSetNeedsDisplayInRegion (void)
{
	return (void*) HIViewSetNeedsDisplayInRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewRender'
// For ise
OSStatus  ewg_function_HIViewRender (HIViewRef ewg_inView)
{
	return HIViewRender ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewRender'
void* ewg_get_function_address_HIViewRender (void)
{
	return (void*) HIViewRender;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewFlashDirtyArea'
// For ise
OSStatus  ewg_function_HIViewFlashDirtyArea (WindowRef ewg_inWindow)
{
	return HIViewFlashDirtyArea ((WindowRef)ewg_inWindow);
}

// Return address of function 'HIViewFlashDirtyArea'
void* ewg_get_function_address_HIViewFlashDirtyArea (void)
{
	return (void*) HIViewFlashDirtyArea;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetSizeConstraints'
// For ise
OSStatus  ewg_function_HIViewGetSizeConstraints (HIViewRef ewg_inView, HISize *ewg_outMinSize, HISize *ewg_outMaxSize)
{
	return HIViewGetSizeConstraints ((HIViewRef)ewg_inView, (HISize*)ewg_outMinSize, (HISize*)ewg_outMaxSize);
}

// Return address of function 'HIViewGetSizeConstraints'
void* ewg_get_function_address_HIViewGetSizeConstraints (void)
{
	return (void*) HIViewGetSizeConstraints;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewConvertPoint'
// For ise
OSStatus  ewg_function_HIViewConvertPoint (HIPoint *ewg_ioPoint, HIViewRef ewg_inSourceView, HIViewRef ewg_inDestView)
{
	return HIViewConvertPoint ((HIPoint*)ewg_ioPoint, (HIViewRef)ewg_inSourceView, (HIViewRef)ewg_inDestView);
}

// Return address of function 'HIViewConvertPoint'
void* ewg_get_function_address_HIViewConvertPoint (void)
{
	return (void*) HIViewConvertPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewConvertRect'
// For ise
OSStatus  ewg_function_HIViewConvertRect (HIRect *ewg_ioRect, HIViewRef ewg_inSourceView, HIViewRef ewg_inDestView)
{
	return HIViewConvertRect ((HIRect*)ewg_ioRect, (HIViewRef)ewg_inSourceView, (HIViewRef)ewg_inDestView);
}

// Return address of function 'HIViewConvertRect'
void* ewg_get_function_address_HIViewConvertRect (void)
{
	return (void*) HIViewConvertRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewConvertRegion'
// For ise
OSStatus  ewg_function_HIViewConvertRegion (RgnHandle ewg_ioRgn, HIViewRef ewg_inSourceView, HIViewRef ewg_inDestView)
{
	return HIViewConvertRegion ((RgnHandle)ewg_ioRgn, (HIViewRef)ewg_inSourceView, (HIViewRef)ewg_inDestView);
}

// Return address of function 'HIViewConvertRegion'
void* ewg_get_function_address_HIViewConvertRegion (void)
{
	return (void*) HIViewConvertRegion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetDrawingEnabled'
// For ise
OSStatus  ewg_function_HIViewSetDrawingEnabled (HIViewRef ewg_inView, Boolean ewg_inEnabled)
{
	return HIViewSetDrawingEnabled ((HIViewRef)ewg_inView, (Boolean)ewg_inEnabled);
}

// Return address of function 'HIViewSetDrawingEnabled'
void* ewg_get_function_address_HIViewSetDrawingEnabled (void)
{
	return (void*) HIViewSetDrawingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsDrawingEnabled'
// For ise
Boolean  ewg_function_HIViewIsDrawingEnabled (HIViewRef ewg_inView)
{
	return HIViewIsDrawingEnabled ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsDrawingEnabled'
void* ewg_get_function_address_HIViewIsDrawingEnabled (void)
{
	return (void*) HIViewIsDrawingEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewScrollRect'
// For ise
OSStatus  ewg_function_HIViewScrollRect (HIViewRef ewg_inView, HIRect const *ewg_inRect, float ewg_inDX, float ewg_inDY)
{
	return HIViewScrollRect ((HIViewRef)ewg_inView, (HIRect const*)ewg_inRect, (float)ewg_inDX, (float)ewg_inDY);
}

// Return address of function 'HIViewScrollRect'
void* ewg_get_function_address_HIViewScrollRect (void)
{
	return (void*) HIViewScrollRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetBoundsOrigin'
// For ise
OSStatus  ewg_function_HIViewSetBoundsOrigin (HIViewRef ewg_inView, float ewg_inX, float ewg_inY)
{
	return HIViewSetBoundsOrigin ((HIViewRef)ewg_inView, (float)ewg_inX, (float)ewg_inY);
}

// Return address of function 'HIViewSetBoundsOrigin'
void* ewg_get_function_address_HIViewSetBoundsOrigin (void)
{
	return (void*) HIViewSetBoundsOrigin;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewAdvanceFocus'
// For ise
OSStatus  ewg_function_HIViewAdvanceFocus (HIViewRef ewg_inRootForFocus, EventModifiers ewg_inModifiers)
{
	return HIViewAdvanceFocus ((HIViewRef)ewg_inRootForFocus, (EventModifiers)ewg_inModifiers);
}

// Return address of function 'HIViewAdvanceFocus'
void* ewg_get_function_address_HIViewAdvanceFocus (void)
{
	return (void*) HIViewAdvanceFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetFocusPart'
// For ise
OSStatus  ewg_function_HIViewGetFocusPart (HIViewRef ewg_inView, HIViewPartCode *ewg_outFocusPart)
{
	return HIViewGetFocusPart ((HIViewRef)ewg_inView, (HIViewPartCode*)ewg_outFocusPart);
}

// Return address of function 'HIViewGetFocusPart'
void* ewg_get_function_address_HIViewGetFocusPart (void)
{
	return (void*) HIViewGetFocusPart;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSubtreeContainsFocus'
// For ise
Boolean  ewg_function_HIViewSubtreeContainsFocus (HIViewRef ewg_inSubtreeStart)
{
	return HIViewSubtreeContainsFocus ((HIViewRef)ewg_inSubtreeStart);
}

// Return address of function 'HIViewSubtreeContainsFocus'
void* ewg_get_function_address_HIViewSubtreeContainsFocus (void)
{
	return (void*) HIViewSubtreeContainsFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetNextFocus'
// For ise
OSStatus  ewg_function_HIViewSetNextFocus (HIViewRef ewg_inView, HIViewRef ewg_inNextFocus)
{
	return HIViewSetNextFocus ((HIViewRef)ewg_inView, (HIViewRef)ewg_inNextFocus);
}

// Return address of function 'HIViewSetNextFocus'
void* ewg_get_function_address_HIViewSetNextFocus (void)
{
	return (void*) HIViewSetNextFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetFirstSubViewFocus'
// For ise
OSStatus  ewg_function_HIViewSetFirstSubViewFocus (HIViewRef ewg_inParent, HIViewRef ewg_inSubView)
{
	return HIViewSetFirstSubViewFocus ((HIViewRef)ewg_inParent, (HIViewRef)ewg_inSubView);
}

// Return address of function 'HIViewSetFirstSubViewFocus'
void* ewg_get_function_address_HIViewSetFirstSubViewFocus (void)
{
	return (void*) HIViewSetFirstSubViewFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetLayoutInfo'
// For ise
OSStatus  ewg_function_HIViewGetLayoutInfo (HIViewRef ewg_inView, HILayoutInfo *ewg_outLayoutInfo)
{
	return HIViewGetLayoutInfo ((HIViewRef)ewg_inView, (HILayoutInfo*)ewg_outLayoutInfo);
}

// Return address of function 'HIViewGetLayoutInfo'
void* ewg_get_function_address_HIViewGetLayoutInfo (void)
{
	return (void*) HIViewGetLayoutInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSetLayoutInfo'
// For ise
OSStatus  ewg_function_HIViewSetLayoutInfo (HIViewRef ewg_inView, HILayoutInfo const *ewg_inLayoutInfo)
{
	return HIViewSetLayoutInfo ((HIViewRef)ewg_inView, (HILayoutInfo const*)ewg_inLayoutInfo);
}

// Return address of function 'HIViewSetLayoutInfo'
void* ewg_get_function_address_HIViewSetLayoutInfo (void)
{
	return (void*) HIViewSetLayoutInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewSuspendLayout'
// For ise
OSStatus  ewg_function_HIViewSuspendLayout (HIViewRef ewg_inView)
{
	return HIViewSuspendLayout ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewSuspendLayout'
void* ewg_get_function_address_HIViewSuspendLayout (void)
{
	return (void*) HIViewSuspendLayout;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewResumeLayout'
// For ise
OSStatus  ewg_function_HIViewResumeLayout (HIViewRef ewg_inView)
{
	return HIViewResumeLayout ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewResumeLayout'
void* ewg_get_function_address_HIViewResumeLayout (void)
{
	return (void*) HIViewResumeLayout;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsLayoutActive'
// For ise
Boolean  ewg_function_HIViewIsLayoutActive (HIViewRef ewg_inView)
{
	return HIViewIsLayoutActive ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsLayoutActive'
void* ewg_get_function_address_HIViewIsLayoutActive (void)
{
	return (void*) HIViewIsLayoutActive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewIsLayoutLatentlyActive'
// For ise
Boolean  ewg_function_HIViewIsLayoutLatentlyActive (HIViewRef ewg_inView)
{
	return HIViewIsLayoutLatentlyActive ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewIsLayoutLatentlyActive'
void* ewg_get_function_address_HIViewIsLayoutLatentlyActive (void)
{
	return (void*) HIViewIsLayoutLatentlyActive;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewApplyLayout'
// For ise
OSStatus  ewg_function_HIViewApplyLayout (HIViewRef ewg_inView)
{
	return HIViewApplyLayout ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewApplyLayout'
void* ewg_get_function_address_HIViewApplyLayout (void)
{
	return (void*) HIViewApplyLayout;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetWindow'
// For ise
WindowRef  ewg_function_HIViewGetWindow (HIViewRef ewg_inView)
{
	return HIViewGetWindow ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetWindow'
void* ewg_get_function_address_HIViewGetWindow (void)
{
	return (void*) HIViewGetWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewFindByID'
// For ise
OSStatus  ewg_function_HIViewFindByID (HIViewRef ewg_inStartView, HIViewID *ewg_inID, HIViewRef *ewg_outControl)
{
	return HIViewFindByID ((HIViewRef)ewg_inStartView, *(HIViewID*)ewg_inID, (HIViewRef*)ewg_outControl);
}

// Return address of function 'HIViewFindByID'
void* ewg_get_function_address_HIViewFindByID (void)
{
	return (void*) HIViewFindByID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetAttributes'
// For ise
OSStatus  ewg_function_HIViewGetAttributes (HIViewRef ewg_inView, OptionBits *ewg_outAttrs)
{
	return HIViewGetAttributes ((HIViewRef)ewg_inView, (OptionBits*)ewg_outAttrs);
}

// Return address of function 'HIViewGetAttributes'
void* ewg_get_function_address_HIViewGetAttributes (void)
{
	return (void*) HIViewGetAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewChangeAttributes'
// For ise
OSStatus  ewg_function_HIViewChangeAttributes (HIViewRef ewg_inView, OptionBits ewg_inAttrsToSet, OptionBits ewg_inAttrsToClear)
{
	return HIViewChangeAttributes ((HIViewRef)ewg_inView, (OptionBits)ewg_inAttrsToSet, (OptionBits)ewg_inAttrsToClear);
}

// Return address of function 'HIViewChangeAttributes'
void* ewg_get_function_address_HIViewChangeAttributes (void)
{
	return (void*) HIViewChangeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewCreateOffscreenImage'
// For ise
OSStatus  ewg_function_HIViewCreateOffscreenImage (HIViewRef ewg_inView, OptionBits ewg_inOptions, HIRect *ewg_outFrame, CGImageRef *ewg_outImage)
{
	return HIViewCreateOffscreenImage ((HIViewRef)ewg_inView, (OptionBits)ewg_inOptions, (HIRect*)ewg_outFrame, (CGImageRef*)ewg_outImage);
}

// Return address of function 'HIViewCreateOffscreenImage'
void* ewg_get_function_address_HIViewCreateOffscreenImage (void)
{
	return (void*) HIViewCreateOffscreenImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewDrawCGImage'
// For ise
OSStatus  ewg_function_HIViewDrawCGImage (CGContextRef ewg_inContext, HIRect const *ewg_inBounds, CGImageRef ewg_inImage)
{
	return HIViewDrawCGImage ((CGContextRef)ewg_inContext, (HIRect const*)ewg_inBounds, (CGImageRef)ewg_inImage);
}

// Return address of function 'HIViewDrawCGImage'
void* ewg_get_function_address_HIViewDrawCGImage (void)
{
	return (void*) HIViewDrawCGImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetFeatures'
// For ise
OSStatus  ewg_function_HIViewGetFeatures (HIViewRef ewg_inView, HIViewFeatures *ewg_outFeatures)
{
	return HIViewGetFeatures ((HIViewRef)ewg_inView, (HIViewFeatures*)ewg_outFeatures);
}

// Return address of function 'HIViewGetFeatures'
void* ewg_get_function_address_HIViewGetFeatures (void)
{
	return (void*) HIViewGetFeatures;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewChangeFeatures'
// For ise
OSStatus  ewg_function_HIViewChangeFeatures (HIViewRef ewg_inView, HIViewFeatures ewg_inFeaturesToSet, HIViewFeatures ewg_inFeaturesToClear)
{
	return HIViewChangeFeatures ((HIViewRef)ewg_inView, (HIViewFeatures)ewg_inFeaturesToSet, (HIViewFeatures)ewg_inFeaturesToClear);
}

// Return address of function 'HIViewChangeFeatures'
void* ewg_get_function_address_HIViewChangeFeatures (void)
{
	return (void*) HIViewChangeFeatures;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HICreateTransformedCGImage'
// For ise
OSStatus  ewg_function_HICreateTransformedCGImage (CGImageRef ewg_inImage, OptionBits ewg_inTransform, CGImageRef *ewg_outImage)
{
	return HICreateTransformedCGImage ((CGImageRef)ewg_inImage, (OptionBits)ewg_inTransform, (CGImageRef*)ewg_outImage);
}

// Return address of function 'HICreateTransformedCGImage'
void* ewg_get_function_address_HICreateTransformedCGImage (void)
{
	return (void*) HICreateTransformedCGImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIViewGetEventTarget'
// For ise
EventTargetRef  ewg_function_HIViewGetEventTarget (HIViewRef ewg_inView)
{
	return HIViewGetEventTarget ((HIViewRef)ewg_inView);
}

// Return address of function 'HIViewGetEventTarget'
void* ewg_get_function_address_HIViewGetEventTarget (void)
{
	return (void*) HIViewGetEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIGrowBoxViewSetTransparent'
// For ise
OSStatus  ewg_function_HIGrowBoxViewSetTransparent (HIViewRef ewg_inGrowBoxView, Boolean ewg_inTransparent)
{
	return HIGrowBoxViewSetTransparent ((HIViewRef)ewg_inGrowBoxView, (Boolean)ewg_inTransparent);
}

// Return address of function 'HIGrowBoxViewSetTransparent'
void* ewg_get_function_address_HIGrowBoxViewSetTransparent (void)
{
	return (void*) HIGrowBoxViewSetTransparent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIGrowBoxViewIsTransparent'
// For ise
Boolean  ewg_function_HIGrowBoxViewIsTransparent (HIViewRef ewg_inGrowBoxView)
{
	return HIGrowBoxViewIsTransparent ((HIViewRef)ewg_inGrowBoxView);
}

// Return address of function 'HIGrowBoxViewIsTransparent'
void* ewg_get_function_address_HIGrowBoxViewIsTransparent (void)
{
	return (void*) HIGrowBoxViewIsTransparent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIScrollViewCreate'
// For ise
OSStatus  ewg_function_HIScrollViewCreate (OptionBits ewg_inOptions, HIViewRef *ewg_outView)
{
	return HIScrollViewCreate ((OptionBits)ewg_inOptions, (HIViewRef*)ewg_outView);
}

// Return address of function 'HIScrollViewCreate'
void* ewg_get_function_address_HIScrollViewCreate (void)
{
	return (void*) HIScrollViewCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIScrollViewSetScrollBarAutoHide'
// For ise
OSStatus  ewg_function_HIScrollViewSetScrollBarAutoHide (HIViewRef ewg_inView, Boolean ewg_inAutoHide)
{
	return HIScrollViewSetScrollBarAutoHide ((HIViewRef)ewg_inView, (Boolean)ewg_inAutoHide);
}

// Return address of function 'HIScrollViewSetScrollBarAutoHide'
void* ewg_get_function_address_HIScrollViewSetScrollBarAutoHide (void)
{
	return (void*) HIScrollViewSetScrollBarAutoHide;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIScrollViewGetScrollBarAutoHide'
// For ise
Boolean  ewg_function_HIScrollViewGetScrollBarAutoHide (HIViewRef ewg_inView)
{
	return HIScrollViewGetScrollBarAutoHide ((HIViewRef)ewg_inView);
}

// Return address of function 'HIScrollViewGetScrollBarAutoHide'
void* ewg_get_function_address_HIScrollViewGetScrollBarAutoHide (void)
{
	return (void*) HIScrollViewGetScrollBarAutoHide;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIScrollViewNavigate'
// For ise
OSStatus  ewg_function_HIScrollViewNavigate (HIViewRef ewg_inView, HIScrollViewAction ewg_inAction)
{
	return HIScrollViewNavigate ((HIViewRef)ewg_inView, (HIScrollViewAction)ewg_inAction);
}

// Return address of function 'HIScrollViewNavigate'
void* ewg_get_function_address_HIScrollViewNavigate (void)
{
	return (void*) HIScrollViewNavigate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIScrollViewCanNavigate'
// For ise
Boolean  ewg_function_HIScrollViewCanNavigate (HIViewRef ewg_inView, HIScrollViewAction ewg_inAction)
{
	return HIScrollViewCanNavigate ((HIViewRef)ewg_inView, (HIScrollViewAction)ewg_inAction);
}

// Return address of function 'HIScrollViewCanNavigate'
void* ewg_get_function_address_HIScrollViewCanNavigate (void)
{
	return (void*) HIScrollViewCanNavigate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewCreate'
// For ise
OSStatus  ewg_function_HIImageViewCreate (CGImageRef ewg_inImage, ControlRef *ewg_outControl)
{
	return HIImageViewCreate ((CGImageRef)ewg_inImage, (ControlRef*)ewg_outControl);
}

// Return address of function 'HIImageViewCreate'
void* ewg_get_function_address_HIImageViewCreate (void)
{
	return (void*) HIImageViewCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewSetOpaque'
// For ise
OSStatus  ewg_function_HIImageViewSetOpaque (HIViewRef ewg_inView, Boolean ewg_inOpaque)
{
	return HIImageViewSetOpaque ((HIViewRef)ewg_inView, (Boolean)ewg_inOpaque);
}

// Return address of function 'HIImageViewSetOpaque'
void* ewg_get_function_address_HIImageViewSetOpaque (void)
{
	return (void*) HIImageViewSetOpaque;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewIsOpaque'
// For ise
Boolean  ewg_function_HIImageViewIsOpaque (HIViewRef ewg_inView)
{
	return HIImageViewIsOpaque ((HIViewRef)ewg_inView);
}

// Return address of function 'HIImageViewIsOpaque'
void* ewg_get_function_address_HIImageViewIsOpaque (void)
{
	return (void*) HIImageViewIsOpaque;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewSetAlpha'
// For ise
OSStatus  ewg_function_HIImageViewSetAlpha (HIViewRef ewg_inView, float ewg_inAlpha)
{
	return HIImageViewSetAlpha ((HIViewRef)ewg_inView, (float)ewg_inAlpha);
}

// Return address of function 'HIImageViewSetAlpha'
void* ewg_get_function_address_HIImageViewSetAlpha (void)
{
	return (void*) HIImageViewSetAlpha;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewGetAlpha'
// For ise
float  ewg_function_HIImageViewGetAlpha (HIViewRef ewg_inView)
{
	return HIImageViewGetAlpha ((HIViewRef)ewg_inView);
}

// Return address of function 'HIImageViewGetAlpha'
void* ewg_get_function_address_HIImageViewGetAlpha (void)
{
	return (void*) HIImageViewGetAlpha;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewSetScaleToFit'
// For ise
OSStatus  ewg_function_HIImageViewSetScaleToFit (HIViewRef ewg_inView, Boolean ewg_inScaleToFit)
{
	return HIImageViewSetScaleToFit ((HIViewRef)ewg_inView, (Boolean)ewg_inScaleToFit);
}

// Return address of function 'HIImageViewSetScaleToFit'
void* ewg_get_function_address_HIImageViewSetScaleToFit (void)
{
	return (void*) HIImageViewSetScaleToFit;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewGetScaleToFit'
// For ise
Boolean  ewg_function_HIImageViewGetScaleToFit (HIViewRef ewg_inView)
{
	return HIImageViewGetScaleToFit ((HIViewRef)ewg_inView);
}

// Return address of function 'HIImageViewGetScaleToFit'
void* ewg_get_function_address_HIImageViewGetScaleToFit (void)
{
	return (void*) HIImageViewGetScaleToFit;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewSetImage'
// For ise
OSStatus  ewg_function_HIImageViewSetImage (HIViewRef ewg_inView, CGImageRef ewg_inImage)
{
	return HIImageViewSetImage ((HIViewRef)ewg_inView, (CGImageRef)ewg_inImage);
}

// Return address of function 'HIImageViewSetImage'
void* ewg_get_function_address_HIImageViewSetImage (void)
{
	return (void*) HIImageViewSetImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIImageViewCopyImage'
// For ise
CGImageRef  ewg_function_HIImageViewCopyImage (HIViewRef ewg_inView)
{
	return HIImageViewCopyImage ((HIViewRef)ewg_inView);
}

// Return address of function 'HIImageViewCopyImage'
void* ewg_get_function_address_HIImageViewCopyImage (void)
{
	return (void*) HIImageViewCopyImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxCreate'
// For ise
OSStatus  ewg_function_HIComboBoxCreate (HIRect const *ewg_boundsRect, CFStringRef ewg_text, ControlFontStyleRec const *ewg_style, CFArrayRef ewg_list, OptionBits ewg_inAttributes, HIViewRef *ewg_outComboBox)
{
	return HIComboBoxCreate ((HIRect const*)ewg_boundsRect, (CFStringRef)ewg_text, (ControlFontStyleRec const*)ewg_style, (CFArrayRef)ewg_list, (OptionBits)ewg_inAttributes, (HIViewRef*)ewg_outComboBox);
}

// Return address of function 'HIComboBoxCreate'
void* ewg_get_function_address_HIComboBoxCreate (void)
{
	return (void*) HIComboBoxCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxGetItemCount'
// For ise
ItemCount  ewg_function_HIComboBoxGetItemCount (HIViewRef ewg_inComboBox)
{
	return HIComboBoxGetItemCount ((HIViewRef)ewg_inComboBox);
}

// Return address of function 'HIComboBoxGetItemCount'
void* ewg_get_function_address_HIComboBoxGetItemCount (void)
{
	return (void*) HIComboBoxGetItemCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxInsertTextItemAtIndex'
// For ise
OSStatus  ewg_function_HIComboBoxInsertTextItemAtIndex (HIViewRef ewg_inComboBox, CFIndex ewg_inIndex, CFStringRef ewg_inText)
{
	return HIComboBoxInsertTextItemAtIndex ((HIViewRef)ewg_inComboBox, (CFIndex)ewg_inIndex, (CFStringRef)ewg_inText);
}

// Return address of function 'HIComboBoxInsertTextItemAtIndex'
void* ewg_get_function_address_HIComboBoxInsertTextItemAtIndex (void)
{
	return (void*) HIComboBoxInsertTextItemAtIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxAppendTextItem'
// For ise
OSStatus  ewg_function_HIComboBoxAppendTextItem (HIViewRef ewg_inComboBox, CFStringRef ewg_inText, CFIndex *ewg_outIndex)
{
	return HIComboBoxAppendTextItem ((HIViewRef)ewg_inComboBox, (CFStringRef)ewg_inText, (CFIndex*)ewg_outIndex);
}

// Return address of function 'HIComboBoxAppendTextItem'
void* ewg_get_function_address_HIComboBoxAppendTextItem (void)
{
	return (void*) HIComboBoxAppendTextItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxCopyTextItemAtIndex'
// For ise
OSStatus  ewg_function_HIComboBoxCopyTextItemAtIndex (HIViewRef ewg_inComboBox, CFIndex ewg_inIndex, CFStringRef *ewg_outString)
{
	return HIComboBoxCopyTextItemAtIndex ((HIViewRef)ewg_inComboBox, (CFIndex)ewg_inIndex, (CFStringRef*)ewg_outString);
}

// Return address of function 'HIComboBoxCopyTextItemAtIndex'
void* ewg_get_function_address_HIComboBoxCopyTextItemAtIndex (void)
{
	return (void*) HIComboBoxCopyTextItemAtIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxRemoveItemAtIndex'
// For ise
OSStatus  ewg_function_HIComboBoxRemoveItemAtIndex (HIViewRef ewg_inComboBox, CFIndex ewg_inIndex)
{
	return HIComboBoxRemoveItemAtIndex ((HIViewRef)ewg_inComboBox, (CFIndex)ewg_inIndex);
}

// Return address of function 'HIComboBoxRemoveItemAtIndex'
void* ewg_get_function_address_HIComboBoxRemoveItemAtIndex (void)
{
	return (void*) HIComboBoxRemoveItemAtIndex;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxChangeAttributes'
// For ise
OSStatus  ewg_function_HIComboBoxChangeAttributes (HIViewRef ewg_inComboBox, OptionBits ewg_inAttributesToSet, OptionBits ewg_inAttributesToClear)
{
	return HIComboBoxChangeAttributes ((HIViewRef)ewg_inComboBox, (OptionBits)ewg_inAttributesToSet, (OptionBits)ewg_inAttributesToClear);
}

// Return address of function 'HIComboBoxChangeAttributes'
void* ewg_get_function_address_HIComboBoxChangeAttributes (void)
{
	return (void*) HIComboBoxChangeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxGetAttributes'
// For ise
OSStatus  ewg_function_HIComboBoxGetAttributes (HIViewRef ewg_inComboBox, OptionBits *ewg_outAttributes)
{
	return HIComboBoxGetAttributes ((HIViewRef)ewg_inComboBox, (OptionBits*)ewg_outAttributes);
}

// Return address of function 'HIComboBoxGetAttributes'
void* ewg_get_function_address_HIComboBoxGetAttributes (void)
{
	return (void*) HIComboBoxGetAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxIsListVisible'
// For ise
Boolean  ewg_function_HIComboBoxIsListVisible (HIViewRef ewg_inComboBox)
{
	return HIComboBoxIsListVisible ((HIViewRef)ewg_inComboBox);
}

// Return address of function 'HIComboBoxIsListVisible'
void* ewg_get_function_address_HIComboBoxIsListVisible (void)
{
	return (void*) HIComboBoxIsListVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIComboBoxSetListVisible'
// For ise
OSStatus  ewg_function_HIComboBoxSetListVisible (HIViewRef ewg_inComboBox, Boolean ewg_inVisible)
{
	return HIComboBoxSetListVisible ((HIViewRef)ewg_inComboBox, (Boolean)ewg_inVisible);
}

// Return address of function 'HIComboBoxSetListVisible'
void* ewg_get_function_address_HIComboBoxSetListVisible (void)
{
	return (void*) HIComboBoxSetListVisible;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldCreate'
// For ise
OSStatus  ewg_function_HISearchFieldCreate (HIRect const *ewg_inBounds, OptionBits ewg_inAttributes, MenuRef ewg_inSearchMenu, CFStringRef ewg_inDescriptiveText, HIViewRef *ewg_outRef)
{
	return HISearchFieldCreate ((HIRect const*)ewg_inBounds, (OptionBits)ewg_inAttributes, (MenuRef)ewg_inSearchMenu, (CFStringRef)ewg_inDescriptiveText, (HIViewRef*)ewg_outRef);
}

// Return address of function 'HISearchFieldCreate'
void* ewg_get_function_address_HISearchFieldCreate (void)
{
	return (void*) HISearchFieldCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldSetSearchMenu'
// For ise
OSStatus  ewg_function_HISearchFieldSetSearchMenu (HIViewRef ewg_inSearchField, MenuRef ewg_inSearchMenu)
{
	return HISearchFieldSetSearchMenu ((HIViewRef)ewg_inSearchField, (MenuRef)ewg_inSearchMenu);
}

// Return address of function 'HISearchFieldSetSearchMenu'
void* ewg_get_function_address_HISearchFieldSetSearchMenu (void)
{
	return (void*) HISearchFieldSetSearchMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldGetSearchMenu'
// For ise
OSStatus  ewg_function_HISearchFieldGetSearchMenu (HIViewRef ewg_inSearchField, MenuRef *ewg_outSearchMenu)
{
	return HISearchFieldGetSearchMenu ((HIViewRef)ewg_inSearchField, (MenuRef*)ewg_outSearchMenu);
}

// Return address of function 'HISearchFieldGetSearchMenu'
void* ewg_get_function_address_HISearchFieldGetSearchMenu (void)
{
	return (void*) HISearchFieldGetSearchMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldChangeAttributes'
// For ise
OSStatus  ewg_function_HISearchFieldChangeAttributes (HIViewRef ewg_inSearchField, OptionBits ewg_inAttributesToSet, OptionBits ewg_inAttributesToClear)
{
	return HISearchFieldChangeAttributes ((HIViewRef)ewg_inSearchField, (OptionBits)ewg_inAttributesToSet, (OptionBits)ewg_inAttributesToClear);
}

// Return address of function 'HISearchFieldChangeAttributes'
void* ewg_get_function_address_HISearchFieldChangeAttributes (void)
{
	return (void*) HISearchFieldChangeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldGetAttributes'
// For ise
OSStatus  ewg_function_HISearchFieldGetAttributes (HIViewRef ewg_inSearchField, OptionBits *ewg_outAttributes)
{
	return HISearchFieldGetAttributes ((HIViewRef)ewg_inSearchField, (OptionBits*)ewg_outAttributes);
}

// Return address of function 'HISearchFieldGetAttributes'
void* ewg_get_function_address_HISearchFieldGetAttributes (void)
{
	return (void*) HISearchFieldGetAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldSetDescriptiveText'
// For ise
OSStatus  ewg_function_HISearchFieldSetDescriptiveText (HIViewRef ewg_inSearchField, CFStringRef ewg_inDescription)
{
	return HISearchFieldSetDescriptiveText ((HIViewRef)ewg_inSearchField, (CFStringRef)ewg_inDescription);
}

// Return address of function 'HISearchFieldSetDescriptiveText'
void* ewg_get_function_address_HISearchFieldSetDescriptiveText (void)
{
	return (void*) HISearchFieldSetDescriptiveText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISearchFieldCopyDescriptiveText'
// For ise
OSStatus  ewg_function_HISearchFieldCopyDescriptiveText (HIViewRef ewg_inSearchField, CFStringRef *ewg_outDescription)
{
	return HISearchFieldCopyDescriptiveText ((HIViewRef)ewg_inSearchField, (CFStringRef*)ewg_outDescription);
}

// Return address of function 'HISearchFieldCopyDescriptiveText'
void* ewg_get_function_address_HISearchFieldCopyDescriptiveText (void)
{
	return (void*) HISearchFieldCopyDescriptiveText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIMenuViewGetMenu'
// For ise
MenuRef  ewg_function_HIMenuViewGetMenu (HIViewRef ewg_inView)
{
	return HIMenuViewGetMenu ((HIViewRef)ewg_inView);
}

// Return address of function 'HIMenuViewGetMenu'
void* ewg_get_function_address_HIMenuViewGetMenu (void)
{
	return (void*) HIMenuViewGetMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HIMenuGetContentView'
// For ise
OSStatus  ewg_function_HIMenuGetContentView (MenuRef ewg_inMenu, ThemeMenuType ewg_inMenuType, HIViewRef *ewg_outView)
{
	return HIMenuGetContentView ((MenuRef)ewg_inMenu, (ThemeMenuType)ewg_inMenuType, (HIViewRef*)ewg_outView);
}

// Return address of function 'HIMenuGetContentView'
void* ewg_get_function_address_HIMenuGetContentView (void)
{
	return (void*) HIMenuGetContentView;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewCreate'
// For ise
OSStatus  ewg_function_HISegmentedViewCreate (HIRect const *ewg_inBounds, HIViewRef *ewg_outRef)
{
	return HISegmentedViewCreate ((HIRect const*)ewg_inBounds, (HIViewRef*)ewg_outRef);
}

// Return address of function 'HISegmentedViewCreate'
void* ewg_get_function_address_HISegmentedViewCreate (void)
{
	return (void*) HISegmentedViewCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentCount'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentCount (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentCount)
{
	return HISegmentedViewSetSegmentCount ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentCount);
}

// Return address of function 'HISegmentedViewSetSegmentCount'
void* ewg_get_function_address_HISegmentedViewSetSegmentCount (void)
{
	return (void*) HISegmentedViewSetSegmentCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentCount'
// For ise
UInt32  ewg_function_HISegmentedViewGetSegmentCount (HIViewRef ewg_inSegmentedView)
{
	return HISegmentedViewGetSegmentCount ((HIViewRef)ewg_inSegmentedView);
}

// Return address of function 'HISegmentedViewGetSegmentCount'
void* ewg_get_function_address_HISegmentedViewGetSegmentCount (void)
{
	return (void*) HISegmentedViewGetSegmentCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentBehavior'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentBehavior (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, HISegmentBehavior ewg_inBehavior)
{
	return HISegmentedViewSetSegmentBehavior ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (HISegmentBehavior)ewg_inBehavior);
}

// Return address of function 'HISegmentedViewSetSegmentBehavior'
void* ewg_get_function_address_HISegmentedViewSetSegmentBehavior (void)
{
	return (void*) HISegmentedViewSetSegmentBehavior;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentBehavior'
// For ise
HISegmentBehavior  ewg_function_HISegmentedViewGetSegmentBehavior (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewGetSegmentBehavior ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewGetSegmentBehavior'
void* ewg_get_function_address_HISegmentedViewGetSegmentBehavior (void)
{
	return (void*) HISegmentedViewGetSegmentBehavior;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewChangeSegmentAttributes'
// For ise
OSStatus  ewg_function_HISegmentedViewChangeSegmentAttributes (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, OptionBits ewg_inAttributesToSet, OptionBits ewg_inAttributesToClear)
{
	return HISegmentedViewChangeSegmentAttributes ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (OptionBits)ewg_inAttributesToSet, (OptionBits)ewg_inAttributesToClear);
}

// Return address of function 'HISegmentedViewChangeSegmentAttributes'
void* ewg_get_function_address_HISegmentedViewChangeSegmentAttributes (void)
{
	return (void*) HISegmentedViewChangeSegmentAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentAttributes'
// For ise
OptionBits  ewg_function_HISegmentedViewGetSegmentAttributes (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewGetSegmentAttributes ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewGetSegmentAttributes'
void* ewg_get_function_address_HISegmentedViewGetSegmentAttributes (void)
{
	return (void*) HISegmentedViewGetSegmentAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentValue'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentValue (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, SInt32 ewg_inValue)
{
	return HISegmentedViewSetSegmentValue ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (SInt32)ewg_inValue);
}

// Return address of function 'HISegmentedViewSetSegmentValue'
void* ewg_get_function_address_HISegmentedViewSetSegmentValue (void)
{
	return (void*) HISegmentedViewSetSegmentValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentValue'
// For ise
SInt32  ewg_function_HISegmentedViewGetSegmentValue (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewGetSegmentValue ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewGetSegmentValue'
void* ewg_get_function_address_HISegmentedViewGetSegmentValue (void)
{
	return (void*) HISegmentedViewGetSegmentValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentEnabled'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentEnabled (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, Boolean ewg_inEnabled)
{
	return HISegmentedViewSetSegmentEnabled ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (Boolean)ewg_inEnabled);
}

// Return address of function 'HISegmentedViewSetSegmentEnabled'
void* ewg_get_function_address_HISegmentedViewSetSegmentEnabled (void)
{
	return (void*) HISegmentedViewSetSegmentEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewIsSegmentEnabled'
// For ise
Boolean  ewg_function_HISegmentedViewIsSegmentEnabled (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewIsSegmentEnabled ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewIsSegmentEnabled'
void* ewg_get_function_address_HISegmentedViewIsSegmentEnabled (void)
{
	return (void*) HISegmentedViewIsSegmentEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentCommand'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentCommand (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, UInt32 ewg_inCommand)
{
	return HISegmentedViewSetSegmentCommand ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (UInt32)ewg_inCommand);
}

// Return address of function 'HISegmentedViewSetSegmentCommand'
void* ewg_get_function_address_HISegmentedViewSetSegmentCommand (void)
{
	return (void*) HISegmentedViewSetSegmentCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentCommand'
// For ise
UInt32  ewg_function_HISegmentedViewGetSegmentCommand (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewGetSegmentCommand ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewGetSegmentCommand'
void* ewg_get_function_address_HISegmentedViewGetSegmentCommand (void)
{
	return (void*) HISegmentedViewGetSegmentCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentLabel'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentLabel (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, CFStringRef ewg_inLabel)
{
	return HISegmentedViewSetSegmentLabel ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (CFStringRef)ewg_inLabel);
}

// Return address of function 'HISegmentedViewSetSegmentLabel'
void* ewg_get_function_address_HISegmentedViewSetSegmentLabel (void)
{
	return (void*) HISegmentedViewSetSegmentLabel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewCopySegmentLabel'
// For ise
OSStatus  ewg_function_HISegmentedViewCopySegmentLabel (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, CFStringRef *ewg_outLabel)
{
	return HISegmentedViewCopySegmentLabel ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (CFStringRef*)ewg_outLabel);
}

// Return address of function 'HISegmentedViewCopySegmentLabel'
void* ewg_get_function_address_HISegmentedViewCopySegmentLabel (void)
{
	return (void*) HISegmentedViewCopySegmentLabel;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentContentWidth'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentContentWidth (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, Boolean ewg_inAutoCalculateWidth, float ewg_inWidth)
{
	return HISegmentedViewSetSegmentContentWidth ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (Boolean)ewg_inAutoCalculateWidth, (float)ewg_inWidth);
}

// Return address of function 'HISegmentedViewSetSegmentContentWidth'
void* ewg_get_function_address_HISegmentedViewSetSegmentContentWidth (void)
{
	return (void*) HISegmentedViewSetSegmentContentWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentContentWidth'
// For ise
float  ewg_function_HISegmentedViewGetSegmentContentWidth (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, Boolean *ewg_outAutoCalculated)
{
	return HISegmentedViewGetSegmentContentWidth ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (Boolean*)ewg_outAutoCalculated);
}

// Return address of function 'HISegmentedViewGetSegmentContentWidth'
void* ewg_get_function_address_HISegmentedViewGetSegmentContentWidth (void)
{
	return (void*) HISegmentedViewGetSegmentContentWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewSetSegmentImage'
// For ise
OSStatus  ewg_function_HISegmentedViewSetSegmentImage (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, HIViewImageContentInfo const *ewg_inImage)
{
	return HISegmentedViewSetSegmentImage ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (HIViewImageContentInfo const*)ewg_inImage);
}

// Return address of function 'HISegmentedViewSetSegmentImage'
void* ewg_get_function_address_HISegmentedViewSetSegmentImage (void)
{
	return (void*) HISegmentedViewSetSegmentImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewGetSegmentImageContentType'
// For ise
HIViewImageContentType  ewg_function_HISegmentedViewGetSegmentImageContentType (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased)
{
	return HISegmentedViewGetSegmentImageContentType ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased);
}

// Return address of function 'HISegmentedViewGetSegmentImageContentType'
void* ewg_get_function_address_HISegmentedViewGetSegmentImageContentType (void)
{
	return (void*) HISegmentedViewGetSegmentImageContentType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HISegmentedViewCopySegmentImage'
// For ise
OSStatus  ewg_function_HISegmentedViewCopySegmentImage (HIViewRef ewg_inSegmentedView, UInt32 ewg_inSegmentIndexOneBased, HIViewImageContentInfo *ewg_ioImage)
{
	return HISegmentedViewCopySegmentImage ((HIViewRef)ewg_inSegmentedView, (UInt32)ewg_inSegmentIndexOneBased, (HIViewImageContentInfo*)ewg_ioImage);
}

// Return address of function 'HISegmentedViewCopySegmentImage'
void* ewg_get_function_address_HISegmentedViewCopySegmentImage (void)
{
	return (void*) HISegmentedViewCopySegmentImage;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewTXNFindUPP'
// For ise
TXNFindUPP  ewg_function_NewTXNFindUPP (TXNFindProcPtr ewg_userRoutine)
{
	return NewTXNFindUPP ((TXNFindProcPtr)ewg_userRoutine);
}

// Return address of function 'NewTXNFindUPP'
void* ewg_get_function_address_NewTXNFindUPP (void)
{
	return (void*) NewTXNFindUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewTXNActionNameMapperUPP'
// For ise
TXNActionNameMapperUPP  ewg_function_NewTXNActionNameMapperUPP (TXNActionNameMapperProcPtr ewg_userRoutine)
{
	return NewTXNActionNameMapperUPP ((TXNActionNameMapperProcPtr)ewg_userRoutine);
}

// Return address of function 'NewTXNActionNameMapperUPP'
void* ewg_get_function_address_NewTXNActionNameMapperUPP (void)
{
	return (void*) NewTXNActionNameMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewTXNContextualMenuSetupUPP'
// For ise
TXNContextualMenuSetupUPP  ewg_function_NewTXNContextualMenuSetupUPP (TXNContextualMenuSetupProcPtr ewg_userRoutine)
{
	return NewTXNContextualMenuSetupUPP ((TXNContextualMenuSetupProcPtr)ewg_userRoutine);
}

// Return address of function 'NewTXNContextualMenuSetupUPP'
void* ewg_get_function_address_NewTXNContextualMenuSetupUPP (void)
{
	return (void*) NewTXNContextualMenuSetupUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewTXNScrollInfoUPP'
// For ise
TXNScrollInfoUPP  ewg_function_NewTXNScrollInfoUPP (TXNScrollInfoProcPtr ewg_userRoutine)
{
	return NewTXNScrollInfoUPP ((TXNScrollInfoProcPtr)ewg_userRoutine);
}

// Return address of function 'NewTXNScrollInfoUPP'
void* ewg_get_function_address_NewTXNScrollInfoUPP (void)
{
	return (void*) NewTXNScrollInfoUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeTXNFindUPP'
// For ise
void  ewg_function_DisposeTXNFindUPP (TXNFindUPP ewg_userUPP)
{
	DisposeTXNFindUPP ((TXNFindUPP)ewg_userUPP);
}

// Return address of function 'DisposeTXNFindUPP'
void* ewg_get_function_address_DisposeTXNFindUPP (void)
{
	return (void*) DisposeTXNFindUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeTXNActionNameMapperUPP'
// For ise
void  ewg_function_DisposeTXNActionNameMapperUPP (TXNActionNameMapperUPP ewg_userUPP)
{
	DisposeTXNActionNameMapperUPP ((TXNActionNameMapperUPP)ewg_userUPP);
}

// Return address of function 'DisposeTXNActionNameMapperUPP'
void* ewg_get_function_address_DisposeTXNActionNameMapperUPP (void)
{
	return (void*) DisposeTXNActionNameMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeTXNContextualMenuSetupUPP'
// For ise
void  ewg_function_DisposeTXNContextualMenuSetupUPP (TXNContextualMenuSetupUPP ewg_userUPP)
{
	DisposeTXNContextualMenuSetupUPP ((TXNContextualMenuSetupUPP)ewg_userUPP);
}

// Return address of function 'DisposeTXNContextualMenuSetupUPP'
void* ewg_get_function_address_DisposeTXNContextualMenuSetupUPP (void)
{
	return (void*) DisposeTXNContextualMenuSetupUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeTXNScrollInfoUPP'
// For ise
void  ewg_function_DisposeTXNScrollInfoUPP (TXNScrollInfoUPP ewg_userUPP)
{
	DisposeTXNScrollInfoUPP ((TXNScrollInfoUPP)ewg_userUPP);
}

// Return address of function 'DisposeTXNScrollInfoUPP'
void* ewg_get_function_address_DisposeTXNScrollInfoUPP (void)
{
	return (void*) DisposeTXNScrollInfoUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeTXNFindUPP'
// For ise
OSStatus  ewg_function_InvokeTXNFindUPP (TXNMatchTextRecord const *ewg_matchData, TXNDataType ewg_iDataType, TXNMatchOptions ewg_iMatchOptions, void const *ewg_iSearchTextPtr, TextEncoding ewg_encoding, TXNOffset ewg_absStartOffset, ByteCount ewg_searchTextLength, TXNOffset *ewg_oStartMatch, TXNOffset *ewg_oEndMatch, Boolean *ewg_ofound, UInt32 ewg_refCon, TXNFindUPP ewg_userUPP)
{
	return InvokeTXNFindUPP ((TXNMatchTextRecord const*)ewg_matchData, (TXNDataType)ewg_iDataType, (TXNMatchOptions)ewg_iMatchOptions, (void const*)ewg_iSearchTextPtr, (TextEncoding)ewg_encoding, (TXNOffset)ewg_absStartOffset, (ByteCount)ewg_searchTextLength, (TXNOffset*)ewg_oStartMatch, (TXNOffset*)ewg_oEndMatch, (Boolean*)ewg_ofound, (UInt32)ewg_refCon, (TXNFindUPP)ewg_userUPP);
}

// Return address of function 'InvokeTXNFindUPP'
void* ewg_get_function_address_InvokeTXNFindUPP (void)
{
	return (void*) InvokeTXNFindUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeTXNActionNameMapperUPP'
// For ise
CFStringRef  ewg_function_InvokeTXNActionNameMapperUPP (CFStringRef ewg_actionName, UInt32 ewg_commandID, void *ewg_inUserData, TXNActionNameMapperUPP ewg_userUPP)
{
	return InvokeTXNActionNameMapperUPP ((CFStringRef)ewg_actionName, (UInt32)ewg_commandID, (void*)ewg_inUserData, (TXNActionNameMapperUPP)ewg_userUPP);
}

// Return address of function 'InvokeTXNActionNameMapperUPP'
void* ewg_get_function_address_InvokeTXNActionNameMapperUPP (void)
{
	return (void*) InvokeTXNActionNameMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeTXNContextualMenuSetupUPP'
// For ise
void  ewg_function_InvokeTXNContextualMenuSetupUPP (MenuRef ewg_iContextualMenu, TXNObject ewg_object, void *ewg_inUserData, TXNContextualMenuSetupUPP ewg_userUPP)
{
	InvokeTXNContextualMenuSetupUPP ((MenuRef)ewg_iContextualMenu, (TXNObject)ewg_object, (void*)ewg_inUserData, (TXNContextualMenuSetupUPP)ewg_userUPP);
}

// Return address of function 'InvokeTXNContextualMenuSetupUPP'
void* ewg_get_function_address_InvokeTXNContextualMenuSetupUPP (void)
{
	return (void*) InvokeTXNContextualMenuSetupUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeTXNScrollInfoUPP'
// For ise
void  ewg_function_InvokeTXNScrollInfoUPP (SInt32 ewg_iValue, SInt32 ewg_iMaximumValue, TXNScrollBarOrientation ewg_iScrollBarOrientation, SInt32 ewg_iRefCon, TXNScrollInfoUPP ewg_userUPP)
{
	InvokeTXNScrollInfoUPP ((SInt32)ewg_iValue, (SInt32)ewg_iMaximumValue, (TXNScrollBarOrientation)ewg_iScrollBarOrientation, (SInt32)ewg_iRefCon, (TXNScrollInfoUPP)ewg_userUPP);
}

// Return address of function 'InvokeTXNScrollInfoUPP'
void* ewg_get_function_address_InvokeTXNScrollInfoUPP (void)
{
	return (void*) InvokeTXNScrollInfoUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCreateObject'
// For ise
OSStatus  ewg_function_TXNCreateObject (HIRect const *ewg_iFrameRect, TXNFrameOptions ewg_iFrameOptions, TXNObject *ewg_oTXNObject)
{
	return TXNCreateObject ((HIRect const*)ewg_iFrameRect, (TXNFrameOptions)ewg_iFrameOptions, (TXNObject*)ewg_oTXNObject);
}

// Return address of function 'TXNCreateObject'
void* ewg_get_function_address_TXNCreateObject (void)
{
	return (void*) TXNCreateObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDeleteObject'
// For ise
void  ewg_function_TXNDeleteObject (TXNObject ewg_iTXNObject)
{
	TXNDeleteObject ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNDeleteObject'
void* ewg_get_function_address_TXNDeleteObject (void)
{
	return (void*) TXNDeleteObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNInitTextension'
// For ise
OSStatus  ewg_function_TXNInitTextension (void *ewg_iDefaultFonts, ItemCount ewg_iCountDefaultFonts, TXNInitOptions ewg_iUsageFlags)
{
	return TXNInitTextension (ewg_iDefaultFonts, (ItemCount)ewg_iCountDefaultFonts, (TXNInitOptions)ewg_iUsageFlags);
}

// Return address of function 'TXNInitTextension'
void* ewg_get_function_address_TXNInitTextension (void)
{
	return (void*) TXNInitTextension;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNVersionInformation'
// For ise
TXNVersionValue  ewg_function_TXNVersionInformation (TXNFeatureBits *ewg_oFeatureFlags)
{
	return TXNVersionInformation ((TXNFeatureBits*)ewg_oFeatureFlags);
}

// Return address of function 'TXNVersionInformation'
void* ewg_get_function_address_TXNVersionInformation (void)
{
	return (void*) TXNVersionInformation;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNAttachObjectToWindowRef'
// For ise
OSStatus  ewg_function_TXNAttachObjectToWindowRef (TXNObject ewg_iTXNObject, WindowRef ewg_iWindowRef)
{
	return TXNAttachObjectToWindowRef ((TXNObject)ewg_iTXNObject, (WindowRef)ewg_iWindowRef);
}

// Return address of function 'TXNAttachObjectToWindowRef'
void* ewg_get_function_address_TXNAttachObjectToWindowRef (void)
{
	return (void*) TXNAttachObjectToWindowRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetWindowRef'
// For ise
WindowRef  ewg_function_TXNGetWindowRef (TXNObject ewg_iTXNObject)
{
	return TXNGetWindowRef ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNGetWindowRef'
void* ewg_get_function_address_TXNGetWindowRef (void)
{
	return (void*) TXNGetWindowRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNKeyDown'
// For ise
void  ewg_function_TXNKeyDown (TXNObject ewg_iTXNObject, EventRecord const *ewg_iEvent)
{
	TXNKeyDown ((TXNObject)ewg_iTXNObject, (EventRecord const*)ewg_iEvent);
}

// Return address of function 'TXNKeyDown'
void* ewg_get_function_address_TXNKeyDown (void)
{
	return (void*) TXNKeyDown;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNAdjustCursor'
// For ise
void  ewg_function_TXNAdjustCursor (TXNObject ewg_iTXNObject, RgnHandle ewg_ioCursorRgn)
{
	TXNAdjustCursor ((TXNObject)ewg_iTXNObject, (RgnHandle)ewg_ioCursorRgn);
}

// Return address of function 'TXNAdjustCursor'
void* ewg_get_function_address_TXNAdjustCursor (void)
{
	return (void*) TXNAdjustCursor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNClick'
// For ise
void  ewg_function_TXNClick (TXNObject ewg_iTXNObject, EventRecord const *ewg_iEvent)
{
	TXNClick ((TXNObject)ewg_iTXNObject, (EventRecord const*)ewg_iEvent);
}

// Return address of function 'TXNClick'
void* ewg_get_function_address_TXNClick (void)
{
	return (void*) TXNClick;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSelectAll'
// For ise
void  ewg_function_TXNSelectAll (TXNObject ewg_iTXNObject)
{
	TXNSelectAll ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNSelectAll'
void* ewg_get_function_address_TXNSelectAll (void)
{
	return (void*) TXNSelectAll;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNFocus'
// For ise
void  ewg_function_TXNFocus (TXNObject ewg_iTXNObject, Boolean ewg_iBecomingFocused)
{
	TXNFocus ((TXNObject)ewg_iTXNObject, (Boolean)ewg_iBecomingFocused);
}

// Return address of function 'TXNFocus'
void* ewg_get_function_address_TXNFocus (void)
{
	return (void*) TXNFocus;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNUpdate'
// For ise
void  ewg_function_TXNUpdate (TXNObject ewg_iTXNObject)
{
	TXNUpdate ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNUpdate'
void* ewg_get_function_address_TXNUpdate (void)
{
	return (void*) TXNUpdate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDrawObject'
// For ise
OSStatus  ewg_function_TXNDrawObject (TXNObject ewg_iTXNObject, HIRect const *ewg_iClipRect, TXNDrawItems ewg_iDrawItems)
{
	return TXNDrawObject ((TXNObject)ewg_iTXNObject, (HIRect const*)ewg_iClipRect, (TXNDrawItems)ewg_iDrawItems);
}

// Return address of function 'TXNDrawObject'
void* ewg_get_function_address_TXNDrawObject (void)
{
	return (void*) TXNDrawObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNForceUpdate'
// For ise
void  ewg_function_TXNForceUpdate (TXNObject ewg_iTXNObject)
{
	TXNForceUpdate ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNForceUpdate'
void* ewg_get_function_address_TXNForceUpdate (void)
{
	return (void*) TXNForceUpdate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetSleepTicks'
// For ise
UInt32  ewg_function_TXNGetSleepTicks (TXNObject ewg_iTXNObject)
{
	return TXNGetSleepTicks ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNGetSleepTicks'
void* ewg_get_function_address_TXNGetSleepTicks (void)
{
	return (void*) TXNGetSleepTicks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNIdle'
// For ise
void  ewg_function_TXNIdle (TXNObject ewg_iTXNObject)
{
	TXNIdle ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNIdle'
void* ewg_get_function_address_TXNIdle (void)
{
	return (void*) TXNIdle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGrowWindow'
// For ise
void  ewg_function_TXNGrowWindow (TXNObject ewg_iTXNObject, EventRecord const *ewg_iEvent)
{
	TXNGrowWindow ((TXNObject)ewg_iTXNObject, (EventRecord const*)ewg_iEvent);
}

// Return address of function 'TXNGrowWindow'
void* ewg_get_function_address_TXNGrowWindow (void)
{
	return (void*) TXNGrowWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNZoomWindow'
// For ise
void  ewg_function_TXNZoomWindow (TXNObject ewg_iTXNObject, SInt16 ewg_iPart)
{
	TXNZoomWindow ((TXNObject)ewg_iTXNObject, (SInt16)ewg_iPart);
}

// Return address of function 'TXNZoomWindow'
void* ewg_get_function_address_TXNZoomWindow (void)
{
	return (void*) TXNZoomWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNBeginActionGroup'
// For ise
OSStatus  ewg_function_TXNBeginActionGroup (TXNObject ewg_iTXNObject, CFStringRef ewg_iActionGroupName)
{
	return TXNBeginActionGroup ((TXNObject)ewg_iTXNObject, (CFStringRef)ewg_iActionGroupName);
}

// Return address of function 'TXNBeginActionGroup'
void* ewg_get_function_address_TXNBeginActionGroup (void)
{
	return (void*) TXNBeginActionGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNEndActionGroup'
// For ise
OSStatus  ewg_function_TXNEndActionGroup (TXNObject ewg_iTXNObject)
{
	return TXNEndActionGroup ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNEndActionGroup'
void* ewg_get_function_address_TXNEndActionGroup (void)
{
	return (void*) TXNEndActionGroup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCanUndoAction'
// For ise
Boolean  ewg_function_TXNCanUndoAction (TXNObject ewg_iTXNObject, CFStringRef *ewg_oActionName)
{
	return TXNCanUndoAction ((TXNObject)ewg_iTXNObject, (CFStringRef*)ewg_oActionName);
}

// Return address of function 'TXNCanUndoAction'
void* ewg_get_function_address_TXNCanUndoAction (void)
{
	return (void*) TXNCanUndoAction;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCanRedoAction'
// For ise
Boolean  ewg_function_TXNCanRedoAction (TXNObject ewg_iTXNObject, CFStringRef *ewg_oActionName)
{
	return TXNCanRedoAction ((TXNObject)ewg_iTXNObject, (CFStringRef*)ewg_oActionName);
}

// Return address of function 'TXNCanRedoAction'
void* ewg_get_function_address_TXNCanRedoAction (void)
{
	return (void*) TXNCanRedoAction;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetActionNameMapper'
// For ise
OSStatus  ewg_function_TXNSetActionNameMapper (TXNObject ewg_iTXNObject, TXNActionNameMapperUPP ewg_iStringForKeyProc, void const *ewg_iUserData)
{
	return TXNSetActionNameMapper ((TXNObject)ewg_iTXNObject, (TXNActionNameMapperUPP)ewg_iStringForKeyProc, (void const*)ewg_iUserData);
}

// Return address of function 'TXNSetActionNameMapper'
void* ewg_get_function_address_TXNSetActionNameMapper (void)
{
	return (void*) TXNSetActionNameMapper;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNUndo'
// For ise
void  ewg_function_TXNUndo (TXNObject ewg_iTXNObject)
{
	TXNUndo ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNUndo'
void* ewg_get_function_address_TXNUndo (void)
{
	return (void*) TXNUndo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNRedo'
// For ise
void  ewg_function_TXNRedo (TXNObject ewg_iTXNObject)
{
	TXNRedo ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNRedo'
void* ewg_get_function_address_TXNRedo (void)
{
	return (void*) TXNRedo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNClearUndo'
// For ise
OSStatus  ewg_function_TXNClearUndo (TXNObject ewg_iTXNObject)
{
	return TXNClearUndo ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNClearUndo'
void* ewg_get_function_address_TXNClearUndo (void)
{
	return (void*) TXNClearUndo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCut'
// For ise
OSStatus  ewg_function_TXNCut (TXNObject ewg_iTXNObject)
{
	return TXNCut ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNCut'
void* ewg_get_function_address_TXNCut (void)
{
	return (void*) TXNCut;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCopy'
// For ise
OSStatus  ewg_function_TXNCopy (TXNObject ewg_iTXNObject)
{
	return TXNCopy ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNCopy'
void* ewg_get_function_address_TXNCopy (void)
{
	return (void*) TXNCopy;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNPaste'
// For ise
OSStatus  ewg_function_TXNPaste (TXNObject ewg_iTXNObject)
{
	return TXNPaste ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNPaste'
void* ewg_get_function_address_TXNPaste (void)
{
	return (void*) TXNPaste;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNClear'
// For ise
OSStatus  ewg_function_TXNClear (TXNObject ewg_iTXNObject)
{
	return TXNClear ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNClear'
void* ewg_get_function_address_TXNClear (void)
{
	return (void*) TXNClear;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNIsScrapPastable'
// For ise
Boolean  ewg_function_TXNIsScrapPastable (void)
{
	return TXNIsScrapPastable ();
}

// Return address of function 'TXNIsScrapPastable'
void* ewg_get_function_address_TXNIsScrapPastable (void)
{
	return (void*) TXNIsScrapPastable;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetSelection'
// For ise
void  ewg_function_TXNGetSelection (TXNObject ewg_iTXNObject, TXNOffset *ewg_oStartOffset, TXNOffset *ewg_oEndOffset)
{
	TXNGetSelection ((TXNObject)ewg_iTXNObject, (TXNOffset*)ewg_oStartOffset, (TXNOffset*)ewg_oEndOffset);
}

// Return address of function 'TXNGetSelection'
void* ewg_get_function_address_TXNGetSelection (void)
{
	return (void*) TXNGetSelection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNShowSelection'
// For ise
void  ewg_function_TXNShowSelection (TXNObject ewg_iTXNObject, Boolean ewg_iShowEnd)
{
	TXNShowSelection ((TXNObject)ewg_iTXNObject, (Boolean)ewg_iShowEnd);
}

// Return address of function 'TXNShowSelection'
void* ewg_get_function_address_TXNShowSelection (void)
{
	return (void*) TXNShowSelection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNIsSelectionEmpty'
// For ise
Boolean  ewg_function_TXNIsSelectionEmpty (TXNObject ewg_iTXNObject)
{
	return TXNIsSelectionEmpty ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNIsSelectionEmpty'
void* ewg_get_function_address_TXNIsSelectionEmpty (void)
{
	return (void*) TXNIsSelectionEmpty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetSelection'
// For ise
OSStatus  ewg_function_TXNSetSelection (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset)
{
	return TXNSetSelection ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset);
}

// Return address of function 'TXNSetSelection'
void* ewg_get_function_address_TXNSetSelection (void)
{
	return (void*) TXNSetSelection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetContinuousTypeAttributes'
// For ise
OSStatus  ewg_function_TXNGetContinuousTypeAttributes (TXNObject ewg_iTXNObject, TXNContinuousFlags *ewg_oContinuousFlags, ItemCount ewg_iCount, void *ewg_ioTypeAttributes)
{
	return TXNGetContinuousTypeAttributes ((TXNObject)ewg_iTXNObject, (TXNContinuousFlags*)ewg_oContinuousFlags, (ItemCount)ewg_iCount, ewg_ioTypeAttributes);
}

// Return address of function 'TXNGetContinuousTypeAttributes'
void* ewg_get_function_address_TXNGetContinuousTypeAttributes (void)
{
	return (void*) TXNGetContinuousTypeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetTypeAttributes'
// For ise
OSStatus  ewg_function_TXNSetTypeAttributes (TXNObject ewg_iTXNObject, ItemCount ewg_iAttrCount, void *ewg_iAttributes, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset)
{
	return TXNSetTypeAttributes ((TXNObject)ewg_iTXNObject, (ItemCount)ewg_iAttrCount, ewg_iAttributes, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset);
}

// Return address of function 'TXNSetTypeAttributes'
void* ewg_get_function_address_TXNSetTypeAttributes (void)
{
	return (void*) TXNSetTypeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetTXNObjectControls'
// For ise
OSStatus  ewg_function_TXNSetTXNObjectControls (TXNObject ewg_iTXNObject, Boolean ewg_iClearAll, ItemCount ewg_iControlCount, void *ewg_iControlTags, void *ewg_iControlData)
{
	return TXNSetTXNObjectControls ((TXNObject)ewg_iTXNObject, (Boolean)ewg_iClearAll, (ItemCount)ewg_iControlCount, ewg_iControlTags, ewg_iControlData);
}

// Return address of function 'TXNSetTXNObjectControls'
void* ewg_get_function_address_TXNSetTXNObjectControls (void)
{
	return (void*) TXNSetTXNObjectControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetTXNObjectControls'
// For ise
OSStatus  ewg_function_TXNGetTXNObjectControls (TXNObject ewg_iTXNObject, ItemCount ewg_iControlCount, void *ewg_iControlTags, void *ewg_oControlData)
{
	return TXNGetTXNObjectControls ((TXNObject)ewg_iTXNObject, (ItemCount)ewg_iControlCount, ewg_iControlTags, ewg_oControlData);
}

// Return address of function 'TXNGetTXNObjectControls'
void* ewg_get_function_address_TXNGetTXNObjectControls (void)
{
	return (void*) TXNGetTXNObjectControls;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetBackground'
// For ise
OSStatus  ewg_function_TXNSetBackground (TXNObject ewg_iTXNObject, TXNBackground const *ewg_iBackgroundInfo)
{
	return TXNSetBackground ((TXNObject)ewg_iTXNObject, (TXNBackground const*)ewg_iBackgroundInfo);
}

// Return address of function 'TXNSetBackground'
void* ewg_get_function_address_TXNSetBackground (void)
{
	return (void*) TXNSetBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNEchoMode'
// For ise
OSStatus  ewg_function_TXNEchoMode (TXNObject ewg_iTXNObject, UniChar ewg_iEchoCharacter, TextEncoding ewg_iEncoding, Boolean ewg_iOn)
{
	return TXNEchoMode ((TXNObject)ewg_iTXNObject, (UniChar)ewg_iEchoCharacter, (TextEncoding)ewg_iEncoding, (Boolean)ewg_iOn);
}

// Return address of function 'TXNEchoMode'
void* ewg_get_function_address_TXNEchoMode (void)
{
	return (void*) TXNEchoMode;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCountRunsInRange'
// For ise
OSStatus  ewg_function_TXNCountRunsInRange (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, ItemCount *ewg_oRunCount)
{
	return TXNCountRunsInRange ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (ItemCount*)ewg_oRunCount);
}

// Return address of function 'TXNCountRunsInRange'
void* ewg_get_function_address_TXNCountRunsInRange (void)
{
	return (void*) TXNCountRunsInRange;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetIndexedRunInfoFromRange'
// For ise
OSStatus  ewg_function_TXNGetIndexedRunInfoFromRange (TXNObject ewg_iTXNObject, ItemCount ewg_iIndex, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, TXNOffset *ewg_oRunStartOffset, TXNOffset *ewg_oRunEndOffset, TXNDataType *ewg_oRunDataType, ItemCount ewg_iTypeAttributeCount, TXNTypeAttributes *ewg_ioTypeAttributes)
{
	return TXNGetIndexedRunInfoFromRange ((TXNObject)ewg_iTXNObject, (ItemCount)ewg_iIndex, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (TXNOffset*)ewg_oRunStartOffset, (TXNOffset*)ewg_oRunEndOffset, (TXNDataType*)ewg_oRunDataType, (ItemCount)ewg_iTypeAttributeCount, (TXNTypeAttributes*)ewg_ioTypeAttributes);
}

// Return address of function 'TXNGetIndexedRunInfoFromRange'
void* ewg_get_function_address_TXNGetIndexedRunInfoFromRange (void)
{
	return (void*) TXNGetIndexedRunInfoFromRange;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDataSize'
// For ise
ByteCount  ewg_function_TXNDataSize (TXNObject ewg_iTXNObject)
{
	return TXNDataSize ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNDataSize'
void* ewg_get_function_address_TXNDataSize (void)
{
	return (void*) TXNDataSize;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNWriteRangeToCFURL'
// For ise
OSStatus  ewg_function_TXNWriteRangeToCFURL (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, CFDictionaryRef ewg_iDataOptions, CFDictionaryRef ewg_iDocumentAttributes, CFURLRef ewg_iFileURL)
{
	return TXNWriteRangeToCFURL ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (CFDictionaryRef)ewg_iDataOptions, (CFDictionaryRef)ewg_iDocumentAttributes, (CFURLRef)ewg_iFileURL);
}

// Return address of function 'TXNWriteRangeToCFURL'
void* ewg_get_function_address_TXNWriteRangeToCFURL (void)
{
	return (void*) TXNWriteRangeToCFURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNReadFromCFURL'
// For ise
OSStatus  ewg_function_TXNReadFromCFURL (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, CFDictionaryRef ewg_iDataOptions, CFURLRef ewg_iFileURL, CFDictionaryRef *ewg_oDocumentAttributes)
{
	return TXNReadFromCFURL ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (CFDictionaryRef)ewg_iDataOptions, (CFURLRef)ewg_iFileURL, (CFDictionaryRef*)ewg_oDocumentAttributes);
}

// Return address of function 'TXNReadFromCFURL'
void* ewg_get_function_address_TXNReadFromCFURL (void)
{
	return (void*) TXNReadFromCFURL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCopyTypeIdentifiersForRange'
// For ise
OSStatus  ewg_function_TXNCopyTypeIdentifiersForRange (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, CFArrayRef *ewg_oTypeIdentifiersForRange)
{
	return TXNCopyTypeIdentifiersForRange ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (CFArrayRef*)ewg_oTypeIdentifiersForRange);
}

// Return address of function 'TXNCopyTypeIdentifiersForRange'
void* ewg_get_function_address_TXNCopyTypeIdentifiersForRange (void)
{
	return (void*) TXNCopyTypeIdentifiersForRange;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetData'
// For ise
OSStatus  ewg_function_TXNGetData (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, Handle *ewg_oDataHandle)
{
	return TXNGetData ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (Handle*)ewg_oDataHandle);
}

// Return address of function 'TXNGetData'
void* ewg_get_function_address_TXNGetData (void)
{
	return (void*) TXNGetData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetDataEncoded'
// For ise
OSStatus  ewg_function_TXNGetDataEncoded (TXNObject ewg_iTXNObject, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset, Handle *ewg_oDataHandle, TXNDataType ewg_iEncoding)
{
	return TXNGetDataEncoded ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset, (Handle*)ewg_oDataHandle, (TXNDataType)ewg_iEncoding);
}

// Return address of function 'TXNGetDataEncoded'
void* ewg_get_function_address_TXNGetDataEncoded (void)
{
	return (void*) TXNGetDataEncoded;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetData'
// For ise
OSStatus  ewg_function_TXNSetData (TXNObject ewg_iTXNObject, TXNDataType ewg_iDataType, void const *ewg_iDataPtr, ByteCount ewg_iDataSize, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset)
{
	return TXNSetData ((TXNObject)ewg_iTXNObject, (TXNDataType)ewg_iDataType, (void const*)ewg_iDataPtr, (ByteCount)ewg_iDataSize, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset);
}

// Return address of function 'TXNSetData'
void* ewg_get_function_address_TXNSetData (void)
{
	return (void*) TXNSetData;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNFlattenObjectToCFDataRef'
// For ise
OSStatus  ewg_function_TXNFlattenObjectToCFDataRef (TXNObject ewg_iTXNObject, TXNDataType ewg_iTXNDataType, CFDataRef *ewg_oDataRef)
{
	return TXNFlattenObjectToCFDataRef ((TXNObject)ewg_iTXNObject, (TXNDataType)ewg_iTXNDataType, (CFDataRef*)ewg_oDataRef);
}

// Return address of function 'TXNFlattenObjectToCFDataRef'
void* ewg_get_function_address_TXNFlattenObjectToCFDataRef (void)
{
	return (void*) TXNFlattenObjectToCFDataRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNRevert'
// For ise
OSStatus  ewg_function_TXNRevert (TXNObject ewg_iTXNObject)
{
	return TXNRevert ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNRevert'
void* ewg_get_function_address_TXNRevert (void)
{
	return (void*) TXNRevert;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNPageSetup'
// For ise
OSStatus  ewg_function_TXNPageSetup (TXNObject ewg_iTXNObject)
{
	return TXNPageSetup ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNPageSetup'
void* ewg_get_function_address_TXNPageSetup (void)
{
	return (void*) TXNPageSetup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNPrint'
// For ise
OSStatus  ewg_function_TXNPrint (TXNObject ewg_iTXNObject)
{
	return TXNPrint ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNPrint'
void* ewg_get_function_address_TXNPrint (void)
{
	return (void*) TXNPrint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNFind'
// For ise
OSStatus  ewg_function_TXNFind (TXNObject ewg_iTXNObject, TXNMatchTextRecord const *ewg_iMatchTextDataPtr, TXNDataType ewg_iDataType, TXNMatchOptions ewg_iMatchOptions, TXNOffset ewg_iStartSearchOffset, TXNOffset ewg_iEndSearchOffset, TXNFindUPP ewg_iFindProc, SInt32 ewg_iRefCon, TXNOffset *ewg_oStartMatchOffset, TXNOffset *ewg_oEndMatchOffset)
{
	return TXNFind ((TXNObject)ewg_iTXNObject, (TXNMatchTextRecord const*)ewg_iMatchTextDataPtr, (TXNDataType)ewg_iDataType, (TXNMatchOptions)ewg_iMatchOptions, (TXNOffset)ewg_iStartSearchOffset, (TXNOffset)ewg_iEndSearchOffset, (TXNFindUPP)ewg_iFindProc, (SInt32)ewg_iRefCon, (TXNOffset*)ewg_oStartMatchOffset, (TXNOffset*)ewg_oEndMatchOffset);
}

// Return address of function 'TXNFind'
void* ewg_get_function_address_TXNFind (void)
{
	return (void*) TXNFind;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetFontDefaults'
// For ise
OSStatus  ewg_function_TXNSetFontDefaults (TXNObject ewg_iTXNObject, ItemCount ewg_iCount, void *ewg_iFontDefaults)
{
	return TXNSetFontDefaults ((TXNObject)ewg_iTXNObject, (ItemCount)ewg_iCount, ewg_iFontDefaults);
}

// Return address of function 'TXNSetFontDefaults'
void* ewg_get_function_address_TXNSetFontDefaults (void)
{
	return (void*) TXNSetFontDefaults;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetFontDefaults'
// For ise
OSStatus  ewg_function_TXNGetFontDefaults (TXNObject ewg_iTXNObject, ItemCount *ewg_ioCount, void *ewg_oFontDefaults)
{
	return TXNGetFontDefaults ((TXNObject)ewg_iTXNObject, (ItemCount*)ewg_ioCount, ewg_oFontDefaults);
}

// Return address of function 'TXNGetFontDefaults'
void* ewg_get_function_address_TXNGetFontDefaults (void)
{
	return (void*) TXNGetFontDefaults;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNNewFontMenuObject'
// For ise
OSStatus  ewg_function_TXNNewFontMenuObject (MenuRef ewg_iFontMenuHandle, SInt16 ewg_iMenuID, SInt16 ewg_iStartHierMenuID, TXNFontMenuObject *ewg_oTXNFontMenuObject)
{
	return TXNNewFontMenuObject ((MenuRef)ewg_iFontMenuHandle, (SInt16)ewg_iMenuID, (SInt16)ewg_iStartHierMenuID, (TXNFontMenuObject*)ewg_oTXNFontMenuObject);
}

// Return address of function 'TXNNewFontMenuObject'
void* ewg_get_function_address_TXNNewFontMenuObject (void)
{
	return (void*) TXNNewFontMenuObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetFontMenuHandle'
// For ise
OSStatus  ewg_function_TXNGetFontMenuHandle (TXNFontMenuObject ewg_iTXNFontMenuObject, MenuRef *ewg_oFontMenuHandle)
{
	return TXNGetFontMenuHandle ((TXNFontMenuObject)ewg_iTXNFontMenuObject, (MenuRef*)ewg_oFontMenuHandle);
}

// Return address of function 'TXNGetFontMenuHandle'
void* ewg_get_function_address_TXNGetFontMenuHandle (void)
{
	return (void*) TXNGetFontMenuHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDisposeFontMenuObject'
// For ise
OSStatus  ewg_function_TXNDisposeFontMenuObject (TXNFontMenuObject ewg_iTXNFontMenuObject)
{
	return TXNDisposeFontMenuObject ((TXNFontMenuObject)ewg_iTXNFontMenuObject);
}

// Return address of function 'TXNDisposeFontMenuObject'
void* ewg_get_function_address_TXNDisposeFontMenuObject (void)
{
	return (void*) TXNDisposeFontMenuObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDoFontMenuSelection'
// For ise
OSStatus  ewg_function_TXNDoFontMenuSelection (TXNObject ewg_iTXNObject, TXNFontMenuObject ewg_iTXNFontMenuObject, SInt16 ewg_iMenuID, SInt16 ewg_iMenuItem)
{
	return TXNDoFontMenuSelection ((TXNObject)ewg_iTXNObject, (TXNFontMenuObject)ewg_iTXNFontMenuObject, (SInt16)ewg_iMenuID, (SInt16)ewg_iMenuItem);
}

// Return address of function 'TXNDoFontMenuSelection'
void* ewg_get_function_address_TXNDoFontMenuSelection (void)
{
	return (void*) TXNDoFontMenuSelection;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNPrepareFontMenu'
// For ise
OSStatus  ewg_function_TXNPrepareFontMenu (TXNObject ewg_iTXNObject, TXNFontMenuObject ewg_iTXNFontMenuObject)
{
	return TXNPrepareFontMenu ((TXNObject)ewg_iTXNObject, (TXNFontMenuObject)ewg_iTXNFontMenuObject);
}

// Return address of function 'TXNPrepareFontMenu'
void* ewg_get_function_address_TXNPrepareFontMenu (void)
{
	return (void*) TXNPrepareFontMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDrawUnicodeTextBox'
// For ise
OSStatus  ewg_function_TXNDrawUnicodeTextBox (void *ewg_iText, UniCharCount ewg_iLen, Rect *ewg_ioBox, ATSUStyle ewg_iStyle, TXNTextBoxOptionsData const *ewg_iOptions)
{
	return TXNDrawUnicodeTextBox (ewg_iText, (UniCharCount)ewg_iLen, (Rect*)ewg_ioBox, (ATSUStyle)ewg_iStyle, (TXNTextBoxOptionsData const*)ewg_iOptions);
}

// Return address of function 'TXNDrawUnicodeTextBox'
void* ewg_get_function_address_TXNDrawUnicodeTextBox (void)
{
	return (void*) TXNDrawUnicodeTextBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDrawCFStringTextBox'
// For ise
OSStatus  ewg_function_TXNDrawCFStringTextBox (CFStringRef ewg_iText, Rect *ewg_ioBox, ATSUStyle ewg_iStyle, TXNTextBoxOptionsData const *ewg_iOptions)
{
	return TXNDrawCFStringTextBox ((CFStringRef)ewg_iText, (Rect*)ewg_ioBox, (ATSUStyle)ewg_iStyle, (TXNTextBoxOptionsData const*)ewg_iOptions);
}

// Return address of function 'TXNDrawCFStringTextBox'
void* ewg_get_function_address_TXNDrawCFStringTextBox (void)
{
	return (void*) TXNDrawCFStringTextBox;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetLineCount'
// For ise
OSStatus  ewg_function_TXNGetLineCount (TXNObject ewg_iTXNObject, ItemCount *ewg_oLineTotal)
{
	return TXNGetLineCount ((TXNObject)ewg_iTXNObject, (ItemCount*)ewg_oLineTotal);
}

// Return address of function 'TXNGetLineCount'
void* ewg_get_function_address_TXNGetLineCount (void)
{
	return (void*) TXNGetLineCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetLineMetrics'
// For ise
OSStatus  ewg_function_TXNGetLineMetrics (TXNObject ewg_iTXNObject, UInt32 ewg_iLineNumber, Fixed *ewg_oLineWidth, Fixed *ewg_oLineHeight)
{
	return TXNGetLineMetrics ((TXNObject)ewg_iTXNObject, (UInt32)ewg_iLineNumber, (Fixed*)ewg_oLineWidth, (Fixed*)ewg_oLineHeight);
}

// Return address of function 'TXNGetLineMetrics'
void* ewg_get_function_address_TXNGetLineMetrics (void)
{
	return (void*) TXNGetLineMetrics;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetChangeCount'
// For ise
ItemCount  ewg_function_TXNGetChangeCount (TXNObject ewg_iTXNObject)
{
	return TXNGetChangeCount ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNGetChangeCount'
void* ewg_get_function_address_TXNGetChangeCount (void)
{
	return (void*) TXNGetChangeCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetCountForActionType'
// For ise
OSStatus  ewg_function_TXNGetCountForActionType (TXNObject ewg_iTXNObject, CFStringRef ewg_iActionTypeName, ItemCount *ewg_oCount)
{
	return TXNGetCountForActionType ((TXNObject)ewg_iTXNObject, (CFStringRef)ewg_iActionTypeName, (ItemCount*)ewg_oCount);
}

// Return address of function 'TXNGetCountForActionType'
void* ewg_get_function_address_TXNGetCountForActionType (void)
{
	return (void*) TXNGetCountForActionType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNClearCountForActionType'
// For ise
OSStatus  ewg_function_TXNClearCountForActionType (TXNObject ewg_iTXNObject, CFStringRef ewg_iActionTypeName)
{
	return TXNClearCountForActionType ((TXNObject)ewg_iTXNObject, (CFStringRef)ewg_iActionTypeName);
}

// Return address of function 'TXNClearCountForActionType'
void* ewg_get_function_address_TXNClearCountForActionType (void)
{
	return (void*) TXNClearCountForActionType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetHIRectBounds'
// For ise
void  ewg_function_TXNSetHIRectBounds (TXNObject ewg_iTXNObject, HIRect const *ewg_iViewRect, HIRect const *ewg_iDestinationRect, Boolean ewg_iUpdate)
{
	TXNSetHIRectBounds ((TXNObject)ewg_iTXNObject, (HIRect const*)ewg_iViewRect, (HIRect const*)ewg_iDestinationRect, (Boolean)ewg_iUpdate);
}

// Return address of function 'TXNSetHIRectBounds'
void* ewg_get_function_address_TXNSetHIRectBounds (void)
{
	return (void*) TXNSetHIRectBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetHIRect'
// For ise
OSStatus  ewg_function_TXNGetHIRect (TXNObject ewg_iTXNObject, TXNRectKey ewg_iTXNRectKey, HIRect *ewg_oRectangle)
{
	return TXNGetHIRect ((TXNObject)ewg_iTXNObject, (TXNRectKey)ewg_iTXNRectKey, (HIRect*)ewg_oRectangle);
}

// Return address of function 'TXNGetHIRect'
void* ewg_get_function_address_TXNGetHIRect (void)
{
	return (void*) TXNGetHIRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNResizeFrame'
// For ise
void  ewg_function_TXNResizeFrame (TXNObject ewg_iTXNObject, UInt32 ewg_iWidth, UInt32 ewg_iHeight, TXNFrameID ewg_iTXNFrameID)
{
	TXNResizeFrame ((TXNObject)ewg_iTXNObject, (UInt32)ewg_iWidth, (UInt32)ewg_iHeight, (TXNFrameID)ewg_iTXNFrameID);
}

// Return address of function 'TXNResizeFrame'
void* ewg_get_function_address_TXNResizeFrame (void)
{
	return (void*) TXNResizeFrame;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetFrameBounds'
// For ise
void  ewg_function_TXNSetFrameBounds (TXNObject ewg_iTXNObject, SInt32 ewg_iTop, SInt32 ewg_iLeft, SInt32 ewg_iBottom, SInt32 ewg_iRight, TXNFrameID ewg_iTXNFrameID)
{
	TXNSetFrameBounds ((TXNObject)ewg_iTXNObject, (SInt32)ewg_iTop, (SInt32)ewg_iLeft, (SInt32)ewg_iBottom, (SInt32)ewg_iRight, (TXNFrameID)ewg_iTXNFrameID);
}

// Return address of function 'TXNSetFrameBounds'
void* ewg_get_function_address_TXNSetFrameBounds (void)
{
	return (void*) TXNSetFrameBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetViewRect'
// For ise
void  ewg_function_TXNGetViewRect (TXNObject ewg_iTXNObject, Rect *ewg_oViewRect)
{
	TXNGetViewRect ((TXNObject)ewg_iTXNObject, (Rect*)ewg_oViewRect);
}

// Return address of function 'TXNGetViewRect'
void* ewg_get_function_address_TXNGetViewRect (void)
{
	return (void*) TXNGetViewRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNRecalcTextLayout'
// For ise
void  ewg_function_TXNRecalcTextLayout (TXNObject ewg_iTXNObject)
{
	TXNRecalcTextLayout ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNRecalcTextLayout'
void* ewg_get_function_address_TXNRecalcTextLayout (void)
{
	return (void*) TXNRecalcTextLayout;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNScroll'
// For ise
OSStatus  ewg_function_TXNScroll (TXNObject ewg_iTXNObject, TXNScrollUnit ewg_iVerticalScrollUnit, TXNScrollUnit ewg_iHorizontalScrollUnit, SInt32 *ewg_ioVerticalDelta, SInt32 *ewg_ioHorizontalDelta)
{
	return TXNScroll ((TXNObject)ewg_iTXNObject, (TXNScrollUnit)ewg_iVerticalScrollUnit, (TXNScrollUnit)ewg_iHorizontalScrollUnit, (SInt32*)ewg_ioVerticalDelta, (SInt32*)ewg_ioHorizontalDelta);
}

// Return address of function 'TXNScroll'
void* ewg_get_function_address_TXNScroll (void)
{
	return (void*) TXNScroll;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNRegisterScrollInfoProc'
// For ise
void  ewg_function_TXNRegisterScrollInfoProc (TXNObject ewg_iTXNObject, TXNScrollInfoUPP ewg_iTXNScrollInfoUPP, SInt32 ewg_iRefCon)
{
	TXNRegisterScrollInfoProc ((TXNObject)ewg_iTXNObject, (TXNScrollInfoUPP)ewg_iTXNScrollInfoUPP, (SInt32)ewg_iRefCon);
}

// Return address of function 'TXNRegisterScrollInfoProc'
void* ewg_get_function_address_TXNRegisterScrollInfoProc (void)
{
	return (void*) TXNRegisterScrollInfoProc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetScrollbarState'
// For ise
OSStatus  ewg_function_TXNSetScrollbarState (TXNObject ewg_iTXNObject, TXNScrollBarState ewg_iActiveState)
{
	return TXNSetScrollbarState ((TXNObject)ewg_iTXNObject, (TXNScrollBarState)ewg_iActiveState);
}

// Return address of function 'TXNSetScrollbarState'
void* ewg_get_function_address_TXNSetScrollbarState (void)
{
	return (void*) TXNSetScrollbarState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNHIPointToOffset'
// For ise
OSStatus  ewg_function_TXNHIPointToOffset (TXNObject ewg_iTXNObject, HIPoint const *ewg_iHIPoint, TXNOffset *ewg_oOffset)
{
	return TXNHIPointToOffset ((TXNObject)ewg_iTXNObject, (HIPoint const*)ewg_iHIPoint, (TXNOffset*)ewg_oOffset);
}

// Return address of function 'TXNHIPointToOffset'
void* ewg_get_function_address_TXNHIPointToOffset (void)
{
	return (void*) TXNHIPointToOffset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNOffsetToHIPoint'
// For ise
OSStatus  ewg_function_TXNOffsetToHIPoint (TXNObject ewg_iTXNObject, TXNOffset ewg_iOffset, HIPoint *ewg_oHIPoint)
{
	return TXNOffsetToHIPoint ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iOffset, (HIPoint*)ewg_oHIPoint);
}

// Return address of function 'TXNOffsetToHIPoint'
void* ewg_get_function_address_TXNOffsetToHIPoint (void)
{
	return (void*) TXNOffsetToHIPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDragTracker'
// For ise
OSErr  ewg_function_TXNDragTracker (TXNObject ewg_iTXNObject, TXNFrameID ewg_iTXNFrameID, DragTrackingMessage ewg_iMessage, WindowRef ewg_iWindow, DragReference ewg_iDragReference, Boolean ewg_iDifferentObjectSameWindow)
{
	return TXNDragTracker ((TXNObject)ewg_iTXNObject, (TXNFrameID)ewg_iTXNFrameID, (DragTrackingMessage)ewg_iMessage, (WindowRef)ewg_iWindow, (DragReference)ewg_iDragReference, (Boolean)ewg_iDifferentObjectSameWindow);
}

// Return address of function 'TXNDragTracker'
void* ewg_get_function_address_TXNDragTracker (void)
{
	return (void*) TXNDragTracker;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDragReceiver'
// For ise
OSErr  ewg_function_TXNDragReceiver (TXNObject ewg_iTXNObject, TXNFrameID ewg_iTXNFrameID, WindowRef ewg_iWindow, DragReference ewg_iDragReference, Boolean ewg_iDifferentObjectSameWindow)
{
	return TXNDragReceiver ((TXNObject)ewg_iTXNObject, (TXNFrameID)ewg_iTXNFrameID, (WindowRef)ewg_iWindow, (DragReference)ewg_iDragReference, (Boolean)ewg_iDifferentObjectSameWindow);
}

// Return address of function 'TXNDragReceiver'
void* ewg_get_function_address_TXNDragReceiver (void)
{
	return (void*) TXNDragReceiver;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetCommandEventSupport'
// For ise
OSStatus  ewg_function_TXNSetCommandEventSupport (TXNObject ewg_iTXNObject, TXNCommandEventSupportOptions ewg_iOptions)
{
	return TXNSetCommandEventSupport ((TXNObject)ewg_iTXNObject, (TXNCommandEventSupportOptions)ewg_iOptions);
}

// Return address of function 'TXNSetCommandEventSupport'
void* ewg_get_function_address_TXNSetCommandEventSupport (void)
{
	return (void*) TXNSetCommandEventSupport;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetCommandEventSupport'
// For ise
OSStatus  ewg_function_TXNGetCommandEventSupport (TXNObject ewg_iTXNObject, TXNCommandEventSupportOptions *ewg_oOptions)
{
	return TXNGetCommandEventSupport ((TXNObject)ewg_iTXNObject, (TXNCommandEventSupportOptions*)ewg_oOptions);
}

// Return address of function 'TXNGetCommandEventSupport'
void* ewg_get_function_address_TXNGetCommandEventSupport (void)
{
	return (void*) TXNGetCommandEventSupport;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetSpellCheckAsYouType'
// For ise
OSStatus  ewg_function_TXNSetSpellCheckAsYouType (TXNObject ewg_iTXNObject, Boolean ewg_iActivate)
{
	return TXNSetSpellCheckAsYouType ((TXNObject)ewg_iTXNObject, (Boolean)ewg_iActivate);
}

// Return address of function 'TXNSetSpellCheckAsYouType'
void* ewg_get_function_address_TXNSetSpellCheckAsYouType (void)
{
	return (void*) TXNSetSpellCheckAsYouType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetSpellCheckAsYouType'
// For ise
Boolean  ewg_function_TXNGetSpellCheckAsYouType (TXNObject ewg_iTXNObject)
{
	return TXNGetSpellCheckAsYouType ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNGetSpellCheckAsYouType'
void* ewg_get_function_address_TXNGetSpellCheckAsYouType (void)
{
	return (void*) TXNGetSpellCheckAsYouType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetEventTarget'
// For ise
OSStatus  ewg_function_TXNSetEventTarget (TXNObject ewg_iTXNObject, HIObjectRef ewg_iEventTarget)
{
	return TXNSetEventTarget ((TXNObject)ewg_iTXNObject, (HIObjectRef)ewg_iEventTarget);
}

// Return address of function 'TXNSetEventTarget'
void* ewg_get_function_address_TXNSetEventTarget (void)
{
	return (void*) TXNSetEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetEventTarget'
// For ise
OSStatus  ewg_function_TXNGetEventTarget (TXNObject ewg_iTXNObject, HIObjectRef *ewg_oEventTarget)
{
	return TXNGetEventTarget ((TXNObject)ewg_iTXNObject, (HIObjectRef*)ewg_oEventTarget);
}

// Return address of function 'TXNGetEventTarget'
void* ewg_get_function_address_TXNGetEventTarget (void)
{
	return (void*) TXNGetEventTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetContextualMenuSetup'
// For ise
OSStatus  ewg_function_TXNSetContextualMenuSetup (TXNObject ewg_iTXNObject, TXNContextualMenuSetupUPP ewg_iMenuSetupProc, void const *ewg_iUserData)
{
	return TXNSetContextualMenuSetup ((TXNObject)ewg_iTXNObject, (TXNContextualMenuSetupUPP)ewg_iMenuSetupProc, (void const*)ewg_iUserData);
}

// Return address of function 'TXNSetContextualMenuSetup'
void* ewg_get_function_address_TXNSetContextualMenuSetup (void)
{
	return (void*) TXNSetContextualMenuSetup;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetAccessibilityHIObject'
// For ise
OSStatus  ewg_function_TXNGetAccessibilityHIObject (TXNObject ewg_iTXNObject, HIObjectRef *ewg_oHIObjectRef)
{
	return TXNGetAccessibilityHIObject ((TXNObject)ewg_iTXNObject, (HIObjectRef*)ewg_oHIObjectRef);
}

// Return address of function 'TXNGetAccessibilityHIObject'
void* ewg_get_function_address_TXNGetAccessibilityHIObject (void)
{
	return (void*) TXNGetAccessibilityHIObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HITextViewCreate'
// For ise
OSStatus  ewg_function_HITextViewCreate (HIRect const *ewg_inBoundsRect, OptionBits ewg_inOptions, TXNFrameOptions ewg_inTXNFrameOptions, HIViewRef *ewg_outTextView)
{
	return HITextViewCreate ((HIRect const*)ewg_inBoundsRect, (OptionBits)ewg_inOptions, (TXNFrameOptions)ewg_inTXNFrameOptions, (HIViewRef*)ewg_outTextView);
}

// Return address of function 'HITextViewCreate'
void* ewg_get_function_address_HITextViewCreate (void)
{
	return (void*) HITextViewCreate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HITextViewGetTXNObject'
// For ise
TXNObject  ewg_function_HITextViewGetTXNObject (HIViewRef ewg_inTextView)
{
	return HITextViewGetTXNObject ((HIViewRef)ewg_inTextView);
}

// Return address of function 'HITextViewGetTXNObject'
void* ewg_get_function_address_HITextViewGetTXNObject (void)
{
	return (void*) HITextViewGetTXNObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HITextViewSetBackgroundColor'
// For ise
OSStatus  ewg_function_HITextViewSetBackgroundColor (HIViewRef ewg_inTextView, CGColorRef ewg_inColor)
{
	return HITextViewSetBackgroundColor ((HIViewRef)ewg_inTextView, (CGColorRef)ewg_inColor);
}

// Return address of function 'HITextViewSetBackgroundColor'
void* ewg_get_function_address_HITextViewSetBackgroundColor (void)
{
	return (void*) HITextViewSetBackgroundColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HITextViewCopyBackgroundColor'
// For ise
OSStatus  ewg_function_HITextViewCopyBackgroundColor (HIViewRef ewg_inTextView, CGColorRef *ewg_outColor)
{
	return HITextViewCopyBackgroundColor ((HIViewRef)ewg_inTextView, (CGColorRef*)ewg_outColor);
}

// Return address of function 'HITextViewCopyBackgroundColor'
void* ewg_get_function_address_HITextViewCopyBackgroundColor (void)
{
	return (void*) HITextViewCopyBackgroundColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewTXNActionKeyMapperUPP'
// For ise
TXNActionKeyMapperUPP  ewg_function_NewTXNActionKeyMapperUPP (TXNActionKeyMapperProcPtr ewg_userRoutine)
{
	return NewTXNActionKeyMapperUPP ((TXNActionKeyMapperProcPtr)ewg_userRoutine);
}

// Return address of function 'NewTXNActionKeyMapperUPP'
void* ewg_get_function_address_NewTXNActionKeyMapperUPP (void)
{
	return (void*) NewTXNActionKeyMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeTXNActionKeyMapperUPP'
// For ise
void  ewg_function_DisposeTXNActionKeyMapperUPP (TXNActionKeyMapperUPP ewg_userUPP)
{
	DisposeTXNActionKeyMapperUPP ((TXNActionKeyMapperUPP)ewg_userUPP);
}

// Return address of function 'DisposeTXNActionKeyMapperUPP'
void* ewg_get_function_address_DisposeTXNActionKeyMapperUPP (void)
{
	return (void*) DisposeTXNActionKeyMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeTXNActionKeyMapperUPP'
// For ise
CFStringRef  ewg_function_InvokeTXNActionKeyMapperUPP (TXNActionKey ewg_actionKey, UInt32 ewg_commandID, TXNActionKeyMapperUPP ewg_userUPP)
{
	return InvokeTXNActionKeyMapperUPP ((TXNActionKey)ewg_actionKey, (UInt32)ewg_commandID, (TXNActionKeyMapperUPP)ewg_userUPP);
}

// Return address of function 'InvokeTXNActionKeyMapperUPP'
void* ewg_get_function_address_InvokeTXNActionKeyMapperUPP (void)
{
	return (void*) InvokeTXNActionKeyMapperUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetViewRect'
// For ise
void  ewg_function_TXNSetViewRect (TXNObject ewg_iTXNObject, Rect const *ewg_iViewRect)
{
	TXNSetViewRect ((TXNObject)ewg_iTXNObject, (Rect const*)ewg_iViewRect);
}

// Return address of function 'TXNSetViewRect'
void* ewg_get_function_address_TXNSetViewRect (void)
{
	return (void*) TXNSetViewRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNNewObject'
// For ise
OSStatus  ewg_function_TXNNewObject (FSSpec const *ewg_iFileSpec, WindowRef ewg_iWindow, Rect const *ewg_iFrame, TXNFrameOptions ewg_iFrameOptions, TXNFrameType ewg_iFrameType, TXNFileType ewg_iFileType, TXNPermanentTextEncodingType ewg_iPermanentEncoding, TXNObject *ewg_oTXNObject, TXNFrameID *ewg_oTXNFrameID, TXNObjectRefcon ewg_iRefCon)
{
	return TXNNewObject ((FSSpec const*)ewg_iFileSpec, (WindowRef)ewg_iWindow, (Rect const*)ewg_iFrame, (TXNFrameOptions)ewg_iFrameOptions, (TXNFrameType)ewg_iFrameType, (TXNFileType)ewg_iFileType, (TXNPermanentTextEncodingType)ewg_iPermanentEncoding, (TXNObject*)ewg_oTXNObject, (TXNFrameID*)ewg_oTXNFrameID, (TXNObjectRefcon)ewg_iRefCon);
}

// Return address of function 'TXNNewObject'
void* ewg_get_function_address_TXNNewObject (void)
{
	return (void*) TXNNewObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNTerminateTextension'
// For ise
void  ewg_function_TXNTerminateTextension (void)
{
	TXNTerminateTextension ();
}

// Return address of function 'TXNTerminateTextension'
void* ewg_get_function_address_TXNTerminateTextension (void)
{
	return (void*) TXNTerminateTextension;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetDataFromFile'
// For ise
OSStatus  ewg_function_TXNSetDataFromFile (TXNObject ewg_iTXNObject, SInt16 ewg_iFileRefNum, OSType ewg_iFileType, ByteCount ewg_iFileLength, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset)
{
	return TXNSetDataFromFile ((TXNObject)ewg_iTXNObject, (SInt16)ewg_iFileRefNum, (OSType)ewg_iFileType, (ByteCount)ewg_iFileLength, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset);
}

// Return address of function 'TXNSetDataFromFile'
void* ewg_get_function_address_TXNSetDataFromFile (void)
{
	return (void*) TXNSetDataFromFile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNConvertToPublicScrap'
// For ise
OSStatus  ewg_function_TXNConvertToPublicScrap (void)
{
	return TXNConvertToPublicScrap ();
}

// Return address of function 'TXNConvertToPublicScrap'
void* ewg_get_function_address_TXNConvertToPublicScrap (void)
{
	return (void*) TXNConvertToPublicScrap;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNConvertFromPublicScrap'
// For ise
OSStatus  ewg_function_TXNConvertFromPublicScrap (void)
{
	return TXNConvertFromPublicScrap ();
}

// Return address of function 'TXNConvertFromPublicScrap'
void* ewg_get_function_address_TXNConvertFromPublicScrap (void)
{
	return (void*) TXNConvertFromPublicScrap;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNDraw'
// For ise
void  ewg_function_TXNDraw (TXNObject ewg_iTXNObject, GWorldPtr ewg_iDrawPort)
{
	TXNDraw ((TXNObject)ewg_iTXNObject, (GWorldPtr)ewg_iDrawPort);
}

// Return address of function 'TXNDraw'
void* ewg_get_function_address_TXNDraw (void)
{
	return (void*) TXNDraw;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNAttachObjectToWindow'
// For ise
OSStatus  ewg_function_TXNAttachObjectToWindow (TXNObject ewg_iTXNObject, GWorldPtr ewg_iWindow, Boolean ewg_iIsActualWindow)
{
	return TXNAttachObjectToWindow ((TXNObject)ewg_iTXNObject, (GWorldPtr)ewg_iWindow, (Boolean)ewg_iIsActualWindow);
}

// Return address of function 'TXNAttachObjectToWindow'
void* ewg_get_function_address_TXNAttachObjectToWindow (void)
{
	return (void*) TXNAttachObjectToWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNIsObjectAttachedToWindow'
// For ise
Boolean  ewg_function_TXNIsObjectAttachedToWindow (TXNObject ewg_iTXNObject)
{
	return TXNIsObjectAttachedToWindow ((TXNObject)ewg_iTXNObject);
}

// Return address of function 'TXNIsObjectAttachedToWindow'
void* ewg_get_function_address_TXNIsObjectAttachedToWindow (void)
{
	return (void*) TXNIsObjectAttachedToWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNIsObjectAttachedToSpecificWindow'
// For ise
OSStatus  ewg_function_TXNIsObjectAttachedToSpecificWindow (TXNObject ewg_iTXNObject, WindowRef ewg_iWindow, Boolean *ewg_oAttached)
{
	return TXNIsObjectAttachedToSpecificWindow ((TXNObject)ewg_iTXNObject, (WindowRef)ewg_iWindow, (Boolean*)ewg_oAttached);
}

// Return address of function 'TXNIsObjectAttachedToSpecificWindow'
void* ewg_get_function_address_TXNIsObjectAttachedToSpecificWindow (void)
{
	return (void*) TXNIsObjectAttachedToSpecificWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetRectBounds'
// For ise
void  ewg_function_TXNSetRectBounds (TXNObject ewg_iTXNObject, Rect const *ewg_iViewRect, TXNLongRect const *ewg_iDestinationRect, Boolean ewg_iUpdate)
{
	TXNSetRectBounds ((TXNObject)ewg_iTXNObject, (Rect const*)ewg_iViewRect, (TXNLongRect const*)ewg_iDestinationRect, (Boolean)ewg_iUpdate);
}

// Return address of function 'TXNSetRectBounds'
void* ewg_get_function_address_TXNSetRectBounds (void)
{
	return (void*) TXNSetRectBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetRectBounds'
// For ise
OSStatus  ewg_function_TXNGetRectBounds (TXNObject ewg_iTXNObject, Rect *ewg_oViewRect, TXNLongRect *ewg_oDestinationRect, TXNLongRect *ewg_oTextRect)
{
	return TXNGetRectBounds ((TXNObject)ewg_iTXNObject, (Rect*)ewg_oViewRect, (TXNLongRect*)ewg_oDestinationRect, (TXNLongRect*)ewg_oTextRect);
}

// Return address of function 'TXNGetRectBounds'
void* ewg_get_function_address_TXNGetRectBounds (void)
{
	return (void*) TXNGetRectBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNActivate'
// For ise
OSStatus  ewg_function_TXNActivate (TXNObject ewg_iTXNObject, TXNFrameID ewg_iTXNFrameID, TXNScrollBarState ewg_iActiveState)
{
	return TXNActivate ((TXNObject)ewg_iTXNObject, (TXNFrameID)ewg_iTXNFrameID, (TXNScrollBarState)ewg_iActiveState);
}

// Return address of function 'TXNActivate'
void* ewg_get_function_address_TXNActivate (void)
{
	return (void*) TXNActivate;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNPointToOffset'
// For ise
OSStatus  ewg_function_TXNPointToOffset (TXNObject ewg_iTXNObject, Point *ewg_iPoint, TXNOffset *ewg_oOffset)
{
	return TXNPointToOffset ((TXNObject)ewg_iTXNObject, *(Point*)ewg_iPoint, (TXNOffset*)ewg_oOffset);
}

// Return address of function 'TXNPointToOffset'
void* ewg_get_function_address_TXNPointToOffset (void)
{
	return (void*) TXNPointToOffset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNOffsetToPoint'
// For ise
OSStatus  ewg_function_TXNOffsetToPoint (TXNObject ewg_iTXNObject, TXNOffset ewg_iOffset, Point *ewg_oPoint)
{
	return TXNOffsetToPoint ((TXNObject)ewg_iTXNObject, (TXNOffset)ewg_iOffset, (Point*)ewg_oPoint);
}

// Return address of function 'TXNOffsetToPoint'
void* ewg_get_function_address_TXNOffsetToPoint (void)
{
	return (void*) TXNOffsetToPoint;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCanUndo'
// For ise
Boolean  ewg_function_TXNCanUndo (TXNObject ewg_iTXNObject, TXNActionKey *ewg_oTXNActionKey)
{
	return TXNCanUndo ((TXNObject)ewg_iTXNObject, (TXNActionKey*)ewg_oTXNActionKey);
}

// Return address of function 'TXNCanUndo'
void* ewg_get_function_address_TXNCanUndo (void)
{
	return (void*) TXNCanUndo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNCanRedo'
// For ise
Boolean  ewg_function_TXNCanRedo (TXNObject ewg_iTXNObject, TXNActionKey *ewg_oTXNActionKey)
{
	return TXNCanRedo ((TXNObject)ewg_iTXNObject, (TXNActionKey*)ewg_oTXNActionKey);
}

// Return address of function 'TXNCanRedo'
void* ewg_get_function_address_TXNCanRedo (void)
{
	return (void*) TXNCanRedo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNGetActionChangeCount'
// For ise
OSStatus  ewg_function_TXNGetActionChangeCount (TXNObject ewg_iTXNObject, TXNCountOptions ewg_iOptions, ItemCount *ewg_oCount)
{
	return TXNGetActionChangeCount ((TXNObject)ewg_iTXNObject, (TXNCountOptions)ewg_iOptions, (ItemCount*)ewg_oCount);
}

// Return address of function 'TXNGetActionChangeCount'
void* ewg_get_function_address_TXNGetActionChangeCount (void)
{
	return (void*) TXNGetActionChangeCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNClearActionChangeCount'
// For ise
OSStatus  ewg_function_TXNClearActionChangeCount (TXNObject ewg_iTXNObject, TXNCountOptions ewg_iOptions)
{
	return TXNClearActionChangeCount ((TXNObject)ewg_iTXNObject, (TXNCountOptions)ewg_iOptions);
}

// Return address of function 'TXNClearActionChangeCount'
void* ewg_get_function_address_TXNClearActionChangeCount (void)
{
	return (void*) TXNClearActionChangeCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSetDataFromCFURLRef'
// For ise
OSStatus  ewg_function_TXNSetDataFromCFURLRef (TXNObject ewg_iTXNObject, CFURLRef ewg_iURL, TXNOffset ewg_iStartOffset, TXNOffset ewg_iEndOffset)
{
	return TXNSetDataFromCFURLRef ((TXNObject)ewg_iTXNObject, (CFURLRef)ewg_iURL, (TXNOffset)ewg_iStartOffset, (TXNOffset)ewg_iEndOffset);
}

// Return address of function 'TXNSetDataFromCFURLRef'
void* ewg_get_function_address_TXNSetDataFromCFURLRef (void)
{
	return (void*) TXNSetDataFromCFURLRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'TXNSave'
// For ise
OSStatus  ewg_function_TXNSave (TXNObject ewg_iTXNObject, TXNFileType ewg_iType, OSType ewg_iResType, TXNPermanentTextEncodingType ewg_iPermanentEncoding, FSSpec const *ewg_iFileSpecification, SInt16 ewg_iDataReference, SInt16 ewg_iResourceReference)
{
	return TXNSave ((TXNObject)ewg_iTXNObject, (TXNFileType)ewg_iType, (OSType)ewg_iResType, (TXNPermanentTextEncodingType)ewg_iPermanentEncoding, (FSSpec const*)ewg_iFileSpecification, (SInt16)ewg_iDataReference, (SInt16)ewg_iResourceReference);
}

// Return address of function 'TXNSave'
void* ewg_get_function_address_TXNSave (void)
{
	return (void*) TXNSave;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewHMControlContentUPP'
// For ise
HMControlContentUPP  ewg_function_NewHMControlContentUPP (HMControlContentProcPtr ewg_userRoutine)
{
	return NewHMControlContentUPP ((HMControlContentProcPtr)ewg_userRoutine);
}

// Return address of function 'NewHMControlContentUPP'
void* ewg_get_function_address_NewHMControlContentUPP (void)
{
	return (void*) NewHMControlContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewHMWindowContentUPP'
// For ise
HMWindowContentUPP  ewg_function_NewHMWindowContentUPP (HMWindowContentProcPtr ewg_userRoutine)
{
	return NewHMWindowContentUPP ((HMWindowContentProcPtr)ewg_userRoutine);
}

// Return address of function 'NewHMWindowContentUPP'
void* ewg_get_function_address_NewHMWindowContentUPP (void)
{
	return (void*) NewHMWindowContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewHMMenuTitleContentUPP'
// For ise
HMMenuTitleContentUPP  ewg_function_NewHMMenuTitleContentUPP (HMMenuTitleContentProcPtr ewg_userRoutine)
{
	return NewHMMenuTitleContentUPP ((HMMenuTitleContentProcPtr)ewg_userRoutine);
}

// Return address of function 'NewHMMenuTitleContentUPP'
void* ewg_get_function_address_NewHMMenuTitleContentUPP (void)
{
	return (void*) NewHMMenuTitleContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewHMMenuItemContentUPP'
// For ise
HMMenuItemContentUPP  ewg_function_NewHMMenuItemContentUPP (HMMenuItemContentProcPtr ewg_userRoutine)
{
	return NewHMMenuItemContentUPP ((HMMenuItemContentProcPtr)ewg_userRoutine);
}

// Return address of function 'NewHMMenuItemContentUPP'
void* ewg_get_function_address_NewHMMenuItemContentUPP (void)
{
	return (void*) NewHMMenuItemContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeHMControlContentUPP'
// For ise
void  ewg_function_DisposeHMControlContentUPP (HMControlContentUPP ewg_userUPP)
{
	DisposeHMControlContentUPP ((HMControlContentUPP)ewg_userUPP);
}

// Return address of function 'DisposeHMControlContentUPP'
void* ewg_get_function_address_DisposeHMControlContentUPP (void)
{
	return (void*) DisposeHMControlContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeHMWindowContentUPP'
// For ise
void  ewg_function_DisposeHMWindowContentUPP (HMWindowContentUPP ewg_userUPP)
{
	DisposeHMWindowContentUPP ((HMWindowContentUPP)ewg_userUPP);
}

// Return address of function 'DisposeHMWindowContentUPP'
void* ewg_get_function_address_DisposeHMWindowContentUPP (void)
{
	return (void*) DisposeHMWindowContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeHMMenuTitleContentUPP'
// For ise
void  ewg_function_DisposeHMMenuTitleContentUPP (HMMenuTitleContentUPP ewg_userUPP)
{
	DisposeHMMenuTitleContentUPP ((HMMenuTitleContentUPP)ewg_userUPP);
}

// Return address of function 'DisposeHMMenuTitleContentUPP'
void* ewg_get_function_address_DisposeHMMenuTitleContentUPP (void)
{
	return (void*) DisposeHMMenuTitleContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeHMMenuItemContentUPP'
// For ise
void  ewg_function_DisposeHMMenuItemContentUPP (HMMenuItemContentUPP ewg_userUPP)
{
	DisposeHMMenuItemContentUPP ((HMMenuItemContentUPP)ewg_userUPP);
}

// Return address of function 'DisposeHMMenuItemContentUPP'
void* ewg_get_function_address_DisposeHMMenuItemContentUPP (void)
{
	return (void*) DisposeHMMenuItemContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeHMControlContentUPP'
// For ise
OSStatus  ewg_function_InvokeHMControlContentUPP (ControlRef ewg_inControl, Point *ewg_inGlobalMouse, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent, HMControlContentUPP ewg_userUPP)
{
	return InvokeHMControlContentUPP ((ControlRef)ewg_inControl, *(Point*)ewg_inGlobalMouse, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent, (HMControlContentUPP)ewg_userUPP);
}

// Return address of function 'InvokeHMControlContentUPP'
void* ewg_get_function_address_InvokeHMControlContentUPP (void)
{
	return (void*) InvokeHMControlContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeHMWindowContentUPP'
// For ise
OSStatus  ewg_function_InvokeHMWindowContentUPP (WindowRef ewg_inWindow, Point *ewg_inGlobalMouse, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent, HMWindowContentUPP ewg_userUPP)
{
	return InvokeHMWindowContentUPP ((WindowRef)ewg_inWindow, *(Point*)ewg_inGlobalMouse, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent, (HMWindowContentUPP)ewg_userUPP);
}

// Return address of function 'InvokeHMWindowContentUPP'
void* ewg_get_function_address_InvokeHMWindowContentUPP (void)
{
	return (void*) InvokeHMWindowContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeHMMenuTitleContentUPP'
// For ise
OSStatus  ewg_function_InvokeHMMenuTitleContentUPP (MenuRef ewg_inMenu, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent, HMMenuTitleContentUPP ewg_userUPP)
{
	return InvokeHMMenuTitleContentUPP ((MenuRef)ewg_inMenu, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent, (HMMenuTitleContentUPP)ewg_userUPP);
}

// Return address of function 'InvokeHMMenuTitleContentUPP'
void* ewg_get_function_address_InvokeHMMenuTitleContentUPP (void)
{
	return (void*) InvokeHMMenuTitleContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeHMMenuItemContentUPP'
// For ise
OSStatus  ewg_function_InvokeHMMenuItemContentUPP (MenuTrackingData const *ewg_inTrackingData, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent, HMMenuItemContentUPP ewg_userUPP)
{
	return InvokeHMMenuItemContentUPP ((MenuTrackingData const*)ewg_inTrackingData, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent, (HMMenuItemContentUPP)ewg_userUPP);
}

// Return address of function 'InvokeHMMenuItemContentUPP'
void* ewg_get_function_address_InvokeHMMenuItemContentUPP (void)
{
	return (void*) InvokeHMMenuItemContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetHelpMenu'
// For ise
OSStatus  ewg_function_HMGetHelpMenu (MenuRef *ewg_outHelpMenu, MenuItemIndex *ewg_outFirstCustomItemIndex)
{
	return HMGetHelpMenu ((MenuRef*)ewg_outHelpMenu, (MenuItemIndex*)ewg_outFirstCustomItemIndex);
}

// Return address of function 'HMGetHelpMenu'
void* ewg_get_function_address_HMGetHelpMenu (void)
{
	return (void*) HMGetHelpMenu;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetControlHelpContent'
// For ise
OSStatus  ewg_function_HMSetControlHelpContent (ControlRef ewg_inControl, HMHelpContentRec const *ewg_inContent)
{
	return HMSetControlHelpContent ((ControlRef)ewg_inControl, (HMHelpContentRec const*)ewg_inContent);
}

// Return address of function 'HMSetControlHelpContent'
void* ewg_get_function_address_HMSetControlHelpContent (void)
{
	return (void*) HMSetControlHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetControlHelpContent'
// For ise
OSStatus  ewg_function_HMGetControlHelpContent (ControlRef ewg_inControl, HMHelpContentRec *ewg_outContent)
{
	return HMGetControlHelpContent ((ControlRef)ewg_inControl, (HMHelpContentRec*)ewg_outContent);
}

// Return address of function 'HMGetControlHelpContent'
void* ewg_get_function_address_HMGetControlHelpContent (void)
{
	return (void*) HMGetControlHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetWindowHelpContent'
// For ise
OSStatus  ewg_function_HMSetWindowHelpContent (WindowRef ewg_inWindow, HMHelpContentRec const *ewg_inContent)
{
	return HMSetWindowHelpContent ((WindowRef)ewg_inWindow, (HMHelpContentRec const*)ewg_inContent);
}

// Return address of function 'HMSetWindowHelpContent'
void* ewg_get_function_address_HMSetWindowHelpContent (void)
{
	return (void*) HMSetWindowHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetWindowHelpContent'
// For ise
OSStatus  ewg_function_HMGetWindowHelpContent (WindowRef ewg_inWindow, HMHelpContentRec *ewg_outContent)
{
	return HMGetWindowHelpContent ((WindowRef)ewg_inWindow, (HMHelpContentRec*)ewg_outContent);
}

// Return address of function 'HMGetWindowHelpContent'
void* ewg_get_function_address_HMGetWindowHelpContent (void)
{
	return (void*) HMGetWindowHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetMenuItemHelpContent'
// For ise
OSStatus  ewg_function_HMSetMenuItemHelpContent (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, HMHelpContentRec const *ewg_inContent)
{
	return HMSetMenuItemHelpContent ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (HMHelpContentRec const*)ewg_inContent);
}

// Return address of function 'HMSetMenuItemHelpContent'
void* ewg_get_function_address_HMSetMenuItemHelpContent (void)
{
	return (void*) HMSetMenuItemHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetMenuItemHelpContent'
// For ise
OSStatus  ewg_function_HMGetMenuItemHelpContent (MenuRef ewg_inMenu, MenuItemIndex ewg_inItem, HMHelpContentRec *ewg_outContent)
{
	return HMGetMenuItemHelpContent ((MenuRef)ewg_inMenu, (MenuItemIndex)ewg_inItem, (HMHelpContentRec*)ewg_outContent);
}

// Return address of function 'HMGetMenuItemHelpContent'
void* ewg_get_function_address_HMGetMenuItemHelpContent (void)
{
	return (void*) HMGetMenuItemHelpContent;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMInstallControlContentCallback'
// For ise
OSStatus  ewg_function_HMInstallControlContentCallback (ControlRef ewg_inControl, HMControlContentUPP ewg_inContentUPP)
{
	return HMInstallControlContentCallback ((ControlRef)ewg_inControl, (HMControlContentUPP)ewg_inContentUPP);
}

// Return address of function 'HMInstallControlContentCallback'
void* ewg_get_function_address_HMInstallControlContentCallback (void)
{
	return (void*) HMInstallControlContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMInstallWindowContentCallback'
// For ise
OSStatus  ewg_function_HMInstallWindowContentCallback (WindowRef ewg_inWindow, HMWindowContentUPP ewg_inContentUPP)
{
	return HMInstallWindowContentCallback ((WindowRef)ewg_inWindow, (HMWindowContentUPP)ewg_inContentUPP);
}

// Return address of function 'HMInstallWindowContentCallback'
void* ewg_get_function_address_HMInstallWindowContentCallback (void)
{
	return (void*) HMInstallWindowContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMInstallMenuTitleContentCallback'
// For ise
OSStatus  ewg_function_HMInstallMenuTitleContentCallback (MenuRef ewg_inMenu, HMMenuTitleContentUPP ewg_inContentUPP)
{
	return HMInstallMenuTitleContentCallback ((MenuRef)ewg_inMenu, (HMMenuTitleContentUPP)ewg_inContentUPP);
}

// Return address of function 'HMInstallMenuTitleContentCallback'
void* ewg_get_function_address_HMInstallMenuTitleContentCallback (void)
{
	return (void*) HMInstallMenuTitleContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMInstallMenuItemContentCallback'
// For ise
OSStatus  ewg_function_HMInstallMenuItemContentCallback (MenuRef ewg_inMenu, HMMenuItemContentUPP ewg_inContentUPP)
{
	return HMInstallMenuItemContentCallback ((MenuRef)ewg_inMenu, (HMMenuItemContentUPP)ewg_inContentUPP);
}

// Return address of function 'HMInstallMenuItemContentCallback'
void* ewg_get_function_address_HMInstallMenuItemContentCallback (void)
{
	return (void*) HMInstallMenuItemContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetControlContentCallback'
// For ise
OSStatus  ewg_function_HMGetControlContentCallback (ControlRef ewg_inControl, HMControlContentUPP *ewg_outContentUPP)
{
	return HMGetControlContentCallback ((ControlRef)ewg_inControl, (HMControlContentUPP*)ewg_outContentUPP);
}

// Return address of function 'HMGetControlContentCallback'
void* ewg_get_function_address_HMGetControlContentCallback (void)
{
	return (void*) HMGetControlContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetWindowContentCallback'
// For ise
OSStatus  ewg_function_HMGetWindowContentCallback (WindowRef ewg_inWindow, HMWindowContentUPP *ewg_outContentUPP)
{
	return HMGetWindowContentCallback ((WindowRef)ewg_inWindow, (HMWindowContentUPP*)ewg_outContentUPP);
}

// Return address of function 'HMGetWindowContentCallback'
void* ewg_get_function_address_HMGetWindowContentCallback (void)
{
	return (void*) HMGetWindowContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetMenuTitleContentCallback'
// For ise
OSStatus  ewg_function_HMGetMenuTitleContentCallback (MenuRef ewg_inMenu, HMMenuTitleContentUPP *ewg_outContentUPP)
{
	return HMGetMenuTitleContentCallback ((MenuRef)ewg_inMenu, (HMMenuTitleContentUPP*)ewg_outContentUPP);
}

// Return address of function 'HMGetMenuTitleContentCallback'
void* ewg_get_function_address_HMGetMenuTitleContentCallback (void)
{
	return (void*) HMGetMenuTitleContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetMenuItemContentCallback'
// For ise
OSStatus  ewg_function_HMGetMenuItemContentCallback (MenuRef ewg_inMenu, HMMenuItemContentUPP *ewg_outContentUPP)
{
	return HMGetMenuItemContentCallback ((MenuRef)ewg_inMenu, (HMMenuItemContentUPP*)ewg_outContentUPP);
}

// Return address of function 'HMGetMenuItemContentCallback'
void* ewg_get_function_address_HMGetMenuItemContentCallback (void)
{
	return (void*) HMGetMenuItemContentCallback;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMAreHelpTagsDisplayed'
// For ise
Boolean  ewg_function_HMAreHelpTagsDisplayed (void)
{
	return HMAreHelpTagsDisplayed ();
}

// Return address of function 'HMAreHelpTagsDisplayed'
void* ewg_get_function_address_HMAreHelpTagsDisplayed (void)
{
	return (void*) HMAreHelpTagsDisplayed;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetHelpTagsDisplayed'
// For ise
OSStatus  ewg_function_HMSetHelpTagsDisplayed (Boolean ewg_inDisplayTags)
{
	return HMSetHelpTagsDisplayed ((Boolean)ewg_inDisplayTags);
}

// Return address of function 'HMSetHelpTagsDisplayed'
void* ewg_get_function_address_HMSetHelpTagsDisplayed (void)
{
	return (void*) HMSetHelpTagsDisplayed;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetTagDelay'
// For ise
OSStatus  ewg_function_HMSetTagDelay (Duration ewg_inDelay)
{
	return HMSetTagDelay ((Duration)ewg_inDelay);
}

// Return address of function 'HMSetTagDelay'
void* ewg_get_function_address_HMSetTagDelay (void)
{
	return (void*) HMSetTagDelay;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMGetTagDelay'
// For ise
OSStatus  ewg_function_HMGetTagDelay (Duration *ewg_outDelay)
{
	return HMGetTagDelay ((Duration*)ewg_outDelay);
}

// Return address of function 'HMGetTagDelay'
void* ewg_get_function_address_HMGetTagDelay (void)
{
	return (void*) HMGetTagDelay;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetMenuHelpFromBalloonRsrc'
// For ise
OSStatus  ewg_function_HMSetMenuHelpFromBalloonRsrc (MenuRef ewg_inMenu, SInt16 ewg_inHmnuRsrcID)
{
	return HMSetMenuHelpFromBalloonRsrc ((MenuRef)ewg_inMenu, (SInt16)ewg_inHmnuRsrcID);
}

// Return address of function 'HMSetMenuHelpFromBalloonRsrc'
void* ewg_get_function_address_HMSetMenuHelpFromBalloonRsrc (void)
{
	return (void*) HMSetMenuHelpFromBalloonRsrc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMSetDialogHelpFromBalloonRsrc'
// For ise
OSStatus  ewg_function_HMSetDialogHelpFromBalloonRsrc (DialogRef ewg_inDialog, SInt16 ewg_inHdlgRsrcID, SInt16 ewg_inItemStart)
{
	return HMSetDialogHelpFromBalloonRsrc ((DialogRef)ewg_inDialog, (SInt16)ewg_inHdlgRsrcID, (SInt16)ewg_inItemStart);
}

// Return address of function 'HMSetDialogHelpFromBalloonRsrc'
void* ewg_get_function_address_HMSetDialogHelpFromBalloonRsrc (void)
{
	return (void*) HMSetDialogHelpFromBalloonRsrc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMDisplayTag'
// For ise
OSStatus  ewg_function_HMDisplayTag (HMHelpContentRec const *ewg_inContent)
{
	return HMDisplayTag ((HMHelpContentRec const*)ewg_inContent);
}

// Return address of function 'HMDisplayTag'
void* ewg_get_function_address_HMDisplayTag (void)
{
	return (void*) HMDisplayTag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMHideTag'
// For ise
OSStatus  ewg_function_HMHideTag (void)
{
	return HMHideTag ();
}

// Return address of function 'HMHideTag'
void* ewg_get_function_address_HMHideTag (void)
{
	return (void*) HMHideTag;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HMHideTagWithOptions'
// For ise
OSStatus  ewg_function_HMHideTagWithOptions (OptionBits ewg_inOptions)
{
	return HMHideTagWithOptions ((OptionBits)ewg_inOptions);
}

// Return address of function 'HMHideTagWithOptions'
void* ewg_get_function_address_HMHideTagWithOptions (void)
{
	return (void*) HMHideTagWithOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateBevelButtonControl'
// For ise
OSStatus  ewg_function_CreateBevelButtonControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, ControlBevelThickness ewg_thickness, ControlBevelButtonBehavior ewg_behavior, ControlButtonContentInfoPtr ewg_info, SInt16 ewg_menuID, ControlBevelButtonMenuBehavior ewg_menuBehavior, ControlBevelButtonMenuPlacement ewg_menuPlacement, ControlRef *ewg_outControl)
{
	return CreateBevelButtonControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (ControlBevelThickness)ewg_thickness, (ControlBevelButtonBehavior)ewg_behavior, (ControlButtonContentInfoPtr)ewg_info, (SInt16)ewg_menuID, (ControlBevelButtonMenuBehavior)ewg_menuBehavior, (ControlBevelButtonMenuPlacement)ewg_menuPlacement, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateBevelButtonControl'
void* ewg_get_function_address_CreateBevelButtonControl (void)
{
	return (void*) CreateBevelButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetBevelButtonMenuValue'
// For ise
OSErr  ewg_function_GetBevelButtonMenuValue (ControlRef ewg_inButton, SInt16 *ewg_outValue)
{
	return GetBevelButtonMenuValue ((ControlRef)ewg_inButton, (SInt16*)ewg_outValue);
}

// Return address of function 'GetBevelButtonMenuValue'
void* ewg_get_function_address_GetBevelButtonMenuValue (void)
{
	return (void*) GetBevelButtonMenuValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonMenuValue'
// For ise
OSErr  ewg_function_SetBevelButtonMenuValue (ControlRef ewg_inButton, SInt16 ewg_inValue)
{
	return SetBevelButtonMenuValue ((ControlRef)ewg_inButton, (SInt16)ewg_inValue);
}

// Return address of function 'SetBevelButtonMenuValue'
void* ewg_get_function_address_SetBevelButtonMenuValue (void)
{
	return (void*) SetBevelButtonMenuValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetBevelButtonMenuHandle'
// For ise
OSErr  ewg_function_GetBevelButtonMenuHandle (ControlRef ewg_inButton, MenuHandle *ewg_outHandle)
{
	return GetBevelButtonMenuHandle ((ControlRef)ewg_inButton, (MenuHandle*)ewg_outHandle);
}

// Return address of function 'GetBevelButtonMenuHandle'
void* ewg_get_function_address_GetBevelButtonMenuHandle (void)
{
	return (void*) GetBevelButtonMenuHandle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetBevelButtonContentInfo'
// For ise
OSErr  ewg_function_GetBevelButtonContentInfo (ControlRef ewg_inButton, ControlButtonContentInfoPtr ewg_outContent)
{
	return GetBevelButtonContentInfo ((ControlRef)ewg_inButton, (ControlButtonContentInfoPtr)ewg_outContent);
}

// Return address of function 'GetBevelButtonContentInfo'
void* ewg_get_function_address_GetBevelButtonContentInfo (void)
{
	return (void*) GetBevelButtonContentInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonContentInfo'
// For ise
OSErr  ewg_function_SetBevelButtonContentInfo (ControlRef ewg_inButton, ControlButtonContentInfoPtr ewg_inContent)
{
	return SetBevelButtonContentInfo ((ControlRef)ewg_inButton, (ControlButtonContentInfoPtr)ewg_inContent);
}

// Return address of function 'SetBevelButtonContentInfo'
void* ewg_get_function_address_SetBevelButtonContentInfo (void)
{
	return (void*) SetBevelButtonContentInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonTransform'
// For ise
OSErr  ewg_function_SetBevelButtonTransform (ControlRef ewg_inButton, IconTransformType ewg_transform)
{
	return SetBevelButtonTransform ((ControlRef)ewg_inButton, (IconTransformType)ewg_transform);
}

// Return address of function 'SetBevelButtonTransform'
void* ewg_get_function_address_SetBevelButtonTransform (void)
{
	return (void*) SetBevelButtonTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonGraphicAlignment'
// For ise
OSErr  ewg_function_SetBevelButtonGraphicAlignment (ControlRef ewg_inButton, ControlButtonGraphicAlignment ewg_inAlign, SInt16 ewg_inHOffset, SInt16 ewg_inVOffset)
{
	return SetBevelButtonGraphicAlignment ((ControlRef)ewg_inButton, (ControlButtonGraphicAlignment)ewg_inAlign, (SInt16)ewg_inHOffset, (SInt16)ewg_inVOffset);
}

// Return address of function 'SetBevelButtonGraphicAlignment'
void* ewg_get_function_address_SetBevelButtonGraphicAlignment (void)
{
	return (void*) SetBevelButtonGraphicAlignment;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonTextAlignment'
// For ise
OSErr  ewg_function_SetBevelButtonTextAlignment (ControlRef ewg_inButton, ControlButtonTextAlignment ewg_inAlign, SInt16 ewg_inHOffset)
{
	return SetBevelButtonTextAlignment ((ControlRef)ewg_inButton, (ControlButtonTextAlignment)ewg_inAlign, (SInt16)ewg_inHOffset);
}

// Return address of function 'SetBevelButtonTextAlignment'
void* ewg_get_function_address_SetBevelButtonTextAlignment (void)
{
	return (void*) SetBevelButtonTextAlignment;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetBevelButtonTextPlacement'
// For ise
OSErr  ewg_function_SetBevelButtonTextPlacement (ControlRef ewg_inButton, ControlButtonTextPlacement ewg_inWhere)
{
	return SetBevelButtonTextPlacement ((ControlRef)ewg_inButton, (ControlButtonTextPlacement)ewg_inWhere);
}

// Return address of function 'SetBevelButtonTextPlacement'
void* ewg_get_function_address_SetBevelButtonTextPlacement (void)
{
	return (void*) SetBevelButtonTextPlacement;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateSliderControl'
// For ise
OSStatus  ewg_function_CreateSliderControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt32 ewg_value, SInt32 ewg_minimum, SInt32 ewg_maximum, ControlSliderOrientation ewg_orientation, UInt16 ewg_numTickMarks, Boolean ewg_liveTracking, ControlActionUPP ewg_liveTrackingProc, ControlRef *ewg_outControl)
{
	return CreateSliderControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt32)ewg_value, (SInt32)ewg_minimum, (SInt32)ewg_maximum, (ControlSliderOrientation)ewg_orientation, (UInt16)ewg_numTickMarks, (Boolean)ewg_liveTracking, (ControlActionUPP)ewg_liveTrackingProc, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateSliderControl'
void* ewg_get_function_address_CreateSliderControl (void)
{
	return (void*) CreateSliderControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateDisclosureTriangleControl'
// For ise
OSStatus  ewg_function_CreateDisclosureTriangleControl (WindowRef ewg_inWindow, Rect const *ewg_inBoundsRect, ControlDisclosureTriangleOrientation ewg_inOrientation, CFStringRef ewg_inTitle, SInt32 ewg_inInitialValue, Boolean ewg_inDrawTitle, Boolean ewg_inAutoToggles, ControlRef *ewg_outControl)
{
	return CreateDisclosureTriangleControl ((WindowRef)ewg_inWindow, (Rect const*)ewg_inBoundsRect, (ControlDisclosureTriangleOrientation)ewg_inOrientation, (CFStringRef)ewg_inTitle, (SInt32)ewg_inInitialValue, (Boolean)ewg_inDrawTitle, (Boolean)ewg_inAutoToggles, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateDisclosureTriangleControl'
void* ewg_get_function_address_CreateDisclosureTriangleControl (void)
{
	return (void*) CreateDisclosureTriangleControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDisclosureTriangleLastValue'
// For ise
OSErr  ewg_function_SetDisclosureTriangleLastValue (ControlRef ewg_inTabControl, SInt16 ewg_inValue)
{
	return SetDisclosureTriangleLastValue ((ControlRef)ewg_inTabControl, (SInt16)ewg_inValue);
}

// Return address of function 'SetDisclosureTriangleLastValue'
void* ewg_get_function_address_SetDisclosureTriangleLastValue (void)
{
	return (void*) SetDisclosureTriangleLastValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateProgressBarControl'
// For ise
OSStatus  ewg_function_CreateProgressBarControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt32 ewg_value, SInt32 ewg_minimum, SInt32 ewg_maximum, Boolean ewg_indeterminate, ControlRef *ewg_outControl)
{
	return CreateProgressBarControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt32)ewg_value, (SInt32)ewg_minimum, (SInt32)ewg_maximum, (Boolean)ewg_indeterminate, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateProgressBarControl'
void* ewg_get_function_address_CreateProgressBarControl (void)
{
	return (void*) CreateProgressBarControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateRelevanceBarControl'
// For ise
OSStatus  ewg_function_CreateRelevanceBarControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt32 ewg_value, SInt32 ewg_minimum, SInt32 ewg_maximum, ControlRef *ewg_outControl)
{
	return CreateRelevanceBarControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt32)ewg_value, (SInt32)ewg_minimum, (SInt32)ewg_maximum, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateRelevanceBarControl'
void* ewg_get_function_address_CreateRelevanceBarControl (void)
{
	return (void*) CreateRelevanceBarControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateLittleArrowsControl'
// For ise
OSStatus  ewg_function_CreateLittleArrowsControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt32 ewg_value, SInt32 ewg_minimum, SInt32 ewg_maximum, SInt32 ewg_increment, ControlRef *ewg_outControl)
{
	return CreateLittleArrowsControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt32)ewg_value, (SInt32)ewg_minimum, (SInt32)ewg_maximum, (SInt32)ewg_increment, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateLittleArrowsControl'
void* ewg_get_function_address_CreateLittleArrowsControl (void)
{
	return (void*) CreateLittleArrowsControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateChasingArrowsControl'
// For ise
OSStatus  ewg_function_CreateChasingArrowsControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlRef *ewg_outControl)
{
	return CreateChasingArrowsControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateChasingArrowsControl'
void* ewg_get_function_address_CreateChasingArrowsControl (void)
{
	return (void*) CreateChasingArrowsControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateTabsControl'
// For ise
OSStatus  ewg_function_CreateTabsControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlTabSize ewg_size, ControlTabDirection ewg_direction, UInt16 ewg_numTabs, ControlTabEntry const *ewg_tabArray, ControlRef *ewg_outControl)
{
	return CreateTabsControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlTabSize)ewg_size, (ControlTabDirection)ewg_direction, (UInt16)ewg_numTabs, (ControlTabEntry const*)ewg_tabArray, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateTabsControl'
void* ewg_get_function_address_CreateTabsControl (void)
{
	return (void*) CreateTabsControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetTabContentRect'
// For ise
OSErr  ewg_function_GetTabContentRect (ControlRef ewg_inTabControl, Rect *ewg_outContentRect)
{
	return GetTabContentRect ((ControlRef)ewg_inTabControl, (Rect*)ewg_outContentRect);
}

// Return address of function 'GetTabContentRect'
void* ewg_get_function_address_GetTabContentRect (void)
{
	return (void*) GetTabContentRect;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetTabEnabled'
// For ise
OSErr  ewg_function_SetTabEnabled (ControlRef ewg_inTabControl, SInt16 ewg_inTabToHilite, Boolean ewg_inEnabled)
{
	return SetTabEnabled ((ControlRef)ewg_inTabControl, (SInt16)ewg_inTabToHilite, (Boolean)ewg_inEnabled);
}

// Return address of function 'SetTabEnabled'
void* ewg_get_function_address_SetTabEnabled (void)
{
	return (void*) SetTabEnabled;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateSeparatorControl'
// For ise
OSStatus  ewg_function_CreateSeparatorControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlRef *ewg_outControl)
{
	return CreateSeparatorControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateSeparatorControl'
void* ewg_get_function_address_CreateSeparatorControl (void)
{
	return (void*) CreateSeparatorControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateGroupBoxControl'
// For ise
OSStatus  ewg_function_CreateGroupBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, Boolean ewg_primary, ControlRef *ewg_outControl)
{
	return CreateGroupBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (Boolean)ewg_primary, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateGroupBoxControl'
void* ewg_get_function_address_CreateGroupBoxControl (void)
{
	return (void*) CreateGroupBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateCheckGroupBoxControl'
// For ise
OSStatus  ewg_function_CreateCheckGroupBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, SInt32 ewg_initialValue, Boolean ewg_primary, Boolean ewg_autoToggle, ControlRef *ewg_outControl)
{
	return CreateCheckGroupBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (SInt32)ewg_initialValue, (Boolean)ewg_primary, (Boolean)ewg_autoToggle, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateCheckGroupBoxControl'
void* ewg_get_function_address_CreateCheckGroupBoxControl (void)
{
	return (void*) CreateCheckGroupBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePopupGroupBoxControl'
// For ise
OSStatus  ewg_function_CreatePopupGroupBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, Boolean ewg_primary, SInt16 ewg_menuID, Boolean ewg_variableWidth, SInt16 ewg_titleWidth, SInt16 ewg_titleJustification, Style ewg_titleStyle, ControlRef *ewg_outControl)
{
	return CreatePopupGroupBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (Boolean)ewg_primary, (SInt16)ewg_menuID, (Boolean)ewg_variableWidth, (SInt16)ewg_titleWidth, (SInt16)ewg_titleJustification, (Style)ewg_titleStyle, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePopupGroupBoxControl'
void* ewg_get_function_address_CreatePopupGroupBoxControl (void)
{
	return (void*) CreatePopupGroupBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateImageWellControl'
// For ise
OSStatus  ewg_function_CreateImageWellControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlButtonContentInfo const *ewg_info, ControlRef *ewg_outControl)
{
	return CreateImageWellControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlButtonContentInfo const*)ewg_info, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateImageWellControl'
void* ewg_get_function_address_CreateImageWellControl (void)
{
	return (void*) CreateImageWellControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetImageWellContentInfo'
// For ise
OSErr  ewg_function_GetImageWellContentInfo (ControlRef ewg_inButton, ControlButtonContentInfoPtr ewg_outContent)
{
	return GetImageWellContentInfo ((ControlRef)ewg_inButton, (ControlButtonContentInfoPtr)ewg_outContent);
}

// Return address of function 'GetImageWellContentInfo'
void* ewg_get_function_address_GetImageWellContentInfo (void)
{
	return (void*) GetImageWellContentInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetImageWellContentInfo'
// For ise
OSErr  ewg_function_SetImageWellContentInfo (ControlRef ewg_inButton, ControlButtonContentInfoPtr ewg_inContent)
{
	return SetImageWellContentInfo ((ControlRef)ewg_inButton, (ControlButtonContentInfoPtr)ewg_inContent);
}

// Return address of function 'SetImageWellContentInfo'
void* ewg_get_function_address_SetImageWellContentInfo (void)
{
	return (void*) SetImageWellContentInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetImageWellTransform'
// For ise
OSErr  ewg_function_SetImageWellTransform (ControlRef ewg_inButton, IconTransformType ewg_inTransform)
{
	return SetImageWellTransform ((ControlRef)ewg_inButton, (IconTransformType)ewg_inTransform);
}

// Return address of function 'SetImageWellTransform'
void* ewg_get_function_address_SetImageWellTransform (void)
{
	return (void*) SetImageWellTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePopupArrowControl'
// For ise
OSStatus  ewg_function_CreatePopupArrowControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlPopupArrowOrientation ewg_orientation, ControlPopupArrowSize ewg_size, ControlRef *ewg_outControl)
{
	return CreatePopupArrowControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlPopupArrowOrientation)ewg_orientation, (ControlPopupArrowSize)ewg_size, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePopupArrowControl'
void* ewg_get_function_address_CreatePopupArrowControl (void)
{
	return (void*) CreatePopupArrowControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePlacardControl'
// For ise
OSStatus  ewg_function_CreatePlacardControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlRef *ewg_outControl)
{
	return CreatePlacardControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePlacardControl'
void* ewg_get_function_address_CreatePlacardControl (void)
{
	return (void*) CreatePlacardControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateClockControl'
// For ise
OSStatus  ewg_function_CreateClockControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlClockType ewg_clockType, ControlClockFlags ewg_clockFlags, ControlRef *ewg_outControl)
{
	return CreateClockControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlClockType)ewg_clockType, (ControlClockFlags)ewg_clockFlags, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateClockControl'
void* ewg_get_function_address_CreateClockControl (void)
{
	return (void*) CreateClockControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateUserPaneControl'
// For ise
OSStatus  ewg_function_CreateUserPaneControl (WindowRef ewg_window, Rect const *ewg_boundsRect, UInt32 ewg_features, ControlRef *ewg_outControl)
{
	return CreateUserPaneControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (UInt32)ewg_features, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateUserPaneControl'
void* ewg_get_function_address_CreateUserPaneControl (void)
{
	return (void*) CreateUserPaneControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneDrawUPP'
// For ise
ControlUserPaneDrawUPP  ewg_function_NewControlUserPaneDrawUPP (ControlUserPaneDrawProcPtr ewg_userRoutine)
{
	return NewControlUserPaneDrawUPP ((ControlUserPaneDrawProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneDrawUPP'
void* ewg_get_function_address_NewControlUserPaneDrawUPP (void)
{
	return (void*) NewControlUserPaneDrawUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneHitTestUPP'
// For ise
ControlUserPaneHitTestUPP  ewg_function_NewControlUserPaneHitTestUPP (ControlUserPaneHitTestProcPtr ewg_userRoutine)
{
	return NewControlUserPaneHitTestUPP ((ControlUserPaneHitTestProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneHitTestUPP'
void* ewg_get_function_address_NewControlUserPaneHitTestUPP (void)
{
	return (void*) NewControlUserPaneHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneTrackingUPP'
// For ise
ControlUserPaneTrackingUPP  ewg_function_NewControlUserPaneTrackingUPP (ControlUserPaneTrackingProcPtr ewg_userRoutine)
{
	return NewControlUserPaneTrackingUPP ((ControlUserPaneTrackingProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneTrackingUPP'
void* ewg_get_function_address_NewControlUserPaneTrackingUPP (void)
{
	return (void*) NewControlUserPaneTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneIdleUPP'
// For ise
ControlUserPaneIdleUPP  ewg_function_NewControlUserPaneIdleUPP (ControlUserPaneIdleProcPtr ewg_userRoutine)
{
	return NewControlUserPaneIdleUPP ((ControlUserPaneIdleProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneIdleUPP'
void* ewg_get_function_address_NewControlUserPaneIdleUPP (void)
{
	return (void*) NewControlUserPaneIdleUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneKeyDownUPP'
// For ise
ControlUserPaneKeyDownUPP  ewg_function_NewControlUserPaneKeyDownUPP (ControlUserPaneKeyDownProcPtr ewg_userRoutine)
{
	return NewControlUserPaneKeyDownUPP ((ControlUserPaneKeyDownProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneKeyDownUPP'
void* ewg_get_function_address_NewControlUserPaneKeyDownUPP (void)
{
	return (void*) NewControlUserPaneKeyDownUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneActivateUPP'
// For ise
ControlUserPaneActivateUPP  ewg_function_NewControlUserPaneActivateUPP (ControlUserPaneActivateProcPtr ewg_userRoutine)
{
	return NewControlUserPaneActivateUPP ((ControlUserPaneActivateProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneActivateUPP'
void* ewg_get_function_address_NewControlUserPaneActivateUPP (void)
{
	return (void*) NewControlUserPaneActivateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneFocusUPP'
// For ise
ControlUserPaneFocusUPP  ewg_function_NewControlUserPaneFocusUPP (ControlUserPaneFocusProcPtr ewg_userRoutine)
{
	return NewControlUserPaneFocusUPP ((ControlUserPaneFocusProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneFocusUPP'
void* ewg_get_function_address_NewControlUserPaneFocusUPP (void)
{
	return (void*) NewControlUserPaneFocusUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlUserPaneBackgroundUPP'
// For ise
ControlUserPaneBackgroundUPP  ewg_function_NewControlUserPaneBackgroundUPP (ControlUserPaneBackgroundProcPtr ewg_userRoutine)
{
	return NewControlUserPaneBackgroundUPP ((ControlUserPaneBackgroundProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlUserPaneBackgroundUPP'
void* ewg_get_function_address_NewControlUserPaneBackgroundUPP (void)
{
	return (void*) NewControlUserPaneBackgroundUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneDrawUPP'
// For ise
void  ewg_function_DisposeControlUserPaneDrawUPP (ControlUserPaneDrawUPP ewg_userUPP)
{
	DisposeControlUserPaneDrawUPP ((ControlUserPaneDrawUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneDrawUPP'
void* ewg_get_function_address_DisposeControlUserPaneDrawUPP (void)
{
	return (void*) DisposeControlUserPaneDrawUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneHitTestUPP'
// For ise
void  ewg_function_DisposeControlUserPaneHitTestUPP (ControlUserPaneHitTestUPP ewg_userUPP)
{
	DisposeControlUserPaneHitTestUPP ((ControlUserPaneHitTestUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneHitTestUPP'
void* ewg_get_function_address_DisposeControlUserPaneHitTestUPP (void)
{
	return (void*) DisposeControlUserPaneHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneTrackingUPP'
// For ise
void  ewg_function_DisposeControlUserPaneTrackingUPP (ControlUserPaneTrackingUPP ewg_userUPP)
{
	DisposeControlUserPaneTrackingUPP ((ControlUserPaneTrackingUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneTrackingUPP'
void* ewg_get_function_address_DisposeControlUserPaneTrackingUPP (void)
{
	return (void*) DisposeControlUserPaneTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneIdleUPP'
// For ise
void  ewg_function_DisposeControlUserPaneIdleUPP (ControlUserPaneIdleUPP ewg_userUPP)
{
	DisposeControlUserPaneIdleUPP ((ControlUserPaneIdleUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneIdleUPP'
void* ewg_get_function_address_DisposeControlUserPaneIdleUPP (void)
{
	return (void*) DisposeControlUserPaneIdleUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneKeyDownUPP'
// For ise
void  ewg_function_DisposeControlUserPaneKeyDownUPP (ControlUserPaneKeyDownUPP ewg_userUPP)
{
	DisposeControlUserPaneKeyDownUPP ((ControlUserPaneKeyDownUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneKeyDownUPP'
void* ewg_get_function_address_DisposeControlUserPaneKeyDownUPP (void)
{
	return (void*) DisposeControlUserPaneKeyDownUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneActivateUPP'
// For ise
void  ewg_function_DisposeControlUserPaneActivateUPP (ControlUserPaneActivateUPP ewg_userUPP)
{
	DisposeControlUserPaneActivateUPP ((ControlUserPaneActivateUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneActivateUPP'
void* ewg_get_function_address_DisposeControlUserPaneActivateUPP (void)
{
	return (void*) DisposeControlUserPaneActivateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneFocusUPP'
// For ise
void  ewg_function_DisposeControlUserPaneFocusUPP (ControlUserPaneFocusUPP ewg_userUPP)
{
	DisposeControlUserPaneFocusUPP ((ControlUserPaneFocusUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneFocusUPP'
void* ewg_get_function_address_DisposeControlUserPaneFocusUPP (void)
{
	return (void*) DisposeControlUserPaneFocusUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlUserPaneBackgroundUPP'
// For ise
void  ewg_function_DisposeControlUserPaneBackgroundUPP (ControlUserPaneBackgroundUPP ewg_userUPP)
{
	DisposeControlUserPaneBackgroundUPP ((ControlUserPaneBackgroundUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlUserPaneBackgroundUPP'
void* ewg_get_function_address_DisposeControlUserPaneBackgroundUPP (void)
{
	return (void*) DisposeControlUserPaneBackgroundUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneDrawUPP'
// For ise
void  ewg_function_InvokeControlUserPaneDrawUPP (ControlRef ewg_control, SInt16 ewg_part, ControlUserPaneDrawUPP ewg_userUPP)
{
	InvokeControlUserPaneDrawUPP ((ControlRef)ewg_control, (SInt16)ewg_part, (ControlUserPaneDrawUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneDrawUPP'
void* ewg_get_function_address_InvokeControlUserPaneDrawUPP (void)
{
	return (void*) InvokeControlUserPaneDrawUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneHitTestUPP'
// For ise
ControlPartCode  ewg_function_InvokeControlUserPaneHitTestUPP (ControlRef ewg_control, Point *ewg_where, ControlUserPaneHitTestUPP ewg_userUPP)
{
	return InvokeControlUserPaneHitTestUPP ((ControlRef)ewg_control, *(Point*)ewg_where, (ControlUserPaneHitTestUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneHitTestUPP'
void* ewg_get_function_address_InvokeControlUserPaneHitTestUPP (void)
{
	return (void*) InvokeControlUserPaneHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneTrackingUPP'
// For ise
ControlPartCode  ewg_function_InvokeControlUserPaneTrackingUPP (ControlRef ewg_control, Point *ewg_startPt, ControlActionUPP ewg_actionProc, ControlUserPaneTrackingUPP ewg_userUPP)
{
	return InvokeControlUserPaneTrackingUPP ((ControlRef)ewg_control, *(Point*)ewg_startPt, (ControlActionUPP)ewg_actionProc, (ControlUserPaneTrackingUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneTrackingUPP'
void* ewg_get_function_address_InvokeControlUserPaneTrackingUPP (void)
{
	return (void*) InvokeControlUserPaneTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneIdleUPP'
// For ise
void  ewg_function_InvokeControlUserPaneIdleUPP (ControlRef ewg_control, ControlUserPaneIdleUPP ewg_userUPP)
{
	InvokeControlUserPaneIdleUPP ((ControlRef)ewg_control, (ControlUserPaneIdleUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneIdleUPP'
void* ewg_get_function_address_InvokeControlUserPaneIdleUPP (void)
{
	return (void*) InvokeControlUserPaneIdleUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneKeyDownUPP'
// For ise
ControlPartCode  ewg_function_InvokeControlUserPaneKeyDownUPP (ControlRef ewg_control, SInt16 ewg_keyCode, SInt16 ewg_charCode, SInt16 ewg_modifiers, ControlUserPaneKeyDownUPP ewg_userUPP)
{
	return InvokeControlUserPaneKeyDownUPP ((ControlRef)ewg_control, (SInt16)ewg_keyCode, (SInt16)ewg_charCode, (SInt16)ewg_modifiers, (ControlUserPaneKeyDownUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneKeyDownUPP'
void* ewg_get_function_address_InvokeControlUserPaneKeyDownUPP (void)
{
	return (void*) InvokeControlUserPaneKeyDownUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneActivateUPP'
// For ise
void  ewg_function_InvokeControlUserPaneActivateUPP (ControlRef ewg_control, Boolean ewg_activating, ControlUserPaneActivateUPP ewg_userUPP)
{
	InvokeControlUserPaneActivateUPP ((ControlRef)ewg_control, (Boolean)ewg_activating, (ControlUserPaneActivateUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneActivateUPP'
void* ewg_get_function_address_InvokeControlUserPaneActivateUPP (void)
{
	return (void*) InvokeControlUserPaneActivateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneFocusUPP'
// For ise
ControlPartCode  ewg_function_InvokeControlUserPaneFocusUPP (ControlRef ewg_control, ControlFocusPart ewg_action, ControlUserPaneFocusUPP ewg_userUPP)
{
	return InvokeControlUserPaneFocusUPP ((ControlRef)ewg_control, (ControlFocusPart)ewg_action, (ControlUserPaneFocusUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneFocusUPP'
void* ewg_get_function_address_InvokeControlUserPaneFocusUPP (void)
{
	return (void*) InvokeControlUserPaneFocusUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlUserPaneBackgroundUPP'
// For ise
void  ewg_function_InvokeControlUserPaneBackgroundUPP (ControlRef ewg_control, ControlBackgroundPtr ewg_info, ControlUserPaneBackgroundUPP ewg_userUPP)
{
	InvokeControlUserPaneBackgroundUPP ((ControlRef)ewg_control, (ControlBackgroundPtr)ewg_info, (ControlUserPaneBackgroundUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlUserPaneBackgroundUPP'
void* ewg_get_function_address_InvokeControlUserPaneBackgroundUPP (void)
{
	return (void*) InvokeControlUserPaneBackgroundUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateEditTextControl'
// For ise
OSStatus  ewg_function_CreateEditTextControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_text, Boolean ewg_isPassword, Boolean ewg_useInlineInput, ControlFontStyleRec const *ewg_style, ControlRef *ewg_outControl)
{
	return CreateEditTextControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_text, (Boolean)ewg_isPassword, (Boolean)ewg_useInlineInput, (ControlFontStyleRec const*)ewg_style, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateEditTextControl'
void* ewg_get_function_address_CreateEditTextControl (void)
{
	return (void*) CreateEditTextControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewControlEditTextValidationUPP'
// For ise
ControlEditTextValidationUPP  ewg_function_NewControlEditTextValidationUPP (ControlEditTextValidationProcPtr ewg_userRoutine)
{
	return NewControlEditTextValidationUPP ((ControlEditTextValidationProcPtr)ewg_userRoutine);
}

// Return address of function 'NewControlEditTextValidationUPP'
void* ewg_get_function_address_NewControlEditTextValidationUPP (void)
{
	return (void*) NewControlEditTextValidationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeControlEditTextValidationUPP'
// For ise
void  ewg_function_DisposeControlEditTextValidationUPP (ControlEditTextValidationUPP ewg_userUPP)
{
	DisposeControlEditTextValidationUPP ((ControlEditTextValidationUPP)ewg_userUPP);
}

// Return address of function 'DisposeControlEditTextValidationUPP'
void* ewg_get_function_address_DisposeControlEditTextValidationUPP (void)
{
	return (void*) DisposeControlEditTextValidationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeControlEditTextValidationUPP'
// For ise
void  ewg_function_InvokeControlEditTextValidationUPP (ControlRef ewg_control, ControlEditTextValidationUPP ewg_userUPP)
{
	InvokeControlEditTextValidationUPP ((ControlRef)ewg_control, (ControlEditTextValidationUPP)ewg_userUPP);
}

// Return address of function 'InvokeControlEditTextValidationUPP'
void* ewg_get_function_address_InvokeControlEditTextValidationUPP (void)
{
	return (void*) InvokeControlEditTextValidationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateStaticTextControl'
// For ise
OSStatus  ewg_function_CreateStaticTextControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_text, ControlFontStyleRec const *ewg_style, ControlRef *ewg_outControl)
{
	return CreateStaticTextControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_text, (ControlFontStyleRec const*)ewg_style, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateStaticTextControl'
void* ewg_get_function_address_CreateStaticTextControl (void)
{
	return (void*) CreateStaticTextControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePictureControl'
// For ise
OSStatus  ewg_function_CreatePictureControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlButtonContentInfo const *ewg_content, Boolean ewg_dontTrack, ControlRef *ewg_outControl)
{
	return CreatePictureControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlButtonContentInfo const*)ewg_content, (Boolean)ewg_dontTrack, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePictureControl'
void* ewg_get_function_address_CreatePictureControl (void)
{
	return (void*) CreatePictureControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateIconControl'
// For ise
OSStatus  ewg_function_CreateIconControl (WindowRef ewg_inWindow, Rect const *ewg_inBoundsRect, ControlButtonContentInfo const *ewg_inIconContent, Boolean ewg_inDontTrack, ControlRef *ewg_outControl)
{
	return CreateIconControl ((WindowRef)ewg_inWindow, (Rect const*)ewg_inBoundsRect, (ControlButtonContentInfo const*)ewg_inIconContent, (Boolean)ewg_inDontTrack, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateIconControl'
void* ewg_get_function_address_CreateIconControl (void)
{
	return (void*) CreateIconControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateWindowHeaderControl'
// For ise
OSStatus  ewg_function_CreateWindowHeaderControl (WindowRef ewg_window, Rect const *ewg_boundsRect, Boolean ewg_isListHeader, ControlRef *ewg_outControl)
{
	return CreateWindowHeaderControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (Boolean)ewg_isListHeader, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateWindowHeaderControl'
void* ewg_get_function_address_CreateWindowHeaderControl (void)
{
	return (void*) CreateWindowHeaderControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateListBoxControl'
// For ise
OSStatus  ewg_function_CreateListBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, Boolean ewg_autoSize, SInt16 ewg_numRows, SInt16 ewg_numColumns, Boolean ewg_horizScroll, Boolean ewg_vertScroll, SInt16 ewg_cellHeight, SInt16 ewg_cellWidth, Boolean ewg_hasGrowSpace, ListDefSpec const *ewg_listDef, ControlRef *ewg_outControl)
{
	return CreateListBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (Boolean)ewg_autoSize, (SInt16)ewg_numRows, (SInt16)ewg_numColumns, (Boolean)ewg_horizScroll, (Boolean)ewg_vertScroll, (SInt16)ewg_cellHeight, (SInt16)ewg_cellWidth, (Boolean)ewg_hasGrowSpace, (ListDefSpec const*)ewg_listDef, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateListBoxControl'
void* ewg_get_function_address_CreateListBoxControl (void)
{
	return (void*) CreateListBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePushButtonControl'
// For ise
OSStatus  ewg_function_CreatePushButtonControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, ControlRef *ewg_outControl)
{
	return CreatePushButtonControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePushButtonControl'
void* ewg_get_function_address_CreatePushButtonControl (void)
{
	return (void*) CreatePushButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePushButtonWithIconControl'
// For ise
OSStatus  ewg_function_CreatePushButtonWithIconControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, ControlButtonContentInfo *ewg_icon, ControlPushButtonIconAlignment ewg_iconAlignment, ControlRef *ewg_outControl)
{
	return CreatePushButtonWithIconControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (ControlButtonContentInfo*)ewg_icon, (ControlPushButtonIconAlignment)ewg_iconAlignment, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePushButtonWithIconControl'
void* ewg_get_function_address_CreatePushButtonWithIconControl (void)
{
	return (void*) CreatePushButtonWithIconControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateRadioButtonControl'
// For ise
OSStatus  ewg_function_CreateRadioButtonControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, SInt32 ewg_initialValue, Boolean ewg_autoToggle, ControlRef *ewg_outControl)
{
	return CreateRadioButtonControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (SInt32)ewg_initialValue, (Boolean)ewg_autoToggle, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateRadioButtonControl'
void* ewg_get_function_address_CreateRadioButtonControl (void)
{
	return (void*) CreateRadioButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateCheckBoxControl'
// For ise
OSStatus  ewg_function_CreateCheckBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, SInt32 ewg_initialValue, Boolean ewg_autoToggle, ControlRef *ewg_outControl)
{
	return CreateCheckBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (SInt32)ewg_initialValue, (Boolean)ewg_autoToggle, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateCheckBoxControl'
void* ewg_get_function_address_CreateCheckBoxControl (void)
{
	return (void*) CreateCheckBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateScrollBarControl'
// For ise
OSStatus  ewg_function_CreateScrollBarControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt32 ewg_value, SInt32 ewg_minimum, SInt32 ewg_maximum, SInt32 ewg_viewSize, Boolean ewg_liveTracking, ControlActionUPP ewg_liveTrackingProc, ControlRef *ewg_outControl)
{
	return CreateScrollBarControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt32)ewg_value, (SInt32)ewg_minimum, (SInt32)ewg_maximum, (SInt32)ewg_viewSize, (Boolean)ewg_liveTracking, (ControlActionUPP)ewg_liveTrackingProc, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateScrollBarControl'
void* ewg_get_function_address_CreateScrollBarControl (void)
{
	return (void*) CreateScrollBarControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreatePopupButtonControl'
// For ise
OSStatus  ewg_function_CreatePopupButtonControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_title, SInt16 ewg_menuID, Boolean ewg_variableWidth, SInt16 ewg_titleWidth, SInt16 ewg_titleJustification, Style ewg_titleStyle, ControlRef *ewg_outControl)
{
	return CreatePopupButtonControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_title, (SInt16)ewg_menuID, (Boolean)ewg_variableWidth, (SInt16)ewg_titleWidth, (SInt16)ewg_titleJustification, (Style)ewg_titleStyle, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreatePopupButtonControl'
void* ewg_get_function_address_CreatePopupButtonControl (void)
{
	return (void*) CreatePopupButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateRadioGroupControl'
// For ise
OSStatus  ewg_function_CreateRadioGroupControl (WindowRef ewg_window, Rect const *ewg_boundsRect, ControlRef *ewg_outControl)
{
	return CreateRadioGroupControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateRadioGroupControl'
void* ewg_get_function_address_CreateRadioGroupControl (void)
{
	return (void*) CreateRadioGroupControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateScrollingTextBoxControl'
// For ise
OSStatus  ewg_function_CreateScrollingTextBoxControl (WindowRef ewg_window, Rect const *ewg_boundsRect, SInt16 ewg_contentResID, Boolean ewg_autoScroll, UInt32 ewg_delayBeforeAutoScroll, UInt32 ewg_delayBetweenAutoScroll, UInt16 ewg_autoScrollAmount, ControlRef *ewg_outControl)
{
	return CreateScrollingTextBoxControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (SInt16)ewg_contentResID, (Boolean)ewg_autoScroll, (UInt32)ewg_delayBeforeAutoScroll, (UInt32)ewg_delayBetweenAutoScroll, (UInt16)ewg_autoScrollAmount, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateScrollingTextBoxControl'
void* ewg_get_function_address_CreateScrollingTextBoxControl (void)
{
	return (void*) CreateScrollingTextBoxControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateDisclosureButtonControl'
// For ise
OSStatus  ewg_function_CreateDisclosureButtonControl (WindowRef ewg_inWindow, Rect const *ewg_inBoundsRect, SInt32 ewg_inValue, Boolean ewg_inAutoToggles, ControlRef *ewg_outControl)
{
	return CreateDisclosureButtonControl ((WindowRef)ewg_inWindow, (Rect const*)ewg_inBoundsRect, (SInt32)ewg_inValue, (Boolean)ewg_inAutoToggles, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateDisclosureButtonControl'
void* ewg_get_function_address_CreateDisclosureButtonControl (void)
{
	return (void*) CreateDisclosureButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateRoundButtonControl'
// For ise
OSStatus  ewg_function_CreateRoundButtonControl (WindowRef ewg_inWindow, Rect const *ewg_inBoundsRect, ControlRoundButtonSize ewg_inSize, ControlButtonContentInfo *ewg_inContent, ControlRef *ewg_outControl)
{
	return CreateRoundButtonControl ((WindowRef)ewg_inWindow, (Rect const*)ewg_inBoundsRect, (ControlRoundButtonSize)ewg_inSize, (ControlButtonContentInfo*)ewg_inContent, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateRoundButtonControl'
void* ewg_get_function_address_CreateRoundButtonControl (void)
{
	return (void*) CreateRoundButtonControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemUPP'
// For ise
DataBrowserItemUPP  ewg_function_NewDataBrowserItemUPP (DataBrowserItemProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemUPP ((DataBrowserItemProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemUPP'
void* ewg_get_function_address_NewDataBrowserItemUPP (void)
{
	return (void*) NewDataBrowserItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemUPP (DataBrowserItemUPP ewg_userUPP)
{
	DisposeDataBrowserItemUPP ((DataBrowserItemUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemUPP'
void* ewg_get_function_address_DisposeDataBrowserItemUPP (void)
{
	return (void*) DisposeDataBrowserItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemUPP'
// For ise
void  ewg_function_InvokeDataBrowserItemUPP (DataBrowserItemID ewg_item, DataBrowserItemState ewg_state, void *ewg_clientData, DataBrowserItemUPP ewg_userUPP)
{
	InvokeDataBrowserItemUPP ((DataBrowserItemID)ewg_item, (DataBrowserItemState)ewg_state, (void*)ewg_clientData, (DataBrowserItemUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemUPP'
void* ewg_get_function_address_InvokeDataBrowserItemUPP (void)
{
	return (void*) InvokeDataBrowserItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateDataBrowserControl'
// For ise
OSStatus  ewg_function_CreateDataBrowserControl (WindowRef ewg_window, Rect const *ewg_boundsRect, DataBrowserViewStyle ewg_style, ControlRef *ewg_outControl)
{
	return CreateDataBrowserControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (DataBrowserViewStyle)ewg_style, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateDataBrowserControl'
void* ewg_get_function_address_CreateDataBrowserControl (void)
{
	return (void*) CreateDataBrowserControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserViewStyle'
// For ise
OSStatus  ewg_function_GetDataBrowserViewStyle (ControlRef ewg_browser, DataBrowserViewStyle *ewg_style)
{
	return GetDataBrowserViewStyle ((ControlRef)ewg_browser, (DataBrowserViewStyle*)ewg_style);
}

// Return address of function 'GetDataBrowserViewStyle'
void* ewg_get_function_address_GetDataBrowserViewStyle (void)
{
	return (void*) GetDataBrowserViewStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserViewStyle'
// For ise
OSStatus  ewg_function_SetDataBrowserViewStyle (ControlRef ewg_browser, DataBrowserViewStyle ewg_style)
{
	return SetDataBrowserViewStyle ((ControlRef)ewg_browser, (DataBrowserViewStyle)ewg_style);
}

// Return address of function 'SetDataBrowserViewStyle'
void* ewg_get_function_address_SetDataBrowserViewStyle (void)
{
	return (void*) SetDataBrowserViewStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DataBrowserChangeAttributes'
// For ise
OSStatus  ewg_function_DataBrowserChangeAttributes (ControlRef ewg_inDataBrowser, OptionBits ewg_inAttributesToSet, OptionBits ewg_inAttributesToClear)
{
	return DataBrowserChangeAttributes ((ControlRef)ewg_inDataBrowser, (OptionBits)ewg_inAttributesToSet, (OptionBits)ewg_inAttributesToClear);
}

// Return address of function 'DataBrowserChangeAttributes'
void* ewg_get_function_address_DataBrowserChangeAttributes (void)
{
	return (void*) DataBrowserChangeAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DataBrowserGetAttributes'
// For ise
OSStatus  ewg_function_DataBrowserGetAttributes (ControlRef ewg_inDataBrowser, OptionBits *ewg_outAttributes)
{
	return DataBrowserGetAttributes ((ControlRef)ewg_inDataBrowser, (OptionBits*)ewg_outAttributes);
}

// Return address of function 'DataBrowserGetAttributes'
void* ewg_get_function_address_DataBrowserGetAttributes (void)
{
	return (void*) DataBrowserGetAttributes;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DataBrowserSetMetric'
// For ise
OSStatus  ewg_function_DataBrowserSetMetric (ControlRef ewg_inDataBrowser, DataBrowserMetric ewg_inMetric, Boolean ewg_inUseDefaultValue, float ewg_inValue)
{
	return DataBrowserSetMetric ((ControlRef)ewg_inDataBrowser, (DataBrowserMetric)ewg_inMetric, (Boolean)ewg_inUseDefaultValue, (float)ewg_inValue);
}

// Return address of function 'DataBrowserSetMetric'
void* ewg_get_function_address_DataBrowserSetMetric (void)
{
	return (void*) DataBrowserSetMetric;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DataBrowserGetMetric'
// For ise
OSStatus  ewg_function_DataBrowserGetMetric (ControlRef ewg_inDataBrowser, DataBrowserMetric ewg_inMetric, Boolean *ewg_outUsingDefaultValue, float *ewg_outValue)
{
	return DataBrowserGetMetric ((ControlRef)ewg_inDataBrowser, (DataBrowserMetric)ewg_inMetric, (Boolean*)ewg_outUsingDefaultValue, (float*)ewg_outValue);
}

// Return address of function 'DataBrowserGetMetric'
void* ewg_get_function_address_DataBrowserGetMetric (void)
{
	return (void*) DataBrowserGetMetric;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AddDataBrowserItems'
// For ise
OSStatus  ewg_function_AddDataBrowserItems (ControlRef ewg_browser, DataBrowserItemID ewg_container, UInt32 ewg_numItems, DataBrowserItemID const *ewg_items, DataBrowserPropertyID ewg_preSortProperty)
{
	return AddDataBrowserItems ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (UInt32)ewg_numItems, (DataBrowserItemID const*)ewg_items, (DataBrowserPropertyID)ewg_preSortProperty);
}

// Return address of function 'AddDataBrowserItems'
void* ewg_get_function_address_AddDataBrowserItems (void)
{
	return (void*) AddDataBrowserItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveDataBrowserItems'
// For ise
OSStatus  ewg_function_RemoveDataBrowserItems (ControlRef ewg_browser, DataBrowserItemID ewg_container, UInt32 ewg_numItems, DataBrowserItemID const *ewg_items, DataBrowserPropertyID ewg_preSortProperty)
{
	return RemoveDataBrowserItems ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (UInt32)ewg_numItems, (DataBrowserItemID const*)ewg_items, (DataBrowserPropertyID)ewg_preSortProperty);
}

// Return address of function 'RemoveDataBrowserItems'
void* ewg_get_function_address_RemoveDataBrowserItems (void)
{
	return (void*) RemoveDataBrowserItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'UpdateDataBrowserItems'
// For ise
OSStatus  ewg_function_UpdateDataBrowserItems (ControlRef ewg_browser, DataBrowserItemID ewg_container, UInt32 ewg_numItems, DataBrowserItemID const *ewg_items, DataBrowserPropertyID ewg_preSortProperty, DataBrowserPropertyID ewg_propertyID)
{
	return UpdateDataBrowserItems ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (UInt32)ewg_numItems, (DataBrowserItemID const*)ewg_items, (DataBrowserPropertyID)ewg_preSortProperty, (DataBrowserPropertyID)ewg_propertyID);
}

// Return address of function 'UpdateDataBrowserItems'
void* ewg_get_function_address_UpdateDataBrowserItems (void)
{
	return (void*) UpdateDataBrowserItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'EnableDataBrowserEditCommand'
// For ise
Boolean  ewg_function_EnableDataBrowserEditCommand (ControlRef ewg_browser, DataBrowserEditCommand ewg_command)
{
	return EnableDataBrowserEditCommand ((ControlRef)ewg_browser, (DataBrowserEditCommand)ewg_command);
}

// Return address of function 'EnableDataBrowserEditCommand'
void* ewg_get_function_address_EnableDataBrowserEditCommand (void)
{
	return (void*) EnableDataBrowserEditCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ExecuteDataBrowserEditCommand'
// For ise
OSStatus  ewg_function_ExecuteDataBrowserEditCommand (ControlRef ewg_browser, DataBrowserEditCommand ewg_command)
{
	return ExecuteDataBrowserEditCommand ((ControlRef)ewg_browser, (DataBrowserEditCommand)ewg_command);
}

// Return address of function 'ExecuteDataBrowserEditCommand'
void* ewg_get_function_address_ExecuteDataBrowserEditCommand (void)
{
	return (void*) ExecuteDataBrowserEditCommand;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserSelectionAnchor'
// For ise
OSStatus  ewg_function_GetDataBrowserSelectionAnchor (ControlRef ewg_browser, DataBrowserItemID *ewg_first, DataBrowserItemID *ewg_last)
{
	return GetDataBrowserSelectionAnchor ((ControlRef)ewg_browser, (DataBrowserItemID*)ewg_first, (DataBrowserItemID*)ewg_last);
}

// Return address of function 'GetDataBrowserSelectionAnchor'
void* ewg_get_function_address_GetDataBrowserSelectionAnchor (void)
{
	return (void*) GetDataBrowserSelectionAnchor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'MoveDataBrowserSelectionAnchor'
// For ise
OSStatus  ewg_function_MoveDataBrowserSelectionAnchor (ControlRef ewg_browser, DataBrowserSelectionAnchorDirection ewg_direction, Boolean ewg_extendSelection)
{
	return MoveDataBrowserSelectionAnchor ((ControlRef)ewg_browser, (DataBrowserSelectionAnchorDirection)ewg_direction, (Boolean)ewg_extendSelection);
}

// Return address of function 'MoveDataBrowserSelectionAnchor'
void* ewg_get_function_address_MoveDataBrowserSelectionAnchor (void)
{
	return (void*) MoveDataBrowserSelectionAnchor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'OpenDataBrowserContainer'
// For ise
OSStatus  ewg_function_OpenDataBrowserContainer (ControlRef ewg_browser, DataBrowserItemID ewg_container)
{
	return OpenDataBrowserContainer ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container);
}

// Return address of function 'OpenDataBrowserContainer'
void* ewg_get_function_address_OpenDataBrowserContainer (void)
{
	return (void*) OpenDataBrowserContainer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CloseDataBrowserContainer'
// For ise
OSStatus  ewg_function_CloseDataBrowserContainer (ControlRef ewg_browser, DataBrowserItemID ewg_container)
{
	return CloseDataBrowserContainer ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container);
}

// Return address of function 'CloseDataBrowserContainer'
void* ewg_get_function_address_CloseDataBrowserContainer (void)
{
	return (void*) CloseDataBrowserContainer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SortDataBrowserContainer'
// For ise
OSStatus  ewg_function_SortDataBrowserContainer (ControlRef ewg_browser, DataBrowserItemID ewg_container, Boolean ewg_sortChildren)
{
	return SortDataBrowserContainer ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (Boolean)ewg_sortChildren);
}

// Return address of function 'SortDataBrowserContainer'
void* ewg_get_function_address_SortDataBrowserContainer (void)
{
	return (void*) SortDataBrowserContainer;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItems'
// For ise
OSStatus  ewg_function_GetDataBrowserItems (ControlRef ewg_browser, DataBrowserItemID ewg_container, Boolean ewg_recurse, DataBrowserItemState ewg_state, Handle ewg_items)
{
	return GetDataBrowserItems ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (Boolean)ewg_recurse, (DataBrowserItemState)ewg_state, (Handle)ewg_items);
}

// Return address of function 'GetDataBrowserItems'
void* ewg_get_function_address_GetDataBrowserItems (void)
{
	return (void*) GetDataBrowserItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemCount'
// For ise
OSStatus  ewg_function_GetDataBrowserItemCount (ControlRef ewg_browser, DataBrowserItemID ewg_container, Boolean ewg_recurse, DataBrowserItemState ewg_state, UInt32 *ewg_numItems)
{
	return GetDataBrowserItemCount ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (Boolean)ewg_recurse, (DataBrowserItemState)ewg_state, (UInt32*)ewg_numItems);
}

// Return address of function 'GetDataBrowserItemCount'
void* ewg_get_function_address_GetDataBrowserItemCount (void)
{
	return (void*) GetDataBrowserItemCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'ForEachDataBrowserItem'
// For ise
OSStatus  ewg_function_ForEachDataBrowserItem (ControlRef ewg_browser, DataBrowserItemID ewg_container, Boolean ewg_recurse, DataBrowserItemState ewg_state, DataBrowserItemUPP ewg_callback, void *ewg_clientData)
{
	return ForEachDataBrowserItem ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_container, (Boolean)ewg_recurse, (DataBrowserItemState)ewg_state, (DataBrowserItemUPP)ewg_callback, (void*)ewg_clientData);
}

// Return address of function 'ForEachDataBrowserItem'
void* ewg_get_function_address_ForEachDataBrowserItem (void)
{
	return (void*) ForEachDataBrowserItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'IsDataBrowserItemSelected'
// For ise
Boolean  ewg_function_IsDataBrowserItemSelected (ControlRef ewg_browser, DataBrowserItemID ewg_item)
{
	return IsDataBrowserItemSelected ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item);
}

// Return address of function 'IsDataBrowserItemSelected'
void* ewg_get_function_address_IsDataBrowserItemSelected (void)
{
	return (void*) IsDataBrowserItemSelected;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemState'
// For ise
OSStatus  ewg_function_GetDataBrowserItemState (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserItemState *ewg_state)
{
	return GetDataBrowserItemState ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserItemState*)ewg_state);
}

// Return address of function 'GetDataBrowserItemState'
void* ewg_get_function_address_GetDataBrowserItemState (void)
{
	return (void*) GetDataBrowserItemState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RevealDataBrowserItem'
// For ise
OSStatus  ewg_function_RevealDataBrowserItem (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_propertyID, DataBrowserRevealOptions ewg_options)
{
	return RevealDataBrowserItem ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_propertyID, (DataBrowserRevealOptions)ewg_options);
}

// Return address of function 'RevealDataBrowserItem'
void* ewg_get_function_address_RevealDataBrowserItem (void)
{
	return (void*) RevealDataBrowserItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserSelectedItems'
// For ise
OSStatus  ewg_function_SetDataBrowserSelectedItems (ControlRef ewg_browser, UInt32 ewg_numItems, DataBrowserItemID const *ewg_items, DataBrowserSetOption ewg_operation)
{
	return SetDataBrowserSelectedItems ((ControlRef)ewg_browser, (UInt32)ewg_numItems, (DataBrowserItemID const*)ewg_items, (DataBrowserSetOption)ewg_operation);
}

// Return address of function 'SetDataBrowserSelectedItems'
void* ewg_get_function_address_SetDataBrowserSelectedItems (void)
{
	return (void*) SetDataBrowserSelectedItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserUserState'
// For ise
OSStatus  ewg_function_SetDataBrowserUserState (ControlRef ewg_browser, CFDictionaryRef ewg_stateInfo)
{
	return SetDataBrowserUserState ((ControlRef)ewg_browser, (CFDictionaryRef)ewg_stateInfo);
}

// Return address of function 'SetDataBrowserUserState'
void* ewg_get_function_address_SetDataBrowserUserState (void)
{
	return (void*) SetDataBrowserUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserUserState'
// For ise
OSStatus  ewg_function_GetDataBrowserUserState (ControlRef ewg_browser, CFDictionaryRef *ewg_stateInfo)
{
	return GetDataBrowserUserState ((ControlRef)ewg_browser, (CFDictionaryRef*)ewg_stateInfo);
}

// Return address of function 'GetDataBrowserUserState'
void* ewg_get_function_address_GetDataBrowserUserState (void)
{
	return (void*) GetDataBrowserUserState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserActiveItems'
// For ise
OSStatus  ewg_function_SetDataBrowserActiveItems (ControlRef ewg_browser, Boolean ewg_active)
{
	return SetDataBrowserActiveItems ((ControlRef)ewg_browser, (Boolean)ewg_active);
}

// Return address of function 'SetDataBrowserActiveItems'
void* ewg_get_function_address_SetDataBrowserActiveItems (void)
{
	return (void*) SetDataBrowserActiveItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserActiveItems'
// For ise
OSStatus  ewg_function_GetDataBrowserActiveItems (ControlRef ewg_browser, Boolean *ewg_active)
{
	return GetDataBrowserActiveItems ((ControlRef)ewg_browser, (Boolean*)ewg_active);
}

// Return address of function 'GetDataBrowserActiveItems'
void* ewg_get_function_address_GetDataBrowserActiveItems (void)
{
	return (void*) GetDataBrowserActiveItems;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserScrollBarInset'
// For ise
OSStatus  ewg_function_SetDataBrowserScrollBarInset (ControlRef ewg_browser, Rect *ewg_insetRect)
{
	return SetDataBrowserScrollBarInset ((ControlRef)ewg_browser, (Rect*)ewg_insetRect);
}

// Return address of function 'SetDataBrowserScrollBarInset'
void* ewg_get_function_address_SetDataBrowserScrollBarInset (void)
{
	return (void*) SetDataBrowserScrollBarInset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserScrollBarInset'
// For ise
OSStatus  ewg_function_GetDataBrowserScrollBarInset (ControlRef ewg_browser, Rect *ewg_insetRect)
{
	return GetDataBrowserScrollBarInset ((ControlRef)ewg_browser, (Rect*)ewg_insetRect);
}

// Return address of function 'GetDataBrowserScrollBarInset'
void* ewg_get_function_address_GetDataBrowserScrollBarInset (void)
{
	return (void*) GetDataBrowserScrollBarInset;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTarget'
// For ise
OSStatus  ewg_function_SetDataBrowserTarget (ControlRef ewg_browser, DataBrowserItemID ewg_target)
{
	return SetDataBrowserTarget ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_target);
}

// Return address of function 'SetDataBrowserTarget'
void* ewg_get_function_address_SetDataBrowserTarget (void)
{
	return (void*) SetDataBrowserTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTarget'
// For ise
OSStatus  ewg_function_GetDataBrowserTarget (ControlRef ewg_browser, DataBrowserItemID *ewg_target)
{
	return GetDataBrowserTarget ((ControlRef)ewg_browser, (DataBrowserItemID*)ewg_target);
}

// Return address of function 'GetDataBrowserTarget'
void* ewg_get_function_address_GetDataBrowserTarget (void)
{
	return (void*) GetDataBrowserTarget;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserSortOrder'
// For ise
OSStatus  ewg_function_SetDataBrowserSortOrder (ControlRef ewg_browser, DataBrowserSortOrder ewg_order)
{
	return SetDataBrowserSortOrder ((ControlRef)ewg_browser, (DataBrowserSortOrder)ewg_order);
}

// Return address of function 'SetDataBrowserSortOrder'
void* ewg_get_function_address_SetDataBrowserSortOrder (void)
{
	return (void*) SetDataBrowserSortOrder;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserSortOrder'
// For ise
OSStatus  ewg_function_GetDataBrowserSortOrder (ControlRef ewg_browser, DataBrowserSortOrder *ewg_order)
{
	return GetDataBrowserSortOrder ((ControlRef)ewg_browser, (DataBrowserSortOrder*)ewg_order);
}

// Return address of function 'GetDataBrowserSortOrder'
void* ewg_get_function_address_GetDataBrowserSortOrder (void)
{
	return (void*) GetDataBrowserSortOrder;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserScrollPosition'
// For ise
OSStatus  ewg_function_SetDataBrowserScrollPosition (ControlRef ewg_browser, UInt32 ewg_top, UInt32 ewg_left)
{
	return SetDataBrowserScrollPosition ((ControlRef)ewg_browser, (UInt32)ewg_top, (UInt32)ewg_left);
}

// Return address of function 'SetDataBrowserScrollPosition'
void* ewg_get_function_address_SetDataBrowserScrollPosition (void)
{
	return (void*) SetDataBrowserScrollPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserScrollPosition'
// For ise
OSStatus  ewg_function_GetDataBrowserScrollPosition (ControlRef ewg_browser, UInt32 *ewg_top, UInt32 *ewg_left)
{
	return GetDataBrowserScrollPosition ((ControlRef)ewg_browser, (UInt32*)ewg_top, (UInt32*)ewg_left);
}

// Return address of function 'GetDataBrowserScrollPosition'
void* ewg_get_function_address_GetDataBrowserScrollPosition (void)
{
	return (void*) GetDataBrowserScrollPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserHasScrollBars'
// For ise
OSStatus  ewg_function_SetDataBrowserHasScrollBars (ControlRef ewg_browser, Boolean ewg_horiz, Boolean ewg_vert)
{
	return SetDataBrowserHasScrollBars ((ControlRef)ewg_browser, (Boolean)ewg_horiz, (Boolean)ewg_vert);
}

// Return address of function 'SetDataBrowserHasScrollBars'
void* ewg_get_function_address_SetDataBrowserHasScrollBars (void)
{
	return (void*) SetDataBrowserHasScrollBars;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserHasScrollBars'
// For ise
OSStatus  ewg_function_GetDataBrowserHasScrollBars (ControlRef ewg_browser, Boolean *ewg_horiz, Boolean *ewg_vert)
{
	return GetDataBrowserHasScrollBars ((ControlRef)ewg_browser, (Boolean*)ewg_horiz, (Boolean*)ewg_vert);
}

// Return address of function 'GetDataBrowserHasScrollBars'
void* ewg_get_function_address_GetDataBrowserHasScrollBars (void)
{
	return (void*) GetDataBrowserHasScrollBars;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserSortProperty'
// For ise
OSStatus  ewg_function_SetDataBrowserSortProperty (ControlRef ewg_browser, DataBrowserPropertyID ewg_property)
{
	return SetDataBrowserSortProperty ((ControlRef)ewg_browser, (DataBrowserPropertyID)ewg_property);
}

// Return address of function 'SetDataBrowserSortProperty'
void* ewg_get_function_address_SetDataBrowserSortProperty (void)
{
	return (void*) SetDataBrowserSortProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserSortProperty'
// For ise
OSStatus  ewg_function_GetDataBrowserSortProperty (ControlRef ewg_browser, DataBrowserPropertyID *ewg_property)
{
	return GetDataBrowserSortProperty ((ControlRef)ewg_browser, (DataBrowserPropertyID*)ewg_property);
}

// Return address of function 'GetDataBrowserSortProperty'
void* ewg_get_function_address_GetDataBrowserSortProperty (void)
{
	return (void*) GetDataBrowserSortProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserSelectionFlags'
// For ise
OSStatus  ewg_function_SetDataBrowserSelectionFlags (ControlRef ewg_browser, DataBrowserSelectionFlags ewg_selectionFlags)
{
	return SetDataBrowserSelectionFlags ((ControlRef)ewg_browser, (DataBrowserSelectionFlags)ewg_selectionFlags);
}

// Return address of function 'SetDataBrowserSelectionFlags'
void* ewg_get_function_address_SetDataBrowserSelectionFlags (void)
{
	return (void*) SetDataBrowserSelectionFlags;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserSelectionFlags'
// For ise
OSStatus  ewg_function_GetDataBrowserSelectionFlags (ControlRef ewg_browser, DataBrowserSelectionFlags *ewg_selectionFlags)
{
	return GetDataBrowserSelectionFlags ((ControlRef)ewg_browser, (DataBrowserSelectionFlags*)ewg_selectionFlags);
}

// Return address of function 'GetDataBrowserSelectionFlags'
void* ewg_get_function_address_GetDataBrowserSelectionFlags (void)
{
	return (void*) GetDataBrowserSelectionFlags;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserPropertyFlags'
// For ise
OSStatus  ewg_function_SetDataBrowserPropertyFlags (ControlRef ewg_browser, DataBrowserPropertyID ewg_property, DataBrowserPropertyFlags ewg_flags)
{
	return SetDataBrowserPropertyFlags ((ControlRef)ewg_browser, (DataBrowserPropertyID)ewg_property, (DataBrowserPropertyFlags)ewg_flags);
}

// Return address of function 'SetDataBrowserPropertyFlags'
void* ewg_get_function_address_SetDataBrowserPropertyFlags (void)
{
	return (void*) SetDataBrowserPropertyFlags;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserPropertyFlags'
// For ise
OSStatus  ewg_function_GetDataBrowserPropertyFlags (ControlRef ewg_browser, DataBrowserPropertyID ewg_property, DataBrowserPropertyFlags *ewg_flags)
{
	return GetDataBrowserPropertyFlags ((ControlRef)ewg_browser, (DataBrowserPropertyID)ewg_property, (DataBrowserPropertyFlags*)ewg_flags);
}

// Return address of function 'GetDataBrowserPropertyFlags'
void* ewg_get_function_address_GetDataBrowserPropertyFlags (void)
{
	return (void*) GetDataBrowserPropertyFlags;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserEditText'
// For ise
OSStatus  ewg_function_SetDataBrowserEditText (ControlRef ewg_browser, CFStringRef ewg_text)
{
	return SetDataBrowserEditText ((ControlRef)ewg_browser, (CFStringRef)ewg_text);
}

// Return address of function 'SetDataBrowserEditText'
void* ewg_get_function_address_SetDataBrowserEditText (void)
{
	return (void*) SetDataBrowserEditText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CopyDataBrowserEditText'
// For ise
OSStatus  ewg_function_CopyDataBrowserEditText (ControlRef ewg_browser, CFStringRef *ewg_text)
{
	return CopyDataBrowserEditText ((ControlRef)ewg_browser, (CFStringRef*)ewg_text);
}

// Return address of function 'CopyDataBrowserEditText'
void* ewg_get_function_address_CopyDataBrowserEditText (void)
{
	return (void*) CopyDataBrowserEditText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserEditText'
// For ise
OSStatus  ewg_function_GetDataBrowserEditText (ControlRef ewg_browser, CFMutableStringRef ewg_text)
{
	return GetDataBrowserEditText ((ControlRef)ewg_browser, (CFMutableStringRef)ewg_text);
}

// Return address of function 'GetDataBrowserEditText'
void* ewg_get_function_address_GetDataBrowserEditText (void)
{
	return (void*) GetDataBrowserEditText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserEditItem'
// For ise
OSStatus  ewg_function_SetDataBrowserEditItem (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property)
{
	return SetDataBrowserEditItem ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property);
}

// Return address of function 'SetDataBrowserEditItem'
void* ewg_get_function_address_SetDataBrowserEditItem (void)
{
	return (void*) SetDataBrowserEditItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserEditItem'
// For ise
OSStatus  ewg_function_GetDataBrowserEditItem (ControlRef ewg_browser, DataBrowserItemID *ewg_item, DataBrowserPropertyID *ewg_property)
{
	return GetDataBrowserEditItem ((ControlRef)ewg_browser, (DataBrowserItemID*)ewg_item, (DataBrowserPropertyID*)ewg_property);
}

// Return address of function 'GetDataBrowserEditItem'
void* ewg_get_function_address_GetDataBrowserEditItem (void)
{
	return (void*) GetDataBrowserEditItem;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemPartBounds'
// For ise
OSStatus  ewg_function_GetDataBrowserItemPartBounds (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, DataBrowserPropertyPart ewg_part, Rect *ewg_bounds)
{
	return GetDataBrowserItemPartBounds ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (DataBrowserPropertyPart)ewg_part, (Rect*)ewg_bounds);
}

// Return address of function 'GetDataBrowserItemPartBounds'
void* ewg_get_function_address_GetDataBrowserItemPartBounds (void)
{
	return (void*) GetDataBrowserItemPartBounds;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataIcon'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataIcon (DataBrowserItemDataRef ewg_itemData, IconRef ewg_theData)
{
	return SetDataBrowserItemDataIcon ((DataBrowserItemDataRef)ewg_itemData, (IconRef)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataIcon'
void* ewg_get_function_address_SetDataBrowserItemDataIcon (void)
{
	return (void*) SetDataBrowserItemDataIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataIcon'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataIcon (DataBrowserItemDataRef ewg_itemData, IconRef *ewg_theData)
{
	return GetDataBrowserItemDataIcon ((DataBrowserItemDataRef)ewg_itemData, (IconRef*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataIcon'
void* ewg_get_function_address_GetDataBrowserItemDataIcon (void)
{
	return (void*) GetDataBrowserItemDataIcon;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataText'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataText (DataBrowserItemDataRef ewg_itemData, CFStringRef ewg_theData)
{
	return SetDataBrowserItemDataText ((DataBrowserItemDataRef)ewg_itemData, (CFStringRef)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataText'
void* ewg_get_function_address_SetDataBrowserItemDataText (void)
{
	return (void*) SetDataBrowserItemDataText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataText'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataText (DataBrowserItemDataRef ewg_itemData, CFStringRef *ewg_theData)
{
	return GetDataBrowserItemDataText ((DataBrowserItemDataRef)ewg_itemData, (CFStringRef*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataText'
void* ewg_get_function_address_GetDataBrowserItemDataText (void)
{
	return (void*) GetDataBrowserItemDataText;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataValue'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataValue (DataBrowserItemDataRef ewg_itemData, SInt32 ewg_theData)
{
	return SetDataBrowserItemDataValue ((DataBrowserItemDataRef)ewg_itemData, (SInt32)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataValue'
void* ewg_get_function_address_SetDataBrowserItemDataValue (void)
{
	return (void*) SetDataBrowserItemDataValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataValue'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataValue (DataBrowserItemDataRef ewg_itemData, SInt32 *ewg_theData)
{
	return GetDataBrowserItemDataValue ((DataBrowserItemDataRef)ewg_itemData, (SInt32*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataValue'
void* ewg_get_function_address_GetDataBrowserItemDataValue (void)
{
	return (void*) GetDataBrowserItemDataValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataMinimum'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataMinimum (DataBrowserItemDataRef ewg_itemData, SInt32 ewg_theData)
{
	return SetDataBrowserItemDataMinimum ((DataBrowserItemDataRef)ewg_itemData, (SInt32)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataMinimum'
void* ewg_get_function_address_SetDataBrowserItemDataMinimum (void)
{
	return (void*) SetDataBrowserItemDataMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataMinimum'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataMinimum (DataBrowserItemDataRef ewg_itemData, SInt32 *ewg_theData)
{
	return GetDataBrowserItemDataMinimum ((DataBrowserItemDataRef)ewg_itemData, (SInt32*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataMinimum'
void* ewg_get_function_address_GetDataBrowserItemDataMinimum (void)
{
	return (void*) GetDataBrowserItemDataMinimum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataMaximum'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataMaximum (DataBrowserItemDataRef ewg_itemData, SInt32 ewg_theData)
{
	return SetDataBrowserItemDataMaximum ((DataBrowserItemDataRef)ewg_itemData, (SInt32)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataMaximum'
void* ewg_get_function_address_SetDataBrowserItemDataMaximum (void)
{
	return (void*) SetDataBrowserItemDataMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataMaximum'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataMaximum (DataBrowserItemDataRef ewg_itemData, SInt32 *ewg_theData)
{
	return GetDataBrowserItemDataMaximum ((DataBrowserItemDataRef)ewg_itemData, (SInt32*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataMaximum'
void* ewg_get_function_address_GetDataBrowserItemDataMaximum (void)
{
	return (void*) GetDataBrowserItemDataMaximum;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataBooleanValue'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataBooleanValue (DataBrowserItemDataRef ewg_itemData, Boolean ewg_theData)
{
	return SetDataBrowserItemDataBooleanValue ((DataBrowserItemDataRef)ewg_itemData, (Boolean)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataBooleanValue'
void* ewg_get_function_address_SetDataBrowserItemDataBooleanValue (void)
{
	return (void*) SetDataBrowserItemDataBooleanValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataBooleanValue'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataBooleanValue (DataBrowserItemDataRef ewg_itemData, Boolean *ewg_theData)
{
	return GetDataBrowserItemDataBooleanValue ((DataBrowserItemDataRef)ewg_itemData, (Boolean*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataBooleanValue'
void* ewg_get_function_address_GetDataBrowserItemDataBooleanValue (void)
{
	return (void*) GetDataBrowserItemDataBooleanValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataMenuRef'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataMenuRef (DataBrowserItemDataRef ewg_itemData, MenuRef ewg_theData)
{
	return SetDataBrowserItemDataMenuRef ((DataBrowserItemDataRef)ewg_itemData, (MenuRef)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataMenuRef'
void* ewg_get_function_address_SetDataBrowserItemDataMenuRef (void)
{
	return (void*) SetDataBrowserItemDataMenuRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataMenuRef'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataMenuRef (DataBrowserItemDataRef ewg_itemData, MenuRef *ewg_theData)
{
	return GetDataBrowserItemDataMenuRef ((DataBrowserItemDataRef)ewg_itemData, (MenuRef*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataMenuRef'
void* ewg_get_function_address_GetDataBrowserItemDataMenuRef (void)
{
	return (void*) GetDataBrowserItemDataMenuRef;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataRGBColor'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataRGBColor (DataBrowserItemDataRef ewg_itemData, RGBColor const *ewg_theData)
{
	return SetDataBrowserItemDataRGBColor ((DataBrowserItemDataRef)ewg_itemData, (RGBColor const*)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataRGBColor'
void* ewg_get_function_address_SetDataBrowserItemDataRGBColor (void)
{
	return (void*) SetDataBrowserItemDataRGBColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataRGBColor'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataRGBColor (DataBrowserItemDataRef ewg_itemData, RGBColor *ewg_theData)
{
	return GetDataBrowserItemDataRGBColor ((DataBrowserItemDataRef)ewg_itemData, (RGBColor*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataRGBColor'
void* ewg_get_function_address_GetDataBrowserItemDataRGBColor (void)
{
	return (void*) GetDataBrowserItemDataRGBColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataDrawState'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataDrawState (DataBrowserItemDataRef ewg_itemData, ThemeDrawState ewg_theData)
{
	return SetDataBrowserItemDataDrawState ((DataBrowserItemDataRef)ewg_itemData, (ThemeDrawState)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataDrawState'
void* ewg_get_function_address_SetDataBrowserItemDataDrawState (void)
{
	return (void*) SetDataBrowserItemDataDrawState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataDrawState'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataDrawState (DataBrowserItemDataRef ewg_itemData, ThemeDrawState *ewg_theData)
{
	return GetDataBrowserItemDataDrawState ((DataBrowserItemDataRef)ewg_itemData, (ThemeDrawState*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataDrawState'
void* ewg_get_function_address_GetDataBrowserItemDataDrawState (void)
{
	return (void*) GetDataBrowserItemDataDrawState;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataButtonValue'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataButtonValue (DataBrowserItemDataRef ewg_itemData, ThemeButtonValue ewg_theData)
{
	return SetDataBrowserItemDataButtonValue ((DataBrowserItemDataRef)ewg_itemData, (ThemeButtonValue)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataButtonValue'
void* ewg_get_function_address_SetDataBrowserItemDataButtonValue (void)
{
	return (void*) SetDataBrowserItemDataButtonValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataButtonValue'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataButtonValue (DataBrowserItemDataRef ewg_itemData, ThemeButtonValue *ewg_theData)
{
	return GetDataBrowserItemDataButtonValue ((DataBrowserItemDataRef)ewg_itemData, (ThemeButtonValue*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataButtonValue'
void* ewg_get_function_address_GetDataBrowserItemDataButtonValue (void)
{
	return (void*) GetDataBrowserItemDataButtonValue;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataIconTransform'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataIconTransform (DataBrowserItemDataRef ewg_itemData, IconTransformType ewg_theData)
{
	return SetDataBrowserItemDataIconTransform ((DataBrowserItemDataRef)ewg_itemData, (IconTransformType)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataIconTransform'
void* ewg_get_function_address_SetDataBrowserItemDataIconTransform (void)
{
	return (void*) SetDataBrowserItemDataIconTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataIconTransform'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataIconTransform (DataBrowserItemDataRef ewg_itemData, IconTransformType *ewg_theData)
{
	return GetDataBrowserItemDataIconTransform ((DataBrowserItemDataRef)ewg_itemData, (IconTransformType*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataIconTransform'
void* ewg_get_function_address_GetDataBrowserItemDataIconTransform (void)
{
	return (void*) GetDataBrowserItemDataIconTransform;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataDateTime'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataDateTime (DataBrowserItemDataRef ewg_itemData, long ewg_theData)
{
	return SetDataBrowserItemDataDateTime ((DataBrowserItemDataRef)ewg_itemData, (long)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataDateTime'
void* ewg_get_function_address_SetDataBrowserItemDataDateTime (void)
{
	return (void*) SetDataBrowserItemDataDateTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataDateTime'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataDateTime (DataBrowserItemDataRef ewg_itemData, long *ewg_theData)
{
	return GetDataBrowserItemDataDateTime ((DataBrowserItemDataRef)ewg_itemData, (long*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataDateTime'
void* ewg_get_function_address_GetDataBrowserItemDataDateTime (void)
{
	return (void*) GetDataBrowserItemDataDateTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataLongDateTime'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataLongDateTime (DataBrowserItemDataRef ewg_itemData, LongDateTime const *ewg_theData)
{
	return SetDataBrowserItemDataLongDateTime ((DataBrowserItemDataRef)ewg_itemData, (LongDateTime const*)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataLongDateTime'
void* ewg_get_function_address_SetDataBrowserItemDataLongDateTime (void)
{
	return (void*) SetDataBrowserItemDataLongDateTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataLongDateTime'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataLongDateTime (DataBrowserItemDataRef ewg_itemData, LongDateTime *ewg_theData)
{
	return GetDataBrowserItemDataLongDateTime ((DataBrowserItemDataRef)ewg_itemData, (LongDateTime*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataLongDateTime'
void* ewg_get_function_address_GetDataBrowserItemDataLongDateTime (void)
{
	return (void*) GetDataBrowserItemDataLongDateTime;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserItemDataItemID'
// For ise
OSStatus  ewg_function_SetDataBrowserItemDataItemID (DataBrowserItemDataRef ewg_itemData, DataBrowserItemID ewg_theData)
{
	return SetDataBrowserItemDataItemID ((DataBrowserItemDataRef)ewg_itemData, (DataBrowserItemID)ewg_theData);
}

// Return address of function 'SetDataBrowserItemDataItemID'
void* ewg_get_function_address_SetDataBrowserItemDataItemID (void)
{
	return (void*) SetDataBrowserItemDataItemID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataItemID'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataItemID (DataBrowserItemDataRef ewg_itemData, DataBrowserItemID *ewg_theData)
{
	return GetDataBrowserItemDataItemID ((DataBrowserItemDataRef)ewg_itemData, (DataBrowserItemID*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataItemID'
void* ewg_get_function_address_GetDataBrowserItemDataItemID (void)
{
	return (void*) GetDataBrowserItemDataItemID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserItemDataProperty'
// For ise
OSStatus  ewg_function_GetDataBrowserItemDataProperty (DataBrowserItemDataRef ewg_itemData, DataBrowserPropertyID *ewg_theData)
{
	return GetDataBrowserItemDataProperty ((DataBrowserItemDataRef)ewg_itemData, (DataBrowserPropertyID*)ewg_theData);
}

// Return address of function 'GetDataBrowserItemDataProperty'
void* ewg_get_function_address_GetDataBrowserItemDataProperty (void)
{
	return (void*) GetDataBrowserItemDataProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemDataUPP'
// For ise
DataBrowserItemDataUPP  ewg_function_NewDataBrowserItemDataUPP (DataBrowserItemDataProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemDataUPP ((DataBrowserItemDataProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemDataUPP'
void* ewg_get_function_address_NewDataBrowserItemDataUPP (void)
{
	return (void*) NewDataBrowserItemDataUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemCompareUPP'
// For ise
DataBrowserItemCompareUPP  ewg_function_NewDataBrowserItemCompareUPP (DataBrowserItemCompareProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemCompareUPP ((DataBrowserItemCompareProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemCompareUPP'
void* ewg_get_function_address_NewDataBrowserItemCompareUPP (void)
{
	return (void*) NewDataBrowserItemCompareUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemNotificationWithItemUPP'
// For ise
DataBrowserItemNotificationWithItemUPP  ewg_function_NewDataBrowserItemNotificationWithItemUPP (DataBrowserItemNotificationWithItemProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemNotificationWithItemUPP ((DataBrowserItemNotificationWithItemProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemNotificationWithItemUPP'
void* ewg_get_function_address_NewDataBrowserItemNotificationWithItemUPP (void)
{
	return (void*) NewDataBrowserItemNotificationWithItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemNotificationUPP'
// For ise
DataBrowserItemNotificationUPP  ewg_function_NewDataBrowserItemNotificationUPP (DataBrowserItemNotificationProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemNotificationUPP ((DataBrowserItemNotificationProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemNotificationUPP'
void* ewg_get_function_address_NewDataBrowserItemNotificationUPP (void)
{
	return (void*) NewDataBrowserItemNotificationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserAddDragItemUPP'
// For ise
DataBrowserAddDragItemUPP  ewg_function_NewDataBrowserAddDragItemUPP (DataBrowserAddDragItemProcPtr ewg_userRoutine)
{
	return NewDataBrowserAddDragItemUPP ((DataBrowserAddDragItemProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserAddDragItemUPP'
void* ewg_get_function_address_NewDataBrowserAddDragItemUPP (void)
{
	return (void*) NewDataBrowserAddDragItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserAcceptDragUPP'
// For ise
DataBrowserAcceptDragUPP  ewg_function_NewDataBrowserAcceptDragUPP (DataBrowserAcceptDragProcPtr ewg_userRoutine)
{
	return NewDataBrowserAcceptDragUPP ((DataBrowserAcceptDragProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserAcceptDragUPP'
void* ewg_get_function_address_NewDataBrowserAcceptDragUPP (void)
{
	return (void*) NewDataBrowserAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserReceiveDragUPP'
// For ise
DataBrowserReceiveDragUPP  ewg_function_NewDataBrowserReceiveDragUPP (DataBrowserReceiveDragProcPtr ewg_userRoutine)
{
	return NewDataBrowserReceiveDragUPP ((DataBrowserReceiveDragProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserReceiveDragUPP'
void* ewg_get_function_address_NewDataBrowserReceiveDragUPP (void)
{
	return (void*) NewDataBrowserReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserPostProcessDragUPP'
// For ise
DataBrowserPostProcessDragUPP  ewg_function_NewDataBrowserPostProcessDragUPP (DataBrowserPostProcessDragProcPtr ewg_userRoutine)
{
	return NewDataBrowserPostProcessDragUPP ((DataBrowserPostProcessDragProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserPostProcessDragUPP'
void* ewg_get_function_address_NewDataBrowserPostProcessDragUPP (void)
{
	return (void*) NewDataBrowserPostProcessDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserGetContextualMenuUPP'
// For ise
DataBrowserGetContextualMenuUPP  ewg_function_NewDataBrowserGetContextualMenuUPP (DataBrowserGetContextualMenuProcPtr ewg_userRoutine)
{
	return NewDataBrowserGetContextualMenuUPP ((DataBrowserGetContextualMenuProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserGetContextualMenuUPP'
void* ewg_get_function_address_NewDataBrowserGetContextualMenuUPP (void)
{
	return (void*) NewDataBrowserGetContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserSelectContextualMenuUPP'
// For ise
DataBrowserSelectContextualMenuUPP  ewg_function_NewDataBrowserSelectContextualMenuUPP (DataBrowserSelectContextualMenuProcPtr ewg_userRoutine)
{
	return NewDataBrowserSelectContextualMenuUPP ((DataBrowserSelectContextualMenuProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserSelectContextualMenuUPP'
void* ewg_get_function_address_NewDataBrowserSelectContextualMenuUPP (void)
{
	return (void*) NewDataBrowserSelectContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemHelpContentUPP'
// For ise
DataBrowserItemHelpContentUPP  ewg_function_NewDataBrowserItemHelpContentUPP (DataBrowserItemHelpContentProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemHelpContentUPP ((DataBrowserItemHelpContentProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemHelpContentUPP'
void* ewg_get_function_address_NewDataBrowserItemHelpContentUPP (void)
{
	return (void*) NewDataBrowserItemHelpContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemDataUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemDataUPP (DataBrowserItemDataUPP ewg_userUPP)
{
	DisposeDataBrowserItemDataUPP ((DataBrowserItemDataUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemDataUPP'
void* ewg_get_function_address_DisposeDataBrowserItemDataUPP (void)
{
	return (void*) DisposeDataBrowserItemDataUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemCompareUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemCompareUPP (DataBrowserItemCompareUPP ewg_userUPP)
{
	DisposeDataBrowserItemCompareUPP ((DataBrowserItemCompareUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemCompareUPP'
void* ewg_get_function_address_DisposeDataBrowserItemCompareUPP (void)
{
	return (void*) DisposeDataBrowserItemCompareUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemNotificationWithItemUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemNotificationWithItemUPP (DataBrowserItemNotificationWithItemUPP ewg_userUPP)
{
	DisposeDataBrowserItemNotificationWithItemUPP ((DataBrowserItemNotificationWithItemUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemNotificationWithItemUPP'
void* ewg_get_function_address_DisposeDataBrowserItemNotificationWithItemUPP (void)
{
	return (void*) DisposeDataBrowserItemNotificationWithItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemNotificationUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemNotificationUPP (DataBrowserItemNotificationUPP ewg_userUPP)
{
	DisposeDataBrowserItemNotificationUPP ((DataBrowserItemNotificationUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemNotificationUPP'
void* ewg_get_function_address_DisposeDataBrowserItemNotificationUPP (void)
{
	return (void*) DisposeDataBrowserItemNotificationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserAddDragItemUPP'
// For ise
void  ewg_function_DisposeDataBrowserAddDragItemUPP (DataBrowserAddDragItemUPP ewg_userUPP)
{
	DisposeDataBrowserAddDragItemUPP ((DataBrowserAddDragItemUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserAddDragItemUPP'
void* ewg_get_function_address_DisposeDataBrowserAddDragItemUPP (void)
{
	return (void*) DisposeDataBrowserAddDragItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserAcceptDragUPP'
// For ise
void  ewg_function_DisposeDataBrowserAcceptDragUPP (DataBrowserAcceptDragUPP ewg_userUPP)
{
	DisposeDataBrowserAcceptDragUPP ((DataBrowserAcceptDragUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserAcceptDragUPP'
void* ewg_get_function_address_DisposeDataBrowserAcceptDragUPP (void)
{
	return (void*) DisposeDataBrowserAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserReceiveDragUPP'
// For ise
void  ewg_function_DisposeDataBrowserReceiveDragUPP (DataBrowserReceiveDragUPP ewg_userUPP)
{
	DisposeDataBrowserReceiveDragUPP ((DataBrowserReceiveDragUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserReceiveDragUPP'
void* ewg_get_function_address_DisposeDataBrowserReceiveDragUPP (void)
{
	return (void*) DisposeDataBrowserReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserPostProcessDragUPP'
// For ise
void  ewg_function_DisposeDataBrowserPostProcessDragUPP (DataBrowserPostProcessDragUPP ewg_userUPP)
{
	DisposeDataBrowserPostProcessDragUPP ((DataBrowserPostProcessDragUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserPostProcessDragUPP'
void* ewg_get_function_address_DisposeDataBrowserPostProcessDragUPP (void)
{
	return (void*) DisposeDataBrowserPostProcessDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserGetContextualMenuUPP'
// For ise
void  ewg_function_DisposeDataBrowserGetContextualMenuUPP (DataBrowserGetContextualMenuUPP ewg_userUPP)
{
	DisposeDataBrowserGetContextualMenuUPP ((DataBrowserGetContextualMenuUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserGetContextualMenuUPP'
void* ewg_get_function_address_DisposeDataBrowserGetContextualMenuUPP (void)
{
	return (void*) DisposeDataBrowserGetContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserSelectContextualMenuUPP'
// For ise
void  ewg_function_DisposeDataBrowserSelectContextualMenuUPP (DataBrowserSelectContextualMenuUPP ewg_userUPP)
{
	DisposeDataBrowserSelectContextualMenuUPP ((DataBrowserSelectContextualMenuUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserSelectContextualMenuUPP'
void* ewg_get_function_address_DisposeDataBrowserSelectContextualMenuUPP (void)
{
	return (void*) DisposeDataBrowserSelectContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemHelpContentUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemHelpContentUPP (DataBrowserItemHelpContentUPP ewg_userUPP)
{
	DisposeDataBrowserItemHelpContentUPP ((DataBrowserItemHelpContentUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemHelpContentUPP'
void* ewg_get_function_address_DisposeDataBrowserItemHelpContentUPP (void)
{
	return (void*) DisposeDataBrowserItemHelpContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemDataUPP'
// For ise
OSStatus  ewg_function_InvokeDataBrowserItemDataUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, DataBrowserItemDataRef ewg_itemData, Boolean ewg_setValue, DataBrowserItemDataUPP ewg_userUPP)
{
	return InvokeDataBrowserItemDataUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (DataBrowserItemDataRef)ewg_itemData, (Boolean)ewg_setValue, (DataBrowserItemDataUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemDataUPP'
void* ewg_get_function_address_InvokeDataBrowserItemDataUPP (void)
{
	return (void*) InvokeDataBrowserItemDataUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemCompareUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserItemCompareUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemOne, DataBrowserItemID ewg_itemTwo, DataBrowserPropertyID ewg_sortProperty, DataBrowserItemCompareUPP ewg_userUPP)
{
	return InvokeDataBrowserItemCompareUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemOne, (DataBrowserItemID)ewg_itemTwo, (DataBrowserPropertyID)ewg_sortProperty, (DataBrowserItemCompareUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemCompareUPP'
void* ewg_get_function_address_InvokeDataBrowserItemCompareUPP (void)
{
	return (void*) InvokeDataBrowserItemCompareUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemNotificationWithItemUPP'
// For ise
void  ewg_function_InvokeDataBrowserItemNotificationWithItemUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserItemNotification ewg_message, DataBrowserItemDataRef ewg_itemData, DataBrowserItemNotificationWithItemUPP ewg_userUPP)
{
	InvokeDataBrowserItemNotificationWithItemUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserItemNotification)ewg_message, (DataBrowserItemDataRef)ewg_itemData, (DataBrowserItemNotificationWithItemUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemNotificationWithItemUPP'
void* ewg_get_function_address_InvokeDataBrowserItemNotificationWithItemUPP (void)
{
	return (void*) InvokeDataBrowserItemNotificationWithItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemNotificationUPP'
// For ise
void  ewg_function_InvokeDataBrowserItemNotificationUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserItemNotification ewg_message, DataBrowserItemNotificationUPP ewg_userUPP)
{
	InvokeDataBrowserItemNotificationUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserItemNotification)ewg_message, (DataBrowserItemNotificationUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemNotificationUPP'
void* ewg_get_function_address_InvokeDataBrowserItemNotificationUPP (void)
{
	return (void*) InvokeDataBrowserItemNotificationUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserAddDragItemUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserAddDragItemUPP (ControlRef ewg_browser, DragReference ewg_theDrag, DataBrowserItemID ewg_item, ItemReference *ewg_itemRef, DataBrowserAddDragItemUPP ewg_userUPP)
{
	return InvokeDataBrowserAddDragItemUPP ((ControlRef)ewg_browser, (DragReference)ewg_theDrag, (DataBrowserItemID)ewg_item, (ItemReference*)ewg_itemRef, (DataBrowserAddDragItemUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserAddDragItemUPP'
void* ewg_get_function_address_InvokeDataBrowserAddDragItemUPP (void)
{
	return (void*) InvokeDataBrowserAddDragItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserAcceptDragUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserAcceptDragUPP (ControlRef ewg_browser, DragReference ewg_theDrag, DataBrowserItemID ewg_item, DataBrowserAcceptDragUPP ewg_userUPP)
{
	return InvokeDataBrowserAcceptDragUPP ((ControlRef)ewg_browser, (DragReference)ewg_theDrag, (DataBrowserItemID)ewg_item, (DataBrowserAcceptDragUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserAcceptDragUPP'
void* ewg_get_function_address_InvokeDataBrowserAcceptDragUPP (void)
{
	return (void*) InvokeDataBrowserAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserReceiveDragUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserReceiveDragUPP (ControlRef ewg_browser, DragReference ewg_theDrag, DataBrowserItemID ewg_item, DataBrowserReceiveDragUPP ewg_userUPP)
{
	return InvokeDataBrowserReceiveDragUPP ((ControlRef)ewg_browser, (DragReference)ewg_theDrag, (DataBrowserItemID)ewg_item, (DataBrowserReceiveDragUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserReceiveDragUPP'
void* ewg_get_function_address_InvokeDataBrowserReceiveDragUPP (void)
{
	return (void*) InvokeDataBrowserReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserPostProcessDragUPP'
// For ise
void  ewg_function_InvokeDataBrowserPostProcessDragUPP (ControlRef ewg_browser, DragReference ewg_theDrag, OSStatus ewg_trackDragResult, DataBrowserPostProcessDragUPP ewg_userUPP)
{
	InvokeDataBrowserPostProcessDragUPP ((ControlRef)ewg_browser, (DragReference)ewg_theDrag, (OSStatus)ewg_trackDragResult, (DataBrowserPostProcessDragUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserPostProcessDragUPP'
void* ewg_get_function_address_InvokeDataBrowserPostProcessDragUPP (void)
{
	return (void*) InvokeDataBrowserPostProcessDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserGetContextualMenuUPP'
// For ise
void  ewg_function_InvokeDataBrowserGetContextualMenuUPP (ControlRef ewg_browser, MenuRef *ewg_menu, UInt32 *ewg_helpType, CFStringRef *ewg_helpItemString, AEDesc *ewg_selection, DataBrowserGetContextualMenuUPP ewg_userUPP)
{
	InvokeDataBrowserGetContextualMenuUPP ((ControlRef)ewg_browser, (MenuRef*)ewg_menu, (UInt32*)ewg_helpType, (CFStringRef*)ewg_helpItemString, (AEDesc*)ewg_selection, (DataBrowserGetContextualMenuUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserGetContextualMenuUPP'
void* ewg_get_function_address_InvokeDataBrowserGetContextualMenuUPP (void)
{
	return (void*) InvokeDataBrowserGetContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserSelectContextualMenuUPP'
// For ise
void  ewg_function_InvokeDataBrowserSelectContextualMenuUPP (ControlRef ewg_browser, MenuRef ewg_menu, UInt32 ewg_selectionType, SInt16 ewg_menuID, MenuItemIndex ewg_menuItem, DataBrowserSelectContextualMenuUPP ewg_userUPP)
{
	InvokeDataBrowserSelectContextualMenuUPP ((ControlRef)ewg_browser, (MenuRef)ewg_menu, (UInt32)ewg_selectionType, (SInt16)ewg_menuID, (MenuItemIndex)ewg_menuItem, (DataBrowserSelectContextualMenuUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserSelectContextualMenuUPP'
void* ewg_get_function_address_InvokeDataBrowserSelectContextualMenuUPP (void)
{
	return (void*) InvokeDataBrowserSelectContextualMenuUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemHelpContentUPP'
// For ise
void  ewg_function_InvokeDataBrowserItemHelpContentUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent, DataBrowserItemHelpContentUPP ewg_userUPP)
{
	InvokeDataBrowserItemHelpContentUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent, (DataBrowserItemHelpContentUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemHelpContentUPP'
void* ewg_get_function_address_InvokeDataBrowserItemHelpContentUPP (void)
{
	return (void*) InvokeDataBrowserItemHelpContentUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InitDataBrowserCallbacks'
// For ise
OSStatus  ewg_function_InitDataBrowserCallbacks (DataBrowserCallbacks *ewg_callbacks)
{
	return InitDataBrowserCallbacks ((DataBrowserCallbacks*)ewg_callbacks);
}

// Return address of function 'InitDataBrowserCallbacks'
void* ewg_get_function_address_InitDataBrowserCallbacks (void)
{
	return (void*) InitDataBrowserCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserCallbacks'
// For ise
OSStatus  ewg_function_GetDataBrowserCallbacks (ControlRef ewg_browser, DataBrowserCallbacks *ewg_callbacks)
{
	return GetDataBrowserCallbacks ((ControlRef)ewg_browser, (DataBrowserCallbacks*)ewg_callbacks);
}

// Return address of function 'GetDataBrowserCallbacks'
void* ewg_get_function_address_GetDataBrowserCallbacks (void)
{
	return (void*) GetDataBrowserCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserCallbacks'
// For ise
OSStatus  ewg_function_SetDataBrowserCallbacks (ControlRef ewg_browser, DataBrowserCallbacks const *ewg_callbacks)
{
	return SetDataBrowserCallbacks ((ControlRef)ewg_browser, (DataBrowserCallbacks const*)ewg_callbacks);
}

// Return address of function 'SetDataBrowserCallbacks'
void* ewg_get_function_address_SetDataBrowserCallbacks (void)
{
	return (void*) SetDataBrowserCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserDrawItemUPP'
// For ise
DataBrowserDrawItemUPP  ewg_function_NewDataBrowserDrawItemUPP (DataBrowserDrawItemProcPtr ewg_userRoutine)
{
	return NewDataBrowserDrawItemUPP ((DataBrowserDrawItemProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserDrawItemUPP'
void* ewg_get_function_address_NewDataBrowserDrawItemUPP (void)
{
	return (void*) NewDataBrowserDrawItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserEditItemUPP'
// For ise
DataBrowserEditItemUPP  ewg_function_NewDataBrowserEditItemUPP (DataBrowserEditItemProcPtr ewg_userRoutine)
{
	return NewDataBrowserEditItemUPP ((DataBrowserEditItemProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserEditItemUPP'
void* ewg_get_function_address_NewDataBrowserEditItemUPP (void)
{
	return (void*) NewDataBrowserEditItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserHitTestUPP'
// For ise
DataBrowserHitTestUPP  ewg_function_NewDataBrowserHitTestUPP (DataBrowserHitTestProcPtr ewg_userRoutine)
{
	return NewDataBrowserHitTestUPP ((DataBrowserHitTestProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserHitTestUPP'
void* ewg_get_function_address_NewDataBrowserHitTestUPP (void)
{
	return (void*) NewDataBrowserHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserTrackingUPP'
// For ise
DataBrowserTrackingUPP  ewg_function_NewDataBrowserTrackingUPP (DataBrowserTrackingProcPtr ewg_userRoutine)
{
	return NewDataBrowserTrackingUPP ((DataBrowserTrackingProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserTrackingUPP'
void* ewg_get_function_address_NewDataBrowserTrackingUPP (void)
{
	return (void*) NewDataBrowserTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemDragRgnUPP'
// For ise
DataBrowserItemDragRgnUPP  ewg_function_NewDataBrowserItemDragRgnUPP (DataBrowserItemDragRgnProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemDragRgnUPP ((DataBrowserItemDragRgnProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemDragRgnUPP'
void* ewg_get_function_address_NewDataBrowserItemDragRgnUPP (void)
{
	return (void*) NewDataBrowserItemDragRgnUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemAcceptDragUPP'
// For ise
DataBrowserItemAcceptDragUPP  ewg_function_NewDataBrowserItemAcceptDragUPP (DataBrowserItemAcceptDragProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemAcceptDragUPP ((DataBrowserItemAcceptDragProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemAcceptDragUPP'
void* ewg_get_function_address_NewDataBrowserItemAcceptDragUPP (void)
{
	return (void*) NewDataBrowserItemAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewDataBrowserItemReceiveDragUPP'
// For ise
DataBrowserItemReceiveDragUPP  ewg_function_NewDataBrowserItemReceiveDragUPP (DataBrowserItemReceiveDragProcPtr ewg_userRoutine)
{
	return NewDataBrowserItemReceiveDragUPP ((DataBrowserItemReceiveDragProcPtr)ewg_userRoutine);
}

// Return address of function 'NewDataBrowserItemReceiveDragUPP'
void* ewg_get_function_address_NewDataBrowserItemReceiveDragUPP (void)
{
	return (void*) NewDataBrowserItemReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserDrawItemUPP'
// For ise
void  ewg_function_DisposeDataBrowserDrawItemUPP (DataBrowserDrawItemUPP ewg_userUPP)
{
	DisposeDataBrowserDrawItemUPP ((DataBrowserDrawItemUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserDrawItemUPP'
void* ewg_get_function_address_DisposeDataBrowserDrawItemUPP (void)
{
	return (void*) DisposeDataBrowserDrawItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserEditItemUPP'
// For ise
void  ewg_function_DisposeDataBrowserEditItemUPP (DataBrowserEditItemUPP ewg_userUPP)
{
	DisposeDataBrowserEditItemUPP ((DataBrowserEditItemUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserEditItemUPP'
void* ewg_get_function_address_DisposeDataBrowserEditItemUPP (void)
{
	return (void*) DisposeDataBrowserEditItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserHitTestUPP'
// For ise
void  ewg_function_DisposeDataBrowserHitTestUPP (DataBrowserHitTestUPP ewg_userUPP)
{
	DisposeDataBrowserHitTestUPP ((DataBrowserHitTestUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserHitTestUPP'
void* ewg_get_function_address_DisposeDataBrowserHitTestUPP (void)
{
	return (void*) DisposeDataBrowserHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserTrackingUPP'
// For ise
void  ewg_function_DisposeDataBrowserTrackingUPP (DataBrowserTrackingUPP ewg_userUPP)
{
	DisposeDataBrowserTrackingUPP ((DataBrowserTrackingUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserTrackingUPP'
void* ewg_get_function_address_DisposeDataBrowserTrackingUPP (void)
{
	return (void*) DisposeDataBrowserTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemDragRgnUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemDragRgnUPP (DataBrowserItemDragRgnUPP ewg_userUPP)
{
	DisposeDataBrowserItemDragRgnUPP ((DataBrowserItemDragRgnUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemDragRgnUPP'
void* ewg_get_function_address_DisposeDataBrowserItemDragRgnUPP (void)
{
	return (void*) DisposeDataBrowserItemDragRgnUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemAcceptDragUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemAcceptDragUPP (DataBrowserItemAcceptDragUPP ewg_userUPP)
{
	DisposeDataBrowserItemAcceptDragUPP ((DataBrowserItemAcceptDragUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemAcceptDragUPP'
void* ewg_get_function_address_DisposeDataBrowserItemAcceptDragUPP (void)
{
	return (void*) DisposeDataBrowserItemAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeDataBrowserItemReceiveDragUPP'
// For ise
void  ewg_function_DisposeDataBrowserItemReceiveDragUPP (DataBrowserItemReceiveDragUPP ewg_userUPP)
{
	DisposeDataBrowserItemReceiveDragUPP ((DataBrowserItemReceiveDragUPP)ewg_userUPP);
}

// Return address of function 'DisposeDataBrowserItemReceiveDragUPP'
void* ewg_get_function_address_DisposeDataBrowserItemReceiveDragUPP (void)
{
	return (void*) DisposeDataBrowserItemReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserDrawItemUPP'
// For ise
void  ewg_function_InvokeDataBrowserDrawItemUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, DataBrowserItemState ewg_itemState, Rect const *ewg_theRect, SInt16 ewg_gdDepth, Boolean ewg_colorDevice, DataBrowserDrawItemUPP ewg_userUPP)
{
	InvokeDataBrowserDrawItemUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (DataBrowserItemState)ewg_itemState, (Rect const*)ewg_theRect, (SInt16)ewg_gdDepth, (Boolean)ewg_colorDevice, (DataBrowserDrawItemUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserDrawItemUPP'
void* ewg_get_function_address_InvokeDataBrowserDrawItemUPP (void)
{
	return (void*) InvokeDataBrowserDrawItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserEditItemUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserEditItemUPP (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, CFStringRef ewg_theString, Rect *ewg_maxEditTextRect, Boolean *ewg_shrinkToFit, DataBrowserEditItemUPP ewg_userUPP)
{
	return InvokeDataBrowserEditItemUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (CFStringRef)ewg_theString, (Rect*)ewg_maxEditTextRect, (Boolean*)ewg_shrinkToFit, (DataBrowserEditItemUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserEditItemUPP'
void* ewg_get_function_address_InvokeDataBrowserEditItemUPP (void)
{
	return (void*) InvokeDataBrowserEditItemUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserHitTestUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserHitTestUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, Rect const *ewg_mouseRect, DataBrowserHitTestUPP ewg_userUPP)
{
	return InvokeDataBrowserHitTestUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (Rect const*)ewg_mouseRect, (DataBrowserHitTestUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserHitTestUPP'
void* ewg_get_function_address_InvokeDataBrowserHitTestUPP (void)
{
	return (void*) InvokeDataBrowserHitTestUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserTrackingUPP'
// For ise
DataBrowserTrackingResult  ewg_function_InvokeDataBrowserTrackingUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, Point *ewg_startPt, EventModifiers ewg_modifiers, DataBrowserTrackingUPP ewg_userUPP)
{
	return InvokeDataBrowserTrackingUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, *(Point*)ewg_startPt, (EventModifiers)ewg_modifiers, (DataBrowserTrackingUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserTrackingUPP'
void* ewg_get_function_address_InvokeDataBrowserTrackingUPP (void)
{
	return (void*) InvokeDataBrowserTrackingUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemDragRgnUPP'
// For ise
void  ewg_function_InvokeDataBrowserItemDragRgnUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, RgnHandle ewg_dragRgn, DataBrowserItemDragRgnUPP ewg_userUPP)
{
	InvokeDataBrowserItemDragRgnUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (RgnHandle)ewg_dragRgn, (DataBrowserItemDragRgnUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemDragRgnUPP'
void* ewg_get_function_address_InvokeDataBrowserItemDragRgnUPP (void)
{
	return (void*) InvokeDataBrowserItemDragRgnUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemAcceptDragUPP'
// For ise
DataBrowserDragFlags  ewg_function_InvokeDataBrowserItemAcceptDragUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, DragReference ewg_theDrag, DataBrowserItemAcceptDragUPP ewg_userUPP)
{
	return InvokeDataBrowserItemAcceptDragUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (DragReference)ewg_theDrag, (DataBrowserItemAcceptDragUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemAcceptDragUPP'
void* ewg_get_function_address_InvokeDataBrowserItemAcceptDragUPP (void)
{
	return (void*) InvokeDataBrowserItemAcceptDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeDataBrowserItemReceiveDragUPP'
// For ise
Boolean  ewg_function_InvokeDataBrowserItemReceiveDragUPP (ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, DataBrowserDragFlags ewg_dragFlags, DragReference ewg_theDrag, DataBrowserItemReceiveDragUPP ewg_userUPP)
{
	return InvokeDataBrowserItemReceiveDragUPP ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (DataBrowserDragFlags)ewg_dragFlags, (DragReference)ewg_theDrag, (DataBrowserItemReceiveDragUPP)ewg_userUPP);
}

// Return address of function 'InvokeDataBrowserItemReceiveDragUPP'
void* ewg_get_function_address_InvokeDataBrowserItemReceiveDragUPP (void)
{
	return (void*) InvokeDataBrowserItemReceiveDragUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InitDataBrowserCustomCallbacks'
// For ise
OSStatus  ewg_function_InitDataBrowserCustomCallbacks (DataBrowserCustomCallbacks *ewg_callbacks)
{
	return InitDataBrowserCustomCallbacks ((DataBrowserCustomCallbacks*)ewg_callbacks);
}

// Return address of function 'InitDataBrowserCustomCallbacks'
void* ewg_get_function_address_InitDataBrowserCustomCallbacks (void)
{
	return (void*) InitDataBrowserCustomCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserCustomCallbacks'
// For ise
OSStatus  ewg_function_GetDataBrowserCustomCallbacks (ControlRef ewg_browser, DataBrowserCustomCallbacks *ewg_callbacks)
{
	return GetDataBrowserCustomCallbacks ((ControlRef)ewg_browser, (DataBrowserCustomCallbacks*)ewg_callbacks);
}

// Return address of function 'GetDataBrowserCustomCallbacks'
void* ewg_get_function_address_GetDataBrowserCustomCallbacks (void)
{
	return (void*) GetDataBrowserCustomCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserCustomCallbacks'
// For ise
OSStatus  ewg_function_SetDataBrowserCustomCallbacks (ControlRef ewg_browser, DataBrowserCustomCallbacks const *ewg_callbacks)
{
	return SetDataBrowserCustomCallbacks ((ControlRef)ewg_browser, (DataBrowserCustomCallbacks const*)ewg_callbacks);
}

// Return address of function 'SetDataBrowserCustomCallbacks'
void* ewg_get_function_address_SetDataBrowserCustomCallbacks (void)
{
	return (void*) SetDataBrowserCustomCallbacks;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RemoveDataBrowserTableViewColumn'
// For ise
OSStatus  ewg_function_RemoveDataBrowserTableViewColumn (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column)
{
	return RemoveDataBrowserTableViewColumn ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column);
}

// Return address of function 'RemoveDataBrowserTableViewColumn'
void* ewg_get_function_address_RemoveDataBrowserTableViewColumn (void)
{
	return (void*) RemoveDataBrowserTableViewColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewColumnCount'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewColumnCount (ControlRef ewg_browser, UInt32 *ewg_numColumns)
{
	return GetDataBrowserTableViewColumnCount ((ControlRef)ewg_browser, (UInt32*)ewg_numColumns);
}

// Return address of function 'GetDataBrowserTableViewColumnCount'
void* ewg_get_function_address_GetDataBrowserTableViewColumnCount (void)
{
	return (void*) GetDataBrowserTableViewColumnCount;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewHiliteStyle'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewHiliteStyle (ControlRef ewg_browser, DataBrowserTableViewHiliteStyle ewg_hiliteStyle)
{
	return SetDataBrowserTableViewHiliteStyle ((ControlRef)ewg_browser, (DataBrowserTableViewHiliteStyle)ewg_hiliteStyle);
}

// Return address of function 'SetDataBrowserTableViewHiliteStyle'
void* ewg_get_function_address_SetDataBrowserTableViewHiliteStyle (void)
{
	return (void*) SetDataBrowserTableViewHiliteStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewHiliteStyle'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewHiliteStyle (ControlRef ewg_browser, DataBrowserTableViewHiliteStyle *ewg_hiliteStyle)
{
	return GetDataBrowserTableViewHiliteStyle ((ControlRef)ewg_browser, (DataBrowserTableViewHiliteStyle*)ewg_hiliteStyle);
}

// Return address of function 'GetDataBrowserTableViewHiliteStyle'
void* ewg_get_function_address_GetDataBrowserTableViewHiliteStyle (void)
{
	return (void*) GetDataBrowserTableViewHiliteStyle;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewRowHeight'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewRowHeight (ControlRef ewg_browser, UInt16 ewg_height)
{
	return SetDataBrowserTableViewRowHeight ((ControlRef)ewg_browser, (UInt16)ewg_height);
}

// Return address of function 'SetDataBrowserTableViewRowHeight'
void* ewg_get_function_address_SetDataBrowserTableViewRowHeight (void)
{
	return (void*) SetDataBrowserTableViewRowHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewRowHeight'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewRowHeight (ControlRef ewg_browser, UInt16 *ewg_height)
{
	return GetDataBrowserTableViewRowHeight ((ControlRef)ewg_browser, (UInt16*)ewg_height);
}

// Return address of function 'GetDataBrowserTableViewRowHeight'
void* ewg_get_function_address_GetDataBrowserTableViewRowHeight (void)
{
	return (void*) GetDataBrowserTableViewRowHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewColumnWidth'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewColumnWidth (ControlRef ewg_browser, UInt16 ewg_width)
{
	return SetDataBrowserTableViewColumnWidth ((ControlRef)ewg_browser, (UInt16)ewg_width);
}

// Return address of function 'SetDataBrowserTableViewColumnWidth'
void* ewg_get_function_address_SetDataBrowserTableViewColumnWidth (void)
{
	return (void*) SetDataBrowserTableViewColumnWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewColumnWidth'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewColumnWidth (ControlRef ewg_browser, UInt16 *ewg_width)
{
	return GetDataBrowserTableViewColumnWidth ((ControlRef)ewg_browser, (UInt16*)ewg_width);
}

// Return address of function 'GetDataBrowserTableViewColumnWidth'
void* ewg_get_function_address_GetDataBrowserTableViewColumnWidth (void)
{
	return (void*) GetDataBrowserTableViewColumnWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewItemRowHeight'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewItemRowHeight (ControlRef ewg_browser, DataBrowserItemID ewg_item, UInt16 ewg_height)
{
	return SetDataBrowserTableViewItemRowHeight ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (UInt16)ewg_height);
}

// Return address of function 'SetDataBrowserTableViewItemRowHeight'
void* ewg_get_function_address_SetDataBrowserTableViewItemRowHeight (void)
{
	return (void*) SetDataBrowserTableViewItemRowHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewItemRowHeight'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewItemRowHeight (ControlRef ewg_browser, DataBrowserItemID ewg_item, UInt16 *ewg_height)
{
	return GetDataBrowserTableViewItemRowHeight ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (UInt16*)ewg_height);
}

// Return address of function 'GetDataBrowserTableViewItemRowHeight'
void* ewg_get_function_address_GetDataBrowserTableViewItemRowHeight (void)
{
	return (void*) GetDataBrowserTableViewItemRowHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewNamedColumnWidth'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewNamedColumnWidth (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, UInt16 ewg_width)
{
	return SetDataBrowserTableViewNamedColumnWidth ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (UInt16)ewg_width);
}

// Return address of function 'SetDataBrowserTableViewNamedColumnWidth'
void* ewg_get_function_address_SetDataBrowserTableViewNamedColumnWidth (void)
{
	return (void*) SetDataBrowserTableViewNamedColumnWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewNamedColumnWidth'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewNamedColumnWidth (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, UInt16 *ewg_width)
{
	return GetDataBrowserTableViewNamedColumnWidth ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (UInt16*)ewg_width);
}

// Return address of function 'GetDataBrowserTableViewNamedColumnWidth'
void* ewg_get_function_address_GetDataBrowserTableViewNamedColumnWidth (void)
{
	return (void*) GetDataBrowserTableViewNamedColumnWidth;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewGeometry'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewGeometry (ControlRef ewg_browser, Boolean ewg_variableWidthColumns, Boolean ewg_variableHeightRows)
{
	return SetDataBrowserTableViewGeometry ((ControlRef)ewg_browser, (Boolean)ewg_variableWidthColumns, (Boolean)ewg_variableHeightRows);
}

// Return address of function 'SetDataBrowserTableViewGeometry'
void* ewg_get_function_address_SetDataBrowserTableViewGeometry (void)
{
	return (void*) SetDataBrowserTableViewGeometry;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewGeometry'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewGeometry (ControlRef ewg_browser, Boolean *ewg_variableWidthColumns, Boolean *ewg_variableHeightRows)
{
	return GetDataBrowserTableViewGeometry ((ControlRef)ewg_browser, (Boolean*)ewg_variableWidthColumns, (Boolean*)ewg_variableHeightRows);
}

// Return address of function 'GetDataBrowserTableViewGeometry'
void* ewg_get_function_address_GetDataBrowserTableViewGeometry (void)
{
	return (void*) GetDataBrowserTableViewGeometry;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewItemID'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewItemID (ControlRef ewg_browser, DataBrowserTableViewRowIndex ewg_row, DataBrowserItemID *ewg_item)
{
	return GetDataBrowserTableViewItemID ((ControlRef)ewg_browser, (DataBrowserTableViewRowIndex)ewg_row, (DataBrowserItemID*)ewg_item);
}

// Return address of function 'GetDataBrowserTableViewItemID'
void* ewg_get_function_address_GetDataBrowserTableViewItemID (void)
{
	return (void*) GetDataBrowserTableViewItemID;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewItemRow'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewItemRow (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserTableViewRowIndex ewg_row)
{
	return SetDataBrowserTableViewItemRow ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserTableViewRowIndex)ewg_row);
}

// Return address of function 'SetDataBrowserTableViewItemRow'
void* ewg_get_function_address_SetDataBrowserTableViewItemRow (void)
{
	return (void*) SetDataBrowserTableViewItemRow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewItemRow'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewItemRow (ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserTableViewRowIndex *ewg_row)
{
	return GetDataBrowserTableViewItemRow ((ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserTableViewRowIndex*)ewg_row);
}

// Return address of function 'GetDataBrowserTableViewItemRow'
void* ewg_get_function_address_GetDataBrowserTableViewItemRow (void)
{
	return (void*) GetDataBrowserTableViewItemRow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserTableViewColumnPosition'
// For ise
OSStatus  ewg_function_SetDataBrowserTableViewColumnPosition (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, DataBrowserTableViewColumnIndex ewg_position)
{
	return SetDataBrowserTableViewColumnPosition ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (DataBrowserTableViewColumnIndex)ewg_position);
}

// Return address of function 'SetDataBrowserTableViewColumnPosition'
void* ewg_get_function_address_SetDataBrowserTableViewColumnPosition (void)
{
	return (void*) SetDataBrowserTableViewColumnPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewColumnPosition'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewColumnPosition (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, DataBrowserTableViewColumnIndex *ewg_position)
{
	return GetDataBrowserTableViewColumnPosition ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (DataBrowserTableViewColumnIndex*)ewg_position);
}

// Return address of function 'GetDataBrowserTableViewColumnPosition'
void* ewg_get_function_address_GetDataBrowserTableViewColumnPosition (void)
{
	return (void*) GetDataBrowserTableViewColumnPosition;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserTableViewColumnProperty'
// For ise
OSStatus  ewg_function_GetDataBrowserTableViewColumnProperty (ControlRef ewg_browser, DataBrowserTableViewColumnIndex ewg_column, DataBrowserTableViewColumnID *ewg_property)
{
	return GetDataBrowserTableViewColumnProperty ((ControlRef)ewg_browser, (DataBrowserTableViewColumnIndex)ewg_column, (DataBrowserTableViewColumnID*)ewg_property);
}

// Return address of function 'GetDataBrowserTableViewColumnProperty'
void* ewg_get_function_address_GetDataBrowserTableViewColumnProperty (void)
{
	return (void*) GetDataBrowserTableViewColumnProperty;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AutoSizeDataBrowserListViewColumns'
// For ise
OSStatus  ewg_function_AutoSizeDataBrowserListViewColumns (ControlRef ewg_browser)
{
	return AutoSizeDataBrowserListViewColumns ((ControlRef)ewg_browser);
}

// Return address of function 'AutoSizeDataBrowserListViewColumns'
void* ewg_get_function_address_AutoSizeDataBrowserListViewColumns (void)
{
	return (void*) AutoSizeDataBrowserListViewColumns;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AddDataBrowserListViewColumn'
// For ise
OSStatus  ewg_function_AddDataBrowserListViewColumn (ControlRef ewg_browser, DataBrowserListViewColumnDesc *ewg_columnDesc, DataBrowserTableViewColumnIndex ewg_position)
{
	return AddDataBrowserListViewColumn ((ControlRef)ewg_browser, (DataBrowserListViewColumnDesc*)ewg_columnDesc, (DataBrowserTableViewColumnIndex)ewg_position);
}

// Return address of function 'AddDataBrowserListViewColumn'
void* ewg_get_function_address_AddDataBrowserListViewColumn (void)
{
	return (void*) AddDataBrowserListViewColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserListViewHeaderDesc'
// For ise
OSStatus  ewg_function_GetDataBrowserListViewHeaderDesc (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, DataBrowserListViewHeaderDesc *ewg_desc)
{
	return GetDataBrowserListViewHeaderDesc ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (DataBrowserListViewHeaderDesc*)ewg_desc);
}

// Return address of function 'GetDataBrowserListViewHeaderDesc'
void* ewg_get_function_address_GetDataBrowserListViewHeaderDesc (void)
{
	return (void*) GetDataBrowserListViewHeaderDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserListViewHeaderDesc'
// For ise
OSStatus  ewg_function_SetDataBrowserListViewHeaderDesc (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, DataBrowserListViewHeaderDesc *ewg_desc)
{
	return SetDataBrowserListViewHeaderDesc ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (DataBrowserListViewHeaderDesc*)ewg_desc);
}

// Return address of function 'SetDataBrowserListViewHeaderDesc'
void* ewg_get_function_address_SetDataBrowserListViewHeaderDesc (void)
{
	return (void*) SetDataBrowserListViewHeaderDesc;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserListViewHeaderBtnHeight'
// For ise
OSStatus  ewg_function_SetDataBrowserListViewHeaderBtnHeight (ControlRef ewg_browser, UInt16 ewg_height)
{
	return SetDataBrowserListViewHeaderBtnHeight ((ControlRef)ewg_browser, (UInt16)ewg_height);
}

// Return address of function 'SetDataBrowserListViewHeaderBtnHeight'
void* ewg_get_function_address_SetDataBrowserListViewHeaderBtnHeight (void)
{
	return (void*) SetDataBrowserListViewHeaderBtnHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserListViewHeaderBtnHeight'
// For ise
OSStatus  ewg_function_GetDataBrowserListViewHeaderBtnHeight (ControlRef ewg_browser, UInt16 *ewg_height)
{
	return GetDataBrowserListViewHeaderBtnHeight ((ControlRef)ewg_browser, (UInt16*)ewg_height);
}

// Return address of function 'GetDataBrowserListViewHeaderBtnHeight'
void* ewg_get_function_address_GetDataBrowserListViewHeaderBtnHeight (void)
{
	return (void*) GetDataBrowserListViewHeaderBtnHeight;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserListViewUsePlainBackground'
// For ise
OSStatus  ewg_function_SetDataBrowserListViewUsePlainBackground (ControlRef ewg_browser, Boolean ewg_usePlainBackground)
{
	return SetDataBrowserListViewUsePlainBackground ((ControlRef)ewg_browser, (Boolean)ewg_usePlainBackground);
}

// Return address of function 'SetDataBrowserListViewUsePlainBackground'
void* ewg_get_function_address_SetDataBrowserListViewUsePlainBackground (void)
{
	return (void*) SetDataBrowserListViewUsePlainBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserListViewUsePlainBackground'
// For ise
OSStatus  ewg_function_GetDataBrowserListViewUsePlainBackground (ControlRef ewg_browser, Boolean *ewg_usePlainBackground)
{
	return GetDataBrowserListViewUsePlainBackground ((ControlRef)ewg_browser, (Boolean*)ewg_usePlainBackground);
}

// Return address of function 'GetDataBrowserListViewUsePlainBackground'
void* ewg_get_function_address_GetDataBrowserListViewUsePlainBackground (void)
{
	return (void*) GetDataBrowserListViewUsePlainBackground;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserListViewDisclosureColumn'
// For ise
OSStatus  ewg_function_SetDataBrowserListViewDisclosureColumn (ControlRef ewg_browser, DataBrowserTableViewColumnID ewg_column, Boolean ewg_expandableRows)
{
	return SetDataBrowserListViewDisclosureColumn ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID)ewg_column, (Boolean)ewg_expandableRows);
}

// Return address of function 'SetDataBrowserListViewDisclosureColumn'
void* ewg_get_function_address_SetDataBrowserListViewDisclosureColumn (void)
{
	return (void*) SetDataBrowserListViewDisclosureColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserListViewDisclosureColumn'
// For ise
OSStatus  ewg_function_GetDataBrowserListViewDisclosureColumn (ControlRef ewg_browser, DataBrowserTableViewColumnID *ewg_column, Boolean *ewg_expandableRows)
{
	return GetDataBrowserListViewDisclosureColumn ((ControlRef)ewg_browser, (DataBrowserTableViewColumnID*)ewg_column, (Boolean*)ewg_expandableRows);
}

// Return address of function 'GetDataBrowserListViewDisclosureColumn'
void* ewg_get_function_address_GetDataBrowserListViewDisclosureColumn (void)
{
	return (void*) GetDataBrowserListViewDisclosureColumn;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserColumnViewPath'
// For ise
OSStatus  ewg_function_GetDataBrowserColumnViewPath (ControlRef ewg_browser, Handle ewg_path)
{
	return GetDataBrowserColumnViewPath ((ControlRef)ewg_browser, (Handle)ewg_path);
}

// Return address of function 'GetDataBrowserColumnViewPath'
void* ewg_get_function_address_GetDataBrowserColumnViewPath (void)
{
	return (void*) GetDataBrowserColumnViewPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserColumnViewPathLength'
// For ise
OSStatus  ewg_function_GetDataBrowserColumnViewPathLength (ControlRef ewg_browser, UInt32 *ewg_pathLength)
{
	return GetDataBrowserColumnViewPathLength ((ControlRef)ewg_browser, (UInt32*)ewg_pathLength);
}

// Return address of function 'GetDataBrowserColumnViewPathLength'
void* ewg_get_function_address_GetDataBrowserColumnViewPathLength (void)
{
	return (void*) GetDataBrowserColumnViewPathLength;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserColumnViewPath'
// For ise
OSStatus  ewg_function_SetDataBrowserColumnViewPath (ControlRef ewg_browser, UInt32 ewg_length, DataBrowserItemID const *ewg_path)
{
	return SetDataBrowserColumnViewPath ((ControlRef)ewg_browser, (UInt32)ewg_length, (DataBrowserItemID const*)ewg_path);
}

// Return address of function 'SetDataBrowserColumnViewPath'
void* ewg_get_function_address_SetDataBrowserColumnViewPath (void)
{
	return (void*) SetDataBrowserColumnViewPath;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SetDataBrowserColumnViewDisplayType'
// For ise
OSStatus  ewg_function_SetDataBrowserColumnViewDisplayType (ControlRef ewg_browser, DataBrowserPropertyType ewg_propertyType)
{
	return SetDataBrowserColumnViewDisplayType ((ControlRef)ewg_browser, (DataBrowserPropertyType)ewg_propertyType);
}

// Return address of function 'SetDataBrowserColumnViewDisplayType'
void* ewg_get_function_address_SetDataBrowserColumnViewDisplayType (void)
{
	return (void*) SetDataBrowserColumnViewDisplayType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetDataBrowserColumnViewDisplayType'
// For ise
OSStatus  ewg_function_GetDataBrowserColumnViewDisplayType (ControlRef ewg_browser, DataBrowserPropertyType *ewg_propertyType)
{
	return GetDataBrowserColumnViewDisplayType ((ControlRef)ewg_browser, (DataBrowserPropertyType*)ewg_propertyType);
}

// Return address of function 'GetDataBrowserColumnViewDisplayType'
void* ewg_get_function_address_GetDataBrowserColumnViewDisplayType (void)
{
	return (void*) GetDataBrowserColumnViewDisplayType;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXUIElementGetDataBrowserItemInfo'
// For ise
OSStatus  ewg_function_AXUIElementGetDataBrowserItemInfo (AXUIElementRef ewg_inElement, ControlRef ewg_inDataBrowser, UInt32 ewg_inDesiredInfoVersion, DataBrowserAccessibilityItemInfo *ewg_outInfo)
{
	return AXUIElementGetDataBrowserItemInfo ((AXUIElementRef)ewg_inElement, (ControlRef)ewg_inDataBrowser, (UInt32)ewg_inDesiredInfoVersion, (DataBrowserAccessibilityItemInfo*)ewg_outInfo);
}

// Return address of function 'AXUIElementGetDataBrowserItemInfo'
void* ewg_get_function_address_AXUIElementGetDataBrowserItemInfo (void)
{
	return (void*) AXUIElementGetDataBrowserItemInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'AXUIElementCreateWithDataBrowserAndItemInfo'
// For ise
AXUIElementRef  ewg_function_AXUIElementCreateWithDataBrowserAndItemInfo (ControlRef ewg_inDataBrowser, DataBrowserAccessibilityItemInfo const *ewg_inInfo)
{
	return AXUIElementCreateWithDataBrowserAndItemInfo ((ControlRef)ewg_inDataBrowser, (DataBrowserAccessibilityItemInfo const*)ewg_inInfo);
}

// Return address of function 'AXUIElementCreateWithDataBrowserAndItemInfo'
void* ewg_get_function_address_AXUIElementCreateWithDataBrowserAndItemInfo (void)
{
	return (void*) AXUIElementCreateWithDataBrowserAndItemInfo;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewEditUnicodePostUpdateUPP'
// For ise
EditUnicodePostUpdateUPP  ewg_function_NewEditUnicodePostUpdateUPP (EditUnicodePostUpdateProcPtr ewg_userRoutine)
{
	return NewEditUnicodePostUpdateUPP ((EditUnicodePostUpdateProcPtr)ewg_userRoutine);
}

// Return address of function 'NewEditUnicodePostUpdateUPP'
void* ewg_get_function_address_NewEditUnicodePostUpdateUPP (void)
{
	return (void*) NewEditUnicodePostUpdateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeEditUnicodePostUpdateUPP'
// For ise
void  ewg_function_DisposeEditUnicodePostUpdateUPP (EditUnicodePostUpdateUPP ewg_userUPP)
{
	DisposeEditUnicodePostUpdateUPP ((EditUnicodePostUpdateUPP)ewg_userUPP);
}

// Return address of function 'DisposeEditUnicodePostUpdateUPP'
void* ewg_get_function_address_DisposeEditUnicodePostUpdateUPP (void)
{
	return (void*) DisposeEditUnicodePostUpdateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeEditUnicodePostUpdateUPP'
// For ise
Boolean  ewg_function_InvokeEditUnicodePostUpdateUPP (UniCharArrayHandle ewg_uniText, UniCharCount ewg_uniTextLength, UniCharArrayOffset ewg_iStartOffset, UniCharArrayOffset ewg_iEndOffset, void *ewg_refcon, EditUnicodePostUpdateUPP ewg_userUPP)
{
	return InvokeEditUnicodePostUpdateUPP ((UniCharArrayHandle)ewg_uniText, (UniCharCount)ewg_uniTextLength, (UniCharArrayOffset)ewg_iStartOffset, (UniCharArrayOffset)ewg_iEndOffset, (void*)ewg_refcon, (EditUnicodePostUpdateUPP)ewg_userUPP);
}

// Return address of function 'InvokeEditUnicodePostUpdateUPP'
void* ewg_get_function_address_InvokeEditUnicodePostUpdateUPP (void)
{
	return (void*) InvokeEditUnicodePostUpdateUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CreateEditUnicodeTextControl'
// For ise
OSStatus  ewg_function_CreateEditUnicodeTextControl (WindowRef ewg_window, Rect const *ewg_boundsRect, CFStringRef ewg_text, Boolean ewg_isPassword, ControlFontStyleRec const *ewg_style, ControlRef *ewg_outControl)
{
	return CreateEditUnicodeTextControl ((WindowRef)ewg_window, (Rect const*)ewg_boundsRect, (CFStringRef)ewg_text, (Boolean)ewg_isPassword, (ControlFontStyleRec const*)ewg_style, (ControlRef*)ewg_outControl);
}

// Return address of function 'CreateEditUnicodeTextControl'
void* ewg_get_function_address_CreateEditUnicodeTextControl (void)
{
	return (void*) CreateEditUnicodeTextControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewNavEventUPP'
// For ise
NavEventUPP  ewg_function_NewNavEventUPP (NavEventProcPtr ewg_userRoutine)
{
	return NewNavEventUPP ((NavEventProcPtr)ewg_userRoutine);
}

// Return address of function 'NewNavEventUPP'
void* ewg_get_function_address_NewNavEventUPP (void)
{
	return (void*) NewNavEventUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewNavPreviewUPP'
// For ise
NavPreviewUPP  ewg_function_NewNavPreviewUPP (NavPreviewProcPtr ewg_userRoutine)
{
	return NewNavPreviewUPP ((NavPreviewProcPtr)ewg_userRoutine);
}

// Return address of function 'NewNavPreviewUPP'
void* ewg_get_function_address_NewNavPreviewUPP (void)
{
	return (void*) NewNavPreviewUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewNavObjectFilterUPP'
// For ise
NavObjectFilterUPP  ewg_function_NewNavObjectFilterUPP (NavObjectFilterProcPtr ewg_userRoutine)
{
	return NewNavObjectFilterUPP ((NavObjectFilterProcPtr)ewg_userRoutine);
}

// Return address of function 'NewNavObjectFilterUPP'
void* ewg_get_function_address_NewNavObjectFilterUPP (void)
{
	return (void*) NewNavObjectFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeNavEventUPP'
// For ise
void  ewg_function_DisposeNavEventUPP (NavEventUPP ewg_userUPP)
{
	DisposeNavEventUPP ((NavEventUPP)ewg_userUPP);
}

// Return address of function 'DisposeNavEventUPP'
void* ewg_get_function_address_DisposeNavEventUPP (void)
{
	return (void*) DisposeNavEventUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeNavPreviewUPP'
// For ise
void  ewg_function_DisposeNavPreviewUPP (NavPreviewUPP ewg_userUPP)
{
	DisposeNavPreviewUPP ((NavPreviewUPP)ewg_userUPP);
}

// Return address of function 'DisposeNavPreviewUPP'
void* ewg_get_function_address_DisposeNavPreviewUPP (void)
{
	return (void*) DisposeNavPreviewUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeNavObjectFilterUPP'
// For ise
void  ewg_function_DisposeNavObjectFilterUPP (NavObjectFilterUPP ewg_userUPP)
{
	DisposeNavObjectFilterUPP ((NavObjectFilterUPP)ewg_userUPP);
}

// Return address of function 'DisposeNavObjectFilterUPP'
void* ewg_get_function_address_DisposeNavObjectFilterUPP (void)
{
	return (void*) DisposeNavObjectFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeNavEventUPP'
// For ise
void  ewg_function_InvokeNavEventUPP (NavEventCallbackMessage ewg_callBackSelector, NavCBRecPtr ewg_callBackParms, void *ewg_callBackUD, NavEventUPP ewg_userUPP)
{
	InvokeNavEventUPP ((NavEventCallbackMessage)ewg_callBackSelector, (NavCBRecPtr)ewg_callBackParms, (void*)ewg_callBackUD, (NavEventUPP)ewg_userUPP);
}

// Return address of function 'InvokeNavEventUPP'
void* ewg_get_function_address_InvokeNavEventUPP (void)
{
	return (void*) InvokeNavEventUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeNavPreviewUPP'
// For ise
Boolean  ewg_function_InvokeNavPreviewUPP (NavCBRecPtr ewg_callBackParms, void *ewg_callBackUD, NavPreviewUPP ewg_userUPP)
{
	return InvokeNavPreviewUPP ((NavCBRecPtr)ewg_callBackParms, (void*)ewg_callBackUD, (NavPreviewUPP)ewg_userUPP);
}

// Return address of function 'InvokeNavPreviewUPP'
void* ewg_get_function_address_InvokeNavPreviewUPP (void)
{
	return (void*) InvokeNavPreviewUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeNavObjectFilterUPP'
// For ise
Boolean  ewg_function_InvokeNavObjectFilterUPP (AEDesc *ewg_theItem, void *ewg_info, void *ewg_callBackUD, NavFilterModes ewg_filterMode, NavObjectFilterUPP ewg_userUPP)
{
	return InvokeNavObjectFilterUPP ((AEDesc*)ewg_theItem, (void*)ewg_info, (void*)ewg_callBackUD, (NavFilterModes)ewg_filterMode, (NavObjectFilterUPP)ewg_userUPP);
}

// Return address of function 'InvokeNavObjectFilterUPP'
void* ewg_get_function_address_InvokeNavObjectFilterUPP (void)
{
	return (void*) InvokeNavObjectFilterUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavLoad'
// For ise
OSErr  ewg_function_NavLoad (void)
{
	return NavLoad ();
}

// Return address of function 'NavLoad'
void* ewg_get_function_address_NavLoad (void)
{
	return (void*) NavLoad;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavUnload'
// For ise
OSErr  ewg_function_NavUnload (void)
{
	return NavUnload ();
}

// Return address of function 'NavUnload'
void* ewg_get_function_address_NavUnload (void)
{
	return (void*) NavUnload;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavLibraryVersion'
// For ise
UInt32  ewg_function_NavLibraryVersion (void)
{
	return NavLibraryVersion ();
}

// Return address of function 'NavLibraryVersion'
void* ewg_get_function_address_NavLibraryVersion (void)
{
	return (void*) NavLibraryVersion;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavGetDefaultDialogOptions'
// For ise
OSErr  ewg_function_NavGetDefaultDialogOptions (NavDialogOptions *ewg_dialogOptions)
{
	return NavGetDefaultDialogOptions ((NavDialogOptions*)ewg_dialogOptions);
}

// Return address of function 'NavGetDefaultDialogOptions'
void* ewg_get_function_address_NavGetDefaultDialogOptions (void)
{
	return (void*) NavGetDefaultDialogOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavGetFile'
// For ise
OSErr  ewg_function_NavGetFile (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, NavPreviewUPP ewg_previewProc, NavObjectFilterUPP ewg_filterProc, NavTypeListHandle ewg_typeList, void *ewg_callBackUD)
{
	return NavGetFile ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (NavPreviewUPP)ewg_previewProc, (NavObjectFilterUPP)ewg_filterProc, (NavTypeListHandle)ewg_typeList, (void*)ewg_callBackUD);
}

// Return address of function 'NavGetFile'
void* ewg_get_function_address_NavGetFile (void)
{
	return (void*) NavGetFile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavPutFile'
// For ise
OSErr  ewg_function_NavPutFile (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, OSType ewg_fileType, OSType ewg_fileCreator, void *ewg_callBackUD)
{
	return NavPutFile ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (OSType)ewg_fileType, (OSType)ewg_fileCreator, (void*)ewg_callBackUD);
}

// Return address of function 'NavPutFile'
void* ewg_get_function_address_NavPutFile (void)
{
	return (void*) NavPutFile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavAskSaveChanges'
// For ise
OSErr  ewg_function_NavAskSaveChanges (NavDialogOptions *ewg_dialogOptions, NavAskSaveChangesAction ewg_action, NavAskSaveChangesResult *ewg_reply, NavEventUPP ewg_eventProc, void *ewg_callBackUD)
{
	return NavAskSaveChanges ((NavDialogOptions*)ewg_dialogOptions, (NavAskSaveChangesAction)ewg_action, (NavAskSaveChangesResult*)ewg_reply, (NavEventUPP)ewg_eventProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavAskSaveChanges'
void* ewg_get_function_address_NavAskSaveChanges (void)
{
	return (void*) NavAskSaveChanges;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCustomAskSaveChanges'
// For ise
OSErr  ewg_function_NavCustomAskSaveChanges (NavDialogOptions *ewg_dialogOptions, NavAskSaveChangesResult *ewg_reply, NavEventUPP ewg_eventProc, void *ewg_callBackUD)
{
	return NavCustomAskSaveChanges ((NavDialogOptions*)ewg_dialogOptions, (NavAskSaveChangesResult*)ewg_reply, (NavEventUPP)ewg_eventProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavCustomAskSaveChanges'
void* ewg_get_function_address_NavCustomAskSaveChanges (void)
{
	return (void*) NavCustomAskSaveChanges;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavAskDiscardChanges'
// For ise
OSErr  ewg_function_NavAskDiscardChanges (NavDialogOptions *ewg_dialogOptions, NavAskDiscardChangesResult *ewg_reply, NavEventUPP ewg_eventProc, void *ewg_callBackUD)
{
	return NavAskDiscardChanges ((NavDialogOptions*)ewg_dialogOptions, (NavAskDiscardChangesResult*)ewg_reply, (NavEventUPP)ewg_eventProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavAskDiscardChanges'
void* ewg_get_function_address_NavAskDiscardChanges (void)
{
	return (void*) NavAskDiscardChanges;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavChooseFile'
// For ise
OSErr  ewg_function_NavChooseFile (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, NavPreviewUPP ewg_previewProc, NavObjectFilterUPP ewg_filterProc, NavTypeListHandle ewg_typeList, void *ewg_callBackUD)
{
	return NavChooseFile ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (NavPreviewUPP)ewg_previewProc, (NavObjectFilterUPP)ewg_filterProc, (NavTypeListHandle)ewg_typeList, (void*)ewg_callBackUD);
}

// Return address of function 'NavChooseFile'
void* ewg_get_function_address_NavChooseFile (void)
{
	return (void*) NavChooseFile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavChooseFolder'
// For ise
OSErr  ewg_function_NavChooseFolder (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, NavObjectFilterUPP ewg_filterProc, void *ewg_callBackUD)
{
	return NavChooseFolder ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (NavObjectFilterUPP)ewg_filterProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavChooseFolder'
void* ewg_get_function_address_NavChooseFolder (void)
{
	return (void*) NavChooseFolder;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavChooseVolume'
// For ise
OSErr  ewg_function_NavChooseVolume (AEDesc *ewg_defaultSelection, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, NavObjectFilterUPP ewg_filterProc, void *ewg_callBackUD)
{
	return NavChooseVolume ((AEDesc*)ewg_defaultSelection, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (NavObjectFilterUPP)ewg_filterProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavChooseVolume'
void* ewg_get_function_address_NavChooseVolume (void)
{
	return (void*) NavChooseVolume;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavChooseObject'
// For ise
OSErr  ewg_function_NavChooseObject (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, NavObjectFilterUPP ewg_filterProc, void *ewg_callBackUD)
{
	return NavChooseObject ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (NavObjectFilterUPP)ewg_filterProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavChooseObject'
void* ewg_get_function_address_NavChooseObject (void)
{
	return (void*) NavChooseObject;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavNewFolder'
// For ise
OSErr  ewg_function_NavNewFolder (AEDesc *ewg_defaultLocation, NavReplyRecord *ewg_reply, NavDialogOptions *ewg_dialogOptions, NavEventUPP ewg_eventProc, void *ewg_callBackUD)
{
	return NavNewFolder ((AEDesc*)ewg_defaultLocation, (NavReplyRecord*)ewg_reply, (NavDialogOptions*)ewg_dialogOptions, (NavEventUPP)ewg_eventProc, (void*)ewg_callBackUD);
}

// Return address of function 'NavNewFolder'
void* ewg_get_function_address_NavNewFolder (void)
{
	return (void*) NavNewFolder;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavTranslateFile'
// For ise
OSErr  ewg_function_NavTranslateFile (NavReplyRecord *ewg_reply, NavTranslationOptions ewg_howToTranslate)
{
	return NavTranslateFile ((NavReplyRecord*)ewg_reply, (NavTranslationOptions)ewg_howToTranslate);
}

// Return address of function 'NavTranslateFile'
void* ewg_get_function_address_NavTranslateFile (void)
{
	return (void*) NavTranslateFile;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCompleteSave'
// For ise
OSErr  ewg_function_NavCompleteSave (NavReplyRecord *ewg_reply, NavTranslationOptions ewg_howToTranslate)
{
	return NavCompleteSave ((NavReplyRecord*)ewg_reply, (NavTranslationOptions)ewg_howToTranslate);
}

// Return address of function 'NavCompleteSave'
void* ewg_get_function_address_NavCompleteSave (void)
{
	return (void*) NavCompleteSave;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCustomControl'
// For ise
OSErr  ewg_function_NavCustomControl (NavDialogRef ewg_dialog, NavCustomControlMessage ewg_selector, void *ewg_parms)
{
	return NavCustomControl ((NavDialogRef)ewg_dialog, (NavCustomControlMessage)ewg_selector, (void*)ewg_parms);
}

// Return address of function 'NavCustomControl'
void* ewg_get_function_address_NavCustomControl (void)
{
	return (void*) NavCustomControl;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreatePreview'
// For ise
OSErr  ewg_function_NavCreatePreview (AEDesc *ewg_theObject, OSType ewg_previewDataType, void const *ewg_previewData, Size ewg_previewDataSize)
{
	return NavCreatePreview ((AEDesc*)ewg_theObject, (OSType)ewg_previewDataType, (void const*)ewg_previewData, (Size)ewg_previewDataSize);
}

// Return address of function 'NavCreatePreview'
void* ewg_get_function_address_NavCreatePreview (void)
{
	return (void*) NavCreatePreview;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDisposeReply'
// For ise
OSErr  ewg_function_NavDisposeReply (NavReplyRecord *ewg_reply)
{
	return NavDisposeReply ((NavReplyRecord*)ewg_reply);
}

// Return address of function 'NavDisposeReply'
void* ewg_get_function_address_NavDisposeReply (void)
{
	return (void*) NavDisposeReply;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavServicesCanRun'
// For ise
Boolean  ewg_function_NavServicesCanRun (void)
{
	return NavServicesCanRun ();
}

// Return address of function 'NavServicesCanRun'
void* ewg_get_function_address_NavServicesCanRun (void)
{
	return (void*) NavServicesCanRun;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavGetDefaultDialogCreationOptions'
// For ise
OSStatus  ewg_function_NavGetDefaultDialogCreationOptions (NavDialogCreationOptions *ewg_outOptions)
{
	return NavGetDefaultDialogCreationOptions ((NavDialogCreationOptions*)ewg_outOptions);
}

// Return address of function 'NavGetDefaultDialogCreationOptions'
void* ewg_get_function_address_NavGetDefaultDialogCreationOptions (void)
{
	return (void*) NavGetDefaultDialogCreationOptions;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateGetFileDialog'
// For ise
OSStatus  ewg_function_NavCreateGetFileDialog (NavDialogCreationOptions const *ewg_inOptions, NavTypeListHandle ewg_inTypeList, NavEventUPP ewg_inEventProc, NavPreviewUPP ewg_inPreviewProc, NavObjectFilterUPP ewg_inFilterProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateGetFileDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavTypeListHandle)ewg_inTypeList, (NavEventUPP)ewg_inEventProc, (NavPreviewUPP)ewg_inPreviewProc, (NavObjectFilterUPP)ewg_inFilterProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateGetFileDialog'
void* ewg_get_function_address_NavCreateGetFileDialog (void)
{
	return (void*) NavCreateGetFileDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreatePutFileDialog'
// For ise
OSStatus  ewg_function_NavCreatePutFileDialog (NavDialogCreationOptions const *ewg_inOptions, OSType ewg_inFileType, OSType ewg_inFileCreator, NavEventUPP ewg_inEventProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreatePutFileDialog ((NavDialogCreationOptions const*)ewg_inOptions, (OSType)ewg_inFileType, (OSType)ewg_inFileCreator, (NavEventUPP)ewg_inEventProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreatePutFileDialog'
void* ewg_get_function_address_NavCreatePutFileDialog (void)
{
	return (void*) NavCreatePutFileDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateAskReviewDocumentsDialog'
// For ise
OSStatus  ewg_function_NavCreateAskReviewDocumentsDialog (NavDialogCreationOptions const *ewg_inOptions, UInt32 ewg_inDocumentCount, NavEventUPP ewg_inEventProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateAskReviewDocumentsDialog ((NavDialogCreationOptions const*)ewg_inOptions, (UInt32)ewg_inDocumentCount, (NavEventUPP)ewg_inEventProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateAskReviewDocumentsDialog'
void* ewg_get_function_address_NavCreateAskReviewDocumentsDialog (void)
{
	return (void*) NavCreateAskReviewDocumentsDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateAskSaveChangesDialog'
// For ise
OSStatus  ewg_function_NavCreateAskSaveChangesDialog (NavDialogCreationOptions const *ewg_inOptions, NavAskSaveChangesAction ewg_inAction, NavEventUPP ewg_inEventProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateAskSaveChangesDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavAskSaveChangesAction)ewg_inAction, (NavEventUPP)ewg_inEventProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateAskSaveChangesDialog'
void* ewg_get_function_address_NavCreateAskSaveChangesDialog (void)
{
	return (void*) NavCreateAskSaveChangesDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateAskDiscardChangesDialog'
// For ise
OSStatus  ewg_function_NavCreateAskDiscardChangesDialog (NavDialogCreationOptions const *ewg_inOptions, NavEventUPP ewg_inEventProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateAskDiscardChangesDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavEventUPP)ewg_inEventProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateAskDiscardChangesDialog'
void* ewg_get_function_address_NavCreateAskDiscardChangesDialog (void)
{
	return (void*) NavCreateAskDiscardChangesDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateChooseFileDialog'
// For ise
OSStatus  ewg_function_NavCreateChooseFileDialog (NavDialogCreationOptions const *ewg_inOptions, NavTypeListHandle ewg_inTypeList, NavEventUPP ewg_inEventProc, NavPreviewUPP ewg_inPreviewProc, NavObjectFilterUPP ewg_inFilterProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateChooseFileDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavTypeListHandle)ewg_inTypeList, (NavEventUPP)ewg_inEventProc, (NavPreviewUPP)ewg_inPreviewProc, (NavObjectFilterUPP)ewg_inFilterProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateChooseFileDialog'
void* ewg_get_function_address_NavCreateChooseFileDialog (void)
{
	return (void*) NavCreateChooseFileDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateChooseFolderDialog'
// For ise
OSStatus  ewg_function_NavCreateChooseFolderDialog (NavDialogCreationOptions const *ewg_inOptions, NavEventUPP ewg_inEventProc, NavObjectFilterUPP ewg_inFilterProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateChooseFolderDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavEventUPP)ewg_inEventProc, (NavObjectFilterUPP)ewg_inFilterProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateChooseFolderDialog'
void* ewg_get_function_address_NavCreateChooseFolderDialog (void)
{
	return (void*) NavCreateChooseFolderDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateChooseVolumeDialog'
// For ise
OSStatus  ewg_function_NavCreateChooseVolumeDialog (NavDialogCreationOptions const *ewg_inOptions, NavEventUPP ewg_inEventProc, NavObjectFilterUPP ewg_inFilterProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateChooseVolumeDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavEventUPP)ewg_inEventProc, (NavObjectFilterUPP)ewg_inFilterProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateChooseVolumeDialog'
void* ewg_get_function_address_NavCreateChooseVolumeDialog (void)
{
	return (void*) NavCreateChooseVolumeDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateChooseObjectDialog'
// For ise
OSStatus  ewg_function_NavCreateChooseObjectDialog (NavDialogCreationOptions const *ewg_inOptions, NavEventUPP ewg_inEventProc, NavPreviewUPP ewg_inPreviewProc, NavObjectFilterUPP ewg_inFilterProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateChooseObjectDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavEventUPP)ewg_inEventProc, (NavPreviewUPP)ewg_inPreviewProc, (NavObjectFilterUPP)ewg_inFilterProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateChooseObjectDialog'
void* ewg_get_function_address_NavCreateChooseObjectDialog (void)
{
	return (void*) NavCreateChooseObjectDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavCreateNewFolderDialog'
// For ise
OSStatus  ewg_function_NavCreateNewFolderDialog (NavDialogCreationOptions const *ewg_inOptions, NavEventUPP ewg_inEventProc, void *ewg_inClientData, NavDialogRef *ewg_outDialog)
{
	return NavCreateNewFolderDialog ((NavDialogCreationOptions const*)ewg_inOptions, (NavEventUPP)ewg_inEventProc, (void*)ewg_inClientData, (NavDialogRef*)ewg_outDialog);
}

// Return address of function 'NavCreateNewFolderDialog'
void* ewg_get_function_address_NavCreateNewFolderDialog (void)
{
	return (void*) NavCreateNewFolderDialog;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogRun'
// For ise
OSStatus  ewg_function_NavDialogRun (NavDialogRef ewg_inDialog)
{
	return NavDialogRun ((NavDialogRef)ewg_inDialog);
}

// Return address of function 'NavDialogRun'
void* ewg_get_function_address_NavDialogRun (void)
{
	return (void*) NavDialogRun;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogDispose'
// For ise
void  ewg_function_NavDialogDispose (NavDialogRef ewg_inDialog)
{
	NavDialogDispose ((NavDialogRef)ewg_inDialog);
}

// Return address of function 'NavDialogDispose'
void* ewg_get_function_address_NavDialogDispose (void)
{
	return (void*) NavDialogDispose;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogGetWindow'
// For ise
WindowRef  ewg_function_NavDialogGetWindow (NavDialogRef ewg_inDialog)
{
	return NavDialogGetWindow ((NavDialogRef)ewg_inDialog);
}

// Return address of function 'NavDialogGetWindow'
void* ewg_get_function_address_NavDialogGetWindow (void)
{
	return (void*) NavDialogGetWindow;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogGetUserAction'
// For ise
NavUserAction  ewg_function_NavDialogGetUserAction (NavDialogRef ewg_inDialog)
{
	return NavDialogGetUserAction ((NavDialogRef)ewg_inDialog);
}

// Return address of function 'NavDialogGetUserAction'
void* ewg_get_function_address_NavDialogGetUserAction (void)
{
	return (void*) NavDialogGetUserAction;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogGetReply'
// For ise
OSStatus  ewg_function_NavDialogGetReply (NavDialogRef ewg_inDialog, NavReplyRecord *ewg_outReply)
{
	return NavDialogGetReply ((NavDialogRef)ewg_inDialog, (NavReplyRecord*)ewg_outReply);
}

// Return address of function 'NavDialogGetReply'
void* ewg_get_function_address_NavDialogGetReply (void)
{
	return (void*) NavDialogGetReply;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogGetSaveFileName'
// For ise
CFStringRef  ewg_function_NavDialogGetSaveFileName (NavDialogRef ewg_inPutFileDialog)
{
	return NavDialogGetSaveFileName ((NavDialogRef)ewg_inPutFileDialog);
}

// Return address of function 'NavDialogGetSaveFileName'
void* ewg_get_function_address_NavDialogGetSaveFileName (void)
{
	return (void*) NavDialogGetSaveFileName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogSetSaveFileName'
// For ise
OSStatus  ewg_function_NavDialogSetSaveFileName (NavDialogRef ewg_inPutFileDialog, CFStringRef ewg_inFileName)
{
	return NavDialogSetSaveFileName ((NavDialogRef)ewg_inPutFileDialog, (CFStringRef)ewg_inFileName);
}

// Return address of function 'NavDialogSetSaveFileName'
void* ewg_get_function_address_NavDialogSetSaveFileName (void)
{
	return (void*) NavDialogSetSaveFileName;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogGetSaveFileExtensionHidden'
// For ise
Boolean  ewg_function_NavDialogGetSaveFileExtensionHidden (NavDialogRef ewg_inPutFileDialog)
{
	return NavDialogGetSaveFileExtensionHidden ((NavDialogRef)ewg_inPutFileDialog);
}

// Return address of function 'NavDialogGetSaveFileExtensionHidden'
void* ewg_get_function_address_NavDialogGetSaveFileExtensionHidden (void)
{
	return (void*) NavDialogGetSaveFileExtensionHidden;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogSetSaveFileExtensionHidden'
// For ise
OSStatus  ewg_function_NavDialogSetSaveFileExtensionHidden (NavDialogRef ewg_inPutFileDialog, Boolean ewg_inHidden)
{
	return NavDialogSetSaveFileExtensionHidden ((NavDialogRef)ewg_inPutFileDialog, (Boolean)ewg_inHidden);
}

// Return address of function 'NavDialogSetSaveFileExtensionHidden'
void* ewg_get_function_address_NavDialogSetSaveFileExtensionHidden (void)
{
	return (void*) NavDialogSetSaveFileExtensionHidden;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NavDialogSetFilterTypeIdentifiers'
// For ise
OSStatus  ewg_function_NavDialogSetFilterTypeIdentifiers (NavDialogRef ewg_inGetFileDialog, CFArrayRef ewg_inTypeIdentifiers)
{
	return NavDialogSetFilterTypeIdentifiers ((NavDialogRef)ewg_inGetFileDialog, (CFArrayRef)ewg_inTypeIdentifiers);
}

// Return address of function 'NavDialogSetFilterTypeIdentifiers'
void* ewg_get_function_address_NavDialogSetFilterTypeIdentifiers (void)
{
	return (void*) NavDialogSetFilterTypeIdentifiers;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'Fix2SmallFract'
// For ise
SmallFract  ewg_function_Fix2SmallFract (Fixed ewg_f)
{
	return Fix2SmallFract ((Fixed)ewg_f);
}

// Return address of function 'Fix2SmallFract'
void* ewg_get_function_address_Fix2SmallFract (void)
{
	return (void*) Fix2SmallFract;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'SmallFract2Fix'
// For ise
Fixed  ewg_function_SmallFract2Fix (SmallFract ewg_s)
{
	return SmallFract2Fix ((SmallFract)ewg_s);
}

// Return address of function 'SmallFract2Fix'
void* ewg_get_function_address_SmallFract2Fix (void)
{
	return (void*) SmallFract2Fix;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'CMY2RGB'
// For ise
void  ewg_function_CMY2RGB (CMYColor const *ewg_cColor, RGBColor *ewg_rColor)
{
	CMY2RGB ((CMYColor const*)ewg_cColor, (RGBColor*)ewg_rColor);
}

// Return address of function 'CMY2RGB'
void* ewg_get_function_address_CMY2RGB (void)
{
	return (void*) CMY2RGB;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RGB2CMY'
// For ise
void  ewg_function_RGB2CMY (RGBColor const *ewg_rColor, CMYColor *ewg_cColor)
{
	RGB2CMY ((RGBColor const*)ewg_rColor, (CMYColor*)ewg_cColor);
}

// Return address of function 'RGB2CMY'
void* ewg_get_function_address_RGB2CMY (void)
{
	return (void*) RGB2CMY;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HSL2RGB'
// For ise
void  ewg_function_HSL2RGB (HSLColor const *ewg_hColor, RGBColor *ewg_rColor)
{
	HSL2RGB ((HSLColor const*)ewg_hColor, (RGBColor*)ewg_rColor);
}

// Return address of function 'HSL2RGB'
void* ewg_get_function_address_HSL2RGB (void)
{
	return (void*) HSL2RGB;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RGB2HSL'
// For ise
void  ewg_function_RGB2HSL (RGBColor const *ewg_rColor, HSLColor *ewg_hColor)
{
	RGB2HSL ((RGBColor const*)ewg_rColor, (HSLColor*)ewg_hColor);
}

// Return address of function 'RGB2HSL'
void* ewg_get_function_address_RGB2HSL (void)
{
	return (void*) RGB2HSL;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'HSV2RGB'
// For ise
void  ewg_function_HSV2RGB (HSVColor const *ewg_hColor, RGBColor *ewg_rColor)
{
	HSV2RGB ((HSVColor const*)ewg_hColor, (RGBColor*)ewg_rColor);
}

// Return address of function 'HSV2RGB'
void* ewg_get_function_address_HSV2RGB (void)
{
	return (void*) HSV2RGB;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'RGB2HSV'
// For ise
void  ewg_function_RGB2HSV (RGBColor const *ewg_rColor, HSVColor *ewg_hColor)
{
	RGB2HSV ((RGBColor const*)ewg_rColor, (HSVColor*)ewg_hColor);
}

// Return address of function 'RGB2HSV'
void* ewg_get_function_address_RGB2HSV (void)
{
	return (void*) RGB2HSV;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'GetColor'
// For ise
Boolean  ewg_function_GetColor (Point *ewg_where, ConstStr255Param ewg_prompt, RGBColor const *ewg_inColor, RGBColor *ewg_outColor)
{
	return GetColor (*(Point*)ewg_where, (ConstStr255Param)ewg_prompt, (RGBColor const*)ewg_inColor, (RGBColor*)ewg_outColor);
}

// Return address of function 'GetColor'
void* ewg_get_function_address_GetColor (void)
{
	return (void*) GetColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'PickColor'
// For ise
OSErr  ewg_function_PickColor (ColorPickerInfo *ewg_theColorInfo)
{
	return PickColor ((ColorPickerInfo*)ewg_theColorInfo);
}

// Return address of function 'PickColor'
void* ewg_get_function_address_PickColor (void)
{
	return (void*) PickColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NPickColor'
// For ise
OSErr  ewg_function_NPickColor (NColorPickerInfo *ewg_theColorInfo)
{
	return NPickColor ((NColorPickerInfo*)ewg_theColorInfo);
}

// Return address of function 'NPickColor'
void* ewg_get_function_address_NPickColor (void)
{
	return (void*) NPickColor;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewColorChangedUPP'
// For ise
ColorChangedUPP  ewg_function_NewColorChangedUPP (ColorChangedProcPtr ewg_userRoutine)
{
	return NewColorChangedUPP ((ColorChangedProcPtr)ewg_userRoutine);
}

// Return address of function 'NewColorChangedUPP'
void* ewg_get_function_address_NewColorChangedUPP (void)
{
	return (void*) NewColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewNColorChangedUPP'
// For ise
NColorChangedUPP  ewg_function_NewNColorChangedUPP (NColorChangedProcPtr ewg_userRoutine)
{
	return NewNColorChangedUPP ((NColorChangedProcPtr)ewg_userRoutine);
}

// Return address of function 'NewNColorChangedUPP'
void* ewg_get_function_address_NewNColorChangedUPP (void)
{
	return (void*) NewNColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'NewUserEventUPP'
// For ise
UserEventUPP  ewg_function_NewUserEventUPP (UserEventProcPtr ewg_userRoutine)
{
	return NewUserEventUPP ((UserEventProcPtr)ewg_userRoutine);
}

// Return address of function 'NewUserEventUPP'
void* ewg_get_function_address_NewUserEventUPP (void)
{
	return (void*) NewUserEventUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeColorChangedUPP'
// For ise
void  ewg_function_DisposeColorChangedUPP (ColorChangedUPP ewg_userUPP)
{
	DisposeColorChangedUPP ((ColorChangedUPP)ewg_userUPP);
}

// Return address of function 'DisposeColorChangedUPP'
void* ewg_get_function_address_DisposeColorChangedUPP (void)
{
	return (void*) DisposeColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeNColorChangedUPP'
// For ise
void  ewg_function_DisposeNColorChangedUPP (NColorChangedUPP ewg_userUPP)
{
	DisposeNColorChangedUPP ((NColorChangedUPP)ewg_userUPP);
}

// Return address of function 'DisposeNColorChangedUPP'
void* ewg_get_function_address_DisposeNColorChangedUPP (void)
{
	return (void*) DisposeNColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'DisposeUserEventUPP'
// For ise
void  ewg_function_DisposeUserEventUPP (UserEventUPP ewg_userUPP)
{
	DisposeUserEventUPP ((UserEventUPP)ewg_userUPP);
}

// Return address of function 'DisposeUserEventUPP'
void* ewg_get_function_address_DisposeUserEventUPP (void)
{
	return (void*) DisposeUserEventUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeColorChangedUPP'
// For ise
void  ewg_function_InvokeColorChangedUPP (long ewg_userData, PMColor *ewg_newColor, ColorChangedUPP ewg_userUPP)
{
	InvokeColorChangedUPP ((long)ewg_userData, (PMColor*)ewg_newColor, (ColorChangedUPP)ewg_userUPP);
}

// Return address of function 'InvokeColorChangedUPP'
void* ewg_get_function_address_InvokeColorChangedUPP (void)
{
	return (void*) InvokeColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeNColorChangedUPP'
// For ise
void  ewg_function_InvokeNColorChangedUPP (long ewg_userData, NPMColor *ewg_newColor, NColorChangedUPP ewg_userUPP)
{
	InvokeNColorChangedUPP ((long)ewg_userData, (NPMColor*)ewg_newColor, (NColorChangedUPP)ewg_userUPP);
}

// Return address of function 'InvokeNColorChangedUPP'
void* ewg_get_function_address_InvokeNColorChangedUPP (void)
{
	return (void*) InvokeNColorChangedUPP;
}

#include <Carbon/Carbon.h>

// Wraps call to function 'InvokeUserEventUPP'
// For ise
Boolean  ewg_function_InvokeUserEventUPP (EventRecord *ewg_event, UserEventUPP ewg_userUPP)
{
	return InvokeUserEventUPP ((EventRecord*)ewg_event, (UserEventUPP)ewg_userUPP);
}

// Return address of function 'InvokeUserEventUPP'
void* ewg_get_function_address_InvokeUserEventUPP (void)
{
	return (void*) InvokeUserEventUPP;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_release_data_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_release_data_callback_stub (void)
{
	return get_cgdata_provider_release_data_callback_stub ();
}

// Return address of function 'get_cgdata_provider_release_data_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_release_data_callback_stub (void)
{
	return (void*) get_cgdata_provider_release_data_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_release_data_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_release_data_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_release_data_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_release_data_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_release_data_callback_entry (void)
{
	return (void*) set_cgdata_provider_release_data_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_release_data_callback'
// For ise
void  ewg_function_call_cgdata_provider_release_data_callback (void *ewg_a_function, void *ewg_info, void const *ewg_data, size_t ewg_size)
{
	call_cgdata_provider_release_data_callback ((void*)ewg_a_function, (void*)ewg_info, (void const*)ewg_data, (size_t)ewg_size);
}

// Return address of function 'call_cgdata_provider_release_data_callback'
void* ewg_get_function_address_call_cgdata_provider_release_data_callback (void)
{
	return (void*) call_cgdata_provider_release_data_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgpath_applier_function_stub'
// For ise
void * ewg_function_get_cgpath_applier_function_stub (void)
{
	return get_cgpath_applier_function_stub ();
}

// Return address of function 'get_cgpath_applier_function_stub'
void* ewg_get_function_address_get_cgpath_applier_function_stub (void)
{
	return (void*) get_cgpath_applier_function_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgpath_applier_function_entry'
// For ise
void  ewg_function_set_cgpath_applier_function_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgpath_applier_function_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgpath_applier_function_entry'
void* ewg_get_function_address_set_cgpath_applier_function_entry (void)
{
	return (void*) set_cgpath_applier_function_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgpath_applier_function'
// For ise
void  ewg_function_call_cgpath_applier_function (void *ewg_a_function, void *ewg_info, CGPathElement const *ewg_element)
{
	call_cgpath_applier_function ((void*)ewg_a_function, (void*)ewg_info, (CGPathElement const*)ewg_element);
}

// Return address of function 'call_cgpath_applier_function'
void* ewg_get_function_address_call_cgpath_applier_function (void)
{
	return (void*) call_cgpath_applier_function;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_aecoerce_desc_proc_ptr_stub'
// For ise
void * ewg_function_get_aecoerce_desc_proc_ptr_stub (void)
{
	return get_aecoerce_desc_proc_ptr_stub ();
}

// Return address of function 'get_aecoerce_desc_proc_ptr_stub'
void* ewg_get_function_address_get_aecoerce_desc_proc_ptr_stub (void)
{
	return (void*) get_aecoerce_desc_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_aecoerce_desc_proc_ptr_entry'
// For ise
void  ewg_function_set_aecoerce_desc_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_aecoerce_desc_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_aecoerce_desc_proc_ptr_entry'
void* ewg_get_function_address_set_aecoerce_desc_proc_ptr_entry (void)
{
	return (void*) set_aecoerce_desc_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_aecoerce_desc_proc_ptr'
// For ise
OSErr  ewg_function_call_aecoerce_desc_proc_ptr (void *ewg_a_function, AEDesc const *ewg_fromDesc, DescType ewg_toType, long ewg_handlerRefcon, AEDesc *ewg_toDesc)
{
	return call_aecoerce_desc_proc_ptr ((void*)ewg_a_function, (AEDesc const*)ewg_fromDesc, (DescType)ewg_toType, (long)ewg_handlerRefcon, (AEDesc*)ewg_toDesc);
}

// Return address of function 'call_aecoerce_desc_proc_ptr'
void* ewg_get_function_address_call_aecoerce_desc_proc_ptr (void)
{
	return (void*) call_aecoerce_desc_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_aecoerce_ptr_proc_ptr_stub'
// For ise
void * ewg_function_get_aecoerce_ptr_proc_ptr_stub (void)
{
	return get_aecoerce_ptr_proc_ptr_stub ();
}

// Return address of function 'get_aecoerce_ptr_proc_ptr_stub'
void* ewg_get_function_address_get_aecoerce_ptr_proc_ptr_stub (void)
{
	return (void*) get_aecoerce_ptr_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_aecoerce_ptr_proc_ptr_entry'
// For ise
void  ewg_function_set_aecoerce_ptr_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_aecoerce_ptr_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_aecoerce_ptr_proc_ptr_entry'
void* ewg_get_function_address_set_aecoerce_ptr_proc_ptr_entry (void)
{
	return (void*) set_aecoerce_ptr_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_aecoerce_ptr_proc_ptr'
// For ise
OSErr  ewg_function_call_aecoerce_ptr_proc_ptr (void *ewg_a_function, DescType ewg_typeCode, void const *ewg_dataPtr, Size ewg_dataSize, DescType ewg_toType, long ewg_handlerRefcon, AEDesc *ewg_result)
{
	return call_aecoerce_ptr_proc_ptr ((void*)ewg_a_function, (DescType)ewg_typeCode, (void const*)ewg_dataPtr, (Size)ewg_dataSize, (DescType)ewg_toType, (long)ewg_handlerRefcon, (AEDesc*)ewg_result);
}

// Return address of function 'call_aecoerce_ptr_proc_ptr'
void* ewg_get_function_address_call_aecoerce_ptr_proc_ptr (void)
{
	return (void*) call_aecoerce_ptr_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_aedispose_external_proc_ptr_stub'
// For ise
void * ewg_function_get_aedispose_external_proc_ptr_stub (void)
{
	return get_aedispose_external_proc_ptr_stub ();
}

// Return address of function 'get_aedispose_external_proc_ptr_stub'
void* ewg_get_function_address_get_aedispose_external_proc_ptr_stub (void)
{
	return (void*) get_aedispose_external_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_aedispose_external_proc_ptr_entry'
// For ise
void  ewg_function_set_aedispose_external_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_aedispose_external_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_aedispose_external_proc_ptr_entry'
void* ewg_get_function_address_set_aedispose_external_proc_ptr_entry (void)
{
	return (void*) set_aedispose_external_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_aedispose_external_proc_ptr'
// For ise
void  ewg_function_call_aedispose_external_proc_ptr (void *ewg_a_function, void const *ewg_dataPtr, Size ewg_dataLength, long ewg_refcon)
{
	call_aedispose_external_proc_ptr ((void*)ewg_a_function, (void const*)ewg_dataPtr, (Size)ewg_dataLength, (long)ewg_refcon);
}

// Return address of function 'call_aedispose_external_proc_ptr'
void* ewg_get_function_address_call_aedispose_external_proc_ptr (void)
{
	return (void*) call_aedispose_external_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_aeevent_handler_proc_ptr_stub'
// For ise
void * ewg_function_get_aeevent_handler_proc_ptr_stub (void)
{
	return get_aeevent_handler_proc_ptr_stub ();
}

// Return address of function 'get_aeevent_handler_proc_ptr_stub'
void* ewg_get_function_address_get_aeevent_handler_proc_ptr_stub (void)
{
	return (void*) get_aeevent_handler_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_aeevent_handler_proc_ptr_entry'
// For ise
void  ewg_function_set_aeevent_handler_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_aeevent_handler_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_aeevent_handler_proc_ptr_entry'
void* ewg_get_function_address_set_aeevent_handler_proc_ptr_entry (void)
{
	return (void*) set_aeevent_handler_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_aeevent_handler_proc_ptr'
// For ise
OSErr  ewg_function_call_aeevent_handler_proc_ptr (void *ewg_a_function, AppleEvent const *ewg_theAppleEvent, AppleEvent *ewg_reply, long ewg_handlerRefcon)
{
	return call_aeevent_handler_proc_ptr ((void*)ewg_a_function, (AppleEvent const*)ewg_theAppleEvent, (AppleEvent*)ewg_reply, (long)ewg_handlerRefcon);
}

// Return address of function 'call_aeevent_handler_proc_ptr'
void* ewg_get_function_address_call_aeevent_handler_proc_ptr (void)
{
	return (void*) call_aeevent_handler_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_aeremote_process_resolver_callback_stub'
// For ise
void * ewg_function_get_aeremote_process_resolver_callback_stub (void)
{
	return get_aeremote_process_resolver_callback_stub ();
}

// Return address of function 'get_aeremote_process_resolver_callback_stub'
void* ewg_get_function_address_get_aeremote_process_resolver_callback_stub (void)
{
	return (void*) get_aeremote_process_resolver_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_aeremote_process_resolver_callback_entry'
// For ise
void  ewg_function_set_aeremote_process_resolver_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_aeremote_process_resolver_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_aeremote_process_resolver_callback_entry'
void* ewg_get_function_address_set_aeremote_process_resolver_callback_entry (void)
{
	return (void*) set_aeremote_process_resolver_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_aeremote_process_resolver_callback'
// For ise
void  ewg_function_call_aeremote_process_resolver_callback (void *ewg_a_function, AERemoteProcessResolverRef ewg_ref, void *ewg_info)
{
	call_aeremote_process_resolver_callback ((void*)ewg_a_function, (AERemoteProcessResolverRef)ewg_ref, (void*)ewg_info);
}

// Return address of function 'call_aeremote_process_resolver_callback'
void* ewg_get_function_address_call_aeremote_process_resolver_callback (void)
{
	return (void*) call_aeremote_process_resolver_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_event_comparator_proc_ptr_stub'
// For ise
void * ewg_function_get_event_comparator_proc_ptr_stub (void)
{
	return get_event_comparator_proc_ptr_stub ();
}

// Return address of function 'get_event_comparator_proc_ptr_stub'
void* ewg_get_function_address_get_event_comparator_proc_ptr_stub (void)
{
	return (void*) get_event_comparator_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_event_comparator_proc_ptr_entry'
// For ise
void  ewg_function_set_event_comparator_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_event_comparator_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_event_comparator_proc_ptr_entry'
void* ewg_get_function_address_set_event_comparator_proc_ptr_entry (void)
{
	return (void*) set_event_comparator_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_event_comparator_proc_ptr'
// For ise
Boolean  ewg_function_call_event_comparator_proc_ptr (void *ewg_a_function, EventRef ewg_inEvent, void *ewg_inCompareData)
{
	return call_event_comparator_proc_ptr ((void*)ewg_a_function, (EventRef)ewg_inEvent, (void*)ewg_inCompareData);
}

// Return address of function 'call_event_comparator_proc_ptr'
void* ewg_get_function_address_call_event_comparator_proc_ptr (void)
{
	return (void*) call_event_comparator_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_event_loop_timer_proc_ptr_stub'
// For ise
void * ewg_function_get_event_loop_timer_proc_ptr_stub (void)
{
	return get_event_loop_timer_proc_ptr_stub ();
}

// Return address of function 'get_event_loop_timer_proc_ptr_stub'
void* ewg_get_function_address_get_event_loop_timer_proc_ptr_stub (void)
{
	return (void*) get_event_loop_timer_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_event_loop_timer_proc_ptr_entry'
// For ise
void  ewg_function_set_event_loop_timer_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_event_loop_timer_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_event_loop_timer_proc_ptr_entry'
void* ewg_get_function_address_set_event_loop_timer_proc_ptr_entry (void)
{
	return (void*) set_event_loop_timer_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_event_loop_timer_proc_ptr'
// For ise
void  ewg_function_call_event_loop_timer_proc_ptr (void *ewg_a_function, EventLoopTimerRef ewg_inTimer, void *ewg_inUserData)
{
	call_event_loop_timer_proc_ptr ((void*)ewg_a_function, (EventLoopTimerRef)ewg_inTimer, (void*)ewg_inUserData);
}

// Return address of function 'call_event_loop_timer_proc_ptr'
void* ewg_get_function_address_call_event_loop_timer_proc_ptr (void)
{
	return (void*) call_event_loop_timer_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_event_loop_idle_timer_proc_ptr_stub'
// For ise
void * ewg_function_get_event_loop_idle_timer_proc_ptr_stub (void)
{
	return get_event_loop_idle_timer_proc_ptr_stub ();
}

// Return address of function 'get_event_loop_idle_timer_proc_ptr_stub'
void* ewg_get_function_address_get_event_loop_idle_timer_proc_ptr_stub (void)
{
	return (void*) get_event_loop_idle_timer_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_event_loop_idle_timer_proc_ptr_entry'
// For ise
void  ewg_function_set_event_loop_idle_timer_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_event_loop_idle_timer_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_event_loop_idle_timer_proc_ptr_entry'
void* ewg_get_function_address_set_event_loop_idle_timer_proc_ptr_entry (void)
{
	return (void*) set_event_loop_idle_timer_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_event_loop_idle_timer_proc_ptr'
// For ise
void  ewg_function_call_event_loop_idle_timer_proc_ptr (void *ewg_a_function, EventLoopTimerRef ewg_inTimer, EventLoopIdleTimerMessage ewg_inState, void *ewg_inUserData)
{
	call_event_loop_idle_timer_proc_ptr ((void*)ewg_a_function, (EventLoopTimerRef)ewg_inTimer, (EventLoopIdleTimerMessage)ewg_inState, (void*)ewg_inUserData);
}

// Return address of function 'call_event_loop_idle_timer_proc_ptr'
void* ewg_get_function_address_call_event_loop_idle_timer_proc_ptr (void)
{
	return (void*) call_event_loop_idle_timer_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_event_handler_proc_ptr_stub'
// For ise
void * ewg_function_get_event_handler_proc_ptr_stub (void)
{
	return get_event_handler_proc_ptr_stub ();
}

// Return address of function 'get_event_handler_proc_ptr_stub'
void* ewg_get_function_address_get_event_handler_proc_ptr_stub (void)
{
	return (void*) get_event_handler_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_event_handler_proc_ptr_entry'
// For ise
void  ewg_function_set_event_handler_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_event_handler_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_event_handler_proc_ptr_entry'
void* ewg_get_function_address_set_event_handler_proc_ptr_entry (void)
{
	return (void*) set_event_handler_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_event_handler_proc_ptr'
// For ise
OSStatus  ewg_function_call_event_handler_proc_ptr (void *ewg_a_function, EventHandlerCallRef ewg_inHandlerCallRef, EventRef ewg_inEvent, void *ewg_inUserData)
{
	return call_event_handler_proc_ptr ((void*)ewg_a_function, (EventHandlerCallRef)ewg_inHandlerCallRef, (EventRef)ewg_inEvent, (void*)ewg_inUserData);
}

// Return address of function 'call_event_handler_proc_ptr'
void* ewg_get_function_address_call_event_handler_proc_ptr (void)
{
	return (void*) call_event_handler_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_menu_def_proc_ptr_stub'
// For ise
void * ewg_function_get_menu_def_proc_ptr_stub (void)
{
	return get_menu_def_proc_ptr_stub ();
}

// Return address of function 'get_menu_def_proc_ptr_stub'
void* ewg_get_function_address_get_menu_def_proc_ptr_stub (void)
{
	return (void*) get_menu_def_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_menu_def_proc_ptr_entry'
// For ise
void  ewg_function_set_menu_def_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_menu_def_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_menu_def_proc_ptr_entry'
void* ewg_get_function_address_set_menu_def_proc_ptr_entry (void)
{
	return (void*) set_menu_def_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_menu_def_proc_ptr'
// For ise
void  ewg_function_call_menu_def_proc_ptr (void *ewg_a_function, short ewg_message, MenuRef ewg_theMenu, Rect *ewg_menuRect, Point *ewg_hitPt, short *ewg_whichItem)
{
	call_menu_def_proc_ptr ((void*)ewg_a_function, (short)ewg_message, (MenuRef)ewg_theMenu, (Rect*)ewg_menuRect, *(Point*)ewg_hitPt, (short*)ewg_whichItem);
}

// Return address of function 'call_menu_def_proc_ptr'
void* ewg_get_function_address_call_menu_def_proc_ptr (void)
{
	return (void*) call_menu_def_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_action_proc_ptr_stub'
// For ise
void * ewg_function_get_control_action_proc_ptr_stub (void)
{
	return get_control_action_proc_ptr_stub ();
}

// Return address of function 'get_control_action_proc_ptr_stub'
void* ewg_get_function_address_get_control_action_proc_ptr_stub (void)
{
	return (void*) get_control_action_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_action_proc_ptr_entry'
// For ise
void  ewg_function_set_control_action_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_action_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_action_proc_ptr_entry'
void* ewg_get_function_address_set_control_action_proc_ptr_entry (void)
{
	return (void*) set_control_action_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_action_proc_ptr'
// For ise
void  ewg_function_call_control_action_proc_ptr (void *ewg_a_function, ControlRef ewg_theControl, ControlPartCode ewg_partCode)
{
	call_control_action_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_theControl, (ControlPartCode)ewg_partCode);
}

// Return address of function 'call_control_action_proc_ptr'
void* ewg_get_function_address_call_control_action_proc_ptr (void)
{
	return (void*) call_control_action_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_def_proc_ptr_stub'
// For ise
void * ewg_function_get_control_def_proc_ptr_stub (void)
{
	return get_control_def_proc_ptr_stub ();
}

// Return address of function 'get_control_def_proc_ptr_stub'
void* ewg_get_function_address_get_control_def_proc_ptr_stub (void)
{
	return (void*) get_control_def_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_def_proc_ptr_entry'
// For ise
void  ewg_function_set_control_def_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_def_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_def_proc_ptr_entry'
void* ewg_get_function_address_set_control_def_proc_ptr_entry (void)
{
	return (void*) set_control_def_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_def_proc_ptr'
// For ise
SInt32  ewg_function_call_control_def_proc_ptr (void *ewg_a_function, SInt16 ewg_varCode, ControlRef ewg_theControl, ControlDefProcMessage ewg_message, SInt32 ewg_param)
{
	return call_control_def_proc_ptr ((void*)ewg_a_function, (SInt16)ewg_varCode, (ControlRef)ewg_theControl, (ControlDefProcMessage)ewg_message, (SInt32)ewg_param);
}

// Return address of function 'call_control_def_proc_ptr'
void* ewg_get_function_address_call_control_def_proc_ptr (void)
{
	return (void*) call_control_def_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_key_filter_proc_ptr_stub'
// For ise
void * ewg_function_get_control_key_filter_proc_ptr_stub (void)
{
	return get_control_key_filter_proc_ptr_stub ();
}

// Return address of function 'get_control_key_filter_proc_ptr_stub'
void* ewg_get_function_address_get_control_key_filter_proc_ptr_stub (void)
{
	return (void*) get_control_key_filter_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_key_filter_proc_ptr_entry'
// For ise
void  ewg_function_set_control_key_filter_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_key_filter_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_key_filter_proc_ptr_entry'
void* ewg_get_function_address_set_control_key_filter_proc_ptr_entry (void)
{
	return (void*) set_control_key_filter_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_key_filter_proc_ptr'
// For ise
ControlKeyFilterResult  ewg_function_call_control_key_filter_proc_ptr (void *ewg_a_function, ControlRef ewg_theControl, SInt16 *ewg_keyCode, SInt16 *ewg_charCode, EventModifiers *ewg_modifiers)
{
	return call_control_key_filter_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_theControl, (SInt16*)ewg_keyCode, (SInt16*)ewg_charCode, (EventModifiers*)ewg_modifiers);
}

// Return address of function 'call_control_key_filter_proc_ptr'
void* ewg_get_function_address_call_control_key_filter_proc_ptr (void)
{
	return (void*) call_control_key_filter_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_cntlto_collection_proc_ptr_stub'
// For ise
void * ewg_function_get_control_cntlto_collection_proc_ptr_stub (void)
{
	return get_control_cntlto_collection_proc_ptr_stub ();
}

// Return address of function 'get_control_cntlto_collection_proc_ptr_stub'
void* ewg_get_function_address_get_control_cntlto_collection_proc_ptr_stub (void)
{
	return (void*) get_control_cntlto_collection_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_cntlto_collection_proc_ptr_entry'
// For ise
void  ewg_function_set_control_cntlto_collection_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_cntlto_collection_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_cntlto_collection_proc_ptr_entry'
void* ewg_get_function_address_set_control_cntlto_collection_proc_ptr_entry (void)
{
	return (void*) set_control_cntlto_collection_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_cntlto_collection_proc_ptr'
// For ise
OSStatus  ewg_function_call_control_cntlto_collection_proc_ptr (void *ewg_a_function, Rect const *ewg_bounds, SInt16 ewg_value, Boolean ewg_visible, SInt16 ewg_max, SInt16 ewg_min, SInt16 ewg_procID, SInt32 ewg_refCon, ConstStr255Param ewg_title, Collection ewg_collection)
{
	return call_control_cntlto_collection_proc_ptr ((void*)ewg_a_function, (Rect const*)ewg_bounds, (SInt16)ewg_value, (Boolean)ewg_visible, (SInt16)ewg_max, (SInt16)ewg_min, (SInt16)ewg_procID, (SInt32)ewg_refCon, (ConstStr255Param)ewg_title, (Collection)ewg_collection);
}

// Return address of function 'call_control_cntlto_collection_proc_ptr'
void* ewg_get_function_address_call_control_cntlto_collection_proc_ptr (void)
{
	return (void*) call_control_cntlto_collection_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_color_proc_ptr_stub'
// For ise
void * ewg_function_get_control_color_proc_ptr_stub (void)
{
	return get_control_color_proc_ptr_stub ();
}

// Return address of function 'get_control_color_proc_ptr_stub'
void* ewg_get_function_address_get_control_color_proc_ptr_stub (void)
{
	return (void*) get_control_color_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_color_proc_ptr_entry'
// For ise
void  ewg_function_set_control_color_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_color_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_color_proc_ptr_entry'
void* ewg_get_function_address_set_control_color_proc_ptr_entry (void)
{
	return (void*) set_control_color_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_color_proc_ptr'
// For ise
OSStatus  ewg_function_call_control_color_proc_ptr (void *ewg_a_function, ControlRef ewg_inControl, SInt16 ewg_inMessage, SInt16 ewg_inDrawDepth, Boolean ewg_inDrawInColor)
{
	return call_control_color_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_inControl, (SInt16)ewg_inMessage, (SInt16)ewg_inDrawDepth, (Boolean)ewg_inDrawInColor);
}

// Return address of function 'call_control_color_proc_ptr'
void* ewg_get_function_address_call_control_color_proc_ptr (void)
{
	return (void*) call_control_color_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_window_def_proc_ptr_stub'
// For ise
void * ewg_function_get_window_def_proc_ptr_stub (void)
{
	return get_window_def_proc_ptr_stub ();
}

// Return address of function 'get_window_def_proc_ptr_stub'
void* ewg_get_function_address_get_window_def_proc_ptr_stub (void)
{
	return (void*) get_window_def_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_window_def_proc_ptr_entry'
// For ise
void  ewg_function_set_window_def_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_window_def_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_window_def_proc_ptr_entry'
void* ewg_get_function_address_set_window_def_proc_ptr_entry (void)
{
	return (void*) set_window_def_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_window_def_proc_ptr'
// For ise
long  ewg_function_call_window_def_proc_ptr (void *ewg_a_function, short ewg_varCode, WindowRef ewg_window, short ewg_message, long ewg_param)
{
	return call_window_def_proc_ptr ((void*)ewg_a_function, (short)ewg_varCode, (WindowRef)ewg_window, (short)ewg_message, (long)ewg_param);
}

// Return address of function 'call_window_def_proc_ptr'
void* ewg_get_function_address_call_window_def_proc_ptr (void)
{
	return (void*) call_window_def_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_window_paint_proc_ptr_stub'
// For ise
void * ewg_function_get_window_paint_proc_ptr_stub (void)
{
	return get_window_paint_proc_ptr_stub ();
}

// Return address of function 'get_window_paint_proc_ptr_stub'
void* ewg_get_function_address_get_window_paint_proc_ptr_stub (void)
{
	return (void*) get_window_paint_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_window_paint_proc_ptr_entry'
// For ise
void  ewg_function_set_window_paint_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_window_paint_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_window_paint_proc_ptr_entry'
void* ewg_get_function_address_set_window_paint_proc_ptr_entry (void)
{
	return (void*) set_window_paint_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_window_paint_proc_ptr'
// For ise
OSStatus  ewg_function_call_window_paint_proc_ptr (void *ewg_a_function, GDHandle ewg_device, GrafPtr ewg_qdContext, WindowRef ewg_window, RgnHandle ewg_inClientPaintRgn, RgnHandle ewg_outSystemPaintRgn, void *ewg_refCon)
{
	return call_window_paint_proc_ptr ((void*)ewg_a_function, (GDHandle)ewg_device, (GrafPtr)ewg_qdContext, (WindowRef)ewg_window, (RgnHandle)ewg_inClientPaintRgn, (RgnHandle)ewg_outSystemPaintRgn, (void*)ewg_refCon);
}

// Return address of function 'call_window_paint_proc_ptr'
void* ewg_get_function_address_call_window_paint_proc_ptr (void)
{
	return (void*) call_window_paint_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_txnfind_proc_ptr_stub'
// For ise
void * ewg_function_get_txnfind_proc_ptr_stub (void)
{
	return get_txnfind_proc_ptr_stub ();
}

// Return address of function 'get_txnfind_proc_ptr_stub'
void* ewg_get_function_address_get_txnfind_proc_ptr_stub (void)
{
	return (void*) get_txnfind_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_txnfind_proc_ptr_entry'
// For ise
void  ewg_function_set_txnfind_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_txnfind_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_txnfind_proc_ptr_entry'
void* ewg_get_function_address_set_txnfind_proc_ptr_entry (void)
{
	return (void*) set_txnfind_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_txnfind_proc_ptr'
// For ise
OSStatus  ewg_function_call_txnfind_proc_ptr (void *ewg_a_function, TXNMatchTextRecord const *ewg_matchData, TXNDataType ewg_iDataType, TXNMatchOptions ewg_iMatchOptions, void const *ewg_iSearchTextPtr, TextEncoding ewg_encoding, TXNOffset ewg_absStartOffset, ByteCount ewg_searchTextLength, TXNOffset *ewg_oStartMatch, TXNOffset *ewg_oEndMatch, Boolean *ewg_ofound, UInt32 ewg_refCon)
{
	return call_txnfind_proc_ptr ((void*)ewg_a_function, (TXNMatchTextRecord const*)ewg_matchData, (TXNDataType)ewg_iDataType, (TXNMatchOptions)ewg_iMatchOptions, (void const*)ewg_iSearchTextPtr, (TextEncoding)ewg_encoding, (TXNOffset)ewg_absStartOffset, (ByteCount)ewg_searchTextLength, (TXNOffset*)ewg_oStartMatch, (TXNOffset*)ewg_oEndMatch, (Boolean*)ewg_ofound, (UInt32)ewg_refCon);
}

// Return address of function 'call_txnfind_proc_ptr'
void* ewg_get_function_address_call_txnfind_proc_ptr (void)
{
	return (void*) call_txnfind_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_txnaction_name_mapper_proc_ptr_stub'
// For ise
void * ewg_function_get_txnaction_name_mapper_proc_ptr_stub (void)
{
	return get_txnaction_name_mapper_proc_ptr_stub ();
}

// Return address of function 'get_txnaction_name_mapper_proc_ptr_stub'
void* ewg_get_function_address_get_txnaction_name_mapper_proc_ptr_stub (void)
{
	return (void*) get_txnaction_name_mapper_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_txnaction_name_mapper_proc_ptr_entry'
// For ise
void  ewg_function_set_txnaction_name_mapper_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_txnaction_name_mapper_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_txnaction_name_mapper_proc_ptr_entry'
void* ewg_get_function_address_set_txnaction_name_mapper_proc_ptr_entry (void)
{
	return (void*) set_txnaction_name_mapper_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_txnaction_name_mapper_proc_ptr'
// For ise
CFStringRef  ewg_function_call_txnaction_name_mapper_proc_ptr (void *ewg_a_function, CFStringRef ewg_actionName, UInt32 ewg_commandID, void *ewg_inUserData)
{
	return call_txnaction_name_mapper_proc_ptr ((void*)ewg_a_function, (CFStringRef)ewg_actionName, (UInt32)ewg_commandID, (void*)ewg_inUserData);
}

// Return address of function 'call_txnaction_name_mapper_proc_ptr'
void* ewg_get_function_address_call_txnaction_name_mapper_proc_ptr (void)
{
	return (void*) call_txnaction_name_mapper_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_txncontextual_menu_setup_proc_ptr_stub'
// For ise
void * ewg_function_get_txncontextual_menu_setup_proc_ptr_stub (void)
{
	return get_txncontextual_menu_setup_proc_ptr_stub ();
}

// Return address of function 'get_txncontextual_menu_setup_proc_ptr_stub'
void* ewg_get_function_address_get_txncontextual_menu_setup_proc_ptr_stub (void)
{
	return (void*) get_txncontextual_menu_setup_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_txncontextual_menu_setup_proc_ptr_entry'
// For ise
void  ewg_function_set_txncontextual_menu_setup_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_txncontextual_menu_setup_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_txncontextual_menu_setup_proc_ptr_entry'
void* ewg_get_function_address_set_txncontextual_menu_setup_proc_ptr_entry (void)
{
	return (void*) set_txncontextual_menu_setup_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_txncontextual_menu_setup_proc_ptr'
// For ise
void  ewg_function_call_txncontextual_menu_setup_proc_ptr (void *ewg_a_function, MenuRef ewg_iContextualMenu, TXNObject ewg_object, void *ewg_inUserData)
{
	call_txncontextual_menu_setup_proc_ptr ((void*)ewg_a_function, (MenuRef)ewg_iContextualMenu, (TXNObject)ewg_object, (void*)ewg_inUserData);
}

// Return address of function 'call_txncontextual_menu_setup_proc_ptr'
void* ewg_get_function_address_call_txncontextual_menu_setup_proc_ptr (void)
{
	return (void*) call_txncontextual_menu_setup_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_txnscroll_info_proc_ptr_stub'
// For ise
void * ewg_function_get_txnscroll_info_proc_ptr_stub (void)
{
	return get_txnscroll_info_proc_ptr_stub ();
}

// Return address of function 'get_txnscroll_info_proc_ptr_stub'
void* ewg_get_function_address_get_txnscroll_info_proc_ptr_stub (void)
{
	return (void*) get_txnscroll_info_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_txnscroll_info_proc_ptr_entry'
// For ise
void  ewg_function_set_txnscroll_info_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_txnscroll_info_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_txnscroll_info_proc_ptr_entry'
void* ewg_get_function_address_set_txnscroll_info_proc_ptr_entry (void)
{
	return (void*) set_txnscroll_info_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_txnscroll_info_proc_ptr'
// For ise
void  ewg_function_call_txnscroll_info_proc_ptr (void *ewg_a_function, SInt32 ewg_iValue, SInt32 ewg_iMaximumValue, TXNScrollBarOrientation ewg_iScrollBarOrientation, SInt32 ewg_iRefCon)
{
	call_txnscroll_info_proc_ptr ((void*)ewg_a_function, (SInt32)ewg_iValue, (SInt32)ewg_iMaximumValue, (TXNScrollBarOrientation)ewg_iScrollBarOrientation, (SInt32)ewg_iRefCon);
}

// Return address of function 'call_txnscroll_info_proc_ptr'
void* ewg_get_function_address_call_txnscroll_info_proc_ptr (void)
{
	return (void*) call_txnscroll_info_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_txnaction_key_mapper_proc_ptr_stub'
// For ise
void * ewg_function_get_txnaction_key_mapper_proc_ptr_stub (void)
{
	return get_txnaction_key_mapper_proc_ptr_stub ();
}

// Return address of function 'get_txnaction_key_mapper_proc_ptr_stub'
void* ewg_get_function_address_get_txnaction_key_mapper_proc_ptr_stub (void)
{
	return (void*) get_txnaction_key_mapper_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_txnaction_key_mapper_proc_ptr_entry'
// For ise
void  ewg_function_set_txnaction_key_mapper_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_txnaction_key_mapper_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_txnaction_key_mapper_proc_ptr_entry'
void* ewg_get_function_address_set_txnaction_key_mapper_proc_ptr_entry (void)
{
	return (void*) set_txnaction_key_mapper_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_txnaction_key_mapper_proc_ptr'
// For ise
CFStringRef  ewg_function_call_txnaction_key_mapper_proc_ptr (void *ewg_a_function, TXNActionKey ewg_actionKey, UInt32 ewg_commandID)
{
	return call_txnaction_key_mapper_proc_ptr ((void*)ewg_a_function, (TXNActionKey)ewg_actionKey, (UInt32)ewg_commandID);
}

// Return address of function 'call_txnaction_key_mapper_proc_ptr'
void* ewg_get_function_address_call_txnaction_key_mapper_proc_ptr (void)
{
	return (void*) call_txnaction_key_mapper_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_hmcontrol_content_proc_ptr_stub'
// For ise
void * ewg_function_get_hmcontrol_content_proc_ptr_stub (void)
{
	return get_hmcontrol_content_proc_ptr_stub ();
}

// Return address of function 'get_hmcontrol_content_proc_ptr_stub'
void* ewg_get_function_address_get_hmcontrol_content_proc_ptr_stub (void)
{
	return (void*) get_hmcontrol_content_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_hmcontrol_content_proc_ptr_entry'
// For ise
void  ewg_function_set_hmcontrol_content_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_hmcontrol_content_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_hmcontrol_content_proc_ptr_entry'
void* ewg_get_function_address_set_hmcontrol_content_proc_ptr_entry (void)
{
	return (void*) set_hmcontrol_content_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_hmcontrol_content_proc_ptr'
// For ise
OSStatus  ewg_function_call_hmcontrol_content_proc_ptr (void *ewg_a_function, ControlRef ewg_inControl, Point *ewg_inGlobalMouse, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent)
{
	return call_hmcontrol_content_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_inControl, *(Point*)ewg_inGlobalMouse, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent);
}

// Return address of function 'call_hmcontrol_content_proc_ptr'
void* ewg_get_function_address_call_hmcontrol_content_proc_ptr (void)
{
	return (void*) call_hmcontrol_content_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_hmwindow_content_proc_ptr_stub'
// For ise
void * ewg_function_get_hmwindow_content_proc_ptr_stub (void)
{
	return get_hmwindow_content_proc_ptr_stub ();
}

// Return address of function 'get_hmwindow_content_proc_ptr_stub'
void* ewg_get_function_address_get_hmwindow_content_proc_ptr_stub (void)
{
	return (void*) get_hmwindow_content_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_hmwindow_content_proc_ptr_entry'
// For ise
void  ewg_function_set_hmwindow_content_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_hmwindow_content_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_hmwindow_content_proc_ptr_entry'
void* ewg_get_function_address_set_hmwindow_content_proc_ptr_entry (void)
{
	return (void*) set_hmwindow_content_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_hmwindow_content_proc_ptr'
// For ise
OSStatus  ewg_function_call_hmwindow_content_proc_ptr (void *ewg_a_function, WindowRef ewg_inWindow, Point *ewg_inGlobalMouse, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent)
{
	return call_hmwindow_content_proc_ptr ((void*)ewg_a_function, (WindowRef)ewg_inWindow, *(Point*)ewg_inGlobalMouse, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent);
}

// Return address of function 'call_hmwindow_content_proc_ptr'
void* ewg_get_function_address_call_hmwindow_content_proc_ptr (void)
{
	return (void*) call_hmwindow_content_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_hmmenu_title_content_proc_ptr_stub'
// For ise
void * ewg_function_get_hmmenu_title_content_proc_ptr_stub (void)
{
	return get_hmmenu_title_content_proc_ptr_stub ();
}

// Return address of function 'get_hmmenu_title_content_proc_ptr_stub'
void* ewg_get_function_address_get_hmmenu_title_content_proc_ptr_stub (void)
{
	return (void*) get_hmmenu_title_content_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_hmmenu_title_content_proc_ptr_entry'
// For ise
void  ewg_function_set_hmmenu_title_content_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_hmmenu_title_content_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_hmmenu_title_content_proc_ptr_entry'
void* ewg_get_function_address_set_hmmenu_title_content_proc_ptr_entry (void)
{
	return (void*) set_hmmenu_title_content_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_hmmenu_title_content_proc_ptr'
// For ise
OSStatus  ewg_function_call_hmmenu_title_content_proc_ptr (void *ewg_a_function, MenuRef ewg_inMenu, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent)
{
	return call_hmmenu_title_content_proc_ptr ((void*)ewg_a_function, (MenuRef)ewg_inMenu, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent);
}

// Return address of function 'call_hmmenu_title_content_proc_ptr'
void* ewg_get_function_address_call_hmmenu_title_content_proc_ptr (void)
{
	return (void*) call_hmmenu_title_content_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_hmmenu_item_content_proc_ptr_stub'
// For ise
void * ewg_function_get_hmmenu_item_content_proc_ptr_stub (void)
{
	return get_hmmenu_item_content_proc_ptr_stub ();
}

// Return address of function 'get_hmmenu_item_content_proc_ptr_stub'
void* ewg_get_function_address_get_hmmenu_item_content_proc_ptr_stub (void)
{
	return (void*) get_hmmenu_item_content_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_hmmenu_item_content_proc_ptr_entry'
// For ise
void  ewg_function_set_hmmenu_item_content_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_hmmenu_item_content_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_hmmenu_item_content_proc_ptr_entry'
void* ewg_get_function_address_set_hmmenu_item_content_proc_ptr_entry (void)
{
	return (void*) set_hmmenu_item_content_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_hmmenu_item_content_proc_ptr'
// For ise
OSStatus  ewg_function_call_hmmenu_item_content_proc_ptr (void *ewg_a_function, MenuTrackingData const *ewg_inTrackingData, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent)
{
	return call_hmmenu_item_content_proc_ptr ((void*)ewg_a_function, (MenuTrackingData const*)ewg_inTrackingData, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent);
}

// Return address of function 'call_hmmenu_item_content_proc_ptr'
void* ewg_get_function_address_call_hmmenu_item_content_proc_ptr (void)
{
	return (void*) call_hmmenu_item_content_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_draw_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_draw_proc_ptr_stub (void)
{
	return get_control_user_pane_draw_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_draw_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_draw_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_draw_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_draw_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_draw_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_draw_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_draw_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_draw_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_draw_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_draw_proc_ptr'
// For ise
void  ewg_function_call_control_user_pane_draw_proc_ptr (void *ewg_a_function, ControlRef ewg_control, SInt16 ewg_part)
{
	call_control_user_pane_draw_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, (SInt16)ewg_part);
}

// Return address of function 'call_control_user_pane_draw_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_draw_proc_ptr (void)
{
	return (void*) call_control_user_pane_draw_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_hit_test_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_hit_test_proc_ptr_stub (void)
{
	return get_control_user_pane_hit_test_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_hit_test_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_hit_test_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_hit_test_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_hit_test_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_hit_test_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_hit_test_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_hit_test_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_hit_test_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_hit_test_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_hit_test_proc_ptr'
// For ise
ControlPartCode  ewg_function_call_control_user_pane_hit_test_proc_ptr (void *ewg_a_function, ControlRef ewg_control, Point *ewg_where)
{
	return call_control_user_pane_hit_test_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, *(Point*)ewg_where);
}

// Return address of function 'call_control_user_pane_hit_test_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_hit_test_proc_ptr (void)
{
	return (void*) call_control_user_pane_hit_test_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_tracking_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_tracking_proc_ptr_stub (void)
{
	return get_control_user_pane_tracking_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_tracking_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_tracking_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_tracking_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_tracking_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_tracking_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_tracking_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_tracking_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_tracking_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_tracking_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_tracking_proc_ptr'
// For ise
ControlPartCode  ewg_function_call_control_user_pane_tracking_proc_ptr (void *ewg_a_function, ControlRef ewg_control, Point *ewg_startPt, ControlActionUPP ewg_actionProc)
{
	return call_control_user_pane_tracking_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, *(Point*)ewg_startPt, (ControlActionUPP)ewg_actionProc);
}

// Return address of function 'call_control_user_pane_tracking_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_tracking_proc_ptr (void)
{
	return (void*) call_control_user_pane_tracking_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_idle_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_idle_proc_ptr_stub (void)
{
	return get_control_user_pane_idle_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_idle_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_idle_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_idle_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_idle_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_idle_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_idle_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_idle_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_idle_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_idle_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_idle_proc_ptr'
// For ise
void  ewg_function_call_control_user_pane_idle_proc_ptr (void *ewg_a_function, ControlRef ewg_control)
{
	call_control_user_pane_idle_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control);
}

// Return address of function 'call_control_user_pane_idle_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_idle_proc_ptr (void)
{
	return (void*) call_control_user_pane_idle_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_key_down_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_key_down_proc_ptr_stub (void)
{
	return get_control_user_pane_key_down_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_key_down_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_key_down_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_key_down_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_key_down_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_key_down_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_key_down_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_key_down_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_key_down_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_key_down_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_key_down_proc_ptr'
// For ise
ControlPartCode  ewg_function_call_control_user_pane_key_down_proc_ptr (void *ewg_a_function, ControlRef ewg_control, SInt16 ewg_keyCode, SInt16 ewg_charCode, SInt16 ewg_modifiers)
{
	return call_control_user_pane_key_down_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, (SInt16)ewg_keyCode, (SInt16)ewg_charCode, (SInt16)ewg_modifiers);
}

// Return address of function 'call_control_user_pane_key_down_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_key_down_proc_ptr (void)
{
	return (void*) call_control_user_pane_key_down_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_activate_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_activate_proc_ptr_stub (void)
{
	return get_control_user_pane_activate_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_activate_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_activate_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_activate_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_activate_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_activate_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_activate_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_activate_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_activate_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_activate_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_activate_proc_ptr'
// For ise
void  ewg_function_call_control_user_pane_activate_proc_ptr (void *ewg_a_function, ControlRef ewg_control, Boolean ewg_activating)
{
	call_control_user_pane_activate_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, (Boolean)ewg_activating);
}

// Return address of function 'call_control_user_pane_activate_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_activate_proc_ptr (void)
{
	return (void*) call_control_user_pane_activate_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_focus_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_focus_proc_ptr_stub (void)
{
	return get_control_user_pane_focus_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_focus_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_focus_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_focus_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_focus_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_focus_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_focus_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_focus_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_focus_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_focus_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_focus_proc_ptr'
// For ise
ControlPartCode  ewg_function_call_control_user_pane_focus_proc_ptr (void *ewg_a_function, ControlRef ewg_control, ControlFocusPart ewg_action)
{
	return call_control_user_pane_focus_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, (ControlFocusPart)ewg_action);
}

// Return address of function 'call_control_user_pane_focus_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_focus_proc_ptr (void)
{
	return (void*) call_control_user_pane_focus_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_control_user_pane_background_proc_ptr_stub'
// For ise
void * ewg_function_get_control_user_pane_background_proc_ptr_stub (void)
{
	return get_control_user_pane_background_proc_ptr_stub ();
}

// Return address of function 'get_control_user_pane_background_proc_ptr_stub'
void* ewg_get_function_address_get_control_user_pane_background_proc_ptr_stub (void)
{
	return (void*) get_control_user_pane_background_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_control_user_pane_background_proc_ptr_entry'
// For ise
void  ewg_function_set_control_user_pane_background_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_control_user_pane_background_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_control_user_pane_background_proc_ptr_entry'
void* ewg_get_function_address_set_control_user_pane_background_proc_ptr_entry (void)
{
	return (void*) set_control_user_pane_background_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_control_user_pane_background_proc_ptr'
// For ise
void  ewg_function_call_control_user_pane_background_proc_ptr (void *ewg_a_function, ControlRef ewg_control, ControlBackgroundPtr ewg_info)
{
	call_control_user_pane_background_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_control, (ControlBackgroundPtr)ewg_info);
}

// Return address of function 'call_control_user_pane_background_proc_ptr'
void* ewg_get_function_address_call_control_user_pane_background_proc_ptr (void)
{
	return (void*) call_control_user_pane_background_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_proc_ptr_stub (void)
{
	return get_data_browser_item_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_proc_ptr'
// For ise
void  ewg_function_call_data_browser_item_proc_ptr (void *ewg_a_function, DataBrowserItemID ewg_item, DataBrowserItemState ewg_state, void *ewg_clientData)
{
	call_data_browser_item_proc_ptr ((void*)ewg_a_function, (DataBrowserItemID)ewg_item, (DataBrowserItemState)ewg_state, (void*)ewg_clientData);
}

// Return address of function 'call_data_browser_item_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_proc_ptr (void)
{
	return (void*) call_data_browser_item_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_data_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_data_proc_ptr_stub (void)
{
	return get_data_browser_item_data_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_data_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_data_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_data_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_data_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_data_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_data_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_data_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_data_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_data_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_data_proc_ptr'
// For ise
OSStatus  ewg_function_call_data_browser_item_data_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, DataBrowserItemDataRef ewg_itemData, Boolean ewg_setValue)
{
	return call_data_browser_item_data_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (DataBrowserItemDataRef)ewg_itemData, (Boolean)ewg_setValue);
}

// Return address of function 'call_data_browser_item_data_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_data_proc_ptr (void)
{
	return (void*) call_data_browser_item_data_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_compare_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_compare_proc_ptr_stub (void)
{
	return get_data_browser_item_compare_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_compare_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_compare_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_compare_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_compare_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_compare_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_compare_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_compare_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_compare_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_compare_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_compare_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_item_compare_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemOne, DataBrowserItemID ewg_itemTwo, DataBrowserPropertyID ewg_sortProperty)
{
	return call_data_browser_item_compare_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemOne, (DataBrowserItemID)ewg_itemTwo, (DataBrowserPropertyID)ewg_sortProperty);
}

// Return address of function 'call_data_browser_item_compare_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_compare_proc_ptr (void)
{
	return (void*) call_data_browser_item_compare_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_notification_with_item_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_notification_with_item_proc_ptr_stub (void)
{
	return get_data_browser_item_notification_with_item_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_notification_with_item_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_notification_with_item_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_notification_with_item_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_notification_with_item_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_notification_with_item_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_notification_with_item_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_notification_with_item_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_notification_with_item_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_notification_with_item_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_notification_with_item_proc_ptr'
// For ise
void  ewg_function_call_data_browser_item_notification_with_item_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserItemNotification ewg_message, DataBrowserItemDataRef ewg_itemData)
{
	call_data_browser_item_notification_with_item_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserItemNotification)ewg_message, (DataBrowserItemDataRef)ewg_itemData);
}

// Return address of function 'call_data_browser_item_notification_with_item_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_notification_with_item_proc_ptr (void)
{
	return (void*) call_data_browser_item_notification_with_item_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_notification_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_notification_proc_ptr_stub (void)
{
	return get_data_browser_item_notification_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_notification_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_notification_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_notification_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_notification_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_notification_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_notification_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_notification_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_notification_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_notification_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_notification_proc_ptr'
// For ise
void  ewg_function_call_data_browser_item_notification_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserItemNotification ewg_message)
{
	call_data_browser_item_notification_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserItemNotification)ewg_message);
}

// Return address of function 'call_data_browser_item_notification_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_notification_proc_ptr (void)
{
	return (void*) call_data_browser_item_notification_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_add_drag_item_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_add_drag_item_proc_ptr_stub (void)
{
	return get_data_browser_add_drag_item_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_add_drag_item_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_add_drag_item_proc_ptr_stub (void)
{
	return (void*) get_data_browser_add_drag_item_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_add_drag_item_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_add_drag_item_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_add_drag_item_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_add_drag_item_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_add_drag_item_proc_ptr_entry (void)
{
	return (void*) set_data_browser_add_drag_item_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_add_drag_item_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_add_drag_item_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DragReference ewg_theDrag, DataBrowserItemID ewg_item, ItemReference *ewg_itemRef)
{
	return call_data_browser_add_drag_item_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DragReference)ewg_theDrag, (DataBrowserItemID)ewg_item, (ItemReference*)ewg_itemRef);
}

// Return address of function 'call_data_browser_add_drag_item_proc_ptr'
void* ewg_get_function_address_call_data_browser_add_drag_item_proc_ptr (void)
{
	return (void*) call_data_browser_add_drag_item_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_accept_drag_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_accept_drag_proc_ptr_stub (void)
{
	return get_data_browser_accept_drag_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_accept_drag_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_accept_drag_proc_ptr_stub (void)
{
	return (void*) get_data_browser_accept_drag_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_accept_drag_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_accept_drag_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_accept_drag_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_accept_drag_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_accept_drag_proc_ptr_entry (void)
{
	return (void*) set_data_browser_accept_drag_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_accept_drag_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_accept_drag_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DragReference ewg_theDrag, DataBrowserItemID ewg_item)
{
	return call_data_browser_accept_drag_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DragReference)ewg_theDrag, (DataBrowserItemID)ewg_item);
}

// Return address of function 'call_data_browser_accept_drag_proc_ptr'
void* ewg_get_function_address_call_data_browser_accept_drag_proc_ptr (void)
{
	return (void*) call_data_browser_accept_drag_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_post_process_drag_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_post_process_drag_proc_ptr_stub (void)
{
	return get_data_browser_post_process_drag_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_post_process_drag_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_post_process_drag_proc_ptr_stub (void)
{
	return (void*) get_data_browser_post_process_drag_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_post_process_drag_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_post_process_drag_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_post_process_drag_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_post_process_drag_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_post_process_drag_proc_ptr_entry (void)
{
	return (void*) set_data_browser_post_process_drag_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_post_process_drag_proc_ptr'
// For ise
void  ewg_function_call_data_browser_post_process_drag_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DragReference ewg_theDrag, OSStatus ewg_trackDragResult)
{
	call_data_browser_post_process_drag_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DragReference)ewg_theDrag, (OSStatus)ewg_trackDragResult);
}

// Return address of function 'call_data_browser_post_process_drag_proc_ptr'
void* ewg_get_function_address_call_data_browser_post_process_drag_proc_ptr (void)
{
	return (void*) call_data_browser_post_process_drag_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_get_contextual_menu_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_get_contextual_menu_proc_ptr_stub (void)
{
	return get_data_browser_get_contextual_menu_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_get_contextual_menu_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_get_contextual_menu_proc_ptr_stub (void)
{
	return (void*) get_data_browser_get_contextual_menu_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_get_contextual_menu_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_get_contextual_menu_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_get_contextual_menu_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_get_contextual_menu_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_get_contextual_menu_proc_ptr_entry (void)
{
	return (void*) set_data_browser_get_contextual_menu_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_get_contextual_menu_proc_ptr'
// For ise
void  ewg_function_call_data_browser_get_contextual_menu_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, MenuRef *ewg_menu, UInt32 *ewg_helpType, CFStringRef *ewg_helpItemString, AEDesc *ewg_selection)
{
	call_data_browser_get_contextual_menu_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (MenuRef*)ewg_menu, (UInt32*)ewg_helpType, (CFStringRef*)ewg_helpItemString, (AEDesc*)ewg_selection);
}

// Return address of function 'call_data_browser_get_contextual_menu_proc_ptr'
void* ewg_get_function_address_call_data_browser_get_contextual_menu_proc_ptr (void)
{
	return (void*) call_data_browser_get_contextual_menu_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_select_contextual_menu_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_select_contextual_menu_proc_ptr_stub (void)
{
	return get_data_browser_select_contextual_menu_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_select_contextual_menu_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_select_contextual_menu_proc_ptr_stub (void)
{
	return (void*) get_data_browser_select_contextual_menu_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_select_contextual_menu_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_select_contextual_menu_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_select_contextual_menu_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_select_contextual_menu_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_select_contextual_menu_proc_ptr_entry (void)
{
	return (void*) set_data_browser_select_contextual_menu_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_select_contextual_menu_proc_ptr'
// For ise
void  ewg_function_call_data_browser_select_contextual_menu_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, MenuRef ewg_menu, UInt32 ewg_selectionType, SInt16 ewg_menuID, MenuItemIndex ewg_menuItem)
{
	call_data_browser_select_contextual_menu_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (MenuRef)ewg_menu, (UInt32)ewg_selectionType, (SInt16)ewg_menuID, (MenuItemIndex)ewg_menuItem);
}

// Return address of function 'call_data_browser_select_contextual_menu_proc_ptr'
void* ewg_get_function_address_call_data_browser_select_contextual_menu_proc_ptr (void)
{
	return (void*) call_data_browser_select_contextual_menu_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_help_content_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_help_content_proc_ptr_stub (void)
{
	return get_data_browser_item_help_content_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_help_content_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_help_content_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_help_content_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_help_content_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_help_content_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_help_content_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_help_content_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_help_content_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_help_content_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_help_content_proc_ptr'
// For ise
void  ewg_function_call_data_browser_item_help_content_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, HMContentRequest ewg_inRequest, HMContentProvidedType *ewg_outContentProvided, HMHelpContentPtr ewg_ioHelpContent)
{
	call_data_browser_item_help_content_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (HMContentRequest)ewg_inRequest, (HMContentProvidedType*)ewg_outContentProvided, (HMHelpContentPtr)ewg_ioHelpContent);
}

// Return address of function 'call_data_browser_item_help_content_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_help_content_proc_ptr (void)
{
	return (void*) call_data_browser_item_help_content_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_draw_item_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_draw_item_proc_ptr_stub (void)
{
	return get_data_browser_draw_item_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_draw_item_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_draw_item_proc_ptr_stub (void)
{
	return (void*) get_data_browser_draw_item_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_draw_item_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_draw_item_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_draw_item_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_draw_item_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_draw_item_proc_ptr_entry (void)
{
	return (void*) set_data_browser_draw_item_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_draw_item_proc_ptr'
// For ise
void  ewg_function_call_data_browser_draw_item_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, DataBrowserItemState ewg_itemState, Rect const *ewg_theRect, SInt16 ewg_gdDepth, Boolean ewg_colorDevice)
{
	call_data_browser_draw_item_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (DataBrowserItemState)ewg_itemState, (Rect const*)ewg_theRect, (SInt16)ewg_gdDepth, (Boolean)ewg_colorDevice);
}

// Return address of function 'call_data_browser_draw_item_proc_ptr'
void* ewg_get_function_address_call_data_browser_draw_item_proc_ptr (void)
{
	return (void*) call_data_browser_draw_item_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_edit_item_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_edit_item_proc_ptr_stub (void)
{
	return get_data_browser_edit_item_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_edit_item_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_edit_item_proc_ptr_stub (void)
{
	return (void*) get_data_browser_edit_item_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_edit_item_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_edit_item_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_edit_item_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_edit_item_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_edit_item_proc_ptr_entry (void)
{
	return (void*) set_data_browser_edit_item_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_edit_item_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_edit_item_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_item, DataBrowserPropertyID ewg_property, CFStringRef ewg_theString, Rect *ewg_maxEditTextRect, Boolean *ewg_shrinkToFit)
{
	return call_data_browser_edit_item_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_item, (DataBrowserPropertyID)ewg_property, (CFStringRef)ewg_theString, (Rect*)ewg_maxEditTextRect, (Boolean*)ewg_shrinkToFit);
}

// Return address of function 'call_data_browser_edit_item_proc_ptr'
void* ewg_get_function_address_call_data_browser_edit_item_proc_ptr (void)
{
	return (void*) call_data_browser_edit_item_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_hit_test_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_hit_test_proc_ptr_stub (void)
{
	return get_data_browser_hit_test_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_hit_test_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_hit_test_proc_ptr_stub (void)
{
	return (void*) get_data_browser_hit_test_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_hit_test_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_hit_test_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_hit_test_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_hit_test_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_hit_test_proc_ptr_entry (void)
{
	return (void*) set_data_browser_hit_test_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_hit_test_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_hit_test_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, Rect const *ewg_mouseRect)
{
	return call_data_browser_hit_test_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (Rect const*)ewg_mouseRect);
}

// Return address of function 'call_data_browser_hit_test_proc_ptr'
void* ewg_get_function_address_call_data_browser_hit_test_proc_ptr (void)
{
	return (void*) call_data_browser_hit_test_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_tracking_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_tracking_proc_ptr_stub (void)
{
	return get_data_browser_tracking_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_tracking_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_tracking_proc_ptr_stub (void)
{
	return (void*) get_data_browser_tracking_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_tracking_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_tracking_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_tracking_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_tracking_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_tracking_proc_ptr_entry (void)
{
	return (void*) set_data_browser_tracking_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_tracking_proc_ptr'
// For ise
DataBrowserTrackingResult  ewg_function_call_data_browser_tracking_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, Point *ewg_startPt, EventModifiers ewg_modifiers)
{
	return call_data_browser_tracking_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, *(Point*)ewg_startPt, (EventModifiers)ewg_modifiers);
}

// Return address of function 'call_data_browser_tracking_proc_ptr'
void* ewg_get_function_address_call_data_browser_tracking_proc_ptr (void)
{
	return (void*) call_data_browser_tracking_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_drag_rgn_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_drag_rgn_proc_ptr_stub (void)
{
	return get_data_browser_item_drag_rgn_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_drag_rgn_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_drag_rgn_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_drag_rgn_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_drag_rgn_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_drag_rgn_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_drag_rgn_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_drag_rgn_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_drag_rgn_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_drag_rgn_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_drag_rgn_proc_ptr'
// For ise
void  ewg_function_call_data_browser_item_drag_rgn_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, RgnHandle ewg_dragRgn)
{
	call_data_browser_item_drag_rgn_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (RgnHandle)ewg_dragRgn);
}

// Return address of function 'call_data_browser_item_drag_rgn_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_drag_rgn_proc_ptr (void)
{
	return (void*) call_data_browser_item_drag_rgn_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_accept_drag_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_accept_drag_proc_ptr_stub (void)
{
	return get_data_browser_item_accept_drag_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_accept_drag_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_accept_drag_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_accept_drag_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_accept_drag_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_accept_drag_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_accept_drag_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_accept_drag_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_accept_drag_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_accept_drag_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_accept_drag_proc_ptr'
// For ise
DataBrowserDragFlags  ewg_function_call_data_browser_item_accept_drag_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, Rect const *ewg_theRect, DragReference ewg_theDrag)
{
	return call_data_browser_item_accept_drag_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (Rect const*)ewg_theRect, (DragReference)ewg_theDrag);
}

// Return address of function 'call_data_browser_item_accept_drag_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_accept_drag_proc_ptr (void)
{
	return (void*) call_data_browser_item_accept_drag_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_data_browser_item_receive_drag_proc_ptr_stub'
// For ise
void * ewg_function_get_data_browser_item_receive_drag_proc_ptr_stub (void)
{
	return get_data_browser_item_receive_drag_proc_ptr_stub ();
}

// Return address of function 'get_data_browser_item_receive_drag_proc_ptr_stub'
void* ewg_get_function_address_get_data_browser_item_receive_drag_proc_ptr_stub (void)
{
	return (void*) get_data_browser_item_receive_drag_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_data_browser_item_receive_drag_proc_ptr_entry'
// For ise
void  ewg_function_set_data_browser_item_receive_drag_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_data_browser_item_receive_drag_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_data_browser_item_receive_drag_proc_ptr_entry'
void* ewg_get_function_address_set_data_browser_item_receive_drag_proc_ptr_entry (void)
{
	return (void*) set_data_browser_item_receive_drag_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_data_browser_item_receive_drag_proc_ptr'
// For ise
Boolean  ewg_function_call_data_browser_item_receive_drag_proc_ptr (void *ewg_a_function, ControlRef ewg_browser, DataBrowserItemID ewg_itemID, DataBrowserPropertyID ewg_property, DataBrowserDragFlags ewg_dragFlags, DragReference ewg_theDrag)
{
	return call_data_browser_item_receive_drag_proc_ptr ((void*)ewg_a_function, (ControlRef)ewg_browser, (DataBrowserItemID)ewg_itemID, (DataBrowserPropertyID)ewg_property, (DataBrowserDragFlags)ewg_dragFlags, (DragReference)ewg_theDrag);
}

// Return address of function 'call_data_browser_item_receive_drag_proc_ptr'
void* ewg_get_function_address_call_data_browser_item_receive_drag_proc_ptr (void)
{
	return (void*) call_data_browser_item_receive_drag_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_edit_unicode_post_update_proc_ptr_stub'
// For ise
void * ewg_function_get_edit_unicode_post_update_proc_ptr_stub (void)
{
	return get_edit_unicode_post_update_proc_ptr_stub ();
}

// Return address of function 'get_edit_unicode_post_update_proc_ptr_stub'
void* ewg_get_function_address_get_edit_unicode_post_update_proc_ptr_stub (void)
{
	return (void*) get_edit_unicode_post_update_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_edit_unicode_post_update_proc_ptr_entry'
// For ise
void  ewg_function_set_edit_unicode_post_update_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_edit_unicode_post_update_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_edit_unicode_post_update_proc_ptr_entry'
void* ewg_get_function_address_set_edit_unicode_post_update_proc_ptr_entry (void)
{
	return (void*) set_edit_unicode_post_update_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_edit_unicode_post_update_proc_ptr'
// For ise
Boolean  ewg_function_call_edit_unicode_post_update_proc_ptr (void *ewg_a_function, UniCharArrayHandle ewg_uniText, UniCharCount ewg_uniTextLength, UniCharArrayOffset ewg_iStartOffset, UniCharArrayOffset ewg_iEndOffset, void *ewg_refcon)
{
	return call_edit_unicode_post_update_proc_ptr ((void*)ewg_a_function, (UniCharArrayHandle)ewg_uniText, (UniCharCount)ewg_uniTextLength, (UniCharArrayOffset)ewg_iStartOffset, (UniCharArrayOffset)ewg_iEndOffset, (void*)ewg_refcon);
}

// Return address of function 'call_edit_unicode_post_update_proc_ptr'
void* ewg_get_function_address_call_edit_unicode_post_update_proc_ptr (void)
{
	return (void*) call_edit_unicode_post_update_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_nav_event_proc_ptr_stub'
// For ise
void * ewg_function_get_nav_event_proc_ptr_stub (void)
{
	return get_nav_event_proc_ptr_stub ();
}

// Return address of function 'get_nav_event_proc_ptr_stub'
void* ewg_get_function_address_get_nav_event_proc_ptr_stub (void)
{
	return (void*) get_nav_event_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_nav_event_proc_ptr_entry'
// For ise
void  ewg_function_set_nav_event_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_nav_event_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_nav_event_proc_ptr_entry'
void* ewg_get_function_address_set_nav_event_proc_ptr_entry (void)
{
	return (void*) set_nav_event_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_nav_event_proc_ptr'
// For ise
void  ewg_function_call_nav_event_proc_ptr (void *ewg_a_function, NavEventCallbackMessage ewg_callBackSelector, NavCBRecPtr ewg_callBackParms, void *ewg_callBackUD)
{
	call_nav_event_proc_ptr ((void*)ewg_a_function, (NavEventCallbackMessage)ewg_callBackSelector, (NavCBRecPtr)ewg_callBackParms, (void*)ewg_callBackUD);
}

// Return address of function 'call_nav_event_proc_ptr'
void* ewg_get_function_address_call_nav_event_proc_ptr (void)
{
	return (void*) call_nav_event_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_nav_preview_proc_ptr_stub'
// For ise
void * ewg_function_get_nav_preview_proc_ptr_stub (void)
{
	return get_nav_preview_proc_ptr_stub ();
}

// Return address of function 'get_nav_preview_proc_ptr_stub'
void* ewg_get_function_address_get_nav_preview_proc_ptr_stub (void)
{
	return (void*) get_nav_preview_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_nav_preview_proc_ptr_entry'
// For ise
void  ewg_function_set_nav_preview_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_nav_preview_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_nav_preview_proc_ptr_entry'
void* ewg_get_function_address_set_nav_preview_proc_ptr_entry (void)
{
	return (void*) set_nav_preview_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_nav_preview_proc_ptr'
// For ise
Boolean  ewg_function_call_nav_preview_proc_ptr (void *ewg_a_function, NavCBRecPtr ewg_callBackParms, void *ewg_callBackUD)
{
	return call_nav_preview_proc_ptr ((void*)ewg_a_function, (NavCBRecPtr)ewg_callBackParms, (void*)ewg_callBackUD);
}

// Return address of function 'call_nav_preview_proc_ptr'
void* ewg_get_function_address_call_nav_preview_proc_ptr (void)
{
	return (void*) call_nav_preview_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_nav_object_filter_proc_ptr_stub'
// For ise
void * ewg_function_get_nav_object_filter_proc_ptr_stub (void)
{
	return get_nav_object_filter_proc_ptr_stub ();
}

// Return address of function 'get_nav_object_filter_proc_ptr_stub'
void* ewg_get_function_address_get_nav_object_filter_proc_ptr_stub (void)
{
	return (void*) get_nav_object_filter_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_nav_object_filter_proc_ptr_entry'
// For ise
void  ewg_function_set_nav_object_filter_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_nav_object_filter_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_nav_object_filter_proc_ptr_entry'
void* ewg_get_function_address_set_nav_object_filter_proc_ptr_entry (void)
{
	return (void*) set_nav_object_filter_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_nav_object_filter_proc_ptr'
// For ise
Boolean  ewg_function_call_nav_object_filter_proc_ptr (void *ewg_a_function, AEDesc *ewg_theItem, void *ewg_info, void *ewg_callBackUD, NavFilterModes ewg_filterMode)
{
	return call_nav_object_filter_proc_ptr ((void*)ewg_a_function, (AEDesc*)ewg_theItem, (void*)ewg_info, (void*)ewg_callBackUD, (NavFilterModes)ewg_filterMode);
}

// Return address of function 'call_nav_object_filter_proc_ptr'
void* ewg_get_function_address_call_nav_object_filter_proc_ptr (void)
{
	return (void*) call_nav_object_filter_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_color_changed_proc_ptr_stub'
// For ise
void * ewg_function_get_color_changed_proc_ptr_stub (void)
{
	return get_color_changed_proc_ptr_stub ();
}

// Return address of function 'get_color_changed_proc_ptr_stub'
void* ewg_get_function_address_get_color_changed_proc_ptr_stub (void)
{
	return (void*) get_color_changed_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_color_changed_proc_ptr_entry'
// For ise
void  ewg_function_set_color_changed_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_color_changed_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_color_changed_proc_ptr_entry'
void* ewg_get_function_address_set_color_changed_proc_ptr_entry (void)
{
	return (void*) set_color_changed_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_color_changed_proc_ptr'
// For ise
void  ewg_function_call_color_changed_proc_ptr (void *ewg_a_function, long ewg_userData, PMColor *ewg_newColor)
{
	call_color_changed_proc_ptr ((void*)ewg_a_function, (long)ewg_userData, (PMColor*)ewg_newColor);
}

// Return address of function 'call_color_changed_proc_ptr'
void* ewg_get_function_address_call_color_changed_proc_ptr (void)
{
	return (void*) call_color_changed_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_ncolor_changed_proc_ptr_stub'
// For ise
void * ewg_function_get_ncolor_changed_proc_ptr_stub (void)
{
	return get_ncolor_changed_proc_ptr_stub ();
}

// Return address of function 'get_ncolor_changed_proc_ptr_stub'
void* ewg_get_function_address_get_ncolor_changed_proc_ptr_stub (void)
{
	return (void*) get_ncolor_changed_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_ncolor_changed_proc_ptr_entry'
// For ise
void  ewg_function_set_ncolor_changed_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_ncolor_changed_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_ncolor_changed_proc_ptr_entry'
void* ewg_get_function_address_set_ncolor_changed_proc_ptr_entry (void)
{
	return (void*) set_ncolor_changed_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_ncolor_changed_proc_ptr'
// For ise
void  ewg_function_call_ncolor_changed_proc_ptr (void *ewg_a_function, long ewg_userData, NPMColor *ewg_newColor)
{
	call_ncolor_changed_proc_ptr ((void*)ewg_a_function, (long)ewg_userData, (NPMColor*)ewg_newColor);
}

// Return address of function 'call_ncolor_changed_proc_ptr'
void* ewg_get_function_address_call_ncolor_changed_proc_ptr (void)
{
	return (void*) call_ncolor_changed_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_user_event_proc_ptr_stub'
// For ise
void * ewg_function_get_user_event_proc_ptr_stub (void)
{
	return get_user_event_proc_ptr_stub ();
}

// Return address of function 'get_user_event_proc_ptr_stub'
void* ewg_get_function_address_get_user_event_proc_ptr_stub (void)
{
	return (void*) get_user_event_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_user_event_proc_ptr_entry'
// For ise
void  ewg_function_set_user_event_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_user_event_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_user_event_proc_ptr_entry'
void* ewg_get_function_address_set_user_event_proc_ptr_entry (void)
{
	return (void*) set_user_event_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_user_event_proc_ptr'
// For ise
Boolean  ewg_function_call_user_event_proc_ptr (void *ewg_a_function, EventRecord *ewg_event)
{
	return call_user_event_proc_ptr ((void*)ewg_a_function, (EventRecord*)ewg_event);
}

// Return address of function 'call_user_event_proc_ptr'
void* ewg_get_function_address_call_user_event_proc_ptr (void)
{
	return (void*) call_user_event_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfcomparator_function_stub'
// For ise
void * ewg_function_get_cfcomparator_function_stub (void)
{
	return get_cfcomparator_function_stub ();
}

// Return address of function 'get_cfcomparator_function_stub'
void* ewg_get_function_address_get_cfcomparator_function_stub (void)
{
	return (void*) get_cfcomparator_function_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfcomparator_function_entry'
// For ise
void  ewg_function_set_cfcomparator_function_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfcomparator_function_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfcomparator_function_entry'
void* ewg_get_function_address_set_cfcomparator_function_entry (void)
{
	return (void*) set_cfcomparator_function_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfcomparator_function'
// For ise
CFComparisonResult  ewg_function_call_cfcomparator_function (void *ewg_a_function, void const *ewg_val1, void const *ewg_val2, void *ewg_context)
{
	return call_cfcomparator_function ((void*)ewg_a_function, (void const*)ewg_val1, (void const*)ewg_val2, (void*)ewg_context);
}

// Return address of function 'call_cfcomparator_function'
void* ewg_get_function_address_call_cfcomparator_function (void)
{
	return (void*) call_cfcomparator_function;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_retain_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_retain_call_back_stub (void)
{
	return get_cfallocator_retain_call_back_stub ();
}

// Return address of function 'get_cfallocator_retain_call_back_stub'
void* ewg_get_function_address_get_cfallocator_retain_call_back_stub (void)
{
	return (void*) get_cfallocator_retain_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_retain_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_retain_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_retain_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_retain_call_back_entry'
void* ewg_get_function_address_set_cfallocator_retain_call_back_entry (void)
{
	return (void*) set_cfallocator_retain_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_retain_call_back'
// For ise
void const * ewg_function_call_cfallocator_retain_call_back (void *ewg_a_function, void const *ewg_info)
{
	return call_cfallocator_retain_call_back ((void*)ewg_a_function, (void const*)ewg_info);
}

// Return address of function 'call_cfallocator_retain_call_back'
void* ewg_get_function_address_call_cfallocator_retain_call_back (void)
{
	return (void*) call_cfallocator_retain_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_release_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_release_call_back_stub (void)
{
	return get_cfallocator_release_call_back_stub ();
}

// Return address of function 'get_cfallocator_release_call_back_stub'
void* ewg_get_function_address_get_cfallocator_release_call_back_stub (void)
{
	return (void*) get_cfallocator_release_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_release_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_release_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_release_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_release_call_back_entry'
void* ewg_get_function_address_set_cfallocator_release_call_back_entry (void)
{
	return (void*) set_cfallocator_release_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_release_call_back'
// For ise
void  ewg_function_call_cfallocator_release_call_back (void *ewg_a_function, void const *ewg_info)
{
	call_cfallocator_release_call_back ((void*)ewg_a_function, (void const*)ewg_info);
}

// Return address of function 'call_cfallocator_release_call_back'
void* ewg_get_function_address_call_cfallocator_release_call_back (void)
{
	return (void*) call_cfallocator_release_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_copy_description_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_copy_description_call_back_stub (void)
{
	return get_cfallocator_copy_description_call_back_stub ();
}

// Return address of function 'get_cfallocator_copy_description_call_back_stub'
void* ewg_get_function_address_get_cfallocator_copy_description_call_back_stub (void)
{
	return (void*) get_cfallocator_copy_description_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_copy_description_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_copy_description_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_copy_description_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_copy_description_call_back_entry'
void* ewg_get_function_address_set_cfallocator_copy_description_call_back_entry (void)
{
	return (void*) set_cfallocator_copy_description_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_copy_description_call_back'
// For ise
CFStringRef  ewg_function_call_cfallocator_copy_description_call_back (void *ewg_a_function, void const *ewg_info)
{
	return call_cfallocator_copy_description_call_back ((void*)ewg_a_function, (void const*)ewg_info);
}

// Return address of function 'call_cfallocator_copy_description_call_back'
void* ewg_get_function_address_call_cfallocator_copy_description_call_back (void)
{
	return (void*) call_cfallocator_copy_description_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_allocate_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_allocate_call_back_stub (void)
{
	return get_cfallocator_allocate_call_back_stub ();
}

// Return address of function 'get_cfallocator_allocate_call_back_stub'
void* ewg_get_function_address_get_cfallocator_allocate_call_back_stub (void)
{
	return (void*) get_cfallocator_allocate_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_allocate_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_allocate_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_allocate_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_allocate_call_back_entry'
void* ewg_get_function_address_set_cfallocator_allocate_call_back_entry (void)
{
	return (void*) set_cfallocator_allocate_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_allocate_call_back'
// For ise
void * ewg_function_call_cfallocator_allocate_call_back (void *ewg_a_function, CFIndex ewg_allocSize, CFOptionFlags ewg_hint, void *ewg_info)
{
	return call_cfallocator_allocate_call_back ((void*)ewg_a_function, (CFIndex)ewg_allocSize, (CFOptionFlags)ewg_hint, (void*)ewg_info);
}

// Return address of function 'call_cfallocator_allocate_call_back'
void* ewg_get_function_address_call_cfallocator_allocate_call_back (void)
{
	return (void*) call_cfallocator_allocate_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_reallocate_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_reallocate_call_back_stub (void)
{
	return get_cfallocator_reallocate_call_back_stub ();
}

// Return address of function 'get_cfallocator_reallocate_call_back_stub'
void* ewg_get_function_address_get_cfallocator_reallocate_call_back_stub (void)
{
	return (void*) get_cfallocator_reallocate_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_reallocate_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_reallocate_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_reallocate_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_reallocate_call_back_entry'
void* ewg_get_function_address_set_cfallocator_reallocate_call_back_entry (void)
{
	return (void*) set_cfallocator_reallocate_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_reallocate_call_back'
// For ise
void * ewg_function_call_cfallocator_reallocate_call_back (void *ewg_a_function, void *ewg_ptr, CFIndex ewg_newsize, CFOptionFlags ewg_hint, void *ewg_info)
{
	return call_cfallocator_reallocate_call_back ((void*)ewg_a_function, (void*)ewg_ptr, (CFIndex)ewg_newsize, (CFOptionFlags)ewg_hint, (void*)ewg_info);
}

// Return address of function 'call_cfallocator_reallocate_call_back'
void* ewg_get_function_address_call_cfallocator_reallocate_call_back (void)
{
	return (void*) call_cfallocator_reallocate_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_deallocate_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_deallocate_call_back_stub (void)
{
	return get_cfallocator_deallocate_call_back_stub ();
}

// Return address of function 'get_cfallocator_deallocate_call_back_stub'
void* ewg_get_function_address_get_cfallocator_deallocate_call_back_stub (void)
{
	return (void*) get_cfallocator_deallocate_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_deallocate_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_deallocate_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_deallocate_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_deallocate_call_back_entry'
void* ewg_get_function_address_set_cfallocator_deallocate_call_back_entry (void)
{
	return (void*) set_cfallocator_deallocate_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_deallocate_call_back'
// For ise
void  ewg_function_call_cfallocator_deallocate_call_back (void *ewg_a_function, void *ewg_ptr, void *ewg_info)
{
	call_cfallocator_deallocate_call_back ((void*)ewg_a_function, (void*)ewg_ptr, (void*)ewg_info);
}

// Return address of function 'call_cfallocator_deallocate_call_back'
void* ewg_get_function_address_call_cfallocator_deallocate_call_back (void)
{
	return (void*) call_cfallocator_deallocate_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfallocator_preferred_size_call_back_stub'
// For ise
void * ewg_function_get_cfallocator_preferred_size_call_back_stub (void)
{
	return get_cfallocator_preferred_size_call_back_stub ();
}

// Return address of function 'get_cfallocator_preferred_size_call_back_stub'
void* ewg_get_function_address_get_cfallocator_preferred_size_call_back_stub (void)
{
	return (void*) get_cfallocator_preferred_size_call_back_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfallocator_preferred_size_call_back_entry'
// For ise
void  ewg_function_set_cfallocator_preferred_size_call_back_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfallocator_preferred_size_call_back_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfallocator_preferred_size_call_back_entry'
void* ewg_get_function_address_set_cfallocator_preferred_size_call_back_entry (void)
{
	return (void*) set_cfallocator_preferred_size_call_back_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfallocator_preferred_size_call_back'
// For ise
CFIndex  ewg_function_call_cfallocator_preferred_size_call_back (void *ewg_a_function, CFIndex ewg_size, CFOptionFlags ewg_hint, void *ewg_info)
{
	return call_cfallocator_preferred_size_call_back ((void*)ewg_a_function, (CFIndex)ewg_size, (CFOptionFlags)ewg_hint, (void*)ewg_info);
}

// Return address of function 'call_cfallocator_preferred_size_call_back'
void* ewg_get_function_address_call_cfallocator_preferred_size_call_back (void)
{
	return (void*) call_cfallocator_preferred_size_call_back;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_get_bytes_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_get_bytes_callback_stub (void)
{
	return get_cgdata_provider_get_bytes_callback_stub ();
}

// Return address of function 'get_cgdata_provider_get_bytes_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_get_bytes_callback_stub (void)
{
	return (void*) get_cgdata_provider_get_bytes_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_get_bytes_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_get_bytes_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_get_bytes_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_get_bytes_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_get_bytes_callback_entry (void)
{
	return (void*) set_cgdata_provider_get_bytes_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_get_bytes_callback'
// For ise
size_t  ewg_function_call_cgdata_provider_get_bytes_callback (void *ewg_a_function, void *ewg_info, void *ewg_buffer, size_t ewg_count)
{
	return call_cgdata_provider_get_bytes_callback ((void*)ewg_a_function, (void*)ewg_info, (void*)ewg_buffer, (size_t)ewg_count);
}

// Return address of function 'call_cgdata_provider_get_bytes_callback'
void* ewg_get_function_address_call_cgdata_provider_get_bytes_callback (void)
{
	return (void*) call_cgdata_provider_get_bytes_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_skip_bytes_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_skip_bytes_callback_stub (void)
{
	return get_cgdata_provider_skip_bytes_callback_stub ();
}

// Return address of function 'get_cgdata_provider_skip_bytes_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_skip_bytes_callback_stub (void)
{
	return (void*) get_cgdata_provider_skip_bytes_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_skip_bytes_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_skip_bytes_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_skip_bytes_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_skip_bytes_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_skip_bytes_callback_entry (void)
{
	return (void*) set_cgdata_provider_skip_bytes_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_skip_bytes_callback'
// For ise
void  ewg_function_call_cgdata_provider_skip_bytes_callback (void *ewg_a_function, void *ewg_info, size_t ewg_count)
{
	call_cgdata_provider_skip_bytes_callback ((void*)ewg_a_function, (void*)ewg_info, (size_t)ewg_count);
}

// Return address of function 'call_cgdata_provider_skip_bytes_callback'
void* ewg_get_function_address_call_cgdata_provider_skip_bytes_callback (void)
{
	return (void*) call_cgdata_provider_skip_bytes_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_wsclient_context_release_call_back_proc_ptr_stub'
// For ise
void * ewg_function_get_wsclient_context_release_call_back_proc_ptr_stub (void)
{
	return get_wsclient_context_release_call_back_proc_ptr_stub ();
}

// Return address of function 'get_wsclient_context_release_call_back_proc_ptr_stub'
void* ewg_get_function_address_get_wsclient_context_release_call_back_proc_ptr_stub (void)
{
	return (void*) get_wsclient_context_release_call_back_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_wsclient_context_release_call_back_proc_ptr_entry'
// For ise
void  ewg_function_set_wsclient_context_release_call_back_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_wsclient_context_release_call_back_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_wsclient_context_release_call_back_proc_ptr_entry'
void* ewg_get_function_address_set_wsclient_context_release_call_back_proc_ptr_entry (void)
{
	return (void*) set_wsclient_context_release_call_back_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_wsclient_context_release_call_back_proc_ptr'
// For ise
void  ewg_function_call_wsclient_context_release_call_back_proc_ptr (void *ewg_a_function, void *ewg_info)
{
	call_wsclient_context_release_call_back_proc_ptr ((void*)ewg_a_function, (void*)ewg_info);
}

// Return address of function 'call_wsclient_context_release_call_back_proc_ptr'
void* ewg_get_function_address_call_wsclient_context_release_call_back_proc_ptr (void)
{
	return (void*) call_wsclient_context_release_call_back_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_get_byte_pointer_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_get_byte_pointer_callback_stub (void)
{
	return get_cgdata_provider_get_byte_pointer_callback_stub ();
}

// Return address of function 'get_cgdata_provider_get_byte_pointer_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_get_byte_pointer_callback_stub (void)
{
	return (void*) get_cgdata_provider_get_byte_pointer_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_get_byte_pointer_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_get_byte_pointer_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_get_byte_pointer_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_get_byte_pointer_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_get_byte_pointer_callback_entry (void)
{
	return (void*) set_cgdata_provider_get_byte_pointer_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_get_byte_pointer_callback'
// For ise
void const * ewg_function_call_cgdata_provider_get_byte_pointer_callback (void *ewg_a_function, void *ewg_info)
{
	return call_cgdata_provider_get_byte_pointer_callback ((void*)ewg_a_function, (void*)ewg_info);
}

// Return address of function 'call_cgdata_provider_get_byte_pointer_callback'
void* ewg_get_function_address_call_cgdata_provider_get_byte_pointer_callback (void)
{
	return (void*) call_cgdata_provider_get_byte_pointer_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_release_byte_pointer_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_release_byte_pointer_callback_stub (void)
{
	return get_cgdata_provider_release_byte_pointer_callback_stub ();
}

// Return address of function 'get_cgdata_provider_release_byte_pointer_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_release_byte_pointer_callback_stub (void)
{
	return (void*) get_cgdata_provider_release_byte_pointer_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_release_byte_pointer_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_release_byte_pointer_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_release_byte_pointer_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_release_byte_pointer_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_release_byte_pointer_callback_entry (void)
{
	return (void*) set_cgdata_provider_release_byte_pointer_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_release_byte_pointer_callback'
// For ise
void  ewg_function_call_cgdata_provider_release_byte_pointer_callback (void *ewg_a_function, void *ewg_info, void const *ewg_pointer)
{
	call_cgdata_provider_release_byte_pointer_callback ((void*)ewg_a_function, (void*)ewg_info, (void const*)ewg_pointer);
}

// Return address of function 'call_cgdata_provider_release_byte_pointer_callback'
void* ewg_get_function_address_call_cgdata_provider_release_byte_pointer_callback (void)
{
	return (void*) call_cgdata_provider_release_byte_pointer_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cgdata_provider_get_bytes_at_offset_callback_stub'
// For ise
void * ewg_function_get_cgdata_provider_get_bytes_at_offset_callback_stub (void)
{
	return get_cgdata_provider_get_bytes_at_offset_callback_stub ();
}

// Return address of function 'get_cgdata_provider_get_bytes_at_offset_callback_stub'
void* ewg_get_function_address_get_cgdata_provider_get_bytes_at_offset_callback_stub (void)
{
	return (void*) get_cgdata_provider_get_bytes_at_offset_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cgdata_provider_get_bytes_at_offset_callback_entry'
// For ise
void  ewg_function_set_cgdata_provider_get_bytes_at_offset_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cgdata_provider_get_bytes_at_offset_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cgdata_provider_get_bytes_at_offset_callback_entry'
void* ewg_get_function_address_set_cgdata_provider_get_bytes_at_offset_callback_entry (void)
{
	return (void*) set_cgdata_provider_get_bytes_at_offset_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cgdata_provider_get_bytes_at_offset_callback'
// For ise
size_t  ewg_function_call_cgdata_provider_get_bytes_at_offset_callback (void *ewg_a_function, void *ewg_info, void *ewg_buffer, size_t ewg_offset, size_t ewg_count)
{
	return call_cgdata_provider_get_bytes_at_offset_callback ((void*)ewg_a_function, (void*)ewg_info, (void*)ewg_buffer, (size_t)ewg_offset, (size_t)ewg_count);
}

// Return address of function 'call_cgdata_provider_get_bytes_at_offset_callback'
void* ewg_get_function_address_call_cgdata_provider_get_bytes_at_offset_callback (void)
{
	return (void*) call_cgdata_provider_get_bytes_at_offset_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_cfrag_term_procedure_stub'
// For ise
void * ewg_function_get_cfrag_term_procedure_stub (void)
{
	return get_cfrag_term_procedure_stub ();
}

// Return address of function 'get_cfrag_term_procedure_stub'
void* ewg_get_function_address_get_cfrag_term_procedure_stub (void)
{
	return (void*) get_cfrag_term_procedure_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_cfrag_term_procedure_entry'
// For ise
void  ewg_function_set_cfrag_term_procedure_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_cfrag_term_procedure_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_cfrag_term_procedure_entry'
void* ewg_get_function_address_set_cfrag_term_procedure_entry (void)
{
	return (void*) set_cfrag_term_procedure_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_cfrag_term_procedure'
// For ise
void  ewg_function_call_cfrag_term_procedure (void *ewg_a_function)
{
	call_cfrag_term_procedure ((void*)ewg_a_function);
}

// Return address of function 'call_cfrag_term_procedure'
void* ewg_get_function_address_call_cfrag_term_procedure (void)
{
	return (void*) call_cfrag_term_procedure;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_get_next_event_filter_proc_ptr_stub'
// For ise
void * ewg_function_get_get_next_event_filter_proc_ptr_stub (void)
{
	return get_get_next_event_filter_proc_ptr_stub ();
}

// Return address of function 'get_get_next_event_filter_proc_ptr_stub'
void* ewg_get_function_address_get_get_next_event_filter_proc_ptr_stub (void)
{
	return (void*) get_get_next_event_filter_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_get_next_event_filter_proc_ptr_entry'
// For ise
void  ewg_function_set_get_next_event_filter_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_get_next_event_filter_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_get_next_event_filter_proc_ptr_entry'
void* ewg_get_function_address_set_get_next_event_filter_proc_ptr_entry (void)
{
	return (void*) set_get_next_event_filter_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_get_next_event_filter_proc_ptr'
// For ise
void  ewg_function_call_get_next_event_filter_proc_ptr (void *ewg_a_function, EventRecord *ewg_theEvent, Boolean *ewg_result)
{
	call_get_next_event_filter_proc_ptr ((void*)ewg_a_function, (EventRecord*)ewg_theEvent, (Boolean*)ewg_result);
}

// Return address of function 'call_get_next_event_filter_proc_ptr'
void* ewg_get_function_address_call_get_next_event_filter_proc_ptr (void)
{
	return (void*) call_get_next_event_filter_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_menu_bar_def_proc_ptr_stub'
// For ise
void * ewg_function_get_menu_bar_def_proc_ptr_stub (void)
{
	return get_menu_bar_def_proc_ptr_stub ();
}

// Return address of function 'get_menu_bar_def_proc_ptr_stub'
void* ewg_get_function_address_get_menu_bar_def_proc_ptr_stub (void)
{
	return (void*) get_menu_bar_def_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_menu_bar_def_proc_ptr_entry'
// For ise
void  ewg_function_set_menu_bar_def_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_menu_bar_def_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_menu_bar_def_proc_ptr_entry'
void* ewg_get_function_address_set_menu_bar_def_proc_ptr_entry (void)
{
	return (void*) set_menu_bar_def_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_menu_bar_def_proc_ptr'
// For ise
long  ewg_function_call_menu_bar_def_proc_ptr (void *ewg_a_function, short ewg_selector, short ewg_message, short ewg_parameter1, long ewg_parameter2)
{
	return call_menu_bar_def_proc_ptr ((void*)ewg_a_function, (short)ewg_selector, (short)ewg_message, (short)ewg_parameter1, (long)ewg_parameter2);
}

// Return address of function 'call_menu_bar_def_proc_ptr'
void* ewg_get_function_address_call_menu_bar_def_proc_ptr (void)
{
	return (void*) call_menu_bar_def_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_mbar_hook_proc_ptr_stub'
// For ise
void * ewg_function_get_mbar_hook_proc_ptr_stub (void)
{
	return get_mbar_hook_proc_ptr_stub ();
}

// Return address of function 'get_mbar_hook_proc_ptr_stub'
void* ewg_get_function_address_get_mbar_hook_proc_ptr_stub (void)
{
	return (void*) get_mbar_hook_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_mbar_hook_proc_ptr_entry'
// For ise
void  ewg_function_set_mbar_hook_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_mbar_hook_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_mbar_hook_proc_ptr_entry'
void* ewg_get_function_address_set_mbar_hook_proc_ptr_entry (void)
{
	return (void*) set_mbar_hook_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_mbar_hook_proc_ptr'
// For ise
short  ewg_function_call_mbar_hook_proc_ptr (void *ewg_a_function, Rect *ewg_menuRect)
{
	return call_mbar_hook_proc_ptr ((void*)ewg_a_function, (Rect*)ewg_menuRect);
}

// Return address of function 'call_mbar_hook_proc_ptr'
void* ewg_get_function_address_call_mbar_hook_proc_ptr (void)
{
	return (void*) call_mbar_hook_proc_ptr;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub'
// For ise
void * ewg_function_get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub (void)
{
	return get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub ();
}

// Return address of function 'get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub'
void* ewg_get_function_address_get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub (void)
{
	return (void*) get_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry'
// For ise
void  ewg_function_set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry'
void* ewg_get_function_address_set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry (void)
{
	return (void*) set_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback'
// For ise
SInt32  ewg_function_call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback (void *ewg_a_function, void *ewg_thisPointer, CFUUIDBytes *ewg_iid, void **ewg_ppv)
{
	return call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback ((void*)ewg_a_function, (void*)ewg_thisPointer, *(CFUUIDBytes*)ewg_iid, (void**)ewg_ppv);
}

// Return address of function 'call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback'
void* ewg_get_function_address_call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback (void)
{
	return (void*) call_sint32_voidp_cfuuidbytes_voidpp_anonymous_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_uint32_voidp_anonymous_callback_stub'
// For ise
void * ewg_function_get_uint32_voidp_anonymous_callback_stub (void)
{
	return get_uint32_voidp_anonymous_callback_stub ();
}

// Return address of function 'get_uint32_voidp_anonymous_callback_stub'
void* ewg_get_function_address_get_uint32_voidp_anonymous_callback_stub (void)
{
	return (void*) get_uint32_voidp_anonymous_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_uint32_voidp_anonymous_callback_entry'
// For ise
void  ewg_function_set_uint32_voidp_anonymous_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_uint32_voidp_anonymous_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_uint32_voidp_anonymous_callback_entry'
void* ewg_get_function_address_set_uint32_voidp_anonymous_callback_entry (void)
{
	return (void*) set_uint32_voidp_anonymous_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_uint32_voidp_anonymous_callback'
// For ise
UInt32  ewg_function_call_uint32_voidp_anonymous_callback (void *ewg_a_function, void *ewg_thisPointer)
{
	return call_uint32_voidp_anonymous_callback ((void*)ewg_a_function, (void*)ewg_thisPointer);
}

// Return address of function 'call_uint32_voidp_anonymous_callback'
void* ewg_get_function_address_call_uint32_voidp_anonymous_callback (void)
{
	return (void*) call_uint32_voidp_anonymous_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub'
// For ise
void * ewg_function_get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub (void)
{
	return get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub ();
}

// Return address of function 'get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub'
void* ewg_get_function_address_get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub (void)
{
	return (void*) get_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry'
// For ise
void  ewg_function_set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry'
void* ewg_get_function_address_set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry (void)
{
	return (void*) set_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback'
// For ise
OSStatus  ewg_function_call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback (void *ewg_a_function, void *ewg_thisInstance, AEDesc const *ewg_inContext, AEDescList *ewg_outCommandPairs)
{
	return call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback ((void*)ewg_a_function, (void*)ewg_thisInstance, (AEDesc const*)ewg_inContext, (AEDescList*)ewg_outCommandPairs);
}

// Return address of function 'call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback'
void* ewg_get_function_address_call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback (void)
{
	return (void*) call_osstatus_voidp_aedescconstp_aedesclistp_anonymous_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub'
// For ise
void * ewg_function_get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub (void)
{
	return get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub ();
}

// Return address of function 'get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub'
void* ewg_get_function_address_get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub (void)
{
	return (void*) get_osstatus_voidp_aedescp_sint32_anonymous_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry'
// For ise
void  ewg_function_set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry'
void* ewg_get_function_address_set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry (void)
{
	return (void*) set_osstatus_voidp_aedescp_sint32_anonymous_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_osstatus_voidp_aedescp_sint32_anonymous_callback'
// For ise
OSStatus  ewg_function_call_osstatus_voidp_aedescp_sint32_anonymous_callback (void *ewg_a_function, void *ewg_thisInstance, AEDesc *ewg_inContext, SInt32 ewg_inCommandID)
{
	return call_osstatus_voidp_aedescp_sint32_anonymous_callback ((void*)ewg_a_function, (void*)ewg_thisInstance, (AEDesc*)ewg_inContext, (SInt32)ewg_inCommandID);
}

// Return address of function 'call_osstatus_voidp_aedescp_sint32_anonymous_callback'
void* ewg_get_function_address_call_osstatus_voidp_aedescp_sint32_anonymous_callback (void)
{
	return (void*) call_osstatus_voidp_aedescp_sint32_anonymous_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_void_voidp_anonymous_callback_stub'
// For ise
void * ewg_function_get_void_voidp_anonymous_callback_stub (void)
{
	return get_void_voidp_anonymous_callback_stub ();
}

// Return address of function 'get_void_voidp_anonymous_callback_stub'
void* ewg_get_function_address_get_void_voidp_anonymous_callback_stub (void)
{
	return (void*) get_void_voidp_anonymous_callback_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_void_voidp_anonymous_callback_entry'
// For ise
void  ewg_function_set_void_voidp_anonymous_callback_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_void_voidp_anonymous_callback_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_void_voidp_anonymous_callback_entry'
void* ewg_get_function_address_set_void_voidp_anonymous_callback_entry (void)
{
	return (void*) set_void_voidp_anonymous_callback_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_void_voidp_anonymous_callback'
// For ise
void  ewg_function_call_void_voidp_anonymous_callback (void *ewg_a_function, void *ewg_thisInstance)
{
	call_void_voidp_anonymous_callback ((void*)ewg_a_function, (void*)ewg_thisInstance);
}

// Return address of function 'call_void_voidp_anonymous_callback'
void* ewg_get_function_address_call_void_voidp_anonymous_callback (void)
{
	return (void*) call_void_voidp_anonymous_callback;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'get_desk_hook_proc_ptr_stub'
// For ise
void * ewg_function_get_desk_hook_proc_ptr_stub (void)
{
	return get_desk_hook_proc_ptr_stub ();
}

// Return address of function 'get_desk_hook_proc_ptr_stub'
void* ewg_get_function_address_get_desk_hook_proc_ptr_stub (void)
{
	return (void*) get_desk_hook_proc_ptr_stub;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'set_desk_hook_proc_ptr_entry'
// For ise
void  ewg_function_set_desk_hook_proc_ptr_entry (void *ewg_a_class, void *ewg_a_feature)
{
	set_desk_hook_proc_ptr_entry ((void*)ewg_a_class, (void*)ewg_a_feature);
}

// Return address of function 'set_desk_hook_proc_ptr_entry'
void* ewg_get_function_address_set_desk_hook_proc_ptr_entry (void)
{
	return (void*) set_desk_hook_proc_ptr_entry;
}

#include <ewg_carbon_callback_c_glue_code.h>

// Wraps call to function 'call_desk_hook_proc_ptr'
// For ise
void  ewg_function_call_desk_hook_proc_ptr (void *ewg_a_function, Boolean ewg_mouseClick, EventRecord *ewg_theEvent)
{
	call_desk_hook_proc_ptr ((void*)ewg_a_function, (Boolean)ewg_mouseClick, (EventRecord*)ewg_theEvent);
}

// Return address of function 'call_desk_hook_proc_ptr'
void* ewg_get_function_address_call_desk_hook_proc_ptr (void)
{
	return (void*) call_desk_hook_proc_ptr;
}

