indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.PassportIdentity"

frozen external class
	SYSTEM_WEB_SECURITY_PASSPORTIDENTITY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_PRINCIPAL_IIDENTITY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Security.PassportIdentity"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Web.Security.PassportIdentity"
		alias
			"get_Name"
		end

	frozen get_has_saved_password: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"get_HasSavedPassword"
		end

	frozen get_error: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"get_Error"
		end

	frozen get_is_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"get_IsAuthenticated"
		end

	frozen get_get_from_network_server: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"get_GetFromNetworkServer"
		end

	frozen get_item (str_profile_name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"get_Item"
		end

	frozen get_authentication_type: STRING is
		external
			"IL signature (): System.String use System.Web.Security.PassportIdentity"
		alias
			"get_AuthenticationType"
		end

	frozen get_time_since_sign_in: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"get_TimeSinceSignIn"
		end

	frozen get_ticket_age: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"get_TicketAge"
		end

	frozen get_has_ticket: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"get_HasTicket"
		end

feature -- Basic Operations

	frozen logo_tag2_string_int32_int32 (str_return_url: STRING; i_time_window: INTEGER; i_force_login: INTEGER; str_co_branded_args: STRING; i_lang_id: INTEGER; i_secure: INTEGER; str_name_space: STRING; i_kpp: INTEGER; i_use_secure_auth: INTEGER): STRING is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32, System.String, System.Int32, System.Int32): System.String use System.Web.Security.PassportIdentity"
		alias
			"LogoTag2"
		end

	frozen login_user: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"LoginUser"
		end

	frozen has_flag (i_flag_mask: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"HasFlag"
		end

	frozen decompress (str_data: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"Decompress"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"Equals"
		end

	frozen login_user_string_int32_boolean (sz_ret_url: STRING; i_time_window: INTEGER; f_force_login: BOOLEAN; sz_cobrand_args: STRING; i_lang_id: INTEGER; str_name_space: STRING; i_kpp: INTEGER; f_use_secure_auth: BOOLEAN; o_extra_params: ANY): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Boolean, System.String, System.Int32, System.String, System.Int32, System.Boolean, System.Object): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"LoginUser"
		end

	frozen logo_tag2: STRING is
		external
			"IL signature (): System.String use System.Web.Security.PassportIdentity"
		alias
			"LogoTag2"
		end

	frozen have_consent (b_need_full_consent: BOOLEAN; b_need_birthdate: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Boolean, System.Boolean): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"HaveConsent"
		end

	frozen sign_out (str_sign_out_dot_gif_file_name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Web.Security.PassportIdentity"
		alias
			"SignOut"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"GetHashCode"
		end

	frozen auth_url2: STRING is
		external
			"IL signature (): System.String use System.Web.Security.PassportIdentity"
		alias
			"AuthUrl2"
		end

	frozen crypt_put_site (str_site: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"CryptPutSite"
		end

	frozen compress (str_data: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"Compress"
		end

	frozen decrypt (str_data: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"Decrypt"
		end

	frozen auth_url2_string_int32_boolean (str_return_url: STRING; i_time_window: INTEGER; f_force_login: BOOLEAN; str_co_branded_args: STRING; i_lang_id: INTEGER; str_name_space: STRING; i_kpp: INTEGER; b_use_secure_auth: BOOLEAN): STRING is
		external
			"IL signature (System.String, System.Int32, System.Boolean, System.String, System.Int32, System.String, System.Int32, System.Boolean): System.String use System.Web.Security.PassportIdentity"
		alias
			"AuthUrl2"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Security.PassportIdentity"
		alias
			"ToString"
		end

	frozen get_is_authenticated_int32_boolean (i_time_window: INTEGER; b_force_login: BOOLEAN; b_check_secure: BOOLEAN): BOOLEAN is
		external
			"IL signature (System.Int32, System.Boolean, System.Boolean): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"GetIsAuthenticated"
		end

	frozen login_user_string_int32_int32 (sz_ret_url: STRING; i_time_window: INTEGER; f_force_login: INTEGER; sz_cobrand_args: STRING; i_lang_id: INTEGER; str_name_space: STRING; i_kpp: INTEGER; i_use_secure_auth: INTEGER; o_extra_params: ANY): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.String, System.Int32, System.Int32, System.Object): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"LoginUser"
		end

	frozen crypt_put_host (str_host: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Web.Security.PassportIdentity"
		alias
			"CryptPutHost"
		end

	frozen has_profile (str_profile: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"HasProfile"
		end

	frozen get_is_authenticated_int32_int32 (i_time_window: INTEGER; i_force_login: INTEGER; i_check_secure: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"GetIsAuthenticated"
		end

	frozen get_domain_attribute (str_attribute: STRING; i_lcid: INTEGER; str_domain: STRING): STRING is
		external
			"IL signature (System.String, System.Int32, System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"GetDomainAttribute"
		end

	frozen logo_tag2_string_int32_boolean (str_return_url: STRING; i_time_window: INTEGER; f_force_login: BOOLEAN; str_co_branded_args: STRING; i_lang_id: INTEGER; f_secure: BOOLEAN; str_name_space: STRING; i_kpp: INTEGER; b_use_secure_auth: BOOLEAN): STRING is
		external
			"IL signature (System.String, System.Int32, System.Boolean, System.String, System.Int32, System.Boolean, System.String, System.Int32, System.Boolean): System.String use System.Web.Security.PassportIdentity"
		alias
			"LogoTag2"
		end

	frozen get_profile_object (str_profile_name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.Security.PassportIdentity"
		alias
			"GetProfileObject"
		end

	frozen crypt_is_valid: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Web.Security.PassportIdentity"
		alias
			"CryptIsValid"
		end

	frozen get_domain_from_member_name (str_member_name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"GetDomainFromMemberName"
		end

	frozen auth_url2_string_int32_int32 (str_return_url: STRING; i_time_window: INTEGER; i_force_login: INTEGER; str_co_branded_args: STRING; i_lang_id: INTEGER; str_name_space: STRING; i_kpp: INTEGER; i_use_secure_auth: INTEGER): STRING is
		external
			"IL signature (System.String, System.Int32, System.Int32, System.String, System.Int32, System.String, System.Int32, System.Int32): System.String use System.Web.Security.PassportIdentity"
		alias
			"AuthUrl2"
		end

	frozen encrypt (str_data: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Web.Security.PassportIdentity"
		alias
			"Encrypt"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Security.PassportIdentity"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_SECURITY_PASSPORTIDENTITY
