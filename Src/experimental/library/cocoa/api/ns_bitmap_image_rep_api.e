note
	description: "Summary description for {NS_BITMAP_IMAGE_REP_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_BITMAP_IMAGE_REP_API

feature -- Creating an NSBitmapImageRep Object

	frozen image_reps_with_data (a_data: POINTER): POINTER
			-- + (NSArray *)imageRepsWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep imageRepsWithData: $a_data];"
		end

	frozen image_rep_with_data (a_data: POINTER): POINTER
			-- + (id)imageRepWithData: (NSData *) data
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep imageRepWithData: $a_data];"
		end

feature -- Getting Information About the Image

feature -- Getting Image Data

feature -- Producing Representations of the Image

	frozen tiff_representation_of_image_reps_in_array (a_array: POINTER): POINTER
			-- + (NSData *)TIFFRepresentationOfImageRepsInArray: (NSArray *) array
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: $a_array];"
		end

	frozen tiff_representation_of_image_reps_in_array_using_compression_factor (a_array: POINTER; a_comp: POINTER; a_factor: REAL): POINTER
			-- + (NSData *)TIFFRepresentationOfImageRepsInArray: (NSArray *) array usingCompression: (NSArray *) comp factor: (NSArray *) factor
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep TIFFRepresentationOfImageRepsInArray: $a_array usingCompression: *(NSTIFFCompression*)$a_comp factor: $a_factor];"
		end

	frozen representation_of_image_reps_in_array_using_type_properties (a_image_reps: POINTER; a_storage_type: POINTER; a_properties: POINTER): POINTER
			-- + (NSData *)representationOfImageRepsInArray: (NSArray *) imageReps usingType: (NSArray *) storageType properties: (NSArray *) properties
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep representationOfImageRepsInArray: $a_image_reps usingType: *(NSBitmapImageFileType*)$a_storage_type properties: $a_properties];"
		end

feature -- Mananging Compression Types

	frozen get_tiff_compression_types_count (a_list: POINTER; a_num_types: POINTER)
			-- + (void)getTIFFCompressionTypes: (const NSTIFFCompression **) list count: (const NSTIFFCompression **) numTypes
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSBitmapImageRep getTIFFCompressionTypes: $a_list count: $a_num_types];"
		end

	frozen localized_name_for_tiff_compression_type (a_compression: POINTER): POINTER
			-- + (NSString *)localizedNameForTIFFCompressionType: (NSTIFFCompression) compression
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSBitmapImageRep localizedNameForTIFFCompressionType: *(NSTIFFCompression*)$a_compression];"
		end

feature -- Loading Image Incrementally

feature -- Managing Pixel Values

feature -- Getting a Core Graphics Image


end
