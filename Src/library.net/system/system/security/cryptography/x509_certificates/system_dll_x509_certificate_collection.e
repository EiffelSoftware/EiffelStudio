indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.X509Certificates.X509CertificateCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_X509_CERTIFICATE_COLLECTION

inherit
	COLLECTION_BASE
		redefine
			get_hash_code
		end
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_x509_certificate_collection_2,
	make_system_dll_x509_certificate_collection,
	make_system_dll_x509_certificate_collection_1

feature {NONE} -- Initialization

	frozen make_system_dll_x509_certificate_collection_2 (value: NATIVE_ARRAY [X509_CERTIFICATE]) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate[]) use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

	frozen make_system_dll_x509_certificate_collection is
		external
			"IL creator use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

	frozen make_system_dll_x509_certificate_collection_1 (value: SYSTEM_DLL_X509_CERTIFICATE_COLLECTION) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509CertificateCollection) use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): X509_CERTIFICATE is
		external
			"IL signature (System.Int32): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: X509_CERTIFICATE) is
		external
			"IL signature (System.Int32, System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: X509_CERTIFICATE) is
		external
			"IL signature (System.Int32, System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Insert"
		end

	frozen add_range_array_x509_certificate (value: NATIVE_ARRAY [X509_CERTIFICATE]) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate[]): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"AddRange"
		end

	frozen copy_to (array: NATIVE_ARRAY [X509_CERTIFICATE]; index: INTEGER) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate[], System.Int32): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: X509_CERTIFICATE): INTEGER is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: X509_CERTIFICATE) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Remove"
		end

	frozen contains (value: X509_CERTIFICATE): BOOLEAN is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Boolean use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_X509_CERTIFICATE_COLLECTION) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509CertificateCollection): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"AddRange"
		end

	frozen add (value: X509_CERTIFICATE): INTEGER is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Add"
		end

	frozen get_enumerator_x509_certificate_enumerator: SYSTEM_DLL_X509_CERTIFICATE_ENUMERATOR_IN_SYSTEM_DLL_X509_CERTIFICATE_COLLECTION is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_DLL_X509_CERTIFICATE_COLLECTION
