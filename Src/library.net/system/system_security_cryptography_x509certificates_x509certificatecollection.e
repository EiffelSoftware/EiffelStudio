indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.X509Certificates.X509CertificateCollection"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as ilist_insert,
			index_of as ilist_index_of,
			remove as ilist_remove,
			extend as ilist_extend,
			has as ilist_has,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
		redefine
			get_hash_code
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end

create
	make_x509certificatecollection_2,
	make_x509certificatecollection,
	make_x509certificatecollection_1

feature {NONE} -- Initialization

	frozen make_x509certificatecollection_2 (value: ARRAY [SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE]) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate[]) use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

	frozen make_x509certificatecollection is
		external
			"IL creator use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

	frozen make_x509certificatecollection_1 (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509CertificateCollection) use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (System.Int32): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL signature (System.Int32, System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL signature (System.Int32, System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Insert"
		end

	frozen add_range_array_x509_certificate (value: ARRAY [SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE]) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate[]): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"AddRange"
		end

	frozen copy_to (array: ARRAY [SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE]; index: INTEGER) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate[], System.Int32): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE): INTEGER is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Remove"
		end

	frozen has (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE): BOOLEAN is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Boolean use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION) is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509CertificateCollection): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"AddRange"
		end

	frozen extend (value: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE): INTEGER is
		external
			"IL signature (System.Security.Cryptography.X509Certificates.X509Certificate): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection"
		alias
			"Add"
		end

	frozen get_enumerator_x509_certificate_enumerator: X509CERTIFICATEENUMERATOR_IN_SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION is
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

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION
